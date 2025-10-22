Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78134FF7F
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146868; cv=none; b=JA0bXiDXCtkcr8La5ktpJTpngg+a7b6tfGvKyH4O2va2nfb4xkKGlWUycZvObSDLjxw3ns4dbMubjfKBqn00sOtO0J5AR5rWKqexv0AWqCCK8YOFXBzYhyUMDGogK4IktGbqLLo0y4MBhG2mPGsjMieF0eQC8t8Gjy6Rd4u1JfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146868; c=relaxed/simple;
	bh=fBFwBJiaoVnu3oqiiIAzBlcO5+LMHlzC4p/ycAEoUQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gH4mF6bBq2xIxX07EkDLwE98Sy3fafWSCr6ygb+/+gd69SbkoEWuoOChhBPRTiYIEkSj5aADjfBhn1UiPCOZfrryvNIvbHOMO0E2/7chwztLuo6/j4MbC3K0eq4yOpyj3DdP44Qh2HgBqY8X4w84nwGPED+ILVqZ17cbYLDPs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q0E6oSlM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aZELVNQA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q0E6oSlM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aZELVNQA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 070431400112;
	Wed, 22 Oct 2025 11:27:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 11:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761146862; x=1761233262; bh=quxPws37HL
	9f57NAWjHuIZVnRywjpLGy7jnA6ZDlvfo=; b=Q0E6oSlMwArGaMAQqtnxzL2w8f
	nIoXqYSDYvaFcjVZMZIpxVvFJsFcH2kqn4HZPvUVRPCdvhU3taT7SDK0BYLv/Km4
	Tgjfrwkmek5/GLojSWd6kgXVl/j5nlkB0Nf7bj/A2aiHWAl27gn9FPDpUCNkY4i8
	zduOccms6v0a2f20yuh4w+LNyn6ZjUOUW4KGaPmfuKPSmQTOiUcPaFvz6YiUDNST
	JVbSaQfiO4RdogPOyDILDkuDuJ0wMcFbZELMmF8MiDzjIOZwgCofm/L1WsKsRzcM
	CakUb6HQbKd4vX8jFUXQ7XLNwtSYc+1bW/l8c5/2KUEvQl9GY08stLxvDawg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761146862; x=1761233262; bh=quxPws37HL9f57NAWjHuIZVnRywjpLGy7jn
	A6ZDlvfo=; b=aZELVNQAtuLUvjM2MxncAim0GM0T/d0pZ///0OXi6EGA9hDuTko
	bnmxuyOBA1C6NBJt78PqeYaPO74XJcCSU0PrA7KmhgWctM6RhPFOqaRe1zcASKVB
	EOFeqWHkCyh8+fu6AjKBKws4ykbM0nApgEv6QyFMLVc/1RCWcoQYkf35Xo6Gep4E
	Pc/frlN0SwGOgUVcze8Aq6YiMEgX73kPzmRNMcFLC+GJz6rq7BxGqHbAC/vjCcIR
	tS+u9nHruZbMjXmWO9HJMjoRevhj6Zn4c4in9W+sDBh5z4rW+JNqCc4njTQtPWRG
	bmK8BXoVBd2nvQ3ay4JVTogr0UvgDNqVWAQ==
X-ME-Sender: <xms:7ff4aHWIa9Y6qr-qSrOecUM-EQymSdLQZycMDgxsIU4WzXUZXDSn-w>
    <xme:7ff4aNITghVZr9Z4CBU4v0Bt_AyfUmmBebn0wAVEI4PcG3AsKH2qwZugJGorRsVyD
    L_0gp0Sy1fodjmQ8WAp1KmI2waNQTVjzmjkl_s7GH1vB3PA9bkM-m0>
X-ME-Received: <xmr:7ff4aJ2KePbe7KVnm-ELrm4T3IAYtZu9PqiZlZGgdHWteCf-BqB0oWnclEMfev-H2eY7_0-rb9VidJKHdfSGdK4JBR2Tega51s92>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7ff4aD7nTHQGkKP3dcxAb69fe1CCfV5MVSLg5esXHXyFZ9g13Z0MOA>
    <xmx:7ff4aC-J9d9SZcMYnYsSxRxrhwXlrU7sG65ccPyTJZTkYD6biCa7tQ>
    <xmx:7ff4aKX--aHaRivcUNhoxpAfL2NU0B7RLWKUV1VLJ-5mg_fbEIB_Ng>
    <xmx:7ff4aFqlvvYyLZh9jjIvZubnGJ1owaAKyNLp2RdNd8zXiL07BdJyJQ>
    <xmx:7ff4aEjO_OHCi_x9kDdqVE1LH4GJgStuAG6Ue7U5oC-fV0dAPTDYkG0T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 11:27:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v3 14/14] ref-filter: parse objects on demand
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-14-eb9f71985ef0@pks.im>
	(Patrick Steinhardt's message of "Wed, 22 Oct 2025 08:41:14 +0200")
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
	<20251022-b4-pks-ref-filter-skip-parsing-objects-v3-14-eb9f71985ef0@pks.im>
Date: Wed, 22 Oct 2025 08:27:39 -0700
Message-ID: <xmqqtszryn10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static int get_or_parse_object(struct expand_data *data, const char *refname,
> +			       struct object **object, struct strbuf *err, int *eaten)
> +{
> +	if (!data->maybe_object) {
> +		data->maybe_object = parse_object_buffer(the_repository, &data->oid, data->type,
> +							 data->size, data->content, eaten);
> +		if (!data->maybe_object)
> +			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> +					       oid_to_hex(&data->oid), refname);
> +	}
> +
> +	*object = data->maybe_object;
> +	return 0;
> +}

I wonder if the calling convention for this function can use further
ergonomic improvements, after seeing that ...

> +		if (!tag) {
> +			struct object *object;
> +
> +			ret = get_or_parse_object(data, refname, &object, err, eaten);
> +			if (ret < 0)
> +				return ret;
> +
> +			tag = (struct tag *) object;
> +		}

... this pattern is repeated three times in the patch.  If the
helper cannot legitimately return 0 (success) while stuffing NULL to
the object, then something like this

		if (!tag) {
			tag = (struct tag *) get_or_parse(data,	refname, err, eaten);
			if (!tag)
				return -1;
		}

ought to be sufficient for this caller and the other two.  I also
wonder if this can further be simplified, but stopping at the above
is fine to me.

In any case, the overall idea of this step is very much in line with
the original vision of ref-filter.c:populate_value() to try avoiding
unnecessary work as much as possible, and it is very much welcome.

Nice performance improvements.

Will queue.  Thanks.

