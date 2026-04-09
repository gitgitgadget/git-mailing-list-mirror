Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D34308F23
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763546; cv=none; b=mB48PhHWhnAqBh7cDlX0Z1PsgtqLc4rCTLdlRG9lh0qKigtfTSUq7WrqLGd6PfQkqZUeGtE5eJrqModEe4u00iGljjKocIOX5OZvczRehH2w72BfCunLTgroD+kd8tQLq+IT4qyYw8MTPJltyEmETeJialdHdDoc2lEhC/sRVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763546; c=relaxed/simple;
	bh=5eLEEveqcRqu7/h6TMhSDVp+HCgvDf5x2qaPFtz3PB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jpngRIRP0PpFho5IXCtlz8NXLJ3yHUMK/zr5qvroyQKSr3dkt/Y0yQCXZe4fspyqZhao7M3A0bPPy5APz7Z3K+BPlinIoBc3FtQRDFqAqjmipV4HbAcXxM1uhJl6vNzKEGV/aCXl4njqbFFQHAdGNUl8Lq/jQqaGeYQxVVWzApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d6iK6PtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aAhuX9Qe; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d6iK6PtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aAhuX9Qe"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29D197A0200;
	Thu,  9 Apr 2026 15:39:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 09 Apr 2026 15:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775763542; x=1775849942; bh=ssjKfZBEi1
	d8gakma9CjxRVZyHptVylX+bK3K6N0xMU=; b=d6iK6PtWgxJpkiCcAvk/GYfT8j
	6eBE4yWXBjL+UOHUGHLQoHTYlwA/jNZj5qj+N+JHrgM+Ad2NEnwL4kap4wBPS0FL
	w0gGiE8zPjlGCehykZRC29bb/XpMKIlMOFt1og0alpBHXqH074GtPduqOMxEcUq+
	jHvvhGig9Zp4Cgv3gawFsrQSAnX8kAVEYL0otBcwKvS0n+mvJzIVmzAVTqv/+4qP
	+yq9X2Hc1fap6cSBN531JBuPYZhHh7ql7+h3tBV/8Lt+4/gZsk5Wl2Ej1d6O5vLl
	QSfr32vWh4Q8x0N6FFMulye3ssNoyyDZ3TGTTJzNmmkaIyDchSE4AM7alGlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775763542; x=1775849942; bh=ssjKfZBEi1d8gakma9CjxRVZyHptVylX+bK
	3K6N0xMU=; b=aAhuX9QecACoJZ+MTtqpNj8FR5fJIqMFRtVviHeUldH11Xbyhgx
	kXtC2w6HO1cImrsCV2pYfeYfml3FmXGUjCFl5J30dbURdGtfWHbBjG81dl7n9E0+
	QKK9cXW72iSj98edIMLtkrNQtOg2cZivqjqPIzJqqVc/0vSn/4KD3/LS1DkAlsNM
	L68slVCJTwavC3xC7TJv8E5H/0iGhFx1hEbqVNYFYSHyhJrxlVTeMHgQjg0KGvhP
	WebbRj3XZnZ8HflFMgFQdAZlWpMvLGK7ooGFD5a9ni29AH2EkBwux5tMy3EXDgWa
	SFQXFlU5zGwE3kLQ0mUh7d8i3Q2CYwjf+OA==
X-ME-Sender: <xms:VgDYaUQVuF5mK2P0o8ej_19L-2TvEHtWX0nA2lf7h1cZDiJYdeQkIw>
    <xme:VgDYaYzmWq26OjgO0ORCDpyb_VDcVfvei79WMZNMDhmrCOcwCInNkHk-LXEcQpcGK
    JLAwI84pOW8lqvVOX7wa4eiZiG7G0CktaUZh8woln3ZF-7QiLDxWw>
X-ME-Received: <xmr:VgDYaW3_z9lp336b8BboUQTGFXGbEhcqqr9GPXcDlgQzuw1Rs9kSrmhNOK1WwRECS3KgajFTD5HVX_keDskpsTrD66B32j6bNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VgDYaW69p3QgPzIIDkgNrMlAjjApdVZP1TfgR-o4OEaNtrm0GMbnjg>
    <xmx:VgDYaZWxRRIhQ5ccMcVQIAdbax49ZCMBjbPZY41AAxq6QyX5fxLOrQ>
    <xmx:VgDYaVDIKp-cZXubwOsCiSxTATRj8D1F6LJ26s4wBCFDAJhlZNwvsA>
    <xmx:VgDYaY492sYVRkypZl9CGSQHZQ1YMsD6USiBtsfysPT66YRsFiZ0Hg>
    <xmx:VgDYaeXPFjuZTJxyCQHnzSutcQwXhMS9y7wNhsoDaKb6sTRN5ooUr9rF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 15:39:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 16/17] odb/source-inmemory: stub out remaining functions
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-16-f02b4f1c0f13@pks.im>
	(Patrick Steinhardt's message of "Thu, 09 Apr 2026 09:24:37 +0200")
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
	<20260409-b4-pks-odb-source-inmemory-v2-16-f02b4f1c0f13@pks.im>
Date: Thu, 09 Apr 2026 12:39:00 -0700
Message-ID: <xmqqzf3bsz3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Stub out remaining functions that we either don't need or that are
> basically no-ops.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-inmemory.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index 15a6a5ae64..1140b1b916 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -299,6 +299,32 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
>  	return 0;
>  }
>  
> +static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
> +						 struct odb_transaction **out UNUSED)
> +{
> +	return error("inmemory source does not support transactions");
> +}
> +
> +static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
> +					       struct strvec *out UNUSED)
> +{
> +	return 0;
> +}
> +
> +static int odb_source_inmemory_write_alternate(struct odb_source *source UNUSED,
> +					       const char *alternate UNUSED)
> +{
> +	return error("inmemory source does not support alternates");
> +}

OK, 00/17 said it only fixed log message, but the messages or
anything end-user facing should consistently say "in-memory".

Or, "in-core", if "incore" is chosen as part of identifiers to be
consistent with the rest of the system.
