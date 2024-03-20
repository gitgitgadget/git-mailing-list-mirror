Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989658627A
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972336; cv=none; b=tx9+zf6XDOgCFWOb2UwBuLYGPU69NESpt9TPbKHwN2pXglKK9ntnfhjTBrirRLe0cyfzPGr9KaWY9JAMvIRAvgCZNkePnxbC2iuW4KxCA7YTLlLAa9lfOya+4HgIR7zynRqyCgSoHcDBxvImlIe2sXxmbQvjT1r6ceouVJJb0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972336; c=relaxed/simple;
	bh=uZwPc6+MaaFAiXPDnVM+S6MtGyE2zaJkmIQdMat6mU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTxiKwYT8IU5lcv3GB3BIlZsWsUkA98NMDF1SDZaIH0nawh0zLhQuJDMD/eAqT/+0WDHYWMK3nmcXkJoJBhV/Ipiw+A39WGv4JrpdDQyBlJSZKyrVqQ6n8xl/kR1FG9ylmaoRsTgV8CiwIDHaf9bl/HQOO+MnTc/9iGpE2X6lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gwX6Pw5r; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gwX6Pw5r"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430bf84977dso2352651cf.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972333; x=1711577133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHYxGoCCMbjPrZxqJC1drLuglnsOvoskdJ+pzFyxRy8=;
        b=gwX6Pw5r2NOdmIUQcfu68tPoWlwlM2jqMysphRS99gwts6QfNiCzvLzGgsKucZ0jBu
         n5mAmQfJexJ2eXlHDgC3Yp0JqHZ9ESmD8S/5/ewfXZyRD5B7WneoQSeBl1yRIachAmGl
         AgZVzk/9bYydaIZETr6KCm8m4k7UtPRFRHqLabTX51AYgNcKp8V4S0OMuqNLbTZQWr5H
         VZ+XbK7P47nI3wuFXzz3Xva1xqFBN8gwMjYSpNlYw4hw/1yDhScl8SlC671TcIJu2k3G
         uuF/hbZtAOgco+nhlOvtv6WxI9Hneg36bF6+uxa51QvhPMn8quHS8pjNbMuD7Y3ZNFe4
         +7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972333; x=1711577133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHYxGoCCMbjPrZxqJC1drLuglnsOvoskdJ+pzFyxRy8=;
        b=ea7ACerOqn8hsDaPTp0oNluDD9Qx+Zo6UB3QU6fw4Dd23JYkaXcVgzyScrdsvqW4Wo
         guwaSHyPVyxlXAILLkN3VMJY4jynINT1PIQKS9o953M0oJYDkL9YGJzxbBbGfB2RYZ7B
         bKLCincpIU4rgl6Mhg4ujJvDCTLwh8InJXrTMOl1MP1xtM9li3QtwOJpBCoZ2Wwc8cYz
         7xCsoonWoESr5MK5//YJa0t0jy+ExDtg7T7jfSJN9TlHysxioUQqUwL02XluVwsN6qwl
         iaIOtwO3QnYtW4AHkYHu8MmYpXrZZnbNiADqrUOeksqjur/j95EcnYpe9Y+jiUTlgYHx
         YpHg==
X-Gm-Message-State: AOJu0YwI+T96fT5SXGVL9YpnA7zClPLS4Cfvx6ivTx9pE8db9DQ8/0st
	TPdROt3cRhFKMRI8Qc8BOG4+hEkqQmvr8ZxQxykBvERhOyoIFjEagq/CWIB2i8lnPIfDhaTCmjJ
	Yj00=
X-Google-Smtp-Source: AGHT+IESSMioY7Ngrt+4McIkOCshDHgVMu2DVUY0y5sr31uYKyEJPf4+qnM5V1NEXr0rPIpz5j5qFw==
X-Received: by 2002:a05:6214:2245:b0:696:4c48:e110 with SMTP id c5-20020a056214224500b006964c48e110mr108820qvc.55.1710972333404;
        Wed, 20 Mar 2024 15:05:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id iw11-20020a0562140f2b00b00690bf9548aasm8234446qvb.108.2024.03.20.15.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:33 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/24] pack-bitmap-write.c: select pseudo-merge commits
