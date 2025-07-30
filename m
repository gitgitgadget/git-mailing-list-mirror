Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EF1917D0
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887518; cv=none; b=QZfPPAtICMl9VeMfxPM4viUHEsnQN7vju0EzmBQ+XZp9adWBfgxYkCfK3MgodPowrKqsEzVliF4YaYezcXiC6RfG/Xs99v5IRGWqroffq+gIOWTePhoxJdDknOTMYZdRX9cpOFTt868O2E7IT+QR4woojZgnDLe+y2mlCRc8Tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887518; c=relaxed/simple;
	bh=QO1wxrctuvP2CO7hTjRuSpVh2FPB/5z1AFRjhDIj99Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oezw9Z4LtK92NByBBaeexyVgWhNelaNE1nAKZke9iPZ2ehoBWfU05oSLIexejsySsPEl68dTC7blZ4A4ZqUq3DD5AxnmN8DhVS7E1wZ6cAC+PlRqWzV6Uv5TBOhZX6V1l2dP4hqOXKK1DM+Fu/2RgMir+q8Rr9TPyhIgyX2E5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dSVqIhIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJImtIsP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dSVqIhIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJImtIsP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 730901401F9D;
	Wed, 30 Jul 2025 10:58:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 30 Jul 2025 10:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753887515; x=1753973915; bh=NGxr8hNIus
	ljWgZU3FJJrS6nkNqZcWkw/uPiC16s4z8=; b=dSVqIhIggeld9zZRnr3Vb0pzb/
	TuLEHYJuMAlyAZ5FmlKboJtsPGg1k3ckz9V3ESXXAKzEpn0izzeyoRuKs+GEaQL9
	gDvfM9VluxXXApuceXHeUqHVqjICM1745QbVN/9pTwOWpJRoRUCj8KjefVQ3EKjT
	xi1pOT1HUzPPsWlKd1gWj8sTYF9krGhq3v9Mh4jRA7mlmtC0LMPken7CKX4qvgNf
	Q5WwgySAlR5Cc3XOn9N+9pbk5VLCxJG7wsQ5Hxq9pp/n76BspHZNQqhd4VmewZsB
	cAKWjowdftu7ebKCkTBgCGQUpjeVyzmiOa7W/bCMUp61aqJONd4/oJ2E0Y0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753887515; x=1753973915; bh=NGxr8hNIusljWgZU3FJJrS6nkNqZcWkw/uP
	iC16s4z8=; b=cJImtIsPVlhWmLm0ETJX19w7Lo5Y1eOvnamz66UBYQpNR7AH37J
	h/1oFztmJJAZ0o6XnBY9bCSEy/8cHGZImN95wGr6pIrfRchhO3dM/mKP1SWhuGLK
	2JSBPan94qQKxkMuDI8DMx3pXAXJE4cKr8/jaj9rGnQ7mjpG93fjYmVSSzNOZlEd
	eTAgvrZhbZ+y6+T8Eo3m300QnjgNHybkerEOsuQVuRvENSmXDQsA7VLq7Z6zwN6A
	w303lLjjHm3fzpeJRx8uoyH3plFcI0OUE0q6ebieAELZVoOYev0hSB2QfGzgGkRR
	M7FHJQnqbrzmOMj1S1m2xdkSKPK298UVq7g==
X-ME-Sender: <xms:GzOKaEIN1Djh_kRPNCe_nZ7Y6PijX1LBG5tJX6pYI9Nn8MMleOo1Xw>
    <xme:GzOKaOv-9Jhs9pLN4j6b6y4QdTPoxPVq4iJ1HePkxQfYrEGxL6t1bakCcRqIgurif
    pW2dioZYaImTBMykg>
X-ME-Received: <xmr:GzOKaBS6G-FlUUbsmGDb44tfvPYVu-pFO5nON4HAEQG10SrxB6X2HTniEsC8S2pWSCdRgjHFegq_MDDPJ1Kxz_ONz5K04qlt5mO_M0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thgrtghhvghrrghsrghsihesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GzOKaENorVEEBUgU87ZL96YurARZkznCbE20TPmVBCy5ZEmke637Tg>
    <xmx:GzOKaGbk2xhizZEgAbkLKVwZbL465w9ubXENbBJRRHM3N8nZfjkHvA>
    <xmx:GzOKaOz2xq4bXbZXvkYhkD-Q0mr_ttzeTSdq_AU5aSbyZvEaA1tlMQ>
    <xmx:GzOKaBIRTJEB9I2R64gQhbTgDnq-p_-pmg_ukGWzy2qIzmLCx4t4Bg>
    <xmx:GzOKaN7I_Latlm5RWtrYhRud0Y6HpkcqsbyF_4uz9emPL6skv46_O5pf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 10:58:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Tach via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tach <tacherasasi@gmail.com>
