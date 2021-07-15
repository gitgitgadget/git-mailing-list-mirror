Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37869C636C7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3E2613C7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhGORrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhGORrf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:47:35 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4843EC061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:42 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id f203-20020a379cd40000b02903b861bec838so4345142qke.7
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GCGfhfKz/l4FriIDuLU44x+a/HOwfeht2LqWeP0JsDA=;
        b=MWL7R2UvLVbGip1tdsBk9dQsXJEP/TZCYh3p5+PZauvvrY1ZKzubms3dc7y5SQgw8J
         xEWGUSPFpN0Y8hTe/0Zl5eyunPu0+AYKGDSJcYd8S5qh45c8Qzsit0bQBo5yNYkPB8L+
         eUbevss22d4incluFEa97WQJ5+FeMZdbY0Fld3jaqaj8GY7jksb97kEE/CN8KNmtIZYM
         hNlxUUCsJctvw18IJEE3epiu1eAYl82uPomfPe6c63R8xgLSVLyhm9yiaYyjwdOlH99r
         MulY70qnXZL2fodpRA+nbTDzDcfEBied1nZwPwxyWXoyhZioRh/22GI7lXezDGUlJeQR
         Rjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GCGfhfKz/l4FriIDuLU44x+a/HOwfeht2LqWeP0JsDA=;
        b=A/RfYhVHRzMh5lmxXVsHqR9UM597KJH3HQlRYou1XW7x/n8SBsWcy4ufGdBRx6QUPM
         16Q0LOeUijnYfh7ZM1IW2WlPyDch1DN+/B9oDux7kmV8VOAx4zGILWQoLWbPJPF8oWGt
         CtdN3CBtrDqdfABbrH7wJE5608iikeMwdJdmFLX21P99KBRM1c3vxxFwm3XISjhwNhw4
         DMG6nR+uatj6JnS93Jbe8okwCIUbCKwZeZiIYKKNjeaSE3bB9Nxhyr2f2oQ4hItp2CoH
         VV+4dSBLzclcbn+kC1jNEqy7KWwouLQMgPSq4lDEMqYeXDe7uOe2bV0YrFmFsrFoXCXy
         JS7Q==
X-Gm-Message-State: AOAM533ptvSH8h2+0Kh8M2Lk6u9s032m0tLpbBr1lZejoXIVL0ZZ1F8v
        0L+klriskHeM13L5t2drILEgMgpYeoynQVsGRiJ971TNR/PhF9b/ptt138TfJSLC45bakhryBox
        Sj4hrppRHXb0i1tT8bBC1DKyPzaQiUC9RtuXgG+YTG7ti5dEh7JTTLTaE7gca3VJ+Q8frdjtMbd
        wc
X-Google-Smtp-Source: ABdhPJxX+nnkkGAAtYADJvwlgGEV+Oa74QVzV4uGeXNh/0WW+Tvufw+3dhznD1G51ZzQVZTHNJstm7SdbC/kzb/TxemZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:e4a:: with SMTP id
 o10mr5707937qvc.39.1626371080585; Thu, 15 Jul 2021 10:44:40 -0700 (PDT)
Date:   Thu, 15 Jul 2021 10:44:31 -0700
In-Reply-To: <cover.1626370766.git.jonathantanmy@google.com>
Message-Id: <c8416933035849e40b88c29f1d5fa91064ca0c8a.1626370766.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1624486920.git.jonathantanmy@google.com> <cover.1626370766.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v2 2/3] send-pack: fix push nego. when remote has refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        emilyshaffer@google.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
did not test the case in which a remote advertises at least one ref. In
such a case, "remote_refs" in get_commons_through_negotiation() in
send-pack.c would also contain those refs with a zero ref->new_oid (in
addition to the refs being pushed with a nonzero ref->new_oid). Passing
them as negotiation tips to "git fetch" causes an error, so filter them
out.

(The exact error that would happen in "git fetch" in this case is a
segmentation fault, which is unwanted. This will be fixed in the
subsequent commit.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c                | 6 ++++--
 t/t5516-fetch-push.sh      | 4 +++-
 t/t5549-fetch-push-http.sh | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 9cb9f71650..85945becf0 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -425,8 +425,10 @@ static void get_commons_through_negotiation(const char *url,
 	child.no_stdin = 1;
 	child.out = -1;
 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
-	for (ref = remote_refs; ref; ref = ref->next)
-		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (!is_null_oid(&ref->new_oid))
+			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
+	}
 	strvec_push(&child.args, url);
 
 	if (start_command(&child))
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0916f76302..4db8edd9c8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -201,6 +201,7 @@ test_expect_success 'push with negotiation' '
 	# Without negotiation
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
 	echo now pushing without negotiation &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 push testrepo refs/heads/main:refs/remotes/origin/main &&
@@ -210,6 +211,7 @@ test_expect_success 'push with negotiation' '
 	rm event &&
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
 	grep_wrote 2 event # 1 commit, 1 tree
@@ -219,6 +221,7 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
 	rm event &&
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
 	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
 		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
@@ -1767,5 +1770,4 @@ test_expect_success 'denyCurrentBranch and worktrees' '
 	git -C cloned push origin HEAD:new-wt &&
 	test_must_fail git -C cloned push --delete origin new-wt
 '
-
 test_done
diff --git a/t/t5549-fetch-push-http.sh b/t/t5549-fetch-push-http.sh
index f50d584881..2cdebcb735 100755
--- a/t/t5549-fetch-push-http.sh
+++ b/t/t5549-fetch-push-http.sh
@@ -27,6 +27,7 @@ setup_client_and_server () {
 	git init "$SERVER" &&
 	test_when_finished 'rm -rf "$SERVER"' &&
 	test_config -C "$SERVER" http.receivepack true &&
+	test_commit -C "$SERVER" unrelated_commit &&
 	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
 	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit
 }
-- 
2.32.0.93.g670b81a890-goog

