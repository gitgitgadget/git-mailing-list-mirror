Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2E34DB66
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155935; cv=none; b=E0v0inrgmP7jorsAIXsfLPJOPeVLdTcUZN5mGHDVr38QLN5lypbgqcaVNXJeW4b7R5+HpryrzQ/znDTKmDxpdtryWh66+fsjoJGmR+n5h5H2elEniVVFLFzaQcvPzhEBHCf0nT55E3QjSS/cypkMpb9tib+IxRC0H3IVqO57lt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155935; c=relaxed/simple;
	bh=dlgefzK7zNzpZQpG3wsLTJ+NoHiidd2CpmSn4yy0Op8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H372WToNhlKxibhHuhUHV+UG8fxLnBJAsMzdwEa7+8K0Q9diwMCJQ8tqDWMA/I9CtI0G0OS1/2Vn6AJ+SLvvBUPrOoqg/R6N47ZI75yutZDcYv+IUFmbj6NZs1qikARqZGPzDCleTs2YO5H1frTDOBi29Br7i/tzP8fkE8RXqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GvgfBqAJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4tW5O0E; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GvgfBqAJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4tW5O0E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D7EDEC00CC;
	Sun, 11 Jan 2026 13:25:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 11 Jan 2026 13:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768155925; x=1768242325; bh=duy413+lOK
	9dc5g4y5p5+HgpX4iAsY8L50HcXA63WTk=; b=GvgfBqAJumCjRSGsHrfCJvP1UH
	3BE3TSyL/k1BNh+bn8NfoYcjycc3iIz2RWuUZxNNZOiyqVuXeUJAHSEmyLMvJJpj
	T+08NLHbQwDtENAQpo/Ap42tCS+xxZBnEvpe3oLbCT9UKnkW2Qi848E5+mzc9hgk
	qgSuauOJ7IMxqKGG08dC5lq/49mU1eJOd1GxmEoGm6YvGkbC0ivpu/O0ssUjS/sX
	5StV6zU/oXpD/yLIakS6GAe5WUEq7VDdgxFmmPhsXQE+XGSuKUOj2eFQ96Fq8kny
	/dS1dmvPytyFfswgDAfQN19MIxpRp/xN6BJmIgCBj3ovKyNbqHEDE7nDrh3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768155925; x=1768242325; bh=duy413+lOK9dc5g4y5p5+HgpX4iAsY8L50H
	cXA63WTk=; b=K4tW5O0ELtc/1E71lAkuUz1Nv2zR0aNzaO931ca2/P8KD/gr+Fk
	TbMsLhmHTcqURMWV9pAlhT2hpevm6TGNgtzaCZJErVDq7lOhG2I1sUMk0+qIGDKk
	KJKcA8SnRc3aGnQss4LLLPPGHPm+/VI8iaL+g6NfC3WzEum2uoAAmgBoodBZBOsQ
	gqu5i0ajvH8IKlWJ2sse6T90lFEK88M4tM+0OzwSj69U/ZLnAJSUMGH6K0VaIKEE
	a60Cr4ODksb6Je+qVkhQnqKnZzOtfINsUKjE9d53xYOZrKmNlzJP0li7Qq7qR1eg
	2L36BL0yKZ+QEqd/6lPdBzq+sTLw7i5maQw==
X-ME-Sender: <xms:FetjaT6hC6ExCIkO5U8JOQY3oPk0XbRsuyGujvV1ONY38RWlDTkaKw>
    <xme:FetjaSWROhuugrYGGAHILEId0Dvi05FKtce7syyeoTwTt6uh4nTqWUT3BgXhT-VRl
    b5NVzjvba21inaj9qrz0MzM7oM0OwJS21Ou9iqOzi0yIIriW9ewMg>
