Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B6C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B936220890
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rogers.com header.i=@rogers.com header.b="Ux8QzaAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392049AbgFSUXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:23:42 -0400
Received: from sonic311-19.consmr.mail.bf2.yahoo.com ([74.6.131.193]:36494
        "EHLO sonic311-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391809AbgFSUXk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 16:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1592598219; bh=v3IyZAxmMC7FyOpAfrXilkZ5nd0THSrVlOHbwxPN0Rs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ux8QzaAyysKB3JP3rPO94tociDHPN/2QF5v1trIqWnHvbkoK2tupES/9vGyKLNgQ38IgN++FIFIZb3TpraoRVjiO0EDPYQCWYsmxyH/sXLhta8KIspEk6kxaZ85vX77f5Ex73aTylWyD30RU+YP9/S6rD9JqGOtPg3dKTpsn7sXdgmMwrF9xawNImwG2OpV5F+f1I+UKfGpo7cO4cgmbjblAxV5OIOGhcw+7QJPbPb1rTF3Om9r5EZ0+zGDd5bvvbsU7qbQ+xn6Xv0qbKOxaTaUKRfzZ6XDPQZkREgBW6+rjsdeOwb6WqiRiR2JKM6VJgkwMePafB70Lp9A6F3x3ZQ==
X-YMail-OSG: j1ANJMQVM1mEgV8lcSslagBOZepsjMxQLHiwBmHTUhyV2gJlgk.Y3DnrgRMo05t
 3eG3JifFVjug5iTNfv528W0yiHlsxtnAkupA7I5WuIO9aD44PhkxnvRESBqNwFXaYg16GUnQZgzN
 Y0.RuS249SHyI5sp8Xesz9gG7rjBB1_30sraEXRq68AzwtUzlur.rAW6Pl0IKr6QHBI5X_t6x_FU
 Qy3fIeT22xklYPym2rPoUh0GQAFAPXn8gvjLm7PBKRf8PBpJtJ4NjnN6yOTit9AC2zVYH.ERPBaa
 AKrckrZUuTYE8j7wPAuMeqDR5AvkhpvJWJEftOgzbYrmTC0io0Ux1wCALU7xJYIhzEDwCdfuSPFf
 T6GBYAYBQKS6T9INOozHnDWUuyCN4r4NwJ_Y15S1eP4e4IcIGI7o_zLtbU49grO.lKsqH_eAJVCm
 MRhyVXZgLXV6cM3fWsA6JX35.zsK18XV_dr37gAojK_6Gb7ishpgC1ASVu4nV4ALslBmJFG8AvHc
 snacv3_apUo2TiUQTkLA_ctVeSGVlsL8t7105evS0geb13mu606aU2FkEO5UNSRdp7B4stuKhMSF
 w1jYE.fh.Nvq38gHwH4ARx47vpB7vsBag33S6YF3bGMr_UagjobGNyo8BQ2NJHq3XizCVWnaEV8j
 kGD7_pHwghEGg3cIQi6syxurBzdVt1oaw_vkwWNyuiirzVMNY1JbqlBHKgwxBBFeZ.jja_2E0JyJ
 nNfEpQaegI7TZFnpnDOi4tkuTYQpbNJ61Vaeq93XI0QSbF7yN.Kt4c5HkYJ5w.WezqDH35uyev1l
 zcANfhx8ypYwvc19jHngYNUSnDCoY.LGbo.3jbPFXOPFuSy4zIV6_KxS.9s52n5X0KoX7ULvO31a
 W8kb2z8CibKjhrlXuZyU038HuLIeA_z0XFpWJlD9LXwEArEL7Tx.cww5f0CGb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jun 2020 20:23:39 +0000
Received: by smtp409.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f9cdc319e6c5c02f6098bff69147f340;
          Fri, 19 Jun 2020 20:23:35 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [Patch v2 1/2] bugreport.c: replace strbuf_write_fd with write_in_full
Date:   Fri, 19 Jun 2020 16:23:19 -0400
Message-Id: <20200619202320.4619-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200619202320.4619-1-randall.s.becker@rogers.com>
References: <20200619202320.4619-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

The strbuf_write_fd method did not provide checks for buffers larger
than MAX_IO_SIZE. Replacing with write_in_full ensures the entire
buffer will always be written to disk or report an error and die.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 bugreport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bugreport.c b/bugreport.c
index aa8a489c35..1aefa4c6bc 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -174,7 +174,9 @@ int cmd_main(int argc, const char **argv)
 		die(_("couldn't create a new file at '%s'"), report_path.buf);
 	}
 
-	strbuf_write_fd(&buffer, report);
+	if (write_in_full(report, buffer.buf, buffer.len) < 0)
+		die_errno(_("unable to write to %s"), report_path.buf);
+
 	close(report);
 
 	/*
-- 
2.21.0

