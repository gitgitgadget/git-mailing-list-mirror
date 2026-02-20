Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770191BCA1C
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558823; cv=none; b=i3NRGXiZzBZnjfLx8PgGTk37whzyxiFz7P4BT2utQdTjnmR2tDrszv2Rts+sTYkU5fL3qkIlfKZuSd9vg6r7Lil1D6kbpQnKbXFQNfBGRKPpZoeG3Gj/51RTlfBmSwOfuhzjizmsgPuvSpsVrI4w8UrIVdCvEuyzgz68OoMqIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558823; c=relaxed/simple;
	bh=obaVtlAb2sHTHevQfYVOfCXtmH05foBau06U9glHR4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxS7Lt8k3MYgukMuyKGYUAlyxmyBKPrkqtlEFUOl3q5qSfEHPmQqOlMmkNOufNCAzwUaIbADR1bd5F9ata+Fg+JqDbYANorTVdGekgS4RZCESAT7cSq2Y4tuMzumBTY8RKztPj1sgvC/ypisGfnD3DnKuo4CnAatwRO4YZkP9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnx0R1u1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3lY462H; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnx0R1u1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3lY462H"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C6F114001BF;
	Thu, 19 Feb 2026 22:40:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 22:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771558821; x=1771645221; bh=svXQ7S+wvj
	08JZKbFSN5I6BPgAQY89OXAaf9xaSzNio=; b=gnx0R1u1Yoqie2zRfsmui9HRFx
	tnfk7Yt/2IyjBE5fqSlpDZ8l59HLiCU9YjHQ6QSVsZbVcKSBg+pAdVCaH4QzIWkZ
	jcj2BkmTzeah1Q55aiuo/1LS54sOKjEVD0fgMRM57V5hStX4Rn+Cnz8pAMxROtYN
	WoIYUY45fsJzI3nNjNXVSjM/CpcNOgF9x0etV/8WNARTeOzC/8XsMRZQUl8xs0ii
	9ZABzjkoHgzK21nSywiRj/cZGL6Jd5oduKZCy9GJqunTaICklaDr734Sq1AVvllI
	wHR57va0CI7s99wtSg5sIhmpCpHNyBfJAy1/H1iflJd2WaL5V3HHHkOI0aZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771558821; x=1771645221; bh=svXQ7S+wvj08JZKbFSN5I6BPgAQY89OXAaf
	9xaSzNio=; b=e3lY462HW4k5+8T0e0zpVjumurugN3cTWm1L57WJ4GV5zk9L031
	vO8T+H8pdOxpMAKW98H1CLUvzJj5qXeCE7V/tlCiZn9k56W/PhU/w+HjhzK0qT19
	TDaMevE799rt2xzDctDaROuYlrr70xONWYfvn2zCB4BZe+p+BJFr9tbJ+uDzGFxS
	dNrZgqzgAdzrzXQd6pk9HE32FDQFEsgcaLt0b7Shcfnq1BlSAVFRhd/CEFyfuN+F
	xFhiomX8DlkYZnJkDkEAsVq5pHrX/rkmx3UJgQi8mdF6HWvoCbnO+2iKlkjztbvf
	J4kVoNAgEa8BPIqn7MGIG1EMcowES8gbiXg==
X-ME-Sender: <xms:pdeXaRd2QZTxMzTm2LEYzfhKOJFadf4J5peoZRyUgL09pu6-KRJAaw>
    <xme:pdeXaWOyWiLR9BUKB_-bu2jdoy_mDaPeAReGfLQPXKVWUgxQHjtRtWKLC0Bros_yg
    of9YR5JRqRG6KSBkiywApoUSvWB2OXWG2jcQ5SHrLNZCvJawUUg7g>
