Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30127E7F0
	for <git@vger.kernel.org>; Sat,  3 May 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299614; cv=none; b=UK7IrSjGV5cnLE2kJUzjDIeOVj8mmbQh1HXH9t8yuaupcOdK9Q1whwS9wMhMIKLtHW2buVhO3fcyU4WO64ZGBvr+OFUAoYDZxBNJGreKrlNXtXS8L4hLix/gSvmLKgA3W8/0Uhxy1Qg7ujE2pw3Fa3lsoU37qd6XO0xN4H7BPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299614; c=relaxed/simple;
	bh=EFj+2BvxzSixQJNB1NRu52OSe8wowsAzuwoP8osq2r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGtBgaKt/SK75FAb1qMexxBQFjtErbf5u7xFxC73MRMw0LyUVPaJr3C/mmBHEzaBPwd+gXh6Mz29gXwvCrXuDka43cMOncB3uXyV6HYJXjzvoRgjte3om6BEitsukPHtBCe1Jdo2KG9Itn4dMFmQmcFsE7f/z4lXFhOdz6DDyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ps8ksuJM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qd12FJUa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ps8ksuJM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qd12FJUa"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD5AC1140170;
	Sat,  3 May 2025 15:13:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 03 May 2025 15:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746299611;
	 x=1746386011; bh=lvVDPePfX/ZoS0DeILMqOuzzPfYKAFwEdFAH25oDwTk=; b=
	ps8ksuJM1vwjtWWT/PNWl5zPcAYUh7rvXsL9RcTctOiWAnRisxzsEikeSdc4dAUf
	VUUC6BJh1WPNFXljVS0GuTlK3wFrXCDIVX+FmhFKwDGefw0fCXeL952jbiC3qy/q
	izVGFLPsXi3xD4XxAXsCSQj2w8u4NVgoQ62WYLaw/jENHdDZXMmLsNVJHOKtPx74
	9V7hytMXQ18tayCzBV+uivLbJpjdCUbQbqIl+Sdy8xGUgoDP1ge6nVw4BvgXJLLz
	2j0Fsny91YKglu0LaA7kdXinEZEDs8N5XGc4rT6GsJwFgQ7ySALjD82iwNJJkZx2
	dJpK8APXl2FO63j4VDuBIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746299611; x=
	1746386011; bh=lvVDPePfX/ZoS0DeILMqOuzzPfYKAFwEdFAH25oDwTk=; b=q
	d12FJUam/kSQQFjHGuV1ZyrDRhJriVUXmV/geXPNbHdzQALX7T2ev61vzBnN+BJ2
	T9FC44teDFBvXvXPjeqSzHtx+UT2Rwu7W3IeaI1/Uy8eHWYvLhlLMBNcoIewy0nA
	KNxwfS/pj4MMnQsVBcLL45wa0AF1Q5UyOOAlAngNCboqzBwDFrSfbSN8UdtC6FX1
	aI5MSj2P+4ATfOlKV6zt6PQ240rgFRIsWo9ZOxvkbHjaeTpufwHsk+txAHSDs1Gc
	9KSFAHI0JOba30ouyyhEAADbBaV1KD/ipPV7Adk/9t2MGwKDa/gIQAhix7oYnP31
	CUuixEfLQo5B4yMlVVF/g==
X-ME-Sender: <xms:22oWaKMNjr7_6utoBgagtcjB_5sQ7rdEbnvcC3pc6i1bTcbdYCoqw6A>
    <xme:22oWaI9c9vbHYlFKpnAal6Lx_WlTG9ipUa1Lk0P5K4mmgsRRgO0LQXrLO-wr40yWC
    2dxCqMUXM1Gys7URg>
X-ME-Received: <xmr:22oWaBQ7QssuFv7oEKMD2ii3HSAdPiVjxKvHAWfSNQLOS89g1JLeL5KTdxME6ehi9MTj7nqpavGDfYORz2yXf8Y96Wx1W-ZSo2rAq5_zIZdbjKTf_7ntr2MUhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheeg
    fedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:22oWaKuLmh-mYkk8P2ypw4tbsjVQlnQFDhCF-buqwbwrqpVLS4lbUw>
    <xmx:22oWaCfeMJbxdT1bZInO9izjLSeOfiwCrTp_z7Y6P3t9371aZ0K9UA>
    <xmx:22oWaO08QPm53LJrA_mnT8RTPofA6QuD0U_KSsUYPqDvvE2zqFnY-A>
    <xmx:22oWaG9wMPoGpJPJm4Tak60SNiJ_IrZLJCFz-yhRcMNx7FW2B6rHQw>
    <xmx:22oWaAUEyaoeikc2pzGI3lAnjS-VjU2R9mjK6PvPs560WANqeeWhDvSg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 May 2025 15:13:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/2] doc: reflog: fix `drop` subheading
Date: Sat,  3 May 2025 21:13:08 +0200
Message-ID: <bd485dafa5f0eeb21c8a2eea6fd5590e6296c6af.1746299135.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.459.gf65182a99e5
In-Reply-To: <cover.1746299135.git.code@khaugsbakk.name>
References: <cover.1746299135.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The tilde (~) count doesn’t match the length of the heading.  In turn
you get a bunch of `<sub>~</sub>` instead of the intended `<h3>` in the
HTML output.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-reflog.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index b55c0605697..412f06b8fec 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -138,7 +138,7 @@ Options for `delete`
 used with `expire`.
 
 Options for `drop`
-~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~
 
 --all::
 	Drop the reflogs of all references from all worktrees.
-- 
2.49.0.459.gf65182a99e5

