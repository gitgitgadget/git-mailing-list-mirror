Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10B1B4138
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552793; cv=none; b=Y5EKYMN1H7sY3txJ4D8x1mToOv98j7mRzEfydfNsizJWYhaOPwRQpCEPLfhb0tSTRW62y1LPZ1ya0juMDXSzxiPdsOi1mPZ//VEtsqDkHwAI4gFkCJkttg1IiPwLYd2nY5j28+/2YpMByAEYMiRpxH8DuQP1XpsSiSoatcHSnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552793; c=relaxed/simple;
	bh=gKIPGPO09K6ybgyxHbxFiDuXlEDwVlFQilnsDUpjzTE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=or9BaS0+/T6qnOEviedBGi4Ad4Odz+/km7bOAFPMs/G9H/imjUZk6L2FPuox+qpoP+eBCVaI7NuK7r04RRpYPUfdvQbID3CNprbVbyKXJQnmsa46XJRlAODfbwDqQpfxpy6eoRRqKRvsPj6hqVChzMDIaST5vjJyb6AMfhR1/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQvrx/V0; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQvrx/V0"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba94dbf739so1774190eec.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771552791; x=1772157591; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJFByzjeaFUmMq6Br1FaD0oRpgn+ZiF0mVTGqvq7v2c=;
        b=LQvrx/V0aE3UOoRFRkzuNvACooWVYzd+9DXgeUdI9SHbFkILWSlEFkgBmHM+XnXPjD
         AB1yNiXEB+6swsfnQtqUTkMazXmQGQ+WkWRTKXaOtQRwiekgM157yCraMzVbvPm1Vf9R
         iFPQtrF/rNsdCYLTsC5d45eX4fF9ix+zxDYs2RSSYXovqCtjv03Q9QsGSyq3IWvDrG5a
         pDs0KdJaGNWWFoFe/ukbI6mcit5BAiVsc8uP3Efit0LV6/HplQVE91+2zEiloeAwgF2E
         YblLXvEbXmKFp2FA1UYlHyIY0bbn0OXb3YecjVcy3pQ+gjvlUt28q8diFjczpy8ifDw0
         MNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552791; x=1772157591;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJFByzjeaFUmMq6Br1FaD0oRpgn+ZiF0mVTGqvq7v2c=;
        b=xIyTnECdJI3CCnDU4iqFHTmYtjyXQnfAAaJfN4BGjcC7nhWJRN7DaKDLqqpu4UMfQU
         anTrRXlf7GvxRQntu0Q9q7ciT2UzU74OnWazV01vuTbPHcpy3eG4D4HW3x09Aa85hk2S
         TiM8emwUcwapaxbgJOpT/67Aw+ISvmMc4yZdE0pC9Pc6P6/UPpGC72n9G9kUGUpBfnYm
         MHo25H/utFAstrUQJYdVDrPvrM3Kb0x+J4ECuR5yG1+MwbRYDvatbUUJ/C/cqWR0El5x
         tC6CNYyxvIhwE5+QVoAxFUBKbURN81upVln4p+q+z2N/MkC+v+G1czl6jVhuuOmscSmv
         SaIg==
X-Gm-Message-State: AOJu0YxwdbfyoJf0aHfjhIeWklSDZuR44vhMBEHv0P3FZiRMlQ/vqZIY
	g/i5jKoS24ji2Qx+edha0xpSYfRsVfrO9+RcFShA3TPuECE5Nnjh8F+d38thDQ==
X-Gm-Gg: AZuq6aKQhe+dHe+KqVwnNYhPN+w2zhuqpYFjs4A0dfYhLfN4UquiH03hZjlTMOJyslg
	CgeG6OVKQciUTXob5+uS9n3SV4aDfyUnLmPIjDf7PhOnv6EihucbqCxvWhX195CoYCn057dmM4o
	lFHcQAkYZCOO20Ua4q7ojjZ3IyLGNqA3xlOAehwlYsvENYr8jQz50+KmdtbpWYIwjYsE60FgPZK
	M3N4YE8fq/teVASDW2v1jF7pC636bRhl29eZvnwrA2DUBFU5sqxI20BCI+N9O4BeY7d6RW7oRHb
	DBrev8JR1W117ed1vHFSfr22MEpnsNHx3dSxh8nf2ku7EmrgMs6I1FyKE0zMdm/qW+FFljiPB1m
	WJ82jtuy7NIYsZgBD2M2FbrFfMQ6yizwZputBSv4WGdA1xtYCWE+J3avHYrYvrJDfhCCrmSIU/Z
	9kEdo1NFidLd8dfaC9JpzOFzOijA==
