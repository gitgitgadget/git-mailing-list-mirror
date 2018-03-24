Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAD81F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeCXUi2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33291 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeCXUiL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:11 -0400
Received: by mail-lf0-f68.google.com with SMTP id x205-v6so22936735lfa.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAgT36+fu8FyFwVCxOazrvKQuPUOr2j2X2eZztnOxQg=;
        b=JkuoRyF1Wc9R4kWeV9aXQhvWZJVhoYMLSLYNm8NOYjlC9ugdzDtLE+FPd5t+mwTQbM
         IG79Z/O6GIIUTlzbDWlPyfQyBuMOIm13ywIVGOoD9HcWMQ7+YYjKx/js8IxNvCuhNIav
         JF7/x1aJg3x1N9buSKoq7H2ts/ISPm7BsV0gRzXyA9vWHNCTVX4sxyDQDvmnx/CFWiiB
         h7xrq1StfV//weB/h2fqdAelUxkphgAVnVemE4bt9XuAthL98KKr1MtwbKlSUhr3gdkV
         dRN5n1nLhEZbGXdk3L8cXeZ/8E6Hlr42DZ4jcGRmpCFjuHK019nfj7uTF2q9/VtL24BW
         gRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAgT36+fu8FyFwVCxOazrvKQuPUOr2j2X2eZztnOxQg=;
        b=F9qBdC4XfbnAvvumn6tGEw+zPkmbxTeQpi6G3+Qi+9ngH1IzLWioXEvuwDY7UyDIQw
         0sn7ED4PRRPV8hYr057sVlYd+UMIWsXc0XQuFBaN+lZQwQBM0zziizTXw5E5Oqay92Oa
         kiCC5BMB2ssgjzrySLEA0d78qkASg2LjwbPZdv72tx0nd/T35F/VrxEO1LFfLD6ROlVb
         ym7yJsTHVAb+TrKlRoKD9PJTCo/3P2WYEtGKZFA64FGG4p3j8K9FmShEHs3AAydB4xyO
         5OOU/B0kR9MFtUNoBC821Cx6K8/MlXM3l7xOv9ZQkRh9+tUkRBPzupmQDVc8fL35/dvg
         WMEw==
X-Gm-Message-State: AElRT7H5QnWLKYQe4yYqBcxItlGEaSlVHxeuRyF+nklsUeKQHkksQQNn
        wqrdhwHbv4a1o3MLLSlUwd4=
X-Google-Smtp-Source: AG47ELvpdx4M2aBeI2HD1IaYvNc45Nw1BaKzeuSRO9NM9n9NVh1zkXwrUfv2gP3TZMKxTwSz9dDbNA==
X-Received: by 10.46.145.4 with SMTP id m4mr7445947ljg.73.1521923889982;
        Sat, 24 Mar 2018 13:38:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] completion: add --option completion for most builtin commands
Date:   Sat, 24 Mar 2018 21:35:22 +0100
Message-Id: <20180324203525.24159-6-pclouds@gmail.com>
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

Many builtin commands use parseopt which supports expose the option
list via --git-completion-helper but do not have explicit support in
git-completion.bash. This patch detects those commands and uses
__gitcomp_builtin for option completion.

This does not pollute the command name completion though. "git <tab>"
will show you the same set as before. This only kicks in when you type
the correct command name.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 28 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b3a9ecfad0..a90b0e8db4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3034,12 +3034,40 @@ _git_worktree ()
 	fi
 }
 
+__git_complete_common () {
+	local command="$1"
+
+	case "$cur" in
+	--*)
+		__gitcomp_builtin "$command"
+		;;
+	esac
+}
+
+__git_cmds_with_parseopt_helper=
+__git_support_parseopt_helper () {
+	test -n "$__git_cmds_with_parseopt_helper" ||
+		__git_cmds_with_parseopt_helper="$(__git --list-parseopt-builtins)"
+
+	case " $__git_cmds_with_parseopt_helper " in
+	*" $1 "*)
+		return 0
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
 __git_complete_command () {
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
 	if declare -f $completion_func >/dev/null 2>/dev/null; then
 		$completion_func
 		return 0
+	elif __git_support_parseopt_helper "$command"; then
+		__git_complete_common "$command"
+		return 0
 	else
 		return 1
 	fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e6485feb0a..d0a1e4c988 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1454,6 +1454,12 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
 	EOF
 '
 
+test_expect_success 'completion without explicit _git_xxx function' '
+	test_completion "git version --" <<-\EOF
+	--build-options Z
+	EOF
+'
+
 test_expect_failure 'complete with tilde expansion' '
 	git init tmp && cd tmp &&
 	test_when_finished "cd .. && rm -rf tmp" &&
-- 
2.17.0.rc0.348.gd5a49e0b6f

