Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB5520A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 20:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeLLUWJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 15:22:09 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42351 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeLLUWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 15:22:09 -0500
Received: by mail-pl1-f201.google.com with SMTP id p3so13621117plk.9
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 12:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r7rWdrEDuwvvAi5bjzfk1dqGyjb05AJ8rt3kPuk9eMI=;
        b=OjBv+jN3blpp9Ce/RGapYzbFD5D7P8ProeCgLdZjuCgpKqvnDmeQ0II8r6SEZsZjJh
         6Sz4p1s7R4R9mo/jFyTJTAKYI7UN8HcKXj4PZ3La/npliFWECB4TO00X6j9DC5xaSfBr
         am569guafKz/RZjXC/rH9JTX8RskxdKJsdibU2cdE8n2pbyewFXoy0/X3pkI13auDz5R
         lw94A2WJviufytReAsywqa+L4w1orSmxMjGkkTTRB25Lz0eQe5M2MPLQGijSD5SwdakR
         y8X5jmxV7p8urMxTcxwFritw+7PfRkE1WFZMAn7Ql7pDaFYoGVRniS4tS22hZwF9+ppw
         y2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r7rWdrEDuwvvAi5bjzfk1dqGyjb05AJ8rt3kPuk9eMI=;
        b=k8YdfI3rj+kiD6C/esF0BRZnH3wLguJsq1mi9xQtT+eKeJWBr59SsTQpuYiGtPWIDt
         +3qy9ZxvD/HGedEud3WRAfqJtLCexYbcazjqTwmKl4Df/9QenPFEKqWKus9gjKh9HNOx
         ramA0SVr65W1ZFDHYQooXWHa1wJgSMbdPXdhHjeFPYVkJZHa0amEQAp0IpazbPbUNNSN
         LNMqx7QC+UgzeAXHMABBGER6bc+l3yr/K7ulqYxlYGooFriH/WdEuPLp0AjFKnA7vlxN
         YThnPelbYaB6Z6acwaKrYZpBfusqBp337znH3Yljr/xFHkNue04kM6fammKSdQfg82fH
         WEXw==
X-Gm-Message-State: AA+aEWY8cyrpsHPj3BTafK+avfIllQjDu1KZpMoVnpkBCkHXtw8HPlS9
        y8sUaHMUCyOPr1c/cIWgQvzGRnpUiR63
X-Google-Smtp-Source: AFSGD/UrqcoT7W5QAEoMW0iGUpTvmp8JrPVG/PvnnXmQnxc7T+HNh2a9+ARmhMEDfd70/EjQKiN90H7ybC0n
X-Received: by 2002:a62:e419:: with SMTP id r25mr10822547pfh.33.1544646128963;
 Wed, 12 Dec 2018 12:22:08 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:22:05 -0800
In-Reply-To: <CAGZ79kZ72eQPiQ_KW1QkiRqMFUAUpCQCHZdk3RSMVK7TGPE2aw@mail.gmail.com>
Message-Id: <20181212202205.170998-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kZ72eQPiQ_KW1QkiRqMFUAUpCQCHZdk3RSMVK7TGPE2aw@mail.gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.230.gc28305e538
Subject: Re: [PATCH 18/23] submodule: use submodule repos for object lookup
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

On Thu, Nov 15, 2018 at 11:54 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> Other than that, this patch looks good.

I'll incorporate these changes once resending.

Stefan


 submodule.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 262f03f118..4486ff664b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -483,12 +483,13 @@ void prepare_submodule_repo_env(struct argv_array *out)
 }
 
 /*
- * Initialize 'out' based on the provided submodule path.
+ * Initialize a repository struct for a submodule based on the provided 'path'.
  *
  * Unlike repo_submodule_init, this tolerates submodules not present
  * in .gitmodules. This function exists only to preserve historical behavior,
  *
- * Returns 0 on success, -1 when the submodule is not present.
+ * Returns the repository struct on success,
+ * NULL when the submodule is not present.
  */
 static struct repository *open_submodule(const char *path)
 {
@@ -501,6 +502,7 @@ static struct repository *open_submodule(const char *path)
 		return NULL;
 	}
 
+	/* Mark it as a submodule */
 	out->submodule_prefix = xstrdup(path);
 
 	strbuf_release(&sb);
-- 
2.20.0.rc2.230.gc28305e538

