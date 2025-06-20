Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C22F2F
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750381118; cv=none; b=HSVZ0VEzXE8X62ry9sxfwN7G11qfZqhU/6ZXt/8Est6VIfmFRJ1MEKWmkzOFISwhT/VA/Df4bmI/NKNC1YV1vJhG1LsDw+WvX43uv5JOLWpDsdLaPDGgvJTg7AqaAfMs9FdeHcOyfqTByIEJG0nYLl2/0uYCdSBU98jZK7kFGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750381118; c=relaxed/simple;
	bh=5xgLP4Y2fn97GhhO0i4mEqrvTVyknU2qIJ7hwxoMQho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fvpnCvT/NYjpj6Y4Ib+JrU8jY1P6ceVz4m1YSg7WrkK7cI/WKH02TfVqauhCMOShbzK2ziUw3eCmoPJGbuycwvY516SIO9UdYiMLWItI9eKphtyr6aZBjRFsdTOs1FvnsbDBqhbiwgA3M4pK+sFsXjaYWf8XA0y930XcZxPLq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oGC95wxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zt21HlhK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGC95wxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zt21HlhK"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3104E2540197;
	Thu, 19 Jun 2025 20:58:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 19 Jun 2025 20:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750381115;
	 x=1750467515; bh=4i8i1ZBc7O7Iyp5eX4EHfsq6UAxz9dIi8J9V7SnChjM=; b=
	oGC95wxfJonulA2ls0xBr54Rbzf5FwmGpy4kevgyOkvRkByikZin+16m917qbemJ
	upXs8saUjASQUoW6gSrUDKUCH8Qre6mrPbNL61isPO5I73hCixesLYZLBgBRAvxX
	1S2K4cSjJRzgxJWlShS05OIwbtA05TTyDQHznYEgZGtNpNlJ6wCpHQwDktPgT2JL
	fYUSuG/FMc11HKdCbTW4HghJKJSHezp68Dz+prSgOy51MkWf5hMRZfkisSw2uAdo
	AsCPB1CZRcoF/d3W4scf8ubbhpcMB/G/O7f6EFB0ZRuCz6l5l8dlSXQl/3CcXSbt
	hK9PKPz8aEiD1IV9ZYi+ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750381115; x=
	1750467515; bh=4i8i1ZBc7O7Iyp5eX4EHfsq6UAxz9dIi8J9V7SnChjM=; b=Z
	t21HlhKL/TtoYPNahhefGk+UTsndJEA1Nn4WMN8E+Tl7AkoDTxMRr4dX384tfz3w
	TOmb4sCMCm+J3GXng+bQ0lrJcI6aJc3H3ihtifI7qKJrRuyftH8TjHxP+H4k8Xi+
	FMMwu/fB2y0dX1jwAwkKnolNqDEncRCv8BRu6xSpJ6Qjc8NseRedf3rAbUB8J6eQ
	/Gsp/idHTg+tkh4ci4kR/JNe8DF/ebmvlTscydcKTbxggilTv7zeqZyHazP9N2k9
	66mOgT1nR1u+tFCKGae9a33qkVEFEA3DkD3mPDto0X7wJz4gmcm395XaoqDdhNm9
	Xq5tF3YsGcOBI4FSr/cGw==
X-ME-Sender: <xms:OrJUaDSkjx-_eAHrxPS6O5q4NNjgI1de9GihdkGpdSEXnwG7HYN0lQ>
    <xme:OrJUaEy-lT2cXWLeqTNHYDH7XM0Er5xABx598y3oSfnN0tcS5HzSs6u1AKUStA_rx
    2tBhrlvK17w9fAtlw>
