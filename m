Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B7C1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeCXUiT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:19 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39614 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeCXUiN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:13 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so22920649lfd.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6D93SXjwFs+dgeeP6FnzNmJnhlvz0HfbR7/+dEzD0A=;
        b=UuCVqQQIRAX+c/TF7yH5V3LOY2jB8RG6e4CW/ObAv1ZkIvvmz494dgYjRR8jdFTDIN
         9kQBSR5OiRFg+pAOftVz0iAJUoEstJ32tG7bo7gE7acVVQnn+fkTPkK9hPyk6Dh3b3ZU
         CRH03QV68Hy76gvO1Hyr2dP9iuv2gxFGfPH6LhygQ0KInYAiUFdcWGDNINsowQx0Hko4
         mZlh5MCM4As0Oh0IWRiWl5wYxYzq3l6886iuzoKbQ0LJzwIjbJBkDXeqeyHm+sABLCzE
         7RzygsY7b8l1WwNi2my/hkTT9J6/8FhP1BwKoc6ajKzRjYzozBfBBzpXhzK78AXcblT1
         3mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6D93SXjwFs+dgeeP6FnzNmJnhlvz0HfbR7/+dEzD0A=;
        b=DqNVd/HV1oQiw4+FMIsaL49TS5zJWWte/GUwACTuCWDyXxnXuJKynfD5IP0sPw8Tqw
         F6/yhJpoF3zbV4lgjet8knDz+coUXdreAdvwraH/dbWqf2zz0zASbXA5/4I1WDZJc916
         45HaeYU83O31Rcqod6dtsP8rz1zef7ZJRrOIkbtuoeX7hvc5O+j0huViqKzv8UQwSddO
         nua3LQFSvQh6n1HfXUNmvjQcNIjHRtmVeuF4kl7DrXnQa+dvvb7UaFgs8CatQ4PpkTID
         WtlRHMwiLW7fAeur6YK8HWj+aiF8r6opiayF64ZqtE2sb5OAf3NLCfW4m7P91bsabd9E
         YXRw==
X-Gm-Message-State: AElRT7FA2zXIgNcXKAKu1xqCXhL+cqAYoCp4Pl8ZOF+e+cR4ijvbOLnJ
        JrQZ86V/8MbKYZZTDUw5SAPe7Q==
X-Google-Smtp-Source: AG47ELulThrE1K4bbqyPnvJPqeRNxo90noe57BG7xyDQCfn9Ej9Z25wGCU4klyt0H+YApPlP7/716w==
X-Received: by 2002:a19:9d12:: with SMTP id g18-v6mr13607035lfe.142.1521923891995;
        Sat, 24 Mar 2018 13:38:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] completion: use __gitcomp_builtin in _git_ls_tree
Date:   Sat, 24 Mar 2018 21:35:24 +0100
Message-Id: <20180324203525.24159-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324203525.24159-1-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com>
 <20180324203525.24159-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0ee0ad7ac3..2f16264413 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1625,6 +1625,13 @@ _git_ls_remote ()
 
 _git_ls_tree ()
 {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin ls-tree
+		return
+		;;
+	esac
+
 	__git_complete_file
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

