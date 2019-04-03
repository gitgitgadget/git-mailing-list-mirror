Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C3320248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDCLfP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36738 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCLfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so6998554pfn.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RkJkXS0Ch+9mIL4ix59KiJ6ZOaCsTq/O/PJ91VgU4Jk=;
        b=FlvM+FOTjxj6c7sbEuvXLSqHGjwDosoBH2K8z/gF0lPUv6/yghQldFsuKKORAqx1iH
         vLphchBnGXWuYG/XhEBqrGpA9AnGW6D/Bm6lRknNwbKGKdtNSDBAwft2NrdIGbi7Ylrt
         uT6G86LxzbrXzvX82Q/YjmKOyTfHPvDPz2V0YgCutTOqjBzJMiDR2aLNoaclJ5NxIs7L
         cHBOvvtHTeiAjVMoHLgwnBfkZmZZstRx/tbq8O7vM9j2F3BB8x99zf0wxtSPh1xvDL8M
         +nNDf4g2zeJ34uXpee8hUDhvBIebWm7ihQusbI0E/7eKhy59oJXJQ8NDIq27y8pQkPDn
         +81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RkJkXS0Ch+9mIL4ix59KiJ6ZOaCsTq/O/PJ91VgU4Jk=;
        b=ZitkuZuI+J74W9ORs+uEcrmO0U1ovntyBOZmyP80AnNpOobIoYtE5qySxBE9gVXHbu
         geAvCqtgz0GqLSCmjnEnsegreeku1reyjZoaY9bul0ZjxQi9ZGCq2LR0EkQZv6pewcus
         sPAgz5bQI1rZCeX+mLOX15cbyqEunxV+xyGY3T/Uj1JiFr5mwy1bKw1OgrRR7IiRHW0e
         pTSYPCHJrHdUjkhzZwtmqtCg2oTgHE9Mpd3nSmJKkwDHL4ghkajmAfMksGY2jHL2w381
         sEg8lZjpQChou/ygRGPHFm34gKuATejW7R5Rqkl+KGCXwOer3U2Yklv0arp5Lawff9gx
         yA6w==
X-Gm-Message-State: APjAAAUb+eHGPcW9EXoUYLFaP1LIEAEglstfD94SvXwTMWzB/YOGhJmN
        PHdWcMxGuOs6rSpAlOvGT74=
X-Google-Smtp-Source: APXvYqyTASh6he9zNgfADXTIi4C+wmphxI2/MxY8PdWITIckfEiL+Uugm7CNMK8/HwR25rvNQP+WQg==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr8383181pfb.16.1554291314300;
        Wed, 03 Apr 2019 04:35:14 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id z13sm15664017pgc.25.2019.04.03.04.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 01/32] rebase: 'make coccicheck' cleanup
Date:   Wed,  3 Apr 2019 18:34:26 +0700
Message-Id: <20190403113457.20399-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..c064909329 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1592,8 +1592,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				branch_name = options.head_name;
 
 		} else {
-			free(options.head_name);
-			options.head_name = NULL;
+			FREE_AND_NULL(options.head_name);
 			branch_name = "HEAD";
 		}
 		if (get_oid("HEAD", &options.orig_head))
@@ -1793,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * we just fast-forwarded.
 	 */
 	strbuf_reset(&msg);
-	if (!oidcmp(&merge_base, &options.orig_head)) {
+	if (oideq(&merge_base, &options.orig_head)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
-- 
2.21.0.479.g47ac719cd3

