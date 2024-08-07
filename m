Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730B6D1B4
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022858; cv=none; b=NpgTSo6DKxOaVnnZSYwchKnWKakWcWB2TYZH2SVA004v5ee/vFFLYy8G4mjNZxzvwfO9+KPUabxmD1XOa2T2j2c0ikopyPNzkoZceQhkoNzaN/q7IbjgqAVaK7q/AzFpoL/zaf89VVLX8Va/z7Bq9faPel/6dI1X/DCxZiMzSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022858; c=relaxed/simple;
	bh=P14yamL8djbKObnBrVQeEdz3aOcS+L44LHnRBBFCjdE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=p+d79iNgRlB4eJsPR2qK5j0Oy1BNnTwk3/Mq8ntSbXvtb98k+EB/2vohYk+h6pCbyz7+0nD6R9PRFRblXLAvOhIBokEUwOqeZ5tImuD2b26fe79TzPVhPqHgBBGINv9d02agp41CJJRnGH2hTIhGkmZJgqzb0ERm8tnu84A1mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=T4X0XFHB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/4JCOdn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="T4X0XFHB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/4JCOdn"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BB78E1151AF1;
	Wed,  7 Aug 2024 05:27:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 05:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723022855;
	 x=1723109255; bh=P14yamL8djbKObnBrVQeEdz3aOcS+L44LHnRBBFCjdE=; b=
	T4X0XFHB3TE5ikhsY4CrHSScojEfCGtJ/msTbOIlmRlm4Lm9YtcCMXb+8cWxo2zN
	9WSMWW4sZ4+ce2/ThfNdr/E1XFjy6YtkDUsbzx/k35BfWQtsw2bYYriSGRcixNmY
	9AzTmIyjkOZpZKH9LbniA6h/0MHAtYnsbEfV4X9LCcl+xerwrfMNto8n4rCg/TN3
	SLEdFzyPl3p9DVGnzimNxvfh/f36gNdzi+mKgxtxp6zGYXQFG08LAq1whcvRCa3Y
	UJarqHNWgxgMaDRrv6be4Cz1uqMimThx2kIhXLG1nByziETv9iAqhxPCOcXmA4kN
	Al+umK/13Aaa7d2mS9Yz9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723022855; x=
	1723109255; bh=P14yamL8djbKObnBrVQeEdz3aOcS+L44LHnRBBFCjdE=; b=a
	/4JCOdnPiGgqw9T8cD2zkIOoiBIwG70/x3mittLFYjSESWOo5lAIMkfklZleFCRe
	B5Axy6h+8myhfKkdQHyy/Jpe9XVDCqHWFE7q5O/ur4hOpGvu8RVAx/gb51r5zWW0
	KiMx6Gd41GYscCoF6CbXOiMjTaly5U0qxCs9D3mkFBwQJ6EccX8CRm6wOax0FvKG
	He45AxVHNPiV20BB/tevGj8vG7d1BoMUu7ySE4jtJjH1zRQwEPprNfpOZ9XNBhgY
	e5vu5OMcNwjSsxGJ35tCGK87lVD2fte2AcA4dc9O+C131rJZEruG3lwLoGJXZk23
	N2veOLVNoJiQE+ZtVipBg==
X-ME-Sender: <xms:Bz6zZtMeRQGOavO3dZtKFBoGGjAXEXpt0hiCogH9Q9Qd3DMSV9MnNw>
    <xme:Bz6zZv_NmVDIevw6gpnFxJG9SGzoq8FvPPtPhD0zmVv7TbuDYPvTbW0lTN1ArZqXq
    CsoHg-fYO8mQ4oiPg>
X-ME-Received: <xmr:Bz6zZsQnBIFGGaFZucK7ZxStWsyaBrYRr4sq22KAVkpqxXVnRiOSrBrvf16t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:Bz6zZptyEpD0brIYvqERPEv1eSe0fqH81_E74df-01pt63EL7QRYmw>
    <xmx:Bz6zZlfS-Te6594LXnjn9fZyxSab3DwDstgAh7FOi3hbWcWMjI6LCQ>
    <xmx:Bz6zZl1VcyNg1Wz8YtLD-1RrETzS-W7Jf8eh1QyTg0DkgaYsYmOlOw>
    <xmx:Bz6zZh94JoEdtxNPwiQHZ1q9tEYx9kFKD3r7vL5nLAqp1XJM6mKI5w>
    <xmx:Bz6zZmozNo3MGfDIjTKQCiwRm_1rQofXBdvFGB_68Nqu6T6Eibm4pr9Y>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 05:27:34 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 19:27:32 +1000
Message-Id: <D39KMJ3FXBZC.7S74VUTPEQHY@jamesliu.io>
Subject: Re: [PATCH 00/22] Memory leak fixes (pt.4)
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
In-Reply-To: <cover.1722933642.git.ps@pks.im>

On Tue Aug 6, 2024 at 6:59 PM AEST, Patrick Steinhardt wrote:
> Hi,
>
> the third set of memory leak fixes was merged to `next`, so this is the
> next part of more or less random memory leak fixes all over the place.
> With this series, we're at ~155 leaking test suites. Naturally, I've
> already got v5 in the pipeline, which brings us down to ~120.
>
> The series is built on top of 406f326d27 (The second batch, 2024-08-01)
> with ps/leakfixes-part-3 at f30bfafcd4 (commit-reach: fix trivial memory
> leak when computing reachability, 2024-08-01) merged into it.
>
> Thanks!
>
> Patrick

Thanks Patrick, most of these fixes make sense to me! I appreciate that
even the minor changes are accompanied by context.

Cheers,
James
