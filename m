From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help creating git alias
Date: Wed, 30 Oct 2013 20:54:42 -0700
Message-ID: <xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	<xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
	<CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 04:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbjMW-0003TR-31
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 04:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab3JaDz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 23:55:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab3JaDzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 23:55:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E08324F5C2;
	Wed, 30 Oct 2013 23:55:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQgIm4EiUgWJEV1/DVIzBuluLuM=; b=wqD2or
	qVSU6a4n+kk3OM2vjFIlPm7Y1U5kLWTmGooI48IYBYQ6+EN93xRk20Sn5Vvz5qsB
	sB/gIHnitHnCS4B9dyBh/yG1z2nEp4ht/Hu8AFCiIRPvRscu2YMhicSLNhVra9n1
	4g2d8OSq7whETVJQLJFCifJ5nspFN12nv5jbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DyG/T4ontleqJnkD1M4MFkQHhYh84py/
	3FjvgmHrpzbBtXDRNKlPzH2ipqUvdduN1/DViRFDZIoWaEMDWwUZhEux7i0csUHt
	USINlazJvuaNg2Fr6+nPkznfwltTEhQFoh5iWAzvirpZ+pFoMoQRTNc7AwcgbD67
	S903YypkF2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC81C4F5C1;
	Wed, 30 Oct 2013 23:55:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93B794F5AE;
	Wed, 30 Oct 2013 23:55:36 -0400 (EDT)
In-Reply-To: <CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
	(Eugene Sajine's message of "Wed, 30 Oct 2013 21:26:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F0F6134-41E0-11E3-9393-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237077>

Eugene Sajine <euguess@gmail.com> writes:

> That was my initial intention, because I would like to be able to pass
> parameters like to git log or git blame correctly without the explicit
> use of $1. Could you please advise about how to make it work with the
> !sh -c ?
>
> Because the same exact (sed 's/@\\S*//') syntax didn't work with "sh -c".

You can make it work if you think step-by-step.  First, this is what
you want to run:

	sh -c 'git log --format="..." "$@" | sed "s/@\S*//"' -

so that "git euguess master..next" would turn into

	sh -c 'git log --format="..." "$@" | sed "s/@\S*//"' - master..next

Now, you want to wrap it into an alias, i.e.

	[alias]
        	euguess = "!sh -c ..."

That ... part is read by our configuration reader, so you need to
quote the double quotes and backslashes with backslash, which would
give you something like:

	[alias]
		euguess = "!sh -c 'git log --format=\"%h %ae %s\" --date=short \"$@\" | sed \"s/@\\S*//\"' -"
