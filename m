Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55183955D4
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759137; cv=none; b=CuNfQIBfZrUnSFGQhYRFn8Bz8guzLbTjtA6vEqwNd5BKWnmiPT1oca5z2IefSVQm3B9BaduyS5oqX8A30GJGfhmOQkCKQoGLF0PGK4OYwdFSvvoRU51o/e3ddug7c2MEcKnpkmISUm3h8MD0/wwlgN5tqZekoKbWXcmnbwdt4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759137; c=relaxed/simple;
	bh=3A0PKVju6os7luQxn1WBdFNErT1lP/WVc4Rq8+rxD94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i72QG9uUrLTKv1fqVQ7qItch3b6kPqo513gvnDCIUKH8QvU5W6AgASj2egR2a+cKNPoxNMXej9YiDXKTVACvcaeC90aIH8R3ZcIEhHCcTpG+CHMWfDewImfd4pKVc5by1kqgJ/h+4Bbhk3IeiMDn7xkAIPTNt3MtLd+Bod29qOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dJkMU7rB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uv5hxaUH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJkMU7rB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uv5hxaUH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E76767A00A4;
	Mon, 29 Jun 2026 14:52:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 14:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782759134; x=1782845534; bh=KtsQ5sXY4I
	IHykbDahC8t81lgcTxJfz4Qwni+pecVkw=; b=dJkMU7rBT/zH9msRyGVzIgjyNe
	kViBZ6y29DUt6tdlhiebOHsIauSa//Pvxhq2UpvRt8J5dlyHo+RnRhotH0O5Nmx2
	LRqShPgyVvJMfU0SHzH0943HlzB9p/xwjr0cAcBhyUN7kFS4h7yAh/vLIW1DGXu6
	Nt0Go0/IFw4mdoEeJvB/rklAae5Lb779BJ7eK2D/RSAmnEDVVt5Tn8SaA8O16wIz
	9ndBkCQbgH+UrGrM4J6CKX/0DW6qGN5UQAuA+ACzp2/KUq1zrK3O0goINRUSBG6/
	DE5toVO+PN/KtosKYjyq2Ze35jAs3vhIo9SWBpndbwEMwnBwD6eNBZqOH3Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782759134; x=1782845534; bh=KtsQ5sXY4IIHykbDahC8t81lgcTxJfz4Qwn
	i+pecVkw=; b=Uv5hxaUHvydgFkRm2D3GPsgJvrIDAuapuQdZDXoy88JDRinemdb
	TApY3kCTckg+1jT8tRseZDjvFfc/H7Qa4JPIchTG9HwHxL134TDQbJuXQiVQ0OP2
	+2lsyQL1hyHG6u93X94kYeDTmrlWNUlC446GdzLaViUwoIMqj9+UQqJh7HA/1q8m
	UGoNm2t9wn/WyweJ/gwRDP0CmF6HcOz+me3lJ2PrJJ5/39lACNbhyl89+xYIeau4
	3IWvu9GO7nD3GvPsDemOL1oWFiURz0bdjO/O47eDONSf8fWh4/bStnq2CfNb1Mnh
	ELh9+hVjYd16Mn5ogeRgPptzdqxxGiCTeAA==
X-ME-Sender: <xms:3r5Caium8jLWx2FzULnFydRoZzfCL8vVH8_PeBd86C3lAw8Ghq2UYA>
    <xme:3r5CauVIbEdu70NTsbRCK2jSHbmbudM3nuBhRLHOohaZ2CaDdHl7DlVn-7F1ulpAH
    7uybIQpG47TWSwTCW69lZTHgmPfbM7wf_jgH2yg5xENIEIS1Zh91w>
X-ME-Received: <xmr:3r5CamFaxx6NhL0CNBWDjkIsnE72C8SYmorsTVrfw111xfwFNqArGrCUIiPMMOHadQ5EPhwWvK2T2hArhqfs8Ftt_Ca0IlUhJ8qI-Yc>
X-ME-Proxy-Cause: dmFkZTGbItz812XYTjrcjmnz/Dc9/EgG5lsOj2xLm3v1lTux2/gre3NbGqLpanOdQPehQn
    /WRMuFnn5C935bD/UknZLC4fXVGHu7LKPgrBXPguBIVCYGSm8SupgwfZaIgDvcBvMQ0Uwn
    yBeWQrzukIGO2TRysj6+w+8OaUk+H9RvEgQrYcWQ/toXxMwSNHXBggr8SQBrHWH1zqzp/s
    gCXZi4hrhPUnB3dnCbg8XtltF+0UtkFSIvPPFgm6vTRgYFTju6XwcNZtU0fiGaGpeBoxnm
    6mNEzWcCHsE8hWtlDBVRuO0NX8ELmkjDh4+lmCkZ44BU8fL4HCNTKdXoXzHMdnQASUhhaM
    RvzdnSJEExcgooTqhGc2QqJn/4whXcbCLLySzBw9DxfIuEbi3w8I3x7MtK+wOUXn+2qfs6
    W97lqlzYWXi19HgZu5pVrp5mTgF7mqHzSe577dq/E1lQe6IY4r+SxpfADXkdkZZfgY4w1D
    rfbGNaAlTIx0li0EU7IzXZbxeFYG2jLtZU/5LNDhPRXxu9xsMmEQLanc67wQV43aEZCG1n
    tjpwWiceSnJAhqvXw8yibJCpOXpKCmJ0iCZVy/k+WBDrl81hEHhPPXik7pTtaePb0Z0l+d
    LwID9aTPy+tYDX3hiAHeC5xBIy8IqXE8mhi7krn8jGJmkNL23gi71XGs2xag
X-ME-Proxy: <xmx:3r5Cao3LISu2bPqYNyY5yn8-UP1_FLKdKj64Z5it9g5h3ebJLoRWcQ>
    <xmx:3r5CagMWVttpb9lIyYPpJCq-1zvvmrTRmVC8FBWEWN5L7IImFP1nng>
    <xmx:3r5Cav5qLqRsVSm69tPwrCLbrefXqFPaAk-z5r2ExCjbyagNE-264A>
    <xmx:3r5Cai0KRdjcPLU7_BE-T9vXW4r7XyWuo9cgGT0WND-DngMMaMYGIA>
    <xmx:3r5Cal0ruBAh84e1nr-CpnGScgnJvmIqTmHa0OVUUOhpDE6aOLKXtDtC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 14:52:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] commit-reach: fix !FIND_ALL early exit with v1
 commit graph
In-Reply-To: <CAL71e4P4GbYYv1LdarAbeodm06q841wj4gdGpn0QYADQjOB5gw@mail.gmail.com>
	(Kristofer Karlsson's message of "Mon, 29 Jun 2026 20:27:38 +0200")
References: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
	<xmqqldbxw81i.fsf@gitster.g>
	<CAL71e4P4GbYYv1LdarAbeodm06q841wj4gdGpn0QYADQjOB5gw@mail.gmail.com>
Date: Mon, 29 Jun 2026 11:52:12 -0700
Message-ID: <xmqqa4sdw55v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> My preference would be to merge this as-is, and then I can rework
> v5 of kk/merge-base-exhaustion on top of it later - it will
> add some delay but I don't want to rush it since it's a non-trivial
> change.

That sounds very sensible.  Let's do that.

I've taken a look at both of these two patches and found the
solution quite sensible, but I'd prefer a second set of eyes
to confirm.

Thanks.
