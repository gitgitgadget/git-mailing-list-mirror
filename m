Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00F2F0685
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319102; cv=none; b=Bv5dO/yinMMHaezlovE7RX0PjiaSTzF4Dc1glN4mksocIesMfQOy00RTcVNxIzl6lQtAJzZVLgxCsds1KhprpoH6nxBHqeMsOnEjrpb09TaAdd9352O+724D/YwY9XboebNfAaHgRj/QuhcF7uDn5xV7yZog9XvvJBeCdF0cxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319102; c=relaxed/simple;
	bh=uYZ2wTZGns0XRnQku4C6U8VrKy+BVOpCfcRLYkfqUso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqlHtFdBwRXkCL2Ul8+Qpm18orZGtw82qTK4wzlgAojF5sbqAR5gO5nS8EU6MfcZf80omZpWnMyP46RkuylXkOnOmBmSvcsDW+4rbTkB/MN1CpwOzF18cxh3qZhaxE97t00yOCgDpeMPFJHTjhlNW9YdYm8PUL3sTSpnqZbTN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CKz4M1m2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eOPbkxlz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CKz4M1m2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eOPbkxlz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F0341D00124;
	Tue, 17 Feb 2026 04:04:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 04:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771319099; x=1771405499; bh=xr0b1PrcKc
	BRBDsL/whg+hlHL8CFecMKlakQgNJA6VU=; b=CKz4M1m2Y7rGmdMlLoOIL8j/Vn
	+3Aesbpz328/Dt0Z4114/Y1iidRclnPKolBgmfFtNGn9POCrbUCFl1cPbkC3wOY8
	4EFZMxsJeJ0AaJlmp/cUwErYbdlXp82v93ucjuAjRKAcfO+TQ1r/MdcPBkCKHDPV
	OKRPpxc4dGeG+/wf0IfQuIfTCFMwG4cDQpfNCaWUp3OY06KUxX1YgtK1pbucRzea
	uhOTTGuAkMdNlkMRmfL1ajabjMn//AA3jQQJeMVTje5sI39wRKdZu0kR8pT7ioA6
	vLcltSk74brsDC57tz/AzwKnSkMkzNVacnDwHPOeeII+xV8sAnQ601HurajA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771319099; x=1771405499; bh=xr0b1PrcKcBRBDsL/whg+hlHL8CFecMKlak
	QgNJA6VU=; b=eOPbkxlz2qHIg+idV2WDc3A6LiAkyY5PxXyr4/Zpy3uRARKdNY4
	q3203fiu10b+zFkNs1YxFDA8wXvasYqoNGwTNAYJLLgy0VXdbYVSBLoWvkRNb+/X
	ETWA/RX6vP2DcJq8qWhtKkwK7CnvcIugRSHZ7ucjZYAEXP1QiKSq31hmT79Ie9A4
	5A8jGrf+NpXCsPRcjslnaAikrexQQV+t5TjsVJniQEsU1xbFvrpb8V2qFi8QRCPx
	lkhci0KW40SaFOfGzFBzDU9L3AHbyYFDaRB3OgQ0neB08ypOKsl2dcbpoSn5yZX0
	IAKY8yT0MYNIL302TA8PXmyPCZCcDsjdBsw==
X-ME-Sender: <xms:Oy-UaWjSOCZT_e2fcddlc8OOkU-qxY_KPf0c-FBMCC1s6tzaDNZ0eQ>
    <xme:Oy-UaWEBhAn-CEuN4YrkBLIn46zY6YAR7T7gLfs80SUQnabRy-BWaxka00sYe3N7_
    wM1Gr1lq4Fxsqk83PUl9hec0kkaECmgO23-u3vIKgkHMWWdlZNVHQ>
X-ME-Received: <xmr:Oy-UaUR6ap1LVqP-JNOHbipRyq_ejrXrsmrjUW2t1enqKGJwrcP3hOb4Rvq2bW_IigoIB7Ct-yHx0aWPq57B7p-ECw1JMJTiPSpPDYR9Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Oy-UabxEyNNc4yRUvZqk7OIGlfB_a0U1fofXwZuiORLwHJl9NWJcrA>
    <xmx:Oy-UaYe6lKenm1eRF2-tgj6GcTx6O2iEgIIaazGE0XjglM68pylI-A>
    <xmx:Oy-UaWOzFOF1vR_qSuq9uLLqmg1rqRrgFJAx0qgr9AyxzkXFCj1P6g>
    <xmx:Oy-UabujAivmHc5fd80S5V0SrQOuz3IAqHI5FaDhrvwrEUMI8BaWUA>
    <xmx:Oy-Uaf7RT1diTIQmVtsT0ZT3En09O1E9q-EkHqxx0Qu_dgDtN08qA2BJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:04:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d980dc95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 09:04:54 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:04:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 03/13] config: make 'git config list --type=<X>' work
Message-ID: <aZQvLzL-AhPG3rbx@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <6d2a48a3b7f61c068392e66933caaf1d78055857.1771026918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d2a48a3b7f61c068392e66933caaf1d78055857.1771026918.git.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 11:55:08PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> Previously, the --type=<X> argument to 'git config list' was ignored and
> did nothing. Now, we add the use of format_config() to the
> show_all_config() function so each key-value pair is attempted to be
> parsed. This is our first use of the 'gently' parameter with a nonzero
> value.
> 
> When listing multiple values, our initial settings for the output format
> is different. Add a new init helper to specify the fact that keys should
> be shown and also add the default delimiters as they were unset in some
> cases.
> 
> If there is an error in parsing, then the row is not output.

It might make sense to document the rationale behind this decision in
the commit message.

> diff --git a/builtin/config.c b/builtin/config.c
> index b4c4228311..4c4c791883 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -318,21 +318,12 @@ static int show_all_config(const char *key_, const char *value_,
>  {
>  	const struct config_display_options *opts = cb;
>  	const struct key_value_info *kvi = ctx->kvi;
> +	struct strbuf formatted = STRBUF_INIT;
>  
> -	if (opts->show_origin || opts->show_scope) {
> -		struct strbuf buf = STRBUF_INIT;
> -		if (opts->show_scope)
> -			show_config_scope(opts, kvi, &buf);
> -		if (opts->show_origin)
> -			show_config_origin(opts, kvi, &buf);
> -		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
> -		fwrite(buf.buf, 1, buf.len, stdout);
> -		strbuf_release(&buf);
> -	}
> -	if (!opts->omit_values && value_)
> -		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
> -	else
> -		printf("%s%c", key_, opts->term);
> +	if (format_config(opts, &formatted, key_, value_, kvi, 1) >= 0)
> +		fwrite(formatted.buf, 1, formatted.len, stdout);

We could probably use puts(3p) instead, but as we know the length of the
data ahead of time it might be more efficient to use fwrite(3p) indeed.
Ultimately I guess it doesn't matter much.

Patrick
