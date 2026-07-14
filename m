Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4644223707
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000989; cv=none; b=DZwkklImiZu0uZ8y+VxKD6TjH0Febfbm4kKYqi6ZXP2C8aZ9UtMFA69qJjIePMFF1C1PeWnQD3DcFEG01UkSqBerPVnJ0PgnMTH5tuHhCRQFubd0I2bKCOu6iWYrHbOXhx3BNDVIgsBeyabhFkhMSpqu8qlPaTwAASv4kPVM9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000989; c=relaxed/simple;
	bh=jwd63HFBGgyKhy2YieT3WWTJ8N8R8/QrocP7+eM8HeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMA8yjgckOWC41astXbf7GjFAoODNqkeoggS0Y0GwsD194PCiw1D5ll71kGQa9mLp0qbqyJfHu8F4tcQ6fjr81HvyScmS/nsiw3O9adWpjNC4dq1Qi1PN9MdwNlnlvQE3mUKfFlorKOS/cRQC2B2AF1qg0drbbi4Ywl9CmEca1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=XYAIOTsS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="XYAIOTsS"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e53581361so259117585a.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784000987; x=1784605787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jwd63HFBGgyKhy2YieT3WWTJ8N8R8/QrocP7+eM8HeQ=;
        b=XYAIOTsSj2L7JEuCj+3DBnk16c8XiNzKMHj2k3WiZknbm1MOMzpJmMCU3gsY6ZrC4d
         NjA0BKaMMtzY8jGYDMCIeuqiu4fzafN9paUu9bpA9Nx8NXyWhMNgv6Y9tGRuLkoJoooq
         29DkCr+oM+zUz6+/7LqoPFqZkYTo3DCx5IoAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784000987; x=1784605787;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwd63HFBGgyKhy2YieT3WWTJ8N8R8/QrocP7+eM8HeQ=;
        b=Lp8/TlrMgEpU3s/GKp4CJ91AsMatXFkFlEb8rhpeXA47u70uGNSUO7cJTMjqbm3nDU
         rDmi7IYjBg9DxDXQfyZKXHl1GHMHOWu+7IP8vTRlCaEgYFLOd3pjK83ijWTbhd2H2/ns
         jMi/eNQEDkQxBVLAYnlI1vt0MnnucwmAJKLavjY+ayvC33wwa9m9pKD/aCvRm6cVuXz7
         yCzr0yX5PinWAPCXkBxItnMxknOXtIfZyKJOkSK2gBqqdOe2U7fjhnl8i7d/nXwjVtSL
         QBD7bOkEStSC9yPgk938AESGZeiFLzBNtazdtJ7RbLs0XvyijMTMcl6KFWAUenD/Y9xv
         EFiw==
X-Gm-Message-State: AOJu0YzlNI+ZBeWQdhA4YD/fwaNVOLlaqAtOJRU8E5md7dxIzLFd5cPj
	ZNRGUgUY9E2h5X6P6FEfkyRssHQ8EiT9kWgyVLx3jF9859wFLZm1i/aLWoErjKMRlv3PPZlBdjZ
	wTWKXgqcY4g==
X-Gm-Gg: AfdE7cksYDFAkGB1LWIC3lVe0YL6UtLfXTeqiLEajSTTBMxqG+pMzHoZQpxvJGwa1Ax
	Gzbm62izg54odpxAZ71oZlFrHN69m9EKzJlqSSK8GKdbVz2GHuNnYzo5zExYUBX633zYWAIltfN
	M18xb4nWgSFWowTS5HB6p8RBUeMr+Lo+1aEjgkSFJ0Hn/6bsSpLA6CMq2Fh6zzyZYJLYfbRxhPm
	vo0Mioke/aQ+b8XYP1kGIqDBvE0d9BRdUKD2FYoFL8jMj3yMSUu9EGDbsisHj4os3OG8RaqQ0Hz
	spGvITQOKfnLuRLY5nIU4XFwF6M2EiiMIBuUqjiybk/Sf5jVdRz11EIsW2ozi+sHiRYg71QQEsd
	2LZxA72UBpc/uPPLfcU17ceDVrQHN+SEuzZ4hgwvV4L2rFmEgSDERh93tfg/tbTI9FzCnzviC/U
	KfuZHaBCw93oXZhzC6ljytREB6
X-Received: by 2002:a05:620a:199f:b0:915:673a:617b with SMTP id af79cd13be357-92ef2b533a8mr1213443785a.24.1784000986528;
        Mon, 13 Jul 2026 20:49:46 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9063df4319asm51579516d6.38.2026.07.13.20.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:49:46 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:49:43 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] odb/source-packed: improve lookup when
 enumerating objects
Message-ID: <alWx1wj1bc48g11X@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-1-3710a9cc165a@pks.im>
 <alFxRvkfNgJRCQTB@com-79390>
 <alS1440iifvTvGKP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alS1440iifvTvGKP@pks.im>

On Mon, Jul 13, 2026 at 11:54:43AM +0200, Patrick Steinhardt wrote:
> On Fri, Jul 10, 2026 at 03:25:10PM -0700, Taylor Blau wrote:
> > On Fri, Jul 10, 2026 at 10:48:53AM +0200, Patrick Steinhardt wrote:
> > > Fix the issue by using `packed_object_info()` directly.
> >
> > What you wrote here makes sense to me insofar as I understand the
> > pluggable ODB code.
> >
> > However, I am confused by the way this function is written in general.
> > We use `bsearch_one_midx()` to locate the first possible MIDX position
> > in which an object matching the given prefix may exist, which is
> > sensible. However, we go from that position up to "num", where "num" is
> > the total number of objects in the MIDX!
> >
> > Functionally this is not incorrect as we will happily discard objects
> > that do not match the prefix. But it causes us to waste CPU cycles
> > repeatedly calling `match_hash()` (at least for the first byte of the
> > prefix) for objects that we know will match.
>
> That's not quite true though, as we abort iteration as soon as
> `match_hash()` tells us that the prefix doesn't match anymore.

Right, we neither iterate through more objects than necessary once we
know that `match_hash()` will stop returning true, nor do we emit
objects that don't actually match the prefix.

What I was trying to say above is that in the special case where our
prefix is a single byte long, we don't have to call `match_hash()` at
*all*, since we can enumerate just the portion of the fanout for that
specific byte, and we know that all such entries will match.

> Or do you mean that `num` should only be `m->num_objects` instead of
> also iterating through `num_objects_in_base`? I have to admit that I'm
> alwas struggling with the chained MIDX. It's never quite clear to me
> whether a given function cares about the complete chain or whether it
> really only cares about a single MIDX.

If the goal is to yield all such objects that match the prefix, then we
need to enumerate each layer. The analogy that I have had in my head
while working on these is that they are the same conceptually as the
incremental commit-graph format.

Thanks,
Taylor