X-ME-Received: <xmr:FetjaaBYCWk-gsUylfQpe4YyaFOPJS-Ik8EmbIjy6_sVxVDrKqI8EhoQoSH1UpFwJHcE3w5Bso8LQMxIqI9_VqcCrgXorCiC0Npd0uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhjsehkjhhtshgrnhgrkhhtshhiughishdrihgurd
    gruhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhjthhsrghnrghkthhsihguihhssehgrhhoqhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FetjaZ6PBRq7BnzoQxQnrKgWK1P0FJvi30Rg1RjbWNRiXRcS5pXS9Q>
    <xmx:FetjadwAO5ijwzkCLCStQWgydp_3xAJN0QsEWg6y8XBkPuUeby1zAw>
    <xmx:FetjaYyYxwmbzdhrNJADEv2zuIcDYvsm3b1reW2e6iow8hRn2yQxbQ>
    <xmx:FetjadzlugsO0Wkd2FQLOr5CDw9LJEWWO9QBRgwdQTtzunaUwOjs9w>
    <xmx:FetjaYwmLZmx-EmGzoov-ZutGuNT76GmrKtP9ZBZJ1-LLSHZp25dpLa5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 13:25:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>
Cc: git@vger.kernel.org,  KJ Tsanaktsidis <kjtsanaktsidis@groq.com>
Subject: Re: [PATCH] http-backend: write newlines to stderr when responding
 with errors
In-Reply-To: <20260108225926.3587282-1-kj@kjtsanaktsidis.id.au> (KJ
	Tsanaktsidis's message of "Thu, 8 Jan 2026 22:59:21 +0000")
References: <20260108225926.3587282-1-kj@kjtsanaktsidis.id.au>
Date: Sun, 11 Jan 2026 10:25:23 -0800
Message-ID: <xmqqpl7govl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au> writes:

> From: KJ Tsanaktsidis <kjtsanaktsidis@groq.com>
>
> The not_found and forbidden methods currently do not write a newline to
> stderr after the error message. This means that if git-http-backend is
> invoked through something like fcgiwrap, and the stderr of that fcgiwrap
> process is sent to a logging daemon (e.g. journald), the error messages
> of several git-http-backend invocations will just get strung together,
> e.g.
>
>> Not a git repository: '/var/lib/git/foo.git'Not a git repository: '/var/lib/git/foo.git'Not a git repository: '/var/lib/git/foo.git'
>
> I think it's git-http-backend's responsibility to format these messages
> properly, rather than it being fcgiwrap's job to notice that the script
> didn't terminate stderr with a newline and do so itself.

Now another question is which between the callers and these two
helper functions is responsible to ensure that the message
terminates with LF.  As these functions can be called only once, I
think letting them add LF makes sense (if they can be called twice
or more, we can imagine that a caller may find it useful to make two
calls to produce a single log entry by ending only the later call
with LF, but such a use-case clearly cannot be supported with these
NORETURN functions).  So I think this design makes sense.

> Signed-off-by: KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>
> ---
>  http-backend.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index 52f0483dd3..bda8bb91e1 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -143,8 +143,10 @@ static NORETURN void not_found(struct strbuf *hdr, const char *err, ...)
>  	end_headers(hdr);
>  
>  	va_start(params, err);
> -	if (err && *err)
> +	if (err && *err) {
>  		vfprintf(stderr, err, params);
> +		fprintf(stderr, "\n");

Somehow it feels overly heavyweight to call fprintf() just to send a
single literal byte to the standard error stream.  putc('\n', stderr)
perhaps?  The same comment forr the other hunk.

> +	}
>  	va_end(params);
>  	exit(0);
>  }
> @@ -159,8 +161,10 @@ static NORETURN void forbidden(struct strbuf *hdr, const char *err, ...)
>  	end_headers(hdr);
>  
>  	va_start(params, err);
> -	if (err && *err)
> +	if (err && *err) {
>  		vfprintf(stderr, err, params);
> +		fprintf(stderr, "\n");
> +	}
>  	va_end(params);
>  	exit(0);
>  }
