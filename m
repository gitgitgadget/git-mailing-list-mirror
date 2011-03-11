From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Fri, 11 Mar 2011 09:49:30 +0100
Message-ID: <4D79E21A.3040007@drmicha.warpmail.net>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu> <20110310225233.GH15828@sigill.intra.peff.net> <7vvczq1o4l.fsf@alter.siamese.dyndns.org> <20110311012318.GB15377@sigill.intra.peff.net> <20110311053107.GB16605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 09:53:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxy68-0003sG-5N
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 09:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab1CKIxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Mar 2011 03:53:06 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60508 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751298Ab1CKIxF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Mar 2011 03:53:05 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 732B1208F7;
	Fri, 11 Mar 2011 03:53:02 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 11 Mar 2011 03:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=n6ZJ7zfGdPtBqeZ8s1jEduz4pfM=; b=AsIi7k1V/NYoNmqdrTwAHXT3g7sjmveYlklJ+WhcmwbSrKLtUFT9JkJ1+FwMRImk9pruV6FnUVUsOXefGho9+gIoHsvJrVQStPoDG8/vmsccs7DM9g1Dq8uUk7eTBeYrsfnxLmPRJBBUdOAFGRDn6sliiXzsN8HVNydpEhdWYAs=
X-Sasl-enc: WyhSgr+zdXiIulyMnrfx/o9RPkCyx2YJoHSyv83PLfHx 1299833582
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A8C9D404AE5;
	Fri, 11 Mar 2011 03:53:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <20110311053107.GB16605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168891>

Jeff King venit, vidit, dixit 11.03.2011 06:31:
> On Thu, Mar 10, 2011 at 08:23:18PM -0500, Jeff King wrote:
>=20
>> I like the proposal for:
>>
>>   # Lines below this one will be removed.
>>   diff --git ...
>>
>> which seems to have the best of both worlds, robust and easy for edi=
tors
>> to recognize as a diff. For that matter, we could also do "# Lines b=
elow
>> this one..." for _all_ of the git-status template, but I don't think
>> it's necessary. Those lines are already clearly marked with a delimi=
ter,
>> and I don't think anybody is complaining about them (and the "Lines
>> below this one..." line adds just one more line of cruft).
>=20
> Hmm, actually the proposal that G=C3=A1bor mentioned here:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/100525/focus=
=3D100655
>=20
> was to mark the whole status template as "everything below this line =
is
> uninteresting". And I was wrong that it would add one more line of
> cruft; we already have a line saying "lines with '#' will be ignored"=
,
> so it would be replacing it.
>=20
> I do still think I prefer the "#" as comment lines, though. Editors
> understand that concept pretty well. For example, one thing that happ=
ens
> to me a lot is that I write a paragraph, then edit it, then ask the
> editor to re-wrap it. Inevitably it buts against the "#" lines, and
> those get re-wrapped, too. I could fix it, of course, but I don't bot=
her
> because the editor knows that the stuff on "#" lines should remain on
> "#" lines. So as it is now, the git-status output gets scrambled, but=
 I
> don't have to care. With a special "# Lines below this one..." line, =
I
> will have mangled it and get extra cruft in my commit message.

As long as we match for the first n characters of that line with n<60 o=
r
so the rewrapping will do no harm (assuming you leave it to start a new
paragraph, i.e. "^#Lines..." stays "^#Lines...").

>=20
> But I admit that this is one pretty bizarre personal anecdote and mig=
ht
> not affect anyone else.

What affects me more is when when I track files in a different encoding
(latin1, say), the diff triggers that encoding for vim and I end up wit=
h
encoding issues for the commit message (which is supposed to be utf8)..=
=2E

Michael
