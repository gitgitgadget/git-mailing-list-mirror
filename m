Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969151F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeDPWRB (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:17:01 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:32998 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDPWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:16:58 -0400
Received: by mail-yw0-f193.google.com with SMTP id q12so7200127ywj.0
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LaI6kPJZTlZp4rR0VTKK+fjvDfokJszRSlHYixhHFBc=;
        b=m4J1WGbVdYrDwhbsaWGnY2XMcp8wMNbFP111z/3ip2Ek565FElnHNDn6Zr3UamqFjq
         ABeuplyCCfz4YnPhi5+gA8E18lZ1covbwtDB70+xxjnkx0zMx6sKCBiwleQ3nkSrLmX8
         9A4QY8JJbr/Ot1MI2wY0chyq8huZ2hLoVhu/xlRSoZXzjckRYqoJuuWFcqT6XZXD4V4I
         +C3KyBuXpEDZm7e3AsE1+v0lrPliuLQRPMlBStjR+XeoQy+VcZnEI8MoafU5zDsY/lYb
         ta4TCH3zkol1iiDg2I2vvc1C9xAqzsQM8euQYV8r2E9YxYxfdOJANcQbTpMCiyaR9y9e
         PGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LaI6kPJZTlZp4rR0VTKK+fjvDfokJszRSlHYixhHFBc=;
        b=P0Tu96ID8DMVJnyUT9qlJths8XrNuSVK7j0zc1ceGeHLguvN9H7wtAvzYO3YT5W0+n
         A+BHynYCTeAvujeHll3x9TUQNPJr7k5rVSfMwyVCqsOO+WZvqxiqokhn0jQLMQkUU7/m
         SV2QadlJVhBg0XbbpdHO4/bJqyMFN7gf/F6EVmnumz19ggN9l4xUtp6S2kCDh4jGf4cz
         Hu7iflEmUj7FCpMWgdiHfvINMsVPekLNrBe503QNRfoW5VeWg9qSLdLiGOBsAklDczK+
         uPd/y4s4623ubIuC+lIRjIdP1y5rnZZWHNLJsxxDkBWYd0gu0lcfBaFeroMEF+fYU5pY
         tsKA==
X-Gm-Message-State: ALQs6tCM0ljjMOXxnZxPhhJG29EaCDFiddmYlItwwRBfbu70wQadGR9n
        zKdkM/J+vhTGNOuBo3MgL70Ir9mlocU=
X-Google-Smtp-Source: AIpwx4+y1nx9GzKBt+2jtg5juyAStzuHW8Z9IydqtuR5mMdLZ/ukhOjlH1Aud1KC4qyVhYajW+o21A==
X-Received: by 10.129.72.65 with SMTP id v62mr9139817ywa.375.1523917017579;
        Mon, 16 Apr 2018 15:16:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x5sm2541885ywf.107.2018.04.16.15.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 15:16:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] worktree: accept -f as short for --force for removal
Date:   Mon, 16 Apr 2018 15:16:54 -0700
Message-Id: <20180416221654.49454-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The force flag is very common in many commands and is commonly
abbreviated with '-f', so add that to worktree removal, too

Signed-off-by: Stefan Beller <sbeller@google.com>
---

As a side note:

 $ git worktree add ../test HEAD^
 $ cd ../test
 $ make
 $ git worktree remove test
 fatal: working trees containing submodules cannot be moved or removed
 
 (This is on git.git, which does have submodules, but they should not 
 be relevant here? Instead we rather want to point out files left over.
 Not sure. I also plan on having worktrees and submodules to work well
 together eventually)


 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 40a438ed6c..d734874d58 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -783,7 +783,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 {
 	int force = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "force", &force,
+		OPT_BOOL('f', "force", &force,
 			 N_("force removing even if the worktree is dirty")),
 		OPT_END()
 	};
-- 
2.17.0.484.g0c8726318c-goog

