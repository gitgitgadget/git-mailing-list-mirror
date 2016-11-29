Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30521FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbcK2Qam (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 11:30:42 -0500
Received: from mout.web.de ([212.227.17.12]:52660 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbcK2Qak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 11:30:40 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpZD-1cFNwc32dL-00WoBp; Tue, 29
 Nov 2016 17:30:25 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, eevee.reply@veekun.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] convert:  git cherry-pick -Xrenormalize did not work
Date:   Tue, 29 Nov 2016 17:30:23 +0100
Message-Id: <20161129163023.23403-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:a6N7Drc2oNO8yXsXHCtyd9+UNsyP1mQARGfugK1YQice5JOFtWK
 x/kXUyPjek9sCZsUdGgIHVgbcukWvvTT+YXueDQbuZDDpcS78zwzWZqM3+UC4SrvQyTl5ud
 hLW/iAEnKI0GwlVjAjjlNwm8RBbS/scb7nMuo7dtVPU4VAHbAWL8fcp7LrKLy+mUS+ubHIK
 YRCZv2we1Y4CCt3Gfsl6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CZUokrtUJ2s=:rJOWD8wSKK+NoQ/4cmPLqX
 MEzTW1y68LgyFVn8KFSqs2CnYD+u5s6TVP9EFt2LZ0kt8wSJNq1bnCAXa1O7Mf6ejB13sF4OA
 yEsmwUDFAfix8ZlNfYNlh/+uDNEl+chCZWOAmBD9MIEcmv+pXtlhGVDCXsgbfU0j/MwygIgUh
 R1ZcrMy0cbxr4ed/rBvJJvG+EKatiYAZ44Nf0MTKPMf8eS08E5PlUVDZqZIwFR+WdIvtF2EbT
 KK8wpkpqQB8r5iwEqq4tZbYjrzyNy2n+cEd82ywFUVxUXjiMZ9gCtiuQRtOh2ExfH8UHhpXTF
 oZm3J1q48jzBYjN6qPUCGQiQrfu0E22M7GeBhmhk3Fgf9o5XUs8v7vrHzY9l92EGZpL6l9MYg
 UNQAntNU5QFB5hXhUOWR5wSLt2QliOwADge0pOWY8Gi2M9Icutry80m+MEfpOEfCZYsMJhEyc
 x+iggGHKcvWXXdec//jFVZgEwXRR81SgcaRiRhL1USDs3vIgOSfcp/SzsyZVK4cvtCJYoHd9H
 1QkWgbZNnJ+o1VfxoH5xnk+J+FVP5y9khJBrSEp0uAVhb6sPjszPaUwOk/tLiCfAh21X/6xoy
 a2ZtCqxoUkNDEikoB6s6qczSbdegqc/wZ0sgHruQDd9dmRsae1bYAEoTKdCghs0wYLOYZAICM
 o0hdx3uz+GhwbpgNZzfM+lXJq2pqKPt1/y3GKwYqvNtyDJ/4ojj9yJINEX9KzR04xa2QwGssS
 VvNg6RoequqA6dOrKeDzlz0WlKz43fDuSy9LlIYT838ZhaKBpeJVclcT9YK8Ne0vouptTHC5J
 YBdSPpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Working with a repo that used to be all CRLF. At some point it
was changed to all LF, with `text=auto` in .gitattributes.
Trying to cherry-pick a commit from before the switchover fails:

$ git cherry-pick -Xrenormalize <commit>
    fatal: CRLF would be replaced by LF in [path]

Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
SAFE_CRLF_RENORMALIZE must be turned into CRLF_SAFE_FALSE.

Reported-by: Eevee (Lexy Munroe) <eevee@veekun.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

Thanks for reporting.
Here is a less invasive patch.
Please let me know, if the patch is OK for you
(email address, does it work..)

 convert.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index be91358..526ec1d 100644
--- a/convert.c
+++ b/convert.c
@@ -286,7 +286,9 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			checksafe = SAFE_CRLF_FALSE;
 		else if (has_cr_in_index(path))
 			convert_crlf_into_lf = 0;
-	}
+	} else if (checksafe == SAFE_CRLF_RENORMALIZE)
+		checksafe = SAFE_CRLF_FALSE;
+
 	if (checksafe && len) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
-- 
2.10.0

