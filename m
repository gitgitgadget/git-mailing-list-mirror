Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3A2D47F3
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707274; cv=none; b=c5LZUdMWOdavqeL/9cL2xcRr6wCAF0DBJwial4tVkJtKc8TF+gJkTerEWEWePNbxzwbxJTMY8RwHhiZv2CGjBHuKFYzjjjV4wfwNwmXDUpn91/Gc8qP2EGZtX4UnCV6EC7zIbWqm2CI+8sxTB4O4dn54r+s3MaGsZvuSBKd2HdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707274; c=relaxed/simple;
	bh=lx4/q7yJidWAfA1uHIJBvttGE9MnLnC1ddaYHrZsFak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9OmLrAQ91cr8/NGRyaCByQVGTxYT6AqphIhwsJhTXGGjrT8/oPtO+0TsPvWWiDoniP60VuhrYrm2Su71WY+81x7C5GXg+rNp+28QHi7ypGSpgGYJW3svBMsgR6x0F6+Sp5ju8ixEmabddWeoNzo3f9GTuRFM6a0kFBWY6p5qgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=saAoq8v9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVRDFl8V; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="saAoq8v9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVRDFl8V"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F4208EC03BD;
	Tue,  2 Dec 2025 15:27:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 02 Dec 2025 15:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764707270; x=1764793670; bh=2JtltORMr3
	lGCQjp1+axTL2XbgOLtfrX3NXmGHjBckg=; b=saAoq8v9XNvT5RzJAgga6YlDAa
	1g04OgI22kZrvKUFz28ulolHXSsPi3/lTKBmg5Sb2WpXhr7lk9NacMa+lnn5GkH0
	guNhGX/pL/tuF5Fflr17G29CSv7OI+qhvjxfF0TPKPgQlKrElIV0pDhY4IeYF1ax
	LHdxULHPxoY0zP+z95i6EPeOpsqZhPGlXjaqfyIMxVuDxmNqXxqFUiAFbVkfZgpJ
	DlKs29rEYg4Oj+CkfGcO5ek+Uskh4XRfWdiZox0ebTotRGEnVYSnugRrq6pU6xZ0
	tDCFwqEYx9kacfU5PlmL0eb4WFfdZQlvDTdWtXmZHB1GBD/64bsHe7iHv8iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764707270; x=1764793670; bh=2JtltORMr3lGCQjp1+axTL2XbgOLtfrX3NX
	mGHjBckg=; b=lVRDFl8V9D2QXNEEoxGYt02gZxNJUwtE8X73Cae0ayoQl9LuCit
	ku3MDM4Ktl+tpu0gZ0iuEBYFSop3QDCR3J2pI+KlKSPfrB2XzcRmlF1ABKXgcfvY
	kLQhnX3x7xNpU/A0j0ZZFlxF3x/omrZbN10+zRV7ttoxxKth8mNKyMm46XvInCk5
	zteeV5kDY9BZhJFPQiKUzNagnH/zL1SyJBCqwf9GmmFrr1Pqu6L9EXgUDzyLL4nl
	i+q7QbVP4xa1RYwsacABjZ2bPjjzA5FXrB3iJ0rFkjWb5nrWysWVnhXfu6FTo1zD
	GmWH/0hyAdFMJMneu7E770KQAPR6yY15o0g==
X-ME-Sender: <xms:xksvadmRZWdYM6xxLxkeATBModpxv_FlebXRnAp5RqT487s8pobV4w>
    <xme:xksvae2u58GOsyxK-89bE1ABM8i2YHyus41rOztodJ23hiPa9dKk4bUpeiVyG9ijF
    nJnMSUaAfyVWYZE6SoPqRMmvN7cK06v64PHDGfXXsZngzCcxOoLPw>
X-ME-Received: <xmr:xksvaRRfk7OFvyGZa1FTn6tinMMSgg3EWUz3zT8HH-lW58H12ChcJTCgOLWzyL4bvU8PJOHSjN51cQMs28ARz4py3ZWDScO7ubjbCrlu6Fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    thhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:xksvaYu8dQPn2Qg9Ec-9GmdQ--FxpXzhhKTTyxg-qPTIeDSGAurVYQ>
    <xmx:xksvaeamcISD6g95JL-SMcVJDYxrsfKkc3rcLKD1-Cd39vMcr7B65w>
    <xmx:xksvaVufiYfmcS35Z5eIla1aTMzLQP54mW0y75rRb-xnbNMRdtNJzg>
    <xmx:xksvaYFOPQgArYvNAN0xNTK-ObZHEQ9uqck2SOSn_DtuK9PnFNPDxw>
    <xmx:xksvaY-Aze8Nj7ChpB84z03a1b5-98kots86rrks2Ns9C_PIYTIUB8f2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 15:27:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d4b7590 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 20:27:47 +0000 (UTC)
Date: Tue, 2 Dec 2025 21:27:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] meson: only detect ICONV_OMITS_BOM if possible
Message-ID: <aS9LvvjW7mZStceJ@pks.im>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
 <20251202-toon-cross-compile-v1-2-cabc8bce529f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-toon-cross-compile-v1-2-cabc8bce529f@iotcl.com>

On Tue, Dec 02, 2025 at 11:48:09AM +0100, Toon Claes wrote:
> In our Meson setup it automatically detects whether ICONV_OMITS_BOM
> should be defined. To check this, a piece of code is compiled and ran.
> 
> When cross-compiling, it's not possible to run this piece of code. Guard
> this test with a can_run_host_binaries() check to ensure it can run.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index f1b3615659..95348e69a4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1064,7 +1064,7 @@ if iconv.found()
>      }
>    '''
>  
> -  if compiler.run(iconv_omits_bom_source,
> +  if meson.can_run_host_binaries() and compiler.run(iconv_omits_bom_source,
>      dependencies: iconv,
>      name: 'iconv omits BOM',
>    ).returncode() != 0

We have `not meson.is_cross_build()` in a different location to guard a
call to `compiler.run()`. But `can_run_host_binaries()` is the better
way to test for this condition, as it allows the host to plug in a
wrapper (e.g. QEMU or WINE) that _would_ allow it to execute binaries of
the target host.

`can_run_host_binaries()` is available since Meson 0.55, and we target
a version >=0.61.0. So should we maybe convert that other callsite to
use `can_run_host_binaries()` in a separate commit?

Thanks for these fixes!

Patrick
