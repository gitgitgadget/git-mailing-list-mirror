Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1461F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeGQA4v (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:56:51 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:51890 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGQA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:56:50 -0400
Received: by mail-yw0-f201.google.com with SMTP id v14-v6so9033600ywv.18
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=XfPP60whMlE2PCMkhx5wZqYkrrSb+TsbpNIxUxvU3vY=;
        b=pjNZNG1Dji6uDhhxYqbXMFP7UIRt0gnzrWosEzCc6pSqmlK5q6/uWFw8RZM7sw+sPk
         uy2Dwiy0E2xQcVc55Va6KXVCurOSO9EUylbfUe9G61+rG14M0tEEKRzaMxkMCDia/9+Z
         k8K+wsRJvVQgxIiYspGK1Rjb6q+j8nTGEzfv6YULwDKJZ3HxRgY/Vzj7Y2N2/8pQLQCS
         lbiZOPYODSQcx9G4JEyliRvkGUuVrYEInWTGr+3DayZiNkXrwd1+qJBazxrJHS9ny1J1
         L55ixLH+Xynrg+1Du+D8qiURBlnTEqr6wo7C6aBJlOonG/taGpFaN0yy3GehQPEqfS/5
         Wjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=XfPP60whMlE2PCMkhx5wZqYkrrSb+TsbpNIxUxvU3vY=;
        b=NJAr66lJqcVJZYlhp5uBD4paQ5Xlhh40+bew9uJfvibNTUe56aeGeuAAlTCnp8L4ou
         JKRQ5f2H4psNKafhSlT2pP6XXJDCTK7GWDmZ15BtLT6piyaYqnLm9xbR3gsxl4lBoDiH
         Mw+KSt/apHJo4mQv46V0fguBf+dQHjcBR6/lKgqUfUhtc7ctL497l2HIVS1HXhY+kUXk
         eQAh2W4OIcym4fjZRVUEafkWLYS6lb/Agilfe7YNJaW78xsqnzvaZ2xiPDzGRZDrSQBD
         BHatM26qvT/toBmLJH/FJ0zc3ZOA0jiRE77EnMe2FoH07zFc2KL94TMSL62a5PO9SstI
         Ke1Q==
X-Gm-Message-State: AOUpUlFY0o/kmAusnUa0VVNu1Zwx4ZI0lwvmLTdyJUshsB9PwVZj7uEt
        itoaPTZp56X99U0DsrUMw5cdsoHadEERSUap4Cu/bRux05oDhzq8XpIzuEiMssNNTdEWff7QHRS
        J0PgIkZAFkVnDKCTuzwthFw2L797t+MvD2CnH69eGX2UHFIeDRolMnjrloWdL
X-Google-Smtp-Source: AAOMgpfqvZu9bKZ6DdFnFl6BdS/L3dgLzQZqpPTK77ZM1b3+4L1RE3QofQKty/maafaeORfJQ9KUtt1TH57w
MIME-Version: 1.0
X-Received: by 2002:a0d:da41:: with SMTP id c62-v6mr5532759ywe.98.1531787220652;
 Mon, 16 Jul 2018 17:27:00 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:26:49 -0700
In-Reply-To: <20180717002654.120375-1-sbeller@google.com>
Message-Id: <20180717002654.120375-2-sbeller@google.com>
References: <20180717002654.120375-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 1/6] git-submodule.sh: align error reporting for update
 mode to use path
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other error messages in cmd_update are reporting the submodule based
on its path, so let's do that for invalid update modes, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5f9d9f6ea37..8a611865397 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -627,7 +627,7 @@ cmd_update()
 				must_die_on_failure=yes
 				;;
 			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
 			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
-- 
2.18.0.203.gfac676dfb9-goog

