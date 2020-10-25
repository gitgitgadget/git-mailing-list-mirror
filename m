Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC40C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2990A20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyGBwbta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766859AbgJYDON (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766849AbgJYDOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:09 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D40C0613D4
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:09 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id v123so1555337ooa.5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkhluwteQ5rcvV0BPWK7M7XpbHit4oZpMwJLu5ec1Do=;
        b=PyGBwbtaNyWbFCJUJGJvErinoqc2l452xT/vQDQEFvzurJl4JTjkw6njKhqSLaadxj
         2qMsXx5MMn9PkjeD+3oKnnKQ7GTgNOokTGRyH2TFyXW4CNIZI0bPubb2tU+l1ugOa5V2
         hFksyVOlGPJe988VkC4a5g3YtkVHjlCOrIhEW/0lW6TqwA35iNEabCNsfwQ+/fcc5KiE
         ZJvCQ1DxmiTWIe0DZ3lnVwbp+NQ6GStovHnVI82qtEcF0X8jxgjQ9nGPdT6xXmt2KejS
         3TVxqB2InO8QHerx62I4BjbwZuBFw7I+NB4VRC3HV0FZhPj4XibjDpu878NU8tTDero6
         +V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkhluwteQ5rcvV0BPWK7M7XpbHit4oZpMwJLu5ec1Do=;
        b=SSzXN7c6ZTvZZhYp4tXlDCIkIXWOULpD+Ju1hk16vm1WZZX7J4V5PBCdT8VrJDBjo/
         +SrTlRvOfLMHCWNGr7JUUjcKiUViBmsympQMZ2gWeEuSjq0CuV2pGkKCi+WyOxk8qmfZ
         djEZJcywbk+n06yN8WFVdxXntmIxlIQ1AAVZTW8xfRRNE0K6Z/DH4oQUZ49bM26e2Dn7
         KC7IAj24erqUnZtrBCyeC0xnEYGhPMQi9Vyqs1qI7qM7eDggFNzi2Z7zaDuj0WUctJEb
         eQSq6T7BrIc+84tE8+hEI/T4bz9AnKLpnuGNM5N1Ck8B+VLhEc84da7s2m79C7RWkJsf
         e3UQ==
X-Gm-Message-State: AOAM533OJHwCEE0pcl/PN75WwfToQMKajYAqQsI2gWPKihuY3ef9Xwnv
        3C8WPZqMjIhEOiRB+PJtpfJzBfdm0jVnuQ==
X-Google-Smtp-Source: ABdhPJzk5JKehiMOdskpP9Mk7hPetVnqd5npN4RUVsW7BTyX2+c5cCeo8p0sF8LUCMaUpzT2+H5Idw==
X-Received: by 2002:a05:6820:30e:: with SMTP id l14mr8119667ooe.57.1603595648256;
        Sat, 24 Oct 2020 20:14:08 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u26sm1702325ote.60.2020.10.24.20.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/29] completion: zsh: simplify compadd functions
Date:   Sat, 24 Oct 2020 22:13:29 -0500
Message-Id: <20201025031343.346913-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to override IFS, zsh has a native way of splitting by new
lines: the expansion flag (f).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 088bf7f759..2f20fe386a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -93,9 +93,8 @@ __gitcomp_direct ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -- ${${=1}% } && _ret=0
+	compadd -Q -- ${${(f)1}% } && _ret=0
 }
 
 __gitcomp_direct_append ()
@@ -107,34 +106,30 @@ __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_nl_append ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_file_direct ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compadd -f -- ${=1} && _ret=0
+	compadd -f -- ${(f)1} && _ret=0
 }
 
 __gitcomp_file ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compadd -p "${2-}" -f -- ${=1} && _ret=0
+	compadd -p "${2-}" -f -- ${(f)1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.29.0

