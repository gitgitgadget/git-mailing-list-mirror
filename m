Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F92D73A0
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765130142; cv=none; b=OX6btLFxVpUiwZzabaXR2FWlQgjscbQW0wIOfS7kpQawI2eJD2pCiiB0Zps885ZVaQZw7qxZoaDH6Wltnv7+tmEVGzpz3rE0Vo5ZjDps15P6wM+Z1FuJkl6CR1DWZJncpMnGuhPFUsjAc1saiZO4+UcDeYZl1svm45v5dd7SWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765130142; c=relaxed/simple;
	bh=uzjGb6RYspybRlJ0J4aSTJ+vgvIivwKmNyObDnWsiJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqKxNPEgq4u3JhMFmlwqt4GNlCndmNU+m9+8I23MJyxWiLlCfU18nCobNisJticNSfKgssX8gchi2gtxlchO5U/Lg/ctDo2pdNc7TSwBarXhtUkoSqhJD+zoii3VElX/SK/9P1tLL/4xM259w8rfLouU3DPV0ieaeUSvnP43YtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MJ6vmFLy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/7cDSZA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MJ6vmFLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/7cDSZA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E47FEC04C4;
	Sun,  7 Dec 2025 12:55:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 07 Dec 2025 12:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1765130139; x=1765216539; bh=OTgXw8rkz0D7JGJghm1nT
	eFfVFcW/aWedoFZg9aoRL4=; b=MJ6vmFLykQsv3ZwO/FOXze0JDB4xNPt7g7gld
	qLMy6niOyy4PIGsjv4E9Lp9OuQ2zlt/M4Xe8KJqWKFploRbm7XzfLcvThHMWWJrO
	0RGLjD+59IHhlg24bOApFLYT2tK/L2pNyQvw2DEcSDj2zoO5yhjgic3UGTxeTVTV
	PU8bXSDYjTCSWrQdF8CtgNMYaYMOxNYvpVOfg1m4vxj4TAvn2nupaEmdqVg9/WcK
	W6Xh4feh6wGn2VdVRPXlSrJ+QjjgcYFuM2bE4gQmerZ1/L7GD+VA7MBlUsWBNCgY
	eIRpWQXpRH212aeY8BpMG5EJVEklufTLiLatZdwDqQ4p2lHTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765130139; x=1765216539; bh=OTgXw8rkz0D7JGJghm1nTeFfVFcW/aWedoF
	Zg9aoRL4=; b=H/7cDSZAChPt0skvN3geeYTzEhIQUhfNrQar+Upsp0dJgXv1v3W
	9Adblxo1pJ27rNcry+qYlbapGdCIfdR+2FNDg95jQSHW8Q7/eLKMiU5bc24vWv93
	IS87yBm0T0MmKHAItPX0XDrtOdG72jj2obRJmJwCQua0fRoQ/7YfIyP8zxlCRLp6
	ALyH7G2vq7aRdMrRPV4aT+KSh9Rz8q+UowA8/mp/wOy7vgVfw90j37Ej0D2+1ty5
	PwU9CPR/WKn035rZxvPtKI1pjjtiQA37ksx/5URVfruQnSkfEDairBLiJcV8+O8b
	/AlcLE3CasTXKINSvsbW8xYjpp4W0dHkJvg==
X-ME-Sender: <xms:mr81aaPWuVp8Gv0rVm2oo2ZMb261jwu2T5XhA7Vivh9ob9GBDKjcmYg>
    <xme:mr81af27Z-sYERjIboCI6I5JabquOEJSDE7V8W-6VOF9AeJICFRjtG3XuV6CHJRze
    0u8bbM--GI7f5ZUf2YtdyuDpbvYwTuziALIEq89IRTa_1BXdNgNUQ>
X-ME-Received: <xmr:mr81aZnrXsTm7stQEyvL6KDPd83oQCXn3x5jR4pWkfAzAbTpO8eAXziE8tYPY6aOnsqwXpjcbOUdNQCWD82FqdE4n8OdvcAjl2zF9XldD0Mau8Hf7WWiwfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmnecuggftrfgrthhtvghrnhepvdehledvjeehjeejheevtedtjeekhffhffevtedtfffg
    keduvddvteefjefhuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouh
    guvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:mr81aWXwwkiwIaTd2_vKb5KPuDT-oU9A3DmRL_g5xBsF2GYMzKSYGw>
    <xmx:mr81afvVLIey8KrWWhs7XJVI4GfSg3FZrAFHbFxw9ZfmWEOdeznklw>
    <xmx:mr81aZb3tsc9U4Jn1wNydJ23Gzs8xZJ7GhvUkDU72G9WA4hvUwdMVg>
    <xmx:mr81aeV22ROfFuKjqjHsTfuc_vnJUytMck5iAEI3QBxlG_gJytWNqQ>
    <xmx:m781aTE_ybUPkAsJVYzbE5LtNlvyrhWxKiaHCsFTgboTcYb9ii4Xv7fc>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Dec 2025 12:55:37 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 0/3] doc: replay: improvements like "mention no output on conflicts"
Date: Sun,  7 Dec 2025 18:55:08 +0100
Message-ID: <CV_replay_conflict.101@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Explicitly say that conflicts do not give any output. I found this a bit
confusing with the current doc since I am used to other commands
complaining loudly.

Also two other things:

Kristoffer Haugsbakk (3):
  doc: replay: mention no output on conflicts
  doc: replay: document --contained
  doc: replay: link section using markup

 Documentation/git-replay.adoc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
-- 
2.52.0.10.g08704017180

