Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC3C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CBA61352
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbhI2B44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbhI2B4y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:56:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B68C061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y15so1088081ilu.12
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=plmzWDKNttTf3F4mYoAK+PUPvE5Sb6Lxr4ohnq+wxTg=;
        b=XAe46bSNMocKc0pmOTm9envxLWIs9DVh+CjGYFjJXkUXEjcwhhlxlEg9UIDRHGTIIT
         yy3wJ8jo46cRGpk3kLwgflEAv5gIWNlSsPW6irEZ9ZVyutKaicXgjOP14Q8AeaIQUy1r
         vp3TeAE5Bxzemw2n0dNWbcakUYRZcuQZqm2xbZ/8wykk3TXEoBvP+53ZTTG9FfbC6nFi
         9caKnu4cm8I1EOztTEXB8fEltVWX2wZdhWzFLNoXOH57ru6iGJem9ApuOzMJdQpjsa8z
         bUaHdPG1qej4J9dhciy+5G6lQ85o2uJRBqVDCf38us8hVuBj85OzNltraLik/ffTE9Mh
         NnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=plmzWDKNttTf3F4mYoAK+PUPvE5Sb6Lxr4ohnq+wxTg=;
        b=lCJiG8FRJxlnUAlHTwiwgW5WymAdy3xBD6kOZKpSC0HlPkyxsd9N+G0LgpRh7+BkMS
         tSDQHtvKpZWY1dP6TeuYyInjWfGboJSo6NS4dwRTP7GLJXvrHAJGYJNw7SCyRDCaD4+a
         gBUGxCWlyAn18S9mwHBhIg3vmxgFFWect7cfoLdr+VjXt3yRtp2lcCcjIxPCKHWI2eNJ
         5JZNkTCbuIjjWyrw8h67LbDdTQVD20vVAWgj/bA/tdz+2KZKLF57sHrLyP2OS3TVfQSE
         F4ByJBNnad+dVyrYD4gKvKBBPHjKWxK/1Q0lMtPaFlOLV1iayUMH9yoNPX2Nswnbc0gU
         YUOg==
X-Gm-Message-State: AOAM530FUyyYhiup7hu3UpZjSghOfzMMNEQ01a/cMVtgd9o44IDOfZu2
        hLCxrHQwvggb5g3ib2uJrl+z7ROLsNT8MQ==
X-Google-Smtp-Source: ABdhPJw2tV/ERlXh76cLxH2N37qkUsvRjFThrylNxW40W1oVnk/Xd9k5ABiOkyEhs5vSm2AVnYKaPQ==
X-Received: by 2002:a05:6e02:10c4:: with SMTP id s4mr6334250ilj.285.1632880513863;
        Tue, 28 Sep 2021 18:55:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u14sm588993iob.18.2021.09.28.18.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:13 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 5/9] builtin/repack.c: rename variables that deal with
 non-kept packs
Message-ID: <15831a201a99534063b81f9bba81ed88f766f46e.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new variable `existing_kept_packs` (and corresponding parameter
`fname_kept_list`) added by the previous patch make it seem like
`existing_packs` and `fname_list` are each subsets of the other two
respectively.

In reality, each pair is disjoint: one stores the packs without .keep
files, and the other stores the packs with .keep files. Rename each to
more clearly reflect this.

Suggested-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 39f11df675..5539ec7e89 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -94,12 +94,12 @@ static void remove_pack_on_signal(int signo)
 }
 
 /*
- * Adds all packs hex strings to either fname_list or fname_kept_list
- * based on whether each pack has a corresponding .keep file or not.
- * Packs without a .keep file are not to be kept if we are going to
- * pack everything into one file.
+ * Adds all packs hex strings to either fname_nonkept_list or
+ * fname_kept_list based on whether each pack has a corresponding
+ * .keep file or not.  Packs without a .keep file are not to be kept
+ * if we are going to pack everything into one file.
  */
-static void collect_pack_filenames(struct string_list *fname_list,
+static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 				   struct string_list *fname_kept_list,
 				   const struct string_list *extra_keep)
 {
@@ -127,7 +127,7 @@ static void collect_pack_filenames(struct string_list *fname_list,
 		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
 			string_list_append_nodup(fname_kept_list, fname);
 		else
-			string_list_append_nodup(fname_list, fname);
+			string_list_append_nodup(fname_nonkept_list, fname);
 	}
 	closedir(dir);
 }
@@ -440,7 +440,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
-	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
@@ -574,13 +574,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
-	collect_pack_filenames(&existing_packs, &existing_kept_packs,
+	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
 			       &keep_pack_list);
 
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing_packs.nr && delete_redundant) {
+		if (existing_nonkept_packs.nr && delete_redundant) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
 					     packtmp_name, item->string);
@@ -690,7 +690,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (pack_everything & ALL_INTO_ONE) {
 			const int hexsz = the_hash_algo->hexsz;
 			string_list_sort(&names);
-			for_each_string_list_item(item, &existing_packs) {
+			for_each_string_list_item(item, &existing_nonkept_packs) {
 				char *sha1;
 				size_t len = strlen(item->string);
 				if (len < hexsz)
@@ -743,7 +743,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
-	string_list_clear(&existing_packs, 0);
+	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
 	strbuf_release(&line);
-- 
2.33.0.96.g73915697e6

