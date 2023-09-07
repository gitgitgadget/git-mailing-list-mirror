Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022AEC875C
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjIGUVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbjIGUVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:21:12 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D311BD8
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694118059; x=1694722859; i=l.s.r@web.de;
 bh=hQmJ1uufx7yJZyoxuOzRZ9uF1K1w6Yl2CCbpjCqT/sU=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=k0Nj2I2GoDN2+8mWPfRgHs/aQYA+XH7M64BFQpq4wStrV3EEdHjuatgY3+tWRBoJrEndM3t
 WAMKlc5z3p2U0DfkLG1SNcgP13DViKTTFgDLXHqG1RRIHbYiWyyKiTZ1iAOeIU85QRWPzF7Wl
 M4n337cw06w4n6Ryps50xBzVC3gMuqweAH0MKWasA9PR5yco7eS/Sk3drNZrOkyf0SiLI3qI2
 wfLdMYBsjseLzBIZDH2vnNz3tfNjEHIsK4lts9yvedff5FzOotHfUr91l9wyzR5Cq5V25LvsS
 ShzJ9Atnib9VxAvrBwDkOpq6Opm0csHU6Cx913zMSJCNzs68Trcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.74]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpuy-1q4jlJ30Es-00Zy4j for
 <git@vger.kernel.org>; Thu, 07 Sep 2023 22:20:59 +0200
Message-ID: <6aeb0ebe-0fea-ccd3-089a-ee0b5b5baf10@web.de>
Date:   Thu, 7 Sep 2023 22:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] grep: reject --no-or
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ypauFrDPYhaccgFoAV4H7/dOcVTVyNqHJWUseXEq8EgUMrhSEER
 6RsPQg6oX3V56AEtJWX/B3grEGMYJgumhERDQU6Ft11Db04O5WxOTSKXGy/ssADZgaHqa/I
 QNQMfpS/byipLIANk07A2xTTDXrq6syE2Lo3xaFDL8Tgo3NkNgOl1mFZ/iIR4H1GutS1P2U
 WJhr+7yEhesOYASvOfEmQ==
UI-OutboundReport: notjunk:1;M01:P0:Sw36nzQ5z24=;YoE93uPvu+W1TQTVD+h0f6uIIUf
 MOS4/wcpDIWqUCduoFNgskQT1Ho2fCEp9Yz0avnrAbZoAC8fBUOhmyHye5Lemg3u29OOaryRv
 PpVr8FAxXMfUMbZ/JVRsWGxYf+1Iz8+NjEPi/0wrnnA35jzUbkGoRnyihDTcObFbAUCLRLDvj
 z7Xt4RwsSJS58Jkqu8ybSYU7BQ90QSDfDIvsfuKfDagH3+XcyuQUya15bMEfH6XY6n35lQnT2
 2FZb5NFjSLsnM1DKF/cdGceQli9yGCKlLX/XwE+tgPMS8BUPU9pd2GhFy4BiAJEBNw2EDc6EG
 TpTteZSMnG3v8lRo8dwMBVWFUhC7r/Jqhi1diIhBUS+UeqnYSSCIyk0Pj+A59Jb8PMu90758E
 CyWxsqswhZv4c8y81VIpp1beCA2SgnYru0jor0gQCA7kB6os+7o/zb1zwyzEapLXiykxiv4+T
 IlBOK2Ri2LZTCM1Fuz1crB46tkbGIdgvW5+ELTZlbM8nKZ91vIqG/q20Dx/kVRteJrisBRb1d
 5mX0E/oegMPuP0P0Y1dsGRk0EooXAwAUHMv/xjPjAjurrwukgGprhnQv7n2nVbGBSUhza4VFZ
 VOveYkYKPnjy90zn5EwAUThcUtxM82PgNfjigxYOXhv8wT6loOMZqgSnSCMyaQUKvkjNIYbOz
 1/DeSzGfwuP4C25O4wHSkY6ujecCmEYEYLrUOamBlPNs02Rs0YsrVF3lo/rt1YjqdiZssv30u
 8WekX/i1I5Yr5LDP+6PwLYxDOmRQ5gRSXRFAbIvti5jha9V0TanNt1p+AnRz4hZ+5KCfjccdJ
 gSa6A7SNzJOM9KmS0zE1z5T7eCKpqW7t+uJMoXuss57tuo8ISspJBjoSYIrDACE83yx5o7+8d
 O/9v6k7zP2wDExdh4tW0sR2knDbWJv05VEpeDwyiWEoUGXg2f2sJWbQgmgw8Kmi98Yrar6tab
 vKACTOZPOTczX+HBNl1/ItDXqsk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 3e230fa1b2 (grep: use parseopt, 2009-05-07) git grep has been
accepting the option --no-or.  It does the same as --or: nothing.
That's confusing and unintended.  Forbid negating --or.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 50e712a184..2a261074f1 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -990,7 +990,7 @@ int cmd_grep(int argc, const char **argv, const char *=
prefix)
 		OPT_CALLBACK_F(0, "and", &opt, NULL,
 			N_("combine patterns specified with -e"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback),
-		OPT_BOOL(0, "or", &dummy, ""),
+		OPT_BOOL_F(0, "or", &dummy, "", PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "not", &opt, NULL, "",
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, not_callback),
 		OPT_CALLBACK_F('(', NULL, &opt, NULL, "",
=2D-
2.42.0
