Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCABF1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933896AbeFYQnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:43:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39292 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933865AbeFYQnl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:43:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so10731803wmc.4
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RZvCbXrrVhLOK8WeeJPUOpAsJgHSSUSRiZ5lSQep2mE=;
        b=d01zZmhixEM9e9EPj1bPVUzmjKoyw1Onyf+O1Ut9s/85JRRIwkQiYF7wArud8Z0ujO
         /6ZHnUKczw+Tw+kxGUv8iiaLjFJa94Hhj40J+xY5Vq8JlI32bCbM0e0os3FWQ1UVVb1s
         MxOFIwzSeXT8HeBv3s02a8yheARM7i1RP/uKZPaXjSQXneIpv+ul02wW+ZzvjPESm3YV
         BO0r8H/DlRraXRxLlbu2nUTK1Bhch9/PeA/PspbInbIcSKyfQyPRO6BUjS8Xtl4Na997
         t4yXyi/i1N3KrXjA4bqlrFz316FbF5d/rr0zjUM8tHxy1pONNGYvAnilv0SyVClfCO2C
         fbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RZvCbXrrVhLOK8WeeJPUOpAsJgHSSUSRiZ5lSQep2mE=;
        b=GepP0U+AqtHTjQwXnzpycSBziajf7uvYBrK3WAweVGSdlZno25/o6n9sMHi2tLReEL
         UOkF7xljDVf/XXFVT9MX8GezV3umk0FbdlYD2F0jTYPKeIs+hJWdR6mNinCVTVttqg8R
         QWUSJZkCzR7JnI2DO/4K/tNJTNs+rMdGMsJmGGc8N2FJIBbOi0jIICMSv6Aor/FUfqBf
         5pQFDglG+U6qDxBTkaH7w8pCPQsXOX2CAFY/Nw9jUZcEKjGLve7clgAD15povGq9mlXT
         f8c4NiR+lrTenPp67vM+wDaOndr3uzey5Qf41/EkwGPBee1GhraFwCclw/xArjbyOpM9
         rTEQ==
X-Gm-Message-State: APt69E18EcTjtz+wgEYF+4+iENfCduo/U5ctJoUWlJRNHVDMow/WBrFj
        TGO8iW+g1NFgw3aWWk/gq4hlTkkU
X-Google-Smtp-Source: AAOMgpf244QLxMdUONaOdbkEkK1HdKeW8/FOx+NaL77tWnvvOwjb50qZMz8CYl4h3CqUleNLHg0JuA==
X-Received: by 2002:a1c:b3c3:: with SMTP id c186-v6mr576694wmf.41.1529945019239;
        Mon, 25 Jun 2018 09:43:39 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id b124-v6sm14287200wmf.11.2018.06.25.09.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:43:37 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 4/4] stash: convert pop to builtin
Date:   Mon, 25 Jun 2018 19:43:26 +0300
Message-Id: <5d5b05caecc01d8f252ef5f8495549663815ed63.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref functions from the shell script now that they
are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 36 ++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index fbf78249c..a38d6ae8a 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,7 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
@@ -24,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -528,6 +533,33 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0, ret;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+	if ((ret = do_apply_stash(prefix, &info, index)))
+		printf_ln(_("The stash entry is kept in case you need it again."));
+	else
+		ret = do_drop_stash(prefix, &info);
+
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *branch = NULL;
@@ -589,6 +621,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
 
diff --git a/git-stash.sh b/git-stash.sh
index 29d9f4425..8f2640fe9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -554,50 +554,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	res=$?
-	cd_to_toplevel
-	return $res
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -655,7 +611,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.18.0.rc2.13.g506fc12fb

