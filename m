Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F1EC77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjERUDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjERUDd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BDE45
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3093d10442aso1639307f8f.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440209; x=1687032209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNO2gC9OIGG5Fp3+Aat6F3ILcm8+T6Z8zFG822ffxdE=;
        b=VpvYTNL7K2jriqlt0WcXnIyDHiE75HKH5k31c5fcPxodSRIEPbw+eW0MysKC/9Yekp
         O7Fkw4ytSsUum+onh9pVOZGOs/sJa94MHVJ35fUrjobpMqvuob5B4TE2sMYHL1X8RMRv
         zfMEBUylKfj9FNOfwcdqNcqxuKisc1TqOPOCaIyxT+9jz05RHFkdElVcu4SFamHoDKFb
         oOj0nOKQLYXJbMTW8misMnJaoodeaAsQdl2g5+GiWJXUzHX+DJO+xonnpLi1SMvcyIV0
         jw2fmLDpvE0xuTqNhH8Us5d0x2/rse0xVAsovlMcfIR+2sleFv4v16OA117hZQ561FLh
         swrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440209; x=1687032209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNO2gC9OIGG5Fp3+Aat6F3ILcm8+T6Z8zFG822ffxdE=;
        b=Gy7DuevTJNdoJFdxO64O2ZQqfkgFBkdQmh+H4kv45IxNJ+cH1xXDJ5I3/5T+8MGEB4
         Q8CSZ6hsxxq0LhjEm0lDQq2puBPD45gBs8z/4ezlV9x+NAz+nXqlNUJHfAVRW/3XYlW7
         RI1F0VZq6/aorNUcDmmE1WHHxKnd90D/bFZkEdBO321CK+ZJXYFmKnNFXkY7PrVme42p
         zLOvUXYvLm21kRrip3JDTJ543d3G+mpBkmDE6J+jLR0ZEdoNuU8tjxuJpPfSYjQO0Ife
         wd8iTJVksXvbKsJYElYTM9VIMknj9ENBqNbGx/I74PAShNAlJAwYyLndFRmTjVzydRDw
         wmQw==
X-Gm-Message-State: AC+VfDwgpnlXLZTvuD9mI61fk0fdlrpzGTIEFNgtxrgCCpR8S+fjgeIK
        4Tt+f0ezSnDnqWYSlcPmoWxP2uyT5Ww=
X-Google-Smtp-Source: ACHHUZ4XT4ko3lGz88q5isOLZjmedgKGQb51HlGjX9+9Fnc+71anvYiEgz4iAJLmGEKN7ahBadPMIA==
X-Received: by 2002:a5d:410f:0:b0:309:4243:f38 with SMTP id l15-20020a5d410f000000b0030942430f38mr2347010wrp.35.1684440208620;
        Thu, 18 May 2023 13:03:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b002f7780eee10sm3054898wrm.59.2023.05.18.13.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:28 -0700 (PDT)
Message-Id: <68a54a55ea227ec8bba00239c0de99cc6eaf40ce.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:07 +0000
Subject: [PATCH 02/20] t0030-stripspace: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests in t0030-stripspace.sh used the older four space indent
format. Update these to use tabs.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0030-stripspace.sh | 560 ++++++++++++++++++++----------------------
 1 file changed, 271 insertions(+), 289 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 0a5713c5248..d1b3be87257 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -17,396 +17,378 @@ printf_git_stripspace () {
     printf "$1" | git stripspace
 }
 
-test_expect_success \
-    'long lines without spaces should be unchanged' '
-    echo "$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
-
-    echo "$ttt$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
-
-    echo "$ttt$ttt$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
-
-    echo "$ttt$ttt$ttt$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual
+test_expect_success 'long lines without spaces should be unchanged' '
+	echo "$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
+
+	echo "$ttt$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
+
+	echo "$ttt$ttt$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
+
+	echo "$ttt$ttt$ttt$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'lines with spaces at the beginning should be unchanged' '
-    echo "$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
+test_expect_success 'lines with spaces at the beginning should be unchanged' '
+	echo "$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
 
-    echo "$sss$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
+	echo "$sss$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
 
