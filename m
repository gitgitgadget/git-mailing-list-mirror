Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3542DECB4
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579338; cv=none; b=mTE+rVbxIG7R9iga3rKuQU2Gvq7kQOCgulkh7Pa7LCededbY+JmCEYSK/Y089CxOOo8kLzxTXcKyzj+XkSEbYLQjjLXaRHpX4upfPGWO58ZNXKr0qWGxPuXTy/A8uC0W0gqk9Lk9U3h3hjX1fvV1cf+hlAm/WjBntuUcUkLje/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579338; c=relaxed/simple;
	bh=U5kgcFanuqa1nrC6C7mZEIvjLRE3S3pAAmeAFqJV0Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTy4afmg96kPZJC0hfpU4ke/8zhtEfJQlu7Ok5XWV58I4XWoOLqBXJo4iGrjaud+iqK3NSCasKK46lZbdqbt0v0IuQP8oF2maWOEThPLSx2lMnP/dCiR1xfoanIkbPmB/uY13XIHjsPGt3lXWL3dLKpq4ZLx2m6uWkEIKXdpPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zq708mQu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWxFRX+z; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zq708mQu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWxFRX+z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F074BEC094B;
	Mon,  1 Dec 2025 03:55:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 01 Dec 2025 03:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764579335; x=1764665735; bh=cV57Z4ILVU
	G+EdCf1FDUox1QwHw2ZGPH62krMT4D0Sw=; b=Zq708mQuq6z0Flsnb1/eM9xRa6
	LR+SQN8Dyu/blxOJASJ7jBngOBy8PCbTfTLZY2GwZuAbVx3D+MebJkNg94Ms+5ie
	kqfHDMaPsIoqNH32sHRq5t4HW4/nQfRgHJ5AFYjiAvpsdBb8RjACskaPPAIaBFTa
	nBbgUDf7fM2oDNvrq7XZbcACNV/WjDIFVAqwVmbtA2zVa/ixDom8ZWMCpuvrgEjp
	e/prXhh5ZTe9K/lfYZrzNIVklIuX4N/Cy2Z8zE0TEoAqiAnNdu5RHuVWd8XR0vrk
	Q6HxFVWgpd+XV6InvXlu6oajee/gpURQSgAGZFaXvrD6dNwrwt/5Qie1lciw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764579335; x=1764665735; bh=cV57Z4ILVUG+EdCf1FDUox1QwHw2ZGPH62k
	rMT4D0Sw=; b=OWxFRX+zJW/M+Lj19612Ram0jWappv/a9A5o5C3YZgiXie0SRuH
	agW1Ipc/Aiz0DRIl7z5P2+5dj39X0G6aPexKxSMsqYMr1rz1qYYReoiD3d2daz0n
	m+S/qS/JufZKZoO+BOMFJRoyFigWHUvZVSX1ej5GdgHJXLsC+4TLz5Fl/Lffqq1r
	kkzS04lLZzdj0d4YtuixDh00fUjEElq/HlKhfQd1o543yAd5XbMcfd217hkrFDT9
	NQOPO1ceMCaeX7ucOGl/NC1Kr25jzx5IMUH6lk+ugtel4SuLsYMkZ4KVUSCruTNZ
	KAeVzeLzEAvRopuhVy3NLzAszKW5YL5zIiw==
X-ME-Sender: <xms:B1gtaW6Kh_k0VzGwGzJWw4TebKwLMM9AuZ9SAvoHFg0ez26eRs-D9g>
    <xme:B1gtaTkG7v0w5qpfcfBOaS2yK6s6QVB8V2n0JeGviZ_c0yb_4xwwL1WALxMbKKGG8
    iH6iFWEu3fN1X1b_hZba7puqelMVkj1KaM5GqKNTW8MGBD6UEU>
X-ME-Received: <xmr:B1gtafQ2P2uzK6zvNEVlCchDvvQ1wiQvWSXEJnJwvPlUbVgK_DauI4QFUxeV3vJLsSS-IIN-cnN_W6wZDWLlrlRGdJGTzGKKbMkPwPUm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghtthhhvgifhhhugh
    hhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:B1gtaaENJ5pF8SMagM1uZl5B7K4VxEnJFqSnxWe7S6H-Ehcpf5jHVQ>
    <xmx:B1gtacFCwU0nijrSVlON5LMaXKu3cNQqECLjG2SyAzCUAKLTHQ0mOA>
    <xmx:B1gtaQTxXjSIcoYMMh2pI750Hz0-PeqYRJcRMmUDcQGs6BE05DpUXQ>
    <xmx:B1gtaVKtrk49xRz0woUWY38qLRWoWwG1YpbAwYCcuxgMzGmlzX4eAg>
    <xmx:B1gtaTVzaUhEkGFoaJ6g0D8NZufZzysHbzRp7qG8nm5Zl8tbw5Pbh3YJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 03:55:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 308e2102 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 08:55:33 +0000 (UTC)
Date: Mon, 1 Dec 2025 09:55:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com,
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/5] scalar: alphabetize and simplify config
Message-ID: <aS1YAugZpgtNkgkR@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <9b8ce6ba2bcc802ae38b2e1223d7d93b03fb2a1b.1764195516.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8ce6ba2bcc802ae38b2e1223d7d93b03fb2a1b.1764195516.git.gitgitgadget@gmail.com>

On Wed, Nov 26, 2025 at 10:18:35PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The config values set by Scalar went through an audit in the previous
> changes, so now reorganize the settings and simplify their purpose.
> 
> First, alphabetize the config options, except put the platform-specific
> options at the end. This groups two Windows-specific settings and only
> one non-Windows setting.
> 
> Also, this removes the 'overwrite_on_reconfigure' setting for many of
> these options. That setting made nearly all of these options "required"
> for scalar enlistments, restricting use for users. Instead, now nearly
> all options have removed this setting.

As far as I understand, this setting causes us to overwrite any
preexisting config values when reconfiguring Scalar? So with your
changes the effect is that we now don't do that anymore, which allows
the user to tune some of the configuration values to their liking after
having run `scalar init` for the first time. I guess that makes sense,
as it gives the user more flexibility.

It does make me wonder though: is it really the most sensible thing to
overwrite any keys that already exist in the configuration? We may end
up overwriting configuration specified by the user both in the case of
`scalar init` and `scalar reconfigure`. But arguably, we might want to
only ever write configuration that does _not_ yet have an explicit value
in the configuration file, regardless of whether or not we reconfigure.

> However, there is one setting that still has this, which is
> index.skipHash, which was previously being set to _false_ when we
> actually prefer the value of true. Keep the overwrite here to help
> Scalar users upgrade to the new version. We may remove that overwrite in
> the future once we belive that most of the users who have the false
> value have upgraded to a version that overwrites that to 'true'.

Makes sense. This has likely been a bug, and we now want to rectify that
bug.

Thanks!

Patrick
