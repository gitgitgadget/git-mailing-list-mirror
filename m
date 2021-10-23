Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CCC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 06:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0D06103D
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 06:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhJWGBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 02:01:00 -0400
Received: from mout02.posteo.de ([185.67.36.66]:43211 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhJWGA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 02:00:59 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 1098C240101
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 07:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1634968719; bh=NQMFjftTPi9J6vka2VmOzqbwUizgPp5JKGaeyEVRUv4=;
        h=From:Subject:Date:To:From;
        b=IrZRaB+wPYV97eqfshKl6xwnn+q6q3J0n3QvUb1Sd29N0oIHBYOyUorIgFMEC0glj
         kpnDO6OlSHeSlUIuAuKonIV/vvCSFAQwOsIGz6aa0k+KG08iTv1za98j3kJF14Cfke
         rot2CDsIaCNvwWWbMXGDpML+WlO+Kb9zSBvSnrE4Rro2pPPD3UN6c/MGCPwkkkdRiT
         Ie9pec0a/zqgr3Mz3U6rpNvBs1kOBBn29/26HDD/+oZXVktqrf+S4R6LPNW48/ITSw
         l1U6yJdRO9Km+eWiM4m2Nvawl1+OQ7pLdTna7zjH8z6ddVwbSPHiZtr6F0gFjagVDN
         QWVoZq95MWd5Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HbrB64DLLz9rxM
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 07:58:38 +0200 (CEST)
From:   "Schanzenbach, Martin" <mschanzenbach@posteo.de>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_99C5F546-AC3A-4957-A1E2-4E178B33D785";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: git log displaying wrong account information
Message-Id: <9826C830-3680-4AC4-9ADB-5FA45222A15B@posteo.de>
Date:   Sat, 23 Oct 2021 05:58:37 +0000
To:     git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_99C5F546-AC3A-4957-A1E2-4E178B33D785
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

there is some odd behaviour in "git log" which affects me in various =
ways:
For some reason, it "canonicalizes" the author/commiter information in =
our repository: https://git.gnunet.org/git/gnunet.git
5 years ago or so I was using another email address for commits. I have =
been using a different email address since that.

But if you clone this repo, and take a look at a recent commit such as =
be9b998b3369056c7c8fb0ae84fb4e2a064b496c using "git log", you will see =
that my email address is actually the old one and different from the =
_real_ information.
You can see that I correctly set the author/commiter email here using =
either cgit =
(https://git.gnunet.org/gnunet.git/commit/?id=3Dbe9b998b3369056c7c8fb0ae84=
fb4e2a064b496c) or a specific format such as

$ git log --pretty=3Dformat:"[%h] %cd - Committer: %cn (%ce), Author: =
%an (%ae)

This is driving me crazy as the information is just plain wrong and when =
our CI tries to collect a blamelist when sending out notifications, it =
also uses the info from "git log" instead of the actual author/commiter =
emails, promptly sending the reports to the wrong account.

Any idea what to do? I really do not want to rebase and rewrite =
thousands of commits with questionable success.
Doing that locally also does not change the output from "git log", in =
case you are wondering.
This problem will reemerge eventually whenever an author wants to change =
to another email address it seems so is this a bug?

Any help/pointers appreciated.

Martin

--Apple-Mail=_99C5F546-AC3A-4957-A1E2-4E178B33D785
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPREGPBD5jRS9JNFHCwmY74b1m2oFAmFzpI0ACgkQCwmY74b1
m2qAQBAAgj2WsPcFxCWOSpg8Mz6EtAP5tQv+0cq9zL/6IhAB8hyOPVciwfIN1d6K
XNk+ShmY10URybs6dQ3qjPpEEEDVVV+cxVow/DmhbdWtHFpLjietg0GnO9L7YMIy
er21fTlgoARdzo2kxhkpGNWpcpJahfMEyGCQbIvNkhh6mRWWPvBk1SF545av5V0F
Il9DZuw+i33cl586i80NhXZ1q0IyMhXGIKKbtku6Uj4x5Fye4X9TlAfWjtU0lvLq
TMlYU2g37kLThO3ZMBSo4Y+2oe8tz2FDTdoRlpaj72ucFUHiwr/WKWc+oPmX5zAz
N05OIsLpIGwi77ugMFjSaMRPZeK2QE0SwMluUdUCn4FGc9BdWnFdxhKRCi199R5q
QGaxyPQjGtUOd16f0Zea2mwi/0enRgK8PwiJNPqFVZUvs1G1ewMrczuRq8AZh87p
/Y5trn32nytxrstQ1FGR31cqWq6Y8mwAhYJOZ7uyVazk0X+e63aFdB4eH2d3gjma
PIY5qnC72f6FeM89Lunnxjdqg9gYV1yiMihn71l3KwXiHYFLLKXtYI6b0ESojk2M
8voA9npgS6Y9sofP4eMTyNa5X1Vp9GODWjm5oRUt3CKx38yMOOhhbuMXfTJYCYA5
f0n7jr9NDpakMLIVLybgwxe0/D3Jm9Hsw0rvFB9XhZEyC/3kpBg=
=3WKT
-----END PGP SIGNATURE-----

--Apple-Mail=_99C5F546-AC3A-4957-A1E2-4E178B33D785--
