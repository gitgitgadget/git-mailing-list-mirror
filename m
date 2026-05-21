Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48BA39FD9
	for <git@vger.kernel.org>; Thu, 21 May 2026 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386610; cv=none; b=Lvm4je2wdq98qx8t3ZPUumAsnZAe0FSLpsO205scw36JjVCTXSYOKynJvGTlbpO294w49Ur6oHavn64dJ9isspgdLXRFNystAn1x4bHB2mILojEb/k+m8BtBhq9QVhV4tbVM11PXiOf8pzXE4CkUeugJBlGdiOKbTOoorEtKZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386610; c=relaxed/simple;
	bh=+/hudcWb4VJM2jCjYJ/ee0Gp/JDG+xlkZGOVhcwFjE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr/quCGQ4iO/xDtHsDpkJve3zWmqa1Cic+/UaPhryVKPJfaVX/s/tA6bqDqXVl7aWDqD/nNTEay8gQBWL1VgjtL48cyU7up/0MTT6x7agMUYS5kjkSYX1bjov4MCErA1ys0GXYd9YTjBeFmqbOnPwnZwIbMGiqJhF2JZ7ZroynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FVZ1Wn9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbB+CE9O; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FVZ1Wn9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbB+CE9O"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83F3D7A009D;
	Thu, 21 May 2026 14:03:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 14:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779386607;
	 x=1779473007; bh=TE8FprOsPtwK5HTSdANSk7G1s+s/esjfOd8c+RPG534=; b=
	FVZ1Wn9N98bGxf2f4dFiXSjPhAZDazb11IqM5PkpJFz/b7Ht/yGNyL8ouods4wtU
	PWr/2EZeymcovPNo6St/n/iJVt7HJfBb0W+tdFxk7KmDfbrnWutolin3h4PFF98H
	FYy8ASjVYnTXpztnY8zfynpLpLD3Spm+tCU/Y4Kfb4K0wEjD9WI8lfEmbUKRZr6y
	gOB/udx2PTBJDq3nwBpvMOYRisHuqwIKhPge9Xn5VXkF33y4gilfkqOD/2s+YL79
	h8uBEzp58Uy3+cVlBkyvyDT9Qa/R7aSk8QHlRplygigvSVbKJQNkpqER07a6iqzj
	GbXKqR3M1ZR5VZANKMJ31w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779386607; x=
	1779473007; bh=TE8FprOsPtwK5HTSdANSk7G1s+s/esjfOd8c+RPG534=; b=V
	bB+CE9Oh9L1/uDCj59KuxEKUtvv++O4kqrrnJB4NRuqYTOH+3bZ/Lw7nCIIrt9re
	7qYNM7GKs+zbKa6ROiUotH/kEEMRW0Gtd4HeMj8APGTYGdAAoU/Ct74wC0Hs6U+g
	AYtD/pGpYFs/Q6PnVrvF580cFlvmvHyi3W09NV7eITrvDhM1e8rnqBhYefC3PKEb
	of8SWUGICqkPL8qZQfZuE1jscVO7A+TL61N0S50+g15xDAISuf8hwloKmkjPQ+fG
	EmT4THpvVs+EKhMXYoV9bE+7eQ1NjXMndN09TFJZeEg3zLH2otd95bX7uJcfOgMF
	UBTGbI3a7pRyz9EXu+BXQ==
X-ME-Sender: <xms:70gPakqzcFog_EjMsKyuqCjNliagAlSzcew8lpmd2Rm0NdA8qoUdEUc>
    <xme:70gPaiHKGunfCBIxSBmoGEtKiKXgt6I6IOxcmoHPi2yhm0wKuyiOk2uy0J5Kx1N4V
    sw6D8eHoHYH2PM2KFPoKI_dsbf1kp-liVIiNlbQhUoCgDFKfK0CSA>
X-ME-Received: <xmr:70gPamm-63pV6NhPLCvY1vr4rVtwdsyaJLpn3jrBevo1qI8NxVIVc6HuwXI-Wxp2K5rinkvjdsy6XW8vYsxbOkcth8rwy6coLcpgDP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:70gPalnsCKN1c-N_evvmtcY6nbR3oOJQ-AaV3tsBoZPqCrxDLbyOkg>
    <xmx:70gPansTkuniYxCJB0A7U_laLFDZGVyF-5MVF47nyFZ4d-V1PF3WuA>
    <xmx:70gPaolOqFryc-lrsIo6FUkfl8SM8MWdun4biDqT8nw6unGzPxadJw>
    <xmx:70gPaiuQV3LVpgThnXaMhP3PKq8Yth9iQkwzx5SL6k2afnwY1tpkMg>
    <xmx:70gPaqEHHVwkiULt1ZvfP8hu4DPVGFzWXfs8-fE9C-tgTInBDxnaH1Ql>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 14:03:25 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 4/4] =?UTF-8?q?doc:=20replay:=20move=20=E2=80=9Cdefault?= =?UTF-8?q?=E2=80=9D=20to=20the=20right-hand-side?=
Date: Thu, 21 May 2026 20:02:01 +0200
Message-ID: <default_RHS.70d@msgid.xyz>
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

This is now a definition list (see previous commit) and parentheticals
like this do not go on the left-hand-side. Moving it to the other side
makes it stand out just as much and is also more consistent with the
rest of the documentation.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    > do not go on the left-hand-side.
    
    At least I haven’t seen it.

 Documentation/git-replay.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index b4fe43ec687..39ecc2e1876 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,7 +80,7 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
-`update` (default);; Update refs directly using an atomic transaction.
+`update`;; (default) Update refs directly using an atomic transaction.
 	All refs are updated or none are (all-or-nothing behavior).
 `print`;; Output update-ref commands for pipeline use. This is the
 	traditional behavior where output can be piped to `git update-ref --stdin`.
-- 
2.54.0.13.g9c7419e39f8

