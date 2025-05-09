Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9D21579F
	for <git@vger.kernel.org>; Fri,  9 May 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804445; cv=none; b=ZNwM6iDq3Ckr18v3orynMrx+tlWS5NFUoZDSQLSLoQVqbxA1ckvb89bLYPk27KgsEL2F4y1LOmoZTodqqx6GdEZHs/KejwNrMB0BuA6UGO35TBOftR2aRbKfJyMIXLffqwyLN2qeSUPb4zxMzXxiVbO0F4pOE6dvtEhsCcDXDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804445; c=relaxed/simple;
	bh=f5LHffP8dahKbPyAM7WVuQrZawGikj+Oegf2jy0nk3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VhAijRtI1Ozsdds3KUqTo3cxBSQJWlYPbFIk4kPvuBJbBexYd/6+CUcR6tmuwZ3yRyXUo8CV3ZjvU1eRMZQ3NBwSktl5cFuFhel98aIX6lTgal9GC1loWxp7sRsDdZZ7R0uu2VBJeNypqQiwGMDPU9Df9L1Tn6vi122qclYH9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zi+zoRIp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aV7eQtBI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zi+zoRIp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aV7eQtBI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62D651140182;
	Fri,  9 May 2025 11:27:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 09 May 2025 11:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746804442; x=1746890842; bh=bSo01TXAtX
	kTWxJB/To4yAgkJkxk8XEU/1nUqJ4lYzE=; b=Zi+zoRIpLCNan7siYNvMmCdgdR
	JJqrqULmKGSz4DwEV9GiwzYdrJUns+FRuV8mPaslTkJrBnmXHC7bF2WdH4P4nbkS
	rR4VUWJokW5Z9ffTotfDETdaE4dgkW/vn3dZRfkCTCnws6rND7rk/qOR3dG/Cq4t
	yfMolTY4WrDvF9Z1+iNeiHOiL85t6foD2GaZ8LYpE/RggQm0cQuBgHCYbPdWCGDG
	fePOaNIiR9p+sQ2YBsI3fCliMRtyUQLkOw78CtNEoypz4tpSfCWy5ksPjwK6ydIJ
	1+/0qdLYDL4so4taiPEth+Zha0jNCVmil74KiJqEm8JxwqnQbAWTlhqbHU1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746804442; x=1746890842; bh=bSo01TXAtXkTWxJB/To4yAgkJkxk8XEU/1n
	UqJ4lYzE=; b=aV7eQtBIZyb8YDv7+fAV83sgDC/DndQrdLdi08mRHJLr9lf2n7r
	Kmmz9B9okj7NlD5kz8Tt3Yk/Rn27B20ttcCtSiV8Bfv9SVTsV5D9ugwjKX4NmDi8
	EKACGcDFmJ4cBeMldnUuaYskDHewrIBFM/8HHKMrIJd8b4+4MirIJ/W+zQORVqRr
	hARFPvlHT84gDQfsD9J474RS988TaPC1aqqVjZvIYQgZmTj6PpCOuQySPfIQZacK
	hTg3YugH9w7hF6UCget8VFMAh82PPRjZS6oLL+99VrZ27EQvNv6irGMVJqqOChe6
	q7a7BPla5kN1IiDKVmSv9KDi9wlMIo0M9pA==
X-ME-Sender: <xms:2h4eaA22qmzx47_faMPvWBktaaZC3gdLz12nl7GIbXOhxUhE_IAbyA>
    <xme:2h4eaLFNMQZM743D-JAIZWnS9GBA6-az60Jn0AMJGJFcFh_ZYdpgNxi8rBgBLVrZ7
    zH-AtbonkB1UR7IRA>
X-ME-Received: <xmr:2h4eaI5yVwMCNHflNyTeKdM8upLFLdlnB0sKIiCEFqnYkErfTBSKy6yRjZk3k_6DBxTCqvSwHlxilORimt96vevtaw4TCP3Oe5mO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:2h4eaJ3G8gCuz69Gbgo7-JfZav5di_5EX5cPYtV15fVgITZNfUhG1A>
    <xmx:2h4eaDFjzwBOYXg1WZjjuG4MofMJ1v3JmvPWKoTN2PuWAwyhU42Fgg>
    <xmx:2h4eaC_efRt5m7vXLCexZdql_PSdU5wxgORSgDCJyBm0S8KdxnzenQ>
    <xmx:2h4eaIllJ9ICXJr6wHw-9brvjaiJr4s4bpz7W453svZlxapHh5MrpA>
    <xmx:2h4eaPbfbN_CS5UMrrw8b-AmmUmLLoA57NoP9q-NKgeiVAvjnKlBA0Fm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 11:27:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 2/4] builtin/stash: factor out revision parsing into
 a function
In-Reply-To: <20250508234458.3665894-3-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 8 May 2025 23:44:55 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-3-sandals@crustytoothpaste.net>
Date: Fri, 09 May 2025 08:27:20 -0700
Message-ID: <xmqqldr53iuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We allow several special forms of stash names in this code.  In the
> future, we'll want to allow these same forms without parsing a stash
> commit, so let's refactor this code out into a function for reuse.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/stash.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index cfbd92852a..8ee6752efa 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -169,6 +169,25 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
>  		die(_("'%s' is not a stash-like commit"), revision);
>  }
>  
> +static int parse_revision(struct strbuf *revision, const char *commit, int quiet)
> +{
> +	strbuf_reset(revision);
> +	if (!commit) {
> +		if (!refs_ref_exists(get_main_ref_store(the_repository), ref_stash)) {
> +			if (!quiet)
> +				fprintf_ln(stderr, _("No stash entries found."));
> +			return -1;
> +		}
> +
> +		strbuf_addf(revision, "%s@{0}", ref_stash);
> +	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> +		strbuf_addf(revision, "%s@{%s}", ref_stash, commit);
> +	} else {
> +		strbuf_addstr(revision, commit);
> +	}
> +	return 0;
> +}
> +
>  static int get_stash_info(struct stash_info *info, int argc, const char **argv)
>  {
>  	int ret;
> @@ -196,17 +215,10 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
>  	if (argc == 1)
>  		commit = argv[0];
>  
> -	if (!commit) {
> -		if (!refs_ref_exists(get_main_ref_store(the_repository), ref_stash)) {
> -			fprintf_ln(stderr, _("No stash entries found."));
> -			return -1;
> -		}
> -
> -		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
> -	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> -		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
> -	} else {
> -		strbuf_addstr(&info->revision, commit);
> +	strbuf_init(&info->revision, 0);
> +	if (parse_revision(&info->revision, commit, 0)) {
> +		free_stash_info(info);
> +		return -1;
>  	}

Two comments:

 - It is file-scope static so it is not a huge deal, but it is a bit
   confusing that parse_revision() sounds like a helper function you
   would have in revision.c and call from everywhere.

 - The call to free_stash_info() from inside get_stash_info() is
   probably wrong.  The early error return when ref_stash is missing
   leaves info intact, and the callers of it share this pattern:

        if (get_stash_info(&info, argc - 1, argv + 1))
                goto cleanup;
        ...
    cleanup:
        free_stash_info(&info);
        return ret;

   Even if free_stah_info() happen to be idempotent right now, I do
   not think we want our code to rely on it.