X-Received: by 2002:a05:7300:bc99:b0:2ac:1e68:2342 with SMTP id 5a478bee46e88-2bd501948c0mr3658650eec.39.1771552790995;
        Thu, 19 Feb 2026 17:59:50 -0800 (PST)
Received: from [127.0.0.1] ([172.215.211.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577c1csm25620811eec.13.2026.02.19.17.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:59:50 -0800 (PST)
Message-Id: <7155a0da6f8bcdac90cf1ed085622f2c8b68675e.1771552788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
	<pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:59:43 +0000
Subject: [PATCH v2 1/6] merge,diff: remove the_repository check before
 prefetching blobs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Prefetching of blobs from promisor remotes was added to diff in
7fbbcb21b162 (diff: batch fetching of missing blobs, 2019-04-05).  In
that commit,

  https://lore.kernel.org/git/20190405170934.20441-1-jonathantanmy@google.com/

was squashed into

  https://lore.kernel.org/git/44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com/

without the extra explanation about the squashed changes being added to
the commit message; in particular, this explanation from that first link
is absent:

> Also, prefetch only if the repository being diffed is the_repository
> (because we do not support lazy fetching for any other repository
>  anyway).

Then, later, this checking was spread from diff.c to diffcore-rename.c
and diffcore-break.c by 95acf11a3dc3 (diff: restrict when prefetching
occurs, 2020-04-07) and then further split in d331dd3b0c82
(diffcore-rename: allow different missing_object_cb functions,
2021-06-22).  I also copied the logic from prefetching blobs from
diff.c to merge-ort.c in 2bff554b23e8 (merge-ort: add prefetching for
content merges, 2021-06-22).

The reason for all these checks was noted above -- we only supported
lazy fetching for the_repository.  However, that changed with
ef830cc43412 (promisor-remote: teach lazy-fetch in any repo,
2021-06-17), so these checks are now unnecessary.  Remove them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c            | 2 +-
 diffcore-break.c  | 2 +-
 diffcore-rename.c | 4 ++--
 merge-ort.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 35b903a9a0..91d81f66ad 100644
--- a/diff.c
+++ b/diff.c
@@ -7176,7 +7176,7 @@ void diffcore_std(struct diff_options *options)
 	 * If no prefetching occurs, diffcore_rename() will prefetch if it
 	 * decides that it needs inexact rename detection.
 	 */
-	if (options->repo == the_repository && repo_has_promisor_remote(the_repository) &&
+	if (repo_has_promisor_remote(the_repository) &&
 	    (options->output_format & output_formats_to_prefetch ||
 	     options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		diff_queued_diff_prefetch(options->repo);
diff --git a/diffcore-break.c b/diffcore-break.c
index c4c2173f30..5ce227ba22 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -69,7 +69,7 @@ static int should_break(struct repository *r,
 	    oideq(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
-	if (r == the_repository && repo_has_promisor_remote(the_repository)) {
+	if (repo_has_promisor_remote(the_repository)) {
 		options.missing_object_cb = diff_queued_diff_prefetch;
 		options.missing_object_data = r;
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d9476db35a..072752954e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -987,7 +987,7 @@ static int find_basename_matches(struct diff_options *options,
 			strintmap_set(&dests, base, i);
 	}
 
-	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
+	if (repo_has_promisor_remote(the_repository)) {
 		dpf_options.missing_object_cb = basename_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
@@ -1574,7 +1574,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 	/* Finish setting up dpf_options */
 	prefetch_options.skip_unmodified = skip_unmodified;
-	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
+	if (repo_has_promisor_remote(the_repository)) {
 		dpf_options.missing_object_cb = inexact_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
diff --git a/merge-ort.c b/merge-ort.c
index 0a59d1e596..593e3a2087 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4438,7 +4438,7 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	struct string_list_item *e;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
+	if (!repo_has_promisor_remote(the_repository))
 		return;
 
 	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
-- 
gitgitgadget

