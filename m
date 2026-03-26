Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731133F7AB2
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527685; cv=none; b=aqcPchXg5xO+F1vJ8pX8XdpbU9UNnBeJzmC3OcW3jVBSonIUkXdFV8RLrRrWvW61NRcC1jvmWBu+sFf/cGkeDvlt4ywAYb0htpa5o63g+e3x5O/BmxILS4iQ2MkrPJALPRmKZUdfy6sMHmb0kSVQTnO1U/dYg9ZmIr6B4BR8JgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527685; c=relaxed/simple;
	bh=ziAWmqJiMFttG404oNKbLfl4UE3tJ4Pm/7O30ztHx6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB6qoznmAfjTok7pNHBBEc9+R8nyITgCg/F/lqC7LoSCjiemUnZgMVqqjY7OFNTMmKMsbKf6jU1y1oBYrZUWOXwAt1C5DkSRxBZtrCK7X74oE3NBARwb7SK2McF+xLZAda6UuLrkzVxSzYbFornrcIkHpPW/b1aVvVlfB4HVE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d4flNpI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2zutFsDI; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d4flNpI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2zutFsDI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B80491D00065;
	Thu, 26 Mar 2026 08:21:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 26 Mar 2026 08:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527682; x=1774614082; bh=lUPZtMsBYj
	3JR1kDQlkMiP9Mo4TfvwMVwdhD2c2Yo5M=; b=d4flNpI8iTcaYySQldr9ltLCxU
	gjLkzfsQpLuTxCNsWF5L6c6i5YXoc5AW/lyOV4qsXXCv9bKje8CoonOhCtDP/s1n
	9uXyTiassUcmSWdaI7lV3bs2GU+RGGjvAqvCzoG0/0YB9MJqoVR6F7FG4Aayxbrp
	42DSe8+0O5XbI4/QI3bV/CuvYOcAzFPXPp3EBdg3Icp/JnCN4QUryf+fRM3qz9q3
	5NtLF96M3SQ/Auq/tAJCnA9LxNhkgBXqwz1YFgskkI/jBburk3BHcyZW5lJwR7pE
	m2YXn4Xrt2s6o2Lvts5irP6y+vXRkqylOXikJPlxEeEK/Y+edbSqFKKa3+EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527682; x=1774614082; bh=lUPZtMsBYj3JR1kDQlkMiP9Mo4TfvwMVwdh
	D2c2Yo5M=; b=2zutFsDIRKzabOPbzOfFbYtE5y+oi0hBr8nodNb186FcKxRQMPD
	hyuUPSyEXNZSqvRRhMy0LrR1p86kutqf+2TsZvKpJAHFLFdxk/dPQfNbHYFAqTQY
	DwvTj9vna7IniEjIvk0Isyy1F+hSxjQubL0LMdsClP8jbxWtSlemRDXEiwxLACwp
	hv7z68MAOM/yJSHyPwh16gwUm03GnlhlcnW4xIIJTgkoN39JcyfC+VsPp2RCTSrQ
	nkbaHD86CDfsYgycER1wWKEgD9b61wR97n75Z8490f3LDGOffFQItRFhOhQtlmyb
	NiVeHkyiMZcyjOTeNFWLyS0yfuzbvK8dvUQ==
X-ME-Sender: <xms:wiTFaZopfAm1cXW3SWTmNJt3wRjGtXUBTsC6GaZFMjZNPvaQCWB0fA>
    <xme:wiTFad4WBHxKWr70XyohMCWWQfwuwSk6WSl2Yu42IrNGYOmSzOG8nEQxJACbCAViC
    b-iTPoqTfaaQzIeMdn6fXIUuS6nGebYPyGaG4oxzZ1Ix3eoKugdIso>
X-ME-Received: <xmr:wiTFaYcMNf7Y76P4XaenbbmMjmHc-czwlqJsxaZ5Aly357wkQVhHzPSZeK1oxGpklIFSiDJ5T2vqHAxIvA5tVXU-TsNXG1OcUp5qkliD6mHSCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wiTFaa4N-xKDYorJbtgyEt8O9KsfvC9xkqGlKk69kAACBLZkrTKL_Q>
    <xmx:wiTFaXv7S2sLp_PBFERBQoJ1HfwLUOhGwU1YVdDopzBmLB0SfNz3vQ>
    <xmx:wiTFaSj1-8RZVAq2VA-U-4bDlFejXLHTR6zyPrD0g6qolRWJCPwI7w>
    <xmx:wiTFaaqtQ2KkU--yGhsvAKSCqxAIRm9yXnORnqZmep1LKQtA7U0GVg>
    <xmx:wiTFaapAwT7zY1zmaMD12oIDqFInnOBb0N6Y-K-WAgIgYd5ez0_5KxXV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af21db7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:20 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 10/16] promisor-remote: pass config entry to
 all_fields_match() directly
Message-ID: <acUkvkLYiO0wkCfm@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-11-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-11-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:13AM +0100, Christian Couder wrote:
> The `in_list == 0` path of all_fields_match() re-looks up the

This reads a bit weird. How about "looks up the remote in config_info by
advertised->name repeatedly" instead?

> diff --git a/promisor-remote.c b/promisor-remote.c
> index da347fa2dc..8f2c1280c3 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -619,7 +627,11 @@ static int all_fields_match(struct promisor_info *advertised,
>  		if (!value)
>  			return 0;
>  
> -		if (in_list) {
> +		if (config_entry) {
> +			match = match_field_against_config(field, value,
> +							   config_entry);
> +		} else {
> +			struct string_list_item *item;
>  			for_each_string_list_item(item, config_info) {
>  				struct promisor_info *p = item->util;
>  				if (match_field_against_config(field, value, p)) {
> @@ -627,12 +639,6 @@ static int all_fields_match(struct promisor_info *advertised,
>  					break;
>  				}
>  			}
> -		} else {
> -			item = string_list_lookup(config_info, advertised->name);
> -			if (item) {
> -				struct promisor_info *p = item->util;
> -				match = match_field_against_config(field, value, p);
> -			}
>  		}
>  
>  		if (!match)

Okay, the logic is reversed now, which makes sense as we now pass `NULL`
instead of `1`, and the promisor info instead of `0`.

The change itself makes sense, but other than that I have a very hard
time understanding these two functions. I think they would strongly
benefit from some comments explaining what's going on, what the input is
and what we're trying to do. Of course that doesn't have to be part of
this commit here, but I would appreciate a preparatory commit that helps
guide the reader a bit.

Patrick
