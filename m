Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2EF1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965593AbeEJOTq (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46864 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965266AbeEJOTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id x7-v6so3199133lff.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFt+2eKEJThMwCdB4eIoYbVWRS/siBEk3huCQG7DBgY=;
        b=UfWOJsm9UYkos1ymFplH7Y7ML17J891uSjZ7o503FxzzgAIUmABELj4TkcdXILVuAR
         f3DJU7fd4RvZ+G+85zfqXiJXE6CwNA+FlaSyyCZv1QMML8Ui0tPywEyPK66ielzyHVYg
         ZeI3mozqkQ3VIrp1pXbgZ8PIEBG6vMWmIYa8RrcKSt8Lz/y7W4nIqGW1XZ69bu7Qw5qV
         AT11t9lJ76eHHP1mdns8VR2KlpgrThbxY1RDALU4KKmk7guiP+iG9ZdzmF4juntReZZD
         mwNCWLwNt8bNoOYzWUZF/Sf3BFD3HyYZ44SxMQGQ/0cBH6vazD/Ohzr0MHb2g+m1OuyU
         jJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFt+2eKEJThMwCdB4eIoYbVWRS/siBEk3huCQG7DBgY=;
        b=td0MLIKmTJyaatJXFpsrZuwu0KUzveFag6o9Y3oxCm5sqPmMDS+x9tHoEQKpdfT1Zm
         A79QEWVrhnHpFWhiNTGmFF8fPWd+iImyzoVbVc4iORfaHwe7N9Ldz5p/MMT2Bu+hMNNz
         2qMDvuZrHR4J5MZNIS5yOteHiwYccg0mCYOLLBJIHvqVHcIz5Okv4OU5Ene+mGch5jLu
         t/msdnLA4xaFXR2pe/p/aSKDOuszyAPXqRMUjuY+4UvFtdmrMv3AolwDc2TA+hHi1uD5
         SUlJcw7Jg/VA1HOWj0JYLVMjTUZOEoJdKkKAfkEVM4KrYk6Di6m3Lxu4bvpgFQgOmRey
         Lc4A==
X-Gm-Message-State: ALKqPwfeALRihFkkYhZQ3hBAdDvkFvKQR1QLjAyuOTlCGOugMUXuSy/s
        pFpEYTYFKBVXjcX7N8ysem/yGg==
X-Google-Smtp-Source: AB8JxZpr7nuPbaQqnA/T4tt67g3nxxiOSA9v21R8zQZyq6IQEo1Abvks7cU4sQrRVLAeCfiCvF7qIQ==
X-Received: by 2002:a2e:2e17:: with SMTP id u23-v6mr1296803lju.77.1525961980743;
        Thu, 10 May 2018 07:19:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 8/9] completion: support case-insensitive config vars just a bit
Date:   Thu, 10 May 2018 16:19:26 +0200
Message-Id: <20180510141927.23590-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

config variable names are technically case-insensitive while this case
construct is by default case-sensitive. Moving it to case-insensitive
could be a lot more work. Instead let's just accept the form that is
more likely to show up in practice.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8d3257c4de..e7829b5b24 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2084,7 +2084,7 @@ __git_compute_config_vars ()
 _git_config ()
 {
 	case "$prev" in
-	branch.*.remote|branch.*.pushremote)
+	branch.*.remote|branch.*.push[Rr]emote)
 		__gitcomp_nl "$(__git_remotes)"
 		return
 		;;
@@ -2096,7 +2096,7 @@ _git_config ()
 		__gitcomp "false true preserve interactive"
 		return
 		;;
-	remote.pushdefault)
+	remote.push[Dd]efault)
 		__gitcomp_nl "$(__git_remotes)"
 		return
 		;;
@@ -2162,7 +2162,7 @@ _git_config ()
 		__gitcomp "$__git_send_email_suppresscc_options"
 		return
 		;;
-	sendemail.transferencoding)
+	sendemail.transfer[Ee]ncoding)
 		__gitcomp "7bit 8bit quoted-printable base64"
 		return
 		;;
-- 
2.17.0.705.g3525833791

