Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501D2FFDCE
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643093; cv=none; b=qqyzcVLQXxqDNLXJWBnE2dVoXZHJ7NT3bAuEpTH5rd6JhSvq/Vu+ZGjSAWkt8HzEOB7aS5WzQawFEs66Ac9bfXQZ7udyX5jeg38Ve5OqFI0jgDx9kv1ogpo54/W0W8vqrbgClUgbhY+pdpZLewbtiOZOksxj7WD7tw0BmLQqh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643093; c=relaxed/simple;
	bh=8l/phfDYvCwq/MgYGGgYoBy2mQZ+GgltgIoB2IMQuZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFJtx9j4p6n5PJl+AuGPFjSujZRpiXkdSeqdTNtEjOH8pMU76FW+RVKXVaOH3zgCTQ/oiyuliKfUNGEd/xN1mG2VJ8DsmIE5rhP3T9pnzOkzY4xz0AZbZniSDZnEuAbrdJ77VVyOhOX7hjY/FEtcBZfZLC5uKBfDAlZkPc4r7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A2RXyJO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WBf413HK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A2RXyJO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WBf413HK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 88773EC0314;
	Tue, 28 Oct 2025 05:18:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 05:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643090; x=1761729490; bh=wQaxaNjS6S
	3VfBov+r5JdpwUQfX1QeaW07I8mtqO+fg=; b=A2RXyJO+F39e7CC6Ar6RIVYSAu
	JQ47PZApbYb19MmOPd94OCK+9aR6BiWVdTU3UZsLQbk5LQkpkWY1QiMZGvvAUJZR
	RCEIJYbvCrMfviLyXh6Gu0iwPbNs53v+SZsPy7ssK4Op3eRUWCnkoXoINA5Le4fr
	I2qqN7cjdyFhik6KRcQRL3f0/0w01Vsx+XeML9lKlOwNWCqh6pcNPRfW9XmCcItU
	90I9INA9y9Tlgt/jE4pglDWh6G5niGgCqiBG5wF0oAQGRdJZknGCGqNru62UslAc
	wJ9X+XPN2wdminAOlPRmd2O9IE9D4hKyd0IijhUzEXQMjqQuAcnEP8AMHrKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643090; x=1761729490; bh=wQaxaNjS6S3VfBov+r5JdpwUQfX1QeaW07I
	8mtqO+fg=; b=WBf413HK6AsuD0Ph60C5WXY/9uBk8QNABvsRNmh9vnzhG6qJxvD
	uOnPXlXU2o18/u14VkBZ/DWsTFqmf2MW7VtqiX06IzGij43i4vqvVpkemZ0jT5iA
	0j1XDcsXEWM5ckavwtOxdLyeOeU2j3qWceopbwP45zdljnia+/F3Dhni6q+dX4c4
	QQzpKNRsVSvAQpfI4alPpA9Nkdi/4MP+rbEHMbHpk4mmEUfX/rIIRtXV0fdrqhjV
	tg/Rv7M81X2qhiojcnXJzahna588ODQNr4WRd+KiFEFvRufVCqMCYSOesj7vdliH
	nzuAl5KnsxvlkUa1jY/q70Ah1WXf9lWAH0g==
X-ME-Sender: <xms:UooAaVYTorCEak9e2VEAePFHgL5NVr-PWOc-FXvRNnPasGWwST2jfQ>
    <xme:UooAaTZA2Jwti9YbPfXBOa3UiwUrDF7BtMx3oQk7w5ZVI3MI2rsFsG0VJiW7dNZBD
    -3uDX_-Wo-azcRjETUCq_anf8RyxVPUcfOPBNni1bINLQDRXmsI>
X-ME-Received: <xmr:UooAac_odYVnbwFvkmkeqPtf7vizd_gWZlbKgXz1Z7Pskx12fbfV6PhKkuo_bE7l0Ztzn86WUcL6lZFceSKopl2PUPiqPnXarDVzC2bW0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivghl
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UooAaSgoUrwta_dl9KDKSBkV7e_Rls062lx-XyUmdcqYSokm63bVgA>
    <xmx:UooAacc-MGEOCIvOsewznn2tcThhuRSZbbPt_8kyosjvqoF5O2NrLQ>
    <xmx:UooAaZrS-3kWWEBVAR9lk1lPXGq7BrRg0EwRRPgaWB_zlRT4WCJlig>
    <xmx:UooAaRAbUmnf3YYK4D2HsU9hPR8_07PhMpwuLcxuXIpvOVafi2cNfQ>
    <xmx:UooAadBel83sBIU-tU37uy9dtCeWNw1qYekhcVQyzQjI-ZHF3F-gOltN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:18:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ebea7a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:18:08 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:18:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 05/14] rust: add a hash algorithm abstraction
Message-ID: <aQCKTFrmtlp9UEL6@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-6-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-6-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:43:55AM +0000, brian m. carlson wrote:
> diff --git a/src/hash.rs b/src/hash.rs
> index 0219391820..1b9f07489e 100644
> --- a/src/hash.rs
> +++ b/src/hash.rs
> @@ -19,3 +19,145 @@ pub struct ObjectID {
>      pub hash: [u8; GIT_MAX_RAWSZ],
>      pub algo: u32,
>  }
> +
> +#[allow(dead_code)]
> +impl ObjectID {
> +    pub fn as_slice(&self) -> &[u8] {
> +        match HashAlgorithm::from_u32(self.algo) {
> +            Some(algo) => &self.hash[0..algo.raw_len()],
> +            None => &self.hash,
> +        }
> +    }
> +
> +    pub fn as_mut_slice(&mut self) -> &mut [u8] {
> +        match HashAlgorithm::from_u32(self.algo) {
> +            Some(algo) => &mut self.hash[0..algo.raw_len()],
> +            None => &mut self.hash,
> +        }
> +    }
> +}
> +
> +/// A hash algorithm,
> +#[repr(C)]
> +#[derive(Debug, Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
> +pub enum HashAlgorithm {
> +    SHA1 = 1,
> +    SHA256 = 2,
> +}
> +

Seeing all the `match` statements: we could alternatively implement this
as a trait. This would have the added benefit that we cannot miss
updating any of the functions if we ever were to add another hash
function.

Patrick
