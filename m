Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453F3D7D7C
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693072; cv=none; b=i2ezVCHp4GMNTcif4R4YwLjsrVEtTa4l4xwiCdjXsTi6jGAT45bejahitsYbQ/hiKMMnk2s9XsCbJlpwDb8nFGSG+ULIBTH04+o0gEsvL7XEDfGSjOe8M1YmAwRRsoX3LyXl+7jisqDtRBbO415wBoGX2k9E9QquevMmhmQz560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693072; c=relaxed/simple;
	bh=6CWNNMrswmPICMh6iPqUW98YQAEXfonK4Ks/zE3K14c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I8Qj2AfewDQQ8nbCOc0LAw5oiQtSI2tIDtWWSVrzr0NHTkKZfPGg4XDvHqfVg5CXqTl1dSjXFaXvqIE4E3364DIDmO7+a33HtC5atF5P4ukNZGhXFgQ79a66TOEgw6TuJGHXygNJjvgYXvgqAMJLY8DuexPqRpOS7btKKLe3P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MqldNmK/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yHXVVCle; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MqldNmK/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yHXVVCle"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E31F57A0305;
	Mon, 16 Mar 2026 16:31:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 16:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773693069; x=1773779469; bh=ILdGlRNMPo
	r5AuqU9mumKsfWuUb+QPGGMrMW4AGwbVo=; b=MqldNmK/JxqgomKANytcMdPy9r
	9jigGFtb4pgkVu4Sf9Dd/2ay9yhSVipMQ5V3MR0jq3ezmY/e1bW8bFoGp9Vxt5M7
	GiFxHZHsCVSMmglFhEu80spQl9PTGqfayF1Z5g2LfSrOJFXxvc5xJFyy201elMWu
	FUDDAwDs5UbTnQVlUjMTgDQhPydd9Se0Y/BhOpOjb+VimJnjDhNKUrIz6yUS8k//
	rMgxJU09nIo9YVnfocRdtfxX87o8X1WS1YPJ4WVgurXyxt/lXm6TwCkszssIrbjE
	k38M9gF+qz+lr3Lk/jLp4/kYB686oGnUvijxWZ3JhhLJJnVnr8cP4qwAR4DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773693069; x=1773779469; bh=ILdGlRNMPor5AuqU9mumKsfWuUb+QPGGMrM
	W4AGwbVo=; b=yHXVVCleEdhfW2FK0TVtEJe5K3wDmCc4/7gNPxmXuKHSNDeW0AY
	M+PUexsEJQQUDv9die9hBfpFngXsIkEbAEXAyppdKdH3o3sCW7yDL01jutKVnN/X
	Pgzw69iqUfWZkzSmfm1G2aKP0sSjQrRmGyT6fw+EpebHF7gITFv7ZCuqUUo8jUYx
	4TdsEctOSFAyrppRWShouHuMmZPEPey81tI34lN5jaLWogr3lTA9dUZ8iSR+PrP7
	zXYjHIMRhHdR4OWCa9AK05GFXCQc/ppAfWwWcyVseIQvY4av2TRfwO1XlbJx2tAo
	JV+dYIgMWQtnsfVDnCtZ0SBknDVOPHIO2oA==
X-ME-Sender: <xms:jWi4afWE4Vvl_OhpWTttZwXUWdZW-UKNWqZGkB4oFraJcO-aa1oiaw>
    <xme:jWi4ael6hCfxoc3eK1A7Ot5TLOrYWi9YFit3w0OB7PKdogUTWwPdHiQ6FM1jXB3Z9
    XtCU5L_bBFaMV4GtmYB_M5k5KKCS0H7IV9LeI_Jz8PFErlxnVKakg>
