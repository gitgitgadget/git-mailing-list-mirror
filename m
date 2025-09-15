Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA35C96
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980717; cv=none; b=mrEZxuJEZkjHtQ3BDsG6zBATL2dbMMnadU3RK4T8TqV89v5LAXEI1eimdCRLSCotyICeuKpsdGToqATwbTJmtHRgYk6ThW/VKQwgbMSQZFtuP9skhWdD+ZYs6YLfW/oFJyMgcHsPrJJCiv0oOMNogN6AcclW3MuPLt/Igk0sTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980717; c=relaxed/simple;
	bh=HrHlzsdAANrK+fgj1bmiDExsko1vG99x2pgx2J1NDlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bm3rBM/88wIcx4m7zNJFI3xfqkOXBqYfVAH2AtfTVmQmew7BEXPrugvnbmCT5Ns+g6mn2mtrXerIpCIXdj5hiyeXTzv9vQ2ODte7qUoBflBOPvOQcjjT3m5ApBOKREr3wDDmBCqGYWr1ieMjSAJoCjBQxiJD92yu7Uyy63tNDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TSstcoHq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AE3y3UfF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TSstcoHq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AE3y3UfF"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C7FA1D001B3;
	Mon, 15 Sep 2025 19:58:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 15 Sep 2025 19:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757980714; x=1758067114; bh=GC+PPkogu6
	aj+XzBijhDBHmp+AwzGwRYE2OGR9dai4E=; b=TSstcoHq8YVPuG0S21H46dYfqd
	XAlFHQ5zJ5elUjMDpiABrqtH6+fsdfARtBf68GtfeMTh0qwJgmFKm5EokUb+vT9m
	jxDS/s2MaelLeHxvuNUlC8oIQ4yBo0BApQl8wJTkRdMZ9wWuWniEbzU2UoEoxuFm
	tKF3ixkthiqD2bmMSoc59h6jxKPxawBavjJKc03sV9fKKN9ITWQiZgSRXLyQW0On
	8s8lAxWdp3EFKdxn7y/sHbEZEpiaQ16Mg08tdkH62luP9BrqLeXJoVV7Sy97p53h
	uvh45q+EBQmUKWcuUb91PTl8OxiUvO1WWjUem52QmZwgcKHPpCzZZwOgTdLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757980714; x=1758067114; bh=GC+PPkogu6aj+XzBijhDBHmp+AwzGwRYE2O
	GR9dai4E=; b=AE3y3UfF7rccnN+oQi7zrV/285gyAAHt6W/Ckl+bmg3U8VqqVFr
	crvwJwAc7BHRO+2tVIElWb/pp3p4WauaOcrAlSJaJnDV8W6/wod/OLFGyvocCS32
	QDqzrA6IiOIiafbwGgTKPmHczCjli8fh7FuiINriQs4nsA58NNsixvXRlpR7NN65
	QD9uh/9MXfLjj7WKrRkT97oGGUtMiyZfxiPlPwzXDq/s0qM16s/JBFdQ6JZrkgn9
	QfdRvYmU+xlYJmdewoSm22jYMWIFOkgeObQsPXjQ1r3ceszHq3Ygjdbs1+veXbyV
	U+xvC5GYq7KkcM/qdAJZ/B1ZGw9TotJX4RQ==
X-ME-Sender: <xms:KajIaP_Nn6o29YlmIq7sVhkYsYbXmqmSS_K1eOVhWScEwrtO8vozog>
    <xme:KajIaHNiROWl3Wqku1SUsqAXFxhzore0cWIs1ukRRpDq1l-jUjFUcQkdR4JGUfnON
    i7SFdltRkz3Uk8N8A>
X-ME-Received: <xmr:KajIaDdnNhCH-LYy2xu3Qmcry8LCNDY_laHuwQCx3nM9AGm4YZcs1uQGmBxLn9TTvWHSs3tyBHp81f3XUlNFA4Aau7mz1gbNCROv2Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KqjIaGUZr9XjanUfXo9mPCqBmxQbETYPTSKlRev-6wCBgBhChTVjqA>
    <xmx:KqjIaLjndk855JWDokkWQQCadZi_ukZvgqfX4Vkj6mDTHxGDHLrJtw>
    <xmx:KqjIaF9BqS1mNTea4xV5yNOv8Hsk8dHaCPrXRf5H1fH0sZwNujgvnQ>
    <xmx:KqjIaNZw0R4uL3j9NOTaFm_40kgdQEr7h2pyjHzHz0iMn6DJC_zCDA>
    <xmx:KqjIaBsr0GovquTMjKnIQbNxwZKqEt02B0-6CqrIyvvfCvv8ACIsJhAH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:58:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [PATCH] repo: add --all to git-repo-info
In-Reply-To: <20250915223618.13093-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 15 Sep 2025 19:36:17 -0300")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
Date: Mon, 15 Sep 2025 16:58:32 -0700
Message-ID: <xmqqfrcnclp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add a new flag `--all` to git-repo-info for requesting all the available
> keys. By using this flag, the user can retrieve all the values instead
> of searching what are the desired keys for what they wants.

I initially read these three lines as "we let you grab all the keys
(without value), so that the caller do it once and then iterate over
them, asking for the values individually".

I think "for requesting all the available keys" can be tweaked to
avoid such a misunderstanding?

    for requesting values for all the available keys

or something, perhaps?

> -git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
> +git repo info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]

Wouldn't it be more like

	..... [--all | <key>...]

or does giving both --all and an indiviual key do something
interesting (like, just make sure these individual keys are valid,
but otherwise do the same as a simple --all)?

> +`info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]`::
>  	Retrieve metadata-related information about the current repository. Only
>  	the requested data will be returned based on their keys (see "INFO KEYS"
>  	section below).
>  +
>  The values are returned in the same order in which their respective keys were
> -requested.
> +requested. The `--all` flag requests all keys.

"requests values for all the keys."

>  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
>  
> +	if (all_keys) {
> +		print_all_fields(repo, format);
> +		return 0;
> +	}
> +
>  	return print_fields(argc, argv, repo, format);

OK, so "git repo info --all no-such-key" will silently ignore
no-such-key.  I do not have much problem as long as it is
documented, but there are a few equally plausible alternative
designs.

 * "git repo info --all anything" ignores "anything" no matter what
   they are, as "--all" makes all keys on the command line ignored.

 * The same as above, but it warns about the extra command line
   arguments that are ignored.

 * "git repo info --all object.format" is rejected merely because
   "--all" is defined to be incompatible with giving any individual
   key.

 * "git repo info --all object.format" works as if the command is
   given all the defined keys and then object.format, i.e.
   object.format is reported twice.  If you ask "git repo info
   --all no.such.key", it would fail while asking for no.such.key
   because there is no such key.

I think the first one is what you have implemented.

I see no practical reason why anybody want to pass a concrete key
when asking "--all", but the first one feels the least intuitive one
among these four.  I think the last one is the most logical that
lets users discover why it behaves that way the most easily, even
though it is debatable that succeeding and doing exactly what was
requested in that way is better than rejecting (or perhaps ignoring
with warning) these requests with extra command line arguments.

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 2beba67889..b1391a47b6 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -110,4 +110,10 @@ test_expect_success 'git repo info uses the last requested format' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'git repo info --all returns all fields' '
> +	git repo info layout.bare layout.shallow object.format references.format >expect &&
> +	git repo info --all >actual &&
> +	test_cmp expect actual

We would want tests that asks "--all object.format" and "--all no.key",
after deciding what should happen.

Thanks.
