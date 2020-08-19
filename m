Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE9C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD8E20888
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oOPojZG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHSQop (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:44:45 -0400
Received: from mout.web.de ([212.227.15.14]:54235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgHSQoA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 12:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597855429;
        bh=elpQWnMEbQJfLsNjewKKZ3fdHB+Kvm017RCsE/3EDR8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=oOPojZG1tDEzEpeF/U1HaoaHbZB84JYgildCtGCinOY5SiiVf878dYW0+CtghU2yX
         ZQq/4zoOxxNDWFNoMXBpKwFkkGPAzGZaETGWhlfLqg842LPguvoFCJZBtFuaRgA8S7
         pK2OtIqu34St0JC4iwEcabbd2z8GbDqemz4BT19A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.157]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtoGb-1kp9v62CRx-011E7s; Wed, 19
 Aug 2020 18:43:49 +0200
Date:   Wed, 19 Aug 2020 18:43:48 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/2] dir: Recurse into nested git repos if they aren't
 submodules
Message-ID: <52f2765689d0d56739b3ba2c08d9cf8db63b5794.1597853634.git.lukasstraub2@web.de>
In-Reply-To: <cover.1597853634.git.lukasstraub2@web.de>
References: <cover.1597853634.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sRKfcG+uykK18LYrkNfCJDu";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:YWBZfQTStgg/LDkb1qFYRNFHiGZ1FBKAp7z8NkI3yI7QYW0Aa4Q
 3Ro0KE1+iZxef0qFL4/d8Xf4IPMH+EHu9s0sKFG9i5pg0skBR/CxhsRqWiAE86T5knzVQ0K
 KCMfTMHdivZr0peUo7AUtM+d5fGr8XWn/ohNYlp+S/ehlDmwyxQWOuFJddaq0p8Rbx9q5W2
 PzEALuTAWucIGcabUvFJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z+VyMVC9rJs=:re61Xat14j7UooDGIt6lTB
 AJaInbI6X4yzAh0UpGKD1X5Ew9rYGor9nYifXn/J9/MtggKVv94vY6YQtrCi/pJoevsQCaGtx
 EiiMVICoOiQsDdQNh9rhXvqbFYKkfjrIFyIsVbDeGnNAiTZ5zIb5+gAcQ7WM4M8xJfZB7+7kY
 umLM9Px2ZXY36yibuZK/A6BXzRpMKSv3tSpwrmYtgSXZ8d+FJxErteSBNrFcYgcgevwWqq7KW
 DU6hkt5NS9t+mgm9sVs/+iE0QfNLHlH9Nwsw9vWNJpNQFzGGU1KwuDanR1h5S/XeXwAG+XtxH
 p5CFhvP7A+wMZTw+DPsDHVuYzIPAdDmAchbbNLBcIO1C2tBXsohfjYX4ng1UwcoR7kDXnaN4z
 EyqZXUt5PZn4O+kjX1WjDHi80jvrdDFZBbxEVhTrN3yT+v6phZua/mGngAKO+SHmqCKZZuTum
 eWg2NZV9NsGASMEhBmuOWLJPWnWCXBORdXxeKDIxZBX4zdj4VhHbu9Ah40xEGuYyftg/pwQZI
 yxqi0Ykafg2nInc0PSqTcCr7RCT51lC3y2q+RgpO5OLKKDw8FHykJliEL4zG/A6/crkA0ZUTk
 Zr+FqEU9NMsGeUluiNDDmSxM7xaqPH3ApivuNwPy9mWc6QHPs69tEkHS3u85n2L3D8a+pvfE6
 M66b/I6ieX+lRrO03uLZNHbl+vtW3SdrkV4Mv09KNb9mPhGP6IRjC21dvO0KyHcDFSQYhVg3N
 2LcrbcQ3WkbbqwcBw8EWQrf0TbwUGyzapmd/LlPafE8qNOLi1VvQTQjKBVHmM0ask39+R8UTL
 KDjnAJ2w+YhyVkMi4IdXgGNdOV4AkYoolcS4jfaOdtGRIJNHaY4AN+eCvb3D5KfPa2vKdE942
 bk+qq94zmIpzBfuBOH4Eimg/nRTCoTgHEGNODP99j07XZORBMtw1sy9Rk5bHuyzAI1C29JUUU
 3saro0W2V9xq1L+hNQKKArsiKlqqcqhdES8qobP3lCqj/YKZTB5wEBWsX2lqKSQn0YbYn5K19
 LYKnnmFPpRMuJ32Wf/IFQ+kgH453ujpaakYLYK2kT073Mr2MK0uPisHUnw7XVCiiGEyz3rPsf
 3dSqchTSiiwMkvM5JkcsAuTwfepdFzoMh2bxLhvKbfPYmejgyyCt47XFBqkmfzVxvXOsDldtC
 6BghIHlzJBl5tm3KcTrUYdH6ubQh2X5/Q5jFW1yfNRSjpJicePpXt6b8o0VH73xetP6lU+FZM
 Q/TGemHF0iCxW1PhFGTTVn3IGhpUj9sdaFRwWQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/sRKfcG+uykK18LYrkNfCJDu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Only stop recursing into a nested git repository if it actually is
