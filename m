Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808E4562B3
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428370; cv=none; b=FzWILXQW3VWKZ4TTVOIzXQZGkeuaja5RYfQtOEihzrojJ2AT2NYg5R96ldngEtkg8B6az7CXjzmmDNtQelaEPrRvO3LAtTij9Q43Q7cjDNA197aXALujUL652pj1qDRmt3WBG2v258lfSaLAV7qc4jIn4XnDxqj7rnMSaba04KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428370; c=relaxed/simple;
	bh=CzpY1DSZSIdWW7JjngMQhI+hXbbtD30K2CXY4qWZA30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V8oI3UELcg74xPvajv8oqe1jk7EypwR1Tfk7AEz4NaM2bptRb3XwfteALnArTo/VhE7j3tQ3zJJ2MzXDqIDI01KzBHfF7hu91lpXIEyfrfsd3khud+FYzGWfNZHRx+WkSJc+mnyBwldZuwbA2UyuQfyRv0bJYCShJ0yRxqFUlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CgSjnKrB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLRkm4+o; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CgSjnKrB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLRkm4+o"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5438D7A00BF;
	Thu, 30 Jul 2026 12:19:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jul 2026 12:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785428368;
	 x=1785514768; bh=ZDA7YHilLuOpQELlpgpKowWrpAwgQJero+u/h9MHfI0=; b=
	CgSjnKrBAGKIHgpbD1paapt6y1R+3ZLAfC///GGhkzgN4wVDOAmWkWvA9HLjAnzl
	fAzilHrSd2Wot1VU5Am4GNKgSIP5ZW39uDGDNLMJATvP29xpr6+avBqulut7mTCx
	XBi4XIXcUeZQ8x5tWywsLPJIS+rEURc+AC9yx6+Zo210Ii7+8Fkx8z/s2zPSfrgD
	0w5DWdeKslG00UPL32NFUykZYfm7Hr4fkCJAFKV9ldgkFhvEB9RyFQwTySGyq2wd
	NbtQeMkZ1oFWxsaCa/f8klLTg1RuzYigrG+PoySi7tQ+wxnMcu5/V+pbygP3LzY/
	ZZqx6jPDd6fPNzGRzLfg0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785428368; x=
	1785514768; bh=ZDA7YHilLuOpQELlpgpKowWrpAwgQJero+u/h9MHfI0=; b=Z
	LRkm4+oJCXfjrmG6ybYeLYPjMwCjnPyO3RhYr3mPCIQF0Lc6CCsYj21O2+lK7/5S
	A42agvHoGAfaavkMQ0uzs2drXoiyleOe9MP5rwQC9iU0llRAf6ARj2ArOKPEgX+g
	VgT/RS/3LrzNgrZ2rsyFbr/iRj4nKvE59kDjPW0dtWpU3px/zUuTX+RXSFe1JynR
	d0yWvQV+ThaH8yq3HSxk5QUIwIabM3H7Qde12P6FBu4EglugT5axX9VqhYbWRp4A
	wrWxMr8M06H9MfoVsiB9GEhQzcn31h2rTIpw6m3zhhtV4xx/JckFY/zUHy4PNb2Z
	w3/HoZWlXPqEv9aXe333g==
X-ME-Sender: <xms:j3lraitVXz-grHcVgL1UKDpjcLiBItEIor2aES_8xWErVtbM8y3eDQ>
    <xme:j3lrapvpjW6-omDkmVG7_dt_WCeXu_WUTWyuBc163Crle4Cd7e9Z6haiqDtgWxuIq
    Zu90YznZq7M9WK8GQfFWVFLscvcb020VsqlDXBGYsT8GS6-TiNPLQ>
X-ME-Received: <xmr:j3lragCVdUKAc5zn7rxZ-HTdTIvFbGfxQB5VLHFIKwfziq_lPDYV3_mN8YfMb-pQHS3ooFrEpRDYfdyBvTFm61mD1Pa6e07PvA>
X-ME-Proxy-Cause: dmFkZTEKXtD84GWnBMxtreOlUPM/3udahOSakspFVoz0zHOB915oMzMUEpua4qiFdBsSrH
    LsnkSx3Ju8+w6W91PNEmkVSp0Qs09dIWwxQFiQl/1CLd/IvVKPr4YpeGndxT62FgCsk6Q/
    ZGeneCQklZLPfYrUXlXWO3p+O1giMLUTo9aei2Vwg9GQsaeetWKkUBML49A/EsbcxnVBLu
    myzNDJmNJmTtPIvIxqczFml2amZaiVVK43dtRWMgVroP8X6SFV9IQk3QxQn4WZ6F0YB3rw
    t0aAtHBwDPPs1hEP8KRhn5KkIEwr/lZJLJ/4kxwVEEt4N6QpovNtsI/lroiCosbydKH+QQ
    W/R1H8dusci72lKxPYcztKPfBZNutgTRuRiy9eHJ7eQTxeKEMxcjzlZ61cN1fj5rPdRsvW
    8c/rrTdTZXIjqEq/EMV0jXDDY1j7KS7fagyoShF0r4okWAbYrZud/kxwXlhLW51cDqLwQQ
    ojv2uXRdKz+VI99yiiSu61zkY4BDg/uyfxdKNJQ6uIeyruHissvNeueQhxx6py53QoCv29
    zY5FuE/PYDN1yOSBD8zrM7va16HNVms77eSZC2kBIbEpelP4XUVdK1anDyOadkG6zPi8iI
    KiJ+dnThszth70T8js+/QhDncgVD2NI+cIbALYtGSVN5FOoMBgDyelxz72Jw
