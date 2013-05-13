From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 14:52:42 -0700
Message-ID: <7vobcelf85.fsf@alter.siamese.dyndns.org>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
	<1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
	<CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
	<20130511055647.GA3262@iris.ozlabs.ibm.com>
	<20130511061322.GB3394@elie>
	<20130511094119.GA6196@iris.ozlabs.ibm.com>
	<CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
	<20130513185551.GB3657@google.com>
	<CAAhxitGFhVa6+8x_rgNz5dgyr6m4S11fVU2eJNnMuWimGiM8aQ@mail.gmail.com>
	<20130513193320.GC3657@google.com>
	<CACPiFC+Ummjj4d7OiZwEW+Xm_uRNU1hre3_6UDKUBTepm7EmqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Martin Langhoff <martin@laptop.org>,
	Paul Mackerras <paulus@samba.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 23:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0fq-0004A1-I0
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab3EMVwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:52:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab3EMVwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:52:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1E1C1E57B;
	Mon, 13 May 2013 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8k51rVGd0x8X56HTBItgJVHiHuY=; b=L0Cjn6
	yhGu7ahVCIgj0/uMpvzHejJJ7NiR/qQn3GGnOh9iRJkp2cK/VorjQzsE6fcF0dCu
	OB2ex8GscXW1GiViaFw/Sh9QRdPjppItHS44bwRZ1xHuEF+YuajtyqFHi0UgDB05
	Em59X7q6pBY+ah7MpM0J7XOgX/CVDX9EIYZCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cE/uD8uDq64SzuOElGoQD4LnT0avySAU
	iJU4SDTePGgZTz4kU6MNtikV6SuZK/R10/86CIB6o9t+5DtQLj3+UcnV7aI2PVP/
	qfjcj4RJfwiHf5e9vCL3BWZq8eyVzo+iDX52TXJewJqOYHhZaufgbgL1zlTTRXtx
	lCqzSkUngJs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A88BB1E57A;
	Mon, 13 May 2013 21:52:44 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 227521E579;
	Mon, 13 May 2013 21:52:44 +0000 (UTC)
In-Reply-To: <CACPiFC+Ummjj4d7OiZwEW+Xm_uRNU1hre3_6UDKUBTepm7EmqA@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 13 May 2013 16:54:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 711A5B16-BC17-11E2-B2D2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224214>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Mon, May 13, 2013 at 3:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Well, no, it should find the final change that brought it into the
>> current form.  Just like "git blame".
>>
>> Has it been finding zero results in some cases where the current code
>> matches the pattern?  That sounds like a bug.
>
> Ummm, maybe. You are right, with current git it does work as I would
> expect (usefully ;-) ).
>
> I know I struggled quite a bit with log -S not finding stuff I thought
> it should and that log -G did find, back a year ago.
>
> Damn, I don't have a precise record of what git it was on, nor a good
> repro example. Too long ago,

Since its beginning, the -S implementation hasn't change that much,
and I do not remember fixing such a bug. If you saw issues in old
Git, the same issues would still exist in today's Git.

It could be that a change to your history (not change to Git) was
introduced in an evil merge, and you were running "git log -p -S"
without "-m", or something.
