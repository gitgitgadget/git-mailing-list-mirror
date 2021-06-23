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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47962C49EA5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8A061360
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWWdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhFWWdU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:33:20 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1549C061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:31:00 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g4-20020aa787440000b02903020544da0fso2548536pfo.20
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7sMy48GbDfMuXJRbRhMnevYp8Q/DwW33JPUdlInv78k=;
        b=YWamyhQtfFFh2RFL83cTucB3YK/3KrCrxFps/5+Po7rANXIjESrnIlWNZOPb6xhYNp
         pTkSYIwdj4iXqJQiZw2kqstlzi2jIcFXpH5aURCgMgiIMCZ1U4uvqbWbJ1DUPiY98qHf
         5hsPcQVEymyVW8hcLCwrBdvbfnTL2/QctXqirSc0p5ZFkTxPyWLSW3Is1I2uP5Nqr4J0
         e6kQvD8Li+WAXXFQdHvQvUGofhq27byPFTHFXPcDNOCyPzJ7W3KSTuRRGlLC+ViKCdKr
         k3k3LC6Xz1eZ3PjxH8TEUK3YmvfzcKqzMGA0FA8zGPI5MfY/qDlUSfTwJ0v/Pk6SFZS6
         7hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7sMy48GbDfMuXJRbRhMnevYp8Q/DwW33JPUdlInv78k=;
        b=B++RsazT0em7a1BT5fHWPNsoYMxCM4IoxnWl2AUlzqZb9EQRD3RlO535fPB9+eZkcI
         GpKL8KnL3mVGj92eXiEXLrsyPuV/gAo5/zplTG5KpAc95OlSN5Sx7weg6ksYfFPyjmmE
         Glt2WxQJR91ASZmTpYw41BaJYmGxjs6kWmKPVi96XRtzwv28sR6efQiSW2wCzTyNITz+
         BZDN/2/bxwMDByZxnx1QGEmYl+fkV6D61zRKJLA+NGbtEPrwamRGrCCgtJWIlLF/5jf7
         CQOogGZX3y57AJD9hDkV4StlCpUf2pBhkJIMly5uw9sx2AyG3KofyYKY2WWYolc1imJ/
         EAzA==
X-Gm-Message-State: AOAM530dbYWGaalUqQHyxKegaTWo2E8INiTZC8Es7rSa9xsytljmzzAa
        3nggys8JroIuj2qhgEZQA59AjQOgycWbnxZ0+EzoajVvqLDacLTmT43n9qoIdoHTokti4dCd9SU
        2Oa9uBBYFNjHCm/vPNEGLKpyVOxZfPminrzS9TnucI1feyn+cpMIuPMa9dOed5k9VsjtF+UPJc4
        SY
X-Google-Smtp-Source: ABdhPJxG/0jEtW13I6m694TJDMLZhbybeY+R5kHPHfgwugFPEhS1p3Iabtz/tsSoeTZKYtF2Z0MzOw5Tl3wCXZEgbbaD
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8645:b029:fd:25ef:3df7 with
 SMTP id y5-20020a1709028645b02900fd25ef3df7mr1429530plt.48.1624487460163;
 Wed, 23 Jun 2021 15:31:00 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:30:52 -0700
In-Reply-To: <cover.1624486920.git.jonathantanmy@google.com>
Message-Id: <175da5f02b319bb637700e4f6665ee346674e1b0.1624486920.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1624486920.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 2/3] send-pack: fix push nego. when remote has refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
---
 send-pack.c           | 6 ++++--
 t/t5516-fetch-push.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

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
index 5ce32e531a..e383ba662f 100755
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
@@ -1783,6 +1786,7 @@ test_expect_success 'http push with negotiation' '
 	# Without negotiation
 	test_create_repo "$SERVER" &&
 	test_config -C "$SERVER" http.receivepack true &&
+	test_commit -C "$SERVER" unrelated_commit &&
 	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
 	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
@@ -1794,6 +1798,7 @@ test_expect_success 'http push with negotiation' '
 	rm -rf "$SERVER" &&
 	test_create_repo "$SERVER" &&
 	test_config -C "$SERVER" http.receivepack true &&
+	test_commit -C "$SERVER" unrelated_commit &&
 	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
 	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
-- 
2.32.0.288.g62a8d224e6-goog

