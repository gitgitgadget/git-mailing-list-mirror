Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD886353
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504935; cv=none; b=lag2aHCzhOX7d4Y5WCEZ5/3P6IxaqnFE87Wf6wF7TkZgPsCCbd81lHvMU+V3ECiDzsHYm4YSa3HeGMOPWM5xj7tTxwocAoATsRme31sOVqCN2P+RIzEMVt6tlYiA6pPGonIA3zv1tTm5d+uAsLm5atdIaC/a06bzWkeridF1Gg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504935; c=relaxed/simple;
	bh=Etdgp9v+KM+6OJncbmklPC+jDfwLuNORTI2rHqCBQFA=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=aag50MgAYHnYlT7rekvkiEV0KpRRkPUbIO+G6ZZjBth7PrFFBGaCDXWD94Aa3M5p1LQ8N8ZSd4Sr3lvaA5ClOI3CL28eWnRPrECX6RKMGFUXJ/KDG25Gqm4gXAWEs3SDWzAbC7OeJgEks4WuK0J5YDu2BKfLbzvl6wiIin1AYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com; spf=pass smtp.mailfrom=artagnon.com; dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b=ntCztey9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fd6gXySa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artagnon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b="ntCztey9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fd6gXySa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AE7FC13844C8
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 06:55:31 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-05.internal (MEProxy); Tue, 01 Apr 2025 06:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1743504931; x=1743591331; bh=Etdgp9v+KM
	+6OJncbmklPC+jDfwLuNORTI2rHqCBQFA=; b=ntCztey9Q+WfKTCFcUGcRrwjPM
	w7GfIjFHxOOK+tUG3OsPM9wKlQipuP0mxon8LYNgOV4zFfOXTu69OBRc+U/JJ4Ez
	P2iZISfWCS0ZxUC5ubj+afEAKWu8nUAradFIg+htWhrqgsNKXkiOwmIpsfItpGp3
	Xkb0ODNtNJVWgA4avKsGSLR8fR6Cjp0bh3IdDVZlRB5g9lYIFNobjtWbwhwlp3k2
	ApuJoyB/H+8juvT1BWWockHMrUztr+ea+DyjCD4jhShwZCeDGacGsmGWuBhG7y6N
	9sNA8tHuMwU+thQGsbFEPygX/hKdNP0hCcEU+dCMT+TwUmH3dw15605Xdqhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743504931; x=1743591331; bh=Etdgp9v+KM+6OJncbmklPC+jDfwLuNORTI2
	rHqCBQFA=; b=fd6gXySaHy9mIJn33bg/5WavZX6+oJ+NUI9/RV0mOn9B5jaX43S
	Re3LePSr0+6qCc/371kpZd3nvWqlfa2rGLQD/F/77bwi1bljEMjmCve386GsECae
	4K1pW+0xBW0izuZkA3CMnhxPu+mJcD7S0kPSO2yV0fsDqTuJwahqtWhoj34sqtyA
	GyrPsTeWAdeF8xHTFsGWDB1Jx5qvf9v/g69AtBhYr5P+DQf4HRN19wylKlcUZ1BD
	oOrCcDzGpyLrtvVIuDLA8/sxnZlSeaj+BGovz23ETTQloT2QovEkQ0R058e4qbgr
	urPxgwPexO+ZnxxUMCBuBznE+WI8MqWTVRg==
X-ME-Sender: <xms:I8brZxy7nW0-Op5gUVThpKMA70Qc1yp0AYl3pWZs357YLbOIW_-ShQ>
    <xme:I8brZxTvCXC-NZjGzFu6SC6wbvgLolvSaSrGdCeV3vJwRq3hi1xdDxgz-ZTDtcx3W
    yHgaCDzBnDppRMBKyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpedftfgrmhhkuhhmrghrucftrghm
    rggthhgrnhgurhgrfdcuoehrsegrrhhtrghgnhhonhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeejleelveeftddvfeeuhfeghfdujeelfeeuudeujeeuieeiveeggeehgfdtvdek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhesrg
    hrthgrghhnohhnrdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:I8brZ7Ub11ZCeDfkiPGTY_3TMglcBcSZ-SKkN92pQXXoP0Pwk3UnLA>
    <xmx:I8brZzjWOgIAHqMiICsXt9q2EfF_sMx2byQwXNWd_ktoUWfkAlFjWA>
    <xmx:I8brZzBKZxfUElpkkx0pr5ap5SY0BpI5XhBiZcWm9GZBVPhyXQfCZw>
    <xmx:I8brZ8JSyEiMMmkIpEUDwkkt_bC6fEka2-oqVv76NHIDS5S1lUBogg>
    <xmx:I8brZ2oaZmA_p_wW2tFUQWJ0ok7c7xdXwCkokQJ30zUtEVnUr8Ci-eE7>
Feedback-ID: ifc014702:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 658E21F00073; Tue,  1 Apr 2025 06:55:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Apr 2025 11:54:15 +0100
From: "Ramkumar Ramachandra" <r@artagnon.com>
To: "Git List" <git@vger.kernel.org>
Message-Id: <4f142817-49a7-4079-b7b1-e54de36a6242@app.fastmail.com>
Subject: [ITCH] Redundant rebuilds when rebasing outdated branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've noticed a common pattern in my everyday work, and thought I should ask if I'm doing something stupid. I work on upstream LLVM, and develop patches on different branches based off 'main'. Due to the nature of our collaboration, I often need to update 'main' and rebase patches, when some patches land. As a consequence, different patches are based on different points of 'main', and I find myself checking out an outdated branch, rebasing it on top of 'main' (which often doesn't result in conflicts), and this triggers a rebuild because the timestamps changed. Since LLVM is a huge project, I use ccache to speed up my builds, but this doesn't solve the problem of redundant rebuilds, since CMake often needs to be reconfigured, and several built artifacts are generated using home-grown tools.

I think it would be preferable to have something like 'git rebase-checkout', which in principle, creates a new branch based off 'main', cherry-picks commits off the outdated branch, and renames the fresh branch into the outdated branch's name. It should be possible to script this using the existing plumbing, but I was wondering if something like this would be useful to have in core git?

Thanks.

Ram
