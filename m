Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893F35C1A0
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889203; cv=none; b=ZhmZbsi+E85bnQl1PypbnPHCE6E79F5v+FggMilq+uzmgzhgDEGCsL5S2gsf2tiNhMDghRcNIiHSQtGdRflc5kjo5Ya7vQy5p309HzEPka9JPd/J4mKrvPDa1r8c7NEPHM/8ZVh7UhlG0vBcAcKE9wsS54p/LxcgXf58YxDyB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889203; c=relaxed/simple;
	bh=EysZyRlcsJRxTzJFarK1dJDRuXspVUBci/4T4j38sT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BgU7HoV3xTvjW0WdCw2L6Aqgv89zfQPuDXj+idw7mOVQbyuzycUU6YZOUYqEjov8qQjIUCY1T/KhmRTUscoDpwB5+DUiBy9UGVQvJTlfQo2WWui5OpC1pDQgSGg0Xpo+F2UIWWSgq6yHW5ry+OqwyuLuXup1DBG01zCXbrUbZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tbcV5LMX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PP0noSJU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tbcV5LMX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PP0noSJU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33C2D14000DF;
	Tue,  8 Sep 2026 13:40:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 08 Sep 2026 13:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788889200; x=1788975600; bh=QFfWXo1hKe
	9jWvNvTzdmDLvKOJ0N7orIApA4F/ogqJk=; b=tbcV5LMXmLg40ssOWVCSUZ/cVG
	zdHPlP9+TYPWkPms6cc3fwRfHGsS5Pw1uJ7AZDQzDAwSTACZFTbAMPVjy2k0QiW1
	aOmmCyjaotXKz8hm5lVORe3y6EBoOMXVAeNt9cBdWTuiqw7Wq2+M/f7cDxwW1XiK
	Z5BNPeUuo2zyztjcT2iDI+Ww9g01xmkJHL3PBG0O7dbXdv+hhXuo5e0RozO8pQrG
	otNFZUJ+ScFtqgWLtqCtfHvN+8NN1Lj6fV4YXJCUhgEb0okPGG4JfJXp9YyB8Ms6
	NlO0iQDc5xyXNkNXhomjBeALc9m0vLu5rJaKvy1Sf86YUMo50QTu6nFf26Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788889200; x=1788975600; bh=QFfWXo1hKe9jWvNvTzdmDLvKOJ0N7orIApA
	4F/ogqJk=; b=PP0noSJUjh0O0Hz6Wh+iG/EVk/gOX1fl1ao14/oyouty7e1HG73
	AFxymYQapLzvE435Fc5006JgsZ2ccKRQ978Gm/VI8ySOmmlwZtSMcvJYYClD6Frb
	8Y2/EMz6ZwfX1YEnRpYP60JJDtL0Rot7n680JHhRJqApQYXR1e9QZhyxShlkf6cU
	C2vW1u6m3e6jqjjAfMDAVDR8Eac+aP+1pFkXzov4NbRLkbQRF2w44hCB5/aU9bP/
	cC55E3VgLjX2JErAFWrLCcVwCKfqCd7HNbhxo2PEmzui38VLpPwQ1yZTU/YjTGYk
	RV+71jsc/jyQuu9PGcXrW31KIcJPKbEbaKA==
X-ME-Sender: <xms:b0igarF2sBoSbggfcu6RA_dZgJE1Ndbdb-xrEXQV98jt3cB9esMEKA>
    <xme:b0iganaKWl_XMNI7cE--d-UyOSZjpKZFvT-RO5kyraZYjARfyrxggIIVkXKO0iOaZ
    CEBTNCSqvtjEuuH04hYLS_55gudSzqb9V-Fv6pRiNhNkamPKzST1Vw>
