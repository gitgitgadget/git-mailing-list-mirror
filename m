Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="KjoyOnUh"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7582F5
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 03:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700999856; x=1701604656; i=l.s.r@web.de;
	bh=0Fe8gBnPWaATmipLa7tuunT3txhzno15lSn84yo+R7Q=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=KjoyOnUhgDozt8QFhmoff8cpGDaBMlmPvqc+KngrC2b9VldMaiJtBTBraKW3Pfos
	 XQfz7yZ26bLL5cTiOklNVY20u23Ks/gLntoG1Lkh+0QV/WjqGU1p5rPVLr885AGK+
	 voEUPErikzw1KWWIpRxflCBJqCXxUz9DenUQlBBlYkqOIApv3Zxdlc1CXQm8J1KNK
	 oc0/1yG14w9Q4tMsCQSjc9YWesXvgLE7f/JQQfLvGHK5z1XtzibM93PMHXRJ5xkby
	 8u4V6ZAaEoF7eK8PO836mzKkBCEIstLduBG9oLLePNDY2XYR8JCJfCiUOFE2Mran3
	 Lq2V17CsU32OZBBxiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.220]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1r3sEm3E4S-00EkMq for
 <git@vger.kernel.org>; Sun, 26 Nov 2023 12:57:36 +0100
Message-ID: <f087137d-a5aa-487e-a1cb-0ad7117b38ed@web.de>
Date: Sun, 26 Nov 2023 12:57:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] column: release strbuf and string_list after use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IzdLSbbz1TIV98TNiGO8r3T9eSD4lZiWro+1WCF1Gxd4NwVwG6H
 fW4ptFGqtlVWSfb0JHdlGVlWxa7XKDnUd/35T66a2Iyo0YWSCXZ9I5iuMVZLyeJ+kSMN0Cv
 iaJLXoDxmlqRz9IvM+2/pjnv0pkDLq9/Yb7zk8et1/J3Kd2CMmosqfA4PUOByBDA1N2nkrX
 +3cqF4+0m3KYWSlKcO9Kw==
UI-OutboundReport: notjunk:1;M01:P0:KDp8l30AqEk=;b+lU371D3VJfZeuwQVjHpF1Mm6Z
 s39fUj1GV2P0D6M6wbQtE/KK9bIWWy5NYcznpPLhnz9OHV5NmW/t140N+7WkBovt4dWareN7E
 GJ4bAVBLg/dIHdEmPm5dJ2G1hrWflgboqhC1uXCzaRXdubuTI9UZbuXPl98JFe9FNActyvccS
 PL2LhAxftcnU06xXc64CXE5Uz/E0U5z/+nr1yAU09pgKOdC9EBW8dzFPJ6BdS8fimqHM0VUzR
 UihoxV2dy3ColL8WLrBRu3jsMxYr5tANvOutv1WYE2S6Cg0omF9Ptt8PZYhBEhd2yrur1k33m
 yCIk+670nzmXRKZjlRzB2Cs7wqIfyH8C5X3mi1necITOVGk8fmU9xZle9NfBUGy/LTIbp8qHP
 gCPcxNMyAxBqa2SLEwLDJdBd9Wxatto40bYtEVoq3ke7HoRB0OdrFP/TMCmvhOyj/F+me0Ifd
 aQBBuzDDrIlGBjpuGkSqDMKTbrDVPgi1c487JuaV8Km0ku3VZQKVvba9fpVcB81uZl4wu8PBJ
 Cw3Var5qoGgjufn1cN9LGnZqDOU85kYhYSNjrG1i7qaeKJlpT6qS20mHlH/OH6Ro6Ma4gkS4n
 GN6dkuJ9ku27sekVoXfFsRi5wnpSPn1FCxgyR5XSUL+uw4S1W9b0YYvUcBisWRQskWU+mAf5t
 Mimgw2QFIGZdGuH7rdzmwKCEllI+atrB1u7zHBcPb9CAeCv/5NJgmpW0DieEunh5ae4PpkOU5
 nBw2CB1o21dlHlbL++UG/TB6PiEwj65/u1x1hTSsc9LJz+x26IsaYtZeaTiMAmG1Nng71acsJ
 aOcuImWp+gnz7Kc3egrDQp8mT9HoZZpM+5onF59c04QQigmh8Zai1ACC1wvGAI93Fpcqy91lf
 sUuoC7rm3qrX8KbAxkQ6lPcde41Bc/IuPndaxh2Zf3g9QoG1HHF3EWwVRvyZtZEaXVCcqIeS6
 9IwnpQ==

Releasing strbuf and string_list just before exiting is not strictly
necessary, but it gets rid of false positives reported by leak checkers,
which can then be more easily used to show that the column-printing
machinery behind print_columns() are free of leaks.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/column.c  | 2 ++
 t/t9002-column.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/column.c b/builtin/column.c
index a83be8bc99..e80218f81f 100644
=2D-- a/builtin/column.c
+++ b/builtin/column.c
@@ -56,5 +56,7 @@ int cmd_column(int argc, const char **argv, const char *=
prefix)
 		string_list_append(&list, sb.buf);

 	print_columns(&list, colopts, &copts);
+	strbuf_release(&sb);
+	string_list_clear(&list, 0);
 	return 0;
 }
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 6d3dbde3fe..348cc40658 100755
=2D-- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -1,6 +1,7 @@
 #!/bin/sh

 test_description=3D'git column'
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh

 test_expect_success 'setup' '
=2D-
2.43.0
