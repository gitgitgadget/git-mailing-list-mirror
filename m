Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFCC55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3B5206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlKQxCOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgKJVVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbgKJVVt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:49 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84FC0613D3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:49 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id g4so1607151oom.9
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NX/DLewIinm9wuQBVdPcQG+miDz8MXllUkcbopJ+4SU=;
        b=qlKQxCOOI1spy3jmIOgnJsX39QsEgSnaTBgZE2KuQesB4oQj5PNfwd/ykCBa7JILjO
         jCaDdHqQzUhhC6Qp6+8XczIZWWIIBOdcN+gd0zryr3aeMp1bDJV4wIsboVWFs8EfAzOo
         YmTd60GqlKe1Kw+6P6Jl/7rVNPgzUi6QT+pAkcuKUgauAnt7dp3j90THspu8BLT+f535
         oJjLjGH1WwEuo5+I6d6THfeqgAnuSJ5kQwgaqrQzfjFUG6yzCHqqQZgXSgnyL6ze21uS
         2nxuFVA5qZVT9VjfHVRcMmkQZlb6Fu3jgqqtSwewN+NqVvg+k0eED0buLcUEJqONLhCZ
         rN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NX/DLewIinm9wuQBVdPcQG+miDz8MXllUkcbopJ+4SU=;
        b=ZpK2xcrnCIbmoVWMw6wOgK7UrJnW4KFf9nmKAoep2TaJVlQ8Ps2V2GwzSitceW5oWH
         Rc78IOH60n80ZJdCE+2ihxGqhyiQv5Imu2UrAG7Ctmd+oYD1T69nzWFhvlMGOfUxcgFU
         cf5c5/BUpC0BeXlg1qyy4TcPOSfvxa3OstuYAgLkxnIgu2WssXFScOjcjVK4Lkg5tTHZ
         aBZUIETZNRtgu/0+WwAETboFt9GsBl4LM/tqPEHFa9oIQHC/X3Dz3oOwk9ayTzvV/nVQ
         wTPvcLFS7EgfnXWL4u1u2sYBq3cHN8MC4uWtHwuonaHfbj0LfvYIzPSF6m1VmhJcBDnc
         U2+g==
X-Gm-Message-State: AOAM530dWTgS3AAfH6JNBfuEaKdjbPB7MgoWwJSdMy2O4dSDwfA30ZcO
        mAXEnbqZ4VakZaK49r7aSnmbaFOPyqsX6A==
X-Google-Smtp-Source: ABdhPJxFPWdEjAvbTXtEHZmEf6ZfzLpQWpaZkco3t3hdhDIQglT4xxaxNr68zzVw6MZ4vh3B4PmvmA==
X-Received: by 2002:a4a:ddd7:: with SMTP id i23mr4180451oov.73.1605043308596;
        Tue, 10 Nov 2020 13:21:48 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y8sm20220ota.64.2020.11.10.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:48 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/26] completion: bash: do not modify COMP_WORDBREAKS
Date:   Tue, 10 Nov 2020 15:21:14 -0600
Message-Id: <20201110212136.870769-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was no need for this once __git_reassemble_comp_words_by_ref() was
introduced. Now irrespective of the value of COMP_WORDBREAKS, words are
always joined together.

By default COMP_WORDBREAKS does contain a colon, and if it doesn't
somebody probably has a reason for it.

Completions are not supposed to modify COMP_WORDBREAKS and none of the
completions in the bash-completion project do.

We manually set it in Zsh so the Bash script is not confused.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 -----
 contrib/completion/git-completion.zsh  | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5b2dff150d..12275a3558 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,11 +45,6 @@
 #     When set to "1" suggest all options, including options which are
 #     typically hidden (e.g. '--allow-empty' for 'git commit').
 
-case "$COMP_WORDBREAKS" in
-*:*) : great ;;
-*)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-esac
-
 # Discovers the path to the git repository taking any '--git-dir=<path>' and
 # '-C <path>' options into account and stores it in the $__git_repo_path
 # variable.
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e0fda27f4c..fa7f88bbb3 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -45,6 +45,7 @@ fi
 
 local old_complete="$functions[complete]"
 functions[complete]=:
+COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
-- 
2.29.2

