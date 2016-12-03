Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F5A203EA
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbcLCAbO (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:14 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36313 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756625AbcLCAaw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:52 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so112440917pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwDfDN37pJVdG3qhjifipU89DIUbMU3xjZtAdt3uWiE=;
        b=C8fGHeFKY4geYLmxBa+6peq5QzoZZ8nRYVWCq5n7jyCCxChjNzSAf1cWrYcLxRpGe8
         9hePUqeU/rZvMpmP1AcseIst5sZB6FMs1hfk6koQS7GOd2nmjz85Fdrf0fj057f7lteH
         xAJVHO7yS1y/OQL4LccG2xYpIDZxHqicOp97SqB/RUChH0kQX92aOg7sA9BujhowAiRH
         vy7QTtKhMSR+pBFybTgMJ5lKL4FPV2tDkad4RB2x1wY/cAhpugnhDc4s+OqV+rw06cY4
         MQeaX2gAHenHoWIl5lIr0l5Rirny5N+VLqM0lZ6GBGQdVW1a5ZOA+vKIVMHd/4ceuudJ
         pR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwDfDN37pJVdG3qhjifipU89DIUbMU3xjZtAdt3uWiE=;
        b=T5U8rGP5JeulAyJDZ56U4wWVw+EyBVgLn7t14ZO1ik4xvOpq7oD7XxVM8SHaAmlj+o
         3mAUQPmxWXDHCQV6FDnOA2Y1L4vkPuI9o2O+KZftZwn3VljY8kucQggVcQeMSslYeiv0
         KrGQLlYZpNibT4soPNiZ0JqJxNLVxfUlUYHz54G2cdLCPi64Ks4GE3P1mCaCF9IkoEZy
         Xn8wI+Obw0sWFf+vq0Htvejlq0LS1WEzlS5Op+HN6vkOHs5QO47jTshrekZ4ZdMlPPL9
         RjPSEaMBZNSbM4TG5Mh/qY92yD2Y1vV7QPm26ER/4Ide9uAdGLwXPPvMIflI3FHMHYwo
         RCKQ==
X-Gm-Message-State: AKaTC00JaGZWIOl8tKzH6dDtH7Lma+0Z5uUBtZLVOeBxGVQUVATnL2LmdtpDm4SooCPpxN56
X-Received: by 10.99.8.133 with SMTP id 127mr84659791pgi.76.1480725051718;
        Fri, 02 Dec 2016 16:30:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id i124sm10308692pgd.15.2016.12.02.16.30.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 16/17] completion: add '--recurse-submodules' to checkout
Date:   Fri,  2 Dec 2016 16:30:21 -0800
Message-Id: <20161203003022.29797-17-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/completion/git-completion.bash | 2 +-
 t/t9902-completion.sh                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8df..28acfdb377 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1068,7 +1068,7 @@ _git_checkout ()
 	--*)
 		__gitcomp "
 			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --orphan --patch
+			--conflict= --orphan --patch --recurse-submodules
 			"
 		;;
 	*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2ba62fbc17..d2d1102a3d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -447,6 +447,7 @@ test_expect_success 'double dash "git checkout"' '
 	--conflict=
 	--orphan Z
 	--patch Z
+	--recurse-submodules Z
 	EOF
 '
 
-- 
2.11.0.rc2.28.g2673dad