Subject: Re: [PATCH] status: add --json output format to git status
In-Reply-To: <pull.1937.git.1753856826464.gitgitgadget@gmail.com> (Tach via
	GitGitGadget's message of "Wed, 30 Jul 2025 06:27:06 +0000")
References: <pull.1937.git.1753856826464.gitgitgadget@gmail.com>
Date: Wed, 30 Jul 2025 07:58:33 -0700
Message-ID: <xmqqo6t1n2sm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tach via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: tacherasasi <tacherasasi@gmail.com>

> Add a new --json flag to 'git status' that outputs repository state
> in a structured JSON format. This enables reliable machine parsing
> of status information for tools and automation.

The --porcelain format is meant to serve this "parseable for tools
and automation to read" use case.  Was there anything your parser
couldn't fathom out of the format?

> This provides a robust alternative to parsing traditional output
> formats, making it easier to build reliable tools and automation
> around Git status information.

The writer is obviously biased ;-) but I find this a bit hand-wavy
and unconvincing.

> Signed-off-by: Tachera Sasi <tachera@ekilie.com>
> Signed-off-by: tacherasasi <tacherasasi@gmail.com>

It is not like two separate people worked on this patch, or somebody
at ekilie worked on the patch but asked a different person with a
very similar name to send it on their behalf, right?

Perhaps update the user.{name,email} on the in-body From: to match
the one used on the first Sign-off, and drop the second Sign-off?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index fba0dded64a..f1db4fdfd9a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1540,6 +1540,9 @@ struct repository *repo UNUSED)
>  		OPT_SET_INT(0, "long", &status_format,
>  			    N_("show status in long format (default)"),
>  			    STATUS_FORMAT_LONG),
> +		OPT_SET_INT(0, "json", &status_format,
> +		    N_("show status in JSON format"),
> +		    STATUS_FORMAT_JSON),

There are now several ways to set to status_format now.  It could be
a good idea to make a preliminary UI clean-up to introduce a new
option "--format={short,long,porcelain,porcelain-v1,porcelain-v2}"
as a separate step, declare that any new format will use this new
option without adding a separate option on its own, before adding
any new features.  And then on top that, a new format can be
introduced without cluttering the set of options.

Not that I am enthused to see json here, given that we have
introduced porcelain format for the same purpose eons ago.

> @@ -1603,7 +1606,8 @@ struct repository *repo UNUSED)
>  		       prefix, argv);
>  
>  	if (status_format != STATUS_FORMAT_PORCELAIN &&
> -	    status_format != STATUS_FORMAT_PORCELAIN_V2)
> +	    status_format != STATUS_FORMAT_PORCELAIN_V2 &&
> +	    status_format != STATUS_FORMAT_JSON)
>  		progress_flag = REFRESH_PROGRESS;
>  	repo_read_index(the_repository);
>  	refresh_index(the_repository->index,

Also, we might want to tweak the bit-assignment for the
status_format constants to make this part easier to maintain (e.g.,
ones below 100 are for human consumption and gives progress bar and
ones above 100 are for machine consumption and suppresses progress,
or something like that), again as a separate preliminary clean-up
step before adding any new features.

> @@ -1735,6 +1739,9 @@ int cmd_commit(int argc,
>  		OPT_SET_INT(0, "long", &status_format,
>  			    N_("show status in long format (default)"),
>  			    STATUS_FORMAT_LONG),
> +		OPT_SET_INT(0, "json", &status_format,
> +		    N_("show status in JSON format"),
> +		    STATUS_FORMAT_JSON),

And if we are to clean-up with --format=<name> and build on top,
this part would become somewhat different.  The clean-up would
probably be somewhat like what opt_parse_porcelain() is doing and
"json" or "yaml" or any new format name would join if/else if/
cascade there.

> diff --git a/wt-status.c b/wt-status.c
> index 454601afa15..7192fb4d057 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2564,6 +2564,101 @@ static void wt_porcelain_v2_print(struct wt_status *s)
>  	}
>  }
>  
> +
> +static void wt_json_print_string_array(struct wt_status *s, const char *name, struct string_list *list)
> +{

We seem to have a json write-out library-ish helpers already; is it
too tied to its current use (i.e. trace output) and too inflexible
to be used here, or does the status output have so specialized and
unusual need as a normal JSON producing application that we need a
special purpose code here with bunch of fprintf() and manual
formatting?

Thanks.
