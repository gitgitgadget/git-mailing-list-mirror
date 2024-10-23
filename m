Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E530130E58
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664232; cv=none; b=QEFeCm2cG8R0pdTAom8KkLeiJkLSTPFaRgZ7ixYgARDcRkRm1wvWGCdQzxs/dkpoEWvQY/5ueGRLOPhzQIQoeaaE6W8K4507SevRRHFfT44PSwZvHsUBJ/qb05KgUKDSqs2qdc6VvGGOh1RwiAA9lIN49ylUAydN05+FVgUQDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664232; c=relaxed/simple;
	bh=dbswdbMTB85hwleP4FcaPv9a1uZ6cDkU85KoDGPNwOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thCPqGbs/q28O5C7Yyn+MwP9QDWnOr2FXkJ1sipm2PGKu7YoniOOMGfzRcZjxZkTqWMlHPSeVbuIxE1h1t1AZv7IBu1pS0/UoAbhgYa0yvKpm6CAkGIlXKfhfsgtgvXMi7elobqAlYCwZHufycy/XnFCAStYi9Ks6cdibq9OUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HcPVvrco; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNG9PFen; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HcPVvrco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNG9PFen"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 95684138028D;
	Wed, 23 Oct 2024 02:17:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 23 Oct 2024 02:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729664229; x=1729750629; bh=TmiJkiIfj7
	NGPQstv7F1/hMZqqHlXqexvIEBn9y0QOM=; b=HcPVvrcow5HNgAjzoovbC+6pyO
	kHi7vzuLZ+v6mB6qpTjxm+H1jeJHnX0i+rh0TFs+QjxAwjgPJ2vHM5LHBAX5Jkfy
	kSDh1XZi3OvkuqWh9SXtMU5zvtDRebzxqRlqVw/d9SeG32KiEBKL/6lb80KxcpZr
	SHCxzDm1UtgSC/sK3loC/EYla0N/tjlUnC/35VaP6vVnFDVCeO7/CnfPG88QTFaN
	th6E84BZt/5K5OtV3B6tUUyJpAyfl1rmLNA/zpeZzMjvuc5n3OjVUL2wZXv6jh02
	15WaS4yHN5mcDXmsn0XvYPW45mTyWqKedWg8G7vW7WDvfyQmDIrit8Vxa9qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729664229; x=1729750629; bh=TmiJkiIfj7NGPQstv7F1/hMZqqHl
	XqexvIEBn9y0QOM=; b=lNG9PFenlLz3L/+8WkWMvH36VPbO2n1NTEEcM9x7xSFL
	AuVm6TnUd+/r1DT8vdaXgcF8fQ7n6EU59ZTImHiIEOlcmoCw6k7GunMhW+hBTcJt
	E5AvOjwc8ikONwfsMDfrIrRMmVWud/hatmAmEkyhwAmqS1I7K4vK7sGqhUEPjUzV
	FllvS5mus0zc2QwQJHTWiw8Gppdogb+zVddPHQDd0rtGGYk5XsGpR+fNGEcn0sec
	hhlMGZ6iDyjYXaZ4NtKZ8obM6vdyR8s9END46I/2l0FEX/oTbm0o8xk8U2uEZbt8
	Qe+hhGgNBACfMMKBcQTxuz7DdtkfKwjP/spBe7tsLg==
X-ME-Sender: <xms:5ZQYZ1qWFmB4DpVv1FUeK0zUi4VJml_OP6EsapHlNT0ZH7r4Z_ajSQ>
    <xme:5ZQYZ3r8oCND6T3aJpyNSV3Wlh6gCVstud6Z4toqJ076wJsh52FMNwRz07iaFfYpu
    82a10YqrjkHEuPftQ>
X-ME-Received: <xmr:5ZQYZyN0OVJa8vOy--pEajJCEn9Wh_AQrpoUxQBxH_kh7o81tzQDIlugzFHwobPhoXtnEaZjHMVvv5aJQ49-F7p_4ev68lQ7POuxPB8oBRdh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeiiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheevhedvfe
    eljedtfedtheduvdffueevhfdvjeethfeiieelhfeffefhhfefheehnecuffhomhgrihhn
    pehgohdrshgrpdifvghllhdrshhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5ZQYZw5R9U8Od_NX8jbeti6Al71pqoy2qlLints25lquqP72UlVgdQ>
    <xmx:5ZQYZ07bcYuGStDxzAfXTuTxLNH4G8sVvB-3mCCzzoDfENp0pwy2ug>
    <xmx:5ZQYZ4gQUfsRhV1tkHjVrAa4OFFQty5soOznCCuiUjAcYbOrNFfxYQ>
    <xmx:5ZQYZ27LW3bd0ECslWwha3Bc6nqWxpMWC9gLqJAzkzCcHpLeVlEEog>
    <xmx:5ZQYZ0HE85GMB8bevn1ozQtmB7a-frb3O3GKORP8cnuRIhFXUrLug-Nt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 02:17:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3aa4ca7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 06:15:34 +0000 (UTC)
Date: Wed, 23 Oct 2024 08:17:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #10; Tue, 22)
Message-ID: <ZxiU1mw1mbRaxoRO@pks.im>
References: <ZxgUocb5gH+zuKRw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxgUocb5gH+zuKRw@nand.local>

On Tue, Oct 22, 2024 at 05:09:53PM -0400, Taylor Blau wrote:
> * rj/cygwin-exit (2024-10-18) 1 commit
>  - credential-cache: treat ECONNABORTED like ECONNRESET
> 
>  Treat ECONNABORTED the same as ECONNRESET in 'git credential-cache' to
>  work around a possible Cygwin regression. This resolves a race condition
>  caused by changes in Cygwin's handling of socket closures, allowing the
>  client to exit cleanly when encountering ECONNABORTED.
> 
>  Will merge to 'next'?
>  source: <20241018052952.GE2408674@coredump.intra.peff.net>

I think this one should be ready to go.

> * sa/notes-edit (2024-10-21) 1 commit
>  - notes: teach the -e option to edit messages in editor
> 
>  Teach 'git notes add' and 'git notes append' a new '-e' flag,
>  instructing them to open the note in $GIT_EDITOR before saving.
> 
>  Needs review.
>  source: <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>

I've just reviewed this and think that the topic is ready to go, as
well.

> * ss/duplicate-typos (2024-10-21) 1 commit
>  - global: Fix duplicate word typos
> 
>  Typofixes.
> 
>  Will merge to 'next'?
>  source: <6ce47185-690d-415e-95c9-06a3b828be29e@cs-ware.de>

Looks ready to me.

Patrick
