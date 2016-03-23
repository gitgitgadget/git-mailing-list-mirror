From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Wed, 23 Mar 2016 08:21:42 -0700
Message-ID: <xmqqbn65dxtl.fsf@gitster.mtv.corp.google.com>
References: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
	<CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
	<CACsJy8DCk5YintK3PoO1BWdNmsiSLpAcGL4pU7QgNEG6S41CsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Mehul Jain <mehul.jain2029@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:21:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aikbW-0002Un-Co
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 16:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbcCWPVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 11:21:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753113AbcCWPVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 11:21:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 73E934CBB0;
	Wed, 23 Mar 2016 11:21:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WWTx8/xzeRbEKObdoiH94Oo2jFM=; b=GtLJnh
	1sU83ljTlrQJUdUAuAdUCeemne7+DS6/yDeOFAcgqglfgmr6CnYDkanhSaeteSCP
	s+M1rHkiqRKtL550/z6dph4u9oyGs6LWTX0GVz5vApwwda4I1ngAt4wTpuUt7/oR
	Qi684jH54SJILtrdmAH9NaNhtzjTgNICfY6Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dTaoMyqv6eXWgXgH9YpP9RGIijWcjAWO
	OYeT5/VDofavv/5zZDew+sBO0MZvgBVNKgFI12a61MqamFNSRTR3FMufQ0aJnLnF
	Q3YkctluIxEkUjktE0a25Me2Xf8GAvjyOhUGkgBN6L08lwYAksVY8Mpq49ebKo6j
	jKOX+K0iq1o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69CC54CBAE;
	Wed, 23 Mar 2016 11:21:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFD6C4CBAD;
	Wed, 23 Mar 2016 11:21:43 -0400 (EDT)
In-Reply-To: <CACsJy8DCk5YintK3PoO1BWdNmsiSLpAcGL4pU7QgNEG6S41CsQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 23 Mar 2016 17:15:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F35938BA-F10A-11E5-9A64-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289658>

Duy Nguyen <pclouds@gmail.com> writes:

> 1) add --no-index to force git-apply ignore .git, --git (or some other
> name) to apply patches as if running from topdir, add a config key to
> choose default behavior

I think we do have --no-index (which is why I am largely ignoring
the rest of your message as uninformed speculation for now).

See

  http://thread.gmane.org/gmane.comp.version-control.git/288316/focus=288321

I agree it is bad that it silently ignores the path outside the
directory.  When run with --verbose, we should say "Skipped X that
is outside the directory." or something like that, just like we
issue notices when we applied with offset, etc.
