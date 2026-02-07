Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20B3502A7
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476801; cv=none; b=tRCjzLsvTYl9e34w3dDW/kCecP57jCTtYKgYZvz3cKzlrBeFqlj+3ZhybD9TlbCiItXGxZ8j1v7KyY4+6fvPTIbkDKmIGAlu1roLSUPKOmFodchN5W4uN0X6zVXD84/18xzhuFO6VbiDCr4rqIKjjWwNRd5mzApnHCafvin0EqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476801; c=relaxed/simple;
	bh=lXX+e5n96ju6OQLwmC7Zfk/92AtY0rVale8Gm3gbUSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJPFq09ki5HHfJTezFcJ1NP0XYcqlJuDwLvbdAtZKy0HJ3Qg+9dK0a1S+sFCL44GNv0O5QdO9Y9zJWodVODW74c5D8T3sapwWK3niLcogkzVmZBlBVXVF5DaeZI1RVnq5JRybb2BDRNtWxf2jCE+lJzGeC2WJL9yPFhtfRVP7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FgRvxdfX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pqXhxXRV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FgRvxdfX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqXhxXRV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0724FEC032D;
	Sat,  7 Feb 2026 10:06:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 07 Feb 2026 10:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770476800;
	 x=1770563200; bh=vv5Kz9M7nxl41bLHBsesg2r3IQRy97EFWlldR55EYKw=; b=
	FgRvxdfXPRSxgzncpbNf70mX667imYcPChVYV8nk0tD5DjxZ13LYCbSqe22boFAb
	QwOQpGwcFzoCKQvWHFyAPjVu8NvBudS0rCGFO1SIs00m84mYDRCPbWqTWos604/w
	QIEHgA5I563GPfZ3ibK6PT1t4TiwnjFpZhrbgQnxrjOn58O92xJMYqs3mQj7hpnp
	XespBaA5WVs0cX9XoEkqjMxEVxAhiXvsHp4rFrBtTnruxi/eavbu3pjpbTNzXmwb
	vO+0UlVZsEOUVA/X/tMJjhCWhCrfCBCbZoAT6JUdFE52Up46638g1SkhymXtn2Pr
	WfyU0W04Ps/twNsMaZjJ3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770476800; x=
	1770563200; bh=vv5Kz9M7nxl41bLHBsesg2r3IQRy97EFWlldR55EYKw=; b=p
	qXhxXRV7T9z0tWnE+an7XAS1PPlsAp4y12auPtvHQJuBZhGn5XxcARddj2ybMmwS
	gM/WByrm6eM4iV03lTwWp16GfUTsIqDgyhqS8ynTwe7+O6vg77laC3UjiiAkAA2e
	visI1zVzLv3qX904Fg3aBCX1yBf04DJ0gQvUbGCcJLLXgabycqyZb/Pdh9ObVGJw
	voPADi0qLLJIpVEFRTvVpCElvfiTMtoE3hgvqoU64WPEAlMKMJ/1IPWTWqYww/PC
	clKJgDEkjefqnf/9E//4nMIFYLDnYV0z19F71fj6eu9wU7czd7JkEZRCptzbeH9T
	oywEn4qpzkVajv3y0GeJA==
X-ME-Sender: <xms:_1SHad0OrS2V4nq2xS2eUHQED7d6FHvbWELDPN3TVUyLD-cyZUCfXl4>
    <xme:_1SHabjZl_l4Pm89RzsM3LFwxfkuzNAd5Cwfzd4cRGm9403LmwezJZVGGtB9V2T4w
    K_8AgTOPRHLEsOYo6wJAnCNVuQakqAms33SZ2HBvRtSMSPVVbZm9A>
X-ME-Received: <xmr:_1SHabQLYS3LRwtSzApmr7kbNJnnOeIh-WjjTNegN85YTeg2mOcS6tflb65Q-KLmC_UIKSktA-MXT1WXSAejp19Mk-KKbFGHbGbgi8bTCnvEIORL3poskFaFWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepffekudfgvdeugfekgefhvdfhtdekgeeuhfev
    feekfeeiieeltddtkeeijeekgffgnecuffhomhgrihhnpehsthgrtghkohhvvghrfhhloh
    ifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:_1SHaUg3kE0UzRs2BHelLNGemH6mbMer6GVkw-gxrbOMNa64GxuU0g>
    <xmx:_1SHaT6102j-ibpldZPMJ-0XV55BqHWqjJfFnBnu3PYMrePbcwDQdw>
    <xmx:_1SHaZBgs7pnTwuhxpIn7bMMHPzWKVRoIDxTMXNYaNcfpAvttNlFMA>
    <xmx:_1SHaSaHtPl1E1H2HG88xVBbNLrlrjFIwWVDYQA8gCVsJUZNuD6h1A>
    <xmx:AFWHafjZuWl_9u8lIiKEQ6NHkrMSfRIXa0eDWN4XXbKP6BONmXxaIGX3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 10:06:38 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] doc: patch-id: emphasize multi-patch processing
Date: Sat,  7 Feb 2026 16:05:26 +0100
Message-ID: <multi-patch_processing.276@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <CV_doc_patch-id_4.275@msgid.xyz>
References: <CV_doc_patch-id_4.275@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Emphasize that you can pass multiple patches or diffs to this command.

git-patch-id(1) is an efficient pID–commit mapper, able to map
thousands of commits in seconds. But discussions on the command
seem to typically[1] use the standard loop-over-rev-list-and-
shell-out pattern:

    for commit in rev-list:
        prepare a diff from commit | git patch-id

This is unnecessary; we can bulk-process the patches:

    git rev-list --no-merges <ref> |
         git diff-tree --patch --stdin |
         git patch-id --stable

The first version (translated to shell) takes a little over nine
minutes for a commit history of about 78K commits.[2] The other one,
by contrast, takes slightly less than a minute.

Also drop “the” from “standard input”.

[1]: https://stackoverflow.com/a/19758159
† 2: This is `master` of this repository on 2025-10-02

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 013e1a61906..e95391cd255 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -3,7 +3,7 @@ git-patch-id(1)
 
 NAME
 ----
-git-patch-id - Compute unique ID for a patch
+git-patch-id - Compute unique IDs for patches
 
 SYNOPSIS
 --------
@@ -12,7 +12,7 @@ git patch-id [--stable | --unstable | --verbatim]
 
 DESCRIPTION
 -----------
-Read a patch from the standard input and compute the patch ID for it.
+Read patches from standard input and compute the patch IDs.
 
 A "patch ID" is nothing but a sum of SHA-1 of the file diffs associated with a
 patch, with line numbers ignored.  As such, it's "reasonably stable", but at
@@ -25,7 +25,8 @@ When dealing with `git diff-tree --patch` output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
 commit, and outputs two 40-byte hexadecimal strings.  The first
 string is the patch ID, and the second string is the commit ID.
-This can be used to make a mapping from patch ID to commit ID.
+This can be used to make a mapping from patch ID to commit ID for a
+set or range of commits.
 
 OPTIONS
 -------
-- 
2.53.0.26.g2afa8602a26

