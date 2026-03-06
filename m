Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8DF37883D
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831147; cv=none; b=KGGN9ISPsIucilmKqIPPO45StMPBTx2LiG4V/ws9S2A7QkXMxhj7yRz0BUBxeCfxDXKKQUNwJjoMuJOuyOdfsVHDmq70sq5hoo6C8d6eyb9c8jNALKSz09IUHqdAnpgxjSAa+U4H86Mi+6dH64SkPy/v6/itw3IFDyHbGm+ukDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831147; c=relaxed/simple;
	bh=rSzYXRb26xh21E2OseUk+ncr9gq6Q/9FR877LLGwYno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OK9s+kD9MEg7Qjskif1u17+k7wQ+JDpVeTAo0sO70Y7qWYgD3RFlh+jWx4djIAzODjr4H3CvlDUgxcaw35KRqdsbc4bmv9tlkuL8gz6vH9ePha+bfwleD+N+CRrUYdqYHIFN7bztsGvtKvOAZI3gBYyykMFz6ZT7MIpt7/chRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L4re2PM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5TuQBbwD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L4re2PM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5TuQBbwD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC22014001FD;
	Fri,  6 Mar 2026 16:05:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 16:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772831145; x=1772917545; bh=xyyPhVA4gG
	J94SYIHHhWtG2szkyQxUQgkP0enC5Ff6I=; b=L4re2PM6KDX4akegvkKwEJ4A9z
	5eSjDjEUzGynYKkPV+m2esTosAvAi0MVBUGVXZjOhTNcc8vjo1RmgZUQV0UAc4Si
	lN+lQN1PNzRD6iWwuew2ZFa7hy/heRupMIGDFApbLa6xHEXP62W6IQS1F26Dlv2I
	jXefS4XAGEo79luMWTLWT6KoMhh5kdYxt+9029OBKvKFXESNaMs9Fkv80sko2vKo
	CEf5AlTccdXZfPc/x52bOmqYexGEcpdS9lc5BiB3fsuMxBp5f96b09pkDaWImnj1
	Hi3p1fSd7T1OFoYw4PQ5E6X+ZRsqNlgMUtf1YMJDCapsV59YmQ/dhrdK2liQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772831145; x=1772917545; bh=xyyPhVA4gGJ94SYIHHhWtG2szkyQxUQgkP0
	enC5Ff6I=; b=5TuQBbwD4lGXYJ3cCfSndzYBknil4d5gyDaz03myiZmLlc+ghsO
	BuaTk7zst16pUsCMSH58XMXb8cvn3J+VErZ/jyf3/JJffHNqJVwJZBBKeZnusL1Y
	okWUJU7J33xcWdyPHTBdajq/zFGOaxk2/XWgmmAnKLVp8w3G1iB5YMe5U/rUEeEn
	rwFQeiE13JjLibaEIjRh7NFqlnV+tyyUUFT33gVBOPa8TytsyhqP4Ixk8B9h3L0u
	Pv8typrYxzEG9itYF6bfewKgammxQqg35iMHr+g5+YtKQB2xcKt4Y/iaFsozLpZi
	mNoXYROzL+nWiORkYrBiR9C2aZSYFos4xYA==
X-ME-Sender: <xms:qUGraZ9cu8ih358Rg5xZDU6xE7-5bl9qZHfo0BPOvB9vIHedQNTCvQ>
    <xme:qUGraXC5fvW4tWSbohgPlKqR6dk3scrPiH6YxyvcvsXzwxbxYeQ_svBpnxw9M5rEm
    0OEl1utMlXB1NCZmrtM5Jfd3uuMTY753geWNyPIebKfUOXkXgpteg>
X-ME-Received: <xmr:qUGraeRjRdtckixv6bXrOztJjpnKGAfCJWrSR6oqm1GTFZbkZOaYr8uK4W6EvgigC7JBoDkR-QrHq-DcN2gNCdJzFFfZKyrM6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qUGraet-qhHowjklLNHw6DVpGsSYL_UojqBaionTcWf2RA00EGO4aw>
    <xmx:qUGraa2iS4yfDrLVq5MLzkuVYSKanbO-GOnLnlDNqsDRQ5RYivrwlw>
    <xmx:qUGrafW1payqdaJ3kq3aGcbXlpKRmPbmUAiAx1GYD_IKZoEHDk7c_A>
    <xmx:qUGraVJzKIOveZvST89EzDnEsY-Q_hk3aEDpb4kZQ5b3scSF5LvFDg>
    <xmx:qUGraYD84gD6KJh3gwKvZnNU7kC67VJ_EJOVpQE9WLRjUgugdhBCgHLU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:05:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Li Chen <me@linux.beauty>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v8 2/6] interpret-trailers: refactor
 create_in_place_tempfile()
