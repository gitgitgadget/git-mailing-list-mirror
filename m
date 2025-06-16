Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2DF360
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035684; cv=none; b=NINSvUfrgm1yt6U/b7MUrK7NGZbHh8jci8dAAlISKtrsoAkRIx2vFMFVO8MdTE5gR7sWXf/21FKs+okpQTeHLYo854nGRdLwYS5GplRMh7Ou/EyiZ31l7cTyOSEu5mczP1hdFOJ7hCZxzoSOjGM4R14NscX3k1kvhnO/fE2Wrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035684; c=relaxed/simple;
	bh=8Cf3iXjqK4y5HwecO34vVqUF6dDllQ1zD1W80MXhxl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SM+OtiZu9UVMjw10l7r9zqJSoe2zrEYs8o81+U0OGDP32VEFIGoX020hj9UwHRuhelAqjytfcHq+IrE1E1FeYdsLR1jxG2m08J7wjuRjuBnoNd0VXHMIkzvLsTmTEbHtBWRcxIkF6zgH9FtHwaX1u+PKc8+3iJ4azauhmS0PYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p4I2KLd+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPXhlxi6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p4I2KLd+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPXhlxi6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B580213804BC;
	Sun, 15 Jun 2025 21:01:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 15 Jun 2025 21:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750035681;
	 x=1750122081; bh=IMfa8DslzlEQJ7k47fbKgxBssHbC7z6/85fodTb8Otk=; b=
	p4I2KLd+MepRxbg/2Fn0i/0AIKVzHAgjW1SCV45wiv+IjFgASW6YuBc9Mu48m0nl
	ZumViAUYA16TW0Ys7d6rLhZp1KuMtuC7oPzzeSZWBFSkFcaBKyam2gzWdNYYPe9Q
	+hu8mzqMqu4yVu8Ezj5DrdBX+pOrxs/rpt1OrJKb5Z+DLKn8HicyA+32FXhbPkC6
	D/NovJfS5abtDeZ2IX2m4r/V7XQCYdwRH0fINXAry6aHgp86P9L4cRisuWT3yPDG
	24JCk2micsNUHJUI7lwW6e2zyQsrwYfnffiUWZkqcboW/w7eqGkoajss8I2NDkoH
	r3QHsDlrkhLbRT1/DCBa7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750035681; x=
	1750122081; bh=IMfa8DslzlEQJ7k47fbKgxBssHbC7z6/85fodTb8Otk=; b=D
	PXhlxi6HRfGjkqMLWdBmgtnXNf6R0kyoYA+Oau8MxHpMyA4tm6J2izKngOOJRnDm
	F3+aWeBFFlNr6Kn7yYznXY65VdXtrE9deFyRUjlGJq//RqEyD59c0aFrNU/qasVI
	6EzuQa3nbmCuaYzZKwg3HaPguI6IsqI4mzrc1lTt8NTWOGmVL+c3bDwh38WXjMAz
	odDfAawnjkEjeLBP5LdtemvjpyPw1O1L5S3pKYcLLitSrAG9MnjzLfnIh2sEah68
	OIiYzV8kSdGdI/KylfSMFhQt/Q+e1RuA59HcWGdKF2UoJ5fUweqzwuBDntvPQFtf
	5e8AI9pRYFkxKBNtudrqQ==
X-ME-Sender: <xms:4WxPaAmd4UvkAN3bOOw__hBPUFB0z5J5iBwNAngBDOA8olwqO4yQMg>
    <xme:4WxPaP0OaNyrSeDUSuX-jqWo_uLF38Cg_rK9TPLBm8a3fmI-N69uGTTnjTTOGM1LC
    FPGEURdAITKGGaMng>
X-ME-Received: <xmr:4WxPaOoHYoRkxDWU2d_4heejIR3MPb5DVT93jcS2ee4818ZZnPYC5GVrCyLrEQ8h0Z80LgFCLWIvYeRCs1hQdCommbkNP3h8wh7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvhedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlughhohhmvg
    dvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhuohekgeeisehpuhhrughuvgdr
    vgguuhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghlvgigghhuohdutddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4WxPaMkGde2HNaJIrOFUg6_UIlrO3KXrUlzHxWH0kAh6U-XMNxwyqQ>
    <xmx:4WxPaO09fApUgH5VJgvkWQ4M3dtlSb7gLp8UURMJh8ml1schQ6o2gA>
    <xmx:4WxPaDvo6zPZ1p3wtfs65QEsTy9XTBZTkgHJC9La2f3Hn37l-IFZrw>
    <xmx:4WxPaKV0GMEMKHrZVPTdLH4RnInSE64QpO0xxpcS8WGWb3O7Q0r_ww>
    <xmx:4WxPaEMOQh4FNcE4uby-W8b9mLGwoTyswL8e-Ai11VIk8LhC8XdF2I9G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 21:01:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Jinyao Guo <guo846@purdue.edu>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Josh Soref <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>,  Alex
 <alexguo1023@gmail.com>
Subject: Re: [PATCH] Fix memory leak in function handle_content_type
In-Reply-To: <8C3C7F5F-9442-4C63-9280-D46A683C9F4D@gmail.com> (Lidong Yan's
	message of "Sun, 15 Jun 2025 20:55:08 +0800")
References: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
	<44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
	<SA1PR22MB3999874B7FD9FFF7D90C9F89E477A@SA1PR22MB3999.namprd22.prod.outlook.com>
	<xmqq7c1f8nr2.fsf@gitster.g>
	<SA1PR22MB399911638F342E1AA20F014AE477A@SA1PR22MB3999.namprd22.prod.outlook.com>
	<8C3C7F5F-9442-4C63-9280-D46A683C9F4D@gmail.com>
Date: Sun, 15 Jun 2025 18:01:19 -0700
Message-ID: <xmqqldps4i00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> Subject: Re: [PATCH] Fix memory leak in function handle_content_type

The subject should probably be something like

	Subject: [PATCH] mailinfo.c: plug memory leak in handle_content_type()

> May be using goto here would be better. Like:
>
> ---
> diff --git a/mailinfo.c b/mailinfo.c
> index ee4597da6b..83358b7517 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -266,13 +266,14 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
>                         error("Too many boundaries to handle");
>                         mi->input_error = -1;
>                         mi->content_top = &mi->content[MAX_BOUNDARIES] - 1;
> -                       return;
> +                       goto out;
>                 }
>                 *(mi->content_top) = boundary;
>                 boundary = NULL;
>         }
>         slurp_attr(line->buf, "charset=", &mi->charset);
>  
> +out:
>         if (boundary) {
>                 strbuf_release(boundary);
>                 free(boundary);
> —

Yup, that one looks good enough.

If we wanted to clean up this code path even further, I think the
first clean-up to do is to reconsider the use of "struct strbuf *"
(instead of "const char *") in *(mi->content_top).  strbuf is a fine
and less error-prone mechanism to use while you have to manipulate
character strings (like parsing from input line to formulate the
boundary string), but once this function computed what was asked by
the caller, the computed result (like the boundary string) almost
always do not need to be editable.  But such a code improvement is
totally outside the topic of this patch.

