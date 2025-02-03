Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976F1D5CD4
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623218; cv=none; b=hJB7j/dcFYzIl5KHTZaOXHpKKiiB7kN7ONkAvoDUJmKcb8vKWxfBsfMGGL2AKnZjlw5E7vMm9iSzUwTNX34zEWtzh3YHTYENANBnA1WcIsz9OXX/Q3r1XX+6/SzbDOM89hElagUMzpTN/NceR4lHGR0nRSxq8B/DiRzGFzp7ENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623218; c=relaxed/simple;
	bh=7IAJTCOaIdKx7YAfYE8ADJ3slomIFcCxRiFvtq5qGY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qx8qylpfRewV8LSJivku3wuLpRU8JLU0xymAswgUEi7xJGWyuQtAEIMP0qd+QVISmGW4NWe4nBQRlpVF3L9xsVasiJV9/gD2MN5hYoXlz2F3Fr01pQ2gPJei1fT1pbNSQeS1Tm3Bu0VOKwnwFcrROVy8oDeTd4C2NnEAHF8r9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FWN9A4K5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2cT3/DN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FWN9A4K5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2cT3/DN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0978C254019A;
	Mon,  3 Feb 2025 17:53:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 17:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738623215; x=1738709615; bh=mGZy9Emalt
	Ez/fuoKIu8bb+UWDQYs+NNg2XECtpkZR8=; b=FWN9A4K5Gg1fFWXDYAVVG7l23Y
	Dw/EMHLPN9VJMxIcU5Gy4/5PlRO/bGzWk/CSdcwZtw7zbjdf3qz5z762XETxTgai
	DToyzyUK0LFIJPTWMFDFEXBV3as0cDNNoqoPO7j4ciJdSSPLvFdpzAyVpvWYB4JG
	pV/t5zMG/6E8OK8RYERXMGpHUZZW95k+qD1P7iRUVeQrF1KYteWxZAelkHZMUigl
	ncCrs6YtmyZ/PBa1CC42S2HlZNM+NW+YUueOI8fxtOzvzPkn5AvWiGXAcr6QkXgl
	zpmMr/INYcpmKJLyMvrKJDYCh+OqHavaRJDkSsjvdbdg/Dt4voB6Wcabq13g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738623215; x=1738709615; bh=mGZy9EmaltEz/fuoKIu8bb+UWDQYs+NNg2X
	ECtpkZR8=; b=K2cT3/DN8lQqqZ8PrDaoyl+l/bbDzL61gucNj9Kc6OAYJQljhOr
	z8UMRoDq5Qe/Lo6Tdi93FTv6fKJE81U1DYSd30E/Tl6/lMZi23/ga8QyknT0x29r
	jStmeGmLtvvi8eQI/Sej5kg/AZ54IR2REn0z9BhrEm5eBqXC3a9f6798k74t+XZz
	tOBUGM1WzbVAWH9ANsjOoof6fLa5+MNYJpiKCdtrflp6w7AF0JQC4/oIJpp2NELd
	qasXkhTQiTfPceG8waye2XE6VIjIif2LF4IvEvB3c1EKu4tTY4uTf0UwnFNZFSm3
	egLqZBk1WLrJAt5ZYk3d72tUSJ1K8esrCQQ==
X-ME-Sender: <xms:70ihZ6GpEJxE-FGaxvbeWFrAaZU0VnPf998r95gkK_xMuRnLIhzZnQ>
    <xme:70ihZ7X74LE9Uh_8Ov2W5Tu_rGJTlPF1suUP1I3OKudJZkux0uxmu8nvJQsJcx-K9
    Jgs2aZFjKWfHR9y_w>
X-ME-Received: <xmr:70ihZ0IiLNeM0s_65AGD9q9uTAzTUaeg16ludn3PAGS0VZ6jMMbk3jVqq96eRIWH4BE3X4Fm2gYoOpNw0cmb0ZGD5bpY_N0LBIOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshgthhgrtghonhesghhmrghilhdrtghomhdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopeihvgifohhnsehrvghvihdrvghmrghilhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:70ihZ0FOTVrlC-GH3-UUoFVezlVxsUGB6nH0U8NEkgOfsuJ_iLeQPw>
    <xmx:70ihZwV8aKUhVbz9fggDpYD775uNoYudv6cBGRs95emcZfI4JauL0g>
    <xmx:70ihZ3Poa3iWG9FRJvhUlJTYwA0rmBjXtSSB9OdwHLpwvATHz4aBuw>
    <xmx:70ihZ33caq922WVWd1HLoDARCbV-ehr_fmawutKIgk6NoHEwoI8poA>
    <xmx:70ihZ0ofEHhEYDoO0NNVwtUzcLfEqmpTmsYL3zg-MXUoHknsZCKKeMZ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 17:53:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org,  Scott Chacon <schacon@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Yongmin <yewon@revi.email>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 2/2] help: add "show" as a valid configuration value
In-Reply-To: <20250201213319.153109-2-davvid@gmail.com> (David Aguilar's
	message of "Sat, 1 Feb 2025 13:33:19 -0800")
References: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
	<20250201213319.153109-1-davvid@gmail.com>
	<20250201213319.153109-2-davvid@gmail.com>
Date: Mon, 03 Feb 2025 14:53:33 -0800
Message-ID: <xmqqldumzlle.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Aguilar <davvid@gmail.com> writes:

> Add a literal value for showing the suggested autocorrection
> for consistency with the rest of the help.autocorrect options.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is just for consistency with the other config values and
> can be dropped if it's not useful.
>
>  Documentation/config/help.txt | 2 +-
>  help.c                        | 2 ++
>  t/t9003-help-autocorrect.sh   | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
> index 676ba3a55f..b369589cec 100644
> --- a/Documentation/config/help.txt
> +++ b/Documentation/config/help.txt
> @@ -11,7 +11,7 @@ help.autoCorrect::
>  	If git detects typos and can identify exactly one valid command similar
>  	to the error, git will try to suggest the correct command or even
>  	run the suggestion automatically. Possible config values are:
> -	 - 0, "false", "off", "no": show the suggested command (default).
> +	 - 0, "false", "off", "no", "show": show the suggested command (default).

Makes sense.


>  	 - 1, "true", "on", "yes", "immediate": run the suggested command
>  immediately.
>  	 - positive number > 1: run the suggested command after specified
> diff --git a/help.c b/help.c
> index 55425c0d97..8d91afe851 100644
> --- a/help.c
> +++ b/help.c
> @@ -574,6 +574,8 @@ static int parse_autocorrect(const char *value)
>  		return AUTOCORRECT_NEVER;
>  	if (!strcmp(value, "immediate"))
>  		return AUTOCORRECT_IMMEDIATELY;
> +	if (!strcmp(value, "show"))
> +		return AUTOCORRECT_SHOW;
>  
>  	return 0;
>  }
> diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
> index 5ebfc00f52..8da318d2b5 100755
> --- a/t/t9003-help-autocorrect.sh
> +++ b/t/t9003-help-autocorrect.sh
> @@ -28,7 +28,7 @@ test_expect_success 'setup' '
>  	test_cmp expect actual
>  '
>  
> -for show in false no off 0
> +for show in false no off 0 show
>  do
>  	test_expect_success 'autocorrect showing candidates' '
>  		git config help.autocorrect $show &&
