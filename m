Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F039901C
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502697; cv=none; b=WoTf2sJhkr+l0IsYG53bwZBkwSj2slKtQy9XTnouNE+AFX+9RlTHcykSKh/9W+IzUClu3cK4WfGREs2690m8VCRkGkVNjAmgRYdD4rNoWBBfJPci4IVUS6kDQSeghIOpa5CkQYC1LjvNHaWh9wB1MHRgihg1NSg5e+lwtvjCg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502697; c=relaxed/simple;
	bh=BkFGkKez8iHb/MusuO2AS4l4fIbjfWlhJnpTTSbUZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj76hE56sc+q+l/ymlO9BiHGRDJZyRzTRpIk211Ma2jjzeOOANFVgA7LlmpIGe2Z1a44uDi3iLXV5tdlKUz3cdOQufMAAHD6zVzvrUNkkTJl0qGxWF/KJCBBUSnYtQB0Ow+dF5BN8fLJkyc8i9CVa3mZbYXJ351By+3pahgpfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b2IQOS+X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zo8i3SZd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b2IQOS+X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zo8i3SZd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 319521D000D1;
	Wed,  3 Jun 2026 12:04:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 12:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780502695; x=
	1780589095; bh=dqVTUHuM5NqzzXEhARYRIZwN7L3IqYN17j6YGL07Cx0=; b=b
	2IQOS+XtFhH+y5XoMHGJ1kKRU2iUWv2CQcoiMcPfWusmIGrywVmM+QYUS6leYoiu
	y4Soa/lJSnZviHtsGRQloFh6t2ycAp0EAkkAKk7JQ8BWn711g84y28EY08YWzZzS
	FVdNqXXSGvp3zDoWLnishN8QX6GgpfdF9xOObhRT5QwDHdbKCrinOlGIBCdYAasJ
	7jX7CHsFKf+6Sox3DTbg+5+PuqftBTMLZPzxg1ze69Ekgk6B94jdhF9Z4OlPjb7D
	S93coIAmxaFFGdEjf8nl40MW7OAoJ5Jt8ViTteFvAPbMX/Y//7KqPyL4Mx0C0rA2
	x7L1yP08lC5B2E+FchuVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780502695; x=1780589095; bh=d
	qVTUHuM5NqzzXEhARYRIZwN7L3IqYN17j6YGL07Cx0=; b=Zo8i3SZdSeHd/Qi7M
	0YPHy8AVQ3ydqV58OD3Hg2dEFZRylIsXVuIq60jIfiwyqwFMn04h+B1XX+CpVNoU
	w7gnLgfjCgLE8rHsbFfAuWeq1cTAnUB9l/IHQoay/ff1JZAapY05JK4MYFtOfxUv
	dR6nd5cU3THY7aB/Ki6y03tZbqmYj+R5tuOVNTrZuZgLt8DhhcZEjiyQcR/e81oS
	CcJvl89Rm0SBqr1bv0LKOzGE8cdDdZhs8m9FV6Z2XKa5vd//rzbPN7eG+1lncQrA
	sjH+U2Z3ANRTmmFcu1744sLOgivzPv0seuzTKDZl/0OdQi56p5aPyR4UDbmy93m1
	SWEjg==
X-ME-Sender: <xms:plAgaqdLRXg6WlgPoTQ5_NNKpJpvOxXkkQxLoaqp1sSg3cNPo0Je2ws>
    <xme:plAgarMAnGoTSWp2XrB1vU26F4bC9yxfkVFEHlMnMBiF3v7OfVdkk9Vg-EBMAdrwz
    pis23dz-tLHJfLzHdGJBbuVAU0I6DVpMsAQRJk_oJNTUADAGybQtrY>
X-ME-Received: <xmr:plAgaggs-9nCjzau7nF0jZwKHvUlY6WOWF7nTgmS93VS6GvxkmKam3c09h7CQY0wNtJUwh-Z1-2l8BBOX4Wc7APdl-xgQ4StnVSC5Rw>
X-ME-Proxy-Cause: dmFkZTFfOJZ0ptXvf0p8IaMTbZcx35iI+erJTdybPECgZw4fu/CJ84Nw2iVgl994fQENJ4
    LjqyjOzdRwK6HYbPQZoOiatFbp9ANpaJNyv/yDuQEEPjzy+DVw+dnMQ37ceiaMsI8mAK/e
    G2zdh/3HbuFDRylk1Uj7XzZoC4qzapqrAfufF0BbemF7rX5YsZTmCTO8be935w8AcxRxIN
    LTwb+DBErxpHeSYFZDxMaj8V6zJcNfqUbrni3dB/K2/gpKzSHFkqDec/7KQtbUjpMud2Zc
    GpYoOECuExIvm8U3necqbNdh6S0ZnT6j1bU78Be2c+Y/M5kSok5mzVf0VXR+FfVFVDM8po
    sdk7glU2AodXOSy1xxv3cTnn/vN1eFc+Eyq6iaSsWmsXWvWIPq8xFZgXPCWpAKKpSLypeL
    AY5lIbJWTBOr04SP0Awecm7Oz6gzs+2y7lenE/iTuYlazqYWLg2UjaehLe34Wp5YB2RlLX
    nU6S0L7zd5w17dQLVLgFr+GZMCoEPzOfz8CymtYIdrBjhzXYKjgLiE+QVIIlCq2K9MFwdz
    Is4brx0DjgsAcYsZLR/mC3kP5DP//Rz6q0GnJmQf/xrTZTNarT57UEyvEeU3qv4/zj1KVv
    rUee9UJ/VOnN5Otzk+nfcoBm8WzMKObokqBRlkTbM7o3vQ+UfpH3RBbYe99Q
X-ME-Proxy: <xmx:plAgam39ANoPzEFzBgePA0Zvk2GjOR7J6WNAR7uZ6XyF-fbEhmlwFw>
    <xmx:plAgaigL2YkL8ATl4kWEIQxGgJpAYj9HwS9AMnjh3CKIgKq5sCN2zA>
    <xmx:plAgauf95fgwIfhjfWm7bhhxcUoezsdyP54ou98nS03uu0GV7aHn8Q>
    <xmx:plAgatm46YawsS9H9rj8koO8FRZEEkOtAc3iycdoQM4C-enhrnbG5Q>
    <xmx:p1AgakCswozvrnoCZRaZYoES-9B3IB4YnzkAPVgb537A1jXkm9IeHIRm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:04:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2 1/4] doc: link to config for git-replay(1)
Date: Wed,  3 Jun 2026 18:04:22 +0200
Message-ID: <V2_doc_replay_link_config.768@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_doc_replay_config.767@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V2_CV_doc_replay_config.767@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This config doc was added in 336ac90c (replay: add replay.refAction
config option, 2025-11-06) but never included anywhere. Include it in
git-replay(1) and git-config(1).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config.adoc     | 2 ++
 Documentation/git-replay.adoc | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index 62eebe7c545..51fabecb9b0 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -511,6 +511,8 @@ include::config/remotes.adoc[]
 
 include::config/repack.adoc[]
 
+include::config/replay.adoc[]
+
 include::config/rerere.adoc[]
 
 include::config/revert.adoc[]
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index a32f72aead3..f9ca2db2833 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -209,6 +209,10 @@ This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
 `refs/heads/mybranch` to point at the result. This can be useful when you want
 to use bare commit IDs instead of branch names.
 
+CONFIGURATION
+-------------
+include::config/replay.adoc[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.54.0.22.g9e26862b904

