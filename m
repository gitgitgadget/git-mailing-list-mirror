Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1A51F403
	for <e@80x24.org>; Wed,  6 Jun 2018 09:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeFFJmE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 05:42:04 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37200 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeFFJmD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 05:42:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so6100169lfb.4
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6ScC1TvT7W8wK6gzI/3oUNbSdON5+mKI92eVxpROJU=;
        b=ViBGk70AvxI+pQ1wO2hWAc4vh9AXjpf8AOLe6LcusqYZV+PcxlcE+K21VBjcenJl7e
         fNdaVolw2t50un4cv2dvSypy/l68F4v/3uLzFVeJ/xeEqPQGPi5VItgSftiiy1Nqhn7O
         CGBgh7erlL9/4Fd+1uAGLS+dXs0yrR3BzYmP8i/dxsjoMdj068OtXwq71S+ZIylnxdO8
         V7f32B2dVtQrdCJC/jQnSdmFco8cezzFc/qMa6pZrMD2h45IVPPiHKQ3EFAeei6W77YD
         1DrtIOr5v8y8BULiHLf5jePd5rDcDNTqGd0UNDuGxqXXookAFKnZdMxsK3aWvT276mlV
         mRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6ScC1TvT7W8wK6gzI/3oUNbSdON5+mKI92eVxpROJU=;
        b=lmrDFJVE2WbKBiiml/9WnYbVOMHn+p5ao3kBrzLd/zOWVN8cWX93dUP+UbBxHg8uc6
         c3iNuT8nV+qXGi+Ko0nZr8Q2g02HUaEreI4w+RATBUvetaeLfvhbKYsdI4/XSZt6zyiM
         PNCv312fJuZWaSTOzb5mWutzJIRYmOZtj0Jt9PJNIL+l++M7AWszGGFbWIHN4Qh36T2c
         gYjnI/+HiHJRLA9EkntVuf2dSxC2bOFdHETAvfOSkE3/hKHCfZS31/Rm+AdnjMqtjrbt
         xs7SEm4r954krP9RsEMwYFOK5mRxeyrwhzlexQrnVxixIGzOdJhoFyyJ6nB4Ycbkln7r
         3q2g==
X-Gm-Message-State: APt69E2+JPaNSxgGiRN1yJJrugg0TZgteF/nTRjHnmUhWdYQVcxcveS0
        XQjhKfM2vzb3BtoTUV6em2Q=
X-Google-Smtp-Source: ADUXVKIJGqXN4oom+B1loLpPIVT1j9+eKoJ0fKxP783my8ZkL3QCyfpht2/GQZEschdujIh/b0/pRA==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr1557241ljj.49.1528278122274;
        Wed, 06 Jun 2018 02:42:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2987062ljj.71.2018.06.06.02.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 02:42:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 0/3] ompletion: complete all possible -no-<options>
Date:   Wed,  6 Jun 2018 11:41:36 +0200
Message-Id: <20180606094139.30906-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180527083828.6919-1-pclouds@gmail.com>
References: <20180527083828.6919-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes an annoying bug in 3/3. If you do "git commit --fi<tab>"
then the "fi" part is eaten up by bash and you got back to
"git commit --" on the command line.

This is because we give COMPREPLY with two options "--fixup" and
"--no-...". The second one forces the common prefix "--" for both
of them, instead of "--fi". Bash does the rest according to the book.

Some tests are added to verify new behavior in __gitcomp and make sure
this does not happen again.

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4eef353ee2..425d06256f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -286,7 +286,10 @@ __gitcomp ()
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
 			if [[ $c == "--" ]]; then
-				COMPREPLY[i++]="${2-}--no-...${4-} "
+				c="--no-...${4-}"
+				if [[ $c == "$cur_"* ]]; then
+					COMPREPLY[i++]="${2-}$c "
+				fi
 				break
 			fi
 			c="$c${4-}"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index eb4a43584a..157ee7085d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -459,6 +459,42 @@ test_expect_success '__gitcomp - suffix' '
 	EOF
 '
 
+test_expect_success '__gitcomp - ignore optional negative options' '
+	test_gitcomp "--" "--abc --def --no-one -- --no-two" <<-\EOF
+	--abc Z
+	--def Z
+	--no-one Z
+	--no-... Z
+	EOF
+'
+
+test_expect_success '__gitcomp - ignore/narrow optional negative options' '
+	test_gitcomp "--a" "--abc --abcdef --no-one -- --no-two" <<-\EOF
+	--abc Z
+	--abcdef Z
+	EOF
+'
+
+test_expect_success '__gitcomp - ignore/narrow optional negative options' '
+	test_gitcomp "--n" "--abc --def --no-one -- --no-two" <<-\EOF
+	--no-one Z
+	--no-... Z
+	EOF
+'
+
+test_expect_success '__gitcomp - expand all negative options' '
+	test_gitcomp "--no-" "--abc --def --no-one -- --no-two" <<-\EOF
+	--no-one Z
+	--no-two Z
+	EOF
+'
+
+test_expect_success '__gitcomp - expand/narrow all negative options' '
+	test_gitcomp "--no-o" "--abc --def --no-one -- --no-two" <<-\EOF
+	--no-one Z
+	EOF
+'
+
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '


Nguyễn Thái Ngọc Duy (3):
  parse-options: option to let --git-completion-helper show negative
    form
  completion: suppress some -no- options
  completion: collapse extra --no-.. options

 builtin/checkout.c                     | 10 +++--
 contrib/completion/git-completion.bash | 61 ++++++++++++++++----------
 parse-options.c                        | 58 ++++++++++++++++++++++--
 t/t9902-completion.sh                  | 41 ++++++++++++++++-
 4 files changed, 136 insertions(+), 34 deletions(-)

-- 
2.18.0.rc0.333.g22e6ee6cdf

