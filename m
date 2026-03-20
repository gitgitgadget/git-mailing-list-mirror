Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22352383C70
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048413; cv=none; b=hilXy68aDukFWdvh5X2HtfNwiBRifNBNhJP+jNbLnYm184LU3xcavV9guzXoE7GD/pD/FO6RDqqBqihKqN1jb2htNmAZCgr+kDcqOXOmZ2V/yDpVGrArqTuAccjR+2I973m3lRritdCecpYqPXgc5XqRKbMoytx2b5Jfh1dDmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048413; c=relaxed/simple;
	bh=2wgvfNlGHJf6qdGEI2LaVecm19kiXNALoddZpK+0STQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WpIO+MAXniwJ5VFrjpp0niCOwnXTtcRt+UNsb9pEBYDtiTTBGinFlJ7NmeUjG4EuKNYr0Z6CUDVbkRZ9eIAQjw4oyY3WLlZrDq4eSt0ue+VlHum1hly3jqenEhJuCVfRcsRetAZzwU5vnTREPnqVRWkra4T6G5vUFRe5sce0Nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jVWjOwl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gZKs3kcm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jVWjOwl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gZKs3kcm"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49E90140004E;
	Fri, 20 Mar 2026 19:13:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 19:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774048411; x=1774134811; bh=LUVTbwEfe8
	ceuLn5fwrpY4KEba+VKF/ijIm6ER5woNo=; b=jVWjOwl5D3QPRYjQfc3AaiZw7D
	zNKwVb91H5ZiKLMKHm0qHjygdlTBD/FPIeX7uUpuiRf/a+1vcnd/DtxIgLLBU1yw
	P4p2Q63i9Pkxt0z9iGG4z9U2pl4os7m14BJ43CyARYtrF+R91dpnz4eoopuMxbak
	ePt68XonGHeJ7AAtUuFPu0wSVYmpd2N6Amuof76eEkwwXDbFcjaDOvLvO6nqkC1b
	wI3e0MM/NGUQZFF3tgziiiYN2ygOxyJEZsVrTRuqNrdIzSQtHjUKtArLqdHPvpE8
	mmI9XwL8cv6j23UZzrRT3dumtT+yOzIQ5iu/y7RiiMnVSx1zKTE4YovMz93g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774048411; x=1774134811; bh=LUVTbwEfe8ceuLn5fwrpY4KEba+VKF/ijIm
	6ER5woNo=; b=gZKs3kcmTAy1kcAPt6Uh17VRy14OdiOrErzOKAWFGZjJkf8ML0a
	O24nKEoBz2CN87h/tdwgEzohieRAIfKN0zLbQdlYPCMRl21L2NlNJ2DM3WrL3pz+
	GPAA4INhryAmdSBFrNB+5ILMl6Ta5lu260KGD7wWN80SYpvxiuhZrLTUDJSGyq+u
	Lu9xTWD5hnyizWPSf34VmNNzIS9RVcy22DqpiRSUr0fhBjzVbZuZmy57zsi+Jb+X
	o7ZUZUmi+kbLF4GVNi6aDa6u7Fd6KoGmOQvbo9YGzM6khoRACKBXbpEHJS/pqgfs
	HiMjUvPxBloe7Y+nAh7Y9fKQnfRflSS8djw==
X-ME-Sender: <xms:m9S9acNgekBzbEXopry0RG7WbY5V4J8JrFS8tQVdVTi8bYXy3tv50g>
    <xme:m9S9aaZcoGYJ7yx--RBeemcpcCxm4GJwU-ntUp9Q1yoNcjnDgRicJeUhRJOJl3RRf
    3IKscjX_q4FwPGKtduN1EX9F5hM5Z7F_rUCtI_wXGrnwpZotZ8B4A>
X-ME-Received: <xmr:m9S9aQqfCle6UyframglZCJNpLlyooffdfsPIHLfBrQIW3pFK-91ZU7dzkFM6wvtAuJvA-F-DEoYxVkqBRqiVibDoRvdRpyOxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:m9S9aeY2a8xpwvZG6D3X6u6hf8pozaNnXIZta6CEFM4oWr84GnHQEw>
    <xmx:m9S9aYR_YteMEgmkspLRC_Ove0Hqg8bFcVJTH4y1HakoIQK99MTMjg>
    <xmx:m9S9aV5kwkMGJg6hiW0Q5JRTn4lhL5hBlLjwDiH-sCHEgv0Oizpbjg>
    <xmx:m9S9adw5bPiepmwlFaXWSQXqzYOA-zIAEL0tsWX9s7ElOWt1B3pv2g>
    <xmx:m9S9aagV9aPuwfLdl2mrW3kupoD325cJoV57OWZhuDQQ7PTqhrOXSU8a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 19:13:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/14] fsck: provide repository in `struct
 fsck_report_object`
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-13-6594f997926b@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Mar 2026 12:47:18 +0100")
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
	<20260320-b4-pks-fsck-without-the-repository-v1-13-6594f997926b@pks.im>
Date: Fri, 20 Mar 2026 16:13:29 -0700
Message-ID: <xmqqy0jmccx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The `report()` function invokes a callback function with a `struct
> fsck_report_object` for every object that failed at least one of our
> checks. This report doesn't give the caller enough context though, and
> thus they have to rely on global state for `the_repository`.
>
> Refactor the code and inject the repository into the report.
>
> As this requires us to touch up all callsites, rename the `report()`
> function to `fsck_report_object()` to align it with `fsck_report_ref()`.
> We have already discussed this rename in the past, but we decided to not
> do it because it required us to adapt too many callsites.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  fsck.c | 365 ++++++++++++++++++++++++++++++++++++++---------------------------
>  fsck.h |   1 +
>  2 files changed, 214 insertions(+), 152 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index edf7a0618f..59b9163598 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -258,13 +258,15 @@ static int fsck_vreport(struct fsck_options *options,
>  	return result;
>  }
>  
> -__attribute__((format (printf, 5, 6)))
> -static int report(struct fsck_options *options,
> -		  const struct object_id *oid, enum object_type object_type,
> -		  enum fsck_msg_id msg_id, const char *fmt, ...)
> +__attribute__((format (printf, 6, 7)))
> +static int fsck_report_object(struct repository *repo,
> +			      struct fsck_options *options,
> +			      const struct object_id *oid, enum object_type object_type,
> +			      enum fsck_msg_id msg_id, const char *fmt, ...)

Earlier I wondered if struct repository *repo should be added to
fsck_options; I didn't comment on individual patches, but almost all
patches I saw since that remark made me suspect that fsck_options
would be a good place to pass repository throughout the callchain
even more.
