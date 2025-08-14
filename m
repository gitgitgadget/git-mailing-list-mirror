Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06624167F
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186156; cv=none; b=hyjajoQclGbNw96dz1nXQWtGSUvrrIq/pQh2KMyJvkrVgSX0gmZIGhrgnnVj+jmea1txrFYDxO9xewtIl/ksPknQb3auFM4RHu0iHo4JbpuEcNdTVNuwm3J6x4/LqsSRTHUlCWp/aMlLJZeGUP4I0gz1nhy5gu7VgdZUUpdyxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186156; c=relaxed/simple;
	bh=dadU2Usv6R9refrNA5TF2Ir8a9k+uHOYJO79V96whWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hRGZ+ePFvD3NzcukM335CZpi9GzCRZdK7pea+Tn/W1Wp1VupEfmWuDVvHVZ1XsjXQQtkk3kVt4JumfnfZBM6HzVWB6RZVEty6jd3BHX4SYGXXnXGBiUi1xuTAf+N29xExUuCkqcsqBwDHzYcdNtJ34IG7Gz2FXrxpkNTnuBji0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b/8IfFyJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acL/TW1M; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b/8IfFyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acL/TW1M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CA5FAEC00B0;
	Thu, 14 Aug 2025 11:42:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 14 Aug 2025 11:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755186153; x=1755272553; bh=/FgTmeOV2/
	GiwA/0IjlmRYx0txQPvCQMJVtDHE+W8mg=; b=b/8IfFyJHPXI149j+Ecw8akz3S
	kPEYSJ+2Rj7TJP33D/ZeZHKyjTZOaYL9Nh4hVwJnlzJv8a5ZozPTdQHr7xoH3cbk
	R5xLEgD7caD+GE/X9FMkL/lqA1pO/3BRJEfX8/8qghYMnzN1/YZxJYsOkr5ZnoSi
	ANQXw8gVbl1m8SqGGkBf8FVYlLgADEYjXu6Ze1zu9MQ3sQc4gqYebzLNPt9F3gFH
	pML6tcR+kaU6GX7S2BR0iPiCB6HEa7sBvzEOgD8qtkIcLJ3XazZyFoNKyrsHrh4N
	OiaeULh8PhG+oMe/XPnYzd4WzcFzs4X8tgt4hbPsp4Kin1cWlNeT+ivk8V6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755186153; x=1755272553; bh=/FgTmeOV2/GiwA/0IjlmRYx0txQPvCQMJVt
	DHE+W8mg=; b=acL/TW1MCUw5HxaiI2MFOKa/akuxS0ITSU2JFvb3QZzkHfBrq2A
	npaeV9m20gea0A+Osx+2c9wxKPCbaWuVjoagFN9QM3VS4z8j27dTKzGwfT9/twrv
	N9bb6en0EMcCj3AxH/hLLVpevzDRPFFFLafkXeH/PEHGnFlRv/4z3tWZdlUX0S7z
	EzemIAKbpn4cNnigPsmGXti4qtLSiUuusjbXDcZVKT9gocmyFwJ+GZDC7CV7LKvg
	unu5ijut9w/4OJsKZJ6F2J0c/bxY1AHGyvxDhBufiFmzJ5y9PzXdMG6/Nqj3+Bjr
	z6nspToWNfS4Q0f76JOdj2Es57Ao42w3+gQ==
X-ME-Sender: <xms:6QOeaBCaYKL_RjcQ9Gty_3QV_6Cdgbx80CvlyiMWbVO0VDF7V2md_g>
    <xme:6QOeaCwByghjr8OkAxJ8ZOMnPOvexZt5Q9cb7jeih8NKELxXrRH9xcuqU_6arZqf_
    lH40PtYm7OFasHpcQ>
X-ME-Received: <xmr:6QOeaGCLamBfg8WKNEAbXpx9KyqEe3U-LkJ6LpDy_SJEMScRW56DzucoaSK2i2wPdNFT6QCGj8BjSsJqb_VIKEt5qKiclPTu4cYj2x8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmlhhssehs
    uhhsvgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6QOeaHYTd-2ZrwuNJd4PDkVZcOYKT7lTClNoxVbIVETDObufreReIQ>
    <xmx:6QOeaGjOiGYBIPJv1XHA4XtiNr5AA3ghmkGJIbnffOd4c2OT4KSamA>
    <xmx:6QOeaB5cZHddh8xThfInSq64NiZ4jx61D_OztjADvbCgneIYQDZEeg>
    <xmx:6QOeaF7tVFOgVuZaoGFA-hPrJC48rb31_EyCLoyu2G7spLyxqgDR7A>
    <xmx:6QOeaKDZW_XFYWosh3Se-6vb_MwYzE_aYYRBeQW1NBaf-FihnjM8Ll9u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 11:42:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Schroeder <mls@suse.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] submodule: truncate the oid when fetchig commits
