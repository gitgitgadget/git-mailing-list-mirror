Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4427C84B
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622734; cv=none; b=CD1W2RnwR/UEdvqFQBAXIVt4OzPlN4BCtxoYJHRD7OAIdE8hYzMAe4d2PB/nPBGPJpf6q3iCUhpvH2Z5+CDuYbrimnkKuqP8ScTl/RNp6YjnvNCnQRNd+IJtWxD7XeMVZX2Z8Su7h4wGH3IXXebQ/0wCJFjOoDVDaV4Swnr6w0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622734; c=relaxed/simple;
	bh=nSAVTg9aSnwr/rHUwvjmwv11vWDIKedoiAdOeEeYNKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbgZLF35666+Lm7GOCixFpOuaFH/11eubahYIyQRzG/9MBXT+6ATkEmFEiwDrG+Rn7kUnz0J3Ur6reW2fpVcaVaXJoFm+FrvuUMy73jOBtkV3gPxDvAZgd+beCULc9dxHft2wfFs64/X6e/bMFsc0sLaDKSxBKUzoNsOZ4+ciOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PZzZhtJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHR0uYRH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PZzZhtJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHR0uYRH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 695AF1D0011E;
	Mon,  5 Jan 2026 09:18:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 09:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767622726; x=1767709126; bh=nSAVTg9aSn
	wr/rHUwvjmwv11vWDIKedoiAdOeEeYNKs=; b=PZzZhtJkUuPRs9jkQB/fahQ7Hs
	7dEMrOjLQ70ZgO3CwlUmvZI/0tdUC34GHA7kxAwUnHy8Omx2EQJRWMlDeUefeiT5
	F2cxh+DkmzUBCqtXXPy1vVd2q2Jl9RGwqhx8OAW70FYyBFIwyuzUkvJ4RJEQV5V9
	LRICGO37rsjCOKKhNHmwhRLzUrE/fr3Vvezz128g+JgjQ8CgGhmkQJmntT4JkxXO
	ckROqcx8P2D3Qx0Vj9qIDTSOAp2M5+cXgIGU+7UaJnemPZMISE3Ca+IQWkEWtdyU
	XdYgE7m54sRDNchNYQUsz4tfVpWNmt6/6FvnRvQ3fz3RG39DKH61P23Wkqug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767622726; x=1767709126; bh=nSAVTg9aSnwr/rHUwvjmwv11vWDIKedoiAd
	OeEeYNKs=; b=FHR0uYRH1IuVuOQn42/Mle8ks8f8OeP1m5JCrXNEdtBsc3C+tBj
	URM8hhy6Kx7DMPB2nLCDcnPFeScMlHKRBpHHlxcTitygvm4nMLwZZ86jlJFKj94X
	i7bnwMiqz+dPpt8pI8hXZF2jD16SICasWQMiKLgy34XLba0MsIhsV2Ylu4dqOKId
	bkgwSvVoSLlQpnwfiewm88yJwjj80D1gd2Mb4dEd5Ca3cNZA+bKpIU8JVmUOXK6t
	UJomuHOIPK4pKSIyabImvz690jUpmwrK3M3reL/2YLu2Jywsv5T+5zi8HRjzJ1r/
	fJDlii+CtthGjQLs9KC9hW0/7Wt2wdOp//g==
X-ME-Sender: <xms:Rshbaa2GcGXPRuQgOFh3b4upHrzar3liR8ZiXp2dnM2LE8YWhlY63g>
    <xme:RshbaTFl-E_jbw--vc7fjC-gMNxGgc-FG7UbWXgOMjUdoWQaVsFjmfmMOdA4PaGcA
    3gsxBXC8l_pGhn6qk7WQKgSrv6rEsajgIKoQBsd-qJ1ES0ehyOj-A>
X-ME-Received: <xmr:RshbaQgSIjN_0_UIGf1uSNLMJEJtpewmFXgtD1SZURSx9Wor2g0p6pzW7gagKS2tOfR8aC6S7XKJCHaChCZV76IMppyYWyxFiuTIO0qX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RshbaW8m7xjeMRbi6_bVi7441Z0sTMJr_hgHyRN35sPQSYpLu3U_0A>
    <xmx:RshbafqUdRR0w5kO-6V9HTr9T10r0KU44Mb-IquKXXZ8V3dmp5itwQ>
    <xmx:Rshbad_1-BnE55PY_97w2hPozpCJF0xA-iV_jSTHTwJCGd-S54HelQ>
    <xmx:RshbabW8D6Np5MRuMWpqBe6GIWWE70KUdaL8E61dwA_16VVgtNd95A>
    <xmx:RshbaRUdcP-0G4xTABy5H3-xrZQb7-LL45npMEm_kAAgMsl1bATR-WcT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 09:18:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eed2dcf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 14:18:44 +0000 (UTC)
Date: Mon, 5 Jan 2026 15:18:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] repo: add a default output format to enum
 output_format
Message-ID: <aVvIQYdsrB8vAJ_R@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209194616.61620-2-lucasseikioshiro@gmail.com>

On Tue, Dec 09, 2025 at 04:36:02PM -0300, Lucas Seiki Oshiro wrote:
> Add a `FORMAT_DEFAULT` value to `enum output_format`. Change the initial
> value of `format` to `FORMAT_DEFAULT` in cmd_repo_info, indicating that
> the initial value hasn't been changed. Also map the string "default" to
> this new value in `parse_format_cb`, allowing future patches to add
> support to --format=default.

This is missing a test. It would for example be nice to verify that
"--format=nul --format=default" does the expected thing.

Also, I didn't see `git repo structure` being updated. Should we do that
so that both subcommands know to handle the "default" format?

Patrick