Message-ID: <bf6b0d8601e98061a84c5eb90128c2d82053988a.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Now that the pseudo-merge machinery has learned how to select
non-bitmapped commits and assign them into different pseudo-merge
group(s), invoke this new API from within the pack-bitmap internals and
store the results off.

Note that the selected pseudo-merge commits aren't actually used or
written anywhere yet. This will be done in the following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt                     |  2 +
 Documentation/config/bitmap-pseudo-merge.txt | 75 ++++++++++++++++++++
 Documentation/technical/bitmap-format.txt    | 26 +++++++
 pack-bitmap-write.c                          | 14 ++++
 4 files changed, 117 insertions(+)
 create mode 100644 Documentation/config/bitmap-pseudo-merge.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 782c2bab906..e5a7170c9e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -381,6 +381,8 @@ include::config/apply.txt[]
 
 include::config/attr.txt[]
 
+include::config/bitmap-pseudo-merge.txt[]
+
 include::config/blame.txt[]
 
 include::config/branch.txt[]
diff --git a/Documentation/config/bitmap-pseudo-merge.txt b/Documentation/config/bitmap-pseudo-merge.txt
new file mode 100644
index 00000000000..90b72522046
--- /dev/null
+++ b/Documentation/config/bitmap-pseudo-merge.txt
@@ -0,0 +1,75 @@
+bitmapPseudoMerge.<name>.pattern::
+	Regular expression used to match reference names. Commits
+	pointed to by references matching this pattern (and meeting
+	the below criteria, like `bitmapPseudoMerge.<name>.sampleRate`
+	and `bitmapPseudoMerge.<name>.threshold`) will be considered
+	for inclusion in a pseudo-merge bitmap.
++
+Commits are grouped into pseudo-merge groups based on whether or not
+any reference(s) that point at a given commit match the pattern, which
+is an extended regular expression.
++
+Within a pseudo-merge group, commits may be further grouped into
+sub-groups based on the capture groups in the pattern. These
+sub-groupings are formed from the regular expressions by concatenating
+any capture groups from the regular expression, with a '-' dash in
+between.
++
+For example, if the pattern is `refs/tags/`, then all tags (provided
+they meet the below criteria) will be considered candidates for the
+same pseudo-merge group. However, if the pattern is instead
+`refs/remotes/([0-9])+/tags/`, then tags from different remotes will
+be grouped into separate pseudo-merge groups, based on the remote
+number.
+
+bitmapPseudoMerge.<name>.decay::
+	Determines the rate at which consecutive pseudo-merge bitmap
+	groups decrease in size. Must be non-negative. This parameter
+	can be thought of as `k` in the function `f(n) = C *
+	n^(-k/100)`, where `f(n)` is the size of the `n`th group.
++
+Setting the decay rate equal to `0` will cause all groups to be the
+same size. Setting the decay rate equal to `100` will cause the `n`th
+group to be `1/n` the size of the initial group.  Higher values of the
+decay rate cause consecutive groups to shrink at an increasing rate.
+The default is `100`.
+
+bitmapPseudoMerge.<name>.sampleRate::
+	Determines the proportion of non-bitmapped commits (among
+	reference tips) which are selected for inclusion in an
+	unstable pseudo-merge bitmap. Must be between `0` and `100`
+	(inclusive). The default is `100`.
+
+bitmapPseudoMerge.<name>.threshold::
+	Determines the minimum age of non-bitmapped commits (among
+	reference tips, as above) which are candidates for inclusion
+	in an unstable pseudo-merge bitmap. The default is
+	`1.week.ago`.
+
+bitmapPseudoMerge.<name>.maxMerges::
+	Determines the maximum number of pseudo-merge commits among
+	which commits may be distributed.
++
+For pseudo-merge groups whose pattern does not contain any capture
+groups, this setting is applied for all commits matching the regular
+expression. For patterns that have one or more capture groups, this
+setting is applied for each distinct capture group.
++
+For example, if your capture group is `refs/tags/`, then this setting
+will distribute all tags into a maximum of `maxMerges` pseudo-merge
+commits. However, if your capture group is, say,
+`refs/remotes/([0-9]+)/tags/`, then this setting will be applied to
+each remote's set of tags individually.
++
+Must be non-negative. The default value is 64.
+
+bitmapPseudoMerge.<name>.stableThreshold::
+	Determines the minimum age of commits (among reference tips,
+	as above, however stable commits are still considered
+	candidates even when they have been covered by a bitmap) which
+	are candidates for a stable a pseudo-merge bitmap. The default
+	is `1.month.ago`.
+
+bitmapPseudoMerge.<name>.stableSize::
+	Determines the size (in number of commits) of a stable
+	psuedo-merge bitmap. The default is `512`.
diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 63a7177ac08..ed7edf98034 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -434,3 +434,29 @@ the end of a `.bitmap` file. The format is as follows:
 
 * An 8-byte unsigned value (in network byte-order) equal to the number
   of bytes in the pseudo-merge section (including this field).
