Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE09EEB3
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514863; cv=none; b=HKEyzqZnScrQgJlwRDz68KW5X56TSBXx1/vIXkOBl3CDwRTjlZMvy0CLlIdhu7Hmj/5a84Tzs3fEQDvZ3ulncG1MZX7qM/Y0KLR5deDKsYTqrn+6W7An8TXX0u6vyI4mxwW/efihdxbkcVSQBCd5Qc8YrSiBvHgNFU2bApBPFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514863; c=relaxed/simple;
	bh=JGni6SiR6nn1FMhGmJM0fMV70xOiZySQCUwM/rVYhq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPYAzsg76uiud9Xf5d/ThhtaJE9ahNQo0J2jsSagTKXwnvAn3gRmzD+tCVnkHnTwordy4wKkfIogx3014Gc9tVL2VC3zl586rX/G0y1qeTfS2QQQLz7xes23UoxTk+9C9RGPbW7Y0ZcevDXLq0IaFtU/ZSAWguS8Ih4s3v5eocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GUvudrRH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vIX+8JnK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GUvudrRH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vIX+8JnK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7103414001B6;
	Thu, 19 Feb 2026 10:27:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 19 Feb 2026 10:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771514861; x=1771601261; bh=JGni6SiR6n
	n1FMhGmJM0fMV70xOiZySQCUwM/rVYhq4=; b=GUvudrRH73nK09JQzLt0FTKSs1
	TCRejrpTn1Yt23GjVhMn4W6L8cFEuHaTfFaMqsXmTQKs/Y6ezZZWcon8URSrHXIS
	EzdQCBoHMJCYTlw8ETi4ivHpqSHZ+8qI5DVGh63zn7AYJ5/f4sWo9KQTDT0Zj6Ba
	85HOKs1/hSZ6Q/D97XhPbF5CSH8ycOfL/j0LFLE4XZOKkoYZirO3F8slRN0XBlVR
	LHzQEMkn9hhc5sqLo9q07cLh3+asi2QS6EXT88YPvaoWa2qfrPn27a9AIoDeAHYH
	/E6IjuHXawQFl9Oy5UtWpjla3pGbyxqp6dHsh9xlYMUi32nFCZKXwr/Lm63g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771514861; x=1771601261; bh=JGni6SiR6nn1FMhGmJM0fMV70xOiZySQCUw
	M/rVYhq4=; b=vIX+8JnK/U6Sdv8GLFrLfZ8s7PyitPBD5P4OZcVjVd8UV9C5CFy
	XqD4tgfzdZUPv6umCMRyooDVbSO2gmDN7+7pwc7KY+i/V9C8uFSN8Umhw21EqkKN
	Wct9FUeKoQ2kDzkM5DA06oe4pIl0/6FbF85FNsDp8F1opWS93TLu18JCsxlEerjN
	M15ZB3hVm9uH46sSca0KQ83F0AVdm7DyQbwymDrK8mGfmEgiIyFXtR9nPcjxDAd+
	rhCa6rsETY/yc8g6dENVHiFra94q8BQYSgu0+jaMKWCFYvgOK4SLi/7KgEWgTBHj
	d/zmDFP9nQRDNaybYfsQHdgS4vJ9ZFjXmQg==
X-ME-Sender: <xms:7SuXacc2nGSPr-mHodwRLBZlYsU74zc1KPGHu_XtOvWpWhjHm-dTtQ>
    <xme:7SuXaVoUAPN8zSEnhzfAcgquYZDqQxyywHpdKhYw0ZpTeFLQFLmRNfh3DIumCmJAO
    QXQoba2phakdE4-nD-0GuHCF1ioceQxZ7PbYs0YSAa-OYP2PidDuQ>
X-ME-Received: <xmr:7SuXaa6Ox4z6iYrEPBffyH4PTfjGiNbw7MRLFCgjZ7ob7KJW7zpqrpI6aM50bBVwxxye5BHnWwG6tG_DHYc75W5FQfel2vSEi-EPiRR5mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:7SuXabqXWpBSqpzRA2Z2GZkTEIWV-XlCoI4nu-mjfo_TkMpHd40I2A>
    <xmx:7SuXacgxvXCY5oGmFNCVhRHcGu4mGoz0hf9rcEJ8blW8Sr3i4_tDWg>
    <xmx:7SuXaVJjOVpsOW3dS9R-jeLZbn_i6wDyWQMI_cI6a9dBfirWziL8tw>
    <xmx:7SuXacD_FRNsx8rfK7vIrkP1sQaenfcDrj6Ui0uvl_aS3NQe8XBLmA>
    <xmx:7SuXaUEi4OBHTeXnbtlvhs0WAEF9FcoJZraAwmT6o6BKG320PZjF3E3n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 10:27:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5573827 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 15:27:37 +0000 (UTC)
Date: Thu, 19 Feb 2026 16:27:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/5] merge-ort: replace the_hash_algo with
 opt->repo->hash_algo
Message-ID: <aZcr58Dd5JPngow9@pks.im>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <36c2713ceb305f17295c4e8b38dbf252dc641128.1771406115.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c2713ceb305f17295c4e8b38dbf252dc641128.1771406115.git.gitgitgadget@gmail.com>

On Wed, Feb 18, 2026 at 09:15:13AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

Nit: might make sense to have at least a oneliner here to explain what
we're doing, even if the subject already says it all.

Patrick