In-Reply-To: <aJ37eHEGMw6RgmZC@suse.de> (Michael Schroeder's message of "Thu,
	14 Aug 2025 17:06:32 +0200")
References: <aJ37eHEGMw6RgmZC@suse.de>
Date: Thu, 14 Aug 2025 08:42:31 -0700
Message-ID: <xmqqqzxd6haw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Schroeder <mls@suse.de> writes:

> If a submodule uses a different hash algorithm than used in
> the main repository, the recorded submodule commit is padded
> with zeros.

Hmph.  I suspect that this "extra zero bits" would happen when your
superproject uses a longer hash (e.g. SHA-256) than the hash used by
the submodule you are fetching?  If the arrangement is reversed,
would we see a different and possibly an even severe problem?

I do not mean to say that you need to solve the problem in both
direction at all.  But perhaps

    ... uses a hash algorithm with shorter hash length than what is
    used in the main repository, ...

would clarify what problem you are solving in this patch better.

> This is usually not a problem as the default is to
> do submodule clones non-shallow and the commit can be found
> in the local objects.
>
> But this is not true if the --shallow-submodules clone option is
> used (or the --depth option in the submodule update call).
> In this case, the commit is often not reachable and a fetch of the
> specific commit is done. But the fetch cannot deal with the zero
> padding and interprets the commit as a name. Because of this,
> the checkout will fail.
>
> Implement truncation of the recorded commit to the correct size
> corresponding to the hash algorithm used in the submodule.

When we use the verb "truncate" in the context of this project, I
think we always use the word to mean making it shorter than its
natural length.  But in the above, the word is used to remove excess
so that we use it at its natural length.  I cannot offhand offer a
better phrase, so I'll let it go for now, but suggestions for better
wording is very much welcome.

>  builtin/submodule--helper.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 07a1935cbe..ef21eb42b8 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -72,7 +72,7 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
>  	return resolved_url;
>  }
>  
> -static int get_default_remote_submodule(const char *module_path, char **default_remote)
> +static int get_default_remote_submodule(const char *module_path, char **default_remote, const struct git_hash_algo **hash_algo)
>  {
>  	const struct submodule *sub;
>  	struct repository subrepo;
> @@ -106,6 +106,9 @@ static int get_default_remote_submodule(const char *module_path, char **default_
>  
>  	*default_remote = xstrdup(remote_name);
>  
> +	if (hash_algo)
> +		*hash_algo = subrepo.hash_algo;
> +
>  	repo_clear(&subrepo);
>  	free(url);
>  
> @@ -1272,7 +1275,7 @@ static void sync_submodule(const char *path, const char *prefix,
>  		goto cleanup;
>  
>  	strbuf_reset(&sb);
> -	code = get_default_remote_submodule(path, &default_remote);
> +	code = get_default_remote_submodule(path, &default_remote, NULL);
>  	if (code)
>  		exit(code);
>  
> @@ -2319,16 +2322,19 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
>  	if (depth)
>  		strvec_pushf(&cp.args, "--depth=%d", depth);
>  	if (oid) {
> -		char *hex = oid_to_hex(oid);
> +		char hexbuffer[GIT_MAX_HEXSZ + 1];
> +		char *hex = oid_to_hex_r(hexbuffer, oid);
>  		char *remote;
> +		const struct git_hash_algo *hash_algo = NULL;
>  		int code;
>  
> -		code = get_default_remote_submodule(module_path, &remote);
> +		code = get_default_remote_submodule(module_path, &remote, &hash_algo);

It feels highly unsatisfying to have oid_to_hex_r() blindly read and
convert oid to hex (assuming the hash length of the current
repository) without using the knowledge of how much of that object
name is valid.  We obtain that knowledge shortly after we call
oid_to_hex_r() in hash_algo here.  That is the only reason why we
manually have to truncate below, isn't it?

In other words, shouldn't we be finding out hash_algo first, and
then use something like hash_to_hex_algop_r() to convert only the
valid bits of the oid into the buffer?.  That way, we do not have to
manually add '\0' in this function below.

>  		if (code) {
>  			child_process_clear(&cp);
>  			return code;
>  		}
> -
> +		if (hash_algo)
> +			hex[hash_algo->hexsz] = 0;	/* truncate to correct size */
>  		strvec_pushl(&cp.args, remote, hex, NULL);
>  		free(remote);
>  	}
> @@ -2635,7 +2641,7 @@ static int update_submodule(struct update_data *update_data)
>  		char *remote_ref;
>  		int code;
>  
> -		code = get_default_remote_submodule(update_data->sm_path, &remote_name);
> +		code = get_default_remote_submodule(update_data->sm_path, &remote_name, NULL);
>  		if (code)
>  			return code;
>  		code = remote_submodule_branch(update_data->sm_path, &branch);
