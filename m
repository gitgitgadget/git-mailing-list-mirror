Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39223ABA7
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351121; cv=none; b=NYPiuomcCy+3WjrD+eoejP395IbxNxnz3tqCQn9Lhi+nQss6BEwfgWqGTN9Y5/PQmOIijqgr1kR0phFMCgcuBnf8iMazMlMhIi4X4i4YAibtM8R/Nx5PKcwNxFE82uMvloNljZDyL5cVyYL6H3+mRMoSQJ09Wb+vuHiYek7+c5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351121; c=relaxed/simple;
	bh=yfuZHtHvOPmT9Zj6FYuwZwIRA0Ot3jH28i4EiCwoelQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L3J6LdZOUgcTM4Cm+UjQMXTFczyb+zCQsMuklofmj3LGkMJabJH5N7P8T+4S91jbE+gfEzXFyPkjrrGjIRpj/PdgkE8q4Onk0XS2aPUFZ54CkiZ7b8saa4nFeMRGF4WKLV7gupMkRODDm/o0LU7j5igMGwEPv7WxZgXrhrFyQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TfD9T52T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XyEDUEtp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TfD9T52T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XyEDUEtp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4F8725401BE;
	Thu, 19 Jun 2025 12:38:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 19 Jun 2025 12:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1750351117; x=1750437517; bh=urOSbV5JV0jTs5to9joPyr8BQTldKIWP
	r3WR5vn7kuY=; b=TfD9T52TwUn/uuX9ABJ6UAxlF/LOjloteaZDMy72efvyS4dL
	8RtuGMiwNuAFgSPDmDcxvYHIHFx6H4QDTj7cFRjLa6Amp3EZ7fj2BlIY7aE0qKqB
	vG/hNj7j3aqq0oLUw5Hu+2f+WfUzv6lbrP+zhvTjsJPyUoHnxWm/TS+bIRCSfKQi
	6KTS/Mpwq1jmHCgEz2YC24E6Ff+Sm1Q59BzFm3S7kBQ9+shZ1h1w8L9f0/rpsYnX
	2PMBmPL8DlKBIu9u/gnxskA6PNxCSGv8SmkNNN5iKrhfuaG9yCKYaIU9bwEysxAO
	37+QJW9I7oBaI3DpyJkkDPy+EP+RFedB0yXw0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750351117; x=
	1750437517; bh=urOSbV5JV0jTs5to9joPyr8BQTldKIWPr3WR5vn7kuY=; b=X
	yEDUEtpaEZXzAjXkqP4d2zEefI74DCp+PLxMSd+UlOUA+lIcE1JDLe9Oel09Vkpl
	zUTt0l9kQgbdMR36ROLUllB4BgQRd7yhjIzLP34bP1W0M54MxWZAeAaYWVsNn5Jo
	e77bEOGvDJ9RBW0VG/AncfE0n+Nm/u3nRh/QVqp3kv1BxnKAMiZ+fyBxQJ4q2xoU
	nXx7JdpcltzWdmY211CK0FUVdZ4JpV0d25Fm6rJv6I1VpOgr/B4u+GhijUO42T9m
	c6yYGO2rjToaLO4IZmi3wRM4ASuoTNo3qRl3v0E8rM+qPsXJHIIsDeZ41vjHC2te
	1xmNahsZXcTE5G7U+EQXw==
X-ME-Sender: <xms:DT1UaIWjISSZH3v7qTpyd4o20Xsnz6HdsP2HSTGrFEz8BLzxFPQpRg>
    <xme:DT1UaMk5zvctre3YpJdbag9KoldgqSa0x5eCAOjIQBFNG0_APd8T8BGe0sc8_2tpk
    fUi3DxN5TVkVIRyTQ>