a submodule.

This allows adding nested git repositories as files as usual.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 dir.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index a959885f50..359015748f 100644
--- a/dir.c
+++ b/dir.c
@@ -1787,10 +1787,8 @@ static enum path_treatment treat_directory(struct di=
r_struct *dir,
=20
 	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
 		!(dir->flags & DIR_NO_GITLINKS)) {
-		struct strbuf sb =3D STRBUF_INIT;
-		strbuf_addstr(&sb, dirname);
-		nested_repo =3D is_nonbare_repository_dir(&sb);
-		strbuf_release(&sb);
+		nested_repo =3D !!submodule_from_path(the_repository, &null_oid,
+						    dirname);
 	}
 	if (nested_repo)
 		return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
--=20
2.28.0.217.ge805fe7219

--Sig_/sRKfcG+uykK18LYrkNfCJDu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl89VsQACgkQNasLKJxd
sljWmQ//XD4qKiQqLP8gP6vCYraSYHTuPI7Ti6MUUKH6+oT7QGyJYt+Hd2tPNXnL
aMmDJLkB5w40SZAjtfVgC5MB2XXDKbCBHxrRIb/23jnI2wnxZHAvgWZkMHzosgNa
cIcoisGwPEtm2GAAvIrpNIwuKHSPCb1P+tVRlNmjcV0lw2DrJlmcSED/UqVB8FeW
1xRnIyV5/wGXJpfyKryrrqo+mWHtIRBSG8dw9lnjZz9dbM6AFafYRDNOPB249PEB
zDEDeP6YTs4g//IGooyYrMBll6zhMmgS6ZgYSlFxdhoJ9mg+/8GDJPLE7AVDxHAB
+Yi2H31L57VUh5eyBked585IaVBwpu5cMrl9SBDzgRi2hbDAAQKT8SYulZt9813V
i2H7kvjWMmffQLjvyEVAsT4tHN8upZVKPSo9IOFIZiSbmBNcxNOJ+h/vO1lJh4gO
7gFHiLYDIj7W7rRFolsC5BsCnrCGHg3CazdvYZV5F456XszDzNPPQarkFXvGPnWl
YStNxMq4Hoo3nBX6CGbS26pKvnSKieliAZ+AAihMOGCQgsaaDxXGlV5ngBap5H3H
SOJYx/9aHr5aenS2WLxfQtVyyXIy/bYvD1484qcr94OBn7SjQfVr4AahdiviT/rf
tYlXbizp5vss8g+Z3TJIYdA+asW8ByYqLz+TSdOeOxdlenVe3+Q=
=61vQ
-----END PGP SIGNATURE-----

--Sig_/sRKfcG+uykK18LYrkNfCJDu--
