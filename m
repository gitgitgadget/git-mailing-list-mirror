Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DBDA1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdBCCts (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36362 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbdBCCtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1169062wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=chhFsLMGF0Hf2w8L2JNiqd/dLGxecaa+6GJZiY70HVo=;
        b=gBlWsS1Y78TQ/euvLhY7qeLfC6sW3TVc6XThjgXJDI/kUzoulEZ0uZ8O6d0cG11SwP
         CDP/2UUyQgXSQ6408Pi8eEKooEDGtJy9l3nfTozfpzw47Q6GplOla/cpbZRio3hEZYhi
         R6PCELtfqAG7nBGZmQACsHZOGE6U7BX1yjJB6I0M8d2qpsNIfcMqBJtbc6uoXugWtYKx
         8d+mH7lP15acQ7UKPW54NbsEHMpLb6p4s0pg8swiRm3MHNPyn7YwcEkjCqog7H+4Y1s0
         VDIpmqG3U5gMpG8bj38TNXJdEO+5OD4XvyHnjY/H7Hvy1HvjWhfMBkqDuFG7du355IuV
         Hclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chhFsLMGF0Hf2w8L2JNiqd/dLGxecaa+6GJZiY70HVo=;
        b=XtwbWLL4UQCU7k6CsKu9sK1Z3gMDz4YLOaeB2aoDv/BnYKK2liIb0nCQPl50gGDDtT
         PV2r1BdRIhDqauAm3de7h6EldezRH0AbijETsdh0Mq1zsyRZEjzJVIj9rTFpCZ/5q9ef
         eLg+Pzx/LMQtwaZqWdpx3Kd3FoCjiiYNqTI0kyKQ5hZLdpRSk20450Yb6SywTD1TKhY5
         uh1Uvr7JUA9kOt12V9zQpQBQEeoo0cwZjFkERxbFjrMRjhqzG23NdGssGbXpe8Bxegom
         nuHAhc5mijw69enpZ7yKvAyyjXeAJutIX6pZAE2wK3Eu526b65Aqul+3yuYe0B31mRWb
         kM6g==
X-Gm-Message-State: AIkVDXLdtdQAD8NDQ4yA1KFZuQLu+9eSpLKIKgmp8PfgsdOGI7fhMXQnOY82sQygnmll5g==
X-Received: by 10.223.138.220 with SMTP id z28mr10041709wrz.26.1486090165309;
        Thu, 02 Feb 2017 18:49:25 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:24 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 13/21] completion: don't offer commands when 'git --opt' needs an argument
Date:   Fri,  3 Feb 2017 03:48:21 +0100
Message-Id: <20170203024829.8071-14-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main git options '--git-dir', '-c', '-C', '--worktree' and
'--namespace' require an argument, but attempting completion right
after them lists git commands.

Don't offer anything right after these options, thus let Bash fall
back to filename completion, because

  - the three options '--git-dir', '-C' and '--worktree' do actually
    require a path argument, and

  - we don't complete the required argument of '-c' and '--namespace',
    and in that case the "standard" behavior of our completion script
    is to not offer anything, but fall back to filename completion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4ded44977..7d25b33b8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2808,6 +2808,17 @@ __git_main ()
 	done
 
 	if [ -z "$command" ]; then
+		case "$prev" in
+		--git-dir|-C|--work-tree)
+			# these need a path argument, let's fall back to
+			# Bash filename completion
+			return
+			;;
+		-c|--namespace)
+			# we don't support completing these options' arguments
+			return
+			;;
+		esac
 		case "$cur" in
 		--*)   __gitcomp "
 			--paginate
-- 
2.11.0.555.g967c1bcb3

