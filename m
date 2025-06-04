Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF986353
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023805; cv=none; b=jCy498ckjcMqnY3vBkHKR5ShcE8oX4tDsCH8sDjEFu2PLr9y5HIxe/gxRr5jvBzQUq86IccAus23a0+2qYzsvVklldi04MEh3piaz15x/ootSPvtTqHL+w3hMXai2kumy1TrlDSUg0alKtbIroTsN6WqKpFVy4i5PN/puOZe6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023805; c=relaxed/simple;
	bh=8WiNz5JKtZHjO0gdvrnmmwTkvYahGj1ih72Ge4kvAoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EENeChqVN1T8kFGlZ7JZ8YEDEWtmMbeBFZRi1Nk7I13N7Y9QVb6hOFpmPCoCxA/HnBoPIuvhlGYcIM///V0VhtnEbx7xmZJ+eZuVg4jRfmt6GZgKrfGkme5U36TWlqcXqZI4y2z/oL+6Bz7LZaytO8KywmCX6dgR4uUr8Fh7bWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MERRNMjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iWXj1YEi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MERRNMjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iWXj1YEi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C9D9013803BA;
	Wed,  4 Jun 2025 03:56:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 04 Jun 2025 03:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749023802; x=1749110202; bh=fuVvfFIfTi
	6j1oHoBO4VxShyURP4tuXKFZHdcAV4Bb4=; b=MERRNMjgrSI3MMjflVoIe2VszF
	LuGRC4O+KtTDpKqUpv9lXQNk6kXBgDRJtHRKqYXveLX0cVtqUZhioZRjNkCUSSFj
	833s25CudCS9nbtEQBzg6dgDTRDiKQtLK2Is3Yt5rpilp2o962F3BpljdBIlFamn
	6/7K0u8EdabEZDEDGUH4FiHpqOt7XrlEqGKFgT1KF13qjHsM6bnZ3i1OzL8J3ete
	pHkbCdWVjvmd+m8uo6wNgcmQ15bvVI5hCTC6U3YyVnSp1wpX3Xz5U4eZlCvy287K
	LKb8rYb01QnylQ4lYJILUkQbV6owJSMuHUr9oYuOoE2TYf5Jx/pPnhKwqvnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749023802; x=1749110202; bh=fuVvfFIfTi6j1oHoBO4VxShyURP4tuXKFZH
	dcAV4Bb4=; b=iWXj1YEi29Fy7fg22/FroCyDnUgECWDvmiWXZbR9iIBHO9XwRQN
	3rZrf+gillyO+r8CdUXge3et0umcQU3kzYjOhyaT52pnRVayOnIYk8OYYLcnH3qF
	dsIL74NTQQkHNML7EqIX/7wqS2qlOSOy/FcT2xhpD88Fsd4D/KCW0nqjL4mqq109
	MRKCnjCaW8iTmVhY/mZpBs74S6N5uoVgN7jDEdLTcUGrd934uCTzzgViaDowdYJi
	E10pUdhz1yE/Y88NzvMk9QAN/oivUWGoxqbWZRg6FhR9ioOR+gAuN4E69vA+I98V
	PLn1NDo39PyoRG7nVwsC8xuW8AegwLTAjzg==
X-ME-Sender: <xms:Ovw_aKIluPSeHSQuNE0djR26HASXKRR9Klc0z4OUL2et0_0BgwyTsQ>
    <xme:Ovw_aCKuhRlquV9qGMWchXRDx1rF42_sZRPn_18oyeRCVmcxTZdvTZMQ5soXlreU1
    uODk2-GvSakqNCjYQ>
X-ME-Received: <xmr:Ovw_aKsIFvO0TzczEzVlPLYnGpOAUEbDedut0-FClrSWLY123_7wqDd_aPqMjFFf7J-MIdWIAlRobG-YOO6oP9D5IN1UcKU_mEDUYK6aL0qD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghn
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Ovw_aPa-stjDd3x1KtQC3MXroUvs1kZ8eX9qr1jTD2UnbrhrT3kRSQ>
    <xmx:Ovw_aBYXuHZOVqokv92Vy73L53jGajmoD9VPFXnORQlLs8yAJGNaYQ>
    <xmx:Ovw_aLA0Ts52KgqmfTBxKUzTFMLEWRAdfleU9y0yQSHQHgroMkAAvA>
    <xmx:Ovw_aHYggL-YzXFWX2Y7kyRUKnZXtaHFL68vkGzS0mHPFQ5Ae7ciow>
    <xmx:Ovw_aF1YiQ6dE3bhV6UiZBkCC-z9Hq6KKaw639Ftq4M1aLspAetuXKDG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:56:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b434b1a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:56:40 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:56:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] repo_logmsg_reencode: fix memory leak when use
 repo_logmsg_reencode()
Message-ID: <aD_8NxMi6Dk7CmSl@pks.im>
References: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>

On Wed, Jun 04, 2025 at 03:10:07AM +0000, Lidong Yan via GitGitGadget wrote:
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 225cef08807..6172c8aacc9 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -84,6 +84,7 @@ static struct commit *create_commit(struct repository *repo,
>  	obj = parse_object(repo, &ret);
>  
>  out:
> +	repo_unuse_commit_buffer(the_repository, based_on, message);
>  	free_commit_extra_headers(extra);
>  	free_commit_list(parents);
>  	strbuf_release(&msg);

Makes sense. This one _looks_ like a leak that I'd expect to hit in our
test suite as it's not part of an error path.

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 30075b67be8..dfc7e85ae96 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -186,8 +186,10 @@ static void insert_records_from_trailers(struct shortlog *log,
>  	commit_buffer = repo_logmsg_reencode(the_repository, commit, NULL,
>  					     ctx->output_encoding);
>  	body = strstr(commit_buffer, "\n\n");
> -	if (!body)
> +	if (!body) {
> +		repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
>  		return;
> +	}
>  
>  	trailer_iterator_init(&iter, body);
>  	while (trailer_iterator_advance(&iter)) {

Should this one maybe be converted into a `goto out` so that we can
release resources in a single location, only? Something like the below
patch.

Patrick

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 30075b67be8..dd08bc40161 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -177,7 +177,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 	struct strbuf ident = STRBUF_INIT;
 
 	if (!log->trailers.nr)
-		return;
+		goto out;
 
 	/*
 	 * Using repo_format_commit_message("%B") would be simpler here, but
@@ -187,7 +187,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 					     ctx->output_encoding);
 	body = strstr(commit_buffer, "\n\n");
 	if (!body)
-		return;
+		goto out;
 
 	trailer_iterator_init(&iter, body);
 	while (trailer_iterator_advance(&iter)) {
@@ -206,6 +206,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 	}
 	trailer_iterator_release(&iter);
 
+out:
 	strbuf_release(&ident);
 	repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
 }