-    echo "$sss$sss$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual
+	echo "$sss$sss$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'lines with intermediate spaces should be unchanged' '
-    echo "$ttt$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
+test_expect_success 'lines with intermediate spaces should be unchanged' '
+	echo "$ttt$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$sss$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual
+	echo "$ttt$sss$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'consecutive blank lines should be unified' '
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive blank lines should be unified' '
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'only consecutive blank lines should be completely removed' '
+test_expect_success 'only consecutive blank lines should be completely removed' '
+	printf "\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "\n\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss\n$sss\n$sss\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss\n$sss\n$sss\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss\n$sss\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss\n$sss\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "\n$sss\n$sss$sss\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n$sss\n$sss$sss\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss$sss$sss\n\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss$sss$sss\n\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "\n$sss$sss$sss$sss\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n$sss$sss$sss$sss\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
-
-    printf "\n\n$sss$sss$sss$sss\n" | git stripspace >actual &&
-    test_must_be_empty actual
+	printf "\n\n$sss$sss$sss$sss\n" | git stripspace >actual &&
+	test_must_be_empty actual
 '
 
-test_expect_success \
-    'consecutive blank lines at the beginning should be removed' '
-    printf "$ttt\n" > expect &&
-    printf "\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive blank lines at the beginning should be removed' '
+	printf "$ttt\n" > expect &&
+	printf "\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
-    printf "\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" > expect &&
+	printf "\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" > expect &&
-    printf "\n\n\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" > expect &&
+	printf "\n\n\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n" > expect &&
-    printf "\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n" > expect &&
+	printf "\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt$ttt\n" > expect &&
-    printf "\n\n\n$ttt$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt$ttt\n" > expect &&
+	printf "\n\n\n$ttt$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
+	printf "$ttt\n" > expect &&
 
-    printf "$sss\n$sss\n$sss\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$sss\n$sss\n$sss\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "\n$sss\n$sss$sss\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "\n$sss\n$sss$sss\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$sss$sss\n$sss\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$sss$sss\n$sss\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$sss$sss$sss\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$sss$sss$sss\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "\n$sss$sss$sss\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "\n$sss$sss$sss\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "\n\n$sss$sss$sss\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "\n\n$sss$sss$sss\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'consecutive blank lines at the end should be removed' '
-    printf "$ttt\n" > expect &&
-    printf "$ttt\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive blank lines at the end should be removed' '
+	printf "$ttt\n" > expect &&
+	printf "$ttt\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" > expect &&
-    printf "$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" > expect &&
+	printf "$ttt$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
+	printf "$ttt\n" > expect &&
 
-    printf "$ttt\n$sss\n$sss\n$sss\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$sss\n$sss\n$sss\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$sss\n$sss$sss\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$sss\n$sss$sss\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$sss$sss\n$sss\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$sss$sss\n$sss\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$sss$sss$sss\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$sss$sss$sss\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$sss$sss$sss\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$sss$sss$sss\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n\n$sss$sss$sss\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt\n\n\n$sss$sss$sss\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'text without newline at end should end with newline' '
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$ttt"
+test_expect_success 'text without newline at end should end with newline' '
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$ttt"
 '
 
 # text plus spaces at the end:
 
-test_expect_success \
-    'text plus spaces without newline at end should end with newline' '
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$sss" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss$sss" &&
-    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss$sss"
+test_expect_success 'text plus spaces without newline at end should end with newline' '
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$sss" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss$sss" &&
+	test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss$sss"
 '
 
-test_expect_success \
-    'text plus spaces without newline at end should not show spaces' '
-    printf "$ttt$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    printf "$ttt$ttt$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    printf "$ttt$sss$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null
+test_expect_success 'text plus spaces without newline at end should not show spaces' '
+	printf "$ttt$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	printf "$ttt$ttt$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	printf "$ttt$sss$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null
 '
 
