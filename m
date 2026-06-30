Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C13C4B82
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850372; cv=none; b=W5yhIxJt9ng7gmX4YMAnmu3eVAOeFcbxOJIo1aSS2yNuYR35GBiTH0/m5iX3T8cTop5ge4knGFYK94MuMVT5GWI1VjXjQfsDOvUoukwRoexil9m+4n9gQk+VVdaNmrWc4EI7yWPpIQrl4oQN7vgeQ4/EEZSsZj+u84WppqTmcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850372; c=relaxed/simple;
	bh=1bjLg5TQwAHNBMGMwAtLLwV1o7WWtGMqHjnuBbGey90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p56CZLZ3tL+lsDkhEhBP13XfH4QJecJLDtBOc8xCTbZ3tUNYZ5xvjq+1WfhotTsMtbEhx8HjqBPQByPhoqJB9oxmQPtffp0PpSm5Uee7LEF5bL+nlOPuY1ARXZmNGkZqIyITRGmG+d5/ABs1u8QFC2ZOeJzEsqhRDlIDUWjseSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a/8iNB6J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itI2z2wt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a/8iNB6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itI2z2wt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 11646EC0091;
	Tue, 30 Jun 2026 16:12:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 16:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782850370; x=1782936770; bh=A6GQahaCUG
	Qzs6RAZq3lA2xx+hK+sSJYeOvVwdo0o6Q=; b=a/8iNB6Ja0QGBBEkQVVC/6PvK+
	kJUDaDmbdJf8qYlzGyFKSj0Bk7JY69XdsiMcDWHWEUB20ksTKIZ9WbpDlh9CQziX
	Huu8FvFDtH2F5eIGQqOSkXG4diz47ibcdscZBt3UhJA4klSjuXpPatponBOr4ARs
	raE7mxO7qfS69qJrOODIUCXNtrG9VJ5IbK5Qv0n5747bOKpmKYZvF3Y8v8twe5hp
	oN7gY7MxhaeSr2PhnMkHXifCfOaguPlZ1pU+QdrIJUE6mNe5bybfTaQz2EBQFTLj
	nVLukA5nU/ArKbiQSVE5FY71wx0hErF5C4Y8cNjX5krsqyJM0WBqm+IfpSqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782850370; x=1782936770; bh=A6GQahaCUGQzs6RAZq3lA2xx+hK+sSJYeOv
	Vwdo0o6Q=; b=itI2z2wtY2dKGt2bGrv6bhghm46s2P8v7zC82HPzcegWh2K9jQr
	D2A8pUZ1M3I+ZSJAkShl3MQRnkWBXgxvM4VUI9uHVImgYj1JQL/SVkK4NkFkuUfl
	NrLM9ihOaNZwqGU/gfTWdxO0qFcc0x4xFebQis1nE5rhFfmMiP7FoncnpuQNFOOG
	CtEzCMLM92lMS6TowPNO8Cuh7Hsgdm1ewMXwBzYzo8QkQjf4E5eQ+UQLrKb9mcwD
	L6wEORYqVGv+ZYlyn86N/sdoAsf5dVGM6qWVKN6Lf48edxktSJMkJD4ZFOGDAuAW
	PVXxd7eTpeFU0eVBlsqF/R/gBN0F2/4Qe6A==
X-ME-Sender: <xms:QSNEavKxUFL-4u2_0mchjCh1JBNRT7HDRX2VAhSyW3yR4IP9husnjw>
    <xme:QSNEaqLwgdaqW5Ov5r775nzkIn4jBkfVjJ9rftcvsmOMT1Q06uSg-nmdNR49FMY97
    G85mu9atAmDDkDjWXfBXXLKfungSMRW8tLG1yD6R4bmjok8rrIS>