In-Reply-To: <5a4d03ab375bbba84436796ca6871204f47521eb.1772808594.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 6 Mar 2026 14:53:28 +0000")
References: <20260224070552.148591-1-me@linux.beauty>
	<cover.1772808594.git.phillip.wood@dunelm.org.uk>
	<5a4d03ab375bbba84436796ca6871204f47521eb.1772808594.git.phillip.wood@dunelm.org.uk>
Date: Fri, 06 Mar 2026 13:05:44 -0800
Message-ID: <xmqqjyvozn13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Refactor create_in_place_tempfile() in preparation for moving it
> to tralier.c. Change the return type to return a `struct tempfile*`
> instead of a `FILE*` so that we can remove the file scope tempfile
> variable. Since 076aa2cbda5 (tempfile: auto-allocate tempfiles on
> heap, 2017-09-05) it has not been necessary to make tempfile varibales
> static so this is safe. Also use error() and return NULL in place of
> die() so the caller can exit gracefully and use find_last_dir_sep()
> rather than strchr() to find the parent directory.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/interpret-trailers.c | 51 ++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 22 deletions(-)

Yes, this organization is much nicer.  Thanks for cleaning it up.

>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 69f9d67ec0e..033c2e46713 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -93,35 +93,37 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> -static struct tempfile *trailers_tempfile;
>  
> -static FILE *create_in_place_tempfile(const char *file)
> +static struct tempfile *create_in_place_tempfile(const char *file)
>  {
> +	struct tempfile *tempfile = NULL;
>  	struct stat st;
>  	struct strbuf filename_template = STRBUF_INIT;
>  	const char *tail;
> -	FILE *outfile;
> -
> -	if (stat(file, &st))
> -		die_errno(_("could not stat %s"), file);
> -	if (!S_ISREG(st.st_mode))
> -		die(_("file %s is not a regular file"), file);
> -	if (!(st.st_mode & S_IWUSR))
> -		die(_("file %s is not writable by user"), file);
>  
> +	if (stat(file, &st)) {
> +		error_errno(_("could not stat %s"), file);
> +		return NULL;
> +	}
> +	if (!S_ISREG(st.st_mode)) {
> +		error(_("file %s is not a regular file"), file);
> +		return NULL;
> +	}
> +	if (!(st.st_mode & S_IWUSR)) {
> +		error(_("file %s is not writable by user"), file);
> +		return NULL;
> +	}
>  	/* Create temporary file in the same directory as the original */
> -	tail = strrchr(file, '/');
> +	tail = find_last_dir_sep(file);
>  	if (tail)
>  		strbuf_add(&filename_template, file, tail - file + 1);
>  	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
>  
> -	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
> +	tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
> +
>  	strbuf_release(&filename_template);
> -	outfile = fdopen_tempfile(trailers_tempfile, "w");
> -	if (!outfile)
> -		die_errno(_("could not open temporary file"));
>  
> -	return outfile;
> +	return tempfile;
>  }
>  
>  static void read_input_file(struct strbuf *sb, const char *file)
> @@ -178,20 +180,25 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>  {
>  	struct strbuf input = STRBUF_INIT;
>  	struct strbuf out = STRBUF_INIT;
> -	FILE *outfile = stdout;
> +	struct tempfile *tempfile = NULL;
> +	int fd = 1;
>  
>  	trailer_config_init();
>  
>  	read_input_file(&input, file);
>  
> -	if (opts->in_place)
> -		outfile = create_in_place_tempfile(file);
> -
> +	if (opts->in_place) {
> +		tempfile = create_in_place_tempfile(file);
> +		if (!tempfile)
> +			die(NULL);
> +		fd = tempfile->fd;
> +	}
>  	process_trailers(opts, new_trailer_head, &input, &out);
>  
> -	strbuf_write(&out, outfile);
> +	if (write_in_full(fd, out.buf, out.len) < 0)
> +		die_errno(_("could not write to temporary file '%s'"), file);
>  	if (opts->in_place)
> -		if (rename_tempfile(&trailers_tempfile, file))
> +		if (rename_tempfile(&tempfile, file))
>  			die_errno(_("could not rename temporary file to %s"), file);
>  
>  	strbuf_release(&input);
