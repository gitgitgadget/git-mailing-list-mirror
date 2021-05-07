Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C84C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 14:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA748610F7
	for <git@archiver.kernel.org>; Fri,  7 May 2021 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhEGOi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 10:38:28 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37607 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233545AbhEGOi2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 10:38:28 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 248E5126C;
        Fri,  7 May 2021 10:37:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 07 May 2021 10:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=date:from:to:cc:subject:message-id:mime-version:content-type;
         s=fm1; bh=ci1g4uVv7+4GyTvVNLRQOCWSQpVNmyrZrl7Qtwta8jE=; b=ZQh1h
        JNrsJhOgTzAegTSrt/oAZFls5IAc6g0oBvmIXCCbzYKj4vQbRtYYNsBaoSj396jd
        UBi/uF2ejGQB8wRfhAvJDpNPgjqBGZJ7N2rEJWNzZ/FwCpnx7l7nVJdV2kZDCUuK
        fgYPGmOXVNN0qBRAKBak4/jNftbvA6cEjUHWBvP8yvtxxKpP6oQsiC+4Dwh5BQpA
        J67JC+MosII5EwYzrZlXcVDO91apT0LMO3HUtqNJ829anjXlgSPDkhY2yH5Kvv9S
        Z+He/K7vP8PE/9zsvwgseDVhvmxeVmL57qeki0LSfJzcz3oJvYBPaf5WjzctZ8tN
        InUG+Etf531dOOj1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ci1g4uVv7+4GyTvVNLRQOCWSQpVNm
        yrZrl7Qtwta8jE=; b=uKXNjnQYpXrbr7D/feFshUM8CxHtJ39Dd3kL572JTXAef
        /9/DlQ6xxXMiPbGloswPUI9uRjZwpK2hVe/LmfN+JbIDHX0cWGO/VP4NABNXNce9
        6gE/HCFRSkYtZiIqC20Va0E59uEbM4Dp6FnOGQbKznQlLHb3Ph7JrHmygJN28p/L
        0j3Zk9lB5rZav1LJ3ejp98GTcTJC++JrN9My46bfoLZ7ssq/DWOHHegRCvoDM1Re
        +9wsrh7oP9nK5R2an8aWx/20F17/4nUeP00EqLGT4oSn4yLm3vjjecCLOt69VqhB
        PNS1TelrdNttB5NU2r0uxn+f26zc0Z3vE5M5wrtww==
X-ME-Sender: <xms:p1CVYJRyI0AobYhlyB10hcBf5oerQ9Zg_ALzjwH9VK-K2s7qgXOS1Q>
    <xme:p1CVYCzdbmh7VBbpxFhoy6qFP1ApGNQhvDXNfiZrYgHZXWrH8bKaUZ0aOKJ9reQx4
    CDMDwclieYgukmUeao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtjeenucfhrhhomhephghilhhlucevhhgrnhgulhgvrhcuoeiffhgtseiffhgthhgrnhgu
    lhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhepteelveffheektdeujeefkeduvdethe
    elvddtheetvedtffefveeuuefgvdduleejnecukfhppeejhedruddukedrfedrudegleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiffhgtse
    iffhgthhgrnhgulhgvrhdrohhrgh
X-ME-Proxy: <xmx:p1CVYO0L2hWt8wyGxOsbq6WNtTc3I0TVtaKrGercAVkQEzBdzcwXtQ>
    <xmx:p1CVYBBu7f2a2XVRqvC7ySJDLpJhzhn460XtmMJ_VgfZqNQ7awCdYg>
    <xmx:p1CVYCgB_gHENOPpQG7Ueu4yX42m58S6meuA0YBOmzILebt4ZCFEwQ>
    <xmx:p1CVYIcJyQydms1RRskYUUWOH5gfYoo7xwEN7tPo4-MJZpBJX3TdiA>
Received: from mini.wfchandler.org (d118-75-149-3.try.wideopenwest.com [75.118.3.149])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri,  7 May 2021 10:37:27 -0400 (EDT)
Date:   Fri, 7 May 2021 10:37:25 -0400
From:   Will Chandler <wfc@wfchandler.org>
To:     git@vger.kernel.org
Cc:     ps@pks.im
Subject: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When deleting a packed ref, a lockfile is made in the directory that
would contain the loose copy of that ref, creating any directories in
the ref's path that do not exist. When the transaction completes, the
lockfile is deleted, but any empty parent directories made when creating
the lockfile are left in place.  These empty directories are not removed
by 'pack-refs' or other housekeeping tasks and will accumulate over
time.

When deleting a loose ref, we remove all empty parent directories at the
end of the transaction.

This commit applies the parent directory cleanup logic used when
deleting loose refs to packed refs as well.

Signed-off-by: Will Chandler <wfc@wfchandler.org>
---
 refs/files-backend.c  | 12 ++++++------
 t/t1400-update-ref.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 119972ee16..49e6ee069a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -45,10 +45,10 @@
 #define REF_UPDATE_VIA_HEAD (1 << 8)
 
 /*
- * Used as a flag in ref_update::flags when the loose reference has
- * been deleted.
+ * Used as a flag in ref_update::flags when a reference has been
+ * deleted and the ref's parent directories may need cleanup.
  */
-#define REF_DELETED_LOOSE (1 << 9)
+#define REF_DELETED_RMDIR (1 << 9)
 
 struct ref_lock {
 	char *ref_name;
@@ -2852,6 +2852,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY)) {
+			update->flags |= REF_DELETED_RMDIR;
 			if (!(update->type & REF_ISPACKED) ||
 			    update->type & REF_ISSYMREF) {
 				/* It is a loose reference. */
@@ -2861,7 +2862,6 @@ static int files_transaction_finish(struct ref_store *ref_store,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
 				}
-				update->flags |= REF_DELETED_LOOSE;
 			}
 		}
 	}
@@ -2874,9 +2874,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		if (update->flags & REF_DELETED_LOOSE) {
+		if (update->flags & REF_DELETED_RMDIR) {
 			/*
-			 * The loose reference was deleted. Delete any
+			 * The reference was deleted. Delete any
 			 * empty parent directories. (Note that this
 			 * can only work because we have already
 			 * removed the lockfile.)
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e31f65f381..adae9ef91f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1598,4 +1598,13 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
 	test_must_fail git show-ref --verify refs/heads/restart
 '
 
+test_expect_success 'directory not created deleting packed ref' '
+	git branch d1/d2/r1 HEAD &&
+	git pack-refs --all &&
+	test_path_is_missing .git/refs/heads/d1/d2 &&
+	git branch -d d1/d2/r1 &&
+	test_path_is_missing .git/refs/heads/d1/d2 &&
+	test_path_is_missing .git/refs/heads/d1
+'
+
 test_done
-- 
2.30.2