+
+=== Pseudo-merge selection
+
+Pseudo-merge commits are selected among non-bitmapped commits at the
+tip of one or more reference(s). In addition, there are a handful of
+constraints to further refine this selection:
+
+`pack.bitmapPseudoMergeDecay`:: Defines the "decay rate", which
+corresponds to how quickly (or not) consecutive pseudo-merges decrease
+in size relative to one another.
+
+`pack.bitmapPseudoMergeGroups`:: Defines the maximum number of
+pseudo-merge groups.
+
+`pack.bitmapPseudoMergeSampleRate`:: Defines the percentage of commits
+(matching the above criteria) which are selected.
+
+`pack.bitmapPseudoMergeThreshold`:: Defines the minimum age of a commit
+in order to be considered for inclusion within one or more pseudo-merge
+bitmaps.
+
+The size of consecutive pseudo-merge groups decays according to a
+power-law decay function, where the size of the `n`-th group is `f(n) =
+C*n^-k`. The value of `C` is chosen accordingly to match the number of
+desired groups, and `k` is 1/100th of the value of
+`pack.bitmapPseudoMergeDecay`.
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e46978d494c..db1c38f4e46 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -17,6 +17,7 @@
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "pseudo-merge.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -39,6 +40,8 @@ struct bitmap_writer {
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
 
+	struct string_list pseudo_merge_groups;
+	kh_oid_map_t *pseudo_merge_commits; /* oid -> pseudo merge(s) */
 	uint32_t pseudo_merges_nr;
 
 	struct progress *progress;
@@ -56,6 +59,11 @@ static inline int bitmap_writer_selected_nr(void)
 void bitmap_writer_init(struct repository *r)
 {
 	writer.bitmaps = kh_init_oid_map();
+	writer.pseudo_merge_commits = kh_init_oid_map();
+
+	string_list_init_dup(&writer.pseudo_merge_groups);
+
+	load_pseudo_merges_from_config(&writer.pseudo_merge_groups);
 }
 
 void bitmap_writer_show_progress(int show)
@@ -686,6 +694,12 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 	}
 
 	stop_progress(&writer.progress);
+
+	select_pseudo_merges(&writer.pseudo_merge_groups,
+			     indexed_commits, indexed_commits_nr,
+			     writer.pseudo_merge_commits,
+			     &writer.pseudo_merges_nr,
+			     writer.show_progress);
 }
 
 
-- 
2.44.0.303.g1dc5e5b124c

