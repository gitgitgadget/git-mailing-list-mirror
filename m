Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D28F5B
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497124; cv=none; b=BWmyUctE7V4x6rsxe1i20VLQQ/EoMJc5FvyoNfItnc8IhtxbUdCGaM3DKYNuEY3X4EjTfINHnSqQNIDxbt3FK1AGn1jDocLVDmwSdf/zCDPhsyfMFeiXiqrV48Ofh8Onk7KMXBSpVYzDjvxfmjwoJV9Kd2toPn9u9vuyM+Lm+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497124; c=relaxed/simple;
	bh=v9fCH49btCjmHc/37f8GhYhUb1lG+khIhuasfX+Y6pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDen+GnG1W++hM5wLHqstqA88sFEgcu9/A6FgOtSrrUnrJqx39/FymDNvqWExd505xvLHV5+sxbbnSU7h1lqkgDKOyG7Dv12bmwOP8HtsCqVDAjo0zm/tHz4XiQl2QxbX6b+KLCOhK94i1qhCON7P/4fYljriIa6UO6zExYpFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZFPYi8RN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kg37WjCX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZFPYi8RN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kg37WjCX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 072AFEC0217;
	Tue, 27 Jan 2026 01:58:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 27 Jan 2026 01:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769497122; x=1769583522; bh=RzMVZA+v9Q
	bTIHdtbXpseF08yz+uyUdJ1VZnUt8PSno=; b=ZFPYi8RNKb6A3uzlUcRRSEg1/g
	X7b11jouS6oVlUL8VHurD0XAJfySnXOTfOYk/OBPbbpRxr/JSd8ejqIFtmdxe1xY
	BJ8a4SMv/ivtIhoZI19BKSc4YKtAfPiz0m7eDZK3hndZHkN3p9lGA8gRIBx7MzwK
	gbwkT7HlpzT6o1ONxa+xup64qV+0hAD2Ji5kVXMrjqfKdKL7CjjX+/ZHTTPLOokL
	u+xvme52xob7x4dJ7lrZNDfHKJvZH2QBQWoNcSKybcJG3+cB/kh7IwBiDQ3ZSGLM
	ZG9tBCnfHoMCcBknqefUzgDuO5JL2c6RM5V8EIY/Ah8D7oebNlvbKG0cPnHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769497122; x=1769583522; bh=RzMVZA+v9QbTIHdtbXpseF08yz+uyUdJ1VZ
	nUt8PSno=; b=Kg37WjCXGrY+Xtvp5FwAI/RsgXjRENHxbFVgFuI5v/Nmdz1ve7+
	vX/IW6PRsxXEHt3UZqsbNXp0erN106Mj1gn+KrotKA2Jxbk0xBNVazgeM6XF1stP
	BZzsRay3Mh+7Q9+U1vSFnySiCC/BVmN/zkgqoX4X7599RR+w16GQbN2958HiEWE6
	6WfSu4z2KykCy27Uo8hBz3kiBzYs5egrW/YcYUnXabO/8I4nx5GhSCkKUlKrTgr4
	jSILWCeGtxBuD2Kw1D+dHE2lDHXYBbGOtLDjDu8mqkAE07vcG9pstcBzCeZQwVXO
	8isPIHIbbgjc1RzjHIB7SQXfGZ0ehxnsq9w==
X-ME-Sender: <xms:IWJ4aVIEx4zuvOxoYpBjkuJGgQQN05HmuYuQccswKWOakhrTi8V5eA>
    <xme:IWJ4aYBpY_HHsVFkfgFEkV3yrRsq6IM8mGLG5XTF4AmBrGtaGfh19iMLU9fpJslgz
    hJWhTEVFa5pIlVIHvIh6ieny8g0-K3x9OH2Ixf2oSFti1FfzmE7jCI>
X-ME-Received: <xmr:IWJ4aWB-L_3BDNRPYnfsbA2bxXWqlMeDov8pF41hH__hejYRlTBB2YlmCOIrPc1GMv0ZbWBvGeiJKwcUu5q_Pv2e-xBOmUFC-OuOSF5ARXbj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrvhhilhgrrdhjnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    eplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IWJ4aSA55L5a2ofB72RRaHgKFtyUfwjsySENmdKWC3an80plnJeMnQ>
    <xmx:IWJ4aZrPFPE4S_INWosfVKNuILAC9m54SM3dxFE4Okk1UhtwDw2_1Q>
    <xmx:IWJ4aUkaVUoMQBlT8uwrfMot-wGsDXkTSWI59nfsrhLj3MX3J4hl_Q>
    <xmx:IWJ4aRwPX_veMiNmijw4nNMv01AsZj8GewWoR1WgKSt9T5aTwBaATQ>
    <xmx:ImJ4aVRD-T4rTPLpyAAxvwOgS4N6xZ0VSS8RIMTAxpOlUprGujGpLjU4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 01:58:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20d39bf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 06:58:39 +0000 (UTC)
Date: Tue, 27 Jan 2026 07:58:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	avila.jn@gmail.com
Subject: Re: [PATCH v5 1/2] repo: rename "keyvalue" to "lines"
Message-ID: <aXhiHAFNFxgsXa0S@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123164900.35092-2-lucasseikioshiro@gmail.com>

On Fri, Jan 23, 2026 at 01:34:53PM -0300, Lucas Seiki Oshiro wrote:
> The output format name "keyvalue" isn't so descriptive. Rename it to
> "lines", since it describes better the syntax of the output format and
> it isn't tied to key-value pairs.

I think this commit message is a bit hand-wavy. Most importantly, the
reader might wonder _why_ it isn't so descriptive, and why these
concerns are strong enough to change the accepted value now.

I would've written something like the following:

    Both subcommands in git-repo(1) accept the "keyvalue" format. This
    format is newline-delimited, where the key is separated from the
    value with an equals sign.

    The name of this option is suboptimal though, as it is both too
    limiting while at the same time not really indicating what it
    actually does:

      - There is no mention of the format being newline-delimited, which
        is the key differentiator to the "nul" format.

      - Both "nul" and "keyvalue" have a key and a value, so the latter
        is not exactly giving any hint what makes it so special.

      - "keyvalue" requires there to be, well, a key and a value, but we
        want to add additional output that is only going to be newline
        delimited.

    Taken together, "keyvalue" is kind of a bad name for this output
    format.

    Luckily, the git-repo(1) command is still rather new and marked as
    experimental, so things aren't cast into stone yet. Rename the
    format to "lines" instead to better indicate that the major
    difference is that we'll get newline-delimited output. This new name
    will also be a better fit for a subsequent extension in git-repo(1).

Please feel free to use this message or parts of it if you plan to
reroll.

I was also briefly wondering whether it would make sense to call the new
format "newlines" instead of "lines", but I'm not feeling strongly about
this in any way.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 0ea045abc1..4031612bc8 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -26,7 +26,7 @@ typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
>  
>  enum output_format {
>  	FORMAT_TABLE,
> -	FORMAT_KEYVALUE,
> +	FORMAT_LINES,
>  	FORMAT_NUL_TERMINATED,
>  };

This feels a bit unbalanced to me, as `FORMAT_LINES` and
`FORMAT_NUL_TERMINATED` look so different from one another. Maybe it
would be better to call it `FORMAT_NEWLINE_TERMINATED`?

Patrick
