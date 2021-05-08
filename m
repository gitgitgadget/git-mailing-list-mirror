Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA071C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 05:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D4F61458
	for <git@archiver.kernel.org>; Sat,  8 May 2021 05:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEHFBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 01:01:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42801 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229467AbhEHFBt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 May 2021 01:01:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 92FC95C014D;
        Sat,  8 May 2021 01:00:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 08 May 2021 01:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oUAiBB0Tx7T3iNlVIkY85AwdLXL
        pXq826PE6cW5xpjY=; b=LV9yLpezuWUMur1CLOvX497AXSdEWmTZziQWBOjqLO1
        vPkAFIkOpyD+GZWeFH3nywbn1aTOXkoO5T4kAZMxEATfUrItX1ZKEqmIZucwMfIV
        Gl4ZSwmu/PrzNXmF/VK1WugQRAHwSglYNAnill1I69DHf4vUx5hXMTO9xmhDNSbS
        HULMtxfUICtTfGuyH+BrMy7WysgHMvSqpFIpuFu09qafLBwMZzGqTeAJVtEeOEkq
        ta2h8u2gPbhDY8TKgiHkwJIaM2j1NdlE3MXcHfXkHbC9OAQBWZWuWiWDlTyljQMH
        Mkop7DWoFdxrFIH/ocTgydAgZUKGMQ1WuGzCGx/CE6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oUAiBB
        0Tx7T3iNlVIkY85AwdLXLpXq826PE6cW5xpjY=; b=fXaTBbbfxDstckvwFNW5vk
        uivcI7YpQBxlVPBO05Tw98MoXoAqy2rXL3TZQOalIWsQoAiL+wcCgy1Aq15G4Pz/
        /hP4jjLskPud1eM7bAQd+Pmv9izxlaa+/L6XCSnw12Htou11Vr9lF2SyH4A6FSKc
        Msk4LQKh2szmvsIkjA+x7QynMIUqjNUg7PUlAB53Jgn4tMhWRaWppl5ebTv1ij7d
        iF0rwSK6KECQOWzBXaQy6AiqzU0yY/n3DcjnWy5VyvriMkpdF2mw5SPBGZEdfnmY
        wTGIJsRgFHbvEepadtXzbipBkPdwjVsYfW3L2CYUZ/k23vPrsDLzdxKxUsjZpxcg
        ==
X-ME-Sender: <xms:_RqWYPBAfUxyaX-X9xbPZ1FspaYKcYMGcF8N3G0Prptff28ZOHUxiQ>
    <xme:_RqWYFhi4l62cZgKq7Sx-NPnfNNN4MuS2RaU_SZa8fDPBVVYzgxjca6vFJsfIDTLo
    SjynOXbGG14nfDUazs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtjeenucfhrhhomhephghilhhlucevhhgrnhgulhgvrhcuoeiffhgtseiffhgthhgr
    nhgulhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhepgfdttefggfeludfgffeutdfhue
    etvdeikeehgeeihfeugffgueeutdeuheduieeinecukfhppeejhedruddukedrfedrudeg
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiffh
    gtseiffhgthhgrnhgulhgvrhdrohhrgh
X-ME-Proxy: <xmx:_RqWYKlHP7vlImJRxZfrDt4Z3ZwrteO4XvTJsuE8eeOJNY9kZ6pjlg>
    <xmx:_RqWYBzFAnc1Cgy7zIwJk1TPEqrptbcPq4fVQS0jYR8ggx4CevZrgA>
    <xmx:_RqWYETZWGNs47IM1rv49ZpXCQ3-IGi9mp-GAJ0OkDXHw9p1uTFxsg>
    <xmx:_hqWYN5QZOuH_8efOSbGPEujvhnyKl4hMBOLX9pPAT-OEJKbqsab5A>
Received: from mini.wfchandler.org (d118-75-149-3.try.wideopenwest.com [75.118.3.149])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sat,  8 May 2021 01:00:45 -0400 (EDT)
Date:   Sat, 8 May 2021 01:00:43 -0400
From:   Will Chandler <wfc@wfchandler.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJYa+7yUyt2YD16r@mini.wfchandler.org>
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
 <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
 <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
 <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
 <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: [PATCH v2] refs: cleanup directories when deleting packed ref

When deleting a packed ref via 'update-ref -d', a lockfile is made in
the directory that would contain the loose copy of that ref, creating
any directories in the ref's path that do not exist. When the
transaction completes, the lockfile is deleted, but any empty parent
directories made when creating the lockfile are left in place.  These
empty directories are not removed by 'pack-refs' or other housekeeping
tasks and will accumulate over time.

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
index e31f65f381..4506cd435b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1598,4 +1598,13 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
 	test_must_fail git show-ref --verify refs/heads/restart
 '
 
+test_expect_success 'directory not created deleting packed ref' '
+	git branch d1/d2/r1 HEAD &&
+	git pack-refs --all &&
+	test_path_is_missing .git/refs/heads/d1/d2 &&
+	git update-ref -d refs/heads/d1/d2/r1 &&
+	test_path_is_missing .git/refs/heads/d1/d2 &&
+	test_path_is_missing .git/refs/heads/d1
+'
+
 test_done
-- 
2.30.2

