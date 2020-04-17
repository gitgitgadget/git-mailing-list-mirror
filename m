Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429FC3815B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06A4207FC
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjXGOdVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDQJpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDQJpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 05:45:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6BCC061A0F
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a32so868008pje.5
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmGCmv5C3mkznvYS92yE96WIX4hxINifuURYzvo4Wag=;
        b=SjXGOdVaon8qCVF88o6a3dWsVSMMc7BmOHJFVUYMzFv0DFhRIea4HEFlG0Wz3mE2XF
         23NuePivFCQzTWthEBN7GjvFck+R5Vz+f1Ut58XNhivVzGK1MkrrcEumq8kBBYzHgMIW
         CfmZLAKhe6DbrFIL2TvUyiOVSMP3zDa8pYePvr4KfjFs7w9d0hQfiOU+0XQvIOkcw68f
         zIAOfZRCoNHYFf+G5Ijreyc4iRVyri29E6eYHkzOhbTT5mnsNT5H7kBMpPToPSNune2a
         YmIEb9ARhTmwxgSXgkXKgX9S14khv6o6U0vZ4BdYfIPAE8bBBOjrZIzfr41sK/gq3RMT
         DZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmGCmv5C3mkznvYS92yE96WIX4hxINifuURYzvo4Wag=;
        b=X4qZf57TIR43O+mcJOoMeTariRvshQGOo5T3dakI9B50RB4o1kdhwX1piRBovDvJ+l
         lf02NBQVMi16NILI14HcVgN2pY/ywRFyJ9DibHkCXXyFlEgbjjJeDjU2xLYnc87uzlR/
         zV1cdNRm8JFDA3ijDERPCz8zHNN+2nh3SQoHPK8ltmEfvSw1jg8WuNIRVUdil8UzkLFA
         gs1PR5lyX1XYWx1ZSW8xT/ir3Bl4F654uz0/yIOc6sD4aKR3VkmWnUQIywwwPaAy5diB
         sFy8RkVPWRd2jnaPOVALDIlPHjRvImNFaJafcvbl8StPr3jUdP09VxU5bNTVZ3FmEi73
         Iu3w==
X-Gm-Message-State: AGi0PuZuenqI07I6qHIWXhb+7H+5kjGTsTymlBDMw9XUmSX4yBwYmwNa
        UMgOCkaNUQvQc9/JRmNid5K3mLtXeJk=
X-Google-Smtp-Source: APiQypJ7MYdKecoZRs4SsTCN76TMbCUz+N7hhbEoh+Ng4AoT71kRloADheTCf3tM79kwFV4JotlwcA==
X-Received: by 2002:a17:90b:3014:: with SMTP id hg20mr3450880pjb.56.1587116742054;
        Fri, 17 Apr 2020 02:45:42 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q145sm4790979pfq.105.2020.04.17.02.45.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 02:45:41 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 1/5] send-pack: fix inconsistent porcelain output
Date:   Fri, 17 Apr 2020 05:45:32 -0400
Message-Id: <20200417094536.9463-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200416162415.5751-1-worldhello.net@gmail.com>
References: <20200416162415.5751-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The porcelain output of a failed `git-push` command is inconsistent for
different protocols.  For example, the following `git-push` command
may fail due to the failure of the `pre-receive` hook.

    git push --porcelain origin HEAD:refs/heads/master

For SSH protocol, the porcelain output does not end with a "Done"
message:

	To <URL/of/upstream.git>
	!  HEAD:refs/heads/master  [remote rejected] (pre-receive hook declined)

While for HTTP protocol, the porcelain output does end with a "Done"
message:

	To <URL/of/upstream.git>
	!  HEAD:refs/heads/master  [remote rejected] (pre-receive hook declined)
	Done

The following code at the end of function `send_pack()` indicates that
`send_pack()` should not return an error if some references are rejected
in porcelain mode.

    int send_pack(...)
        ... ...

        if (args->porcelain)
            return 0;

        for (ref = remote_refs; ref; ref = ref->next) {
            switch (ref->status) {
            case REF_STATUS_NONE:
            case REF_STATUS_UPTODATE:
            case REF_STATUS_OK:
                break;
            default:
                return -1;
            }
        }
        return 0;
    }

