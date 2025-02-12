Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BF1E9B04
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343947; cv=none; b=Mg96pNijtMFycQ8oNSSq5KoXs8dciMDWboWFfv4EOy5ewHf6jMLLJdXSF70UcmG9Zpd70PkToZw47mrDYqADS53UdwP7E+nX/dEGtz7ZuhMxEgdMQeBFIsxe9VPCvgpEdTgaTo+C7Y+WwgM1Ma1xMqjs8F1jVlv/2BITHlZ/SWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343947; c=relaxed/simple;
	bh=Sw0nxJ7qCo+YJrmMtZQ6cxQtTjyNQnolPm+U9DS5BHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjSLk55NMCibkjoFVNbilJ4lPXjjUybg4EXiey9eMVQLM3OVgbTKQDNR5LF6na6rPn0av0z3EG//vOAZjK+pbjmQd2o4YCl31BQ55rZTkqBiVTv0GeMqXf8Gm2JMiA164L03dwBcnL+qfc+y0yNVqaNLLFjVy0jGmk1hE1im+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EitYHqiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgaAxTEx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EitYHqiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgaAxTEx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC0511140156;
	Wed, 12 Feb 2025 02:05:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 02:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739343943;
	 x=1739430343; bh=2abmCazzzHXFRFanDts5+87qFtN0w4uf9qZf7ENQ6KM=; b=
	EitYHqivxkPMZeW/u403sWaL8wmoEcusWB7460zEVyLJvn5egJN0DgJXpwo6Qwlf
	wz4otEx3sc+zgX42FG6sKb2MF130iEStc85o6mmsh7FmZles+Rj8krr+FTXtS8KY
	koOF9aBIxlzo9ql6c8kj9bjbI5C6CrMnuqATgLg3kc9sfFNIvpBbAos5o3+YzTVm
	Lebox0A08KU3oldLRxCinbWtF/2cPj89jPowRe+74bfv7Ku2jNhZOBCMN50tHoeL
	F51mFPN2Dg9RX7NjqllGn64wXt67shRc/p2zXP6p3R7Fy6AsiI5Vy2CqAYjnXL0j
	34tkppjmHUJOzRN0GkOxuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739343943; x=
	1739430343; bh=2abmCazzzHXFRFanDts5+87qFtN0w4uf9qZf7ENQ6KM=; b=R
	gaAxTExkO3d8OKPJlJTl0IqLRXwXGZPw055RnEyG0JgRX+G4RqsvLMcPo8vTLj7u
	+S3B2EKOki2HfNrKhliTEQrH/T65q7P93ERxKdf34ryujVw3UEVFL+Mp9L1kUBuS
	y2sHklp5OGHMIOqrPUVRFWUVHIv4LjFI+pio1bRewTlgn/dZmI5q7+OxdhWH3tSr
	0A3xQNrWXniBxHlPMnuTe4jZK6gdY0uvp+ZTJePwWj/3VB0E+vgneZxuQ/rlDfZk
	10k1xH1Di6DpalRIhkrkcUL3u++SOAPxXm9l2qI8YBMCvlqFkY3vIKSDyWLGGnh4
	7wrZomh2WOlDfHZDHfJhw==
X-ME-Sender: <xms:R0isZyq1Kc92s6tjDHWm1S5plbmFnALInp-zSimWWlEfoYSx6PaAMA>
    <xme:R0isZwr7M2RCIZWZ87e4iRU9iu1taXqclMH4luYz_P0y4ONFgfT6CXozpKFrXS931
    -ECDrx83QhlDYl_Zw>
X-ME-Received: <xmr:R0isZ3M3RW6KtQIXBkbrE-kpOo9DyR1T7KKPUFKVvLI7-y-CGGMj9e3jJugPMFIg36pa3mRZZK2YK2FD2N9Ogn-ZKPumUNxZhDwwU5mjbI_jhm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:R0isZx5aMUDgVVN61Cgj007fXpUdOi7Rdr7lG4upbInfCOb3NW6csw>
    <xmx:R0isZx4X5v8PVru1aFXwrqjxTaZnsCyePBg6pz7QlND1PJ9OmN4vrw>
    <xmx:R0isZxhoS4Lu7n0Pvo5aRELlSZQXPfdeZoE--XsMoKb6IsJQXpJmRw>
    <xmx:R0isZ75zXnI35lYsG4nNBj9Vl8jF6Arw-ZQtZ_0PYlQVoRymySu1iQ>
    <xmx:R0isZxGqJZsa9--uZP6hSOIa4qv0zJ94Rfl7b95lLMVlkmCRjeqkcySr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 02:05:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9346ca6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 07:05:39 +0000 (UTC)
Date: Wed, 12 Feb 2025 08:05:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] commit: avoid parent list buildup in
 clear_commit_marks_many()
Message-ID: <Z6xIPowXnL-awm6g@pks.im>
References: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>

On Sun, Feb 09, 2025 at 11:41:15AM +0100, René Scharfe wrote:
> clear_commit_marks_1() clears the marks of the first parent and its
> first parent and so on, and saves the higher numbered parents in a list
> for later.  There is no benefit in keeping that list growing with each
> handled commit.  Clear it after each run to reduce peak memory usage.

Okay. So the issue here is that `clear_commit_marks_1()` only processes
the first-parent chain of commits, and any other commits will be added
to the `struct commit_list` backlog. Consequently, merge-heavy histories
are very likely to build up quite a backlog of non-first-parent commits.

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  commit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index 540660359d..6efdb03997 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -780,14 +780,14 @@ static void clear_commit_marks_1(struct commit_list **plist,
> 
>  void clear_commit_marks_many(size_t nr, struct commit **commit, unsigned int mark)
>  {
> -	struct commit_list *list = NULL;
> -
>  	for (size_t i = 0; i < nr; i++) {
> +		struct commit_list *list = NULL;
> +
>  		clear_commit_marks_1(&list, *commit, mark);
> +		while (list)
> +			clear_commit_marks_1(&list, pop_commit(&list), mark);
>  		commit++;
>  	}
> -	while (list)
> -		clear_commit_marks_1(&list, pop_commit(&list), mark);
>  }

And this is fixed by immediately processing all commits that we
currently have in the list. As `clear_commit_marks_1()` only processes
immediate children of the handed-in commit we know that it will have
processed the first parent, and `list` will contain remaining commits,
if any.

We also end up adding grandchildren to the list, so this change
essentially converts the algorithm from depth-first to breadth-first. I
bet we can construct cases where this will perform _worse_ than the
current algorithm, e.g. when you have branch thickets where every commit
is a merge: But I assume that for the most common cases this might be an
improvement indeed.

The question to me is: does this actually matter in the real world? It
would be nice to maybe get some numbers that demonstrate the improvement
in a repository.

Patrick