X-ME-Received: <xmr:jWi4aQa5i6SU3dKawS9lb-HT5KYX3PV6G7RMCLFnq__rFQ6BHLK6kPDDvtVu1CKLdtXZX4dZgJDwwaLqkn_nVjtnE8L8Yeq_iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekteehffegieelgfetgfffudfgte
    etjeelgffgvdevffeiledvvddvgfetkedtffenucffohhmrghinhepthhrrghnshhpohhr
    thdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegtshhhuhhnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jWi4aZM5YTYxZotCybzKeymx1LV_3wEQFSYXvbvADkKyaoMEixvoNQ>
    <xmx:jWi4aVbL5LvXW3QRR2yIbazf07QNeaVdWLMDwEgR0q3RSxbEYMUHoQ>
    <xmx:jWi4aX0l-OTHunAZ2RVzczNn1ZqPZI_kVp_FQB2ETEaTtVhxyZEj9g>
    <xmx:jWi4abdXfewdUe9V9jBkkDWHiP-TIqpeR2WwsQrk92kPJdCc8KVCsg>
    <xmx:jWi4aYXuVKzlyJxpF6FBE5tTtWrO7TVYL7pRXN3YXTeL51nN6sZsEeVf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 16:31:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Andrew Au <cshung@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
In-Reply-To: <20260314160814.GA918806@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Mar 2026 12:08:14 -0400")
References: <20260311184206.GA1911377@coredump.intra.peff.net>
	<20260312214945.4050010-1-cshung@gmail.com>
	<xmqqsea4aen2.fsf@gitster.g>
	<20260314160814.GA918806@coredump.intra.peff.net>
Date: Mon, 16 Mar 2026 13:31:08 -0700
Message-ID: <xmqq4imfo6sz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't know if you want to apply it separately (since it's really a
> totally different topic) or on top (since it is only the application of
> Andrew's patch which lets us find the problem).
> ...
>  transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 107f4fa5dc..2fb4767821 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -54,14 +54,14 @@ static int transport_color_config(void)
>  		return 0;
>  	initialized = 1;
>  
> -	if (!repo_config_get_string(the_repository, key, &value))
> +	if (!repo_config_get_string_tmp(the_repository, key, &value))
>  		transport_use_color = git_config_colorbool(key, value);
>  
>  	if (!want_color_stderr(transport_use_color))
>  		return 0;
>  
>  	for (size_t i = 0; i < ARRAY_SIZE(keys); i++)
> -		if (!repo_config_get_string(the_repository, keys[i], &value)) {
> +		if (!repo_config_get_string_tmp(the_repository, keys[i], &value)) {
>  			if (!value)
>  				return config_error_nonbool(keys[i]);
>  			if (color_parse(value, transport_colors[i]) < 0)

Regardless of where it goes, we need to change a bit more, it seems?

    CC transport.o
transport.c: In function 'transport_color_config':
transport.c:57:62: error: passing argument 3 of 'repo_config_get_string_tmp' from incompatible pointer type [-Wincompatible-pointer-types]
   57 |         if (!repo_config_get_string_tmp(the_repository, key, &value))
      |                                                              ^~~~~~
      |                                                              |
      |                                                              char **
In file included from transport.c:5:
config.h:644:62: note: expected 'const char **' but argument is of type 'char **'
  644 |                                const char *key, const char **dest);
      |                                                 ~~~~~~~~~~~~~^~~~
transport.c:64:74: error: passing argument 3 of 'repo_config_get_string_tmp' from incompatible pointer type [-Wincompatible-pointer-types]
   64 |                 if (!repo_config_get_string_tmp(the_repository, keys[i], &value)) {
      |                                                                          ^~~~~~
      |                                                                          |
      |                                                                          char **
config.h:644:62: note: expected 'const char **' but argument is of type 'char **'
  644 |                                const char *key, const char **dest);
      |                                                 ~~~~~~~~~~~~~^~~~
gmake: *** [Makefile:2815: transport.o] Error 1


I'll squash an obvious patch in.

 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/transport.c w/transport.c
index 358bc38585..7985b42a74 100644
--- c/transport.c
+++ w/transport.c
@@ -47,7 +47,7 @@ static int transport_color_config(void)
 		"color.transport.reset",
 		"color.transport.rejected"
 	}, *key = "color.transport";
-	char *value;
+	const char *value;
 	static int initialized;
 
 	if (initialized)
