Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6301E8329
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924625; cv=none; b=Fh9namhqfEd7WQ7o6nmgKnF0r5c82v7nv3O84YvBDrFbphE4sKoSqk8gz0ZG4mU9fZgftc6HuW6ohYZiEiYbIr2lCn/YC6IIRxp/PrzPZy31SRvWpKX3Ut1ffjobWE+PK0H+Mp2L+M6617IST+YC495KTLdxBSQ86qQw9CInS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924625; c=relaxed/simple;
	bh=ekWIppz9bkmEdk6OmEkJkbAJZ1QzBrIn0R9ZWY7pZD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f5kX5q8cxemJC8+0GbzspriQio7ZzdYvjHL4niNyzjl8ld8GxRdvDpp0Ollj88lnJCR4eCGO8XjGxzr88FWfpscHGa5Wvmvf7L9T2Q1CCvcZSvcDDdsHSL1qNbeHWYqT3aqgJL/IiVI9zp5iSWiitz9oLJ2Asx7a97yTmmIUD3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dBvT/wfu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9QMrRto; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dBvT/wfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9QMrRto"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 614547A00B6;
	Thu, 12 Feb 2026 14:30:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 14:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770924623; x=1771011023; bh=50IWReOCiT
	u2WFqQt18SYc0lweLDfwr8JrvsoSNoBco=; b=dBvT/wfuukG0CdPbRuMvPJnqOB
	FGhNSOpECMRRRqznKowg+g+F2uRP+0M6xKIE4tRoTslzR4Ddf2YQ4ExGE0DZdS0m
	IVvaRb5j31ZjmefcdQxyYe91dbC9bLNJsXsHdVDUJTpj7AGWurSPa3JslYSIGzW7
	9sIDnTneOoDlLsVmmEUo3+huNP8aZrpIOA0X5VjiuwMsJbAfRw88mh5Rr7T/JgrP
	fl8FAf021IDJMPaGpBp2AdprXmrRG7caevrmw7kZ7Uugg2iDnjiNJCqPDCfPk8+9
	FwiPwddOXQUTe61pd/fLWnZnHwPSWlgXjT4nuBidTQmxfANnCOa1A3RmaPnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770924623; x=1771011023; bh=50IWReOCiTu2WFqQt18SYc0lweLDfwr8Jrv
	soSNoBco=; b=L9QMrRtoSW/H0fqTV+gGjkSHI88zbLh6gDmR7VF51f22HbNbWK1
	JRBNBH+TAZr3/V1/2oYu+fmYrAxZZT6uvTwz5PtaFYctd3MUvfWdyuVkpxuCYgFe
	WtqOFfyIMW98XFeQil/5zlxSMNIA6RTdZBkAR7RZjLtMk6HzhMaChkMRq6L/DGEB
	IMv9nvp4yC0FJvsRtqSsnaUQHQFkkL62x4vWRQvk2ztW4Ozp8jJ7kTCtwrKPZpca
	uBtdV0FqzlgTMW86tQ/0nvVguEaJjoW6f2i7qTYrgKUHiRP3qkDxCCciOkW7tsfc
	wspeUwUWB6r6yjbPBA8BMxQbnrrQau7GW+A==
X-ME-Sender: <xms:TyqOaUiJbF7X6PZFUNVmJEDo1FvHbf0ui2KdbOU1XlJ6ozRDeamTfQ>
    <xme:TyqOaT4KGtFz5OzDeV9RVGvmdkhV563oTRVXpX5KwMyW1AqR6Kr7PLXR6PLbEH_Rh
    kOEZ9_GSHR4VE-Glqemj3Dl9tYfrC4Bj-yunhnLNn200I74VDY1vA>
X-ME-Received: <xmr:TyqOaUajhEX9b9wWb3nglHZX5jXQXQgv9FRr5IWR52lVp8SASTRA-aMC4FRJgs-bf5lrHZyu-iRuVUTkmy7L8KZ_ecPxaRPJqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:TyqOaQ6TU4KBZoQyqUIwH98CupsUl-7iWZO09Q4IvtmIyyDsr0z8QQ>
    <xmx:TyqOafDtsX1hjlOWJ9mdmpcmGWPfIUJRG81iWjmNi0NseeGP1EU2kA>
    <xmx:TyqOaedIxN29s_VS6_ASfkBGho6YXP2SRziCsK7bqAY3CXOrQ5Ahcw>
    <xmx:TyqOaWLcP6NMUZ4ilTtQ3FE-cOM2fzhMXqokpOAtXh6beXfwJGDnYA>
    <xmx:TyqOaVYu4929aOTzYJ7mXT60EQ5cqGLjCUK7mesTqOHXuqVBKOcEgNhi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 14:30:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH 1/2] sparse-checkout: use string_list_sort_u
In-Reply-To: <20260212041017.91370-2-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Thu, 12 Feb 2026 09:40:16 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260212041017.91370-2-amishhhaaaa@gmail.com>
Date: Thu, 12 Feb 2026 11:30:21 -0800
Message-ID: <xmqqo6ltoj3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
>
> sparse_checkout_list() uses string_list_sort and
> string_list_remove_duplicates instead of string_list_sort_u.
>
> use string_list_sort_u at that place.
>
> Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
> ---
>  builtin/sparse-checkout.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index cccf630331..34e965bfa6 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -94,8 +94,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
>  			string_list_append(&sl, pe->pattern + 1);
>  		}
>  
> -		string_list_sort(&sl);
> -		string_list_remove_duplicates(&sl, 0);
> +		string_list_sort_u(&sl, 0);
>  
>  		for (i = 0; i < sl.nr; i++) {
>  			quote_c_style(sl.items[i].string, NULL, stdout, 0);

Obviously correct.  Will queue.  Thanks.
