Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE996209F4B
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980842; cv=none; b=MX1NDtawgGW5DYVrfvcXZhEd2lhKrp0ZInnTUTKDq4as8aAA0Bpc+rNKRFWsXK6tDr6HmZnP1sLQMiPOm3+Z2p3g1CQ0Z67kk2T7xoR59mwbeiUd8dugSdUIO5nGwqMXsnmne0HVg6s6gLmrLf+jtFKPx5io50bTjxGMNNvYuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980842; c=relaxed/simple;
	bh=fzsFAZHw5igxKNvXxQSgMP6x9QOet6/NhaKyJJ4P0vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGIt4GE4Z5JAeDiIvxB8/03I0UHqfY0K1ebtYapZQh2cW+1cS7WPlJAssygveEKS9ZYHFCLxeWLeSkI+dI6guuDzsNmSRebjbmE1ARg2LFBhYnMdBaMDFZ93yk+ix5tFcS7uGkK8klD2uX0iw/0uTKBMz4PIinWrbGPAIlQS9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UBHn4cHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e6nzas7V; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UBHn4cHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6nzas7V"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8819254011D;
	Thu,  7 Nov 2024 07:00:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 07 Nov 2024 07:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730980839;
	 x=1731067239; bh=gW3FOL2R6/yo4IK1CL/FnkqG90Dml5nsQsMxxIhJvXI=; b=
	UBHn4cHI11viqgnOERFoxZ7iQoHY7v+QU7RdRcPK6cxP58uBD8ve6fjN3Agf5w2R
	ptYnP1k0wVhK5rowS5p10BjQbnYzCt8ZK8Yb9hHhO515tJ/GchBtUamsjcQz7o7B
	oy4utYdPwMzeISH7RMaoy1MR2YLLrJx2tTr8l/F4ZM7N6jZZA3++z1JpLk/CDVTo
	54uZhd1SNAipKOAYVEwoBqjkoqdjV8ZpNxwa7mVeiTSKaowMLomR1cwgSg7Bsllo
	OEZTNPcLaUtQeEyv8cq46f2s9WWcAVhXRwoScfcsjw4yt9yhdiu845UhStXxDpCm
	52l4a4dtSoEpzNND8vGb9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730980839; x=
	1731067239; bh=gW3FOL2R6/yo4IK1CL/FnkqG90Dml5nsQsMxxIhJvXI=; b=e
	6nzas7V1mYPQJPspsk17kE0gkFn/NDdvFeF9H3Kjz49MZpiNGZEIpyUEMKfS+yaE
	JdofFY9wcyp7pmKrPETzdRb8zTsZV+Gn28Gm5xlsOFtweZ3libdIqM9+iMTM0pBN
	G+yjWsEU+LW8VPmROSwZ/yBzZu+7yi0VkdhEP0yDuiMa5tlrGycL2Ke38MCbfKcK
	+12c6vTHKzCQMfiJ1Y5YpBAsw+Pt95XvqA/LBS+zAUk6d+pcri9xYpWGn1/7X0Rn
	jsCSuM4m87SNkcHdMrgYTaYzqNsezb7FPta7v7RyDZrRNI0LaQ8Fa5F/cTZNPuxs
	uo0JpooisXaaUWQDPP/mg==
X-ME-Sender: <xms:56ssZ6rHJYXd62Tz6AYuGPylGMsNz7PgHHS38RwjJpjlScEQ-VPc-0w>
    <xme:56ssZ4rbJmdeceaN9tD3LHz5GOHSvsKT1cu-6R_Zoi3nALzLcHXn9E0MCfrvq6g9t
    eMrnkpJlUfsVHF-_g>
X-ME-Received: <xmr:56ssZ_PNYdsHncgqvL4yTo8BkusaJij8wGJT2tZSkDv5KWx7PiEOawcvfPnT5hpIDdZ1Xi79kXNxqRzNLa11yLEYcYUNUmm4t18SE7sN_gQo5UfPjOmUf70IUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:56ssZ55ulCIIWbbVvL8xbfsTG674oZzu2duwTzO9kr8r6HmTgf1c1A>
    <xmx:56ssZ57RgE53fg_tIeT7SRGVo51Tzr2MuWbFOC_VZ_roqXdH9k7i0Q>
    <xmx:56ssZ5jQu-tJWiqb2XH3XKYnzxeqDQHmlvWDo2DbrS4bFisEkanhSQ>
    <xmx:56ssZz7yHataUfiQwYgftyaMQ_vCyP0Z1rtmhU5BdQeA46TYaOj2Dw>
    <xmx:56ssZ3T9cPQAs3aNyo3yfeLhTqznfLCOM8LrKd9vMfEE4ufmdCUpyfHZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 07:00:37 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v3 3/4] Documentation/git-bundle.txt: mention --all in spec. refs
Date: Thu,  7 Nov 2024 12:57:35 +0100
Message-ID: <8336b0f451e52c38b59b5ae837c002da51a34b31.1730979849.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1730979849.git.code@khaugsbakk.name>
References: <cover.1730234365.git.code@khaugsbakk.name> <cover.1730979849.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 8336b0f451e52c38b59b5ae837c002da51a34b31
X-Previous-Commits: f18f8ca453d04a65149deb8a25f34b51158c4933 33980a47d132c9ea56238641031e72c5c7e2565a
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Mention `--all` as an alternative in “Specifying References”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-bundle.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 724534a330f..d95bdd0429c 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -131,7 +131,7 @@ SPECIFYING REFERENCES
 ---------------------
 
 Revisions must be accompanied by reference names to be packaged in a
-bundle.
+bundle.  Alternatively `--all` can be used to package all refs.
 
 More than one reference may be packaged, and more than one set of prerequisite objects can
 be specified.  The objects packaged are those not contained in the
-- 
2.46.1.641.g54e7913fcb6

