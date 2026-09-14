Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0831ED93
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365056; cv=none; b=KADAJp3JKmRAzbq3rHLWOqUayz0E9JkQBHjqU8IbNpTN1vTO2PqBwstB31VfEP9xUe8lOh2OPZiQbI4GtFFt3uaeVbaM6kiB41SnWPkXzn3QowDIvIXK1VQO8lN/CS7ZbndSHfgoI4jJH3MhfzNKwYy113lT8eylC31FiGNTFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365056; c=relaxed/simple;
	bh=iAZ9sDjW8RAzvyNc9rg3lNOFMY2xSyn/H3wFE5G2WoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saB4p8yHMNnH0irTOGva8MUgibRNnVKEhlFk/bHqaUfMhnNc4CIobDML5dowbBmjWaw21lp1t9fOL0D8sB0QZ+WjwWejdPZ8xnjs1yRhqePnJEzUGb2inY1JdcW3tmZUbcybGND+VXxuRVxwQugYLdVMSB/WqgGqcpPl8LzjYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lpQUuape; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lldIBgAt; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lpQUuape";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lldIBgAt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D36AF1D000D4;
	Mon, 14 Sep 2026 01:50:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 14 Sep 2026 01:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789365046; x=1789451446; bh=nIRnaZsu20
	Dl1nad3frHwOLMWk1R9vvq1HT7SDc9R/Q=; b=lpQUuapeBTzh7VwqRDMUO8ssL2
	GycJ6OOO3qrFbVbYeVsCAmtybz5588zHxRdtS3qdifR29kRDOKp/nwj3Rls3anOC
	/m8p8hMExHFNXh2wZ03vyDSUU72xEbIyPfyJQOhsmQYyKVUVjoTrtYAQamyWHF9S
	UfsU8yLN2qJN4BcMIQ8pGJZIu9hon3P8q4kgWRCN/IZnbFvVTpvTt3ccPC0gnRQU
	sCUZ7q7QbVHfUgsB5FFIBiEdpiWbdz/XTXodzk4wRxUHQ1CaxnLW2OT7CxCfOB5C
	/ugX6qwIXphC345zYo9OjPrCjL115PrzuijF2uSV4pcIoNjeBzS/ICuOOfxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789365046; x=1789451446; bh=nIRnaZsu20Dl1nad3frHwOLMWk1R9vvq1HT
	7SDc9R/Q=; b=lldIBgAtuEsEvKz8V1z0iWFTk2R94devsCUWLJDhNvmDQ6ZQ4aB
	nt0Yhy77OASuctLT0r5kZxDiDVjxG3zUS8Rlw228x3/t5hjF+JJVIWOcXYjA6YG2
	mEY+BYlinik8CGU7C0Y7/ZmqRko1JR9lfiJJWz6e/FEwrrT+QwU0w4aInQENivDD
	PX2EYWg3LWqFPIpEspcB6msjRlO8WzStx6Cayut+bZEgMQeDR7Pdk3qeLGPCZeBn
	eGVm5oV9xiYIzJhLzPYkmhn3dFHYrgPEefVhzfaNSjpZIczJBIdyByfL3KufyMwu
	txD+IeFV2WsDAkVUn1JyP8s0n5MFpKxcZ1g==
X-ME-Sender: <xms:Nounapr16o1mZPpVrw1lXg0vz8d9uy2WbGChLC9Hqd1K3c3VkpcK8Q>
    <xme:NounahqOPlQ7J5TRw0C_4ZaWSoP1hAeNa_6fnLEXuh1CmsEOYVM5--MOK8DhmBq6f
    5-595Vc_4rF7PzupiumTFRMNpgaqgmIToSkT5577aXMv95lQQiIeDs>
X-ME-Received: <xmr:Nounaj3TjtLFQDXSVUstdfa9kHVAzxbpCH46AfTOpRb7e7Cd2ugIgmsPg1ZY2wNJqX_DpA>
X-ME-Proxy-Cause: dmFkZTGb/iXreSsME4oMDr8YI7B9ebsfUkMk/0uG71eQX9nLsvl9vC+aijkPke8I2sFwnT
    bEhv/FU+G/VjmHYskXw5VNzwOheamI5MxYcvIQKkfpp912kGhCn9/3mIm+WbtmrNEIMBdW
    T1RT7PlrzWJ8R/3skAyv67LksagPUCs/En72khCg+eiP73M7FjXjVCMuqdi3Q1wzQZqGzL
    T3BoFip/JYSSkrSfYeMMg+2iaTvEDz/YTEBdZWm29+4NMq2gnNJju/U+y9OTCazcZlubt/
    w4W1UkY65aJGFlpIP8NCenJn8sfBgJHFDKGtd9rgTR/5LqlIIz+w/m1zYmbRuxPAGwQHZL
    Qd1kcePn8+IQlj5ZG4F9C5omebMQdwk5nAoQFqZk6hQ41RuPFqy/7wOXm0/G6tVYFOQJIm
    cqGL+kry6Y7xo4FXj+9iDEosWGnf/MnVAyJeYwEWUFL+OHSd4MDaDDLc3WdkV8n5WbtZM+
    tyTBHgjvsSOdIHlTuEfc674qeZYAeJ3F8NXxsdxV2ldFpzittk4Js8WsJyqisst7Y7eC6R
    kHHeSWf2Zx8Y8JNr1Zppp4d0kGJkTWq6y/k4eWtlSxRQPiLoyhpKg1Gtk6zo3eDKDCl95z
    4uhnjPNDDKJ1Md55H8OU94uvHStPurZi0rTJ55J1TjCTAGy0gf4qA06gQzYw
X-ME-Proxy: <xmx:NounagAIr8J4zrfQld1oGtoxRZYHjNByGmOp56ATAC3FtpnTXkbORg>
    <xmx:NounarflfG9n3H-63ckQICYf6sm8tZdjM9R5KFHNo3nT3oCImYZfCA>
    <xmx:Nounalgk3MK2Y2SJnyIrKpcSR0zqAyhWEie8ESK5iu3xt1qT5q8bTQ>
    <xmx:Nounajo8F20XwE18H-mOPuhlZbA5FXindZfjlQDjQvkAypjA0J2PvQ>
    <xmx:NounajY67jUXH7LxvaRKD41gzDzzTPTdFmk6Pfi3OnF5c37R1dsIxopb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 01:50:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76ee3ce6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Sep 2026 05:50:43 +0000 (UTC)
Date: Mon, 14 Sep 2026 07:50:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ariel Keselman <skariel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] refs/files: avoid packed-refs lock for root ref
 deletion
Message-ID: <aqeLMG7lTJy3bM-h@pks.im>
References: <20260912014609.535922-1-skariel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912014609.535922-1-skariel@gmail.com>

On Fri, Sep 11, 2026 at 06:46:09PM -0700, Ariel Keselman wrote:
> Changes since v2:
> - Run pack-refs after creating AUTO_MERGE and verify that it remains loose.
> - Compare the state of all refs around the failed mixed transaction.
> - Feed the deletes directly to update-ref and omit the optional transaction
>   commands.
> - Drop the redundant test summary from the commit message.

Thanks, this version looks good to me.

Patrick
