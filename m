Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207236C0BA
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925714; cv=none; b=Zwi+l/R+oFfEzOi6BKIEAnoP8WDcVITp8/6BtCXvoaspRfTQm4RaqjrMFAo4No83Oz0gQexryewVas7tSMQWUX/FUa3JR25iykpINOKP0tI1k+gu4d9mbW4GxQyQxnkJ5j76xtQHTopfjFE1FwSZO+2JG7nT2RTfH8PEB09hoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925714; c=relaxed/simple;
	bh=PyHJJXRnVW8cBhBrG+Z+zz9bW1U0KGvSFqH4XQH49M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbjHxIY9bGn2z6l+3YWhZR4flALaeAQqp7nb8tFuKpD+HszBT1M224HhBy7L0mS/gyNMyvn92dDHz6Tmi/dFDFYISBMgE8TCaeyNZO40m5/1a0zwcoGpwECm9tVSyO9ygvLWH/IQWVdKbN4HkU7s0WCHwpp4YIPiiHkNlQOoDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hcdLU/yv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqqXN3Xh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hcdLU/yv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqqXN3Xh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 42FF9EC05BF;
	Tue, 24 Feb 2026 04:35:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 04:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771925712; x=1772012112; bh=d75BOIVKMz
	mAFRgPa/yGlnfE6jx2kPGg5Wol7sxGTAo=; b=hcdLU/yvzlYlPT+x3+dIFjQ76K
	RCjVyvvAG+Q3Qg4wf/R0OnXQ6JfldIAUcrLyFOQTY08dfv06dJJKfBwrB9mGIzVD
	B/xC35MhZd6Pngktin4D7RWjcbJ34haubOJ65Gl1kuBN7jlRV7jT3i5w1mU+RJ8W
	/j3OyV2cx1s6KGnuBt0UgvS3ZOqV0RZ2SCH84qv50ap+3vjfWKMew5apfrcATnQC
	0qEL5iXtxe83VHNoDr2T0w6p6jmMOpl+BsOBqzbs234xGAyUkI7SjzgyK+adW2zI
	tBfwPAU7NhcV4NSKVQSxM0XLl1MWzYQQBpumhvDlfVP8+thJGE6T5Kor/wEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771925712; x=1772012112; bh=d75BOIVKMzmAFRgPa/yGlnfE6jx2kPGg5Wo
	l7sxGTAo=; b=PqqXN3XhKSZvBrHHNyBXDv1TqLaMUWpUPTIoAYkV5IPoWXijRJz
	9l+8Q0ZGecR0mAFMcNGySDEMpyBLS62AZefzXiodrNB/6uhAEylRw4miys6TbIs4
	IXP3cNI4INkb9wEWp/NS+ecPzX0UV6GjRfokUskMe2DrQXzcjFFdB6K05G0bGmWf
	HV7R4PUSuulItzX9iLS1VmMOJ4jFiXYPqJFq0/i8sqBlEzcbbK4UPdv602ymYdYA
	Pz1ZY6ov8mhri+/FLtLFAIz6ykvkGEmaTTOzY9j1jCGKvpXwuPsA88FswcjKl9ht
	bfhaNHq1y8stzs52siu9hhr+BVxClGvADvQ==
X-ME-Sender: <xms:0HCdaX2TovgYPTpeB4PKa9LS4kIPTMa1AqTs-K8EtXJupTzha01S5A>
    <xme:0HCdac8AJGYA3BkEPwFxdiFF8EgsR7O4yA4uj_Q5abWIeOHGKqHvOZaX8UJAakmCM
    W8vjDDI5HaOA6Mw6bRWR8w55Zce0bJIRcaBuJ5cATXFMNHAazEnwQ>
X-ME-Received: <xmr:0HCdaQPl9LkMvRRtQ2YmC6UEa2tWuKwAp2yfpHEaialCYK7ZCoopGe_YZSRs19gRB0ODiyb4bokLVrv22MjxbdvvIV6HkXQrrQ2ERQrahsnKkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvghslhgrmhdrrhgvuggrrdguihhvsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:0HCdaYdea3Eiz6YMLCTSgz1sW-pcraJ-RB_TdD2Rg15zVhdSaXaTTg>
    <xmx:0HCdaXVGLi1agtY2ft8NSPa_AMvLjJBI17sR3FoNfwjD7z9fa_LJ7Q>
    <xmx:0HCdaYh32T3Vnq7-k48nYcScesEhK0pRuBMmFVz2witqzX5ASe9Kjw>
    <xmx:0HCdae9clS4b8iwiaQ7TIlS7PP0lzNtiuA79iYTbarADD6RXsJdRiQ>
    <xmx:0HCdaXuPF8CkBIsEXVAh1evOUBfEFB4-2OygEJfFdu4_Z6k72vyeClGw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 04:35:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdf7f7cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 09:35:10 +0000 (UTC)
Date: Tue, 24 Feb 2026 10:35:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com, eslam.reda.div@gmail.com
Subject: Re: [PATCH v2 0/5] builtin/repo: include largest object information
Message-ID: <aZ1wy55xSaAOye49@pks.im>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223174120.2356504-1-jltobler@gmail.com>

On Mon, Feb 23, 2026 at 11:41:15AM -0600, Justin Tobler wrote:
> Range-diff against v1:
> 1:  94a44e0e0f = 1:  94a44e0e0f builtin/repo: update stats for each object
> 2:  92dbf34f2c = 2:  92dbf34f2c builtin/repo: collect largest inflated objects
> 3:  1811d03afe ! 3:  1457d5d59c builtin/repo: add OID annotations to table output
>     @@ builtin/repo.c: static void stats_table_vaddf(struct stats_table *table,
>      +		entry->index = table->annotations.nr + 1;
>      +		strbuf_addf(&buf, "[%" PRIuMAX "] %s", (uintmax_t)entry->index,
>      +			    oid_to_hex(entry->oid));
>     -+		string_list_append(&table->annotations, buf.buf);
>     ++		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NULL));
>      +	}
>       	if (entry->value) {
>       		int value_width = utf8_strwidth(entry->value);
> 4:  471d352cc1 = 4:  f4e92e3f09 builtin/repo: find commit with most parents
> 5:  7f1b7f9657 = 5:  af404fcc6c builtin/repo: find tree with most entries

Thanks, this addresses my only comment I had on the first version.

Patrick
