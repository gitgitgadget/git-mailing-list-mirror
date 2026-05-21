Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3038B135
	for <git@vger.kernel.org>; Thu, 21 May 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386555; cv=none; b=fqUNEBdwmpfIPpdtX1v3XQyJpsRKS4kG0BWvkGdGPk2R7uQURwBqHO9coF7WsuGiTPnk/wnUAMtY5FibInAkNuQJIdEuJ/D9zWqnnel2eFVDjOgjK1//3pZEPOtwuD/8FtR7xA2QfZ9t+kpFQpft1s5P7lg38d6UemXZdWTDzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386555; c=relaxed/simple;
	bh=+6pCm2b2M+nuMmTL2E8SaJA8ZdYJ43sCAvU5bgnWArk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PG2cxi5Wdv/tfEc3KDl0aWden5roucAB3uzvHkBHKkJMj7EYjmV3vCZ2B2lrPDNcJI3oUMcCME335glB3t41y8MRmSg8j8dYM+cHkZ9m/Kg1IcireCUzEkQ/CVO9IMR+aV+RvOrAZjPqVp4iQ3YohiPOx6KkwP76mQzbPE/CjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jU+XoZV7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWlFkaq3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jU+XoZV7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWlFkaq3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 26DC81D00082;
	Thu, 21 May 2026 14:02:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 14:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779386552; x=
	1779472952; bh=IwXxDx16aUrx7q8J3i7xoMl9tQYe6zNdS4y1gJEYRvo=; b=j
	U+XoZV7FQYlH2KSqTCJVGBanZ8IvMhuotUOIMpx1Gm1/V0dMIvl3/KDRUd8ThDQ6
	joHJjivGZc8+FOjC3KJ1zGSeHUDXhgMMgeNBoR7jyxcwVZluW0Gy3hZgOz6IHmdo
	ySIVt48JtAyH36KBuwYgc6gLgfjWyGo4gxdLrksX55AgSY7oT8vUpibnX5tBLvdy
	RGEAfqa9HQjWp7grJ+kFGnnd/LFtev6N+mx9iHerNO1degutAMOfDYO58Mh7Tjfm
	gmEIy5Mqi/PVrNPog4ODu+4Zt1YET1d9AXjPxiXBvaJ0djHmbbrS+jLAxzC6kc6A
	Idy77qH8G78maVWemJXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779386552; x=1779472952; bh=I
	wXxDx16aUrx7q8J3i7xoMl9tQYe6zNdS4y1gJEYRvo=; b=FWlFkaq3uvyYaCK6c
	BQPK42GRtc9QcCMrfMzrYQHMjxBuUvCjWPZqDE8CPskhJi03zwCdLVHvH676hFym
	5PsX3DmTMAgoh6RBjTOnEjuDid7r0g24lvOCM7cfF2JHpHrx3+cIYRrtidM1T38e
	k3Cq0ZOWJD8oyrxyuI1JA5U9XlNd3/50+XHSYsSCAU1BbGjKC7qcU/kO62xJOZbw
	oyzXexqLUd74u9V2B3tfIR/nf2KqPfSVh65W0oLZbwlMHFs9QPSlTKF7PDNtVq1A
	2kF+syNdTOUcgms9K+qOFg/UZVrhe7fkeEaYrcwA63wqm0jaEkUHMxnyKD9BfiZd
	93sMw==
X-ME-Sender: <xms:t0gPavC5UulvrBms5_2c7IfSVyiB86X2X1jWXhjgGzrD8K_Z0EXuJKA>
    <xme:t0gPas_CWOYVBiFoaTk-MGQnWA-UkSi7wC_kL0Pd3tZQn7x0e31GAihXP4FXAmf4s
    5sFeuVfazV0A5kkRY9GUSysIHLI54uI89hzqmsvEpEHQpQ-vDqCaw>
X-ME-Received: <xmr:t0gPan_0IiC03FsYEWeR_2TNUkXi0pKhqAFNVom2yjsTQWsNk75Tu1WY-9mNQUTy3LeVrbtqcjHL9uu1pxzvfoXVCREr3yuyJMgitZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeefheetkeeftdeiffdvjeetueethfeugfetgfdt
    veehhfevffeuffdtheeitdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsihguughhrghrthhhrg
    hsthhhrghnrgefudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:t0gPare3aoY8U9Zsl1X-luFU4k_DeRJkNAOyCvlp5PyB08VAYPMrSA>
    <xmx:t0gPaoEelJU8b7yQSjp57QGuAOigBx_BCNH0DSbgI-F8rUWuaJxoDA>
    <xmx:t0gPahdk9srMhcu4N7ES6ea9bu2HjsG3yLH-1KO9LM68nciLezJiYw>
    <xmx:t0gPaqFR3G2UcsRHAO5RI8Gg6hr9eyf6OOOXVnlzNbrywttGcmFehg>
    <xmx:uEgPas9l2ROTkHPmuQ9Q0mj5Ih_566Lxf7DU9wlMBzAxFlweJ9jaE55g>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 14:02:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 1/4] doc: link to config for git-replay(1)
Date: Thu, 21 May 2026 20:01:58 +0200
Message-ID: <doc_replay_link_config.70a@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_replay_config.709@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz>
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
2.54.0.13.g9c7419e39f8

