Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8561F731
	for <e@80x24.org>; Thu,  1 Aug 2019 16:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfHAQQW (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 12:16:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34425 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfHAQQW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 12:16:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so32447894plt.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsIp4oYn0HlNKz7anghHI6Lya8u90wtCs4lmVjSs9mY=;
        b=Qns2KQdR9hfh6yQywbgU+zfY5smbvuIofaGszi3b3LddEuRixAWNJKEQX9wicCLb2s
         bQZNd+DdiIxpPiVA1Dt3qE/vRqqbkz+ZoMQ5xgN1vlYzBYYk86ebLnqeZwpBWcFsURs+
         ELK2RAl69bBRkMkGTJAdoEsZK0noFyrWyMocME4K99/oFPcBSAmVmPrg6U7e87U61CtG
         payKvUWrS5byCYp7KkPWDdP/GHN+ExDBtbPoswkEWNC5irBgaB+qqBq8MvWWp7QBG79m
         KosTvw36Fa5TVytvQm5WDLDw8xNOX/zJuMJiBrDUTlCNQlyp2nsajtXf7bUhQfRnNqmO
         MG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsIp4oYn0HlNKz7anghHI6Lya8u90wtCs4lmVjSs9mY=;
        b=nhivDhOu9oTt4DgRQ89T5oi96e+iT80LHRO+PuUVtTuhHQ80xkmFFIF1uksvm1X2hh
         PhjXPxqsFuvcCuK6hguS1RXSo2Q32FdCGrGr60L5nA000ethlPU+6YE+vi3L4n9wA9tx
         xuSQ5alRhzMqsGOrZoZiprM3uL+G6rsmsF/WcVdMdtBxUDPub5Vmwp53UVynqAcFdkXo
         Z1y7/9EsPH1Tm5prk6eM5ZTd/4I+RkSxlACw/XSVBumTFN8ta1MURVL79NwkgMlcBpgc
         A7Y23d181f7wiAxe1EHATvLtq34qPp2kWaBsGQPBpihcabwT1WBy68h/dHaQYD+REeyn
         yNMA==
X-Gm-Message-State: APjAAAV3ChD65IHZ7GTSqYmV4DxhgEbCanAqOGFTaGAOJgwJvP1iixtC
        otjn2oc4h9/OHwJ+y8FCun4=
X-Google-Smtp-Source: APXvYqyHEHVyvdhTbf9JKn18ddBraYJ0QdLbEcobWpfChyspY4LnnCkF3XQ3F2xqfnhxl9cKPkVZCg==
X-Received: by 2002:a17:902:9b94:: with SMTP id y20mr126611639plp.260.1564676181269;
        Thu, 01 Aug 2019 09:16:21 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id b68sm88741663pfb.149.2019.08.01.09.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 09:16:20 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3] diff-lib.c: handle empty deleted ita files
Date:   Thu,  1 Aug 2019 09:15:58 -0700
Message-Id: <20190801161558.12838-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712150235.12633-1-vcnaik94@gmail.com>
References: <20190712150235.12633-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. Certain forms of `git diff` should show the file.
After `git reset HEAD`, the file should be identical in the index and
HEAD. The commands already work correctly if the file has contents in
HEAD. This patch provides the desired behavior even when the file is
empty in HEAD.

The affected "diff" commands and the "reset" command call
diff-lib.c:do_oneway_diff() with a cache entry in the index and a cache
entry in HEAD. An ita file is represented in the index by a cache entry
with the same hash as an empty file. For a nonempty deleted ita file,
do_oneway_diff() calls show_modified(), which detects a diff between the
cache entry in the index and the cache entry in HEAD and therefore deems
the file "modified". However, for an empty deleted ita file,
do_oneway_diff() previously detected no such diff between the two cache
entries and therefore deemed the file "not modified". After this fix,
for any deleted ita file, do_oneway_diff() calls diff_index_show_file()
and deems the file "deleted".

`git diff-index --cached HEAD` prints a row of output for both a
"modified" and a "deleted" file, although the output differs slightly.
`git reset HEAD` treats a "modified" and a "deleted" file similarly,
resurrecting the file in the index from HEAD.

This change should not affect newly added ita files. For those, the
"tree" cache entry is NULL, so the changed code is not executed.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
I tried to limit the "blast radius" of affected commands as much as
possible. To find commands that were affected, I ran the following:
    git diff
    git diff HEAD
    git diff --cached HEAD
    git diff-index HEAD
    git diff-index --cached HEAD
    git diff-files

I also ran each command with the option "--ita-visible-in-index" and the
option "--ita-invisible-in-index". Of these 18 commands, the following
three showed a diff for nonempty deleted ita files, but no diff for
empty deleted ita files. All three commands now work correctly, but I
chose the first one for the test case because the option
"--ita-visible-in-index" is still marked as experimental.
    git diff-index --cached HEAD
    git diff-index --cached --ita-visible-in-index HEAD
    git diff --cached --ita-visible-in-index HEAD

The `git add` at the end of the "diff-index" test case is necessary
because `git reset --hard HEAD` at the beginning of the next test case
_also_ breaks for empty deleted ita files. That command goes into
unpack-trees.c:oneway_merge() rather than diff-lib.c:do_oneway_diff().
I plan to create a separate patch to fix that, after I figure out which
commands are part of its blast radius.

 diff-lib.c            |  5 ++++-
 t/t2203-add-intent.sh | 13 +++++++++++++
 t/t7102-reset.sh      | 11 +++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 61812f48c2..29dba467d5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -433,8 +433,11 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 
 	/*
 	 * Something removed from the tree?
+	 * Consider a file deleted from the index and added as ita to be "deleted",
+	 * even though it should arguably be "modified", because we want empty
+	 * deleted ita files to appear in the diff.
 	 */
-	if (!idx) {
+	if (!idx || (cached && ce_intent_to_add(idx))) {
 		diff_index_show_file(revs, "-", tree, &tree->oid, 1,
 				     tree->ce_mode, 0);
 		return;
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 68e54d5c44..4e4a972921 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -261,6 +261,19 @@ test_expect_success '"diff HEAD" includes ita as new files' '
 	test_cmp expected actual
 '
 
+test_expect_success '"diff-index --cached HEAD" detects diff for deleted intent-to-add file' '
+	git reset --hard &&
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	test_expect_code 1 git diff-index --cached --exit-code HEAD nonempty &&
+	test_expect_code 1 git diff-index --cached --exit-code HEAD empty &&
+	git add nonempty empty
+'
+
 test_expect_success 'apply --intent-to-add' '
 	git reset --hard &&
 	echo new >new-ita &&
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 97be0d968d..7b79502f7d 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -566,4 +566,15 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'reset --mixed removes deleted intent-to-add file from index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git reset HEAD nonempty empty &&
+	git diff --cached --exit-code nonempty empty
+'
+
 test_done
-- 
2.22.0

