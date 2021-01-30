Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15855C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C9164E0A
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhA3K0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 05:26:55 -0500
Received: from wforward2-smtp.messagingengine.com ([64.147.123.31]:56561 "EHLO
        wforward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230058AbhA3K0w (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Jan 2021 05:26:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailforward.west.internal (Postfix) with ESMTP id 4DC6BCB4;
        Sat, 30 Jan 2021 05:19:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 30 Jan 2021 05:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=wL1XU4E8tIHmFrybImcYE+oBCQWPy
        iupFVU0mglZ7VI=; b=RgrqIs1/QK0n9h6QFK9Us2MYoAzshQ/YIXVP9g49NcI70
        5eMMRcETeztpcReXWyLG6iLCRK/mNHrXvXXaG4dgWG3VStm4i3FEAhMStam90c2K
        JR55V2+M5/1j+xI8FUwy8bgH9Uvjhk3jNw3Bh70Z4qUk0t5NLzLvOXESJmDbG22U
        M+OTqW4MfHIoe20JMEmmWt/qMKFzaeQUNNafkA+U1PD/BV8DO8AkNG5P+g8tWX+h
        MQVf/HQU9U8b6cJmp2CacWLs0asj3TRL02Qekou3unP6v2dB+xc3EdiKN8OYr7T7
        Bh86p9DOgRc+ZBZ7pnAuQwk3Lvpo4VaJvCszRwooA==
X-ME-Sender: <xms:qjIVYOqDi1PmwEByBIwg3U_SB1gjndQrAyAkvmtnIsbi7gi8Td5Upg>
    <xme:qjIVYMqCmbof30DtgNPJz1ozwiBvyt1ghEWIiXNqdNUOd0B_Rp7Q2d81baF5DwysQ
    Uy9qYrmxFXqyIV9eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgjfhestddtredttddttd
    enucfhrhhomhepfdfmhihlvgculfdrucfotgfmrgihfdcuoehmrggtkhihlhgvsehgmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeitdejheegtddvffelfeetudefjefhve
    duieetudeilefhgeekfeekkeejgfevvdenucfkphepjeeirddukedruddvvddrvdefvden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrggtkh
    ihlhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qjIVYDOEdhRHgUh1RSqtvuSyATBpmwh-40iPNuYCmPtUZb38oOgYfw>
    <xmx:qjIVYN6HI48Bi-w03_3q5jjzpueEZhwwyXrmp7GwtQ-FUIdanTrS2A>
    <xmx:qjIVYN4RHt9M_MiBldFYRYGXMxrALbHa2lLQb9jibxwnrwuR6g_LDA>
    <xmx:qjIVYHm0OjTAhdAS1mLdBo25DeKaHBSu6S8VB_CcKSlBzzb7g0cVjkgSX1k>
Received: from localhost.localdomain (unknown [76.18.122.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3DB2424005B;
        Sat, 30 Jan 2021 05:19:22 -0500 (EST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH 2/2] refs.c: avoid creating extra unwanted reflog entries
Date:   Sat, 30 Jan 2021 03:19:09 -0700
Message-Id: <1e8c8e3d23d3c2ddf031e3d7719241c@72481c9465c8b2c4aaff8b77ab5e23c>
In-Reply-To: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 523fa69c36744ae6 ("reflog: cleanse messages in the refs.c
layer", 2020-07-10, v2.29.0), ref log messages are now being "cleansed"
to make sure they do not end up breaking the ref log files.  A laudable
endeavor.

Unfortunately, that commit had an unintended side effect that causes
the `git symbolic-ref <refname1> <refname2>` command to suddenly start
adding new entries to the ref log for <refname1> whenever it's run.

These new entries have a completely empty message and do not provide
any useful information.  In fact, there was no mention that the change
to "cleanse" ref log messages was intended to add these new ref log
entries at all.

What happened is that when the change to "cleanse" the incoming ref
log message was made, the code started inadvertently transforming
a NULL ref log message pointer into an empty string "".

This created the observed effect that using the `symbolic-ref` command
suddenly started causing ref log entries to be added.

The original code that predated the "cleanse" commit called the
`xstrdup_or_null` function to retain the original NULL pointer and
avoid introducing unwanted extra ref log entries.

After the "cleanse" commit, ref log messages are now funnelled through
a new static function named `normalize_reflog_message`.

Eliminate the unwanted extra blank ref log entries by returning a NULL
pointer when NULL is passed into `normalize_reflog_message` rather
than returning a pointer to an empty string ("").

To reflect this new behavior, rename the function to
`normalize_reflog_message_or_null` in the same spirit as the name
of the `xstrdup_or_null` function that was called pre-"cleanse".

Flip the `test_expect_failure` tests to `test_expect_success`
as they now pass again.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 refs.c                   | 16 +++++++++-------
 t/t1417-reflog-symref.sh |  6 +++---
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 03968ad7..790b1ff0 100644
--- a/refs.c
+++ b/refs.c
@@ -835,11 +835,13 @@ static void copy_reflog_msg(struct strbuf *sb, const char *msg)
 	strbuf_rtrim(sb);
 }
 
-static char *normalize_reflog_message(const char *msg)
+static char *normalize_reflog_message_or_null(const char *msg)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (msg && *msg)
+	if (!msg)
+		return NULL;
+	if (*msg)
 		copy_reflog_msg(&sb, msg);
 	return strbuf_detach(&sb, NULL);
 }
@@ -1067,7 +1069,7 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if (flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
-	update->msg = normalize_reflog_message(msg);
+	update->msg = normalize_reflog_message_or_null(msg);
 	return update;
 }
 
@@ -1951,7 +1953,7 @@ int refs_create_symref(struct ref_store *refs,
 	char *msg;
 	int retval;
 
-	msg = normalize_reflog_message(logmsg);
+	msg = normalize_reflog_message_or_null(logmsg);
 	retval = refs->be->create_symref(refs, ref_target, refs_heads_master,
 					 msg);
 	free(msg);
@@ -2339,7 +2341,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 	char *msg;
 	int retval;
 
-	msg = normalize_reflog_message(logmsg);
+	msg = normalize_reflog_message_or_null(logmsg);
 	retval = refs->be->delete_refs(refs, msg, refnames, flags);
 	free(msg);
 	return retval;
@@ -2357,7 +2359,7 @@ int refs_rename_ref(struct ref_store *refs, const char *oldref,
 	char *msg;
 	int retval;
 
-	msg = normalize_reflog_message(logmsg);
+	msg = normalize_reflog_message_or_null(logmsg);
 	retval = refs->be->rename_ref(refs, oldref, newref, msg);
 	free(msg);
 	return retval;
@@ -2374,7 +2376,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 	char *msg;
 	int retval;
 
-	msg = normalize_reflog_message(logmsg);
+	msg = normalize_reflog_message_or_null(logmsg);
 	retval = refs->be->copy_ref(refs, oldref, newref, msg);
 	free(msg);
 	return retval;
diff --git a/t/t1417-reflog-symref.sh b/t/t1417-reflog-symref.sh
index 6149531f..3687b058 100755
--- a/t/t1417-reflog-symref.sh
+++ b/t/t1417-reflog-symref.sh
@@ -53,7 +53,7 @@ test_expect_success setup '
 	test $hcnt -ne $kcnt
 '
 
-test_expect_failure 'HEAD reflog symbolic-ref' '
+test_expect_success 'HEAD reflog symbolic-ref' '
 	hcnt1=$(git reflog show HEAD | wc -l) &&
 	git symbolic-ref HEAD refs/heads/unu &&
 	git symbolic-ref HEAD refs/heads/du &&
@@ -62,7 +62,7 @@ test_expect_failure 'HEAD reflog symbolic-ref' '
 	test $hcnt1 = $hcnt2
 '
 
-test_expect_failure 'refs/heads/KVAR reflog symbolic-ref' '
+test_expect_success 'refs/heads/KVAR reflog symbolic-ref' '
 	kcnt1=$(git reflog show refs/heads/KVAR | wc -l) &&
 	git symbolic-ref refs/heads/KVAR refs/heads/tri &&
 	git symbolic-ref refs/heads/KVAR refs/heads/du &&
@@ -71,7 +71,7 @@ test_expect_failure 'refs/heads/KVAR reflog symbolic-ref' '
 	test $kcnt1 = $kcnt2
 '
 
-test_expect_failure 'double symref reflog symbolic-ref' '
+test_expect_success 'double symref reflog symbolic-ref' '
 	hcnt1=$(git reflog show HEAD | wc -l) &&
 	kcnt1=$(git reflog show refs/heads/KVAR | wc -l) &&
 	git symbolic-ref HEAD refs/heads/KVAR &&
-- 
