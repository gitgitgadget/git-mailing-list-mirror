Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B5020A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLLU6V (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 15:58:21 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55671 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLU6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 15:58:21 -0500
Received: by mail-qk1-f202.google.com with SMTP id 98so16842762qkp.22
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 12:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yDGTC+UkmjtruQOsm0e3BrvtEtSYEMdEivrN6FDUAkU=;
        b=DzeMmAWrsSPWCnV8q1GnolpmrqlpNy/dH76d5ZKWofL7k2SoBPUIFpp67IZU7DifZx
         3xjRXP7ZAX0PuyFYIOj692XsPZOAYxO4tCoC58tu1F+z66hiCbkAt1g8+kgehS6jIeK5
         kChMSupPfeOF96EJihtp/Dpo4O3a/sa0v5UStGZmqdb74Ibl5dXmLPcrbEAkO7H4zhDr
         0e1czBZk8lBoTtl/4jaPyNSPtzuxS5+ErdiPKIGULLsDa5mG7ycLOvY3YNRxaEpQ95PD
         dfq8tqlOjgSByvHIJiToLQuuBjX1/pTnUPPoGGuzv0Hs/ATVN9eHif5KdzyAjvjcWQg/
         cwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yDGTC+UkmjtruQOsm0e3BrvtEtSYEMdEivrN6FDUAkU=;
        b=QMjQ36vVBXSJ7wbXSEoLjVbgJAyp+Fmy7G+b1nPsNz5IHMv/CjjwbEXALZI6IOblJT
         TFWu/ExEcErFlJYIJx0cjUEKiiB4o2Z6BBfGEv8xpEf70HMXoyHBXlibxR3LMz+8h+I6
         hz7mcQQDLSjEgLWMk6jI645n5jRd/OV67BPrnR6fjjmrSUROoYgrxPcl4CGy8fQjJUgq
         q+Bd2EnTOPyEoFL+youn7ksEhU+JxGVs/PwypN0HC1ViN622zsTv8Nr6Xgn/sJXrEoge
         /dxU0sTqE28qRWLJr9TPWcBSHgzA9MsED0KWi9o6XviO80SEf+0063xrXtMMaw5ZxSim
         iHdw==
X-Gm-Message-State: AA+aEWYxRBTByRznCYR2tbNH8dQ8LwWDPqst/AxuMDOkZMSB0HAke0Y3
        /AcMDJbIFRitkgOEn3FOA3b0H/TGXu1B
X-Google-Smtp-Source: AFSGD/XjKkjzAKZHeneRAc+njZD3Ow6kSmICkMEwrK1QmGxGUvAujdQDYS5C0Nz70y3Ej2nX/mC/G9jPMXYw
X-Received: by 2002:a0c:9e60:: with SMTP id z32mr17011413qve.0.1544648300107;
 Wed, 12 Dec 2018 12:58:20 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:58:12 -0800
In-Reply-To: <20181212202205.170998-1-sbeller@google.com>
Message-Id: <20181212205812.182398-1-sbeller@google.com>
Mime-Version: 1.0
References: <20181212202205.170998-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc2.230.gc28305e538
Subject: [PATCH] submodule: correct documentation for open_submodule
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 99017ffac8 (submodule: use submodule repos for object lookup, 2018-11-13)
was merged, I had not yet addressed all outstanding review comments, such
as adapting the documentation for the function `open_submodule`, which
changed its signature during the development of that series.
Fix the documentation, and annotate setting of `submodule_prefix`
to indicate we're dealing with a submodule repository.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> I'll incorporate these changes once resending.

... only to realize it hit next already, so we'd prefer updates instead
of resending the whole series.

Maybe a patch like this?

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