X-ME-Received: <xmr:QSNEassOx9LGBLmqRHkbv2RuvnJTN0ZDK02_VZzvxR32pW485Hfss5OubjYxIigHI-8AAsZVGYxy17OeYm9qVEeiI1PaW2Noe-1mK-w>
X-ME-Proxy-Cause: dmFkZTEnlw9CkaTChjaCgXl4N2dEyLsYPIJjetieweXQO6C4UiFwBKelilp3yDNAe6AVaf
    JSxQEzg4wwI4RcKitFj7QvfbT6YaxMSEwCxDFzGvMHZVdeIMaDwPJI3bIhy8wbGShnrSoR
    CC3p78IUMNQ31xX28lAUdaVCTosCQdFoWwhftaDxc5cJinuBavcea2Di6ddD7lnSb5Jdvm
    oI3xH45mAQsARF8Gl7jfUmCcMwO1uBChyWE+x0cFrDhdz7QBW/f2l2VJiYm33kFWTlM2Ro
    MLLMotXTb9bhDnnUsfH/V/iOK4gLKI/VSwR5YYR2ctvBIuiqDRY805m8+FlR4DztumeDLg
    R0P060VaG3EnarmPRSMhYnD5aUIAY+p5i4ya+LONPzqRqF21sQniWA6XotrNgW01w0YavF
    M2ZnV0kEcGKvdDSDbJscCLVet0+i0AEHVIPe+foKl9CLEQQZ45he3M3SHSSWrOymy3Koba
    5dmvzpclu/0NJI5hdjPizcNxeIkRoEjk9xh8U5QxuDVBi2XuqJxgA8MPNf0vfvyQbbBaIB
    MexJARerKIFUjRrtoqOgjJUjfkJQB98QyIkB+pfRtdubT6N1EZMK0LE3ZAX8JxKfSBDY1O
    eR9ygm+n+9KGgJO37sDQSo/xjG9QAiiL9OXhBltj/ce7f0wML2Q9x0LSBKMA
X-ME-Proxy: <xmx:QSNEanS8TxyZ2IXsyRRRIrXUvuZ_dzB5-OAutZ-PBZ3-9pIYZYlSjQ>
    <xmx:QSNEaiOrdLGX-aYS8oRuURl-a-FKLPikt4L74smybGSMOEkhekUjnw>
    <xmx:QSNEasadSM1m25nDqFUK_NxODX6JS7vlEXLl3JAwt87FGuRcJuGXCg>
    <xmx:QSNEaswkHlTPTBU_hjqw2wHoOGMC8-XyNuZEfDSzLJLn7cJ-NpbipQ>
    <xmx:QiNEaiHSH2HHaUHm3r6p31k-BHn3X1zzNyY3ruqLuD-ohIq9JhvXoHQ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 16:12:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: RISHAV DEWAN <rishavdewan10@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1] config: fix case-insensitive match for old-style
 [section.subsection]
In-Reply-To: <20260630124850.2498-1-rishavdewan10@gmail.com> (RISHAV DEWAN's
	message of "Tue, 30 Jun 2026 18:18:50 +0530")
References: <20260630124850.2498-1-rishavdewan10@gmail.com>
Date: Tue, 30 Jun 2026 13:12:48 -0700
Message-ID: <xmqqldbvrdmn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

RISHAV DEWAN <rishavdewan10@gmail.com> writes:

Thanks.

Although this was originally CC'ed to me, according to "git blame",
most of the code involved in the "bug" (i.e., matches() and its
caller) seems to be work by Dscho around 2018, so I'll redirect this
review in that direction ;-0.

