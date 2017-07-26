Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14D82047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdGZXjw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:39:52 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46539 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751325AbdGZXjv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jul 2017 19:39:51 -0400
X-AuditID: 12074412-0b3ff70000000b4e-ec-59792846fe9e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 41.4E.02894.64829795; Wed, 26 Jul 2017 19:39:50 -0400 (EDT)
Received: from localhost.localdomain (GITHUB-INC.bar1.SanFrancisco1.Level3.net [4.53.133.38])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6QNdlvU013338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Jul 2017 19:39:48 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] packed_ref_store: handle a packed-refs file that is a symlink
Date:   Wed, 26 Jul 2017 16:39:42 -0700
Message-Id: <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170720232040.GA159617@aiede.mtv.corp.google.com>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqOumURlpsOmXqsXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8Xbm0sYLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrR1X6EzeNZ7x5Gj4uXlD0+b5ILYI/isklJzcksSy3St0vgymhddou1YJZCxYmZH1ka
        GA9KdTFyckgImEgsvnyIsYuRi0NIYAeTxNIXj9ghnLtMEl+f3WEDqWIT0JVY1NPMBGKLCKhJ
        TGw7xAJSxCxwkFnixa6ZzCAJYQE/idf7r7KA2CwCqhLv7n8Fs3kFoiSWLp7NDLFOXmJX20XW
        LkYODk4BB4l3O9xAwkIC9hIb53ezT2DkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wv
        N7NELzWldBMjJPyEdjCuPyl3iFGAg1GJh3fFlIpIIdbEsuLK3EOMkhxMSqK8k0yBQnxJ+SmV
        GYnFGfFFpTmpxYcYJTiYlUR4hRQqI4V4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphak
        FsFkZTg4lCR4BdSBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGvwep4S0uSMwtzkyHyJ9i1OV4NeH/
        NyYhlrz8vFQpoDVqQEUCIEUZpXlwc2Bp4xWjONBbwhBVPMCUAzfpFdASJqAlc2aUgiwpSURI
        STUwNgY6Hs1arLhgAe+54t33imRNCxoSNnILS++cddJUtv3gHJ+NDurPbd4k1xq8jV8h5H9Z
        sCRnptux+ElSLNF/r+xUmG9h5aLcdz5wQot4+ZrnJ+T1r3qFffzCu7E5wf53+xGteFeOl7bN
        Xa8+tkRdrHv0KJOn8sOh18f4p2r+zO5P/Xsh59wlJZbijERDLeai4kQAOrRtQ/YCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the tricks that `contrib/workdir/git-new-workdir` plays is to
making `packed-refs` in the new workdir a symlink to the `packed-refs`
file in the original repository. Before
42dfa7ecef ("commit_packed_refs(): use a staging file separate from
the lockfile", 2017-06-23), a lockfile was used as the staging file,
and because the `LOCK_NO_DEREF` was not used, the pointed-to file was
locked and modified.

But after that commit, the staging file was created using a tempfile,
with the end result that rewriting the `packed-refs` file in the
workdir overwrote the symlink rather than the original `packed-refs`
file.

Change `commit_packed_refs()` to use `get_locked_file_path()` to find
the path of the file that it should overwrite. Since that path was
properly resolved when the lockfile was created, this restores the
pre-42dfa7ecef behavior.

Also add a test case to document this use case and prevent a
regression like this from recurring.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Sorry for the slow response; I've been traveling and very busy.

I didn't even know that a symlinked `packed-refs` file is a thing. The
attached patch should fix the problem. It applies on top of v3 of
mh/packed-ref-store [1] (which is already in next).

Michael

[1] http://public-inbox.org/git/cover.1498933362.git.mhagger@alum.mit.edu/

 refs/packed-backend.c | 24 ++++++++++++++++++------
 t/t3210-pack-refs.sh  | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a28befbfa3..59e7d1a509 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -610,19 +610,27 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 	int ok;
+	int ret = -1;
 	struct strbuf sb = STRBUF_INIT;
 	FILE *out;
 	struct ref_iterator *iter;
+	char *packed_refs_path;
 
 	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: commit_packed_refs() called when unlocked");
 
-	strbuf_addf(&sb, "%s.new", refs->path);
+	/*
+	 * If packed-refs is a symlink, we want to overwrite the
+	 * symlinked-to file, not the symlink itself. Also, put the
+	 * staging file next to it:
+	 */
+	packed_refs_path = get_locked_file_path(&refs->lock);
+	strbuf_addf(&sb, "%s.new", packed_refs_path);
 	if (create_tempfile(&refs->tempfile, sb.buf) < 0) {
 		strbuf_addf(err, "unable to create file %s: %s",
 			    sb.buf, strerror(errno));
 		strbuf_release(&sb);
-		return -1;
+		goto out;
 	}
 	strbuf_release(&sb);
 
@@ -660,17 +668,21 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 		goto error;
 	}
 
-	if (rename_tempfile(&refs->tempfile, refs->path)) {
+	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
 		strbuf_addf(err, "error replacing %s: %s",
 			    refs->path, strerror(errno));
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	ret = 0;
+	goto out;
 
 error:
 	delete_tempfile(&refs->tempfile);
-	return -1;
+
+out:
+	free(packed_refs_path);
+	return ret;
 }
 
 /*
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 2bb4b25ed9..0d8a03e2a9 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -238,4 +238,19 @@ test_expect_success 'retry acquiring packed-refs.lock' '
 	git -c core.packedrefstimeout=3000 pack-refs --all --prune
 '
 
+test_expect_success 'pack symlinked packed-refs' '
+	# First make sure that symlinking works when reading:
+	git update-ref refs/heads/loosy refs/heads/master &&
+	git for-each-ref >all-refs-before &&
+	mv .git/packed-refs .git/my-deviant-packed-refs &&
+	ln -s my-deviant-packed-refs .git/packed-refs &&
+	git for-each-ref >all-refs-linked &&
+	test_cmp all-refs-before all-refs-linked &&
+	git pack-refs --all --prune &&
+	git for-each-ref >all-refs-packed &&
+	test_cmp all-refs-before all-refs-packed &&
+	test -h .git/packed-refs &&
+	test "$(readlink .git/packed-refs)" = "my-deviant-packed-refs"
+'
+
 test_done
-- 
2.11.0

