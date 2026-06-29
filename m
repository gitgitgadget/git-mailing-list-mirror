Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB02D0C94
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755408; cv=none; b=iZKzTFrw9UWiXWVYo/rI1X/rW0ppVLyWYUip8yXETXdKXAO7fl9QFKvPGook66OaY2O/dER4Nj0bXDijZz+rJNshmgFqgv/X4W8grtgeNWyBMHMQUU/ERSYE0/hBN4rOIz+TPOclZQU1JqLNZBmaWsIdc75kPvnlM3X8llBqBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755408; c=relaxed/simple;
	bh=qF6GOs9nwabn/G/gqaO2nUEFfpggCf5BG9k0yh7gI/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwkp0kHOL8iaEwY8FS6HBrVGvykBpn0LsAkQjlfNRL1JG6Nu3x2bLQDcZzi1WDLmSdpdrAPDazuabvBAFbYQJB7Ti26xj91iS3Un4v6n7Ro3b6dDfdSj62X5UDsloBy53EOuk7HegkFRsS5LGKUTHLtZk2jL3U/3LHXtERHJfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gSfcxtOZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IECuKIg7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gSfcxtOZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IECuKIg7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD4C27A0075;
	Mon, 29 Jun 2026 13:50:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 13:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782755406; x=1782841806; bh=Y2DiKVeebL
	49aLwr6BvwQFOQOc13j01WwGwFdma4Z7g=; b=gSfcxtOZLQEHOsT66WanidnjZv
	RPeyHUQhKHvfZ3mEkcaaFSG99VNv9GMu2bGNmAgnvo//Ethvs/F6vcUjpYoVrq1g
	Nq+ECUg3IKp3DPCkK/psQcqL/Jmru4J3tRXEgQNF4iNv4kz8h5g9q91X748vd+vO
	SYwkA8QSS9VXe1NfslMX/SQzwUfVg57x5thDdUKWRDHVKKtIWJ3YVFW8TNN75Unw
	INizZCX0ENekKfKp87jJ01SOab7WSt7P2/YY0Bd1C+SLVITULiLaz3z5SKlvQKOC
	Tfz2NZ9j7O1b69LKA2hDaNYTLFJ9UpZwUKI1kRwPgWqXsyvkrdUlJUW6gqvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782755406; x=1782841806; bh=Y2DiKVeebL49aLwr6BvwQFOQOc13j01WwGw
	Fdma4Z7g=; b=IECuKIg79rI2RcoR98BSZUHYZDcMdYB+d95RUqLCBIjC1HtofJ+
	AvDItZcmA5S5d95X6fi5dEaTGXTCmyD8kdYUgHKdoPUsI1hew7uOpn7i4xL2hp2k
	Zab5MzWclQTiYWU6hL2/2G32jy868kkENgJdgKphlwgpuO6BCmA84DAyAj6p/2Lm
	kYBx/7rL/N8612++a4xD+sadXrN3VqPP4yLFYYTrpzsq0mUP3zWByTZfvID0Vt4b
	WYXdZpJUYTDhQFdBbe62uFlzVGZ4idtvdMivU3k231/K3rjKUbCUFg+QZiD15Mvg
	iJ2kQ5ujz2W+a7bjdx4Pjwb/gA0Lk8wTRRA==
X-ME-Sender: <xms:TrBCaoDW955Uhwgj_4h4irGaxYzj8yAn1RHVZNi7uCCV6X7xBliqbQ>
    <xme:TrBCahY7ajMjY030mL3cD76AMi6tHTNld9kK_SMXdLkrhVBtKoTceKQK9V87U_7lJ
    hXBS8XB9FNZvbCdQsafM2aHcbcq7IHIYj-QxhsfkZe-LJHlsYQNFg>
