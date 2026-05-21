Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0232E974D
	for <git@vger.kernel.org>; Thu, 21 May 2026 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386574; cv=none; b=Z/5rJBuBUkaPrp1C7rhK6CTCQoEWHP7ESbb9qvQfpirljaH+8ethg9htTYZ8+k849lkPOLUJfum8OH3+FDBxLWDf3hIe2qxoNvvvRMeGSPKHrPlpVq+449wSD5O7dENWZ4SJ6LGeUAEVUeqG1I2HIlrFeymdL37i3lLNLyfSFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386574; c=relaxed/simple;
	bh=Mb/sXdPtHf8x55+euw/D9Yr/t8Wxze85hIEK+3fb8CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqIJPMszxvZfdQiXHqE2IllR4hL1BpSJHMNQcclRSyJsNEz6lCaxR6d5iJVd0vYhsaKYMynHgEvdYdPHzjDAbXf7vaZ7CV2EteQ2wVFpOBgpYCT2HsQqDwL0mBEgtlAO/ljo5MQAsSJjPZCnPDnJpHHCpF4tBQeXZ6A0CU3YNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KobZ95Ay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOe7h5Zb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KobZ95Ay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOe7h5Zb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B65A91D00084;
	Thu, 21 May 2026 14:02:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 21 May 2026 14:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779386570;
	 x=1779472970; bh=qLTg/6m///Z62AH45FAoRr0FZ+G5hBDGGm4Z3IsX8Ww=; b=
	KobZ95Ay74xNGl+OsAIpVWTIlXmdD3p0sFTDHzV6OpcuusyoqWjV3JkLCL1UBTBv
	GOXG8vCTTOnsE/g/ua/3r/03y2IlYEBUAnS7p7nFYUfC+bTHKB39jAsBIcr7AnBT
	psHqc+Y6VIiLQYjQq9kgfZesk+HA3Bxb9Oi280xScgZIBGTcoZMTXpBZgvefXmQN
	0mjBQbscXfCZHXIRn/+Zmp3W9YTgDVjZwfWUD1rPH4xcSLBq6ih+gZQGZUlAs97n
	TfkXzeDxid/PvxznA3XlsbJFDztBh6zYH/gGXCIPJe/n27VwDDDY3HsrGgTL0TaR
	DtvrQAbXAJis/JvFB+m+Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779386570; x=
	1779472970; bh=qLTg/6m///Z62AH45FAoRr0FZ+G5hBDGGm4Z3IsX8Ww=; b=U
	Oe7h5ZbtJiteF4KcvOQFnTZVirjutHBTVf14bEvKe/kXhjCDJVkpTV/s6u6fXKeH
	a+/x3vKfFw+KfyMyXPxzVki9i5HwF7lRnDJGNWJ2nhluRvTBzuws0wQLJifohh8Q
	M6BvN3XjtZrqsaiZiDkX+7z7TukNYCg7Wjjlt7+Wj834kqq8HP2mTvFTMIPlKS6C
	96FVCKKiYuy68z3BAPXbb8dRhqBGcm8k4EvjhOdxw/kaZ52MQv09iNc0mbnAAxXD
	N5ZZ6+L80Y/AOiml2dgGrb9mUsD5x10FAhnbBOUuNUHo2b1lBJcf7ZTUKyl3MAzu
	10c0YE8qGbmAMu+wqbpKg==
X-ME-Sender: <xms:ykgPaloSW2efKZuYNjLrf-kMmodQDk1CozJNyj4bEgX1ysPKk3xtAOk>
    <xme:ykgPaq60uf9vOaZ5Nn4emtBuSNM_nZE4R2I_PdMco7v9m1-JcHL6PVzjoX4Ok3a_p
    ed-f-519z7aXUSZ-fmK2Q4hkX_TLDDoYDWcxL1ImW-KbO9Fd8iiwA>
X-ME-Received: <xmr:ykgParrFmBdB9y7FSum_gNOAQvMkZ0YmOfnr9LHO0ZMHaVO2KPpIcKKjsEShcryTvS3ubj9sj0rBfw1YUvHuA5CCo47xLS_0iITXLDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ykgPasjHikuvftiW8v0zZ-piJzt85jUUNbEHsnR2JeRM-R1eemZSeA>
    <xmx:ykgPalJBhoBPnZdfoji2GT6j662xgiu_adlf6l6DPYor0hGdPXExgQ>
    <xmx:ykgPasCFRBmx7n0G7zODPGSOw1UWe8l_UDnXXJA2LxzQdeR2vMGmBw>
    <xmx:ykgPalgzhoKsMeVHfZehJ0ZvVyltoY7bYpQNgS7m1J7TF8Y_4XYJ-A>
    <xmx:ykgPariObxilT_xaDp6nC7ibO87EGSztKpEYeVxU1a5g7tvCrhUl4IN1>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 14:02:49 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 2/4] doc: replay: simplify replay.refAction description
Date: Thu, 21 May 2026 20:01:59 +0200
Message-ID: <simplify_replay.refAction.70b@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_replay_config.709@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We don’t need to list what each argument does since the documentation
for `--ref-action` does that. So let’s simplify the `replay.refAction`
description by referring to git-replay(1).

Also make sure to not self-link for the git-replay(1) inclusion.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config/replay.adoc | 17 +++++++----------
 Documentation/git-replay.adoc    |  1 +
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
index 7d549d2f0e5..42e521694d1 100644
--- a/Documentation/config/replay.adoc
+++ b/Documentation/config/replay.adoc
@@ -1,11 +1,8 @@
 replay.refAction::
-	Specifies the default mode for handling reference updates in
-	`git replay`. The value can be:
-+
---
-	* `update`: Update refs directly using an atomic transaction (default behavior).
-	* `print`: Output update-ref commands for pipeline use.
---
-+
-This setting can be overridden with the `--ref-action` command-line option.
-When not configured, `git replay` defaults to `update` mode.
+	Specifies the default mode for handling reference updates. Either `update` or `print`.
+ifdef::git-replay[]
+See `--ref-action`.
+endif::git-replay[]
+ifndef::git-replay[]
+See `--ref-action` for linkgit:git-replay[1] for details.
+endif::git-replay[]
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index f9ca2db2833..4de85088d6c 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
 
 CONFIGURATION
 -------------
+:git-replay: 1
 include::config/replay.adoc[]
 
 GIT
-- 
2.54.0.13.g9c7419e39f8