X-ME-Proxy: <xmx:j3lrajPfndr5OzgQJkh70EP6Mv6L4s7Tl4Sc16Jy3Wl4DcWZULhh1g>
    <xmx:j3lrahyveDAJaq1vkZArOJPT95iloBMf63oX--z2Rj-mzQpF4AnIjQ>
    <xmx:j3lrarUW0xhPb8kipUqI_HFrslUVFK_VYPDT5kD0YEGijwK_b5RA9w>
    <xmx:j3lrarOk_ZDkNzTLXQkVKs8TNDykk0pfN8ibSYIUve26tTC9zvUaSQ>
    <xmx:kHlravWQiBrjvpP3GFN3iKAdkuaq4F8xdRoDQ3WoZIZf8a0HBW3U-VqW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 12:19:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 0/4] doc: replay: fix config link
In-Reply-To: <V4_CV_doc_replay_config.af3@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 30 Jul 2026
	11:57:12 +0200")
References: <CV_doc_replay_config.709@msgid.xyz>
	<V4_CV_doc_replay_config.af3@msgid.xyz>
Date: Thu, 30 Jul 2026 09:19:26 -0700
Message-ID: <xmqq4ihglab5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name (applied): kh/doc-replay-config
>
> Topic summary: link to the config for git-replay(1) (one variable) in
> git-replay(1) and git-config(1). Also improve the doc for that config
> variable and `--ref-action`.
>
> § Changes in v4
>
> Patch “improve config description”: Take Toon’s suggestion about avoiding
> two “for”.
>
> § Link to v3
>
> https://lore.kernel.org/git/V3_CV_doc_replay_config.780@msgid.xyz/

That's truly minimal update.  It is a bit surprising that the topic
was stuck for a long time, nearing its expiration date.

A quick look at the thread
https://lore.kernel.org/git/V3_CV_doc_replay_config.780@msgid.xyz/
tells me that there weren't any outstanding review comments.

That unfortunately does not say if this version is good enough or
people got tired of reviewing and did not pick all lints in v3, but
we need to work with what we have, so let's see how smoothly this
round goes.

Will replace.  Thanks.

> [1/4] doc: link to config for git-replay(1)
> [2/4] doc: replay: improve config description
> [3/4] doc: replay: use a nested description list
> [4/4] doc: replay: move “default” to the right-hand side
>
>  Documentation/config.adoc        |  2 ++
>  Documentation/config/replay.adoc | 19 +++++++++++++------
>  Documentation/git-replay.adoc    | 16 ++++++++++++----
>  3 files changed, 27 insertions(+), 10 deletions(-)
>
> Interdiff against v3:
> diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
> index 40d1695782a..84e17e313a1 100644
> --- a/Documentation/config/replay.adoc
> +++ b/Documentation/config/replay.adoc
> @@ -14,5 +14,5 @@ ifdef::git-replay[]
>  See `--ref-action`.
>  endif::git-replay[]
>  ifndef::git-replay[]
> -See `--ref-action` for linkgit:git-replay[1] for details.
> +See `--ref-action` in linkgit:git-replay[1] for details.
>  endif::git-replay[]
> Range-diff against v3:
> 1:  ef8212a076a = 1:  ef8212a076a doc: link to config for git-replay(1)
> 2:  35b44b922e5 ! 2:  392c4f3ab9e doc: replay: improve config description
>     @@ Documentation/config/replay.adoc
>      +See `--ref-action`.
>      +endif::git-replay[]
>      +ifndef::git-replay[]
>     -+See `--ref-action` for linkgit:git-replay[1] for details.
>     ++See `--ref-action` in linkgit:git-replay[1] for details.
>      +endif::git-replay[]
>      
>       ## Documentation/git-replay.adoc ##
> 3:  12c73641fb9 = 3:  a693ab0b6d3 doc: replay: use a nested description list
> 4:  e2191c723fc = 4:  53663bd54ed doc: replay: move “default” to the right-hand side
>
> base-commit: a89346e34a937f001e5d397ee62224e3e9852040