X-ME-Received: <xmr:pdeXafjzENi7a7F9obTJ5NApwyY5-M6PBIJ9MVKwxvUFsHXmS-Mjhym4lRI_0D4xXP69hV283D0EHyPpZpexnVNM4fiOuHcg2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pdeXaZ2-KAyTJ2Hzu2v-DOC0VSqiSZVmHHefbTiz9diZnTQmN39byQ>
    <xmx:pdeXaZhsl1SOEMl0ubnw16vBrs21KeO0fjlE7fEywWNkk-kN4Jq-iQ>
    <xmx:pdeXaZcawEorSG2HYOqpAAF3KZYCavR-4MjdVYEAwL5ZMBZJmmdlCQ>
    <xmx:pdeXackPzmg2Nl4b0OS3Oyv1FkHtHHiZXiErBeb-Hso4cHt34A_m2g>
    <xmx:pdeXaTDA9zYEn2rTW9IiT7j_hHSxdZTv4do5m6HZiI6HVelp67-3G1SF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 22:40:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v7] setup: allow cwd/.git to be a symlink to a directory
In-Reply-To: <20260219071650.208074-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Thu, 19 Feb 2026 15:16:50 +0800")
References: <20260218124638.176936-1-a3205153416@gmail.com>
	<20260219071650.208074-1-a3205153416@gmail.com>
Date: Thu, 19 Feb 2026 19:40:19 -0800
Message-ID: <xmqqh5rc13rw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> diff --git a/setup.c b/setup.c
> index c8336eb20e..5a573e5865 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -897,10 +897,13 @@ int verify_repository_format(const struct repository_format *format,
>  void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  {
>  	switch (error_code) {
> +	case READ_GITFILE_ERR_STAT_ENOENT:
> +	case READ_GITFILE_ERR_IS_A_DIR:
> +		break;
>  	case READ_GITFILE_ERR_STAT_FAILED:
> +		die(_("error reading %s"), path);
>  	case READ_GITFILE_ERR_NOT_A_FILE:
> -		/* non-fatal; follow return path */
> -		break;

This comment is now lost.  Shouldn't (at least /* non-fatal */ part of)
it be moved to those two new non-error codes we see above?

>  	if (stat(path, &st)) {
> -		/* NEEDSWORK: discern between ENOENT vs other errors */
> -		error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		if (errno == ENOENT)
> +			error_code = READ_GITFILE_ERR_STAT_ENOENT;
> +		else
> +			error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		goto cleanup_return;
> +	}
> +	if (S_ISDIR(st.st_mode)) {
> +		error_code = READ_GITFILE_ERR_IS_A_DIR;
>  		goto cleanup_return;
>  	}

OK.

> @@ -1578,20 +1587,25 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		if (offset > min_offset)
>  			strbuf_addch(dir, '/');
>  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> +		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
>  		if (!gitdirenv) {
> +			if (error_code == READ_GITFILE_ERR_IS_A_DIR &&
> +			is_git_directory(dir->buf)) {
> +				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
> +				gitdir_path = xstrdup(dir->buf);
> +			} else {
> +				if (error_code == READ_GITFILE_ERR_STAT_ENOENT ||
> +				error_code == READ_GITFILE_ERR_IS_A_DIR ||
> +				error_code == READ_GITFILE_ERR_NOT_A_FILE ||
> +				die_on_error) {
> +					read_gitfile_error_die(error_code, dir->buf, NULL);
> +				} else {
> +					return GIT_DIR_INVALID_GITFILE;
>  				}
> +			}

Is it just me who finds the above harder to follow than necessary?
I would have expected something like

	if (!gitdirenv) {
		switch (error_code) {
		case READ_GITFILE_ERR_IS_A_DIR:
			if (is_git_directory(dir->buf)) {
				...
			} else if (die_on_error) {
				die("'%s' is an invalid .git directory", dir->buf);
			} else {
				return GIT_DIR_INVALID_GITFILE;
			}
			break;
		case READ_GITFILE_ERR_STAT_NOENT:
			/* no .git in this directory, move on */
			break;
		default:
			if (die_on_error)
				read_gitfile_err_stat_noent(error_code, ...);
			else
				return GIT_DIR_INVALID_GITFILE;
		}
	}

or its equivalent, with the top-level switch rewritten into
an if/elseif cascade.
