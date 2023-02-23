Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6397AC64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 20:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBWUzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBWUzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 15:55:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E0615CB7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:55:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so367326wmq.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHo6iV4PFZ9rA8j/z0NTlhby/vMcGwgJWrgvJGvMzGA=;
        b=OvK8/YWO03R7bTzaOVMOer7ObCS+tyvfBHukGHrjDgV4mPultbIw5NTSDaQPvXzAx2
         BBG+0K8Q3fG5T+VevvCCv2AZJbX1Rm4JKxX4V+7pEsH52Fc1eGirbkceW3+goYkTmAP4
         qDRQ6fIeBssvjo0FHplHXtdsy4GqoLMAqhtK3Xh3uMTzyEkKuly9jHUt2Rbgu1SZY5Pi
         XsBWSgksMntlX4OEhA/cWuQmQoX3Mx9MUIXAbIfWZ6Y3oPEiOaz94Nph5HXKKJEro/3+
         cH1baGaf7nLJhS1BnpiapMA7+qEX+0R7H3FJOuxe/8uQCUPDFbrWEQkm8RiVN3YC/tKx
         UCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHo6iV4PFZ9rA8j/z0NTlhby/vMcGwgJWrgvJGvMzGA=;
        b=m+NH/MSToV9kTljqjw/FoFD8M/MlGteUghhUVcECEWQxlU6K892JPUqVK5BHWLD0im
         I8DFill9KEMFCKF3e23e8xk/3bdxfISv9dnjL0VUJxf7CA4/U/zvfffF/3q3FhvqJYgt
         zA6atta7BQu3uc2SfU29fI3kmDf0P59MU8FiAvfT88W5heegRaEc+SoIQXASGoALIpgb
         tbuPdHz9+BgdxtsevvnxwA0LoBUuhGGL7ssCALGCB1FYeRXI9vzya6FBX9zR2eXmDqRG
         7j081bvsljqg4+vzCkoSW+05HNB94CuEEagIaCbXrBFcp+UkV/Nk36VXa/Uvs0uRPn+D
         owMQ==
X-Gm-Message-State: AO0yUKWhKLgUNTRwhCjWvZAfd3xxlocSAYDQBaeR5slcTFCVbpf13HQB
        ocEJACJpYqrkg3NAkzHrvVc7md3/loQ=
X-Google-Smtp-Source: AK7set84c+c5PrmxeRM1Fg7oxtb6EzLKDm2Ww4KVYRYGmGt7/rM/sTYB0Uyu2y0xgKEPxurpF6OeBQ==
X-Received: by 2002:a05:600c:43c8:b0:3e2:1d1e:78d0 with SMTP id f8-20020a05600c43c800b003e21d1e78d0mr6879535wmn.22.1677185704609;
        Thu, 23 Feb 2023 12:55:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b003e21ba8684dsm507468wms.26.2023.02.23.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 12:55:04 -0800 (PST)
Message-Id: <d670e284c175db67337ca7ce774ecd9afb089736.1677185702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
References: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 20:55:01 +0000
Subject: [PATCH 2/2] rebase -i: fix parsing of "fixup -C<commit>"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user omits the space between "-C" and the commit in a fixup
command then it is parsed as an ordinary fixup and the commit message is
not updated as it should be. Fix this by making the space between "-C"
and "<commit>" optional as it is for the "merge" command.

Note that set_replace_editor() is changed to set $GIT_SEQUENCE_EDITOR
instead of $EDITOR in order to be able to replace the todo list and
reword commits with $FAKE_COMMIT_MESSAGE. This is safe as all the
existing users are using set_replace_editor() to replace the todo list.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                     |  6 ++----
 t/lib-rebase.sh                 |  8 ++++++--
 t/t3437-rebase-fixup-options.sh | 26 ++++++++++++++++++++++++++
 t/test-lib-functions.sh         |  8 ++++++++
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d19ee189b57..9ddae1ce944 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2542,12 +2542,10 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	}
 
 	if (item->command == TODO_FIXUP) {
-		if (skip_prefix(bol, "-C", &bol) &&
-		   (*bol == ' ' || *bol == '\t')) {
+		if (skip_prefix(bol, "-C", &bol)) {
 			bol += strspn(bol, " \t");
 			item->flags |= TODO_REPLACE_FIXUP_MSG;
-		} else if (skip_prefix(bol, "-c", &bol) &&
-				  (*bol == ' ' || *bol == '\t')) {
+		} else if (skip_prefix(bol, "-c", &bol)) {
 			bol += strspn(bol, " \t");
 			item->flags |= TODO_EDIT_FIXUP_MSG;
 		}
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 1d2f0429aea..7ca5b918f04 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -211,6 +211,9 @@ check_reworded_commits () {
 # usage: set_replace_editor <file>
 #
 # Replace the todo file with the exact contents of the given file.
+# N.B. sets GIT_SEQUENCE_EDITOR rather than EDITOR so it can be
+# combined with set_fake_editor to reword commits and replace the
+# todo list
 set_replace_editor () {
 	cat >script <<-\EOF &&
 	cat FILENAME >"$1"
@@ -219,6 +222,7 @@ set_replace_editor () {
 	cat "$1"
 	EOF
 
-	sed -e "s/FILENAME/$1/g" <script | write_script fake-editor.sh &&
-	test_set_editor "$(pwd)/fake-editor.sh"
+	sed -e "s/FILENAME/$1/g" script |
+		write_script fake-sequence-editor.sh &&
+	test_set_sequence_editor "$(pwd)/fake-sequence-editor.sh"
 }
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 274699dadb8..dd3b301fa7a 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -51,6 +51,7 @@ test_expect_success 'setup' '
 	body
 	EOF
 
+	test_commit initial &&
 	test_commit A A &&
 	test_commit B B &&
 	get_author HEAD >expected-author &&
@@ -209,4 +210,29 @@ test_expect_success 'fixup -C works upon --autosquash with amend!' '
 		actual-squash-message
 '
 
+test_expect_success 'fixup -[Cc]<commit> works' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	cat >todo <<-\EOF &&
+	pick A
+	fixup -CA1
+	pick B
+	fixup -cA2
+	EOF
+	(
+		set_replace_editor todo &&
+		FAKE_COMMIT_MESSAGE="edited and fixed up" \
+			git rebase -i initial initial
+	) &&
+	git log --pretty=format:%B initial.. >actual &&
+	cat >expect <<-EOF &&
+	edited and fixed up
+	$EMPTY
+	new subject
+	$EMPTY
+	new
+	body
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 58cfd2f1fda..999d46fafe7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -32,6 +32,14 @@ test_set_editor () {
 	export EDITOR
 }
 
+# Like test_set_editor but sets GIT_SEQUENCE_EDITOR instead of EDITOR
+test_set_sequence_editor () {
+	FAKE_SEQUENCE_EDITOR="$1"
+	export FAKE_SEQUENCE_EDITOR
+	GIT_SEQUENCE_EDITOR='"$FAKE_SEQUENCE_EDITOR"'
+	export GIT_SEQUENCE_EDITOR
+}
+
 test_decode_color () {
 	awk '
 		function name(n) {
-- 
gitgitgadget