X-ME-Received: <xmr:TrBCaj5_q4QbfoYFOSdmUAElxeQT0AyTJBrjDCabqn1n7akjApk2UjQoSozKdfvBiTjqxqv0TeeHztIyc-nNEzHi9pVYZy-NcnYVmAI>
X-ME-Proxy-Cause: dmFkZTFEX95cT9kZqJKsrbttsDVB2hUVI1AtpXucggVmyUmNdEFTbTUWwhD5Nb7NRfHlyN
    e+rUE55s+4jd+gwK0p0IwOBQKqKwlDGkqVz731IMb/D+HcKk8u2whBR94+ug6+FhMGRMnt
    t8A2ceByBWOh8fv6GP/Zl+olfeINZ0dC7YxdHagJ09ssynyL5a5XP1Xz1bzExAku2jyAYx
    gtCrSzIClnHrILHFIgsBn7oUVmeMsFvrw8jeKj4R4jVzk7Brgoy4dfAl57XMTz2EgMPQ8G
    4wZrNbuPTYPDu97vUz6pgKQIOmbzI9/GucWv9dc5p4NwGI06TATguniCXaAuy2TOvDuIsJ
    Aa0J6QsTWT3elSHA02h2kbktSYgoBTfAgVdNOKNGb8GaJON/ABztzQqC99nd3O+g/sCh0N
    JaPsgp99igOVTMRHPQUHMLAk09puHxr1AvPNKLDbu5lr6R1lkKYaMVMw9CgVRjMjB5n7jr
    E3SwGkyQt56yAkqZ3el17te26zi1tl2MJ1Lnh//nnRAfuHDj0U2O9kwrLtlU9La647OHMY
    eosDB6PZa94EdUfK8bGqyS9+GiJRwUvprCYWdX2/NctHhjN9+KMlhCngSkPBcDWahiRaJi
    jRT3/z65MzVt5+OBjLyQnXlceadyGVyLIpLhegkGHFDvoVJmKa7ChkxkC36Q
X-ME-Proxy: <xmx:TrBCaqYLICiyWNvwgviGZXRMJAC3dpv2mDen-2rIC2YKaW7pFWn9KQ>
    <xmx:TrBCaqjWOcYWrtdInPgfIPN-ZdG1YCwgTqoFyuLPHpsa8-Sa-FbaNQ>
    <xmx:TrBCaj-vV_TGgsHrInXWvQ8hlHMbuJA1AQcS6wyzi5phlOGt3J4yiw>
    <xmx:TrBCatp_FVedy4C2w2Lc2j9lUCktKalnLLnYzoh04kcncOnWiHQOkQ>
    <xmx:TrBCarHZ8AzliUhPHSNOYPUaHjlBuKc1c-XKvCE0B-A3jOxRM_9tcnWO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 13:50:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH 0/2] commit-reach: fix !FIND_ALL early exit with v1
 commit graph
In-Reply-To: <pull.2162.git.1782739162.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Mon, 29 Jun 2026 13:19:19
	+0000")
References: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
Date: Mon, 29 Jun 2026 10:50:01 -0700
Message-ID: <xmqqldbxw81i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Fixes a bug introduced by 93e5b1680e (commit-reach: early exit
> paint_down_to_common for single merge-base, 2025-04-10) where git merge-base
> can return the wrong result.
>
> The bug requires all of the following to trigger:
>
>  1. A v1 commit graph (topological levels only, no corrected commit dates).
>     Generation v2 with corrected commit dates has been the default since
>     2021, so only repos that have not rewritten their commit graph in over
>     four years would be affected.
>  2. git merge-base without --all (the common case, but --all is unaffected
>     because it disables the early exit).
>  3. A topology with clock skew: the correct merge base has a lower committer
>     date than one of its ancestors that is also a common ancestor. With date
>     ordering, the deeper ancestor pops first and the early exit fires before
>     the correct result is found.
>
> This two-patch series:
>
>  1. Adds a test demonstrating the bug (clock-skew topology where the correct
>     merge base has a lower date than its ancestor)
>  2. Fixes it by tracking whether the queue is generation-ordered and gating
>     the early exit on that flag

Where should this new "gen_ordered" flag go in the world with
kk/merge-base-exhaustion topic merged in?  Does it also belong
to the paint_state struct or can it be on-stack independent variable
to the function?

