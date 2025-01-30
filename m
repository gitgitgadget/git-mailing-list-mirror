Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7453E499
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738220779; cv=none; b=HWFdMZKyZbnEuH8xGmxmFNvy3Hif7Y+kUq+8ZO+yqgBPMe8erZOQJjkx7GsSi6P2H32IL6uknDiwYTmkg02g1XqPVRSJd0JQ17BOqqP+T54IT47CvL0O7tAM3R7qy2nR2HL8WWLd2sIChHbL0tQlCj7jW8fiMnfa5HCnnoaZqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738220779; c=relaxed/simple;
	bh=tDKMyHz+YemptMFSgDN9vh05kb7U9YwgCTQoIGcB5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtawjP0tZHbzytkybCnInv+K2ENcu9l+J4rlJbcpzSBHJC70KCQBODyufiIAc7vHY7GcccXXWH2tEQ3uxkAqTWhmLdUPPjGXqNKeriSlG00Hg/6vSYGqvQwdAIeC6rx3Njro4uqv35QlpZ7KJyVBSAPnQyGxeldbPtIjl1Gdfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bEvCECXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLafca+r; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bEvCECXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLafca+r"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 202B4114009C;
	Thu, 30 Jan 2025 02:06:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 02:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738220772; x=1738307172; bh=q39iPeAxLs
	ro6LIX0yIDOtpUWi68oHhQdafZ/gFa+vE=; b=bEvCECXBf3/HXEbJI+9agNPJS+
	spJHw+HygySpFiLGjst5mbRzx/bfz+X4gBuKWjerXT9o1qeMQfP/M3LRR9YEDUV7
	UReW+Cy6u69A0OM4IukrxqLTUSJ+9uJAgGKalQPwBK0QsMiNAF1MMwrjh4Jzxl1v
	qfalPdqb5K2YCoB/ShB+sASplW6bMmgYj6tn9dD4woeN3kL3OsmwJGaUCFv44i6i
	ASrcLSwXvV3wNVR2r9X+gHmF4jTzf0I1DCT0eMBxNWqv6NExlPf2uAVvshlLM8a6
	MuFQpJWDqtxJMi+OJKHfhdaPl4r6PjKdOsTsxdsqNAnCfupPC8aFP8fRlfDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738220772; x=1738307172; bh=q39iPeAxLsro6LIX0yIDOtpUWi68oHhQdaf
	Z/gFa+vE=; b=fLafca+rsIBwsAFKSHpJM6mc0wTXaP0O96FlXDKbDjb5HV8WdtO
	JuSof7J7RorGXQr80K8NLbX3d3L+J8plccTeznnlbJctLVCQJdqwMZ+zLv9OAldr
	M3zwPV9jA9VOj8ua3/EHgumVuTS1t6IKxtgpHUZI94Nulj1UzjdcglUlYb8atHST
	VppN/g1ibHAklw/JnhiIAiHi983Ps9CLd37B+rf1Kdr3qfb7TI6I1Jdx2qdIJS7D
	l34wYn5bgAhSGqRHNIPeeyBcadyPsRPUDV7ce0MdzQD3apvlpE0zCn200H6N+KPu
	PcljpeUiSmzttWO2uzOLJhkVD+8R4FopCBQ==
X-ME-Sender: <xms:5CSbZxFdFKF7CMuoOWeoB6Z0HhXRiVbX7UwyuwYj5W1rNISDeMorng>
    <xme:5CSbZ2UC67KMq2goOaB8icAaic7UEuorYG67DpHyUFjR5hdG1wKoWRkgtqAupKeD1
    NaxXWakUwPLl_d7LQ>
X-ME-Received: <xmr:5CSbZzIbsxTHRFHIkvuBxx2wngmoiIoCHvf6P_AhcWMwXhugUPnY4V8CV5lMZW19gbqBJuQeHyhF9TG0Wuf8F2qmacIXIZcuF3F_Oc4ByKbu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5CSbZ3HsrG1ltswpt5ccg-6pHPOZVj-JVVKkylEsn6uwmu95eQYlvA>
    <xmx:5CSbZ3X2fUGl746kD6vklQ0tV3FnX5qZdNrDI5Yzp4c-jMhqsXEMgw>
    <xmx:5CSbZyOq0TjKR7Zd_U-IkBN18GK_K5Tc9XlybXp_ApFinYYTcjsl5g>
    <xmx:5CSbZ210AjXm94DDRgju2Xxx5KsxMUG9FQcnN_MilD311bDPTutVQA>
    <xmx:5CSbZ0h9A7RSXLqbrNRH8PF_HFi3MTv6o2BMK5cCUUStS0dHZY0a0Z_Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 02:06:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90903370 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 07:06:11 +0000 (UTC)
Date: Thu, 30 Jan 2025 08:06:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] meson: fix exec path with enabled runtime prefix
Message-ID: <Z5sk4iIDTHDG3Gi_@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
 <20250129-b4-pks-meson-improvements-v1-1-ab709f0be12c@pks.im>
 <7rnnfxsi4taxtyqek5udyplp767w6jdbw3zshvbbsbc5qxmjs6@ftjofkjsnzyb>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7rnnfxsi4taxtyqek5udyplp767w6jdbw3zshvbbsbc5qxmjs6@ftjofkjsnzyb>

On Wed, Jan 29, 2025 at 02:12:35PM -0600, Justin Tobler wrote:
> On 25/01/29 08:11AM, Patrick Steinhardt wrote:
> > When the runtime prefix option is enabled, Git is built such that it
> > knows to locate its binaries relative to the directory a binary is being
> > executed from. This requires us to figure out relative paths, which is
> > handled in `system_prefix()` by trying to strip a couple of well-known
> > paths.
> 
> Ok if I understand this correctly, when the runtime prefix option is
> enabled, the prefix that gets setup by `system_prefix()` is expected to
> be relative from the directory the binary is being executed at.
> 
> > One of these paths, GIT_EXEC_PATH, is expected to be absolute when
> > runtime prefixes are enabled, but relative otherwise. And while our
> > Makefile gets this correcty, in Meson we always wire up the absolute
> 
> s/correcty/correctly/
> 
> > path, which may result in us not being able to find binaries.
> 
> So the problem is that since GIT_EXEC_PATH is always defined as
> absolute, when the runtime prefix option is enabled, the relative prefix
> is not able to be correctly set and thus always uses the
> `FALLBACK_RUNTIME_PREFIX`.

Yup, excatly.

Patrick
