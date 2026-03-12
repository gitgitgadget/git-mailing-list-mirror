Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D83F8E04
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332926; cv=none; b=hBnbC5/WZ+WznDTEHYF7e4+uzAqPdFcVFLQ8dDAT2pQcfKYmJj27IRGfYOWdn0XF5hfOzr9hgjyP8gt7WVzSuuwSM1QUjitpMLCxWeQSC6Lf5OfjGknkTp5Ds5iw7VNkitOnyHkD9xELXbVUCQtHNBxPegZxrcwK5C/Bq0JTmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332926; c=relaxed/simple;
	bh=PhcstMj74Zz8NfuHcDT3gcN0eHDF01owgB0oyor3fWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riBcMAYy0b0R5U4YsalJT5jbwWekXDjJ7IcNu7W0eMJik4eMFn4vcW/gonl2Wbuz+KhCvcw6LOt42orY2jW7oRdWlU69a4oX/TFRWeTDdbmZGvqKE48wnr43y9yQzYLM66GcE6asnI9y/Xt5VNGfKQKjMWMOULtHh8eFI+KK1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j3vNWpAc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JHuJ78Zq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j3vNWpAc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JHuJ78Zq"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A385B1D001B1;
	Thu, 12 Mar 2026 12:28:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 12:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773332915; x=1773419315; bh=35YLQIjA24
	ZM6w6eF89jd+/s9Et6GV2Ree6jq4mVDeI=; b=j3vNWpAcrJoxbE+rWNLP2J6Xje
	1ivCoKb+F4zQpvc0ICQRyjGYA7NY3rD5qO3IiVIC0ZBefHPgOq8mOiIjeQ7bJam3
	HCZCPHvW3bzUWy4qf4nn8YXioRrEs+FfpNI64p1IijfIH4Pp1gG6c6L2Yq4lqh/L
	neCh5ttEMiH/8xv41tQcUJSyvHU1dmVtFzWI7AQU0pUsKnd7hl9HIEYnpVzoZ78/
	p5cCfjq5TUoFrY7PniiHu5GbuXb4pi0LQUjEDT14dktffKsDou9B1ubWo2KoEwas
	yoiXKGKUpBauRntHtslEsCSLgwZ6fOEfhjs3bk6HZ/sUVVoPPoGPB6ON7KIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773332915; x=1773419315; bh=35YLQIjA24ZM6w6eF89jd+/s9Et6GV2Ree6
	jq4mVDeI=; b=JHuJ78ZqryD7ZsTLcpqLktVPuUvhHMNxyOQ5PCpLCLffn4LYFhv
	i0PM1ANs6BHCUW+vdyfxB/NBaDDe4s5ZWz+eGYxBokOAzyu9cZiwfrzqlaabDJIP
	fFfed4EDbnrzx6vCzUnu3Boqg2ZwI0HE4TeQlV0PGdPSNyvOGf6GkzWcfH5llOwp
	MQtzr0i59TE+XdafdEQQaOArkgpgXVD15xrJ7nW7bmtpq8MUdCtleVJ3+h9urW0L
	WJFK3lbamyu37SdnOWbEkGqF7EkvTw1nX5Vpdok7ieU1rlN7MTNum7rxBsKwLOS/
	P/OsEmVrm+EYvRxNxRel6eZD0Zl3IZv7jmQ==
X-ME-Sender: <xms:s-myaYyN37guw1n1V4cUeq9r7CthDylWy3wZF6PloX459srgGD15nA>
    <xme:s-myaf9N3GxxT3R4kFi5ix77eAJTj-rnJaGMneBr4ABSejirbGKOVhXSptf4Yxxv0
    eWpEYgnfUCvQL0IlXWnhpnuZK7LYZRbB1kKiFo8-e3i_Oe29W_MBFg>
X-ME-Received: <xmr:s-myaUKqt5mbDeLdkuQ2J9bFvDAHN3Bi8V-9JIgi3w8y6AYzg2gfSmVBdh0J3Dfz4GHk01vyx0SVey-Q2aPPKqVhI8DwMzfgiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s-myadc58IrrsQ0-Xe_njR4ZaGrBeKa6M_2i-w1F8laCPnZJxAGp8g>
    <xmx:s-myab-Z6SYPKut836AVk-vPoANx9np3zLEdRavgvD2gQi3YyDTZDw>
    <xmx:s-myaSov3F4fCZw-ksrP-GDROAFbQNdePC7iykKqY2sSFKOrpb67yA>
    <xmx:s-myaYBH4CpC5sjAMtQYUZX1n65g5kR0GRSoudrHqaq8U2kbLlYzTA>
    <xmx:s-myaTBCF3COhI-a4FaXtQlmFAbqythzssW8_-zvE2SVVsTBhAm6d5zg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 12:28:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 1/4] format-patch: move cover letter summary generation
In-Reply-To: <3b008fb94dff3b54f19eb0754938a33968acd1cc.1773331753.git.mroik@delayed.space>
	(Mirko Faina's message of "Thu, 12 Mar 2026 17:20:08 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<3b008fb94dff3b54f19eb0754938a33968acd1cc.1773331753.git.mroik@delayed.space>
Date: Thu, 12 Mar 2026 09:28:33 -0700
Message-ID: <xmqqeclpggge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> As of now format-patch allows generation of a template cover letter for
> patch series through "--cover-letter".

"As of now" is redundant.  Our convention is to describe the state
of the codebase _before_ your changes in the present tense to set
the stage for describing the problem.

> Move shortlog summary code generation to its own function. This is done
> in preparation to other patches where we enable the user to format the
> commit list using thier own format string.

Makes sense.

>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  builtin/log.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 5c9a8ef363..0d12272031 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1324,6 +1324,25 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
>  	}
>  }
>  
> +static void generate_shortlog_cover_letter(struct shortlog *log,
> +					   struct rev_info *rev,
> +					   struct commit **list,
> +					   int nr)
> +{
> +	shortlog_init(log);
> +	log->wrap_lines = 1;
> +	log->wrap = MAIL_DEFAULT_WRAP;
> +	log->in1 = 2;
> +	log->in2 = 4;
> +	log->file = rev->diffopt.file;
> +	log->groups = SHORTLOG_GROUP_AUTHOR;
> +	shortlog_finish_setup(log);
> +	for (int i = 0; i < nr; i++)
> +		shortlog_add_commit(log, list[i]);
> +
> +	shortlog_output(log);
> +}
> +
>  static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
> @@ -1377,18 +1396,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	free(pp.after_subject);
>  	strbuf_release(&sb);
>  
> -	shortlog_init(&log);
> -	log.wrap_lines = 1;
> -	log.wrap = MAIL_DEFAULT_WRAP;
> -	log.in1 = 2;
> -	log.in2 = 4;
> -	log.file = rev->diffopt.file;
> -	log.groups = SHORTLOG_GROUP_AUTHOR;
> -	shortlog_finish_setup(&log);
> -	for (i = 0; i < nr; i++)
> -		shortlog_add_commit(&log, list[i]);
> -
> -	shortlog_output(&log);
> +	generate_shortlog_cover_letter(&log, rev, list, nr);
>  
>  	/* We can only do diffstat with a unique reference point */
>  	if (origin)
