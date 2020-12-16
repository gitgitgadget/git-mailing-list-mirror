Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5DAC2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C50023447
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgLPWJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:09:14 -0500
Received: from sonic309-19.consmr.mail.bf2.yahoo.com ([74.6.129.193]:41513
        "EHLO sonic309-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730152AbgLPWJO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 17:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1608156507; bh=aKMtS/FB9VUX+GknycdGUYxX3TLTNFm7XmKYF9EskWI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EaaNY553cvDVAuQzAuB0wCB92TQuACUFVVdRsQeRRCXNIrXz46HlAoCm976h6LHmCRf3JmG9MLrS6v3/ETQUYaZoklGhiunVUDh3lBlT58MPnZMv1UL7HjhXmKzpHgsw/Hl98ZfQwNR/GG35xeXtLRBeAIr8AaqrqiLG5F0Yot+9xNfirhBxkVgp1BFtMJVMn8neDfc132qMHqCcXuMeVQl+1cD55O3D32dUetdxEb4VKdstNXBzNkEsknKzTynmgb+L0s9CbVEK6xXTo/RM85HoTPt0XB5yEbuX265+MaE3+juW7leF2cP/AsRr1kTIXdwSqMP5AEM9iIxn8pooaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608156507; bh=6qYSd6mSvl9DV4fk01LLFl45qyAJPztkGdev3u+yS0/=; h=From:To:Subject:Date:From:Subject; b=pDc/e2bUKOocf1yVUHVJ9JJBhBs9s6y85iDb9kjU61LD/sCk9hgbvW97kRZOjSe0HG681S0q+83r9uhv29ALYT5b907dB98/R6qRKo1/HRvTqbkq3zB3nvLzFB2AMfMvgdhvikDYwOinQafGIdu1ke9vxJUKftignkIR8qK+XPViCrdfDvrkDRS3+sk4n90wQlYIyfigyZUZXhMXN0PIyA+HZNgu057x+PjzKY096mkyYgbqqsQ93MMYgey5+IG4BoJ8ip75x+LLF24pUlfqL3gXyqubO0eq1z/lW5yY1/Ylvpl57x2DZtaQ+SBXcHjBiIUeKdMqnQPip/4cTbLmmw==
X-YMail-OSG: kr4xsksVM1mNQHp8D6dHKzCPa1sCm1oJIHeCRoRyXhqalOpEQRHiQyIA0EW_nsx
 wB97ev_0GuVGak5wdtq4H5izmevVoQIbsKDrS09ex3AuSFWBIYbUdae9Zm2U4L3R80pGUivNQTPR
 1IiK133OupZeIb8NbYkCLAhoc7j9OSSwEkh4mri.J2iYuYgu4YFUm22dbmEpOUwUWGhRDZbxuPZG
 w.pltRy44BPtp32xwpMYyHLDhzeB9CXd98oTZuGnCLpHthZtk.9CcVRnX7kh.dPdA.Ze0RVoYb0.
 agnCsHcFiIsiwMwijAL_zixbeeL_3dvK0HT5FHWhwC0i.l9b.5_GIB1Ocw_kUW1ZRogOPEh9xa0I
 dIWKCVSqPZEPNin6MZ2SQ11S5RaUBUb9pE43A3nlJXF6SMxgrBIYdxN4jXlhd5eSRsFkOqwOf3vX
 IprzrsSWplhwLlJl6rMgWEXQQ8Cd1LyzpKpxFv_ZaAYtzVMrGAvRb9k6_1fMpsN2cNVTB7uKeo7s
 n3kO4wc9K06Q5tk4t.KRADfehoLe_8j8iJ._ZFc2TBJtDaH8UXHl3QKyEr0e0g3Oq2ZRZjRnbv9y
 76bdtzQ.w4h.ElWnUOscZdyDwkJDbnA58kMB91XmjEY3bkCQwNT4yT.hf7btbJE1meRnxoB.GQnY
 wv2_Cu7ZpEhzZHLPeTq.SgdMaiNzzulujN4nBoYwcFWYa5Fu3hyO2k2FJE.du47NxZcAbf7ODMmO
 tcMw5ZVWdgO2SmHFLbk8PihmllGMjMi.UrY4.HD3JNRFmBr3jX1rv6bApvw_vOyizKv3rlqe81Nv
 x_jLEbcr9DvlLh1bfAKFHrXD.cRaTAcZ8tzRqLKHCZ0ID5X20PMHKG1uQXQ0kmScWGFX4gUpjShp
 x3InXVGIp.HLJruTNl2cdxW4GYkSN2qCe4HQYpp4xN.X0zQk2GgNR8Oc7Gm1AwJKSh73Hu3u.HUA
 AvFcf3lyaU4n6TCUdvVoNTBBE1SoLaaXRKGa_jKejTHoT87d0qIkvuXO9yJUjjpeC5DJ9Da1DHx_
 uQjAdJI5dYK4FPimOLhlNy4bBOLdbcBa8fUHVB3DA1UEavRHVM3U35idVaUnI7zzP4ZEn_RsOWmR
 AqMgpDLmXaIcH1fMxs6GVj11lC3n2zE38jnh9bje3YWQlm5US13JNQVOxaS2Ehk94RihoKiXmwRc
 xvOQCz9s2pI_03Q7.mDaYBjIVIVXb7A21lxq6aJrzxPnV_wWPAmon06CaRhYkBs5l8hHmLFo4Rkk
 lD3tvVpiGM9FAB94_if6vUHywcp85LOfw41N9TvXdf4LmrlbrckMe.mcx.ZIruZvzNnaTqeOlzh_
 2heXvofdG7a92XhAIYTKgwGGJL_zs2.GeXe7fiGte6cqT4ptO1KJxSBVuDCZWvuzWrZra7Oou.0f
 VsjX_f3v8FB3TbYY0ESRggE5RwdJS.xMHz4QqT1Nsxqd09EUqX.phoa6wqXIVQRcGh6eLNc_Sf4O
 JNlDH2tkLoys4SXEv5tnzAknJtkA6HX8LMY1pvBPqvIEQ0JAEwCvkVFb55XeJMqB0I8tBvOfWg0Y
 PvYBfbtWdtc39W3DlqxttW8QuALcpDeaB3BeG.juwjz8V4mK5H4tphkLFibacoinPXH6NWPIGVfp
 IXnEgnrbDWIpM3s0FcB2pgfh_e5iTv2SI1Id7eK14qntcUbbYTOT3yhcpq_6vuOFQS1SkEWV6zGv
 UzFx_D2DPJaoHFAqlmnp_MERhQErmUO02eIoRVsfdA4LCtmMxZg62Mb8HXUPGMZphXzNLZPDuCWc
 9kuV6Q0.NPeOsXSEyglRGDmzWy1PWpTB2fBpUagfTJI17JjpdVqsfVN3liqG9m8i7KOCELO5POgI
 OJVjhQZ8zqi3jYqcKqKd.a9qpsChC21gACnHB8WDHbRzUOnu2ous2tj0mvlRXQnyVqq7ahgvWbVB
 UJUGgQFhOUCcv6Ay8ZMyBWNFtYZbwDldqxrQW7C4Q55MLlcvVm_cLbISPgBcRBuuLA0YOfY0HZWB
 _KMaPWhuJCXfAA1OqYrDCCZUvUwa7SlyRaLNjAXDDZQIt_WnHsVn7e3k4aWibXTeABPwS.2MXET0
 TelgnLRgTxl.PmfNztStpikjzK6DLfD1Bh6zdV5.vGy_vQiqZ7hxXhrvCLxl2_X0pBD8iCxisg0E
 8u3i7WpIyXp_agwZK7UV1OnDdjtHPvpxFg03nO6fmdjct0hbWLfJoFpYrCvX2Jk__Kk30oRd8s96
 0y5YGJF3KQooy624foyiA4DGJ3dJ2P4vxwYGWxPWyxU2oLZ_Nm2_KgZW0.AMzp2t0jlOKpUMgc_F
 ogVxYdGcnsEJQm5bNP.LLenU9UZh1nXEmGhvVVBKJjEh7ySzlleajzI8mRh_4PPEAjQ2g8JkoOWg
 CTnmylDeltBeAWv66LxesGsYrVnuMT0auUDPhtynWl0kiJwUmDB8LQHE99zq25wyfLaggKbOawDT
 qvIK5QGevV4DOMe49RQmCAna.yQmECK5yZrdhZpAaa6D1MdoaLlQ4NjEhK5_wDGtgAFjJRCysWUW
 zDfFHujI2daN6eUpVKmBc_wQ2.Ut0RJOjKc07HXhHQebE6ev7zbUCIbORjw5fY0DF9lNviJGR2sW
 kfw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 16 Dec 2020 22:08:27 +0000
Received: by smtp411.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b0561eb04c317a8b2712f91f841e1bc0;
          Wed, 16 Dec 2020 22:08:10 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch 1/1] config.mak.uname: remove old NonStop compatibility settings
Date:   Wed, 16 Dec 2020 17:07:52 -0500
Message-Id: <20201216220752.6371-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201216220752.6371-1-randall.s.becker@rogers.com>
References: <20201216220752.6371-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The MKDIR_WO_TRAILING_SLASH and NO_SETITIMER options are no longer
needed on the NonStop platforms as both are now supported by the
oldest supported operating system revision.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.mak.uname | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 5b30a9154a..198ab1e58f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -574,10 +574,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MMAP = YesPlease
 	NO_POLL = YesPlease
 	NO_INTPTR_T = UnfortunatelyYes
-	# Bug report 10-120822-4477 submitted to HP NonStop development.
-	MKDIR_WO_TRAILING_SLASH = YesPlease
-	# RFE 10-120912-4693 submitted to HP NonStop development.
-	NO_SETITIMER = UnfortunatelyYes
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
-- 
2.29.2

