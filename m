Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF299C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835CE217D9
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rogers.com header.i=@rogers.com header.b="T7C1du4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393160AbgFSQMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:12:17 -0400
Received: from sonic315-16.consmr.mail.bf2.yahoo.com ([74.6.134.126]:38794
        "EHLO sonic315-16.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391238AbgFSPFF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 11:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1592579104; bh=4IfxBnLYu9Gl/21OjIvfxfRqoCOXjJvudQhdhsEmDjs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=T7C1du4cJHuxZqU3XfRM7g3c1gKa3U5ket7rbPcKpq4F2T6zpudliEYlTt+UW55wVFD3RpLP3LroB2nX3leB9E7bVF1ypzGGW+qK6KNtcz3yzS5ZpCNI1Abm/0Wgzqu0rgdRtGFJH5YMgZkMvoJZI89O7SLL8Kge7Z8XFS366tPQC9/+Fp34f6aXbEMLMZQtiCzY9jHMXzrSlOU7PwsafinDp5oQSwuRSG/GZz+P85/8PO6ceRefJn+XlrctOf7QV9btTUaVpXqawp8D9BGaeR/0L1ha14gKjffAiVFvr+zIgbNV5W66bma93/HPp2PKrI575PPhcYQcS2vrlgUexQ==
X-YMail-OSG: SAp9aG8VM1m4tcc.7TltOb7biEq8LVSj8To62ifELBJTpnnCCycYrrLPRr9lD2j
 f2mZMK3rs_QQcbOZ4Xbt_0KtcFf2kfHtUOlkHhZF.qzi2J8NvjqUe4RsYsgqVKd4RIzn1me25po8
 sNd_UEe.af8EQqMBZH1LdEJ62c_gwYpUE9h3hQfYoWN4i56.68oiVe9UZoqOa.MP9iwu_AtbzXKq
 OaOJ1Dyiyr64vpcRv9L1icZ6RwCrWVwnWkuolEBGT4z6UH8DC3lFfg5uJ7MBDtoTzA9OMZXZnhOl
 3AxyufVZfBzmjxzOcy6b7lHXYOE8Q_N_D7z.lKGHu_s4wR0HrQlr78HYO5I9pC3Rg8aeLLfBJ1qx
 8_WASAhyumSWbvdrIHd..e2IT.lzPB5rbsIeyJbh4SPBwHD9FrNb7goJyu7IMqXTqxlL0ROZuqeA
 XwUdpssu6DSg2JsQfHMohmPC7RlK_kGDE6.JPwCzdMwI.g2fZRM1JXh1OS35LoWZdb16H6zzTmRR
 LA5gsmZ7ZqlcmP4S4p9fMImdHPVs0_KgzGk4wpRixuqJ0gIp5FczxMIPn2uzw5XlUVrtOq4adHCp
 LyQvIqwbJcfsKyrL8H0bIrTBwVu9sDEAtSzvz1.PuXp1OVwi2sgfVqlstsJwF0HHfm8PGJvQd.zJ
 REsYbhcczb3S6EqViJ0bWsLdocTsH3pfvPml3EkzGSwYhtpXU1Wdf6C_1v9.dj.6XxM8RjsbMXxr
 X2IkS33KTQg5RhctH9i.EBZ8Xx1WKyF.lHlsCAt0Ke8qb2G1WdyqUD32t2p9IoKTPTZK0U0keOAi
 QVh88OMr6QwDhrtOslnXexI6xhpIX4STD5StMUQ0SrrOzlfXFru2jZzwjUbvGRXq.aDYug5KF9x4
 bKhcr9gbYEF.mIMifU1L2g.9qg1QUp7PTS2k.9YMOzs1duMMtB6hApWnabTOiC0HXmpmM19TtHr.
 DS2p8U_0iLa8bU7AYn3OmFXf5hqr9MnGg3AYgTAOZrIlskLYXQalvrwgi1hnXSKtk15CzKh05U4U
 PkZaQ0fqUKPm3LH2Nzhc07LzwolRUEX_mFA7xwEJeahSn3yQ.GsWrYolsBaQqHH1TkAfEE218A7r
 dA_eVvIYABsqDsoBCI.fsEbw52IcNOQFjdNlnXOMzzwGZHK.wIcgGExmNe216sZuKTk4E_jVvDu8
 YuqTXIRVcINZDJdhfvTj7bqllfWHJwWl6MaE7U89OzpTcf9ACkToo44ZQddIVXpKLh7nluVqq6NA
 gGfav3yRizrw3bnH1RiJQ1xLigtpsZEexNK0y0zB4GfSqP2DQTV_LXFlsIlq8mVU7PYqHBNsmdN6
 2ICTAJSFp52YlcSCYHhjf2Cd8xVKKYZPyapaugVc47qm3dr4B_KljwmWuWVlFjN_EFepSB4z9mpD
 v7t9j.4xijrn7b9WhqFf1Ke8chzAW6vNO6ctSfM2yG7G9D4yyPRp_FeRiV7Xt6ua.vr4DLI40OBJ
 2mqrreWT36AjYudpH8ELYkDMwopPHiX5YPng-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jun 2020 15:05:04 +0000
Received: by smtp414.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a3a454d2fd8d91b05ef2f93e2ccfa888;
          Fri, 19 Jun 2020 15:04:59 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with write_in_full
Date:   Fri, 19 Jun 2020 11:04:43 -0400
Message-Id: <20200619150445.4380-2-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200619150445.4380-1-randall.s.becker@rogers.com>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The strbuf_write_fd method did not provide checks for buffers larger
than MAX_IO_SIZE. Replacing with write_in_full ensures the entire
buffer will always be written to disk or report an error and die.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 bugreport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bugreport.c b/bugreport.c
index aa8a489c35..bc359b7fa8 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -174,7 +174,10 @@ int cmd_main(int argc, const char **argv)
 		die(_("couldn't create a new file at '%s'"), report_path.buf);
 	}
 
-	strbuf_write_fd(&buffer, report);
+	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
+		die(_("couldn't write report contents '%s' to file '%s'"),
+			buffer.buf, report_path.buf);
+	}
 	close(report);
 
 	/*
-- 
2.21.0

