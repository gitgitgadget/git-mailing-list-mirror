Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE96198E78
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239812; cv=none; b=O0TJxDoW42IjWjlycNOdf+R6z1R+8P6+5nPQTA+v1tPZ9e+q+DUCllsYZ7RIxSN51j8wYvyc7J8O8BfWRoJi0y7k6raOq1T+D3da7t9Kb+GVMz/6CqNle/XotMWwzB1wlGBi+/fIVBUPJKobtDkg3tpFBMNdM588o8a/ClWrJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239812; c=relaxed/simple;
	bh=w41f8mllud45LIBkxS+pBuCumqCpUnlMme/3Y2vETLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap/K91YUvr14ZZHjmBe/a/5D4xEGw6X/cBGkTgjsQyqO5hR7ItjikQ+htk3mkC/M1PSKlCLoyVQaMz1DVmMpr70GllI5d2VzdO51jtquqCiCli6xRUpA9VrzbeBiKOodljtWrd/dvxOsNPKygrc7GYVAChgUrwTHEYqxIMdUXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CBz1A/em; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vU/F4KhW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CBz1A/em";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vU/F4KhW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B48B413801AD;
	Tue,  7 Jan 2025 03:50:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jan 2025 03:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736239809; x=1736326209; bh=J3FdTjmyzm
	3c68t3ZEpY2xyvZolqJP3JShmUd8bJg6c=; b=CBz1A/emAxZoG5WimOzPpaL0VG
	jtB4rx02uZsk6QMACItX/lzgvCvcLTSlkYlg6qMt0fkTApVH1QAR0ow9bl+RHHkA
	njPMPwFVGn54C2kSeSUjsNjzSLsyoGBRLFsXoXrcaamR2z5KYdmHq5wLgSWuPscj
	lvDDlhAHYbDfAW2lYLkK9fkx8d22expxxGK2vPMcL6WNi3sHpsc8J30iN3kqJoGU
	erdXunyYkQeHkgHmXZhc3dsvgMa9qHrugKtiGfF8LNqPDPwlu2g2dxdrIjr9XO5b
	TymknuMGcCDgcjof8GVo+/Mzu2JbHU5OFKGQ3N9FcyyVF56/jogoa48JnOiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736239809; x=1736326209; bh=J3FdTjmyzm3c68t3ZEpY2xyvZolqJP3JShm
	Ud8bJg6c=; b=vU/F4KhWpFR5xeXUqVx8kH2/Bv+cSGJAkOHbELxvcOa7T7O55vt
	Sb4fLd7gvHJIv32Qv6R+VZWoKTqTEblSLXfcnMBvLBZZ2vLzlz/0ebwLgTUhao+S
	GA4Ja3q/vAU8stKDryJgk4RTE1DVEiiMyT+OHSgTTPBnccNHvMVLlOY9tPIjE1VA
	AKQYdwm2HrbVSd6FnTr8y+lvbLcwgc+Lpqf9awCeFI4Z1ugeBS02lxQ7zl+J4a95
	CajGplE+4J4bbHIM/VKtlNq/cSWpcD4EcK4a7UMs0t8cSK0NU0JOc9aVTDiNVMhl
	1+bWi0AGtzt2hFevF9BxamLbEF0Aks6b19A==
X-ME-Sender: <xms:wep8Z7pgsuvszB0RlPCMvjSkIThpRx3msheTI2wmJ0kaVq7Mg8zncQ>
    <xme:wep8Z1pnSF2bNEWyU6myxURF0bNKEQXkJGFdJ47Q2n1bbufErRhEArNxGcM-h1ylo
    WI2hwH5miwumUulRw>
X-ME-Received: <xmr:wep8Z4M1Bw-5Wina-MEklb03blBRMzXIN3tzFhZgJDyx1mt40Ue5di0zRaGuyiqf8tk13VMyh-a840wa5wgy5mefqsJJxf_xRwGZFNu45mzEpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:wep8Z-7mzBPS5ULfMBR_vmc2RQEJoSXvzAEUXBfUl28bQMyN2FgkRQ>
    <xmx:wep8Z67rYwmIW9ERt-fI10SmdKMPIidOUjfFta1u4gzLHr9YV66Uig>
    <xmx:wep8Z2hJmG7Lo_Hd685mzNTcOJMwDafaiNQjVhQpLIs_iQ1X6aYV1Q>
    <xmx:wep8Z85CSDeDZWMFvyw6rjuVGdVHlEd4MKJDQ7qjwkG3IVX1c8eM8w>
    <xmx:wep8Zwl06fCV0qJiAdidEUS4D2TUzG_05w3upcNv3Y5bz2nJTjy5QUmF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 03:50:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f0e11ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 08:50:07 +0000 (UTC)
Date: Tue, 7 Jan 2025 09:50:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <Z3zqvn82UJIxA9yW@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
 <20250103181739.GA2527684@coredump.intra.peff.net>
 <Z3u6lj_bpM7N93Fd@pks.im>
 <20250107023904.GB2363@coredump.intra.peff.net>
 <Z3zqKSx8NVK-QQNL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3zqKSx8NVK-QQNL@pks.im>

On Tue, Jan 07, 2025 at 09:47:44AM +0100, Patrick Steinhardt wrote:
> On Mon, Jan 06, 2025 at 09:39:04PM -0500, Jeff King wrote:
> > So I don't really see a way to do this robustly.
> 
> I think I found a way, which goes back to the inital idea of just
> generating heaps of submodules. My current version generates a submodule
> "A" with a couple of recursive submodules followed by 2.5k additional
> submodules, which overall generates ~150kB of data. This can be done
> somewhat efficiently via git-hash-object-object(1) and git-mktree(1),
> and things work with a sleep before and after the call to grep(1).
> 
> I'm a bit torn though. The required setup is quite complex, and I wonder
> whether it is really worth it just to test this edge case. On the other
> hand it is there to cover a recent fix in 082caf527e (submodule status:
> propagate SIGPIPE, 2024-09-20), so losing the test coverage isn't all
> that great, either. And keeping the race is not an option to me, either.
> 
> So I'm inclined to go with the below version. WDYT?

Gah, this of course needs to be adapted so that it is the submodule that
contains 2.5k recursive submodules. But the idea would still work.

Patrick
