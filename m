Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF41FC7
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771070207; cv=none; b=cjTIJNXYcNwmV4qu4Yh4JaAZFAfxOJXeuRb7B4/UlI3bJqLa5qe2OOyLG7I1mNXTW8K3s/IhqF19p2g2kyQsbDek3OYPzf7++ed50TI7VjeV0S8aRqzRxhLUycjUeJbUSz4NuvY9rKuzI4rjo1WTSzlvcHEx324k9U9/M1AYyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771070207; c=relaxed/simple;
	bh=iTmXgBCJktswQc6StzIUmP87CwM/NHdNcFDTPAe2rPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YV3Fp/ZG8ycFFAjChxbrgRG1RgrLSeSSU5qcglKwnpYnaRHOvzP/RtA+XuXe4LuSEqjZKVyjJZi3qkmRmXCGzVljGrIp8eL4MytI3Txr33covZyR+pcpzOsZCVATsOmhqHrFafkn1mCg7X7UcjYTjAjkoEjiwqCM0aqH9/pdgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VOfAkyBr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxXkT/U9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VOfAkyBr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxXkT/U9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D630A7A007C;
	Sat, 14 Feb 2026 06:56:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 14 Feb 2026 06:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771070205;
	 x=1771156605; bh=xXVsfIBBiy7HQSEZpAUwmu9zkBk62OAAhUzJh6uF5yo=; b=
	VOfAkyBrIItqqPIHfw8KXx2varq9Kt7Lwu02MXvvEo9gZtksx35zshMAON1N+UGd
	q1tZ2vcpg+vPAOoUdw+Zu24bzuXIRiWbFT9jY6e9ggbiIlt2pMeWLQ0lXkEGnkvy
	xAGqYxZU4JmJt+KgSozm0NvISY6683viVgbj3s9RT5NGwulbIyLCN+IK2iE+eZup
	Wtf8HNwkSvy9o1nPcU0JCzfhGPnKnzFeweuV071u4kO2ZIdp/W1XH4pf2WcvOTOQ
	erPhCz+FbykMbVC+cvm5q0YKYMDenCfuXjEhreXiVRdrrax/noa4u1v+52xTsTfv
	3A7D5d3WYdmonZL8KA17QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771070205; x=
	1771156605; bh=xXVsfIBBiy7HQSEZpAUwmu9zkBk62OAAhUzJh6uF5yo=; b=d
	xXkT/U9TYQ7uAW7v8nVe/8G9Wk2zFd7IAEdfrsufHpILxR6WgKXQcHUKsv5KW91J
	IW9f/vgokC+FrquqjxH8iPIDAbluHd/yA3sk1NdcdEyq+mLFuyS0XUluvK5zJedx
	6lSPRCk+rZLFHmtCIPflLujQXgIWzidmFlcT2Sh4yeMnslfsYOqn6faXqF1rimXZ
	nIQ5x0ikl9lqT67JWBblPHt2E4bDzXHB5BjhSTZoB9ehROEQgnbgbloH0S9K6OZV
	8XTvK3P9K+aJfc1leEcIfmKGyy3twus1I2yDML4bhi3CmFi1d72aFoOpB1wvveGU
	1BODc8BB3ETjcx10w9MNA==
X-ME-Sender: <xms:_WKQaR5tqBb65tFag7_Ki9_7nCNtoaWk0QyN6GviRbHtM_CQq-5_3DU>
    <xme:_WKQaV4qlvYOKQfts33l3mOgsWyHNvx2WmhHcxvzTkNc-yIBOK149D1Sl-LSsgzky
    biQlS9qdG2Oe0ZTtzCWUhX17LZfVbxiIFoAYPqrvP6JzJjVu9lxDg>
X-ME-Received: <xmr:_WKQadeLkugoqrLB1Q0GbymjSV-jzXN2rWQQg84nSOGF4qbVvsaHeaK6NyqSh_ZcZjkr6hsgmHMfd9z0dUzjhmo87OvPYPaRnCocDIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddutdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepffekudfgvdeugfekgefhvdfhtdekgeeuhfev
    feekfeeiieeltddtkeeijeekgffgnecuffhomhgrihhnpehsthgrtghkohhvvghrfhhloh
    ifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:_WKQaZDCXOVfx2v1pNCLegSnXWRS7Vq9yRFGpI4SZwHUrIOW5emsMA>
    <xmx:_WKQaQ9tTelvV9N55CdYNBZghbCyxLzFRtnlWFiQIWBAIVTmVoOq_w>
    <xmx:_WKQaUI3XcAdPNZ20VVUCBBq12rXBG-MqbpE_H_b30g3P3TiWSVPXA>
    <xmx:_WKQaZjmGFzMhWsM7oLnOkhUeHB-e3E-7BVMbm23o4KVSQRQGF0kqQ>
    <xmx:_WKQafLdBI9SINTMWeIl0LpZs6jzy6B5RFqc3ecXKzutuCiS2EGaQsF6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 06:56:44 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	ben.knoble@gmail.com
Subject: [PATCH v2 1/3] doc: patch-id: emphasize multi-patch processing
Date: Sat, 14 Feb 2026 12:55:41 +0100
Message-ID: <V2_multi-patch_processing.372@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <V2_CV_doc_patch-id_4.371@msgid.xyz>
References: <CV_doc_patch-id_4.275@msgid.xyz> <V2_CV_doc_patch-id_4.371@msgid.xyz>
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

† 1: https://stackoverflow.com/a/19758159
† 2: This is `master` of this repository on 2025-10-02

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: Use my weird daggers consistently for footnotes

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

