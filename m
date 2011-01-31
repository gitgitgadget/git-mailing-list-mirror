From: Junio C Hamano <gitster@pobox.com>
Subject: Planning for 1.7.5 and 1.8.0
Date: Mon, 31 Jan 2011 09:05:37 -0800
Message-ID: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 18:05:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjxCM-0006tO-3D
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 18:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab1AaRFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 12:05:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab1AaRFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 12:05:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD8B64136;
	Mon, 31 Jan 2011 12:06:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fqWJjamweydt
	mQgsqcBHZupNVlI=; b=r9f4wUg4dcLJUB/0g1gYPKDoCp7fxXb2AC38V5H3DodV
	J2RvAxNkwZ1/+Uov+1pVlGqAOJDlYS0cksu2rKuYy+5j/gJLJ/v8UhD5sw9QYslX
	htmiGSq8jQYTXDb1aMR8M1rfydBVBuObvNM/5xOM34jbCDFW05ERMsxPE3wNbHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qtJhXo
	6H6+g95b57XLsdvDm8JFewNBN9Mzg4KsJhA1QGKOn9BIeh8RA6XFmFHh+YNT6Tnm
	wZNTIUxgbqrUeNqN9q2AQdOnSDPct+5YWXqC5h+yhLmMdFB1+g+sJzkzuwvgTwu0
	o2DfcnbSMY+LvQO6FsASxRILZyvoeT9ii/TCQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA95F4135;
	Mon, 31 Jan 2011 12:06:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E72944131; Mon, 31 Jan 2011
 12:06:33 -0500 (EST)
In-Reply-To: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 30 Jan 2011 21\:53\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76ED1F34-2D5C-11E0-B4E1-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165735>

Now the 1.7.4 release is out, I'd like people to help thinking about th=
e
next cycle(s).

As a discussion-starter, here are my random wishes.  Even though this d=
oes
not attempt to be exhaustive, keeping the number of goals manageably sm=
all
may help us focus.

 * The i18n effort =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason started two c=
ycles ago has
   stalled. If enough people feel i18n's Porcelain UI is worth having, =
I
   think we would need a brief calming period in the entire tree in ord=
er
   for us to get the minimum support (definition of _() macro that is
   empty is a good start) and _() mark-up of existing strings in, and t=
hen
   ask everybody to rebase their ongoing work on top of it.

 * There was a discussion on documentation updates to reduce "here we t=
ell
   you only the basics; see elsewhere for details", and consolidating t=
he
   description of configuration options in one place.

 * Nguy=E1=BB=85n has been scratching my longstanding itch by attemptin=
g to unify
   two pathspec semantics (the ones based on tree-diff matches only
   leading path while others know globs) to reduce inconsistencies. I
   would really want to see this polished and in the main release.

 * Elijah's fix to "rev-list --objects", together with the updated
   pathspec semantics will allow us to cleanly implement narrow cloning
   (possibly deprecating and replacing the narrow checkout in the
   future).  I am hoping that we can lay groundwork on this inside one
   cycle and the initial end-to-end implementation in another.

 * Shawn Pearce says that the diff implementation JGit uses (histogram
   diff) performs way better than the xdiff implementation we use by
   default. It would be great if somebody can spend time taking a look =
at
   it and possibly port it back to C-git.


Over the time we have discussed minor glitches and inconsistencies that=
 we
all (or at least most of us anyway) agreed we would have done different=
ly
if we were writing Git from scratch, yet we cannot retroactively introd=
uce
differences not to harm existing users.  We may also want to revisit th=
ese
discussions during this round--if there are reasonable number of them t=
hat
we can agree the benefit of tweaked semantics/behaviour outweighs the r=
isk
of breaking and having to update ancient scripts that exploited obscure
corner case behaviour of Git, we would want warn the users loudly, bite
the bullet and break them so that we can move forward.  We would howeve=
r
need to roll such potentially disruptive changes into a big single cycl=
e,
like we did in 1.6.0.

I'll follow-up this message with a couple of example proposals.  Please
send your own, imitating the format of the message, as a reply to this
message.  Do not forget to retitle your message when you do so (iow, I
don't want to see "Re: Planning for 1.7.5 and 1.8.0").

Thanks.
