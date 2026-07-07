Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024B382388
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434413; cv=none; b=bvyD7i3ieJ8FahZ63TKW0OBFJxqN3D8x1/EjSdPvSRFVdMG5xTRhMG2I7SHIKgEZdIXttU6wj4MMNCpVXUX7Es3ESSJjRFgpzw3/7lXEZ2nRaJJxU04oHbwu32Pmy2F2G2GXOf+3xhZk9bueDPM5aR7KoF+ERDYRWtYTphR/cAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434413; c=relaxed/simple;
	bh=xFCUDAvo3XoS8R/eukACOabMfSRdt9IZO8WXeVvfQ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiRJp+GyoFVvETDZHAPF9ZOILWlfAyYXImzEPgNaMGktBRwLpSF4csHa2Adulw+FKhFgJvoiOeTGcKjq4K6DbPxmkZDh2fHh1gbuoWcMoRK1Jlq+7y1ivDL1LqiwwUuSOOHsGNHPZsUeScxadB8Zw7kw+jvDGzvIW/c5cyp2z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h9qZMFQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnOJhirl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h9qZMFQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnOJhirl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 19F95EC0214;
	Tue,  7 Jul 2026 10:26:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 10:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783434410; x=1783520810; bh=cWRFwmKt7r
	EqLQNMtsBdl0MApPXk6V7IXCv+bO496wY=; b=h9qZMFQpnu/jmVLxs5EPfKsb0d
	cQckvwL0uLoxISwOS8zl3AnHM00F1G5JWotLL7AC43pH9fMwBkOGYqzXcY4CsnZ0
	rIwRe6L3Ojnxn56xXeTl+7jpnC1Cy83xFF6jv+6XUM1l86MxWmhyXct4Eotjje+i
	2I5KlOSZwFvdyeDh/ol0TH2snjqS04g/sjX8hBEmAIQBJyfWzxt1XEJJlGnLh4Iv
	GP3CIdhvi37SSnfYSfWq0WdGj2YVZWC3f6uQoWS4CGLsRyzhbTvtQnyHurcTA6/4
	H5nljnz4w5/5byRkjQzrkVq1d+SHURpMykIixaHc+jYtfPG/s2yzOpX0ulUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783434410; x=1783520810; bh=cWRFwmKt7rEqLQNMtsBdl0MApPXk6V7IXCv
	+bO496wY=; b=fnOJhirlwT1uHxepe+twobXnPgQH3qG5UfR9i+hw75cybngE/BS
	5vmGCf6RlDQFNTYMdacfzjCziLd+ZmDXKLroFO9D204jKCTWkUf+3MmnOBY8nq/r
	9QuITSmxzkdEw36unoFon7mESevQEJqXYe5lI+Fdgyy5d3Z+JnRwX6K1stqjGKWQ
	TUoNszQB9AlNCUcdVuMn3JH24cRKBsDS9aDcT3vJz1yPzp0umDpHKah++IsF0lSg
	+k1JBv4ov+/0/4F42W5RPNgNEE01cNWChQIkdPUNZT1sNL8oLaeBaSuNVITvqtpv
	ixTI36r1YoBTl1igFOHgycAtIzRIYSa0MwA==
X-ME-Sender: <xms:qQxNapByP01FkZrTtGPgo4YuyK06bxFoYcLgGlxgsXBCaaUljfsrCA>
    <xme:qQxNau8egxOl8GPxwFOmzdAZoYEd0NPR2CFTYdyttZbDwBDjWWbcjfn_HcN3YJkNa
    BFSvWsfYcQEHUek1_P_PRq3gboDlqXjgHCp6PpsMCxCWFIHjyzQXw>
X-ME-Received: <xmr:qQxNah_ucBdqFF9YVRP6m7rmSACND-7_vmp_NEPIrCQuSO6_M0yvKEAC4uaixtzgmVbOqYaHBjjKeEJ9x9udKZr-M8kmC9mwafrdoXMI9w>
X-ME-Proxy-Cause: dmFkZTG1xmVos7mEtgAkR+D0FEQjUI+9RENNbcXXECxmyTdaBBSDeydxGZQ4Ki4DSGuhLC
    tC5Mw3hKyQeUKbNImBb6PyHar6tNHNcfsIF6n833BdWP44Bw8Fzj7DJbXd7brtltrnKsuB
    +I3+kvTdVJsNgzzJ4mQFOj702KHpc2pLRzTKQN66TCII2N8iBrgdyWMV50b4iDi0749O6k
    IuWfc8Pzk/F/n4cWKvZ7G1/dJfsM4UiBe9tNFxKuDAhevvBKWhnL9ba/uKKF9yYRy4j9lr
    ZoMGcl/YiS3LDnvYwHhohCLSM4f/ajQM5Bx4UmQoNQdAytGJveKZJg+WTVi9WnWJJxqSYU
    F7DTs6jRRaOuGeIwUOnBEcUp7pNLhpwneAj0WSAd8H6TFS8lEkFCdbfsnDXEg3x3jfEhG0
    roeE+np+H76SYnHL8o2hOaGkObcENfk3GyQskbK39JiwwIpGvHaoL5CfTC2SMHCmh8cHf2
    IghFZb5Q1DxGoZs/h5SgXG/PkfVM+WnBJBzRiBBOUkDsGJStMDgmQzbuKf4idvx299gJGQ
    /6RypGG6NfcJrcyGYUoqpmunO9uGQ89WijYeDvsFbTy4xWr4qUfWJPa343326iWkJyKbKi
    i0NWyPz3JwmQAg8CdNcN0L7X7Af5uyRANpylqkEZjqU0p71qk5uWM3hOPqCA
X-ME-Proxy: <xmx:qQxNatfAY8CAGRDFlSpzwp2tVm30GXo5ATCLstpG_qeQGtdKMoKnJA>
    <xmx:qQxNaiHBTyzlRFuPJh7k-qAdL1jKS-m_0uvlPpbrfL5pur25aVb6iA>
    <xmx:qQxNajdidjhjRYaFtp5gNxvGWdHltJx3PfTgAoa-lDcibECAaePIYQ>
    <xmx:qQxNakFFLBG9Wxh52CpnZThF9QEwuX0gBKLf8SK76LnaVhmwcOM_Lw>
    <xmx:qgxNaqDyQIVy8g6_D3a09fY3SRaX8zBYWwfEpgRyUpfKfkaE_edKLWXS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 10:26:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f72d2f8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 14:26:48 +0000 (UTC)
Date: Tue, 7 Jul 2026 16:26:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/7] git_hash_*() quality-of-life improvements
Message-ID: <ak0MphY52YkJqs9c@pks.im>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707045556.GA1288172@coredump.intra.peff.net>

On Tue, Jul 07, 2026 at 12:55:56AM -0400, Jeff King wrote:
> This implements the "idempotent git_hash_discard()" discussed in this
> subthread:
> 
>   https://lore.kernel.org/git/20260702080707.GG2029434@coredump.intra.peff.net/
> 
> with associated cleanups.
> 
> It should be applied on top of jk/hash-algo-leak-fixes.

Thanks, this was a pleasant read. I have two minor nits, but other than
that I'm happy with this series!

Patrick