X-ME-Received: <xmr:b0igajW2R34p32P-cCCiO3JldZaRWCvT1MIJFcBt_Fur9FwuJw2XQwl4DaQm6gpo01lyCh6mSHp3yby3nf8n2nCsm0flOB5haLgw>
X-ME-Proxy-Cause: dmFkZTFu7wNbOf9w+O/p3pLWIjgR5BYZKuN3h9TV05PtK8Mm7MXlplHF0Atz5PNnDPFzgz
    ybitKtVeEXasTmcEAI+IsBWoSRFzxTvIvIkjkXpfXf0nlU6lpuEhQW4Gyh3xdPqtugqZ9t
    V1ilzhtvPGOKHMZRZP1JVvM+LRiifuRTB52jbyIC5ymYk5DiZyLnQn91MHiD3swPCvF4E3
    ZRm0vjwaRienZiJBCsPJwxRP5c0RNlVqmZ3Bubm7RvlTF5CwB0rcRmCUy8I+t2OgLUDjNX
    iswZ6VQyg4tCjVdIZESnkyNRIoMRU5YINA4NespnV/42f0e1QnoiPcShtpfqrpkNhnBmNq
    R4gc6agrOwHqWup6PbcF/CAKn462D+gxzj6bKzU3uoUQBmZJ231fisOJbPH7pA4eKlCARt
    qvxmbIHMbt9wnfIyUhw/YvwqgXzUXbpxGsxMolw7wV/QJYqC+maRL4f6ZGktXgBfZNanWW
    9FkSHf9vH4Nzn/jmu5DJkgCkI2qNFkw4ThpyhBzv9xoiiwoYFK1Xl9OZLO2563ej6A1ASC
    4mnnBbMdhPduvvbGMSiNbw3FmyiCFNnO4BaaP89MWZhgfMO+GEba1ejmeuhFf1NhHFvOsA
    aYxACNLVMvjjamzS0lSmjgffDBk8QvtJKfwF0NG+3KRWdFyBue230n9kh/SA
X-ME-Proxy: <xmx:b0igallQAZYh0KmXDXImSRlNelSTGMncgCskL3ADFdlKlihNSG3BPg>
    <xmx:b0igamC6CXVvOVSXdKaLf8NGh7Z6PoSjHkGaDx6NeWPOEPHgX5Tm4g>
    <xmx:b0igasiYzoOTjm48zsb6S2NkxJi25i-kEfFjpZVtdXzoDSlnBtrNVg>
    <xmx:b0igarwNXoe5JDuWE5b6SQ7ZF_GGre1wIZYkQEVSpfwAtCauJw0SEg>
    <xmx:cEigaoLF9Ri7tK6k68FDNstjFye_h7EuhYY5Zw7gmsOvbaz4IrKDgnXM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 13:39:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 1/5] promisor-remote: factor out lazy_fetch_objects()
In-Reply-To: <20260908164129.560396-2-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 8 Sep 2026 18:41:25 +0200")
References: <20260813154748.2378747-1-christian.couder@gmail.com>
	<20260908164129.560396-1-christian.couder@gmail.com>
	<20260908164129.560396-2-christian.couder@gmail.com>
Date: Tue, 08 Sep 2026 10:39:58 -0700
Message-ID: <xmqq7bkvy74h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In "promisor-remote.c:fetch_objects()", there is a check to disable
> lazy fetching when the `GIT_NO_LAZY_FETCH` environment variable is
> set. The fetch_objects() function is called once per promisor remote
> though. So the check might be performed more times than necessary.
>
> Also promisor_remote_get_direct() mixes up the logic deciding which
> promisor remotes to try with the logic checking that the objects
> that could not be fetched are promisor objects.
>
> Let's refactor the lazy fetching logic out of these two functions
> into a new lazy_fetch_objects() function.
>
> This is a pure refactoring with no intended behavior change. Two
> things shift in ways that are observably equivalent though:
>
>   - the `GIT_NO_LAZY_FETCH` check is now performed once up front,
>     instead of once per promisor remote, and
>
>   - promisor_remote_init() is no longer called when lazy fetching
>     is disabled, which is fine as nothing downstream of it, like
>     is_promisor_object(), needs it in that case.

Yeah, I too noticed these while reading the patch.  The latter
change may be a very good thing, in that the calling sequence around
promisor_remote_init() seems to be anybody who needs to access the
promisor remote information is expected to _init() the system
beforehand.  If it were "call _init() once at the very beginning and
then do random things on promisor remotes", then moving its callsite
may have to be done more carefully, but with the "user makes sure it
is initialized beforehand" convention, the postimage of this patch
follows the pattern exactly.

> While at it, let's also convert try_promisor_remotes() to return
> 'bool' instead of 'int', as it just returns whether all the objects
> could be fetched, and document its return value.

Meh.

> +/*
> + * Return 'true' if all the objects could be fetched from the
> + * (non-)accepted remotes, 'false' otherwise.
> + */

The comment was not quite understandable, at least to me,
especially around "from the (non-)accepted" part of the sentence.

Also "could be fetched" made it sound as if this were dry-run but
isn't this function actually doing the fetching and reporting if
everything got fetched or there are still objects remaining to be
fetched?

    /*
     * fetch remaining objects (given in remaining_oids) from
     * the known promisor remotes.  If accepted_only is true,
     * ignore promisor remotes with .accepted member unset.
     * return true when all requested objects have been fetched,
     * false otherwise.
     */

The above only mentions half of how the remaining_oids parameter is
used (i.e., only on the input side), but if we are adding a comment,
we should document how remaining_oids and to_free are used as well.

The semantics of to_free in the entire callchain is especially
tricky to describe correctly, I am afraid.
