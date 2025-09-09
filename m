Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48683043D1
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398982; cv=none; b=co6xYPrjTxgPcmYdGHAfBGEnra+7HoM2p2dotZC/Cg3jS3CPSfwQ8XfYMDrWvZ2rcFxGpoEbxs+OvJfPq3LmMqTmJJFdGDHzbqsA/ci/T5HRtfnbjbwlVITe3Rmh1pOVbz1bR6f33SpdW2wbz30RPbDw3XgeZM6uYig29ngokvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398982; c=relaxed/simple;
	bh=t4D867QiaW2woAodm3ZtseZLc8ItSvdxXCGdWPR+FiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PArPRGR10jJlJYekqJafgPDFhy0Jj9hxQW7jEhuFkO/v+ygUcymmLM35sb1LJ3jZcjbRcl4SG3fPiHVXhALx1Ju+0ZWQC9AGX6Z5O1oFgeSmJ25ZGhfdIXRaPzdaF3uObsJ/KbuEJij5zGvxHn1rmQy41K6Ora1sBXl2iDCZemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qia5VDaH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8WUQ7jc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qia5VDaH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8WUQ7jc"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8EC814000F5;
	Tue,  9 Sep 2025 02:22:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 09 Sep 2025 02:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757398979; x=1757485379; bh=A2IAedS+94
	BCc2bf+v41EZ/NgjsgqiEm8C7ATF0t77I=; b=qia5VDaHEeV7KAXnHYtnnbaM5H
	D+I3JosrB/KOm8eiZM3vQLP68t8S4dFKF62NuWd9NQ8Tw4vOpZsdNrYSZ8q6b4oq
	ceMCJ5bB/j8fogCGhE4IasLo3T0pH9/epLubFUo/3fmLkRVCAVjLfqcUYrfzhf0y
	ft0UV599UnXjB5bQ5rfkY0ua1Ljke8ydxNv4zgqcanBVQ2kU1kn5lRICTM/WZAO4
	b3xzcc/UtZKWBzrAf2t1eFltyKzqfehFuRBcM2jT8C20lzhAMNJbSFC49zBPZN7+
	c+2TIKwJn1abB+v2sxt7fSfh7pJsBxYUlTlfdcq5BSlqrF/RlYZrmhBJv5zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757398979; x=1757485379; bh=A2IAedS+94BCc2bf+v41EZ/NgjsgqiEm8C7
	ATF0t77I=; b=d8WUQ7jcGnMgpXwJo+mtGNK07y5bHtUoZs3PPVv/UnryKxxxXh2
	y/woSDal0KkBVgykAqRB74a/tnr6Eh9g4Z9JEnnbcSjbf1MJ3d7umG2UL/Ij6oXv
	97c315JlOxRhMcijx4sh/gsuKl4tK9YRvysoUArM9QFd4HkYTbvjEoyzAEY7rytM
	hEZM61PYd4MzVIfQZ5xZUHzkjhdGtjpSSeVQOocyGNBgJvAILuQ/xWLCy6/dIssM
	vFrOtOxUlF/MOYgI4yt+gfOKbub5sHLjYsuP8bSvDIKW7Dn86bqHRonmlDwsQxsv
	rRLvt3pozU5RPAMvLHiTUiQWR+eL9WTcBsQ==
X-ME-Sender: <xms:w8e_aMXWDqZxIutZhpleXSCfZ5_hQH1Q7J0O7qXalEYSITp5y2oP2g>
    <xme:w8e_aAxmKxHGBIHEP0C98hOd6IJ6xaAQeI3BghrgQWSsYK3CHtif2Pw3EHGCQpUuS
    fxMXqwoA53zLRicNw>
X-ME-Received: <xmr:w8e_aCOEE_Av4k_vyH82c2RgWpkfocvZSrbX5KltCFzu1CIsktflZa70uyhMzjG7Kq1DPoHDCmdpWr36N1VtSl4m4ZWG8Uc6cyCP8CrovPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:w8e_aJ4yEdVus1CK_6AoarXOKZ9QZPtAcfE85Ci75-kNFv7wU9E-ug>
    <xmx:w8e_aLNsDHdQuZ7QvA0Jpucep7SZ64Uag16Ojxyd43WWz2h8EST_EA>
    <xmx:w8e_aPnMiySSURN3hrj8rU8Z6nHTZEUT4eIgawNfacfMAZ0vbC4njw>
    <xmx:w8e_aKTzC78tQcmAftLTlCaD9-Kq-y4yE0Phz587rbW84KWnxBdllg>
    <xmx:w8e_aOmHmMQhbaetKVyl1opNc45qmI-XzDbtuP6142vyfda4sAa8p5WU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:22:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c039c38e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 06:22:59 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:22:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aL_HwMEJBLjrV8WP@pks.im>
References: <aL21cEM0OcnrKtBW@ArchLinux>
 <aL219d7FYJQNKBEf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL219d7FYJQNKBEf@ArchLinux>

On Mon, Sep 08, 2025 at 12:42:29AM +0800, shejialuo wrote:
> diff --git a/mailmap.c b/mailmap.c
> index 56c72102d9..253517cdf6 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -243,10 +243,9 @@ void clear_mailmap(struct string_list *map)
>  static struct string_list_item *lookup_prefix(struct string_list *map,
>  					      const char *string, size_t len)
>  {
> -	int i = string_list_find_insert_index(map, string, 1);
> -	if (i < 0) {
> -		/* exact match */
> -		i = -1 - i;
> +	int exact_match;
> +	int i = string_list_find_insert_index(map, string, &exact_match);
> +	if (exact_match) {
>  		if (!string[len])
>  			return &map->items[i];
>  		/*

Yeah, this looks much cleaner compared to before.

> diff --git a/string-list.c b/string-list.c
> index bf358d1a5c..224bc182ff 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -92,13 +92,9 @@ int string_list_has_string(const struct string_list *list, const char *string)
>  }
>  
>  int string_list_find_insert_index(const struct string_list *list, const char *string,
> -				  int negative_existing_index)
> +				  int *exact_match)
>  {
> -	int exact_match;
> -	int index = get_entry_index(list, string, &exact_match);
> -	if (exact_match)
> -		index = -1 - (negative_existing_index ? index : 0);
> -	return index;
> +	return get_entry_index(list, string, exact_match);
>  }
>  
>  struct string_list_item *string_list_lookup(struct string_list *list, const char *string)

Okay, this here is where the preceding patch comes from, as some callers
pass `NULL` to `string_list_find_insert_index()`.

> diff --git a/string-list.h b/string-list.h
> index 2b438c7733..03c7009472 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -174,7 +174,7 @@ void string_list_remove_empty_items(struct string_list *list, int free_util);
>  /** Determine if the string_list has a given string or not. */
>  int string_list_has_string(const struct string_list *list, const char *string);
>  int string_list_find_insert_index(const struct string_list *list, const char *string,
> -				  int negative_existing_index);
> +				  int *exact_match);
>  

Makes me wonder whether we want to use `bool *exact_match` now to hint
that this is really only a true/false value? If so, we'd also have to
adapt the signature in the preceding commit.

Patrick
