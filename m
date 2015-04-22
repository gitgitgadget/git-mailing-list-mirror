From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC/Add documentation for version protocol 2
Date: Wed, 22 Apr 2015 16:30:17 -0700
Message-ID: <xmqqd22vd9me.fsf@gitster.dls.corp.google.com>
References: <1429658342-5295-1-git-send-email-sbeller@google.com>
	<xmqqd22wdl88.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZN9nBrJ_7skrSQ4kor+p=DM8RnSC2bFZ6TX=SxdMdqcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 01:30:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl465-00006J-Ag
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbbDVXaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:30:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933110AbbDVXaT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 19:30:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DF514BD0D;
	Wed, 22 Apr 2015 19:30:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EFgS0Fr3cjUS4VkaRHlKSzwcjmQ=; b=yi+Zjh
	ngIgBGW3Djeeta5tnr3OUkktaGb7BNazXXY989Z80Q03OsEroyfNWTO0RgxQqrOm
	/MLfBIfmn/7FZc+lHRSMOvvFR8BkoirqU4ld05qXtK1EXW1B6rg7tk3UB3onYqV0
	tJlVPUYvfWeaF+idf/BjwP0ZyOj7lIxA/BC1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s0jRiuwvv78x92Ckdc5vhAgEpFdPwc57
	xbWAChf15GVYLm3d89TFjgAtc/xn9imC5r2U2nqNmxz1mTWCZMXAG6LxFgt+JUks
	FWZdcxxVCMrq+slLkJx1WUC/w1Up4PM+NBRTXIdHk5OKh170BIGsgRbZT1mjOEm2
	D0w/SbqpqlA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9481F4BD0C;
	Wed, 22 Apr 2015 19:30:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C1B04BD0B;
	Wed, 22 Apr 2015 19:30:18 -0400 (EDT)
In-Reply-To: <CAGZ79kZN9nBrJ_7skrSQ4kor+p=DM8RnSC2bFZ6TX=SxdMdqcA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 22 Apr 2015 12:43:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 892C3288-E947-11E4-9460-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267669>

Stefan Beller <sbeller@google.com> writes:

>>> +action           = "noop" / "ls-remote" / "fetch" / "push" / "fetch-shallow"
> ...
>> If we are going in this "in-protocol message switches the service"
>> route, we should also support "archive" as one of the actions, no?
>> Yes, I know you named the document "pack-protocol" and "archive"
>> does not give you packs, but "ls-remote" does not transfer pack data,
>> either.
>
> I'll add that. Also I need to incorporate shallow in one way or another.

This level of detail may not matter at this point yet, but it is
unclear to me why you have "fetch-shallow" as a separate thing
(while not having "push-shallow").  The current infrastructure does
already allow fetching into shallow repositories witout needing a
separate action that is different from "fetch" (aka "upload-pack").
I would not be surprised if it were "I can deepn you if you want"
capability, but I do not understand why you are singling out
"shallow" as something that needs such a special treatment.
