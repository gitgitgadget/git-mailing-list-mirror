Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4241F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeIEAyd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:54:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37504 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeIEAyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:54:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so5514140wmc.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qv3qKecNq0zhJzl4lAGMIKTcXg5iKnvD7slJcpd0Qu8=;
        b=TCRXInujr6c2iCN3AzyjFq9juPxd6XH0RxJhNIgfxkM6hkXQEsRrdby6p69DeW/E2P
         oZj2/EEhFb0le/DNbMAxsBO3lD/f4YOZ8rt4h0oKs8BW2nCQR8nIJ7dXRyPaStD2GVK6
         raBmDgnllv3t4OFESTp8jKUEFi+aMxdxftM0Fd/QUgf6VnitQoaPMv0LJHlUX01qwQce
         /IkqMxJ1UasngpxaJdGqstLWHt1kU0xIDVhi284JhGvj1El8K5r4IED4ltfTiWVJoZkz
         nYd6m+F8FsIOyPuiTcm4dBjanzUMDTFEt8/nhpd2gY1ZyYqL1kGDevVM6o8X6H2shVUz
         p29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qv3qKecNq0zhJzl4lAGMIKTcXg5iKnvD7slJcpd0Qu8=;
        b=Ss+d7G4qVrO2MVCSeVnG8mBqlQb+9xj5sUD4ZxO3ucsIMNk31vapSdbDFYY1DWYNnA
         k4gjAwDexGady7xaZqG0yGcmEZzuEnJVb/H9xyJ8skd8YMcMjIFBzVWHY8e7Wu8aCzkD
         yGvX3bUBvK4V/KGUTOg99raNsoR/shK84cOS3EKX7WYYeLQwPY4bec6OCHyjv1focajv
         qEWSOTqKwNfKIX/VRhgCCHQM7Ym7CbVqr7I8EfP3mk/UY+Fwn0JgiDp0dMhDJs8R0Z3J
         +pa9awaT6YTWHqSyqvfZ24YgitVDjeaa4TNCNNFcN3fmlbGzzaZypwkORlp6ZOEYKO9K
         LEEg==
X-Gm-Message-State: APzg51ACdRsY5LSUE8tTucpiO8iiMfVVrZk/qHbfBVgVAthf9XTkzdZZ
        lk1Jz+33oaFFMdzZfP47lcoEKOJuR3c=
X-Google-Smtp-Source: ANB0VdaeiQsGavxwHxwwPTAcprNeo3Y0cyhXywiOKqyZlLynFk1F0FUhUypGE0QgDqXZBSXuLvksOw==
X-Received: by 2002:a1c:a8d0:: with SMTP id r199-v6mr8682935wme.97.1536092867665;
        Tue, 04 Sep 2018 13:27:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l130-v6sm257109wmd.16.2018.09.04.13.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 13:27:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] commit-graph verify: add progress output
Date:   Tue,  4 Sep 2018 20:27:29 +0000
Message-Id: <20180904202729.13900-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180904202729.13900-1-avarab@gmail.com>
References: <20180904202729.13900-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the reasons explained in the "commit-graph write: add progress
output" commit leading up to this one, emit progress on "commit-graph
verify". Since e0fd51e1d7 ("fsck: verify commit-graph", 2018-06-27)
"git fsck" has called this command if core.commitGraph=true, but
there's been no progress output to indicate that anything was
different. Now there is (on my tiny dotfiles.git repository):

    $ git -c core.commitGraph=true -C ~/ fsck
    Checking object directories: 100% (256/256), done.
    Checking objects: 100% (2821/2821), done.
    dangling blob 5b8bbdb9b788ed90459f505b0934619c17cc605b
    Verifying commits in commit graph: 100% (867/867), done.

And on a larger repository, such as the 2015-04-03-1M-git.git test
repository:

    $ time git -c core.commitGraph=true -C ~/g/2015-04-03-1M-git/ commit-graph verify
    Verifying commits in commit graph: 100% (1000447/1000447), done.
    real    0m7.813s
    [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 74889dc90a..1a02fe019a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -914,6 +914,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	int generation_zero = 0;
 	struct hashfile *f;
 	int devnull;
+	struct progress *progress = NULL;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -981,11 +982,14 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
+	progress = start_progress("Verifying commits in commit graph",
+				  g->num_commits);
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
 		uint32_t max_generation = 0;
 
+		display_progress(progress, i);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
@@ -1062,6 +1066,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				     graph_commit->date,
 				     odb_commit->date);
 	}
+	display_progress(progress, i);
+	stop_progress(&progress);
 
 	return verify_commit_graph_error;
 }
-- 
2.19.0.rc1.350.ge57e33dbd1

