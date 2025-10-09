Received: from relay2-o.mailbaby.net (relay2-o.mailbaby.net [68.168.211.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74824286400
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=68.168.211.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048114; cv=pass; b=g13tY99gbcxt942OPMMYsssuHggjfojWhWO4w9Ighq3QJprxSQhKQvuGUOcULl/cwkQdGRrZ9oQLOTAlWnUxE8lLC+v9d2Z8xCSkGPSCKlA14va06omdiEgrWw7Aqlxwie78aECRKbk0sWXAJZycekkKiJlEz5jgJOUVAo4q7zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048114; c=relaxed/simple;
	bh=EKKclTstahvIlmrxzipharrRpW+1asBXietDT1C+zJM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q6UhPFb0DF1llwsPwpkGqsppHhJDvh/284lNU74We7Zc1hfdSiKe0BxfxmmDK2K2mfORMEVkBRNEyNbumn36WgFW8rlDnQ13hHZdGnwST3Hdlzya3SVpVV1f0ZK2P059PXehO4cmlHBPvpPUJolHu2T/R5mxfOKQ5g5PQuGsnW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=XY7an04C; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=YJV5qoLI; arc=pass smtp.client-ip=68.168.211.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="XY7an04C";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="YJV5qoLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=EKKclTstahvIlmrxzipharrRpW+1asBXietDT1C+zJM=;
 h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:feedback-id;
 b=XY7an04Cx716iGuArrIJhGnuAU167RboLyDuGi8bxmaSnbFpjwdeA2kfPT42P6V8C7KczqgtF
 JYpass8Nya0RJ/Jq/Q9vU5QSYJriUv5lwcVFOkdYwKMXk/o/aHyDEG+9wqUiSh2NN4mUfxSwxbY
 1/YLwz0WeLHOKSG/v8Xjou4=
Received: from mb-nj-kvm1.internal (mb-nj-kvm1.internal [10.10.2.10])
 (Authenticated sender: mb6724)
 by relay2-o.mailbaby.net (MailBabyMTA) with ESMTPSA id 199cb060f55000610d.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 09 Oct 2025 22:09:56 +0000
X-Zone-Loop: 158114afb10eac248cdf6577f94273425980e7fcd951
ARC-Authentication-Results: i=1;	rspamdcluster17.mailbaby.net;	auth=pass
 smtp.auth=mb6724 smtp.mailfrom=code@agatha.dev
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1760047796; a=rsa-sha256;
	cv=none;
	b=xGCwKWvbPIKVwXmNPJsXU38250zX33r2FZRQFJ9XF5hhRA1sG4oeqgJ5amJwGlADNFt9iu
	152Za7htzJBg4MVxfQwkBDBALTOIKhxiwTUQbEy4CRbqG/1vTw/gZHyhal+RaZkDJ6wYmd
	wwJpkQzeYXYEFlVbv2y5vq/XILs58RFqdQedPjg77YYtMsMj2/htwIKX0u3HXbcWpwZ+M3
	DbjXeO/PHouNSPstGavcz2u5TNvPIwzgjJfePC8p29qlaKAp+rzINKeLmkGpawS2qD0bX1
	eiJgzt7F2FC7nywoPzvotQG/SO4eCS4BfjmBM2KniPAupI7rZeU3i9nYhu94oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1760047796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=EKKclTstahvIlmrxzipharrRpW+1asBXietDT1C+zJM=;
	b=k2pr/m4GPNyq8uPEPbxFkd/JrtD+4jpBupjxI/tQvo9lrv3njat22k+NeugWkMZ6a7nwI0
	bjIRJBigVV2CqGHi52r8p2lD+l3bcjPw4QZ54NXSWLYTMfTFzAy6Sm5LTz8/JH4jgGYe7/
	666noHEZLkRRNdNKNiR+xmJbYF26cO/s6fADepgd7M6w+Zcgd7YTFrVm7kTrHK9yQJgqwH
	UuaG5I+Fm/YH4vlAdwdZVt4qWoZ07J9yZjyaaKwPeE+z+fdr+0Q9HBW9p3IjbOFvBpfAYm
	vNN5TtkIQtI/nVp50AqF7Y81YmQkde+FXMQ1bNS7trx561/dNYYJ2FxmOI5z3A==
X-MB-ID: mb6724|me@agatha.dev
X-SPFOrigin: SoftFail
Feedback-ID: mb6724:199cb060f55000610d:96.47.167.18:mbaby
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EKKclTstahvIlmrxzipharrRpW+1asBXietDT1C+zJM=; b=YJV5qoLIpvopTXK+R+EkgHfnxa
	dezh7BpKoQeSh8+1Ko5yshOXYbdO0WBrCk4uOn/1VzS6qoEHCcf2Sb5Xr1S/myIZtloBxGOq2F1xd
	zcv5CYFfae7U8XqEYLVp6gxJ0LsMc8LeM66iZzSI9VhXWxEOn0wVALH2wz4CWp54MX06A5gRubrCE
	IZ/B1VFQpbAq2vzak5jU6RyUXi+Z+kN6CQZ3bE+7sNKPxN3dEXjkx0g0GmVYSHY4EZXYuLvUqFf82
	V8f76kyx3NDNmHgraFZDxfYKofsXXsyjuAw2LVo7PRtp0xRQF0gFu+Rk6W3i1TsUs2hBaLopjBMnb
	BPBirhfg==;
Received: from [23.94.14.143] (port=58062 helo=lavender.agatha.dev)
	by nyc3000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <code@agatha.dev>)
	id 1v6ypi-00000009KO6-27B5;
	Thu, 09 Oct 2025 18:09:55 -0400
Date: Thu, 9 Oct 2025 17:09:54 -0500
From: Agatha <code@agatha.dev>
To: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Subject: [Outreachy] Introduction =?utf-8?B?KMOBZ2F0aGEp?=
Message-ID: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-AuthUser: me@agatha.dev

Hello!

My name is Ágatha Isabelle (pronouns she/her) and I'm (yet another)
outreachy applicant for this cohort. I have some experience with C,
developing mostly device drivers, a couple of patches in the mainline
linux kernel, etc. I also do some assembly (x86/x64 & riscv a little)
and C++. My goal at outreachy is to regain experience to work in
software development again after some personal setbacks took me out for
some years, while also contributing to an interesting open source
software project like git.

I'm looking forward to interacting with the git community once again
within the next few weeks during the application period.

Currently I'm looking through the documentation to get a better grasp of
what is expected of us during this period. The doc says I'm supposed to
send an introduction e-mail, so here I am. But I don't want to just do
that, I would like to let you know I'm also working on choosing a
microproject -- right now I am exploring some intersections between
git's object model where objects are immutable and tightly linked to
author metadata, and possible privacy concerns. Especially for people
who would like to exercise their right to be forgotten and transgender
individuals who might fear former name exposure in places where this
information is protected by laws, tackling cases where a simple mailmap
entry won't be enough and rewriting history would be way too disruptive.

I want to see if I can work on a microproject that helps to tackle those
privacy concerns while keeping objects immutable and preserving git's
design principles. As it's supposed to be a "micro" project, I plan to
explore a small, concrete first step rather than attempting a full
solution. Yet I would appreciate any input on that. I have a couple of
ideas in mind to check if they are applicable too.

I think this would be of actual significance for several groups of
individuals, especially for transgender software developers who face a
lot of challenges to get in the tech industry, even when they have years
of experience. While in some places linking their current names to their
former names might even be dangerous, or at least lead to embarrassment,
losing credit for their contributions to avoid exposing deadnames could
also be a limiting factor towards obtaining employment in tech.

I’d be happy to discuss whether similar ideas have been explored before,
or hear pointers to related prior discussions.

Best,
Ágatha Isabelle
