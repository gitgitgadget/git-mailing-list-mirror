Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD741B95B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038052; cv=none; b=QPmUTCoxy3FhKA9nYklpmGj2lcyHloNZMF88g2PzNp1jmMD8HqEzQ8MjGcUc7Cjxhm4mehbg1qnLriRf3bvuOP695fuOnjnVJpr0HbKjyx+Q0X1I/7JUkL5hApyjqfqSW3dm1R9I9uARzyy73yQQFn73BQgpmSot3EdVHdh06/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038052; c=relaxed/simple;
	bh=2q4KyV+QFZxZdhMLOWQ921SAAZqn27A6/rvowxbOPx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ5/pJ8/k8euxtTG22xYEVZCFOuzUOYWYksDcF3w52Ob75mJhZk6tcG+8iqL7QiGzNQEePGJrQjx6MmuPHTC6YaQsd/cvHEAxi0CytFT8LgwSEkCi+geBxv5BULROUGSqCtLPcYw1N+o7lTAl9pdX7/1bVxmtSRxKBNR0XCyT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iLvCGEcO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+6YugSU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iLvCGEcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+6YugSU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1071F140020C;
	Fri,  1 Aug 2025 04:47:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 04:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754038050; x=1754124450; bh=mS3vL3uHzq
	E2cHmaeDsmGVgUzaLhZ+beYIZ2C0LQb5s=; b=iLvCGEcOmyGMwNauaQOwhA09Bi
	gpSeeRxj26gkLm1ksPHcklm2fWosUi2M31JKxHcBESpdrGagzxAmmx4nYJspMXeX
	DtzTWYmNwfwrePsY2fOfEHeLw7eIZKovllLZO2BXAuOkoNrmd2TODIkp6PrHTmTm
	mrIHtgDneN2KA2Xa6YHc7bqY09K6BB2SpUq4jtahlubXf3XLu31urSRgyapvIoOX
	XpRTd7VjF5tfKy3Df1tnqcFai/Gm8JjhyY4xkZcoRe9A8/F4fVp5q3FhpQ4uRjv0
	QtiyQf9doQiWKGfN8ok3bCLW0RCPf/cg6/KLyULk9XZfGsJRNBay2PtVgakw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754038050; x=1754124450; bh=mS3vL3uHzqE2cHmaeDsmGVgUzaLhZ+beYIZ
	2C0LQb5s=; b=e+6YugSUZN38oEhA7CxXkZfZ1V4v0+e98eatpwdj9jeb6rC6H7r
	yuH0U2ANgbYv1/9+gSEfFGfOl1NdqGVy8V9W6X4qBRkKAzlK6QTZjH5CZN3+5Wl/
	9owXRWyumYLtU33YMQg1GbZrLh/1f/oeg+R5GrzP2kwKUuV0u3dxayVz5+qOsoal
	v5jg6T6VWR1P0iV/pOgLhGQeWeyUgESHLeq2w2yvDctKqp3JJtqkOzix9Y56lqy2
	ktZ6gYq2992Xm3ILAhOtiaAJz163EGVuxmqVeHEeUSTJaz5+ve04iD0hhkO6PRyL
	VrJ23fQ8PJ+y4uwuKnuvhrXXrOOUSLnxKjw==
X-ME-Sender: <xms:IX-MaOLeDvoRAcr8FJCjGdZs4TpdfCfcFJ2a87z9LkC_t-pqz-Diug>
    <xme:IX-MaGXoNH3DSyCMZGQqAZSgNrqrPzEjScVUS7KjqGn2nUUqPxaSFIPS3RNTNlfdQ
    C_uq6ms06B9IIIl5g>
X-ME-Received: <xmr:IX-MaAj6R9N1nawVpXn_uLkF0-mezQfkhBHR0QtoqjbdM0AntRARqhwvgTeBVI0sSa7NN-IVwhvXFkfPvqZ1f6eZC53S0PfLkH5dFnZMGm2j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IX-MaB8jb_l2kHdXGiUZquSvjdhKCGmX941GWdbudNy7uTcYUyJ2Xg>
    <xmx:IX-MaKC5C-7vcj7IgzRpRPV2n7uV2JlmPzwfoiGlLnOJnSyqctp7zw>
    <xmx:IX-MaOJ72J7rzgI_5lGv6Ln7GwRpejBdBhwHmQtNyxsE89k1OugJZw>
    <xmx:IX-MaNnCowOklO0Crxc8AcXmt9HO-0UtyZiPyDno6nUMU8g3jwyGVw>
    <xmx:In-MaIvz0uMsyj5S6Nr9EhPEFdSzhvTNnL51lSI9RKv25Pc1Zvj6t-L1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:47:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7014f87f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:47:27 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:47:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
Message-ID: <aIx_HIjWEDx9pNW2@pks.im>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-5-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:03PM -0700, Junio C Hamano wrote:
> diff --git a/string-list.c b/string-list.c
> index 65b6ceb259..86a309f8fb 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -336,11 +349,23 @@ static int split_string(struct string_list *list, const char *string, const char
>  int string_list_split(struct string_list *list, const char *string,
>  		      const char *delim, int maxsplit)
>  {
> -	return split_string(list, string, delim, maxsplit, 0);
> +	return split_string(list, string, delim, maxsplit, 0, 0);
>  }
>  
>  int string_list_split_in_place(struct string_list *list, char *string,
>  			       const char *delim, int maxsplit)
>  {
> -	return split_string(list, string, delim, maxsplit, 1);
> +	return split_string(list, string, delim, maxsplit, 1, 0);
> +}
> +
> +int string_list_split_f(struct string_list *list, const char *string,
> +			const char *delim, int maxsplit, unsigned flags)
> +{
> +	return split_string(list, string, delim, maxsplit, 0, flags);
> +}
> +
> +int string_list_split_in_place_f(struct string_list *list, char *string,
> +			       const char *delim, int maxsplit, unsigned flags)
> +{
> +	return split_string(list, string, delim, maxsplit, 1, flags);
>  }

One issue I have with the `_f` suffix is that I immediately jumped
to "formatting string". I think in other places we use `_ext` as a
suffix.

> diff --git a/string-list.h b/string-list.h
> index 6c8650efde..ee9922af67 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -281,4 +281,14 @@ int string_list_split(struct string_list *list, const char *string,
>   */
>  int string_list_split_in_place(struct string_list *list, char *string,
>  			       const char *delim, int maxsplit);
> +
> +/* trim() resulting string piece before adding it to the list */
> +#define STRING_LIST_SPLIT_TRIM 01

Another nit: I think nowadays we more often use enums to introduce such
flags, where the benefit is improved grouping. Also, I think having
`(1 << 0)` as value is slightly more readable.

Patrick
