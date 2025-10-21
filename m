Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70A722579E
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032493; cv=none; b=gQrtB7hop/g2kWvmkQvUormdIPdW69yUYgywXSfVGEvA5AzA+2tq55A8ctFMjQOa+i+ivmYIuazehDP/T2inFwbgcvb8bbdtiT7O2W5SCRVrML1wmQcNt68P5LiQzb6Ki0IM9qfajMgHcOl3JZ45J0AGI3lLkDbFJBPjyih9iIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032493; c=relaxed/simple;
	bh=xgRU2TyrJ2NkQ7TdY4aPo9n2LBgchwjFJJYwcjijtWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rko+H+/RQRWX3CNrqCNccBjAfke6NxosNG5m76Am1N94GVPxfU1WkcLe29Gy8zThL+ZxYqileOumCCNMn4QXyxbK/T1DDGnz/NTrhXJWdWsj8z2kwSSYWgDVEz/SayupJkDPgSDlOUSVjhXTeaXtZWgR3RPbR2Mc9J1rtWxJ+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VeDYi78u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=opDszvhg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VeDYi78u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="opDszvhg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CF466EC0014;
	Tue, 21 Oct 2025 03:41:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 03:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032490; x=1761118890; bh=J+UH22JuNj
	py9FaPAjbUR+58b71pzmBuRtmD0K2cmOA=; b=VeDYi78uBFaSmbHDv3A3+fmex4
	vdFQzLM56XhlkpsNXrfX3Z6RVWMMmInNd/CSN33PsU2M+AhTVtKWSdFSnVtAaChT
	d1kUAeNKfMmkLSaKklyzl/hzoff9ydyg6XeS0xOa64qBbeFTxbXDDXf5IRhiY4Zl
	mcLWQdOZ7Otk9OI0gcaoNx4R6pnhYvmIb4n7bF06/PdtgVKPD+sZL4C/pUcG+BkV
	hqMVvSjpITLGmyIzdCKW1E4FXwTQgIgaCgOarsE2Qn44lucjSEFuojzg6qWvvL0R
	b7Vsuk3ZvsRduK8EjDhLylwSKv86es2SmOCm+6PXsT9jBeTFChcwY+FIpHpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032490; x=1761118890; bh=J+UH22JuNjpy9FaPAjbUR+58b71pzmBuRtm
	D0K2cmOA=; b=opDszvhgzk36BiGtBx77uL/gorjTULgIq3EWbsfViwhmqpL0y7r
	NYbTXmWCDzZh1Sbp7anFfprWnci15CAVU1UZSyYjJHTd2WIo1iF2+CBypnsjmbyE
	Pz6hWktm/SM4w19UN8Ce6Z3wGidDXU6ud2kulPTh5NxXSjQ9Zp0IKcBnTWkSDW7D
	6zkCvOOndAgBeio3wEkXT5WjMZsbdVGSLTZOuKly7ISVbtQctdKAn4NC0p90cRDk
	R+qhicZN0qh9APfsCNskYIj2Z1/njcqu/Lxd7Nxl7xDv5Px73tXbbLtcHNGrrGy9
	k7Jhfq9XFhfVyQJ/A7YXcXIY1xfmIGNQ78Q==
X-ME-Sender: <xms:Kjn3aLDF-TuivuhGBdbwr3uY6_bNZh7mv1qwpMUbwacffGxmT--IOQ>
    <xme:Kjn3aEEs6QFXN9QgKthISddmnEXh9o8gcomt6laMV_uw1qqwEZGPN0EM3V1aH8jSX
    WI5QOqzVDZew5bUiA_cI7xuFYL1rTXms5jPbkjpcVdyDiOahgwlmw>
X-ME-Received: <xmr:Kjn3aKMSFP8-hI8nNVEeiHxtwozg20zvCAYZ_AqI0XE9fo-AEMVGJ5zTUpaIUcCtd8NTqbEu6NOoUUaf0KunzkiNR_li9oWxVQGEAQGo_FfOoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgurghmrgiiihhosehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:Kjn3aN4WGzqEfytm5qqwFn7Je7zGUTG8vgUpCa-Oip4GtVRe-iwQpA>
    <xmx:Kjn3aFhgPC57OOGTdyAwKrPutwca95kvGStGjnpCMWWlmbVowAyhrg>
    <xmx:Kjn3aKfLBSGJKYCViG-qAsWQR4NDB8p_-g-hIG_cjc-p7Mm2OI2J7Q>
    <xmx:Kjn3aFy8ap010G9-XNgVrK0v-Ca1qrcfpJ6kn0E8CjXYnNwX_Ia4vQ>
    <xmx:Kjn3aCELcXIYox2O5rEKg-vovVfy7jvJGnPGcg3pCR2s909-TulvJMFj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:41:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f77bb1bd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:41:28 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:41:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 07/10] run-command: allow capturing of collated output
Message-ID: <aPc5JTxw5uVHEyjH@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-8-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-8-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:41PM +0300, Adrian Ratiu wrote:
> diff --git a/run-command.h b/run-command.h
> index e536ed7544..2c2484478b 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -436,6 +436,20 @@ typedef int (*feed_pipe_fn)(int child_in,
>  				void *pp_cb,
>  				void *pp_task_cb);
>  
> +/**
> + * If this callback is provided, instead of collating process output to stderr,
> + * they will be collated into a new pipe. consume_sideband_fn will be called
> + * repeatedly. When output is available on that pipe, it will be contained in
> + * 'output'. But it will be called with an empty 'output' too, to allow for
> + * keepalives or similar operations if necessary.
> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel.
> + *
> + * Since this callback is provided with the collated output, no task cookie is
> + * provided.
> + */
> +typedef void (*consume_sideband_fn)(struct strbuf *output, void *pp_cb);

I think the interface overall makes sense, but isn't the wording we use
here very specific for hooks?

Taking a step back, what this thing seems to do is to take the hook's
output and customize how exactly we handle this. That isn't really
specific to any kind of "sideband", even though our use case in the hook
code does use this for sidebands.

So maybe we should call this `consume_output_fn` and adapt the rest of
the code accordingly? Because that's what we ultimately do here, IIUC.

Patrick
