Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA82236FA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056170; cv=none; b=Efb+xDbicL0wYXE6aSeElAGmKcozIob7HuScoCHTRnjtxI6OXm+oFWnf2MPABpVsZ0G3e0X8568vvzCfYkA1nza/Q9qPeJVVUITaR+6MOlc3iz+M/TYhYDMdZplamrrwO1u6nT7xG7wzb9BLOZupi9EFVdqCiap7bIy84s7S/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056170; c=relaxed/simple;
	bh=5eKgUEOwZVgvqoh3CWHxDtJUug1wvV1H546nRnSPMz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XohEekFkcj8sLsVM44KKwWYldlovtyqc6OiPAynkg41346w89xfNBj0lj2dMIpmanAwgAwEZJafmQMcalPZT7jENbKDruxWnV7Gm2tkQWI8Jx2Pq2SXbU5f5qku2muvUIS0E5A0eNF/sdpeMnITMBX0olobCChfU08LyJ92E4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fx7vVtT7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kNP4QuzY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fx7vVtT7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kNP4QuzY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBDDF14001AB;
	Tue, 21 Oct 2025 10:16:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 10:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056165;
	 x=1761142565; bh=2taiNvTZTOQjYMMUGlRCTQY9DzHiPg6yOLfiKnyHrCg=; b=
	fx7vVtT7rOQQLN4lKScM7y7lwGBDF05dgpw5zTpaljDhL/GnV2LBJfjCBtbXuuv/
	QL1KzZHQwlT4uQ+g6mmU0+bFNUO7dRqNPsgI6sCXAbCFyjiMVRGQn/oZjpT08XbE
	L/0xNu11WqkFYDb8X3jqWCcVK9NYs7aoDc7DemvRoIlBFI46QXjWSJMyzNaPuK1G
	SkbKAAG/AlQs08cUmOPuWfQgw9U8Dq/nLVMVMQLPlQCLrcLoiVjsox9/5YfdcMuJ
	bWzDSgbwRobXrzCi2rpHN4uMbwUv9zIeaEzgjMgdV1G9XL7SeARN9pE4MjbTcRS2
	Tu+HmCZvWDteqODAxX1BNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056165; x=
	1761142565; bh=2taiNvTZTOQjYMMUGlRCTQY9DzHiPg6yOLfiKnyHrCg=; b=k
	NP4QuzY83ImkV/Mr02tTR2PEw+p1+Z2TK+OdKIlKezCvKvJFyNDu/FMWAEQl3JXw
	0Sli1vbBn5tPtbJJEFxYYzGYpfL4MAnutU8ISPDFWGotF4bdmKYdFxUfwP3sCjYR
	TYWjuGfrYE7h9ASaguN2ob8n6sq9UITaI/WTCAtyHPp2zyLWwaEuYO4Iqbt94aKS
	wbd8vOWnb/fgQS/skx9z5NjVd2PNXILJe2o8NJ7ziidNE61tdEv189ZSrqGUFV9Z
	VMCvWR0HTYRlmn4fbqgs7jI34M7M8F8wlJxK5Fau5EQWuo/+X3swg7Gk7mFh+WsZ
	wlKmq7Yw4N3mkNQqP/1SQ==
X-ME-Sender: <xms:pZX3aJ_4CUxEvu8BLrUFjk_ApsGAZ1jFf5i8tTv8cGd_rXq6d2pkjg>
    <xme:pZX3aASW5Zy2WjW4LYGbOP_I0GwpD5FsextZNd5IN2bjROxlhGFSnxUIADvkXrPgH
    ae-ukRjYJXCVXbFuBlCvC2dsoPRajv_5N0DvIX7JQVDI9MUFlnNYA>
X-ME-Received: <xmr:pZX3aKpMVl20_TDzRl493mkosyR6MCVwmBE04vVrc8SrhDTjM7pRhLuWrQQeT85tBW5XNbZScdiAsosO3lwkQjTXDHWHhEj7OePfRBkhCKTlsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:pZX3aNkV5GzVmZiKKw_iS_QaRR8VsFdB1gh3mJq0NYGHWIbJx1A9eA>
    <xmx:pZX3aDdzShwYipaFAf3onw68wfzJrYCtQogmg-SUw-nBrcHdCNNaKQ>
    <xmx:pZX3aJoujOm0lmlGC5i9q9KZOfv2SlTXEvsLQITpbjZtdGByijZ1wg>
    <xmx:pZX3aNMvja3a16RLnp7mlXfYYY1qW3WEr2n-Y6ofdtDrKim28WuJxw>
    <xmx:pZX3aPUAzv5DvlurzC7IsWvyM_rZQSdoq2TI0jOgqqIu-mI5QRYrNqdr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6556731 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:51 +0200
Subject: [PATCH v5 03/12] replay: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-3-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

In `create_commit()` we're using `the_repository` even though we already
have a repository passed to use as an argument. Fix this.

Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
both of which are stored as global variables that can be modified via
the Git configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay.c b/replay.c
index e22ce399406..13d75d80543 100644
--- a/replay.c
+++ b/replay.c
@@ -62,7 +62,7 @@ static struct commit *create_commit(struct repository *repo,
 	obj = parse_object(repo, &ret);
 
 out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
+	repo_unuse_commit_buffer(repo, based_on, message);
 	free_commit_extra_headers(extra);
 	free_commit_list(parents);
 	strbuf_release(&msg);

-- 
2.51.1.851.g4ebd6896fd.dirty

