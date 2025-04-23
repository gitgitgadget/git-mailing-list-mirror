Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAC289373
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430027; cv=none; b=sZtwyf2gtMGwkpJL4/xIdJ2R4UuJuA53Rwb1hzbmBhARoHKMY9pQoNONbDVK2uFjPU/cymA4MHZIX4SGeeab8J3NpduCAfAFj2YFtap9xKttwGOjOGjb1aIo61v613rNgXALlnmGrJe5jH41byMJg5T8sBwcvNE7+CjPby46kF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430027; c=relaxed/simple;
	bh=BJlBam7Ix+e+WDtyl0mtF72k0vRzLpdPcdq6B/CyfWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+AcYIY2GgQaK0oi57k5SaxMn97a4k9HbfvgrabfFiwDdhTNgyxwq1vXMfvd4eOUhVm5TmmJu3asbouml8POe/vt77jsgKq3raswX+G5dLgms+bnxuCs1HXDgYhvQbE70YCrjeQDSZOxHLsJaxDyj0wAEI05gxvCvWv1GG306PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lC+fK220; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVvmA4M7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lC+fK220";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVvmA4M7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E90A11380222;
	Wed, 23 Apr 2025 13:40:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 23 Apr 2025 13:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745430023; x=1745516423; bh=BJlBam7Ix+
	e+WDtyl0mtF72k0vRzLpdPcdq6B/CyfWc=; b=lC+fK220xRAtJ5UMdWTFZ+cFZ6
	/hvr1SL5grkJF1sESeD8+dbU7e0TzvA8xQefyA/IxIUYmxH4DTuiAaxzfyX0dQQz
	KOh1yFMdBLx3WBdpjqvB7pakW8foCDL3kAgoffC+4AvL0YErhinUUwI/xaFamCMI
	hB6j3UBiUSFHBCRL4zscl0xvgVCrXUDNhIkGewKAjVW3Jk57aNrtjP5v0rWF3cQS
	B9JreEdUzCeRd2s9i0imbEGLdQRsZd8/HbxGHZnha5YaIDF8TDCx5AGxNVW1GCQk
	/7zORcurwSZd8lxK0cXu0R7mKcWv/9FvVhJsxBvCa+oGNQ5o0w6xq81C5uHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745430023; x=1745516423; bh=BJlBam7Ix+e+WDtyl0mtF72k0vRzLpdPcdq
	6B/CyfWc=; b=GVvmA4M7uuqHL1mlZhs2dzXMTs+rUJ8E0QeCX3n0TkJkJKeqEZp
	bfYSRTbtk4XL2JZFfxR92kbHfAEeaN9MRXT4JByp2hMTWI58MqIk7Pm676F7Rs8r
	HCi/cAQ7jg7X+lTbVp/y3ytiaCO2zVLX4i8zFhEvUCM6+RgEwrwFQlfTW6QTNCGb
	KOyys0or5YjXVNLUMbdrEwb40qQwLpImIf8Pd88SxINmNbYlyjn5XnYVhUwWI7b+
	MjNU2qwkgE6t88sWtsCK++YqOrnoHQUsz2BQJZEdSH+Q8KNHTALXDXuTc7IG4NoN
	Vy8lnjAG9ZDTBkHaZA4IDa86P1tc35ZZx2w==
X-ME-Sender: <xms:ByYJaGBgaOSXNaXSmfiwRI2o62fX6csmbPpiETghKwt_OZ-dHGFUIQ>
    <xme:ByYJaAhlfWeMwRUo1pdOj7N83Xbgik4GCtGITSx5uT_uZ-prv6FfD4Aqx2AHtB7rg
    oDhBgwqKqJY7b9k0g>
X-ME-Received: <xmr:ByYJaJmM6cOxR5aDKgH1SmzVuZb1r9tZ9xuFrLsYs5RSoXUYLykWzaNDFNoAZApB-eI2IIKuz__RXWA2XKZd2J74Hk3Xh4P4DUMn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ByYJaEy_sc7-Q6a6WCkUT00kzEqgIKflYYn6sXJrGrYHCE6dLULsVg>
    <xmx:ByYJaLR_4DGgYJvyp_FMPvI7Wlke3a7MU_dgwDOqglh0TbfKcosVbw>
    <xmx:ByYJaPazKEI5ulayOXx2PI1imlBfGw4y5w5t0WuarnmhaGePJiVEYw>
    <xmx:ByYJaEQ1aWpITE0zgadwoLLbUdfd_K1D9XRdFFEzfbrbCTMvOGENdw>
    <xmx:ByYJaH3Sxb7E33Y28DRsHhbh7xGFbfdEXRl20oDVwK45jx9jqHT63xW5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 13:40:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com> (phillip's
	message of "Wed, 23 Apr 2025 11:05:30 +0100")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
	<8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com>
Date: Wed, 23 Apr 2025 10:40:21 -0700
Message-ID: <xmqqtt6ezshm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

> Hi Karthik
>
> This looks good, I've left a couple of comments but I don't think
> there is anything that necessitates a re-roll.
>
> Thanks
>
> Phillip

Thanks, I think the first one that stops us from using tarball
extract may have the biggest impact on the CI, and might reveal
some other bugs (like "this test used to be skipped because it did
not run in a tarball extract, but now this is run and fails"), which
may cause us to scramble to fix them, but I think that would be a
good thing in the longer term.

WIll queue.
