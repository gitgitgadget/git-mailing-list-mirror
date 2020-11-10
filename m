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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F88DC55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF50D20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLbrNtLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgKJVVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJVVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:43 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14243C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:43 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id y3so3314346ooq.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDjeYERVmZBgLAnqXkqNSn+x8uE0/N1xNl0tBZNq1xk=;
        b=iLbrNtLkqI+wgB763M4/J4FCaHtC+i1M52eV30El1bVh46BHhsiKEY/TUUXpMNLwin
         ufarD8ptHkG6SesRJ6ThhXXUGRmwu6BtZizy89TV1SFyfwi/3Prlp1Wy7baD5ZUP1/uc
         3Ds3AB3n4rHJPnlgqzqPN8xKkHKLxkIZXsxOvS5JveMiQDL0cJLVEP8N4OLUesAS44lm
         jZm2YnOHu/ys4WPeFXM9kp1uU46asqKDtKhnnRnX8Xf84WVWtoo0hVLTnIhOusYtLJ0A
         dEz4OIHpDmMPw0JaEjRoLCJmDZaGRX7yIfkIWyMumxD3OS8mFxy589ECb8Cqwf+N/tCt
         38xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDjeYERVmZBgLAnqXkqNSn+x8uE0/N1xNl0tBZNq1xk=;
        b=c6sO3RyaczDz5Ck40s1yqvrjcs1cM5UwpE75yn+Pjf5RNofRf6+f8NW0riOEMhBNjK
         Rn+OcJGjeTbTmqdy1pr7LxeBF83tujHWk9YAhUkRPJ9DK479woYin6SUmqC1rFpIeis/
         6Xal6A47+uCbsB4LVh3bLV/FaSj0T6Ms+WOCIUixm8TMG+YZZIRJ0rn/pdsTLVwmJM0U
         D8PqWtHkdGISxzLTfsqwI3F3Q/aFxGIqg+OqQiJRzTY/QU68TmX9tX9/efWQiq2HB7og
         im+14UupXs5dNn4VsgkJDYLFvTSdzeQK/5tkPjft78m/PfaczScopvoanDrs4NQgOfIT
         LPAA==
X-Gm-Message-State: AOAM533PP+jSJ5+jp/7sNq1dcfNhVPXb94Qo3XL77Vbe5nj2LKNkGG8s
        SpjU+rMUTIUxUhEpepg2DolPjhvof/fXHg==
X-Google-Smtp-Source: ABdhPJyTnZ1nV2QgSDE+rFLjAUeHXiHhvaT5CsXX1OE8mI0NJ0lgsfl3aecg65Ae5ajXYpU9DPiCcg==
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr14494844ooq.50.1605043302192;
        Tue, 10 Nov 2020 13:21:42 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 32sm27636otw.21.2020.11.10.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:41 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/26] completion: bash: fix prefix detection in branch.*
Date:   Tue, 10 Nov 2020 15:21:11 -0600
Message-Id: <20201110212136.870769-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7c81e4ba49..b866b68b3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2615,8 +2615,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.29.2

