Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879E23A9A5
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959290; cv=none; b=mWznLTBXeA3DV8FfGY/I3EKVv9mWeAGgF10YEz7HdOiRa0zDI0arq4OYEZfnsHy4hNaa2U9UxmRahWU6MCp4OQHkH5ZlPKu23GCVzv+hbd+L3LMY+VEQ4wddYu1pj1ElVGJ9PVx3Q359MQBMsB0j3kWGQOoYkHOBvqONx8gRIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959290; c=relaxed/simple;
	bh=ckS3jc8Zw2QUHN+GWoj5OE7k5SnjdtCN5Smfya6zwpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYp8AxbFqUi40pgcBr0egvy9I2i7SN/K5Cr9G+Gv0Hs9zgQ0mYbH/2iaiW/uhkFQFlJtZyw87OLSXn0XSH4erIJNUJ/CCgikQYw1SPBtFFcrPEz97Nq9mvNdPDg/R8rRcUnIe8u2cTb1cJbq4qG+oggSTT1WJcPeIlBc70j+/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EM3Lwp7p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xnk+hB+5; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EM3Lwp7p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xnk+hB+5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 129D71140104;
	Tue,  3 Jun 2025 10:01:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 10:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959287;
	 x=1749045687; bh=Vs+EpWnTasoE4JYc5l3dNBJQR9/751namLRtun7rnAw=; b=
	EM3Lwp7pNHTmfZ+EsWHjI6/3bA8P9u3WJguVUooyUdBUmcb8u8Tdu/1PPjIwldCo
	4i8IBLj+/oWvYm/ODUsh8WB0zbUT3tnu5snmcwY6cWnB6pnbFORQoRR9FHeCL0vH
	i2YxTj1axZ7SrJmkqFiZ6gOynadkSs1/Pm913Q8CYQKDFStAwHvo1ROK69/JMNII
	U5LgBdHLlaadcg65DLQc0cu/RriN7aMDPys44C0zyHS2749K6cwwM5b7ehYGYKnS
	1QsbXpOYg88otsOdYT8csf9Re6SnVjQW65pjrJG6MKRUUC30u1aYE5xPzgj9HnTb
	OCbxruCca0mMiV5yQwpR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959287; x=
	1749045687; bh=Vs+EpWnTasoE4JYc5l3dNBJQR9/751namLRtun7rnAw=; b=X
	nk+hB+5ZiesgJL+y7acG7EOJ/m57pYUnK7EmAIPOC9/TSLjwwYdXJv7YkhQCWD4R
	66bpRVjUJbUBM6SfkKDs0x24Fj4Vx15/9vGCCs/Of2CjWz72voqBDIibSU8Uv1FZ
	hq6A3oWx7BvihueLQdzSnpUV7DyIUOJjSr+X8mvuNwQQC0MBawY7M2Ldl4PNanae
	tsaLhUp+pNeJfQwYrzp0O9mEFdiFGOIdFNQYrLhmEK7sVQx9zX8If1m2Hq6hDQLO
	dpYVd8jX/Av69TuaVOtkG+lpILlmp4gmBOiKNl/bqCZ97Na52fD5haG5vNQf/BoC
	1StbvOP8GzWoogxWge+AA==
X-ME-Sender: <xms:NwA_aJLjOUsC5qepcngST7WszDdNzD3c_9zUSNWkdSvN6LNG_00sEQ>
    <xme:NwA_aFItqbiGcyJSX8w7bBESCWC2PkK_BHlq9i2M_jJ-JbFfh4_Fvhc9pG4rOlt4E
    6aWQxXKWes6ZUCdkw>
X-ME-Received: <xmr:NwA_aBtQuHn4xo7BDY31XKy9vy-C4SJ1YWBfLh649u3Mv_toHG-Y1LOMw__bq4iQLdrOVkOMFeALZNJT9HNwL24I0EU8aGgkWdZK7Uc_zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgrshgrmh
    hufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomh
X-ME-Proxy: <xmx:NwA_aKbJOfN2m42_7AgdcDF2uXcxGlDIrjuMhCQL7yQoFKyRlH2h9w>
    <xmx:NwA_aAbEEZCBEaRNEdHmNn6NcINHcNHTdtEyn3WABtd2xt6rexSRmA>
    <xmx:NwA_aOB2HLjHaJFi1nfpFkjn3-cuqV_k3tzZRYXTlQRdhNM0tMMmvw>
    <xmx:NwA_aOZuCUBPgxdchfluiK-WqXdTAWjDDCcoybSLKLz7byATfsk2dg>
    <xmx:NwA_aD4wpLgS_dD_X0lA3-kTSAgYzaHNkBSU9MugOxz-sVbL7gc4Xxsf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44a610a1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:17 +0200
Subject: [PATCH v4 09/12] builtin/maintenance: fix locking race with refs
 and reflogs tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-9-52f5cf7b7e99@pks.im>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

As explained in the preceding commit, git-gc(1) knows to detach only
after it has already packed references and expired reflogs. This is done
to avoid racing around their respective lockfiles.

Adapt git-maintenance(1) accordingly and run the "pack-refs" and
"reflog-expire" tasks in the foreground. Note that the "gc" task has the
same issue, but the fix is a bit more involved there and will thus be
done in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 72a695853e5..fdd0dd09be7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1587,12 +1587,12 @@ static const struct maintenance_task tasks[] = {
 	},
 	[TASK_PACK_REFS] = {
 		.name = "pack-refs",
-		.background = maintenance_task_pack_refs,
+		.foreground = maintenance_task_pack_refs,
 		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
 		.name = "reflog-expire",
-		.background = maintenance_task_reflog_expire,
+		.foreground = maintenance_task_reflog_expire,
 		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

