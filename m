Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE631E107
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605234; cv=none; b=VGr6wwWBOJQPhfAm7UWdeJQfKyu+VpqPpHeEuMlPi9+ZDlw9mmn27j6I4MLCvQlrdwFMcV1tO3KM6Afvo53rBMrK9ftMxTQAiy+xCgwNckSSQmbFqV8FEmVe0KOznzhf/xCh3b6mi6T12B3h9ZdoMGBkdv2A3JIhJ0VBeXDL8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605234; c=relaxed/simple;
	bh=5cQmPRDXR3isdpOhJTBtjeljyWmy9PDHvDlePd/AC6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lavK3xOwxjQvf3e7VLl1A6B0qYkqVQMKS4EiOQUdXe1jZfja3nLu4H4h9nkpChGowm/Mx8CntBBcj5TVP+2QSU40S067JEwvRy9U+O9PA9y1IF8+dOSo+dXALztKRoKeiDHs1aWjWjyHT/Z85CoL3FDHVrc3cDk1/9bMoGxQmA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BNAgr/9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcxvP81e; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BNAgr/9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcxvP81e"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8817E7A00B8;
	Thu,  9 Jul 2026 09:53:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 09:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783605232; x=1783691632; bh=Mw8pAhkY0g
	14e76mO6CEhQ00a+BryuCSF/dyCvbQ/5s=; b=BNAgr/9bn3TJGkPBHqLPjWoPcE
	JENtsyX5D9HVJLXGj99Lpn+E+lNF3Dajgoygnenq6qbHUC5MFgHwZb+DrjimKHK+
	3HCKh1oVcxvh0r64E24u10K7j+DBcp0As0PqDRiokXbQ5rspAtmm6VIoiFo3Dh74
	h2LDDiEMZcuP8200f/tZ720gvwOw62VZSVxN2fa6DXME+2h1FciTyLHtxcl2cnJO
	TveYHPFlas5y2aqpSq/X+JM9yxvuf9SsGFfUXRSYxgh/l8buQKNlaM4wyuQqNR+M
	iAC/11Wg0HL660eR8tpdMnlKnCr/ArBHPXkHyQtVHIYY9rnu9Qnjk5gx7gLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783605232; x=1783691632; bh=Mw8pAhkY0g14e76mO6CEhQ00a+BryuCSF/d
	yCvbQ/5s=; b=UcxvP81eBHQLTmT8ABZVyTv7mRz+YLM/vlgJd3X6nTAoKuSFgV1
	cyUNjAbUIkDKc8zlsjMKpoSjLBh8QqrNOTdimffRrJiI9KJ8w+jGhw9rq23JN41w
	KS4HAktN6dqxgaAQr5f4SRpwk4UA8lLK0CexUnpE2fQKPMyGapd+HxUHySAG9mdj
	obADu+JasdmfdIrHrVRYfbfop7Yg0Dow1g377/22cgibYpt2zEVQwnKSaMsIsTk0
	ocsZurcR6acHWwhr5CYGngUfCmFZeSo5U0kRw8kyzyihqtV7BeV6t1UUMrOWnzqG
	XHQiJ7Hm9XQDvcXyMLQ2fwAeelQWmeVO12g==
X-ME-Sender: <xms:8KdPah2B4EFop6ByMYwSsp_pNBO1--FD2clLLCxlwXwghqe8fon0DQ>
    <xme:8KdPavj-JJ-VTCCb7ESlDDlhJtPdhJwzLDpj2I8koOS5PS_81IPKPi3HmQn1juSHh
    cq7coUho6tCXSjSwnVOerZvVOuy_ZuEuNURTLngvyLenjDOLPgPmA>
X-ME-Received: <xmr:8KdPavRn8VDTr9z_RSvfgFxMJTHOvzr-muGeqkujBSFdZ6b7DXLhlZFWbSoNX_Si--uZrevtKS8DRoXCpSoiYydVzlaazFub74GmE7UUfA>
X-ME-Proxy-Cause: dmFkZTFMSMgEIzPLfkz2F0PHZzisvxCDCHeWC0fFgVgdhsvUgzHEEVLNclRWABpmwPJ+Eb
    3oAVncNGkcMAApWP0Ut3MYX0aye0IMz2MobyRCnAFUpexKITS0m+W39H8thXN3ESeYg7DG
    FaWBF0Nb72VZZVExyd8d0WwzEo+PVbLCxA2DSllBREH0caQ22/Eaouv5E4ZxmrNrllJmzR
    mUN+4PcAXyo2HLWYo2yJnxxGQUS1uARoEnF+HVfwAF+/3ceh43VaDlcouIEIiryTJrRS+W
    F1ch+sYBzeOUFDJja+VtLBSrjaHZ5sxvwGaSLJi5WeSFZbXe11XpPXUb4qvD1rPLwqRnk1
    fZGR7RGH+viVLvDg2Kpr0hgTylmrmm/4VgpRPe4hS+f1OHUtSHztx499iIys3TlgRRjpBN
    PIX/tleKRszp21kv3q01saIQE0jgOeXXv+WMTk+Ec47NLdOYD85b2rKvTt6QxusbZIw5UW
    wdGxD0+Mi9aLdqQDskxnLM4fdgXSgIYWKHGxBKUxabn/BLHLGiGwHU97Gx7QA3aKFu+OQG
    PHMWeBmEN9zsTlH8NZZ/sEJzOr12vbQl64eKfJ+Axh6YxB5S3KZCTlKlsqdAprOMiM2E1b
    sle3yv9bb0U3bX/c1aJB2OdObjiX8UE7q6fqZN0TBBcdj3HStx7Wq41VMeYA
X-ME-Proxy: <xmx:8KdPaoj-6K_rCgXDu4H5aV1Dpo8Q3-IFV1d-B7U1JruEvHyysrdWXA>
    <xmx:8KdPan4LpDpcwk58W2ihdnyvLEpIDjx5oA4bcmzOZfPMLrfu9j1-XA>
    <xmx:8KdPatCZ5UCmHvBkBRHxm4AhmKW8AqSYSIwVkxklFMKYr6mlhAHEBg>
    <xmx:8KdPamZnhoOmDn6mXf_Win_k6P2tW17wsZEAAo9dL3hFx70A_GoFEQ>
    <xmx:8KdPasxs15v_i8QEB8pn2vgDMe5daJAG5KsvXKawPM-c1xCfNYTiq0SW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 09:53:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e1569db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 13:53:49 +0000 (UTC)
Date: Thu, 9 Jul 2026 15:53:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 2/2] reftable: fix quadratic behavior in the presence
 of tombstones
Message-ID: <ak-n6K4heV2kHviZ@pks.im>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
 <c13f15ddc20f721443fa1d462ea1b7c2356fbffc.1783598912.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13f15ddc20f721443fa1d462ea1b7c2356fbffc.1783598912.git.gitgitgadget@gmail.com>

On Thu, Jul 09, 2026 at 12:08:31PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/reftable/stack.c b/reftable/stack.c
> index ab12926708..fd7d8f3f1e 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -337,7 +337,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
>  	/* Update the stack to point to the new tables. */
>  	if (st->merged)
>  		reftable_merged_table_free(st->merged);
> -	new_merged->suppress_deletions = 1;
>  	st->merged = new_merged;
>  
>  	if (st->tables)

Okay, we still retain the field after this patch. But the question is:
how would libgit2 now set it? I think we should rather extend the
`struct reftable_stack_options` so that the caller can control whether
or not to suppress deletions at stack creation time.

Thanks!

Patrick
