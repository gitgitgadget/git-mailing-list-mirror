From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help creating git alias
Date: Wed, 30 Oct 2013 14:02:00 -0700
Message-ID: <xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 22:02:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbcu6-0005HZ-W7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 22:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab3J3VCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 17:02:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab3J3VCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 17:02:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2BD4EEC9;
	Wed, 30 Oct 2013 17:02:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ge52dzpIjoRrHbO5lfIi7GY7dvU=; b=V6ge09
	TH9FHmz+pDmgjmg96WddV2OFLzrw6IdEUJnwbsjtd7lyiVMv+YxapKAq8/4kDlHC
	3/wgm/fNCW82zOFFjfArWnNqUQ25PmVJwDIens9X6yVfsyWFH3G4Psu/iWSrqbob
	/hCpzNdtDGDb8dbh96DuGpHT9refiO00C1vF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PR32d/wQowT1s9GqFDzuIV2IHddCTkZs
	CwxkSqLGD8CGW21xNLzx3UuziHgbMctYQXrk2gNJoeKSIqrCTlnYcT1gAzA3idmd
	DS1mFnMaZiWYXoEG5XWrtBJl0fSxbS7j5vBqqdLq05zMs6h+BlLcyAKCM3IwGUDc
	QNz5/jo4C8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4574EEC8;
	Wed, 30 Oct 2013 17:02:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CB994EEC4;
	Wed, 30 Oct 2013 17:02:01 -0400 (EDT)
In-Reply-To: <CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	(Eugene Sajine's message of "Wed, 30 Oct 2013 16:10:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86FA6DA8-41A6-11E3-AD4E-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237069>

Eugene Sajine <euguess@gmail.com> writes:

> On Wed, Oct 30, 2013 at 3:57 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>> lg=!git log --pretty=format:'%h %ad %ae %s' --date=short | sed 's/@\\S*//g'
>>
>> should work.
>
>
> It did! thanks! I didn't know that "!sh -c" is not needed

"sh -c" is often used when you pass arguments to your scriptlets,
e.g. to allow

	git lg master..next

you would want

	sh -c 'git log ... "$@" | sed ...' -

so that

	git lg master..next

turns into

	sh -c 'git log ... "$@" | sed ...' - master..next

which makes $1="master..next" and fed to "git log".