So if atomic push failed, must check the porcelain mode before return
an error.  And `receive_status()` should not return an error for a
failed updated reference, because `send_pack()` will check them instead.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c                     |   7 +-
 t/t5504-fetch-receive-strict.sh |   1 +
 t/t5516-fetch-push.sh           |   1 +
 t/t5548-push-porcelain.sh       | 280 ++++++++++++++++++++++++++++++++
 transport.c                     |  10 +-
 5 files changed, 294 insertions(+), 5 deletions(-)
 create mode 100755 t/t5548-push-porcelain.sh

diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..1835cd5582 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -190,10 +190,8 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 
 		if (reader->line[0] == 'o' && reader->line[1] == 'k')
 			hint->status = REF_STATUS_OK;
-		else {
+		else
 			hint->status = REF_STATUS_REMOTE_REJECT;
-			ret = -1;
-		}
 		hint->remote_status = xstrdup_or_null(msg);
 		/* start our next search from the next ref */
 		hint = hint->next;
@@ -489,7 +487,8 @@ int send_pack(struct send_pack_args *args,
 			if (use_atomic) {
 				strbuf_release(&req_buf);
 				strbuf_release(&cap_buf);
-				return atomic_push_failure(args, remote_refs, ref);
+				atomic_push_failure(args, remote_refs, ref);
+				return args->porcelain ? 0 : -1;
 			}
 			/* else fallthrough */
 		default:
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 645b4c78d3..a32efe2b6c 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -65,6 +65,7 @@ test_expect_success 'fetch with transfer.fsckobjects' '
 cat >exp <<EOF
 To dst
 !	refs/heads/master:refs/heads/test	[remote rejected] (missing necessary objects)
+Done
 EOF
 
 test_expect_success 'push without strict' '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9ff041a093..9c6218f568 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1066,6 +1066,7 @@ test_expect_success 'push --porcelain rejected' '
 
 	echo >.git/foo  "To testrepo"  &&
 	echo >>.git/foo "!	refs/heads/master:refs/heads/master	[remote rejected] (branch is currently checked out)" &&
+	echo >>.git/foo "Done" &&
 
 	test_must_fail git push >.git/bar --porcelain  testrepo refs/heads/master:refs/heads/master &&
 	test_cmp .git/foo .git/bar
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
new file mode 100755
index 0000000000..96ba449a38
--- /dev/null
+++ b/t/t5548-push-porcelain.sh
@@ -0,0 +1,280 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Jiang Xin
+#
+test_description='Test git push porcelain output'
+
+. ./test-lib.sh
+
+# Create commits in <repo> and assign each commit's oid to shell variables
+# given in the arguments (A, B, and C). E.g.:
+#
+#     create_commits_in <repo> A B C
+#
+# NOTE: Never calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" &&
+	if ! parent=$(git -C "$repo" rev-parse HEAD^{} --)
+	then
+		parent=
+	fi &&
+	T=$(git -C "$repo" write-tree) &&
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		test_tick &&
+		if test -z "$parent"
+		then
+			oid=$(echo $name | git -C "$repo" commit-tree $T)
+		else
+			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
+		fi &&
+		eval $name=$oid &&
+		parent=$oid &&
+		shift ||
+		return 1
+	done &&
+	git -C "$repo" update-ref refs/heads/master $oid
+}
+
+# Format the output of git-push, git-show-ref and other commands to make a
+# user-friendly and stable text.  We can easily prepare the expect text
+# without having to worry about future changes of the commit ID and spaces
+# of the output.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/  *\$//" \
+		-e "s/   */ /g" \
+		-e "s/	/    /g" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
+		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
+}
+
+setup_upstream_and_workbench () {
+	# Upstream  after setup : master(B)  foo(A)  bar(A)  baz(A)
+	# Workbench after setup : master(A)
+	test_expect_success "setup upstream repository and workbench" '
+		rm -rf upstream.git workbench &&
+		git init --bare upstream.git &&
+		git init workbench &&
+		create_commits_in workbench A B &&
+		(
+			cd workbench &&
+			# Try to make a stable fixed width for abbreviated commit ID,
+			# this fixed-width oid will be replaced with "<OID>".
+			git config core.abbrev 7 &&
+			git remote add origin ../upstream.git &&
+			git update-ref refs/heads/master $A &&
+			git push origin \
+				$B:refs/heads/master \
+				$A:refs/heads/foo \
+				$A:refs/heads/bar \
+				$A:refs/heads/baz
+		) &&
+		git -C "workbench" config advice.pushUpdateRejected false &&
+		upstream=upstream.git
+	'
+}
+
+run_git_push_porcelain_output_test() {
+	case $1 in
+	http)
+		PROTOCOL="HTTP protocol"
+		URL_PREFIX="http://.*"
+		;;
+	file)
+		PROTOCOL="builtin protocol"
+		URL_PREFIX="\.\."
+		;;
+	esac
+
+	# Refs of upstream : master(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: master(A)                  baz(A)  next(A)
+	# git-push         : master(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "porcelain output of successful git-push ($PROTOCOL)" '
+		(
+			cd workbench &&
+			git update-ref refs/heads/master $A &&
+			git update-ref refs/heads/baz $A &&
+			git update-ref refs/heads/next $A &&
+			git push --porcelain --force origin \
+				master \
+				:refs/heads/foo \
+				$B:bar \
+				baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		=    refs/heads/baz:refs/heads/baz    [up to date]
+		     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
+		-    :refs/heads/foo    [deleted]
+		+    refs/heads/master:refs/heads/master    <OID-B>...<OID-A> (forced update)
+		*    refs/heads/next:refs/heads/next    [new branch]
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
+	# git-push         : master(B)  bar(A)  NULL    next(A)
+	test_expect_success "atomic push failed ($PROTOCOL)" '
+		(
+			cd workbench &&
+			git update-ref refs/heads/master $B &&
+			git update-ref refs/heads/bar $A &&
+			test_must_fail git push --atomic --porcelain origin \
+				master \
+				bar \
+				:baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
+		!    (delete):refs/heads/baz    [rejected] (atomic push failed)
+		!    refs/heads/master:refs/heads/master    [rejected] (atomic push failed)
+		!    refs/heads/next:refs/heads/next    [rejected] (atomic push failed)
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
+	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
+		write_script "$upstream/hooks/pre-receive" <<-EOF
+		exit 1
+		EOF
+	'
+
+	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
+	# git-push         : master(B)  bar(A)  NULL    next(A)
+	test_expect_success "pre-receive hook declined ($PROTOCOL)" '
+		(
+			cd workbench &&
+			git update-ref refs/heads/master $B &&
+			git update-ref refs/heads/bar $A &&
+			test_must_fail git push --porcelain --force origin \
+				master \
+				bar \
+				:baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		=    refs/heads/next:refs/heads/next    [up to date]
+		!    refs/heads/bar:refs/heads/bar    [remote rejected] (pre-receive hook declined)
+		!    :refs/heads/baz    [remote rejected] (pre-receive hook declined)
+		!    refs/heads/master:refs/heads/master    [remote rejected] (pre-receive hook declined)
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
+	test_expect_success "remove pre-receive hook ($PROTOCOL)" '
+		rm "$upstream/hooks/pre-receive"
+	'
+
+	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
+	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
+	# git-push         : master(B)  bar(A)  NULL    next(A)
+	test_expect_success "non-fastforward push ($PROTOCOL)" '
+		(
+			cd workbench &&
+			test_must_fail git push --porcelain origin \
+				master \
+				bar \
+				:baz \
+				next
+		) >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		To <URL/of/upstream.git>
+		=    refs/heads/next:refs/heads/next    [up to date]
+		-    :refs/heads/baz    [deleted]
+		     refs/heads/master:refs/heads/master    <OID-A>..<OID-B>
+		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
+		Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-B> refs/heads/master
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+}
+
+# Initialize the upstream repository and local workbench.
+setup_upstream_and_workbench
+
+# Run git-push porcelain test on builtin protocol
+run_git_push_porcelain_output_test file
+
+ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+start_httpd
+
+# Re-initialize the upstream repository and local workbench.
+setup_upstream_and_workbench
+
+test_expect_success "setup for http" '
+	git -C upstream.git config http.receivepack true &&
+	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
+	mv upstream.git "$upstream" &&
+
+	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
+'
+
+setup_askpass_helper
+
+# Run git-push porcelain test on HTTP protocol
+run_git_push_porcelain_output_test http
+
+test_done
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..13d638d5fe 100644
--- a/transport.c
+++ b/transport.c
@@ -715,7 +715,15 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	close(data->fd[1]);
 	close(data->fd[0]);
-	ret |= finish_connect(data->conn);
+	/*
+	 * Atomic push may abort the connection early and close the pipe,
+	 * which may cause an error for `finish_connect()`. Ignore this error
+	 * for atomic git-push.
+	 */
+	if (ret || args.atomic)
+		finish_connect(data->conn);
+	else
+		ret = finish_connect(data->conn);
 	data->conn = NULL;
 	data->got_remote_heads = 0;
 
-- 
2.24.1.15.g448c31058d.agit.4.5

