From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Geolocation support
Date: Thu, 12 Feb 2015 12:57:11 -0800
Message-ID: <xmqqd25ergpk.fsf@gitster.dls.corp.google.com>
References: <87mwrncfkh.fsf@ethzero.com>
	<CALkWK0kHEDn4Wt3Y+XUE59_9ZDf504yopMp9QtBUk49Sd+EXbg@mail.gmail.com>
	<CALWbr2w3=DTAMkFtJoLF1_X46fefpEq2WtTb7HGiTiOExFHG3w@mail.gmail.com>
	<7vhahtfuzm.fsf@alter.siamese.dyndns.org> <87h9uwvtm2.fsf@ethzero.com>
	<CAPc5daW5jYAj5z6UMJAQLoWS4L6OH-NSvbGBMd3LO0qCV40a4A@mail.gmail.com>
	<CACBZZX5rgah7Ucek8dicaDeqvjdkR5ybBC5O7PUxE8+KBwrpgA@mail.gmail.com>
	<xmqqlhk6c2zd.fsf@gitster.dls.corp.google.com>
	<87d25ekg65.fsf@ethzero.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>
To: Alessandro Di Marco <dmr@ethzero.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:57:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0p4-0007ly-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbbBLU5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 15:57:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751701AbbBLU5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 15:57:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE15437BFE;
	Thu, 12 Feb 2015 15:57:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8S5R+UYtpykztaRpZ6Xwon8xSeU=; b=qjKDOb
	gpNyitOWdJ8cfsg+EFGCwTElMRy/+voFgzZmjJrIwOe/p89/fKN7pAC2gAWja9Ly
	h/7jS/SbZKD1jVxMdUiOdQLmyhGOTvMR/Qpv4X3kuJG6ebkQsbbsOXqdrltWidOH
	u4X232uMfJKtU6e5pFD9EV7JcmF2UZ/nMDYCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DjuWF6U9mH9VdhGXACdm08oOSIy2qVuS
	JBs17svob6OtSGxiPW6Lp8AsyP5dWMoYCd6uNgLA3K0ahkQJprQZL1fnjL7GUoat
	FvXHZIRpWJ4KwE8b+pfwfge1fpGaLGybsMVEWy4Aslbhb7y5SRfqVj9IJDfC+UKq
	0mQdIeDqelY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D44EC37BFD;
	Thu, 12 Feb 2015 15:57:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4926E37BFC;
	Thu, 12 Feb 2015 15:57:12 -0500 (EST)
In-Reply-To: <87d25ekg65.fsf@ethzero.com> (Alessandro Di Marco's message of
	"Thu, 12 Feb 2015 21:50:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7896A30-B2F9-11E4-AD4D-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263770>

Alessandro Di Marco <dmr@ethzero.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> More importantly, adding non-essential stuff left and right will force
>> third party Git reimplementations to pay attention to them and also
>> will leave room for them to make mistakes when deciding what to
>> propagate, what to drop and what to update when rewriting commits via
>> rebase, cherry-pick, etc.
>
> ??? http://en.wikipedia.org/wiki/Security_through_obscurity
>
> Do you realize that every git I tried so far has happily accepted any
> crufts I sent to it via git push? And that they stored that crufts and
> then returned it on cloning? :-|

Yes, they will all copy the original commits byte-for-byte.
Otherwise they are broken.

But that is not the paragraph you quoted and responded is about.

What *should* happen, either in the original repository or the other
repository you pushed these commits into, when you _rewrite_ such a
commit?  Should all the cruft headers be carried over to the
rewritten commit?  Should all of them be dropped?  Should some be
kept but some be dropped?  Should some be kept under one condition
but not others?  How are you making sure that all Git reimplementations
do the same thing to the random cruft headers?
