Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2EC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 21:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiG1VYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiG1VYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 17:24:01 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A8F74DFD
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 14:24:00 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 99FDB5A1A8;
        Thu, 28 Jul 2022 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1659043439;
        bh=IwplbxFTYbK7rv3+ROY0wElu1vjaOhSQsKH6WPJBaJY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zUQElQU6VLR/yYZgn9/BxlrqkaFWiSXnZ2rAjyu9Mq+1BLEi46S7Mf1+M+aRsqeQx
         EfHXViFx6d7JL8yUcjr16QY2FE8M8gT+wljlDMvJw7q1skjDEb4os+iqaqKzpOE7Eh
         ugUY7peqGQznDneIxCgu5B0+oxyC7fS4v2y7lXhnfI+xijP1Bi+yo7orZJMv8MQqAH
         wWQ0BOGDvJiZ8yOFDfb3nvZjOKXps++uXoOMINjPnLom8CYGONN2XyVWN/B4QqyJoe
         bm/gwzD4y1lx473ypv9bu4S6fP39Kj8s+bLjTsd6e7kZGtpDy9CSmNG0/GtmQFiMrU
         Ujh0Wom/HD/6VCtYE5hDj5CQRLamwkucYefgfyImv8g4l7D8HnqLFgY0GHdbV3CvG2
         vHRzKH3bIyse6m3WJiQwJwExP7wWjPQGo6KDl45l0wMCbAmAjfzc3Pt4XQTswqwuag
         Am8GqbOWVinjv+i3y3L4W3lVnWGeChHy4Cc5MKnsuaz5uqiSXrY
Date:   Thu, 28 Jul 2022 21:23:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Lost file after git merge
Message-ID: <YuL+btk2MYmnphRs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Um6Ekz/b2FIpVJf3"
Content-Disposition: inline
In-Reply-To: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Um6Ekz/b2FIpVJf3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-28 at 08:23:24, La=C4=8Fa Tesa=C5=99=C3=ADk wrote:
> Dear all,
>=20
> recently we experienced strange behavior of git merge after deleting file=
 in two branches and introducing it again in one of them (revision graph: h=
ttps://i.stack.imgur.com/jNUZB.png):
>=20
> 1. I added a file called 'new_file' to a master branch.
> 2. Then I created branch feature/2 and deleted the file in master
> 3. Then I deleted the file in branch feature/2 as well.
> 4. I created 'new_file' on branch feature/2 again.
> 5. I merged feature/2 into master, merge introduced no changes, file 'new=
_file' is not present in master.
>=20
> This could cause problems to our team in the future, fortunately we notic=
ed it this time.
> Please, does anybody have any explanation for this behavior?
>=20
> Or is anybody aware of any Git or Source option that changes this behavio=
ur?

I think this is covered in the Git FAQ:

If I make a change on two branches but revert it on one, why does the merge=
 of those branches include the change?
	By default, when Git does a merge, it uses a strategy called the `ort`
	strategy, which does a fancy three-way merge.  In such a case, when Git
	performs the merge, it considers exactly three points: the two heads and a
	third point, called the _merge base_, which is usually the common ancestor=
 of
	those commits.  Git does not consider the history or the individual commits
	that have happened on those branches at all.

  As a result, if both sides have a change and one side has reverted that c=
hange,
  the result is to include the change.  This is because the code has change=
d on
  one side and there is no net change on the other, and in this scenario, G=
it
  adopts the change.

  If this is a problem for you, you can do a rebase instead, rebasing the b=
ranch
  with the revert onto the other branch.  A rebase in this scenario will re=
vert
  the change, because a rebase applies each individual commit, including the
  revert.  Note that rebases rewrite history, so you should avoid rebasing
  published branches unless you're sure you're comfortable with that.  See =
the
  NOTES section in git-rebase(1) for more details.

In this case, your change is to delete the file and the revert is to
re-add it, which is why this is happening.

I realize this is tricky, which is why I added this FAQ entry, and,
before that, the mention in git-merge(1) in the sentence starting with
"With the strategies".  It is, however, the correct behaviour, since a
three-way merge must necessarily adopt a change, whatever that is, when
the other side is unchanged, and as a result, there's no configuration
option for this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Um6Ekz/b2FIpVJf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYuL+bgAKCRB8DEliiIei
gTYTAP44fGchDxWXHHS/NATFuKQx5g3m1tvr1OGiY2hsXvkQHwEAnoPZsaUB6WXH
k5RVD+uD9aOUkZCHL1zG4J+OYnntPAk=
=oEx2
-----END PGP SIGNATURE-----

--Um6Ekz/b2FIpVJf3--
