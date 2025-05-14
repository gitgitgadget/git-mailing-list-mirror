Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B211E1DE9
	for <git@vger.kernel.org>; Wed, 14 May 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747190485; cv=none; b=cGgzmpcj4HnFud89tDmXB4jVyyarMtVjbhXbIhTJccTQrF7i4U2qgZQNF7jtEjhxASOH4ARTBsgctKanTe3RIs+AHZBCY8GNG4qFpOWCJhvqaEuoUEF92FPUlRoTbXoiX4AYpzhSWAzp0bUNfwZWvcUIwSCHqHUlJoRPJZUL7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747190485; c=relaxed/simple;
	bh=57AO81bfNT917LYSclrfbYnGO/o/fuVhAKPBvyuXeTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaSDQx07UN+Kys0JiwV/xWeizUXbRPpfVGb1PeJ5wF42OJWUtujpgPqzlh2fSZnvevGjrvYyaxMhvx5nI649xTqJpTYCzCzLf6FC5iK9m3yYhxZaUEwAhELwUkAnYK1IAOa7ucNZYht3EprXLPJVVSYfhro8xBmF8Ns/PHW2GOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CyXVha2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u+MFVazV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CyXVha2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+MFVazV"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 25C0613801EF;
	Tue, 13 May 2025 22:41:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 13 May 2025 22:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747190482; x=1747276882; bh=H3kTLi53YI
	GNR4WjDggkQHYuJt67xGEN4IThvNBQCT0=; b=CyXVha2TwxGcveXmocVo4DrSqp
	bh7U12n6rC+V+YQTo9o4vnI5oTYJSlO98/i0Cob5q7DAH9inXkVIQ6V2KJIw5cpH
	/BdplfUZsUlA6Tb5GsSwg1FMkTQuG+w12P9QDQkWdInjV7Nw5O11w/4aPXP3lmD9
	5bk2EhGiNw3p2B7/iUuuGzAEEF1tC5/sBDuwWfBTFp1jvIKFOAU/2QP9qxr/tVvI
	pclFnUS7KJ3g0uK48ajnCuOWDHXTEgu5TDPWIozKEHg23dXik1ZuYMlHxJ81uuI8
	c9Yi68DnrpCn5rJM1XInF2b5PcOuBm8l4H8ci8ZP3aPGgOxwbbkstxDPvVvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747190482; x=1747276882; bh=H3kTLi53YIGNR4WjDggkQHYuJt67xGEN4IT
	hvNBQCT0=; b=u+MFVazVyRFSPWXpwKu29MFTBFKjklpKZWwZtEGNl7uq3ljr4Kr
	Gm3jwy/myFn/YMTu0BN8Od2QGfv1O09u78YX642uzRkkNgz619baOH5rhtlrSHEr
	HpbQ1CzfFC2/O4kkaMUJSfP4eKK7EuLZDiqII+PzWACzSEcNjG/ocQQw3pXb/9wb
	ymW2WTyxXs7OftgLAUa19Rol51VRdqLUvxXtG871CbshxQEo4y23AoGdZkScixjW
	0Ptmn6oHykK3fkt7BqquE5eUt8njJcDcUi7Yo9c4LogFORNwF2k/v1iOBRx3CYgP
	6Px+m3EarD4E6cWNhTqwSCGiirsVoPeaAnA==
X-ME-Sender: <xms:0gIkaC9gL0CaqCLrWcuZL9qkdwVvm3AFPO5HRnPklTit3F7yYkfYgw>
    <xme:0gIkaCtK4JmrUO9DKdlpFWop79BThFWkjD4f9dVSojcza5taSGKV9HWOhISWDSGEw
    BWmraOFh03HXBky5g>
X-ME-Received: <xmr:0gIkaICOJqgUXlkKbOf99voDjrxpqpb-6NhYR3wVb7VRJ4KNkd9EQ0CUev0Gq5PeZPzvUDozia_0-IxQLeHuuRwd8_Gxjo3VoiSmc0Soob8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0gIkaKcYVd_xMXw2GlRcxoAGEubHqpNPuiiqcL2q_THiW1nq2Yn4FQ>
    <xmx:0gIkaHNNmVN9xF1kfcNhrNbnLjb3y71kh37nKKzzSunM5MFGLDKp9w>
    <xmx:0gIkaEnoxfR-_nLLaZip8KXlMRvq6P_7S8XBxaS8TexyJnnhqJtiOA>
    <xmx:0gIkaJsO3-p8ExKSYMEo9_0BMBCWuGUT0r7PvwVaVnqvAW-KfRGaJA>
    <xmx:0gIkaD4P1d6Wt29s-SZ4p07ZFQ6f1qTxeg2BhhBa55-qCtfQcbFJ4CFW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 22:41:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a89602a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 02:41:20 +0000 (UTC)
Date: Wed, 14 May 2025 04:41:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com
Subject: Re: [GSoC PATCH v2 1/2] json-writer: add docstrings to jw_* functions
Message-ID: <aCQCz_jl5WOdhiAa@pks.im>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
 <20250512020935.73140-2-lucasseikioshiro@gmail.com>
 <aCG2XkW2lJ1qYHKW@pks.im>
 <CBE59EF3-4C4D-4FD0-80E7-D9BAF70EFDAB@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBE59EF3-4C4D-4FD0-80E7-D9BAF70EFDAB@gmail.com>

On Tue, May 13, 2025 at 07:05:21PM -0300, Lucas Seiki Oshiro wrote:
> > void jw_object_begin(struct json_writer *jw, int pretty);
> > 
> > I think it would be interesting to learn _when_ to use this function. Is
> > it mandatory to call it? Can it be nested? Why is there no corresponding
> > `jw_object_end()`?
> > 
> >> void jw_array_begin(struct json_writer *jw, int pretty);
> > 
> > Same questions here.
> 
> A JSON can be a list or an object, composed by other lists or objects.
> Those functions, then, define if the current json_writer will output a
> list or an object.
> 
> Internal lists and objects are declared with
> jw_{array, object}_inline_begin_{array, object}, depending if we want
> to begin a list or an object and depending if we want to begin it
> inside a list or an object.
> 
> In all those cases, there's no need to jw_object_end or jw_array_end.
> jw_end covers both.
> 
> >> void jw_object_string(struct json_writer *jw, const char *key,
> >>      const char *value);
> > 
> > What happens when called after `jw_array_begin()`? Same question is true
> > for all the other `jw_object_*` functions.
> 
> It raises a bug: "json-writer: array: not in array

Okay. Information like this is very valuable context to have in the
per-function docs.

> > 
> >> void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
> >> 
> >> void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
> > 
> > Do these nest? E.g. can you call `inline_begin_object()` multiple times?
> 
> They are only tested up to the second nesting level. However, based
> on the source code it looks like they should.
> 
> json_writer has a stack. The *inline_begin* functions basically append { or
> [ to the buffer and to the stack.
> 
> Perhaps it would be a good idea to include a test for those cases?

That would certainly be welcome :)

Patrick
