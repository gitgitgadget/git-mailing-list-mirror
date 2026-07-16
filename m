Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587C329396
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215737; cv=none; b=ntpqAxOGTpedbOgxJ3gvfZjAr6qbgd1gVockef+ABP1QhQlaVxN925D1utORQZjxldO5+3PNIAyjSe8yg77iV4B43wRAHGw0+FI1grAh9qjJGlCoSLdemZQ+qIWES5tJVSifZ1786dngF045kJhpLYMN8nBOAktIUKYrvqoHcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215737; c=relaxed/simple;
	bh=a9pkfb3DA57Zh9J+5iMs2i8TUQIFsCUTE56bkd9hw6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCtvKx7ERvJVGoTMQVKC8dsJ5XGgQnMDldT0ugUKfg2U0Tx7P/O7CJDda2BidLnPvroGOMMEOQSyf71SYjT0kGG3RpJoBv/q1yAvLzTBoR9qM09k9kPSmhxVpCCyRBHNUIg1gLb3R3P9ca8WhMd4CC1l5HthZZOUsL+VvbKhLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VdwbfRac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4bxPwIt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdwbfRac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4bxPwIt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 25180EC0190;
	Thu, 16 Jul 2026 11:28:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 11:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784215735; x=1784302135; bh=oDK9Kv5T8a
	MrNtlkCIddIpQsDe5wY8Gqj6LaIMDXILM=; b=VdwbfRaccYsxsZnMecASFc9OID
	5j8L8MEZ7+4AekkqLnn0nrP5HWxEkuSRBPkR6CrQ5cLhQVguODDzZ3RUuC3hRn6+
	I1ZSb9cdrZezJBKsUu41n/per5rbzDYuPLIFRBy9WPsSTuRIFNkwigrNJR+EA2y0
	FY8+vlbPBdGCobQTTedbAi2kPh0wJZupjDKZcvfab08iikItFfc8gp8gS75kTPak
	9J1d0UKaXJGWULDFL4ohNJymYYdqn7lZkgoQaBLiGUC67l2mgB7XmREa6ECUS2Rs
	czjJpIr1iLg87oeVYVH3R4GTCjAhoFRtL38QJDSJLPiqoLXKgRYX9zUd3k5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784215735; x=1784302135; bh=oDK9Kv5T8aMrNtlkCIddIpQsDe5wY8Gqj6L
	aIMDXILM=; b=j4bxPwItcSM7fetOz0WN/IzYxG8r7xqDz2VJ8paNJtz04dg5qZp
	9beeD7mRSVZFKNoIC0HuyVF19JykBh7R8IGYlpyuFXquxxr5BkS23lOD3p2oXksz
	VKjwDJerKv0GsKnTiuHORi7DEY0pq7gEiskEHpoEw69E4sIJwc9pnGbShVw1J3sf
	i9ua34MAE644iFpIlaF/h9uKNNnlwWm9EJx9fYeQNgPQs7YkTBD48T8wLNQQGsaT
	sH9C5ip1PcEiklo3ppabZNXwenuqP/5CtiVlFOmVb9ADY3dN+KfM/0wwrs9E/YX/
	LhyWPkIoFXNeWjAPUu/9t7CnmoukSybttUA==
X-ME-Sender: <xms:tvhYap2AghGYsFDUQIrGZKHqcAkO6c2MmowLwrwpL-UGoAMMBIkS9g>
    <xme:tvhYas-l9_HvR-fTVK4Bb6NrovhRoiqc5nTPOXXzo7ALolNO1uOIJwzEJee5nDZ2R
    UrGxKjWUn4A7EELKI550WKFw2AV68lSfL5mIYEYFTMfqWquhKzQ4Q>
