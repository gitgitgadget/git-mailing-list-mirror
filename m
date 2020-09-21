Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA592C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8186920773
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooUpT7Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIUKkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIUKkc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812FC0613D1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so12181552wrp.8
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxhCdW84RN9sLZKj4/fVtMIvvABwK4DsRZo09iFF8Ig=;
        b=ooUpT7ZgqGWT+ftGDyJP+Chnnxvr3A9zTnWX3IEoI00gaBvw3Oq9JnNUFjrDyZV+37
         rk2xO10cAdjU7JbgzogDFQvBlSJeKch90E1Fo8amWH2kcbx7iVRyE8m05COWyF3XT4FH
         +TIBXsTLxABhpucIKxm/9Sqx4Eazf34rbxFPCXwD1ia4ZKcFzJMZHI7g+e8xUHTodPxx
         /A2U7t4HhuSqfTR+1kNshsJboXX/pt20i9XaERRn+cXBXolpGNUd6gqx5c9IF05/6bpr
         MoVlZh4/VWkSQdxSs7Xh353YinWGeyNfSGbzfSCVxnNPjknVKec5RzxNnjF4JJROPd37
         jRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxhCdW84RN9sLZKj4/fVtMIvvABwK4DsRZo09iFF8Ig=;
        b=JtYjmm5mWWNpSiGcfQpfizpCgpt6nCVQlTYI6Grt9KB7pMsAM2YufWFHNsPleZT+Qp
         pGvmZZlog21g0viRKKe6O3F/dTwVaW7HCu1wlAq96JTdn89/Sm21HBGyelsqtCfGZO49
         gqAMCtZerbtXhAF2b8aYEkzvgZPLvCjvYcHi4FQ1u3G1Y5V1SZMBufSNAX9yL/zUhhIM
         Op4pLFBN4a6f5i8mWXBFq4FCZYSY5c8IXcZ2awAinGIjcHroX3gNDiNtGMfU1ZeATM7R
         2lQ+dpqTTnLrzMEO1ED/u+sDBcd/Vxy7fv+Jz+pttuNMy9+Krd+p54jdLCAafmAqMQ0m
         i2eg==
X-Gm-Message-State: AOAM530pRUHwzaFnoDoLFOi7X1UqHBB077hMW9oCnArw7CN40ctodQ4p
        3dWnFKnb13XF71NwYLdnfqbYfcRiMp32Mw==
X-Google-Smtp-Source: ABdhPJwoS98bNNDkX2J0jQAdw6Ummyd4ahlz99DeG/VOz04Sj6LFa3l6zJVEe0Iq3b57PtTAXKuUFg==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr22704078wrn.110.1600684830336;
        Mon, 21 Sep 2020 03:40:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/18] remote-mediawiki: provide a list form of run_git()
Date:   Mon, 21 Sep 2020 12:39:57 +0200
Message-Id: <20200921104000.2304-16-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Invoking commands as "git $args" doesn't quote $args. Let's support
["git", $args] as well, and create corresponding run_git_quoted() and
run_git_unquoted() aliases for subsequent changes when we move the
code over to the new style of invoking this function. At that point
we'll delete the then-unused run_git() wrapper.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 26d5e1a174..59cb277517 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -369,12 +369,14 @@ sub get_mw_pages {
 	return %pages;
 }
 
-# usage: $out = run_git("command args");
-#        $out = run_git("command args", "raw"); # don't interpret output as UTF-8.
-sub run_git {
+# usage: $out = run_git_quoted(["command", "args", ...]);
+#        $out = run_git_quoted(["command", "args", ...], "raw"); # don't interpret output as UTF-8.
+#        $out = run_git_unquoted(["command args"); # don't quote arguments
+#        $out = run_git_unquoted(["command args", "raw"); # ditto but raw instead of UTF-8 as above
+sub _run_git {
 	my $args = shift;
 	my $encoding = (shift || 'encoding(UTF-8)');
-	open(my $git, "-|:${encoding}", "git ${args}")
+	open(my $git, "-|:${encoding}", @$args)
 	    or die "Unable to fork: $!\n";
 	my $res = do {
 		local $/ = undef;
@@ -385,6 +387,15 @@ sub run_git {
 	return $res;
 }
 
+sub run_git_quoted {
+    _run_git(["git", @{$_[0]}], $_[1]);
+}
+
+sub run_git_unquoted {
+    _run_git(["git $_[0]"], $_[1]);
+}
+
+BEGIN { *run_git = \&run_git_unquoted }
 
 sub get_all_mediafiles {
 	my $pages = shift;
-- 
2.28.0.297.g1956fa8f8d

