Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969522F852
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919941; cv=none; b=dKTt073m3zgMF4Rw+TVvmsmj5RHW6A2Fz0xTp/PPhFICA5+fDxft4+vvPo2mVr0SosgYtwrTilhIAylfISbGOLSOpImZm5Su4wbmkWngwPnaRhTR5gfybHrDmpAhoVYCnLhUmLHjpISbuupOtUsRXYftm55QpO/LHC5oo7MngG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919941; c=relaxed/simple;
	bh=KZYi0jLUQWkPXkbpYWPptq+AA3xIe0LyC4d+0Q2Z6oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGTNjwsVUVT9z8I5E8EapoZimjuPTeA1FTbTH5Y0hE3yj566YxbuodNTTLznlsPqEInEYxkt615fdzQWawdgi0QRVJ+s+IayqxH3DN+4XzjW7gYmCs/hEovWD9gBQsRAjPpqPFcCGB/l5HL1FRGBDucoAeKCMX+EngsDdOxmYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFrv6XdY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWmprjKx; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFrv6XdY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWmprjKx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B5C0A25401D4;
	Wed, 15 Jan 2025 00:45:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jan 2025 00:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736919937; x=1737006337; bh=TAXVIqrtVT
	HoNcTjvoaym4Q+djaS6mb416zA/pw7emA=; b=RFrv6XdYY0SeIw/2aB8C6uWO81
	NKghD/zVVzDQKKnAiIK/kwA0hxloonU7DcsXOTD0DM/I+22uEHrCNAOucufYmqK6
	kZvL2lytI4iFja9sXB1IdrbtaKPMnqPD5oJT96Wk+SVsUqtIqCf69XzJ/deD5q3U
	xQh8vNWanYEZGazIKzwkFQzqghRWioIsScOS0aKEfg0dAJ1YyP1VYApPKTCa+8dt
	B96jGgk3JNuJjbSWD0sSqMS03j1DNJP5yutlcRknaBGztumBq5pToA8DJnNcXLp4
	RoAPUZAR/QkqMUh7d5g0PgP6y5KRxD3aC4Y90oxSxVw68ofvZiDqefRBXHKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736919937; x=1737006337; bh=TAXVIqrtVTHoNcTjvoaym4Q+djaS6mb416z
	A/pw7emA=; b=UWmprjKxf2iHIdjMVze2/OY984qnwAWKwyFFdeOGLDDDh9MPeiN
	qlD+7SfaicA9LOu3PJGjnavr+7nA//DLzI3rT+S1itiWyCPyzhthVPvJQ0mk7BPU
	lCqAl2bi6D1kmvqNNUdwVQ9kOESanVkRqH/dbjxQXYvAIYeutCyffutPTUMNwys/
	+3ncE33CTDaH5dg62d6iebtvDovEBepS//rNgGsSrquWRzWfu2yy6KY1pfmyQM9Q
	rNUd+WttSfvsw0nKYpRiWZ71kQE0Ai1uZtcqxJNz6DYEj9tfVcu6brFp9hysT83k
	xSRKpHJvC4mKlTKrmI1xxEY1XnFyskkmQcQ==
X-ME-Sender: <xms:gUuHZ39bv8KBAp6V4OTV3g8FWlOEziZrSR_bbLm8ivO15vnbtPnCkQ>
    <xme:gUuHZzsruJooIdt7HXZfLLF0jx-kFx6K1erNaYScH5LmNSfivrTiakBADIkMSZC5g
    kzN7m3e2Mot_oSwrQ>
X-ME-Received: <xmr:gUuHZ1DCBVOWC4cf0PuRUOCroWYQV_kQ0gOSuWgyN-Q-w_tF6m5bi08ikL9GjUDajKtr9NlK6rRhOZZQ8jimmQjxrV7pjAVRtlsFTpJtBC3Tchc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gUuHZzcIq0xeOFacjb6HQttivIpl2FwkOSWeQj6zWYIfglql3s135w>
    <xmx:gUuHZ8OtK89wHa0bSZVRLdmYKc2Ly8U9ZY6fyoZLa3T6ZktiqWpdEQ>
    <xmx:gUuHZ1nKYD6P6yzMt6FRLH9Hguj_fREjuvw-gOQEWIO-wEVTqd_8UQ>
    <xmx:gUuHZ2uvq69PzOXkpoSeX_l1ZRz5_PfayrjPuhnxClmudxa9dkh9sQ>
    <xmx:gUuHZ5qgfWuinZHQBX5g3zxhbNhzjHZcyFqOk_Fz6F3c1qexg2GyJsx4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 00:45:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b4c8446 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jan 2025 05:45:32 +0000 (UTC)
Date: Wed, 15 Jan 2025 06:45:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
Message-ID: <Z4dLeyF8N8PhYAZq@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <xmqqjzax2nqw.fsf@gitster.g>
 <xmqqa5bt2jc8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5bt2jc8.fsf@gitster.g>

On Tue, Jan 14, 2025 at 01:09:43PM -0800, Junio C Hamano wrote:
> One request.  You seem to have started using --full-index when
> generating the patches.  It is extremely annoying when a patch needs
> to be mucked with an editor to inspect why it does not apply and to
> tweak it to make it apply.  40-hex does not help at all if the base
> commit is not conveyed correctly, as the recipient will not have the
> necessary blob objects _anyway_.  And 40-hex is unnecessarily long
> in order to protect the recipient who uses "--3way" from using a
> wrong blob in a fake ancestor tree.  Please stop.

I have in fact started using b4, as it makes most of the tedious
housekeeping around patch series go away, and it indeed uses
`--full-index` to generate patches. There isn't any way to change that,
but I'll send a patch upstream that gives us an option to do so.

My last patches haven't gotten any feedback though, so let's see how it
goes.

Patrick
