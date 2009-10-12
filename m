From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just a
 branch
Date: Mon, 12 Oct 2009 16:41:57 -0700
Message-ID: <7vaazw6uyi.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu>
 <7vr5t8coex.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0910121708030.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:43:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxUY7-0007dA-LY
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbZJLXmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 19:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZJLXmr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 19:42:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbZJLXmq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 19:42:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9A987580A;
	Mon, 12 Oct 2009 19:42:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=NDYjTX8qpM44j5xLrC5XOf3Zh
	/s=; b=fX7PbBaQ1r4WcmP//faDHb//TKEiTR3irW6uLJ+QK7bMeyEBLCTlMkhaI
	Q2D1DnKMzq3sKz6Y5c7bTzb9VTa3dVTdQ7f8PDKTDyYx4kbrtgAXStHneNfwsb/0
	M/7kRwBzWYRQk1fzM3Zeo71Sa87P5Ig9vo4kP3FfvHLvqweeUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=RjcM95vAuLtFIXRKyRd
	uvyPXTUcjXfwthnrEo+ZHOjGCy0sWCFXzGstODmVD88S2rc9aZHqyljqUkNWdxKT
	THbNumCI6F3ZD9bp+HnT7mq8mXXcHsRIYrSEzGQOENurrxapBXE4tIZg/IkWv/Wq
	O5/bT/KE3xLt3+FI1/Yp9Xzs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E1B275809;
	Mon, 12 Oct 2009 19:42:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5EA9275808; Mon, 12 Oct 2009
 19:41:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D777685A-B788-11DE-8CA2-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130094>

Anders Kaseorg <andersk@MIT.EDU> writes:

> I had in mind only one case where =E2=80=98git bisect reset <commit>=E2=
=80=99 would be=20
> useful.  I often don=E2=80=99t even remember what commit I was on bef=
ore I started=20
> a bisect, much less believe that I want to immediately switch back to=
 it. =20
> I would prefer to be able to clean the bisection state without checki=
ng=20
> out another commit at all, because that takes forever and invalidates=
 my=20
> compiled tree.  This is what =E2=80=98git bisect reset HEAD=E2=80=99 =
would do if it=20
> worked.

I am not sure what "removing bisect states" really buys you.

If having bisect states somehow interferes what you need to do in order=
 to
decide which commit you want to switch to, it may make sense to do 'git
bisect reset HEAD' or 'git bisect stop', before starting whatever you n=
eed
to do to make that decision.

But I do not know how it hurts to still have bisect states around, in
order to find where you want to go next.  Could you elaborate?

But your explanation "I often don't even remember" makes sense to me.

I would understand it, if not agreeing that I also am often in that
situation myself", if somebody does not even care which commit he was o=
n
before starting the bisection, but knows (or is willing to decide at th=
at
point) which branch (or even a specific commit, while still being
detached) he wants to switch to.  And it would make sense to avoid an
extra checkout that snaps back to the pre-bisection commit before
switching to the new state he has chosen.

So in that sense, I would agree with your original patch more than I wo=
uld
agree with what you suggested as an alternative (i.e. "git bisect stop"
which is what "git bisect reset HEAD" would do if we do not verify the
argument is the name of an existing branch) in your response.

I am inclined to ask you to come up with a paragraph in the documentati=
on
to discuss how the optional <branch> (now it will be <commit>) paramete=
r
to the reset subcommand is meant to be used and re-submit the original
patch, perhaps with an updated commit log message.  "Allow resetting to
any" said only what the patch does, without saying why such a mode of
operation was even a good thing to begin with.

Thanks.