X-ME-Received: <xmr:DT1UaMaIZVX9bS9kFISqyqGjcoXVR1qduuFLllTKpvk8_fnZkdQ2SU2U0WlYW1vSklsEliXD28QT6bESQ9DUN99zOFSGSy4N2Ybu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeitddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    epjefhgfefvdekfedthfejgeffieevieeifeegueeihfejleeufeffjeetkeffffejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DT1UaHWMiKQ7-Y_XZTF2U_V5nx4G14LkKBcPsnghB_KivKsB0fNslw>
    <xmx:DT1UaCmwdOplmS8M3LQh8ReNkq90tEpfA8sTbkn-OUpGvIqlS1o1_Q>
    <xmx:DT1UaMdzph6cZ0pRa9_e4APhd-ab5KanBEBD3SRrV4V5LO-4ld8Jmg>
    <xmx:DT1UaEGn9VhImTvwpcO0mpWKpfnpZRI1U3vngwifMorF9mLha-E7MQ>
    <xmx:DT1UaC-DXEtIubgssQIyhohdRciQrQSQKWLyJIu5qLNgUGp8R0m8XyAH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 12:38:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: .clang-format: how useful, how often used, and how well maintained?
Date: Thu, 19 Jun 2025 09:38:35 -0700
Message-ID: <xmqqmsa3adpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cc-list chosen from "git shortlog --since=12.months --no-merges .clang-format".

I am wondering how often our developers use "make style" aka

    git clang-format --style file --diff --extensions c,h

and also wondering if the suggested style fixes are really
"improvements".  For example, taking randomly the latest patch I
just injested into my tree, i.e.

    $ git am a-single-patch-file.txt
    $ git reset --soft HEAD^
    $ make style

I got the output attached at the end of the message.  The result is
a mixed bag (I commented on the "patch" as if it were a patch
submission).

I have this suspicion that nobody complained these sub-par
suggestions the tool makes based on what we have in .clang-format
because not many folks run "make style", and "make style" is not
very easy to use after you record your changes into a commit.  IOW,
there is nothing packaged to help "I have four commits on top of the
upstream, I want to run style checks before running format-patch",
i.e.

    git clang-format --diff HEAD~4

Even the output from the tool is of mixed quality, there are good
pieces that can be used to improve your patches.  So we may prefer
to see the tool used more often, but not in a way to suggest its
output is always better than what the human developer has written.

For that, there are a few things we'd probably need to do:

 - Improve our tooling so that the develper can check a range of
   commits they made before running format-patch, and other
   situations.

 - Improve .clang-format rules to reduce false positives.

> git clang-format --style file --diff --extensions c,h diff --git
> a/builtin/fast-export.c b/builtin/fast-export.c index
> 332c036ee4..d89e5ba6d5 100644 --- a/builtin/fast-export.c +++
> b/builtin/fast-export.c @@ -658,17 +658,16 @@ static void
> print_signature(const char *signature, const char *object_hash) if
> (!signature) return;
>  
> -	printf("gpgsig %s %s\ndata %u\n%s",
> -	       object_hash,
> -	       get_signature_format(signature),
> -	       (unsigned)strlen(signature),
> +	printf("gpgsig %s %s\ndata %u\n%s", object_hash,
> +	       get_signature_format(signature), (unsigned)strlen(signature),
>  	       signature);
>  }

I do not mind the original but the updated one is not worse.  IOW, I
would reject if a human sent this patch to fix the original that is
already in-tree with "once the code is written in an acceptable way,
it is not worth the patch noise to replace it with the updated one
that is not significantly better".

I'll call this kind "once the code is written" in the rest of the
message.

>  static void warn_on_extra_sig(const char **pos, struct commit *commit, int is_sha1)
>  {
>  	const char *header = is_sha1 ? "gpgsig" : "gpgsig-sha256";
> -	const char *extra_sig = find_commit_multiline_header(*pos + 1, header, pos);
> +	const char *extra_sig =
> +		find_commit_multiline_header(*pos + 1, header, pos);

OK.

> @@ -735,19 +734,20 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  		 * The searches must start from the same position.
>  		 */
>  		sig_sha1 = find_commit_multiline_header(sig_cursor + 1,
> -							"gpgsig",
> -							&after_sha1);
> +							"gpgsig", &after_sha1);
>  		sig_sha256 = find_commit_multiline_header(sig_cursor + 1,
>  							  "gpgsig-sha256",
>  							  &after_sha256);

This is a suggestion that is clearly worse than the original.  These
two statements should look similar as they are doing similar things.
Line wrapping the former only because it uses tokens slightly
shorter than the ones used by the latter inevitably makes them look
more different.

