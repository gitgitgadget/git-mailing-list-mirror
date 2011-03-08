From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: --max-count useless with git-rev-list's --reverse
Date: Tue, 08 Mar 2011 09:30:36 +0100
Message-ID: <4D75E92C.1090506@drmicha.warpmail.net>
References: <AANLkTikpK-r_kdqCEPwpqEgENtwgUrZDLwZnuS2QMdH=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 09:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsMt-0001x0-NI
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab1CHIeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 03:34:05 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60303 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756178Ab1CHIeE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 03:34:04 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A88E0206BA;
	Tue,  8 Mar 2011 03:34:02 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 08 Mar 2011 03:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=N4XJDvr6c/AhjXxLqWp5Tm8aHbo=; b=DLn2PcHNosd8dUsg0wRIcoC7HAeQ6AR6RU/v//qYae9Jxsh1Q8/2sppimohq2REwnfPrx+X5VpsYORr7LQKMHT0m46CZC5Hc/r+LblgKh0aIaqqpMr90IXBS4JgkFe6DnpLWlOIKYRem6pRwZvxg2uQlbOrujl+c/nAfIJjsGWg=
X-Sasl-enc: BesBPe0mouqscYwhHra+benV5aAEVNc6EE+wDzcB0N2I 1299573242
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2A26940547F;
	Tue,  8 Mar 2011 03:34:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTikpK-r_kdqCEPwpqEgENtwgUrZDLwZnuS2QMdH=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168642>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 07.03.2011 2=
0:17:
> On git.git, this works as expected, gives me the first 3 commits:
>=20
>    $ git rev-list --reverse origin/master | head -n 3
>     e83c5163316f89bfbde7d9ab23ca2e25604af290
>     8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
>     e497ea2a9b6c378f01d092c210af20cbee762475
>=20
> Why is this so useless about ignoring the --reverse option, is this m=
y
> design (these are the 3 *latest* commits):

I don't think it's your design ;)

>=20
>     $ git rev-list --reverse origin/master --max-count=3D3
>     08fd8710e277eed73a21c6c5483c57bfeb14e8a7
>     6d74e5c9dbe71e2eb63c6e8862ec979e9a5f068b
>     07873dc5dd67398324278ff0d7627bb1a863ba89
>     $ git rev-list origin/master --max-count=3D3
>     07873dc5dd67398324278ff0d7627bb1a863ba89
>     6d74e5c9dbe71e2eb63c6e8862ec979e9a5f068b
>     08fd8710e277eed73a21c6c5483c57bfeb14e8a7
>=20
> From the manpage:
>=20
>    --reverse
>        Output the commits in reverse order. Cannot be combined with

And that's exactly what it does - built in "tac", so to say.

> --walk-reflogs.
>=20
> Shouldn't --reverse be applied *before* --max-count?

We could be clearer about the order in which these options are applied,
for example by listing the option blocks in that order and pointing out
--reverse in particular, see the upcoming little (squashable series).

Cheers,
Michael
