Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866B175A73
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218487; cv=none; b=Aa3y76vbY+1dbjYfl/2v0AFQk+nRVDVouLVKVkaHULlp8gxTqqIArUMVceH8kusoF3LeO5QwZY7AGdVX2x0FSik1U4XPw6yoCoIc8USK7ZlbKI2EfUH9nOsIXlOcIFoo2QLVLPiWXV+qt8oBaq41T+EA/RBlz+POvFjLk+u8u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218487; c=relaxed/simple;
	bh=4vUzUMc63nceGGVbp4mANhNVb/U2iL5HhPyVQ+yY/+c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gH0qDwHx1mRKJZbVVY7Fwf0J5qxjnkOJta1NfSjKo6KRMoGLNotGfs8JlR8Jly4X8SfzOpzWiMMDeJAqNv0pCFdZ70+GLgaHlFgtCe9vBPLEEM2D+SPpOsJHpJ6FK22yMnpZEdhjVcLQberkY7vo1e1XDicBju1rTJuyd6J+d1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RN6h0q9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQD8Jc7i; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RN6h0q9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQD8Jc7i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 77ED71D001A1;
	Wed, 11 Mar 2026 04:41:24 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 04:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773218484;
	 x=1773304884; bh=3fGtp719zcYnzZVzJG87BpuXlZv9ygOGVraShPtIJ+o=; b=
	RN6h0q9csEAM654pu9PIHsz83yjbaTo/iDDCF4GToNhZwFCtl1zuXUE7Vcj7JLO7
	zPCfrA5E5u1wXGjDAb36V9432G+BMzFV94Jg3eVtsIygb/onmV1/zMO1djNMFiAK
	vvTr5i1wO4zBUdRVMfprH9MmLJ1KhlbqQjib6px1Gzpn2kZzlSL2C03b9b503+Ut
	P0d2RK+iiU8BkLE1YqrdUDacvZZMK6afwd/PqYYg9+fd5nYbLXRo0c2LPPDyX2R5
	Hk1MvmbBq2pGh3NwBcsl/V10vC1ie1mWUA85zqaMA+T60nyOtKZcICv7h6ZcrdxP
	mOEvLLLUJPtsW1iWJ9J4cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773218484; x=
	1773304884; bh=3fGtp719zcYnzZVzJG87BpuXlZv9ygOGVraShPtIJ+o=; b=g
	QD8Jc7iCY33PlRvgshc/QHeuiGV9IyuDiZkQeXCYvRhRSOT1nHOLWoDQbzawNRPV
	dBM+UETw4CaLildJ6cBKCpnaC1b/JcUUPnu5wiUt/0WAyfLOLka/rTjUwdr0FswO
	8YpZuc9EXehGWrqs8GdmNJKAsRzXeUaXwxtbfHH4McB26zCBUcvzZnmHpxhzyWbl
	GkUkX5+JictcjO324L5IhsRpsFzgHcfjGbPJjxUsU7F1JEt02SPrWQevL8Ng7Ey6
	eYTA9YITdbw+TVJAv4SI/egA6s+3g6Na5IAKf2U8dwo+kmaf+5ePAdOIi+XmRve3
	PnrfiMXH0j4l7AQKMcaNQ==
X-ME-Sender: <xms:tCqxaWjft8CKpZ_ThGuCQiKLgEvI9N-bXCYqu_G9uN52SLWz7Oh4eS4>
    <xme:tCqxaR1jcEAbQJYSXNdQmIxeGW4iY-RyML5r7zgUFQMHy9mO5IZzKMWRi6tNJ19Xn
    PcCkgURemjn691-78PDVRkAOs93dvrocuGcKCca5GM7JXLIlHYHng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tCqxaX_rUufjqJiPXgAsDY4ZuRlTDyQmbWUwHuMTvE2zEf2YtmFKlA>
    <xmx:tCqxabfiwCHIZXWdtmcybm6u3_iutJqoppOycP6f3r7PbuHYbIUG-g>
    <xmx:tCqxaYFt5sc5rTp0m2YQ2uGIgQ7zh5tdre5S9cuIyWNJPCqvdwL3zg>
    <xmx:tCqxaRcH_P6WCcSI5TH1jYBJAuoYnzW-h-HWiesO1u-70G5Fevk4AA>
    <xmx:tCqxadcexmFNeBz8RwTu3nJWZy2QMmBdIJTZEjs94V5jAtZ5GDBxaJCB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 30BC61EA006B; Wed, 11 Mar 2026 04:41:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aye3URkR62QV
Date: Wed, 11 Mar 2026 09:41:03 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, gitgitgadget@gmail.com
Cc: "Michael Montalbo" <mmontalbo@gmail.com>
Message-Id: <e551ce17-8118-4b3b-ad8c-bdfe1a854c0b@app.fastmail.com>
In-Reply-To: 
 <0d3e84a088ec53368a748684268db89064632871.1772845338.git.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
 <0d3e84a088ec53368a748684268db89064632871.1772845338.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 4/4] doc: note that -L supports patch formatting and pickaxe
 options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026, at 02:02, Michael Montalbo via GitGitGadget wrote:
> From: Michael Montalbo <mmontalbo@gmail.com>
>
> Now that -L output flows through the standard diff pipeline,
> document that patch formatting options like --word-diff,
> --color-moved, --no-prefix, whitespace handling (-w, -b),
> and pickaxe options (-S, -G) are supported.
>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>  Documentation/line-range-options.adoc | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/line-range-options.adoc
> b/Documentation/line-range-options.adoc
> index c44ba05320..aa236281b3 100644
> --- a/Documentation/line-range-options.adoc
> +++ b/Documentation/line-range-options.adoc
> @@ -11,5 +11,9 @@
>  	Patch output can be suppressed using `--no-patch`, but other diff
> formats
>  	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary=
`,
>  	`--name-only`, `--name-status`, `--check`) are not currently
> implemented.
> ++
> +	Patch formatting options such as `--word-diff`, `--color-moved`,
> +	`--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
> +	as are pickaxe options (`-S`, `-G`).

You shouldn=E2=80=99t use indentation here. This is a code block now.

Just a line continuation and flush to the left.

>  +
>  include::line-range-format.adoc[]
> --
> gitgitgadget