X-ME-Received: <xmr:OrJUaI2mKg9bg4bYDYFg1vDhW990565qtBq74wTlMe9_FjtM4Er-CTHAR9GLTt0-0AlAxaO0Tfdfh9qh7ltKB1R2uEbWKwm5g_aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdejtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvvdeltdeguddulefhveduudfgudekiedttdffheehhfekleefgfdtieeh
    veenucffohhmrghinhepfhholhguvghrrdhishdpvgigrghmphhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehjohgvrhhgsehthhgrlhhhvghimhdrihhopdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrghgrughithihrg
    dtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:OrJUaDAEq9uLGTaFDe0CEa9krVlKW8qgm7cl847XA76UZU1kFo7fQA>
    <xmx:OrJUaMisF-b3vxX3GM_3dlO0d0aciAXuIRqf2j5wL3JEDfnzSZciaw>
    <xmx:OrJUaHrdlnZOi7_HaDjYjjzkiwJz7njx_YOHi6c35LNQu7C7IguScw>
    <xmx:OrJUaHh6TXR7Ro3VrfEn-QNweFtX78QY1jBGNIPQljl8ieqbhmu9rQ>
    <xmx:O7JUaF0AkeU6koGSzPUEelWm6d2PtPrBA9_U_RAKi996vVzFSEjqbYOf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 20:58:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?J=C3=B6rg_Thalheim?= <joerg@thalheim.io>
Cc: git@vger.kernel.org, Aditya Garg <gargaditya08@live.com>
Subject: Re: [PATCH] imap-send: improve error messages for missing
 configuration
In-Reply-To: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
 (=?utf-8?Q?=22J=C3=B6rg?=
	Thalheim"'s message of "Thu, 19 Jun 2025 08:53:35 +0000")
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
Date: Thu, 19 Jun 2025 17:58:32 -0700
Message-ID: <xmqq7c178c07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jörg Thalheim" <joerg@thalheim.io> writes:

> The error message 'no imap store specified' was confusing because
> it referred to 'store' when the actual missing configuration was
> 'imap.folder'. Similarly, the host error message provided no
> guidance on how to fix the issue.
>
> Improve both error messages to:
> - Clearly state what configuration is missing
> - Provide hints showing the exact git config commands needed
> - Include examples of typical values
>
> This helps users quickly understand and resolve configuration issues
> when using git imap-send.
>
> Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
> ---
>  imap-send.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

It is curious that you are sending usability improvement patches to
imap-send, which I was recently told to be completely broken wrt the
use of imap.folder.  Is the claim I heard that it is totally broken
not true after all, I wonder?

In any case, there are some patches in flight that rewrites the
parts of the program this patch wants to update (which addresses
that "completely broken" part and makes the program usable again).

Can you fix the messages on top of that work?  By doing

 $ git checkout --detach origin/master
 $ git merge --no-ff -m 'Merge ag/imap-send-resurrection' adbc0b5d
 $ git checkout -b jt/imap-send-error-message-fix

you can prepare the ground and then fix the messages there.

You might want to consider using the advise() API to add the hints,
and please make that a separate patch on top of the "What's imap
store?  We call it a folder!" patch.

Thanks.

> diff --git a/imap-send.c b/imap-send.c
> index 2e812f5a6e..a2d6f6d3f6 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1539,13 +1539,17 @@ int cmd_main(int argc, const char **argv)
>  		server.port = server.use_ssl ? 993 : 143;
>  
>  	if (!server.folder) {
> -		fprintf(stderr, "no imap store specified\n");
> +		fprintf(stderr, "error: no imap folder specified\n");
> +		fprintf(stderr, "hint: set the target folder with 'git config imap.folder <folder>'\n");
> +		fprintf(stderr, "      (e.g., 'git config imap.folder Drafts')\n");
>  		ret = 1;
>  		goto out;
>  	}
>  	if (!server.host) {
>  		if (!server.tunnel) {
> -			fprintf(stderr, "no imap host specified\n");
> +			fprintf(stderr, "error: no imap host specified\n");
> +			fprintf(stderr, "hint: set the imap host with 'git config imap.host <host>'\n");
> +			fprintf(stderr, "      (e.g., 'git config imap.host imaps://imap.example.com')\n");
>  			ret = 1;
>  			goto out;
>  		}
