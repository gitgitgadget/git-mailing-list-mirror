Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292EB3EB806
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255308; cv=none; b=NTPOZTL+yuxeZE/PmvLzlOX9Cixvxn7TtH0/Q/sRijYqn5Me2zU3eECoOXmVmh3CenCJ85n2UQX3oNvrptWdoMbTMHe4FdJPfCqeFpFvEZFLZkaifxBQzY+CBV+ygjQXjCkkdan12k5pCFnG4YqDoqGvyk4mm82ZiihbO+UtWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255308; c=relaxed/simple;
	bh=uN0vfl2z7XmEoVE4oAwsFoSFp301tGdS0HnV4uhF/y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZ+N/pcTkkiopYbcXczypfIbHKNuGQTEMmLSheW/7k3FaqDNhtf7X601OBII0CrAcxTJLjsQnLUmqit95vu0XcmcSgQEwzYNQkqhsDtvae/Vw3rOErS/jGDxioLYchjoHui8sR0NZrVWhggrxuW4RZ6M+aADmxeJxESYgnJp+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bTmkcupz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yMKXDk/8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bTmkcupz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yMKXDk/8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 135EE1D001E8;
	Wed, 11 Mar 2026 14:55:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 14:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773255304; x=1773341704; bh=0Tw8lxJZi9
	FdLXwwulKLeYxdhh932ctB2Vn6W4UrKc0=; b=bTmkcupzm39ohGJfxyvalcn1qL
	MsAYlZAfzwTCM3GQZ5sxyBvIXGfp1UdoSyVa4NtMHCGxZ0qJD53IG3sJOSFokL7q
	EzMh1PqqIFr0aupLFYCbuAIkz8x3QipHhIsPNuKdszK+emg8clJWjBW1u3G/+sjF
	FUtlXxAKKYQuYPW3auirE7FvSeU19TApa5AP0ejjURj+uc/pYmzuiBGBn8mhymx3
	80IOLvrpvo6ey6zwATyXCpiSMtI9OTuN1cZLVXfGHPjh6Hiqdnkpc5dySCfcwU98
	PB9ZuMbmlvvH3MQVN/M3GfHsluL/dhsAPlojIb1rJUeVrRwVWE/qK8aCozlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773255304; x=1773341704; bh=0Tw8lxJZi9FdLXwwulKLeYxdhh932ctB2Vn
	6W4UrKc0=; b=yMKXDk/82NM9ZhJIqifAB9Lv0txdGZuS2nNQr1f0hiPVDZzU1to
	z4793hORCQu5R7tHgRXicmcVTOI4RZ91RKLFUMpjS1T4jYFzGnYFgZ5HPQbGZeoR
	CwDqLbb3/X2M1KdilFCU4+pMKlJndGr0GEzUDtAafCBS+G3VIJCAenbl62F5WfAc
	2LLGBZJAV6Pl9nvHWJxiqXYXs5xru0T3qoxOZNbO7SLYb4P0sZg9OUZb5y4y9PFa
	LHAVpjN9RVnVS2SfMJJdECTm6wViSuF5pgxMfB1jx84NkZsVKubuDj/I0FzlEICg
	6qk73hIA/xs2KGXPpfSEOHcn8A+kCEIZKTQ==
X-ME-Sender: <xms:iLqxaQm_fUn4MSlJQWc0uZtgbjT7yzi2VdcW8HzZlhx8Q5hPTKQQeA>
    <xme:iLqxaW0tp5GdLx17YYoc9bPTiEl5-zL6Vd82OtbvfTJGUbM67JBmu1om-5IiKee-B
    I4X4zlO7UOTl8Pwps21VmM50k-oJCH1ygr0PBpUpIpR96HEYRizYg>
X-ME-Received: <xmr:iLqxaTpTZAuDLOZFnoDev2nFV411ull1vf0MjHiGE2ylgA_7WOcfNRCNNq6Cxw8u2wjrO18UhQgIBYHAmkSvpMJJalWtd_n6hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggvvhdoghhithesughrsggvrghtrdhlihdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigr
    lhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iLqxabeZFdtZ9dwvPZQLOyE5u99FatrsVY46ZGhP343tzBPViCL2mQ>
    <xmx:iLqxaaoSQsTR_FQo_a425RkQodk99Xf2v3_XcoJtndwl2qaM1RGOpA>
    <xmx:iLqxaUH8NNyoGDPoMkGYZWWlefNrmVca72zFGlQGN6e4TTIIau7PZQ>
    <xmx:iLqxaSvhCM_SKxUnc67KYOLhnVey6APx-tbggQYe-CXNjbRXY4nnHA>
    <xmx:iLqxaeQ9S2VCwotLuxGh7DidGrOWh2lvrSZSHxImRKvNue9rQZPUbKKk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 14:55:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org,  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH 3/4] imap-send: remove two string length checks
In-Reply-To: <20260311121107.1122387-4-dev+git@drbeat.li> (Beat Bolli's
	message of "Wed, 11 Mar 2026 13:11:06 +0100")
References: <20260311121107.1122387-1-dev+git@drbeat.li>
	<20260311121107.1122387-4-dev+git@drbeat.li>
Date: Wed, 11 Mar 2026 11:55:02 -0700
Message-ID: <xmqq4immp56h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Beat Bolli <dev+git@drbeat.li> writes:

> At this point, these two checks verify that the ASN1_STRINGs are
> internally consistent. This may have been ok when the fields were
> accessed directly, but now that the API is used, is unnecessary.
>
> Remove the two checks.

Oswald already gave a similar comment, but

 * I am not sure what you meant by "ok" in "may have been ok".  Do
   you mean "with raw access to the fields, it may have been made
   send to ensure validity of ASN1_STRING"?

 * I am also not sure what you meant by "now that the API is used".
   Who in the code uses which API function so that we do not have to
   do our sanity checking?

   The call to host_matches() that these extra checks protect are
   still passing raw "const char *" in this step, and the change to
   pass ASN1_STRING does not happen until [4/4], so you did not mean
   host_matches().  I am not sure what it is.
   
Thanks.

>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  imap-send.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 2a904314dd..2bb0003f08 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -253,8 +253,6 @@ static int verify_hostname(X509 *cert, const char *hostname)
>  			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
>  
>  			if (ntype == GEN_DNS &&
> -			    strlen((const char *)ASN1_STRING_get0_data(subj_alt_str)) ==
> -				    ASN1_STRING_length(subj_alt_str) &&
>  			    host_matches(hostname, (const char *)ASN1_STRING_get0_data(subj_alt_str)))
>  				found = 1;
>  		}
> @@ -270,8 +268,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
>  	    (cname_entry = X509_NAME_get_entry(subj, i)) == NULL ||
>  	    (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
>  		return error("cannot get certificate common name");
> -	if (strlen((const char *)ASN1_STRING_get0_data(cname)) == ASN1_STRING_length(cname) &&
> -	    host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
> +	if (host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
>  		return 0;
>  	return error("certificate owner '%s' does not match hostname '%s'",
>  		     ASN1_STRING_get0_data(cname), hostname);
