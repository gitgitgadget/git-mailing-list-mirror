Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79BBC0502A
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiH3Jd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiH3Jco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E9E096E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id z22-20020a056830129600b0063711f456ceso7667427otp.7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DdMx+UE5my843uOVT+nSBERu9OMnfYEPVHx6qQSvIdY=;
        b=S01SjpeHPOOIjnEweUXCENIT3AQE4DKkmlLsdqaNe5iDc7D7QWMXCZXuge5Wl0pBDv
         zp5REtu5aEQyCKac18sLo3E6QqceCnwAQYUMl9lHFw4LId9B2W9ISxRflc0p4AB69cED
         m2L3Myxpgq4Y7H/AHfP2k8xx0JH1GLmMmbmE660cjwZPNbImaZom7X4Ca8s9TJNc0zSS
         tzgkXWg0QIVWu5BE9Ral8wYDIG3JqvZnfzM/RX1R2qsiykLFYitCt7Aa9gGcqUxzEoit
         2JQo8EyPDKy/FFIKpoyITBqL/xFV4kiQ9y7NiDRazxSoqHxpaX1GK9N9ZSPeB++PM3hk
         kEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DdMx+UE5my843uOVT+nSBERu9OMnfYEPVHx6qQSvIdY=;
        b=NASjZvfxCkEyLknPuVPAId+tvISzbEq4iK24SfExHQ2+3SAdkHE4wmQG1xCmI5DqFl
         21x97Lroyx1hK1FgD172Ah91Wr2PcCMYomds12eobNkCW6B/myGUbN/ST0m4cpg0Ep1H
         56hqfDhOtLCszrLSo2acA3++LCrmaw///9jSa7c+m7JtJ4F8EsdHCuX642xexRCCpy1L
         U42SQYuzqQxCuBZNq5k83u1U/9P1mCIWwyOYAdzIKvDZTmIqf6HLib+p6FeGharR0UUH
         Vs20TsDDZMRUq86aJAvph4rE+GeKZ2B+msGd6+0q4veZq0ouvnBdGWvf9h2bCHsVEm+W
         HooQ==
X-Gm-Message-State: ACgBeo1M7rLrhJD2Tv3Fbq0BPgvFbhhcQbUm0S8Dt2VkwBSPLNxOI75X
        rbQ00qQjWuI/gce5njVIb7ZtVrtJ8LA=
X-Google-Smtp-Source: AA6agR5HkZHwYN8ItJn8xgikZbKK0+DIrdrBWosWZeOvUobmpXuI0SriDrZMhN+PITG6XFJ9mCz5ew==
X-Received: by 2002:a05:6830:1145:b0:639:6fc2:3ac9 with SMTP id x5-20020a056830114500b006396fc23ac9mr7376152otq.303.1661851942847;
        Tue, 30 Aug 2022 02:32:22 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a6-20020a05680804c600b00344cc0c4606sm5771341oie.58.2022.08.30.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 25/51] completion: zsh: add excluded options
Date:   Tue, 30 Aug 2022 04:31:12 -0500
Message-Id: <20220830093138.1581538-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more excluded options, for example: --bare excludes --git-dir.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 17 +++++++++--------
 t/t9904-zsh-completion.sh             |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index f732881958..d2eb221d79 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -217,15 +217,16 @@ __git_zsh_main ()
 	local -a __git_C_args
 
 	_arguments -C \
-		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
-		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=[set the path to the repository]: :_directories' \
-		'--bare[treat the repository as a bare repository]' \
+		'(-p --paginate -P --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
+		'(-p --paginate -P --no-pager)'{-P,--no-pager}'[do not pipe git output into a pager]' \
+		'(--bare)--git-dir=[set the path to the repository]: :_directories' \
+		'(--git-dir)--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
-		'--html-path[print the path where git''s HTML documentation is installed]' \
-		'--info-path[print the path where the Info files are installed]' \
-		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
+		'--exec-path=[path to where your core git programs are installed]: :_directories' \
+		'(- :)--exec-path[print the path where your core git programs are installed]' \
+		'(- :)--html-path[print the path where git''s HTML documentation is installed]' \
+		'(- :)--info-path[print the path where the Info files are installed]' \
+		'(- :)--man-path[print the manpath (see `man(1)`) for the man pages]' \
 		'--work-tree=[set the path to the working tree]: :_directories' \
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index 7283af3342..d0795ee014 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -802,7 +802,7 @@ test_expect_success 'general options' '
 	test_completion "git --no-r" "--no-replace-objects"
 '
 
-test_expect_failure 'general options plus command' '
+test_expect_success 'general options plus command' '
 	test_completion "git --version check" "" &&
 	test_completion "git --paginate check" "checkout" &&
 	test_completion "git --git-dir=foo check" "checkout" &&
-- 
2.37.2.351.g9bf691b78c.dirty

