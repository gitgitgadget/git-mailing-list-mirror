Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E7C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiF0Sgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbiF0Sg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCA186D7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so1245997wmb.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tlgMODRSTxfugpA6U9GDTkON3GDMxqv3+xIrbLK/Kg0=;
        b=VMhRXtyEDCJs4WTGeUSXW3ziSax1FpG7DHNVgVHlgPEeOOj+HmZKaMcJhIINchgOD0
         4kDVZbq48sk3F946ePA2FFUXx+gi4foCBC8i9Xuu6IRL5snQIs5ZLlyIv+wokvzp1eoi
         YAnzNqaFuSrbqyXAI0AkF6k/vJAd4WHj1aMu2QjVLe6aT6K1eV8C6kU8JiF1Ed6XO6uc
         anJs/0pCZUz8WbiLvfRey84flIc0QIHiin9Q6d8rfDNW9ntGvZR6Byuq4SY/MFi//Y3r
         wKNlawx2zbSBrICA5T/1LImextB0ugDYTvKA8TJYug1P76Zp0cOF+izt0NvFMvwngQL/
         kLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tlgMODRSTxfugpA6U9GDTkON3GDMxqv3+xIrbLK/Kg0=;
        b=1lsjXwhYZ1gNXaBCTOyiV17BM06uZ/3eIpK7w9jmJf4vX0H2efRe29psbTGBHIlBiY
         H3yfnW0YjF4sxHqmDdzmpgXZub7s/DXtT64AT+4KOMRUwxl9FY8F5jb+ycMc/huSmlCn
         Wl7F/9xZPmiYzimCNjMTDn/oWTnoUuGYzZlKeR/1nRJVHG/oSjQQIJNjRn0MODsCbKj0
         lIunmm7XrVTIKJRunPrTkLVH0SVYBRlG4Nbt206o1YpJGvYP9TBp7eLl3NvWNliSXWl5
         aNlqdKa/bB9qTFY24uLGtu91ByFcKFFmHUf4ESFEeQ0nIHnvh/37enY9dCMQcJp7OYJm
         +11g==
X-Gm-Message-State: AJIora9OLa8aqBYFIe8qd7simfQIxgi2wuvtYJ2jfVNswobIoiKS+BpF
        RbVPeUIXbs8kxUEo9C0FPgd+DI4RZGCP6g==
X-Google-Smtp-Source: AGRyM1sSz7YzNLae9TFeCYcC86JII801a0SxFKUahfxpgCsXgiAqdjOsrWaC1WW1c1H9ZZ8bmpzRzQ==
X-Received: by 2002:a05:600c:4e02:b0:3a0:4f36:6c0b with SMTP id b2-20020a05600c4e0200b003a04f366c0bmr2146623wmq.54.1656354681792;
        Mon, 27 Jun 2022 11:31:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020adfce02000000b0021b944c9ce4sm11282402wrn.15.2022.06.27.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:21 -0700 (PDT)
Message-Id: <97dd2da8f89fb918a49d4f70d8dcdad9652e5143.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:03 +0000
Subject: [PATCH v4 02/16] bisect run: fix the error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
the part that prints out an error message when the implicit `git bisect
bad` or `git bisect good` failed.

However, the error message was supposed to print out whether the state
was "good" or "bad", but used a bogus (because non-populated) `args`
variable for it.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c    |  2 +-
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8a052c7111f..cc38a009bdd 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1263,7 +1263,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			printf(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'git bisect--helper --bisect-state"
+			error(_("bisect run failed: 'git bisect"
 			" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 6d6e72276ae..7a76f204083 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1063,4 +1063,14 @@ test_expect_success 'bisect state output with bad commit' '
 	grep -F "waiting for good commit(s), bad commit known" output
 '
 
+test_expect_success 'verify correct error message' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 &&
+	write_script test_script.sh <<-\EOF &&
+	rm .git/BISECT*
+	EOF
+	test_must_fail git bisect run ./test_script.sh 2>error &&
+	grep "git bisect good.*exited with error code" error
+'
+
 test_done
-- 
gitgitgadget

