Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0668C004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 11:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjAULFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 06:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAULFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 06:05:15 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D3E17CF7
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 03:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674299111; bh=NjmOuabFZM3Lq+YsCDZRsqYisEQRhShDSCqhdpKSNQg=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=jkdmGGNXmVimByGbJLhnbJBMg3MxNGZhjmcl3vmpD3/E2cH/w9zx+9uKAEW48Zdd4
         aSzzxmi0vMqOnmBW58ESXMb37IdOUna9c6ldy27ySNUMr2rvl6YnGK6g55xGugn6sR
         CybrTZlNO50kmKkZbHwyyzCwQdzt9TAwsgSDDZdUmDI/71fK0edOkvtzn8clH7yRnw
         9WbuadKTV8HEdIWdHGga0JMy7OxU3+McrAGYED5eoMBIHaCQmKNfMEygTkdLv3wawD
         cMK7YMOmsZNCMVsmP4eF4s7trcpKascrIJyUHsPPE+AePg5DeG/+a2Wpq0UnsEizyN
         hs335qqO0tGWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQGF-1pV4JO2gZh-00GeiL; Sat, 21
 Jan 2023 12:05:11 +0100
From:   tboegi@web.de
To:     tboegi@web.de, git@vger.kernel.org
Subject: [PATCH v1 1/1] t0003: Call dd with portable blocksize
Date:   Sat, 21 Jan 2023 12:05:05 +0100
Message-Id: <20230121110505.21362-1-tboegi@web.de>
X-Mailer: git-send-email 2.39.1.254.g904d404274
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C297Ed1DZUbVuqhScmfJcTrIln/gyVWH2qA/r9KvFqw2kJEu3Sz
 kWthjAw83MzWwq4yVUk48jPyovQx51ns/jRpDnkYOicUWO4MLv3DaJeUgN2SecuvJg3rB10
 W/TgeXF1fsNrckGsJqS+p5nA2+KFdyiMwjlshK/l3OVTndfJ7mSaaMciDYtpQGtoVUi3YzQ
 ExD4XkR1wo48O5LKFOcYQ==
UI-OutboundReport: notjunk:1;M01:P0:yBg+GZ28E1U=;4FSXMc5DAFRrM7TZa2oNs9ocdC6
 jHY4h1gRoCmt5RzAPZlrKL1miicsb6EjhxwttyKO7g8rmoYwatGdge/keQ2IIMoqYI8NLmUcG
 YBNJxUK03tq77IaxU1MjHkoXcloOnEdpitM1KQIk0+Cf0j4FRoF4SIbtSQWAOlf+vNlm1i0Nv
 cDAKPHcRsjV2a2kUUQUT/5A7bgw+EPPZ7uwI7VmZ8FiunocPOrfhh6Q1XDNRWGOXIDC1HKoIm
 Ts1HKo0xrFZrl5M5SmGB8xISADxv/t79R2C/oI4Zp8GurU87yjQe38d1/WYqHTv0GjG40A5Ok
 uqVKXHohTZXMbK0sfPjih1WBgU4smnKhiBek1HGGlYaanwubE83H+GcjBo573baFhKoaFBUOs
 lLjLzNwt8Rovs+6CiAxoo5hpdsSWmO/EnkgwzjzmQyu0xzEciDRfSIXXsvc/0H/QHyX8ibgxT
 9JsUKRbNvTS80XgoP+1Asnyekxx+yHQ6TJekk0DK/xba8ikvNFhYNnF2CejP+RqwhR298raAG
 GKUu7qwFV9mleu0MnGSEAMRXw4MThqwBXaHr7zZhuHa9dVh7wPaZLdNQ7CMC38NIbJ0H7EBJs
 OvK9xcnqjQYOorM054Mh50iupy0fMS4VMg86hkfhZAn4V6Y2B05heXnLM+X4rEaT+m6/E3DMv
 tIMWbMKKeOn80QROcRVMCBwTxVc04iWjENOSIBh75TWrnlWqsI9QQU0F3zeVVmKP7Xi2y9+z8
 ROLeE3uf8Ez9VOxIOJ0aNwaiJbl96M+P9lmIpIi8B+aWuwigbPHh0pNCsqdXqTOQj6gjxP8uP
 i535nA7xp9DWfARGwkVb/e0LJ2/wKL0ScXcad5DmgF2XUed6CtOtNtIjINnGoxsqLNVr05dQl
 iL+OF3prRhPxw1tVJql6/VzxkVg4grpy/nHMOy6eab9qZYzUpl96lJpE57el0ngxY2ST4auKY
 PG07h3+DYpBY8gAv2qsdwIOoywo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The command `dd -bs=3D101M count=3D1` is not portable.
Use `bs=3D1048576 count=3D101`, which does the same, instead.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 t/t0003-attributes.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index d0284fe2d7..394a08e6d6 100755
=2D-- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -400,7 +400,7 @@ test_expect_success 'large attributes line ignores tra=
iling content in tree' '

 test_expect_success EXPENSIVE 'large attributes file ignored in tree' '
 	test_when_finished "rm .gitattributes" &&
-	dd if=3D/dev/zero of=3D.gitattributes bs=3D101M count=3D1 2>/dev/null &&
+	dd if=3D/dev/zero of=3D.gitattributes bs=3D1048576 count=3D101 2>/dev/nu=
ll &&
 	git check-attr --all path >/dev/null 2>err &&
 	echo "warning: ignoring overly large gitattributes file ${SQ}.gitattribu=
tes${SQ}" >expect &&
 	test_cmp expect err
@@ -428,7 +428,7 @@ test_expect_success 'large attributes line ignores tra=
iling content in index' '

 test_expect_success EXPENSIVE 'large attributes file ignored in index' '
 	test_when_finished "git update-index --remove .gitattributes" &&
-	blob=3D$(dd if=3D/dev/zero bs=3D101M count=3D1 2>/dev/null | git hash-ob=
=6Aect -w --stdin) &&
+	blob=3D$(dd if=3D/dev/zero bs=3D1048576 count=3D101 2>/dev/null | git ha=
sh-object -w --stdin) &&
 	git update-index --add --cacheinfo 100644,$blob,.gitattributes &&
 	git check-attr --cached --all path >/dev/null 2>err &&
 	echo "warning: ignoring overly large gitattributes blob ${SQ}.gitattribu=
tes${SQ}" >expect &&
=2D-
2.39.1.254.g904d404274