This is why I am dubious of any automated tools that have to make
their decision mechanically.

Is there a way to express:

    We want lines that are longer than the 80-column limit to be
    wrapped at 80-column, but do not coalesce shorter lines only
    to make them into a smaller number of longer lines.

If we can say "wrap overly long lines, whose definition is longer
than 100-column, at 80-column" in the earlier half of the sentence,
it would be even better.

> -		/* Warn on any additional signatures, as they will be ignored. */
> +		/* Warn on any additional signatures, as they will be ignored.
> +		 */

Looks significantly worse.

Is there a way to express:

    Our multi-line comments begin and end with slash-asterisk and
    asterisk-slash on their own line without anything else.

>  		if (sig_sha1)
>  			warn_on_extra_sig(&after_sha1, commit, 1);
>  		if (sig_sha256)
>  			warn_on_extra_sig(&after_sha256, commit, 0);
>  
> -		commit_buffer_cursor = (after_sha1 > after_sha256) ? after_sha1 : after_sha256;
> +		commit_buffer_cursor =
> +			(after_sha1 > after_sha256) ? after_sha1 : after_sha256;

Good.

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 48ce8ebb77..5da80e69f3 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2720,19 +2720,21 @@ static struct hash_list *parse_merge(unsigned int *count)
>  }
>  
>  struct signature_data {
> -	char *hash_algo;      /* "sha1" or "sha256" */
> -	char *sig_format;     /* "openpgp", "x509", "ssh", "unknown" */
> -	struct strbuf data;   /* The actual signature data */
> +	char *hash_algo; /* "sha1" or "sha256" */
> +	char *sig_format; /* "openpgp", "x509", "ssh", "unknown" */
> +	struct strbuf data; /* The actual signature data */
>  };

This is not better or worse, where "once the code is written"
comment would apply.

>  static void parse_one_signature(struct signature_data *sig, const char *v)
>  {
> -	char *args = xstrdup(v); /* Will be freed when sig->hash_algo is freed */
> +	char *args = xstrdup(v); /* Will be freed when sig->hash_algo is freed
> +				  */

Looks significantly worse.

>  	char *space = strchr(args, ' ');
>  
>  	if (!space)
>  		die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
> -		    "got 'gpgsig %s'", args);
> +		    "got 'gpgsig %s'",
> +		    args);

What was the tool thinking when it made this suggestion?  IOW, is
there a stupid rule in .clang-format kicking in?

> @@ -2744,8 +2746,7 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
>  		*space = '\0';
>  
>  	/* Validate hash algorithm */
> -	if (strcmp(sig->hash_algo, "sha1") &&
> -	    strcmp(sig->hash_algo, "sha256"))
> +	if (strcmp(sig->hash_algo, "sha1") && strcmp(sig->hash_algo, "sha256"))
>  		die("Unknown git hash algorithm in gpgsig: '%s'", sig->hash_algo);

This is probably slightly worse from extensibility's pov, which a
mechanical tool cannot make a good judgement, but the author of the
original did ;-)

> @@ -2759,8 +2760,7 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
>  	parse_data(&sig->data, 0, NULL);
>  }
>  
> -static void add_gpgsig_to_commit(struct strbuf *commit_data,
> -				 const char *header,
> +static void add_gpgsig_to_commit(struct strbuf *commit_data, const char *header,
>  				 struct signature_data *sig)

"once the code is written".

> @@ make: *** [Makefile:3346: style] Error 1
-2778,8 +2778,7 @@ static void add_gpgsig_to_commit(struct strbuf *commit_data,
>  }
>  
>  static void store_signature(struct signature_data *stored_sig,
> -			    struct signature_data *new_sig,
> -			    const char *hash_type)
> +			    struct signature_data *new_sig, const char *hash_type)

"once the code is written".

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 6f2d87475f..3e17f69cdc 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -152,8 +152,7 @@ const char *get_signature_format(const char *buf)
>  
>  int valid_signature_format(const char *format)
>  {
> -       return (!!get_format_by_name(format) ||
> -	       !strcmp(format, "unknown"));
> +	return (!!get_format_by_name(format) || !strcmp(format, "unknown"));
>  }

"once the code is written".
