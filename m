Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE7801
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824054; cv=none; b=a0aul3W07AfvXH+Ziz4JgSwnN0hyw6iBqkyZNLwdOqrplKHUT8E95sSWTqrapc7pBmM0y2B27T8NgxuOixMDO4sEqAlSzThBX42mAh9S6IncOja6LG7iDKhEEiZ5ULhdkX1+7X298PtxKdK3bLRiPGmDOzMNcJjbagtGbBgVhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824054; c=relaxed/simple;
	bh=0PvTJVtNRiVF4w2lGm+OrR+OXXtHVWglJA/RcRbBvXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aY/BUi5fuvf+d/Zge9zQUUWtAHsdru23kuHF114J5HPIs1fE+rITjp8RpDlRV0J0Z/7vAg35Wgp6/8qhpIG6rlR7vPk1Vd53vWAJQdloglsCNPqSr5SbfCoQx3fMIpNYJo2cJMXy9cDXzRE3Vf/kHap4LIng2hMrQMwy7Sq/xmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f1jWCP6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isMsjCqy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1jWCP6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isMsjCqy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E4CDD13802A8;
	Sun,  1 Jun 2025 20:27:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 01 Jun 2025 20:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748824051; x=1748910451; bh=6AxmnLej7y
	4bCf07pvnM2XOJeHw8RsW/n31doGTNTXw=; b=f1jWCP6KRhC+VAnHGl8fV4xuNo
	O9+Sp0k0nA1UaI8RN6OTgRLy8/VN7tsEDE+K93c5hZR0XbSwO60Z034J5L3RF5mE
	fPXxhxFvAY5VUJ8kXS7OKGy1ttKSDnISALsjfPGHjywjtuUkhBR5w9nrSzyzGueb
	maj206e2EsLLz2jz7qKfPylBcVi8Qd/gpbvzQDIRs36n7FH9a7ghpolge2wiARyC
	SM+La+pfvvu6A0Lt4W4WwWk4/YSIZdxrMw6epv/6kYLt5JIfJYit7WKF2/Yzyviq
	d410rfnjWk+Wsvux5MUPn6KbZQ5YyP3C6WJfSYUWZGdCwwqha0T9UXrt0l/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748824051; x=1748910451; bh=6AxmnLej7y4bCf07pvnM2XOJeHw8RsW/n31
	doGTNTXw=; b=isMsjCqybtunSmJZYVTbEEvtWmPaXsjifN+BOEGG3cS3s9cU7dO
	+cRT/H+jhIh4BDz7VX01z9e7eMzMrrhBDoFyFk0cZ+aKkbJLQid0WL5fPCBRVyNW
	zwcFourIlI3+mlGfFakD/t66kv/JG+JxlEXRvt+kcL6KDJW6Ubv6NDSxrRUbibZS
	6ejBATR0hipzL1gNWwZFFYxI/4X3EY7PbD+vmzIAsSy1xeq0M3PXZsB4+tiMQ5t3
	+ZIo0OZHrQLXnebAN57YuOVyzgsUPBa051d7oe6wANMpIT+YNwb1/UWa4b06x6lQ
	LMCnmKnS4ap/fWklr8Sf/VGmGPl9DaUpnpw==
X-ME-Sender: <xms:8-88aJ3Pl4RGL3kNQaJbLnxmiQ10NreJxwUqIgKO0BjuqMVujPdS6Q>
    <xme:8-88aAGQ3KupfLLlogK56Afb3P2Zu8pWh3W8fgYxd6sKYfS_rcgtmh-MH9upt9Xjv
    H3j_o88snuE7PnYKQ>
X-ME-Received: <xmr:8-88aJ6Oluyn2VyAMKffMHvP8rw_pdijWfqlHHzLHijvInhiFZC2KhsR4qlQFyTIUcUwZsk4oFLjA-83sVJ3hjsMcAD-_C1--Spu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefiedvvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihihigrohesughishhrohhothdr
    ohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:8-88aG0ZyMIdC-sDaJkoK9FyPdNgFk7vyPK_R4xOdElwXePNNeih0g>
    <xmx:8-88aMGFyujJHWqHM-JUGDNgsZ9KBj4TsTF6_P00ENt16geoay6n_w>
    <xmx:8-88aH_1OD-biBvADt-LuOZ0h5lJ5WUv52u8yImUA8Ht-vEe-9MVtQ>
    <xmx:8-88aJkygv3d-fSG33OwyERE5qnMD1OITVP7lOHpoTxxDiS0CB7wiw>
    <xmx:8-88aABR2R5r__LSFTybbsBFC0Jm3p3cP2ZM2H_IfasCIzDcklrt8GcC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jun 2025 20:27:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 3/9] imap-send: add PLAIN authentication method to
 OpenSSL
In-Reply-To: <20250601083821.2440110-4-gargaditya08@live.com> (Aditya Garg's
	message of "Sun, 1 Jun 2025 08:38:52 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250601083821.2440110-1-gargaditya08@live.com>
	<20250601083821.2440110-4-gargaditya08@live.com>
Date: Sun, 01 Jun 2025 17:27:29 -0700
Message-ID: <xmqqldqbvvgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>  #else
>  
> +static char *plain_base64(const char *user UNUSED,
> +		  const char *access_token UNUSED)
> +{
> +	die("You are trying to use PLAIN authenticate method "
> +	    "with OpenSSL library, but its support has not been compiled in.");
> +}

This comment may apply also to the earlier OAuth related two stub
functions, but this is the "#else" side of "#ifndef NO_OPENSSL";
double negation always makes all our spin, but in short, this is
"You are not building with OpenSSL".  We cannot quite look at the
post context of this hunk for sanity check, but inside the cram()
stub function ...

>  static char *cram(const char *challenge_64 UNUSED,
>  		  const char *user UNUSED,
>  		  const char *pass UNUSED)

	die("If you want to use CRAM-MD5 authenticate method, "
	    "you have to build git-imap-send with OpenSSL library.");

... is the message it dies with.  So, shouldn't the error from the
new stub function also say "If you want to use PLAIN, you have to
build with OpenSSL"?

> +static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
> +{
> +	int ret;
> +	char *b64;
> +
> +	b64 = plain_base64(ctx->cfg->user, ctx->cfg->pass);
> +	if (!b64)
> +		return error("PLAIN: base64 encoding failed");
> +
> +	/* Send the base64-encoded response */
> +	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
> +	if (ret != (int)strlen(b64)) {
> +		free(b64);
> +		return error("IMAP error: sending PLAIN response failed");
> +	}
> +
> +	free(b64);
> +	return 0;
> +}

And the same comment about not gracefully failing when our side lack
support, even though we gracefully fail when the other side lacks
support, given to an earlier step also applies here.

> @@ -1209,7 +1273,22 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
>  		if (srvc->auth_method) {
>  			struct imap_cmd_cb cb;
>  
> -			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
> +			if (!strcmp(srvc->auth_method, "PLAIN")) {
> +				if (!CAP(AUTH_PLAIN)) {
> +					fprintf(stderr, "You specified "
> +						"PLAIN as authentication method, "
> +						"but %s doesn't support it.\n", srvc->host);
> +					goto bail;
> +				}
> +				/* PLAIN */
> +
> +				memset(&cb, 0, sizeof(cb));
> +				cb.cont = auth_plain;
> +				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
> +					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
> +					goto bail;
> +				}
> +			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
>  				if (!CAP(AUTH_CRAM_MD5)) {
>  					fprintf(stderr, "You specified "
>  						"CRAM-MD5 as authentication method, "
