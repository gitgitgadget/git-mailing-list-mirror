Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139520127D
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284916; cv=none; b=UQmqfWjjogTjfhzfDqPvXfXjwcvFOv0ztTaxjV/Z3c03J1kJwkdsarqZFEUsbdYPjtQVGXgiDsnIBACQvdsmYAYjZr8hbmMsycMgnTqpsMa8GRh7pVaw4l1kbDlkXeV/b7LaH3xrjnMjyevPK2Y8UQjV8/1uXx0/Ly2+QHE8gjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284916; c=relaxed/simple;
	bh=RFHg+UbQM4zlxtvgmd0/4Ybv71FlnShukh/1vZDx1Js=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lQXZrBd2MSO43gDG548788dwAVNJoZheGh9b411utv53rcuIpmUI7UO3qhsCK9WXEYSTRc8M/BA9FJFJrak4Yve3C7pHEm495a8tZjDb2cDEN8ALdx0DBXnKYdXf0cVoYb2uzufYoBnCq+bsI9rPcqfoP0w3+TS0AMDyTwNXt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fSHBJSHC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmSSi7/k; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fSHBJSHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmSSi7/k"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0F33C13802F2
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 09:48:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Sep 2024 09:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1725284914; x=1725371314; bh=akM7YKPC9QZiSbOHlo+V/gD1F5LAwRee
	poEhuGlDrE8=; b=fSHBJSHCl7LtNSvVZ9cQ0QyUjEN74qwXpoqrZkN294SNrORB
	YQfG/dxH5zg35cJ476lKBikWtPX9o6XMyunc3CKK6pqlBGPzthyjpgCxATuXA7Lj
	lqgyttYEbWY5bf1cMXpRPDJij4xse0bjDqtHLnOh9s9TmcB674W4osRenZg87oY6
	RtriCt2KfAlh+Xq0meSf3j35SdldZeM69UuvVADVR1z0QTvLSkaUagDXZdXE6R14
	zhylexvYdUibqpRU/KjohYzKnVTZslbf00oh38C3uexRiRHVtZcZhWtPfavRFPUO
	QyGjwO+ZC5BM+pGZmKItHeh7JYgXXXUAZwEfhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1725284914; x=1725371314; bh=akM7YKPC9QZiSbOHlo+V/gD1F5LAwReepoE
	huGlDrE8=; b=nmSSi7/k3UhoRbmZvFQLPCgW+rNmIl9IHv4wssvG5wabWvQwxqP
	4ad05O5GJhBCLV6DuYaRDrN2m4OL4oummvmU9yXq9TF4LmmSFsCSHb9fk82+YSGX
	DXPO/WCBKo2Qxqg0H3QitEoROBE5DwwNti/Akd/P5t/rAOyeuiWj1FiloH2eSueo
	+E3jOgParolk9iYSVhyvHrgGR34PruJWngkGvvjELNt9HEcfwF/84XJb/PTk++/n
	mvbBzF4AwhpCBat91tBFUKV+siAvzd5BWlhAsISfhHSba25yNXzYnpcofvP3C7aw
	CE7jsKJ2NPCtysc4zxlSRmogDbhSdJ1YFjA==
X-ME-Sender: <xms:McLVZm-CaJbhZKXJsXwEUl9WQxJmTbCbXUl9QTwY6YXD0mltvVviyQ>
    <xme:McLVZmtf-bc9-0NJbmgRClYVt4_Y7slJ1pvJIz6bdornruBbVWj-Z6fF72S62A9O4
    T9Fw2HhitHxiZh22A>
X-ME-Received: <xmr:McLVZsAa7BhzjTSLViM0Pmp-VL-ixsd6AD9S1RJJX4wkd5ox6Djxve4Z0bs_0p3fX2TJIxTf8B3fGJADupPrj4UT3nwIwzMot7RqfvFQqDKck4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleejgeevgeffudejhf
    evhefhjeegkedvvdelteektdduffeijeduieduffevleefnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:McLVZudPcyrB47E71J37qrMwAG1_4x-UdycFN_EEH308GkiiS10qdA>
    <xmx:McLVZrNTGuRKgLV9l-6fqf9FUzpPVKY7Oy8bhI44nMeX6ulPFQ37ow>
    <xmx:McLVZokRU6rE-z_iARKdcBvy6E3oNy1vCBigB_f5ycZyAOvlOgn4rA>
    <xmx:McLVZtseCZJHQue725P2cfgdXTcgLFNYeODVwtDvzs05P5-0RFBy8g>
    <xmx:MsLVZh3RNzhmv2VkIlMnxJh_8YhidrjPDvtXxUhXE3vUNYkaVidFg2RO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Sep 2024 09:48:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a24a0571 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Sep 2024 13:48:27 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:48:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/2] refs/files: use heuristic to decide whether to repack
 with `--auto`
Message-ID: <cover.1725280479.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I recently noticed that `git maintenance run --auto` always ends up
repacking loose references. This is because the "files" backend does not
yet have any heuristics wired up to decide whether or not packing refs
is in order. The consequence is that we always decided to pack them,
which is of course quite a waste of time.

This small patch series fixes this by introducing a new heuristic for
the "files" backend. The heuristic is rather simple: the bigger the
"packed-refs" file, the more loose refs we require before we decide to
repack. We have been using this heurisitc successfully for a long time
in Gitaly by now.

Thanks!

Patrick

Patrick Steinhardt (2):
  t0601: merge tests for auto-packing of refs
  refs/files: use heuristic to decide whether to repack with `--auto`

 refs/files-backend.c          |  75 +++++++++++++++++++++++++
 refs/packed-backend.c         |  18 ++++++
 refs/packed-backend.h         |   7 +++
 t/t0601-reffiles-pack-refs.sh | 101 ++++++++++++++++++++++++++++------
 4 files changed, 185 insertions(+), 16 deletions(-)

-- 
2.46.0.421.g159f2d50e7.dirty

