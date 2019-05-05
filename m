Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B1E1F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfEEQYl (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:24:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55692 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQYl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:24:41 -0400
Received: by mail-it1-f194.google.com with SMTP id q132so1492033itc.5
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PGGbmUB+G/tIuGZqsfh+tnjADx1mP+6dxKcQVPV44F8=;
        b=NbfuLpW0R08F4oibo/gpsUNmK9jYVDsJjQIQAqQoT4TRrgSECL4Te1GJ3LZBZbO6YL
         K0jX/8NxLUeoJCeu1PvaznkCuxtpTXqAjv7ZSD+S/9nF7YVCsXL5r5QQKlTlJRHpxvgw
         LTFitd+dr+mk2JPgzkxS8i1/Eio0hWuAWLsRPUMS7qTR836WWamYMK0FyFgZoQUX0Hlp
         TvZ0Y21/klL9gOo5GxHsvr52M851luXrWIxY5qkzUAQy4Yo4kq67x+ed6RGQY4g9FGcN
         JbcXKCuBrvtTxnJ6bWRE3KDHsfeC13eXZT3G/G+Oc+ImMommpW+fKV5+LjJ8Sqzmh/+K
         wkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGGbmUB+G/tIuGZqsfh+tnjADx1mP+6dxKcQVPV44F8=;
        b=iDT5sWZnaadOftsh5bsEdPVaZOerV4/hq9Yd7elxrG7+P1ufWgmaeGgqNS0mrWeTQ1
         HtNQ0Guc2YVU2kaAFTPI0Dpvw0aWUHRmPcmvrxaLkuZklMiYaVD+FgkBZAfx8Rn5lDKB
         o1abW046lqH3Pt8wSGuiuzqwel5k96QVThW/W5NAbg5DqI8e6O5dc27IEuVGMP+zSgb4
         4CC1fj6HwzRVt9FKuKmiijznJAkSAvsE25U7qyzFuG5r+giwB3EES/CKcDQbLMGYazTA
         MKWjU5kaMRKF4fL4Qql56lavpESByNiNimvpRSAVB339/t7pdQEtevzCK+8Ofq5iMowb
         fIJA==
X-Gm-Message-State: APjAAAUq0vpjEIO7Kh30Z7OE56edUfJAkh/Xu4nP7QQINtPFQLjEKUwC
        k0e95AAlq2bt5UfQqy84RZlkncLh
X-Google-Smtp-Source: APXvYqwALNpshkyW6VYuEUz0gn8juBwzud49vPMxwlIzLZTSXBJP7HaLehKf9MCON26tN04AUrC+DQ==
X-Received: by 2002:a02:c8da:: with SMTP id q26mr5705343jao.0.1557073480329;
        Sun, 05 May 2019 09:24:40 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id x187sm3826599itb.39.2019.05.05.09.24.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:24:39 -0700 (PDT)
Date:   Sun, 5 May 2019 12:24:36 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/7] branch.c: extract read_branch_config function
Message-ID: <5318dab19abbe2593bd24c6aaff8e6254a39a4e6.1557072929.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll need to use `read_branch_config` as a generic base
for other branch-config reading functions. Extract it from
`read_branch_desc` so that it can be reused later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 branch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 28b81a7e02..4b49976924 100644
--- a/branch.c
+++ b/branch.c
@@ -162,11 +162,11 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	free(tracking.src);
 }
 
-int read_branch_desc(struct strbuf *buf, const char *branch_name)
+static int read_branch_config(struct strbuf *buf, const char *branch_name, const char *key)
 {
 	char *v = NULL;
 	struct strbuf name = STRBUF_INIT;
-	strbuf_addf(&name, "branch.%s.description", branch_name);
+	strbuf_addf(&name, "branch.%s.%s", branch_name, key);
 	if (git_config_get_string(name.buf, &v)) {
 		strbuf_release(&name);
 		return -1;
@@ -177,6 +177,11 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
+int read_branch_desc(struct strbuf *buf, const char *branch_name)
+{
+	return read_branch_config(buf, branch_name, "description");
+}
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
-- 
2.21.0.1049.geb646f7864