> When writing to an old-style "[section.subsection]" header, the
> config file parser always folds the subsection to lower case
> (get_base_var() lowercases unconditionally), while the key given on
> the command line keeps whatever case the caller typed
> (do_parse_config_key() deliberately leaves the subsection segment
> untouched). matches() compared these two forms with a plain strcmp(),
> so a caller passing an upper-cased subsection (e.g. 'git config
> section.Subsection.key value2' against a file containing
> '[section.subsection]') never matched the existing key and a
> duplicate line was appended instead of replacing the value. This was
> a known, documented limitation (see the now-removed BUGS section of
> git-config.adoc).
>
> Track whether the currently active section was parsed case-
> insensitively (old-style) or case-sensitively (new-style, quoted) in
> struct config_store_data, and have matches() use that information to
> compare the subsection segment of the key accordingly, instead of an
> unconditional case-sensitive strcmp().
>
> Signed-off-by: RISHAV DEWAN <rishavdewan10@gmail.com>
> ---
>  Documentation/git-config.adoc | 21 ---------------------
>  config.c                      | 18 +++++++++++++++++-
>  t/t1300-config.sh             |  2 --
>  3 files changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
> index 57af010ade..11dfd802b4 100644
> --- a/Documentation/git-config.adoc
> +++ b/Documentation/git-config.adoc
> @@ -634,27 +634,6 @@ http.sslverify false
>  
>  include::config.adoc[]
>  
> -BUGS
> -----
> -When using the deprecated `[section.subsection]` syntax, changing a value
> -will result in adding a multi-line key instead of a change, if the subsection
> -is given with at least one uppercase character. For example when the config
> -looks like
> -
> ---------
> -  [section.subsection]
> -    key = value1
> ---------
> -
> -and running `git config section.Subsection.key value2` will result in
> -
> ---------
> -  [section.subsection]
> -    key = value1
> -    key = value2
> ---------
> -
> -
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/config.c b/config.c
> index 6a0de86e3a..7f086fcd75 100644
> --- a/config.c
> +++ b/config.c
> @@ -2594,6 +2594,7 @@ struct config_store_data {
>  	} *parsed;
>  	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
>  	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
> +	unsigned int subsection_case_sensitive:1;
>  };
>  #define CONFIG_STORE_INIT { 0 }
>  
> @@ -2613,7 +2614,21 @@ static void config_store_data_clear(struct config_store_data *store)
>  static int matches(const char *key, const char *value,
>  		   const struct config_store_data *store)
>  {
> -	if (strcmp(key, store->key))
> +	/*
> +	 * The subsection part of "key" (key[0..store->baselen)) was parsed
> +	 * out of the config file using the case sensitivity of whichever
> +	 * section header it came from (see store_aux_event()): old-style
> +	 * "[section.subsection]" headers are folded to lower case while
> +	 * parsing, so they must be compared case-insensitively against
> +	 * store->key, which preserves whatever case the caller passed on
> +	 * the command line. New-style "[section "Subsection"]" headers keep
> +	 * their case, so they need an exact, case-sensitive comparison.
> +	 */
> +	int (*cmpfn)(const char *, const char *, size_t) =
> +		store->subsection_case_sensitive ? strncasecmp : strncmp;
> +
> +	if (cmpfn(key, store->key, store->baselen) ||
> +	    strcmp(key + store->baselen, store->key + store->baselen))
>  		return 0; /* not ours */
>  	if (store->fixed_value && value)
>  		return !strcmp(store->fixed_value, value);
> @@ -2654,6 +2669,7 @@ static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
>  			!cmpfn(cs->var.buf, store->key, store->baselen);
>  		if (store->is_keys_section) {
>  			store->section_seen = 1;
> +			store->subsection_case_sensitive = cs->subsection_case_sensitive;
>  			ALLOC_GROW(store->seen, store->seen_nr + 1,
>  				   store->seen_alloc);
>  			store->seen[store->seen_nr] = store->parsed_nr;
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 87ca11a127..eaa3b83990 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1499,7 +1499,6 @@ test_expect_success 'old-fashioned settings are case insensitive' '
>  	EOF
>  	q_to_tab >testConfig_expect <<-EOF &&
>  	[V.A]
> -	r = value1
>  	Qr = value2
>  	EOF
>  	git config -f testConfig_actual "V.A.r" value2 &&
> @@ -1511,7 +1510,6 @@ test_expect_success 'old-fashioned settings are case insensitive' '
>  	EOF
>  	q_to_tab >testConfig_expect <<-EOF &&
>  	[V.A]
> -	r = value1
>  	Qr = value2
>  	EOF
>  	git config -f testConfig_actual "v.A.r" value2 &&