-test_expect_success \
-    'text plus spaces without newline should show the correct lines' '
-    printf "$ttt\n" >expect &&
-    printf "$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'text plus spaces without newline should show the correct lines' '
+	printf "$ttt\n" >expect &&
+	printf "$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" >expect &&
-    printf "$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" >expect &&
+	printf "$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" >expect &&
-    printf "$ttt$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" >expect &&
+	printf "$ttt$sss$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'text plus spaces at end should not show spaces' '
-    echo "$ttt$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    echo "$ttt$ttt$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    echo "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    echo "$ttt$sss$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null &&
-    echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
-    ! grep "  " tmp >/dev/null
+test_expect_success 'text plus spaces at end should not show spaces' '
+	echo "$ttt$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	echo "$ttt$ttt$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	echo "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	echo "$ttt$sss$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null &&
+	echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
+	! grep "  " tmp >/dev/null
 '
 
-test_expect_success \
-    'text plus spaces at end should be cleaned and newline must remain' '
-    echo "$ttt" >expect &&
-    echo "$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'text plus spaces at end should be cleaned and newline must remain' '
+	echo "$ttt" >expect &&
+	echo "$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt" >expect &&
-    echo "$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt" >expect &&
+	echo "$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt" >expect &&
-    echo "$ttt$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt" >expect &&
+	echo "$ttt$sss$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$ttt" >expect &&
-    echo "$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt$ttt" >expect &&
+	echo "$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$ttt" >expect &&
-    echo "$ttt$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt$ttt" >expect &&
+	echo "$ttt$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$ttt$ttt" >expect &&
-    echo "$ttt$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual
+	echo "$ttt$ttt$ttt" >expect &&
+	echo "$ttt$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
 # spaces only:
 
-test_expect_success \
-    'spaces with newline at end should be replaced with empty string' '
-    echo | git stripspace >actual &&
-    test_must_be_empty actual &&
+test_expect_success 'spaces with newline at end should be replaced with empty string' '
+	echo | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	echo "$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	echo "$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	echo "$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual
+	echo "$sss$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual
 '
 
-test_expect_success \
-    'spaces without newline at end should not show spaces' '
-    printf "" | git stripspace >tmp &&
-    ! grep " " tmp >/dev/null &&
-    printf "$sss" | git stripspace >tmp &&
-    ! grep " " tmp >/dev/null &&
-    printf "$sss$sss" | git stripspace >tmp &&
-    ! grep " " tmp >/dev/null &&
-    printf "$sss$sss$sss" | git stripspace >tmp &&
-    ! grep " " tmp >/dev/null &&
-    printf "$sss$sss$sss$sss" | git stripspace >tmp &&
-    ! grep " " tmp >/dev/null
+test_expect_success 'spaces without newline at end should not show spaces' '
+	printf "" | git stripspace >tmp &&
+	! grep " " tmp >/dev/null &&
+	printf "$sss" | git stripspace >tmp &&
+	! grep " " tmp >/dev/null &&
+	printf "$sss$sss" | git stripspace >tmp &&
+	! grep " " tmp >/dev/null &&
+	printf "$sss$sss$sss" | git stripspace >tmp &&
+	! grep " " tmp >/dev/null &&
+	printf "$sss$sss$sss$sss" | git stripspace >tmp &&
+	! grep " " tmp >/dev/null
 '
 
-test_expect_success \
-    'spaces without newline at end should be replaced with empty string' '
-    printf "" | git stripspace >actual &&
-    test_must_be_empty actual &&
+test_expect_success 'spaces without newline at end should be replaced with empty string' '
+	printf "" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual
+	printf "$sss$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual
 '
 
-test_expect_success \
-    'consecutive text lines should be unchanged' '
-    printf "$ttt$ttt\n$ttt\n" >expect &&
-    printf "$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive text lines should be unchanged' '
+	printf "$ttt$ttt\n$ttt\n" >expect &&
+	printf "$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt$ttt\n$ttt\n" >expect &&
-    printf "$ttt\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$ttt$ttt\n$ttt\n" >expect &&
+	printf "$ttt\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" >expect &&
-    printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" >expect &&
+	printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" >expect &&
-    printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" >expect &&
+	printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt$ttt\n\n$ttt\n" >expect &&
-    printf "$ttt\n$ttt$ttt\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt\n$ttt$ttt\n\n$ttt\n" >expect &&
+	printf "$ttt\n$ttt$ttt\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'strip comments, too' '
-- 
gitgitgadget

