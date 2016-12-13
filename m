Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C955F1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 08:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932700AbcLMIt3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 03:49:29 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33784 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932305AbcLMIt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 03:49:26 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so3863200pgd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZyQvnDzB97O6c0QAnBCiQDlxyNyuw0D/fVFafA96cWs=;
        b=FURi8VqQVxzpz+LwABfwLFeUhtkh1PHO9h6wydzS289DYj96ahGBX2TvZOjlj70ibM
         NoRPcauGmcACdn33CSBhSnwpI/oZNOWCkZhjV8+P7sOa2aKvhEB/kv0yl93tNRkoR+N3
         oBVvA4NPUprzdEuDXQSt+HcP/hcvcgPuh4nghKo13qU1T9R95+zdaELVH9Joqd5Vcei4
         JpU4YtC8X50ij7AlpheZBTxcDu+7HnhZdrUBfqQy2AS8jnffwKrdXvxjZoQJOiyJAw84
         wNQEUVWXomm6XxsTNBCOYu+5n7+NLMUZiNEWQb2p26A+uYMiu6a/sTNOhmFPicUREwYe
         hgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZyQvnDzB97O6c0QAnBCiQDlxyNyuw0D/fVFafA96cWs=;
        b=iGcT9h43oNkrHsZLDk4TUTsKmuSis7C9Yp2VHw2L00sQQBoGiBjO3k4RbZ8sj/McyT
         cCGnFmlkXcCTcM2oWdV5vQ1M6HzmI76WvQ7lpzCQcojFZQX/yH2F/YISQxJ5m8qYdU1Z
         KMB1+gW3NBkxSp684YbsJBIIWLqJL+HSfHvVS+XBSBSCcffiViTNBKgpdYsRJulCCK47
         jcQQ72cXQOELNvoz1tC24r7C6Pqk8OeyOgSTOUB7RNkMzpA0GJNoCqaU3RrUeGwItkXu
         d8VvmAVbaRzWSMop4MR06wiFF/mtbUfDHTNw2YWiTBZwFob3jxoqAEuboUxjNjbOKYSk
         wDmg==
X-Gm-Message-State: AKaTC02ay4I6jRMouvRv/Bq43HCgcuTPGX2R/3/UyR/2TjLhmOKvbRbwmnsu0K5TSj93Eg==
X-Received: by 10.99.211.21 with SMTP id b21mr129701710pgg.120.1481618960889;
        Tue, 13 Dec 2016 00:49:20 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:7966:ce03:97ae:8cb])
        by smtp.gmail.com with ESMTPSA id m5sm79839976pgn.42.2016.12.13.00.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 00:49:20 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     mah@jump-ing.de, peff@peff.net, jacob.keller@gmail.com,
        gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv2 2/2] completion: add --continue option for merge
Date:   Tue, 13 Dec 2016 21:48:59 +1300
Message-Id: <20161213084859.13426-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
In-Reply-To: <20161213084859.13426-1-judge.packham@gmail.com>
References: <20161212083413.7334-1-judge.packham@gmail.com>
 <20161213084859.13426-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'git merge --continue' option when completing.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

Notes:
    Changes in v2:
    - new.

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8d..1f97ffae1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1552,7 +1552,7 @@ _git_merge ()
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options
-			--rerere-autoupdate --no-rerere-autoupdate --abort"
+			--rerere-autoupdate --no-rerere-autoupdate --abort --continue"
 		return
 	esac
 	__gitcomp_nl "$(__git_refs)"
-- 
2.11.0.24.ge6920cf

