Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98CB1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 18:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGLS4s (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 14:56:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44021 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLS4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 14:56:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so5164820plb.10
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zura9PrVdDlGac8hkipNaf2hnyqPugUl+ruEkJe50Uw=;
        b=aJjVvccjOTs79njRXL2Ypu54tn+LF9uzr2rWbcu96OsrUYh37Iuw8mi72oMdCZ1I4i
         iBrTpY1DD/W3Tpoxd/pquXA/Nh38BxLFgCIQNoQDfgtQXE1jPZ94hfCedGwuieGUh49V
         zkXjkfImb7kKoC/hCA17y41lq6IL6BUO91f1RTv4UaAwvIwH46tEdYiBor1EZFs0i98M
         2ANLA7pMjsjhlEY5kvGlvjhm/+jXWLR74hJQoSHsaZN9MuwXmNcmQhSBfBPARXJutuSv
         Ri8tesX4BnHSzJaLarNKdZcnS3/VZbKEV0Mr14ZwaacbGM4xz5n7V6y+55gPrmpyVTgl
         5qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zura9PrVdDlGac8hkipNaf2hnyqPugUl+ruEkJe50Uw=;
        b=MIOZ5SMdaQobc9Xc4aI8o+XrfM0vIFtwdTmGApBzJ6cj5VdG3QH8sYdbdTT0Y71oml
         F5qMTHt38Ilik2IwrDvtBnMj/zOaokHQz5zTjtfpRBkpzFnAgTXq56q0cMuMFPNawTZV
         VTYUVt06tCO3FEPqCBjfo7GR19gGqnmgIN6RAlT5FpfSySTC9nfoMVrgKkZUq5+aa60X
         zw4rHnZmXj0zKT/CzOs1Bdf5N02DvMm/vT7CvPxZKRLJKSZIXj1xSEeBRsY8wFcdGZhJ
         LWW0r5OUKJgkJedEr9hK3ObaaKGgOcg6e2cd/XYehle2WjfFa2kgzIWlguxbXmxh5xyf
         3uNA==
X-Gm-Message-State: APjAAAVByAbhx4hGvc+FE2CtBSPcdg0wgJaI9E6ZL3rQILCNvl0zO2Hj
        ydIXDGFNaWX8Q1Y00O+CJOS4kAjkkX4=
X-Google-Smtp-Source: APXvYqxv0Gw4iHbBtP8dudmgULA0qPQbe4NmiRNB/rtZOxnGRHb/F2xxaRAGSFARfGWK2CxCjnwRgg==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr13534291plg.284.1562957806282;
        Fri, 12 Jul 2019 11:56:46 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id m11sm1431207pgl.8.2019.07.12.11.56.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 11:56:45 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     phillip.wood123@gmail.com, martin.agren@gmail.com,
        Johannes.Schindelin@gmx.de, newren@gmail.com, t.gummerer@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 1/2] sequencer: add NULL checks under read_author_script
Date:   Sat, 13 Jul 2019 00:23:56 +0530
Message-Id: <20190712185357.21211-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_author_script reads name, email and author date from the author
script. However, it does not check if the arguments are NULL. Adding
NULL checks will allow us to selectively get the required value, for
example:

    char *date;
    if (read_author_script(_path_, NULL, NULL, &date, _int_))
	    die(_("failed to read author date"));
    /* needs to be free()'d */
    return date;

Add NULL checks for better control over the information retrieved.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb1..a2d7b0925 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -821,9 +821,19 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		error(_("missing 'GIT_AUTHOR_DATE'"));
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-	*name = kv.items[name_i].util;
-	*email = kv.items[email_i].util;
-	*date = kv.items[date_i].util;
+
+	if (name)
+		*name = kv.items[name_i].util;
+	else
+		free(kv.items[name_i].util);
+	if (email)
+		*email = kv.items[email_i].util;
+	else
+		free(kv.items[email_i].util);
+	if (date)
+		*date = kv.items[date_i].util;
+	else
+		free(kv.items[date_i].util);
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
-- 
2.21.0

