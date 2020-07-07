Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB27FC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDF5206B6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb+BTRvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGGGUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGGUm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:20:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87910C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:20:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so4519102pjb.4
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PWyo3UJ/HmdUs0p9WEx4oOk1xgCWX28SuTGOeypmtq8=;
        b=pb+BTRvz36VRHt1zct2NJSOI45ABGcloERD+sb+6q/h1o4lA7M0ifBQ9Cl0wwkkdEA
         vYD52arBdnzDW3sE8o8xP+kAH5ogMt8x/7uZrGlfD6sZhN8eCO6pU+Omo+oxSuWN3xMj
         HHTzoHkJiCGT+3Vu1y5WxRc3p5xxg8QL7WKY02ARfw0rqw/aDPRxYOyTWRQktgrNAQSy
         NZ5xKRUWPWhjyhYLL9sO8koVi7uVq8uHNijfKOrLNhwK7/s/Ks+0ujqLl0+f6N3S/MQQ
         Ln9DKu/3T3W06yT8a/bPtwwj3xKRideF9lie6NVjJVQICTE2BBsnvxiRJJXo1ngZP/Ja
         hBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PWyo3UJ/HmdUs0p9WEx4oOk1xgCWX28SuTGOeypmtq8=;
        b=Ek5Oum03WbgJ8A8Mo93tpeBkFx5Gf+v+lrigEVdC8orYVAIzsOsMHqY1KStId6sjnZ
         XGO5sNvA6c4zpKqqS0hcOKgxUNGGwhYLaTK/Hpy5d4PFEOiMVYAvxb0XvLxAUEX5nhsV
         xPzPTrpmtS7ClYhWCgo40At103dTH8r4v1jT+0xaeShYCloq405Pdn9z4+M8793QYdZk
         ON1Ct3pR/km7XbtgaIcfUAQ2SyY3afPAw9wu+U/ktYVi1969qIzrtK5RxRsQ44obO1zN
         Yf80M20MMnc5Mo9QC/aWJlaIf8PxC6FrU3OKR3yRYHGDyZ5NSoRypQoaufmeflsh9OnR
         bTkg==
X-Gm-Message-State: AOAM533W6e4rLIYBzbZ0u5FJsufebUDDydP6F677r8fP+QWSQrNoGn/D
        yb/LA9+qrJR6CM3I86ZtPS2dR//3
X-Google-Smtp-Source: ABdhPJxRmqXsxUU3d48+jH8VC6ETtsh0JhuL44r08615mLvLNNJcHLX1XVJviNgHGU34RyuIdXe1zA==
X-Received: by 2002:a17:90a:8c01:: with SMTP id a1mr2611218pjo.97.1594102841813;
        Mon, 06 Jul 2020 23:20:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 22sm21051923pfx.94.2020.07.06.23.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:20:41 -0700 (PDT)
Date:   Mon, 6 Jul 2020 23:20:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] experimental: default to fetch.writeCommitGraph=false
Message-ID: <20200707062039.GC784740@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fetch.writeCommitGraph feature makes fetches write out a commit
graph file for the newly downloaded pack on fetch.  This improves the
performance of various commands that would perform a revision walk and
eventually ought to be the default for everyone.  To prepare for that
future, it's enabled by default for users that set
feature.experimental=true to experience such future defaults.

Alas, for --unshallow fetches from a shallow clone it runs into a
snag: by the time Git has fetched the new objects and is writing a
commit graph, it has performed a revision walk and r->parsed_objects
contains information about the shallow boundary from *before* the
fetch.  The commit graph writing code is careful to avoid writing a
commit graph file in shallow repositories, but the new state is not
shallow, and the result is that from that point on, commands like "git
log" make use of a newly written commit graph file representing a
fictional history with the old shallow boundary.

We could fix this by making the commit graph writing code more careful
to avoid writing a commit graph that could have used any grafts or
shallow state, but it is possible that there are other pieces of
mutated state that fetch's commit graph writing code may be relying
on.  So disable it in the feature.experimental configuration.

Google developers have been running in this configuration (by setting
fetch.writeCommitGraph=false in the system config) to work around this
bug since it was discovered in April.  Once the fix lands, we'll
enable fetch.writeCommitGraph=true again to give it some early testing
before rolling out to a wider audience.

In other words:

- this patch only affects behavior with feature.experimental=true

- it makes feature.experimental match the configuration Google has
  been using for the last few months, meaning it would leave users in
  a better tested state than without it

- this should improve testing for other features guarded by
  feature.experimental, by making feature.experimental safer to use

Reported-by: Jay Conrod <jayconrod@google.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I realize this is late to send.  That said, as described above, I
think it's a good way to buy time by minimizing user exposure to
fetch.writeCommitGraph=true until a fix for it is well cooked.

In other words, I'd like to see this patch in Git 2.28-rc0.

Thanks of all kinds welcome, as always.  Previous discussion:
https://lore.kernel.org/git/20200603034213.GB253041@google.com/

 Documentation/config/feature.txt | 8 --------
 Documentation/config/fetch.txt   | 3 +--
 repo-settings.c                  | 8 ++++----
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 28c33602d52..c0cbf2bb1cd 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -15,14 +15,6 @@ feature.experimental::
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
 +
-* `fetch.writeCommitGraph=true` writes a commit-graph after every `git fetch`
-command that downloads a pack-file from a remote. Using the `--split` option,
-most executions will create a very small commit-graph file on top of the
-existing commit-graph file(s). Occasionally, these files will merge and the
-write may take longer. Having an updated commit-graph file helps performance
-of many Git commands, including `git merge-base`, `git push -f`, and
-`git log --graph`.
-+
 * `protocol.version=2` speeds up fetches from repositories with many refs by
 allowing the client to specify which refs to list before the server lists
 them.
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index b1a9b1461d3..b20394038d1 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -90,5 +90,4 @@ fetch.writeCommitGraph::
 	the existing commit-graph file(s). Occasionally, these files will
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
-	`git push -f`, and `git log --graph`. Defaults to false, unless
-	`feature.experimental` is true.
+	`git push -f`, and `git log --graph`. Defaults to false.
diff --git a/repo-settings.c b/repo-settings.c
index dc6817daa95..0918408b344 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -51,14 +51,14 @@ void prepare_repo_settings(struct repository *r)
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
 	}
+
 	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
 		r->settings.fetch_write_commit_graph = value;
-	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
-		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
-		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
-	}
 	UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 0);
 
+	if (!repo_config_get_bool(r, "feature.experimental", &value) && value)
+		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
+
 	/* Hack for test programs like test-dump-untracked-cache */
 	if (ignore_untracked_cache_config)
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
-- 
2.27.0.383.g050319c2ae

