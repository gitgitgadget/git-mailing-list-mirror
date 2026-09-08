Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF425237A3
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889759; cv=none; b=bmT/azY8wzT11XyBxmQ/u/WcECvCRn3s15SC1OrS2HY996+epspRiLwo2g1B+Z0CpQYgugNVeqwhKpzfd345dB8UH+o3AFYeuIifv+is7RLYXZ5MpKHuNw2hgRvkKzke8JCwIHy/6qluNEAJBPuQUyzHFOTRWstyNB1rysHbyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889759; c=relaxed/simple;
	bh=4DOgMcij/A8iKkIK4+keP1QhCCA18/oMkWHeq35zC80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AG3lL1KZqTO5lShExTJwNYHYbRVrcjzwfOfa4ONPDIn0+KNATj4CJ2v1AaaPxnLRA08uavfUNPCK0peGgYHvvrLjFwrrhh/vug6V16ZU/iYN9fMWBDAeCilLdL1b+jLO24BOqWDQn4jYrxcPFIEczF5CXVTNNNdqTJm3w18G0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rVimp0sN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5/oH0Wy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rVimp0sN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5/oH0Wy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 51EF0EC010B;
	Tue,  8 Sep 2026 13:49:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 13:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788889757; x=1788976157; bh=ZGe6mmzhbl
	9p0hkCUEje3cqgMvlleulOtDVaEHbWATw=; b=rVimp0sNZaMPF1Yho6ciWcf6Bz
	4WpdrFUFNGCWg+mmtD6RLcZKOwwTSr39fAxPXNjLrIwaDoBh7BIPxlG18y1mo6g+
	/qSP5NhYpP2zIJm5B6/P9BhX/1XL/dtTpEwQWyo1lttSOwq7Gzf8idHQvnYasLM1
	t8VYyDd7NbI9+nMoGdb7lKqeSG30grkrn68Ej1yebf8/AbwpYh5sFuNxBpJWeJkA
	GR1R1D9HXpRINnvtdn7zB5eE6Q+i4Z2HuB5KHL56+oyy2meX//UCZS/7tPLi6SGe
	0HYjXpbPHFfvxDC8aG7q5hTRxGmjLlP8loeKwNy/iKBBBzXTMzctmqSMD8EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788889757; x=1788976157; bh=ZGe6mmzhbl9p0hkCUEje3cqgMvlleulOtDV
	aEHbWATw=; b=Q5/oH0Wy0XDQHtHSR83n6tqCcOMYRUb81lvSJkIky9EbhBxjb/F
	8GWtW6mBME2Z3ZjQO43ZV/OMF0QkwlAqJv53JGOOjAAxcL6pR4p28+F0LHd8UfVz
	PeVqlX4yfgrVycKdViTF9DWa+N0zFnP5mJgCiwFCnq+zf1igr5gOjKkj9ArHQVdp
	83/X6jlF3xu8FwFHnqM2m99tOGsAKIWP4Lw4i5YtA6ex8D3L1elDiieFWaIjgFeO
	hxl1C/uyzxi4VSI8TfmTuHoNSjvvvC8+E7EAmm/3z0yZGZv/4G7R+9QX5dqxmBuf
	zBf91saiEnFOaz+IWaJcdqpsCltdOOsbjGA==
X-ME-Sender: <xms:nEqgaitAT16LEFwITBPkoWpnEd6D8seciAeNHH08rAsISzuSa1gyXg>
    <xme:nEqgamjvcVtEUFZiEq7Qro9vFG_fNPw_cUJATUp0LpMUuC5Qazf0ERhIMmRxaTfv7
    C2yaCZOvDEJiTGBzDoneQHRjnvrEfn1yspWNOQOeK1eoIhiujrbQQ>
X-ME-Received: <xmr:nEqgaj8dB8TDM1lARO8w6K1X22RxJvLPZo32yZ8fskAa85bvWWwFtF57SUi6EcJzcFvSoaVokhg-slC0ai3gqQXTWg9VCXiStKZV>
X-ME-Proxy-Cause: dmFkZTEDYkCIk5ecFQPnnz3kM1A/m67kJlYZAbfcArzZ6GrZ8A3Taph0WzE5GlcefMS5jt
    Gjn9HCyzBmXR7ivtwx1mxWqX9NgYAFDR255LAts6sgUWwRrTkAbjNEZDqSM0vmWgun3Qdu
    /yfDGHWl+l6Uzr28JYwalWzKVzqkXn2M2bELZoqcq12vTX2/WEPZWTxvjBtx9/KgsCBs/e
    WHFL2ySDk7wy56JklStMTf3oHkFuwxWPPqxiy5OMV91RAKf6nA9y4c2s+dqL209jBP/8/D
    8es7L2TtO9nQFuzGqeNDGjzWZwYSWCdO1vYF/L4yDLJjOFJRNZabvATwOVHLLLTN2tq6gX
    FGXMZZ4+HYEJf9PSKEJmyNIZs5gm3x+HuqtX5OliH9g8+q8eyH8nDDo1DGoL88mhXQo3ff
    kkVdI0nBN2UostfWaxYDHxNr1ow1hntBeZYCE90BYEKMeUA92SM3NiNRzgKMLh3mxelTAQ
    6suDsR0lneh5SCwXey5r4xr6AdZEZc7okArdqfVFh8Gq/VJM3OZ+l4gHxxxjIC36Bf49LN
    tjy5oI86UZb1ThdU/5XCjrYFevO1b7LgOQeE5ANXnp2op8HlXvcsFfbIDPTLxzCIkzba1h
    K/79h+iTek/GYp4V+ykKAq9jFOyKJQu3920Okh6Nm1n268UrfrDJDCOdv04Q
X-ME-Proxy: <xmx:nEqgapsrS-h-J8WyA2uaxdk5E7nx1dTtaV58BgeqpvPlE2wapOVb4A>
    <xmx:nEqganphUTb5WrdPhYaTHlYiA-j8igkqA0xKUOxQEIelOMf2zNk9lA>
    <xmx:nEqgatoaaseuXErmKMRehk3aIv7UnDom2oP6Pz1rNT3heA5kNKAubg>
    <xmx:nEqgamabCIyYYVCvqt688aFHH1q3dfk55LCzlVsmq9XseBkFbzNhxw>
    <xmx:nUqgapyro2a4UTfmqjjE_4RL1BGvvOaiAOiGY5kPeDOLfus0pyThTeXu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 13:49:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 2/5] setup: extract path_allowlist_apply()
In-Reply-To: <CAP8UFD0qSA_giG1o8ydwxUOyscQaJ9pSNyngCdC7OEa7G_C5jA@mail.gmail.com>
	(Christian Couder's message of "Tue, 8 Sep 2026 18:46:05 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-3-christian.couder@gmail.com>
	<xmqqecg0oabe.fsf@gitster.g>
	<CAP8UFD0qSA_giG1o8ydwxUOyscQaJ9pSNyngCdC7OEa7G_C5jA@mail.gmail.com>
Date: Tue, 08 Sep 2026 10:49:15 -0700
Message-ID: <xmqqy0dbws4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> path_allowlist_apply(key, value, data->path, &data->is_safe);
>
> But OK, I have changed both `int is_match` and `int is_safe` to `bool
> matches` and `bool safe` in the v3 I just sent.

I hate to say this but I think is_safe was perfectly good.  is_match
was not quite grammatrical (it is either "matches" ir "is_a_match"),
but "is_safe" is perfectly fine.
