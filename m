Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DFD71F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfD2GVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40837 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfD2GVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:15 -0400
Received: by mail-it1-f193.google.com with SMTP id k64so7164143itb.5
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mzxV7CsL+sGTh03GsLEtneAm0Frke2yHRPGqtbORuSU=;
        b=QYupVvZ2E19vAPV0xTz9CKKEVQBaekxYi3GZVB2MkcZi1HChw8wf4Y2s1vIDv4VA/J
         7rapfVvya29NLdy1JQBlADyJFA/NAP+rdTY7C781BbQHOcNjvAP/HXSUSffHZYeOOYZc
         n22RHB7HmdpT2kzwwW8kmdOnFOrQke+8g5mWHL3Fov9/JCVKtle4b88YRYelp/mwW4Zv
         DQpBn7wai5sJL3WIvbnzMZFEMd6wJCpY1xYwvCFOjk5K/96KkV6DJFtcKwPUXZT4hugn
         iGA8YN9h3bg9PpwkCHnTbABGc4DL+jYT2I265nqXxlxDzBjlf2s0/Y8mJrFnVvqt9LSa
         +Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzxV7CsL+sGTh03GsLEtneAm0Frke2yHRPGqtbORuSU=;
        b=jrb5F5GIPNlqapxvQTVb7p0WwvJin5qdv1m6RxjlNtwZQ+waS7z+RIY4JnZ/anAAzJ
         1bvKZg52iuWiskf8kOrfDAFvoeSEBQar9nQb63mzKJSqtzsD5inJ56NXg8F94WOmll7w
         +AoPutBco+O/HvwW/Vq2Kz0sVq61qrW2kyYjoVJ1CKY2i8BF0n3OeTnBfVA9tmOMfaFg
         GLV9MHShT+s8QRKvQUVFDWj7IW5cS5CYM6y4nnBIAWvL4lSlXFBYubKFLUW93UcXvmEW
         wYn703lb121SfQdWpQtTnZn7ovGneVOdVfKz4TiVRv9JgnGHbBDB7rhlVho6k0z7GvTm
         36GQ==
X-Gm-Message-State: APjAAAVesI8foLBkJyNjQKjTk8UThRW5IeeC+jebb6d7Qv07JFxXRNgq
        OQNgKk/gAPTGdoZZzzyk8Ldy5bAC
X-Google-Smtp-Source: APXvYqx8YVkGeS4X/czdR1f16M2JS/aNyxf6PAMLuFilfIgwsQyr5fC8iCc6B5tAwpXQ/Ge+O0UXpw==
X-Received: by 2002:a24:480e:: with SMTP id p14mr17083208ita.61.1556518874284;
        Sun, 28 Apr 2019 23:21:14 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id c72sm15012662itc.22.2019.04.28.23.21.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 23:21:13 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:21:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/7] mergetool--lib: create gui_mode function
Message-ID: <27a59e1e275f24a857435d3974f1a24fa6a475cd.1556518203.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <cover.1556518203.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556518203.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, in `get_configured_merge_tool`, we would test the value of the
first argument directly, which corresponded to whether we were using
guitool. However, since `$GIT_MERGETOOL_GUI` is available as an
environment variable, create the `gui_mode` function which increases the
clarify of functions which use it.

While we're at it, add a space before `()` in function definitions to
fix the style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 git-mergetool--lib.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index b928179a2e..4ca170c8a7 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -80,14 +80,18 @@ show_tool_names () {
 	}
 }
 
-diff_mode() {
+diff_mode () {
 	test "$TOOL_MODE" = diff
 }
 
-merge_mode() {
+merge_mode () {
 	test "$TOOL_MODE" = merge
 }
 
+gui_mode () {
+	test "$GIT_MERGETOOL_GUI" = true
+}
+
 translate_merge_tool_path () {
 	echo "$1"
 }
@@ -350,8 +354,7 @@ guess_merge_tool () {
 }
 
 get_configured_merge_tool () {
-	# If first argument is true, find the guitool instead
-	if test "$1" = true
+	if gui_mode
 	then
 		gui_prefix=gui
 	fi
@@ -405,7 +408,7 @@ get_merge_tool_path () {
 get_merge_tool () {
 	is_guessed=false
 	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
+	merge_tool=$(get_configured_merge_tool)
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
-- 
2.21.0.1033.g0e8cc1100c

