Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDC3A7F64
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720853; cv=none; b=iIxV3cEtIUsbgCaQ7acSwJArBYJZ5T7BhKA6cuGK5utiPUXa57xeHLUHmP/DkN+AmIgvLzoc6GPyi+xuqS36NPYQksH1V/Hp37KHwwed6QTTAH0qVr/dUPsAJ6M8rMxxaWCino9UxqsBI6UL6HHcGGEhNWO2mweVVfV2odbu5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720853; c=relaxed/simple;
	bh=Vtz6eZBgf39azTVYo9NewWMP+yXzt2Jdji7nn0TVWb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo3POhns/pPOiRQJ1FWY73XgtAeTpxpe5z2HhSe618ANVxgobHEojvswgISFYk/8iOiLLQW/4SZLf1xm79VkFygvWpoMRqXZPzACWXHMD2f8UaPcb6k23snTsqhmqGE0wDhpJ/wrTW+zJkSBb7ux/rhziOtJEGdS7h7zEQKqDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VPC/M15U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aze2R2Sy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VPC/M15U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aze2R2Sy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23D907A02A8;
	Thu,  5 Mar 2026 09:27:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 05 Mar 2026 09:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772720851; x=1772807251; bh=KEIHYmoHKb
	RU6IumTmvR67hj9qQglCqAHffhCkhuAb0=; b=VPC/M15UWWwRitXbRPUGO1RU2w
	ZyIAnsmKljXjDM9gD/D5z5uEm+SqhhBCtQ8x1jWpI8yKLLHzCiZ361mI/8klDm8d
	htf/Kl9zQkYSqdx1uQeAKVQ+29r+HhDzY417DOInEvvlKLXJToSX+ZquWWgsCfOZ
	8bQUBHMtxvfUqeB9dFEOXitSOkYY2AQG/J2+7vmO/iV4aweQrHtKmMAo91Ni4MEH
	IMHFVF28TpGGb3oArX5FOOBsuMw5lm9M+Leh29NM+KiROfeVFn+g77RpmGoLVSSg
	bwU/HtIUluFmOtMdvZjDeyUMuYk7/CMFd5e/xwPNh34PzM5DPcOnIKR/3HYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772720851; x=1772807251; bh=KEIHYmoHKbRU6IumTmvR67hj9qQglCqAHff
	hCkhuAb0=; b=Aze2R2Sy899eblinXUlJt9m99Vf2jBj0Y2/Edch6CldHk3XjOux
	WSlvHMcASpmV9IbdLy3I91wdjngM48x1kii5/ZJjhYe5JxTDotpQcuZKru0bPWAz
	Hyz+UpQ1ZIoxQ68uL1yJpBziZXjKaH7zQadDjG3TPJHJszsCbYzlrrQvDutUZcwk
	6vmteivc9CJAY6mf5qJrX7QSXnX7nhJ47pJexkrY9rbycGBWdNe5ixA85lTqphdK
	IX9MOAYWzB+WK1GkRH3d+u3Mdo9T1CdnpB/NNlR6dIGx2Cuov7QfyLjTyZgJbfUt
	TUVADjuf6oFdToU/m7B8bkjwD9oPMnYy9pA==
X-ME-Sender: <xms:05KpaXB0FFI6v62ehDDxqF4Yy1k8aOHbg9zIVvhmLdyHX0QqdOv2Qg>
    <xme:05Kpadsp2_7G-S5wlREX_TZ_93d8DpnazDkaYn8XdxEEf2kd5rD5DoxPDXmwshMDn
    HZJqKOZm6yloP2LkDN2_HsirZc_jwWgJf_uSsQ8QADFqGQszjc3>
X-ME-Received: <xmr:05KpaUbdqRI7gJ9ypQU4iJ0fcPALRliT02fsbCFWd4qZDO9ShQSyyk5R9zYHn2B45bkWwvgh3lwTqvAKDb0wf-vEQcsBfNfSqqFaUmE8N3MN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhfohhrih
    hjihelkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:05KpaYWYbimVaG-1-1KEQ7PZJCBCygwUJqezbXSi59LvJQ2n-5aa4w>
    <xmx:05KpaQ5aUo-Cs8oGajOPdi0UuI9BWu4UQNMSDEpK8ZyfDPFAZCGU8Q>
    <xmx:05KpabiedQff3a6XFpOuYFdy61Gqk5sGC2ZOqbKrsZXHflhIbtcREw>
    <xmx:05KpaffbH238ytYLoWzJMU1FToWessbUsLioU7i2cZgmlNxCAMXTpA>
    <xmx:05KpaUTIAiKS1PJiAqtSiJpmmRdYJtvHrrHXnvA4985ZQKD6iveCoZMA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:27:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba6c0aa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:27:29 +0000 (UTC)
Date: Thu, 5 Mar 2026 15:27:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] oidmap: migrate cleanup to
 oidmap_clear_with_free()
Message-ID: <aamSznHdv4g97R6C@pks.im>
References: <20260302200018.75731-1-kuforiji98@gmail.com>
 <20260305100526.102130-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305100526.102130-1-kuforiji98@gmail.com>

On Thu, Mar 05, 2026 at 11:05:24AM +0100, Seyi Kuforiji wrote:
> Hi,
> 
> This series replaces oidmap_clear(map, 1) with
> oidmap_clear_with_free() and introduces explicit free callbacks
> at the remaining call sites.
> 
> The old boolean-based API implicitly assumed plain free(),
> which obscures ownership semantics and does not work well
> when oidmap_entry is embedded inside larger structures.
> The callback-based API makes cleanup explicit and type-safe,
> and avoids relying on hidden assumptions about allocation.
> 
> This is used in subsequent commits to adequately cleanup all
> usage site.
> 
> Changes in v3:
>  - rename funtion to meet guidlines
>  - drop [PATCH 3/5]

Thanks, this version looks good to me!

Patrick
