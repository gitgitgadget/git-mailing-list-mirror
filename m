Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFC2627F5
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829789; cv=none; b=naYQUmeP3ILXbONkQpOrCiJ/nLKrAW1FszOyvWZ4ibQnAPLc1zWSwFSsS6moPe9BFhpxB+TZFLDxO4Qt0yC1gspUhzEh9+Jw0J/YQI0K2TgO1Os8IP7j0nG/UocJGq90nmMz0aTzklnOoJq0HjzqfeJIY7ixsVDJkN8pO8c1xoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829789; c=relaxed/simple;
	bh=y2yLdVXTzuUR9U6946xR2co/LPKHpI/jaZLnI6FZ+UA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M85rQBkrtEhaqvW1+YtCeWG79oPvDzHwnEMgIgnF0YEJIr3AMp+mJJS4qkqCt1etVeP0dMOgNyfVmDl4V0SoxTIPE/Tm6oQOv6rbpTWlHphvwvViJ2JlctzQl6tGkL4FvhNeOePEcrKUnq8X9y4e9QEujINIApxQTWXXAWX2r2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlNtz9Uf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlNtz9Uf"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f5f48eafso2522746f8f.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829785; x=1743434585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFxQHlpqrcIeL8CIdIswv4Pg1SOP2VmsLhHOZfh2EfU=;
        b=DlNtz9UfQfN/RqBtEEgK29tgjAoq1jrcSJFaH2PGjtTAvjWuVRsqnZuaD/drqda+G1
         YeU/1Hph8YLikTNx1lwJDeOVJ41urYOrvDquhBkNPCK1Dw7EdVkely5yrMsJVzvUAPvp
         GkYdSD+G8VrOKU+rgewOBVSOrt3Zo4sIA120weKEr/ajG4DbIhNW2Lc+BiWJ892ex7M8
         U2MPVTKDYD+Y5qcb6bhHb+dCCIyR2coQWJs4H+Q3IsTk3ebw1dAPvyzsw7JRAMQ4FCt+
         U1awrSCjGlrIkoORJolN4W6WFl/d9KIy3pUzNV2FeyQCgCqxTMwX/aGFUvWK7ELa+Odf
         l2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829785; x=1743434585;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFxQHlpqrcIeL8CIdIswv4Pg1SOP2VmsLhHOZfh2EfU=;
        b=bdoRAoaHcnBPyDuAGypxs8lhFo+a+8r5QW1MJKgRixXnrp0NwhvfkHK1E6rboltgwS
         75qB1ZvCWQfOL8hTHNOOwfVqsB/OxHrlgWmvlJJ/lPGglaWxyrYkjsh2nrbujwnpXykT
         PU1Cu3TAFzKh8LGnotWnmyLrgbBQyEAc1/GOCHYbEdJY6VBySs9qcX69ziKf8es34JGU
         782aKoMQcPU/ED70rtZl8xS0ONVHiDcytGJfes9edUj5zq79ubcM+8iwST6DAzcJixCT
         0BVFTanbYZeDdFRGepJ/Zthp/kqzQOrgQBTmA1Nj6QRmZtrISJXYvB63ItHaq+to87ho
         /cLw==
X-Gm-Message-State: AOJu0YyjuNbjcRoWE6o1bcg5BauIOF0DecODwwhDcT9GlEe5A7d2YiHJ
	gxRRU8Q1qHvp8f5GIDXVGd3ed86N13xSCFjivbgn1wa2qQ80wOi1jhPjsw==
X-Gm-Gg: ASbGnctQc1xE3Hz4O1kpCksVxlsIznNKrqoL6FDayjdCmvLuDaMfsGziDGjqmVDeQ3g
	gzZZVk/D491TJn7oLFmx5aG0pI6lgNrotxPKALqEP2EEHl9WH/2WY6e24fjLdsq9HrsWoVuw5t5
	Pq/50BNKDRrW4Elu8kF3086FWGr/54w5CC88bTv5stMlSR7KUdvsL8/rLRPXM9SalLtICtobTfC
	bImc0cOw60dWCK3yiQ/jFrYzdmfZjN9tkZwT49v3T1NEn/b+2kDbRTrU1/UBHDXl+xjNOJ5L0OI
	epPyETpe88RBaG6QvbdJKPZ7jIV0YFKM+j1VFOry99DNaw==
X-Google-Smtp-Source: AGHT+IEs7euRAe3FSb8QDnMSmBdwgq1W67XiDk+u737s7XU7zK+5ftwbsjDDxM/79p/N0Cflvh3WIg==
X-Received: by 2002:a05:6000:418a:b0:391:4b8e:a200 with SMTP id ffacd0b85a97d-3997f9127f6mr8182302f8f.32.1742829784901;
        Mon, 24 Mar 2025 08:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5b8dsm11392313f8f.59.2025.03.24.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:23:04 -0700 (PDT)
Message-Id: <d5484ebd9428f4d7dce05e43c5067d741dc37a9d.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:49 +0000
Subject: [PATCH v2 13/13] pack-objects: allow --shallow and --path-walk
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

There does not appear to be anything particularly incompatible about the
--shallow and --path-walk options of 'git pack-objects'. If shallow
commits are to be handled differently, then it is by the revision walk
that defines the commit set and which are interesting or uninteresting.

However, before the previous change, a trivial removal of the warning
would cause a failure in t5500-fetch-pack.sh when
GIT_TEST_PACK_PATH_WALK is enabled. The shallow fetch would provide more
objects than we desired, due to some incorrect behavior of the path-walk
API, especially around walking uninteresting objects.

The recently-added tests in t5538-push-shallow.sh help to confirm this
behavior is working with the --path-walk option if
GIT_TEST_PACK_PATH_WALK is enabled. These tests passed previously due to
the --path-walk feature being disabled in the presence of a shallow
clone.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a6246c1e78..7db2ebc7962 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -209,6 +209,7 @@ static int keep_unreachable, unpack_unreachable, include_tag;
 static timestamp_t unpack_unreachable_expiration;
 static int pack_loose_unreachable;
 static int cruft;
+static int shallow = 0;
 static timestamp_t cruft_expiration;
 static int local;
 static int have_non_local_packs;
@@ -4486,6 +4487,7 @@ static void get_object_list_path_walk(struct rev_info *revs)
 	 * base objects.
 	 */
 	info.prune_all_uninteresting = sparse;
+	info.edge_aggressive = shallow;
 
 	if (walk_objects_by_path(&info))
 		die(_("failed to pack objects via path-walk"));
@@ -4687,7 +4689,6 @@ int cmd_pack_objects(int argc,
 		     struct repository *repo UNUSED)
 {
 	int use_internal_rev_list = 0;
-	int shallow = 0;
 	int all_progress_implied = 0;
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
@@ -4875,10 +4876,6 @@ int cmd_pack_objects(int argc,
 		warning(_("cannot use delta islands with --path-walk"));
 		path_walk = 0;
 	}
-	if (path_walk && shallow) {
-		warning(_("cannot use --shallow with --path-walk"));
-		path_walk = 0;
-	}
 	if (path_walk) {
 		strvec_push(&rp, "--boundary");
 		 /*
-- 
gitgitgadget