X-ME-Received: <xmr:tvhYappIyu_oxOkR_nmZnJKqkcr_bfpf0MivTn-7Ygu-usaora9CZutChfzWI2zQ7hRBaXfFUiroGsq4J7CJU0SdK796I0L-dE9ys6s>
X-ME-Proxy-Cause: dmFkZTEjtfkZYXEdclbC7V7TuW8JHgdf8SYAQjimxM44VJZUCi/kHk0a4kDpApJg5ZV+fr
    zaAWNoNMADew9AdMlGp/J6Qk6fnIyXXG2oNzkV77krLkMKPFq30m8THqMJBAtUYZBljf2g
    z594BPbFXSygg9AMCay/u7tTobBb4MfbTbbbZD1at2pXMT42CF2druCOqMDYLqK0GhNB28
    rOZ5d+cm/vKRY22JXhIWTk8Rttp5DVhwzK6miKwNBdd9qnaDK57vgrHeU/HZEnMTk8LK/k
    lDQYKulN44CfExXwfUvYPtxXaLNDF+0FczrCXtlfgcIhmizEUPDZMMSt1qsnSHX3ScwQIe
    GxI00E6VAHBz/ZaIhcuFJ4xCJJH8kh/bv9cAvsSUWOcrL/5HXzFsxj8p+1mJGjY6wLDfq6
    dnMEeJImUsWtk+gODsfu/3xG6Q8uAqzZI/flZN9kDKMU/gJ2a/XbWAxtPpiK4Oys0nZhPg
    NZC6p9ksRyXh7nIp166Ru6kdyra8FiVmEI/pGpmsQLPtXrsFLawyyhmFhVGyldkJosyYDk
    Uhtmh/Vs9GaYpkx+p8RPR6pyCgf51Wbc6dCtb/a5pxvEPze3uqJG04Yu7sNglRF44YQa37
    qCDG/v8MaT7FhdNDd1405ZKfor9ixrBrJByMFLEmFuBZRJZUF5JQtiOuQ3aw
X-ME-Proxy: <xmx:tvhYamR109EiQKCog5uOxMp6Q3BNV2U0oE05TIg_kQnMMJPH6Jmk2w>
    <xmx:tvhYasOJUlQRHL5ttRjUkAHpd7RN1csHJhCKPJA5PMdlYvrru3sVrA>
    <xmx:tvhYakjWtPHNWhjmXlHGFOypQd3U8McOqETkkMeP0WWhztJOg-vsxA>
    <xmx:tvhYapnTr9RzjNCwWg5BgBF_KPSHv0mN58Hcz-I-OP-rYWz2eVlVow>
    <xmx:t_hYasJPvVWii0i41IusCL7JAzXAcem1OwmOYyxcmOUXlRA0tkmxHSzZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 11:28:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,
  five231003@gmail.com,  hariom18599@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v1] repository: move fetch_if_missing into struct
 repository
In-Reply-To: <alcqQp0lkwRIIE1t@pks.im> (Patrick Steinhardt's message of "Wed,
	15 Jul 2026 08:35:46 +0200")
References: <20260715011850.3181131-1-cat@malon.dev> <alcqQp0lkwRIIE1t@pks.im>
Date: Thu, 16 Jul 2026 08:28:53 -0700
Message-ID: <xmqqh5lzhs22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  	/*
>>  	 * index-pack never needs to fetch missing objects except when
>>  	 * REF_DELTA bases are missing (which are explicitly handled). It only
>>  	 * accesses the repo to do hash collision checks and to check which
>>  	 * REF_DELTA bases need to be fetched.
>>  	 */
>> -	fetch_if_missing = 0;
>> -
>> -	show_usage_if_asked(argc, argv, index_pack_usage);
>> +	if (repo)
>> +		repo->fetch_if_missing = 0;
>>  
>>  	disable_replace_refs();
>>  
>
> Okay. This command can run without a repository, in which case we'll end
> up just indexing the pack. My assumption is that we'll probably end up
> using `the_repository` if so, as we still use `the_repository` in this
> file. So could this here cause a change in behaviour?

Meaning that even outside a repository, we could have read the
setting from ~/.gitconfig or some other places other than the
per-repository .git/config file?

