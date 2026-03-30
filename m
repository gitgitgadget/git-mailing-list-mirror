Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6032BF44
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882618; cv=none; b=Z46Sm2NmXJn6d6muDUuOtsc50WUxA72ge5/GjaAMKDgqxR89ah661J0bG/jopJvRUxguCkmbnQaCgE3FoEmzuacvmNS95x8Nr4cBrTbtj8933dzPDhUvCiFS4fy/p6FUaoehjm75FLbVwQ+hAlJHjKOYzZ6SJwOIi+a5wX/MVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882618; c=relaxed/simple;
	bh=2ItA6xGTUb9n+3XyPYhgmT0Yxo9DdE2ie8GwH1dvNmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VA62XBvu9Ryyr+Gm8grLFIPj2ehzTB1q+IaQRQHycWCONUkin+QSyo1Mb8SnUzUDyGz6sCceCpF04LasR6TrY1vOZzvftRBxoKZqGUl+NRmmXr+q5On7lxRLrayzoDJuGFN4L/17ecNsKTE5aIa+nU3chTWPrbkHDsD/wboBys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HE8CS3EW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyZc8Xpj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HE8CS3EW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyZc8Xpj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 10EEB1D0007E;
	Mon, 30 Mar 2026 10:56:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 30 Mar 2026 10:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774882615; x=1774969015; bh=ias1i+RgnM
	FDQQ/b0cUv8lCOi2B1Xe+CsP62dhbCm6w=; b=HE8CS3EWXaM1w9Jrq6o//5zqXt
	b6SOTV/K2Aqiqgb+08VntXTOMAMhuaPXrvDxzwYfgTwhi5AzBShlmJBqustKIPDJ
	gvQof+WTrpznv6PxEJNyKjwenb4IDZMcQ5uOCUOkdP077dlomb6sJNq+apQFAb3k
	7GnuGiE1kMf30LKvWxrmdiWb6fblIzWGJq8gXDpIEcujE2Y9xR67UN55RK9OemKu
	myy/pi8ZODNfnmkocIBNS2GbIwexL5JBOnozB+/ERKzZWqwb8BQXflQzG+fIaK9Z
	T0M4WbpI9oHN1dZfxpDl+B6rM3DM3IUuMYUADx5EAMClZFayqoGkbtkK+vng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774882615; x=1774969015; bh=ias1i+RgnMFDQQ/b0cUv8lCOi2B1Xe+CsP6
	2dhbCm6w=; b=KyZc8XpjHP31I6FU8HxOmdIMtXjpm9pBlpFumPsMPodqf0v6h0Z
	ba2PIDbaWwnd9m2LFeZIyVhzw+P8rXavupzPb4d8bOngs2v1njJ2pN0qahDT54Ep
	VF8bzuFgTMqHx4qAbtsu4Vw986QFg4SdM+aNajcQevLJ7zo0ioEkbJNKWjgEGtrD
	xtp+ZUK2hQRgiWubZD4s3XuKzQdslv7Q/15PIqLirbyl7Of7ROn5iLxfpepTZnKx
	/7Xd3rCaZ8KstmpL/ZqGc4VaZvK87N/lxTMiNvK2SBsZzJ/MaRrZQM7ua79IuDmE
	PFte9q6r6gx4hSJZ66Y3hyrihEYgNCZXkuQ==
X-ME-Sender: <xms:N4_KaYLLNum_qbfewgENgQrgiakkIncqcpr8D112Q-oPb0TRq_mD4w>
    <xme:N4_KaYTzlOl3ebap5XXf1ZhdZ3ufITxFx4XNEYc9X42p4gAJypk-FV3z6QDk53CWD
    0hk8UJSrUrGYzWsy5uvnpqv4vKC5p-ZE1_EmofZBICnTJhTYxWD>
X-ME-Received: <xmr:N4_KaQpRt6o9TN7bUjbnLI4g2qbARWIq5I2Z8qicvlwODVvPMru9j1pfib9J452NCe2VXl5bEVfHlJeBH48nZ1ionyUxT7L9BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopedvgedtjedt
    jedvuddtfeejsehsihhthhihugdrshhiuhdrvgguuhdrihhnpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:N4_Kado9QyffCU99MU9-CVc3WvxqR8-Jr8ku6_X0YXfSNp3CqZ8eNw>
    <xmx:N4_KaaM_FaBv-Q02ZcpSt9nj8Ct2OA8YAxcxvWuCQAOfrXF2Xyp5Mg>
    <xmx:N4_KaWyYnB3muEY21zfHyueMlROigkjwENk6tE21aT2xY18U4QlZfw>
    <xmx:N4_KabsjbyVPbxb0Jd4Sae05FRHBt89IicaHfM9UrXQef8Qp6kSDvw>
    <xmx:N4_KaUR7kY90KT_JnXLm0Che_-6BbjFP7-Cx6JXEtoPjbTTi_g0x_lbg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:56:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] bugreport: clarify usage message purpose
In-Reply-To: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in> (Smaran
	Jaianand's message of "Mon, 30 Mar 2026 06:44:44 +0000")
References: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
Date: Mon, 30 Mar 2026 07:56:54 -0700
Message-ID: <xmqqjyutfjrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Smaran Jaianand <24070721037@sithyd.siu.edu.in> writes:

> From: smaran-jaianand <24070721037@sithyd.siu.edu.in>
>
> Add a brief description of the bugreport command to improve
> clarity of the usage message.
>
> Signed-off-by: smaran-jaianand <24070721037@sithyd.siu.edu.in>
> ---
>  builtin/bugreport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index f78c3f2aed..3b3fdd4dfb 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -56,7 +56,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  }
>  
>  static const char * const bugreport_usage[] = {
> -	N_("git bugreport [(-o | --output-directory) <path>]\n"
> +	N_("git bugreport -create a bug report with diagnostic information \n"
> +           "              [(-o | --output-directory) <path>]\n"
>  	   "              [(-s | --suffix) <format> | --no-suffix]\n"
>  	   "              [--diagnose[=<mode>]]"),
>  	NULL
> -- 
> 2.43.0

This is wrong.  The usage string is to show "usage".  Unless your
users type

    $ git bugreport -create a bug ...

from their command line, the first line that you added does not
belong there.

In general, these should match what is in the synopsis section of
the manpage (i.e., "git help bugreport" output), and there is even
a test to ensure they do not diverge from each other (iirc, t0450).

