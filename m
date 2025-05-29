Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D2335C7
	for <git@vger.kernel.org>; Thu, 29 May 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555953; cv=none; b=GHn2BGnKCd3SpXml58GI1BjKWjquprYVaTC+foIDL6DjgN7+332OiLMA73v3ZYtTZ2Wa2rRrmnJlSWMnuWsvhwUjFlTUj7IHnK2c32XI2Pr19Fbj/hPmdIMdhvct2rjk3wZCKrQSoMDQAZ7cLGYl/7cg9GeQ4+CZxhu82xZ74eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555953; c=relaxed/simple;
	bh=2PnlCDT7EYrFaSzAd4luQ6wRUV8NAdSe1r2yVy4rSI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b3iexpgnmJ6+WzblLcwJj83APMcWguPWm62gqmmama8ipi1vzgn8rTn1AFasGqDUOSqnmoj5+MY8pwqNP47BggJ51Moo4eh0Jueiab8xJcKAjaPoLo45TccfFh29kfgTJ+r+oMeOAfIT67BXvmWxdMC30X9JVWbiDdlhhrn+NpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ECSQ2Oei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pVkHgz0e; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ECSQ2Oei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pVkHgz0e"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D33131380090;
	Thu, 29 May 2025 17:59:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 May 2025 17:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748555949; x=1748642349; bh=Yqp4gPQiF2
	t22Cq/Lb1GTyt0EzcHF7c8/nfSDVHyJgc=; b=ECSQ2OeidvohAfDzlppGgqLCnl
	LFlM0LPshSDgOvxKRSh8cGor17U4kyzyVfmlIm9oNihYsXw2QVKnzSW9voWjSXVs
	z3SvQUcSHFrPe/iqpvaNlKHVwPDUNDIdGCTFTb3Zm7xcbliCVELZtWfO7gwmAbkd
	rBFKcyTI5c4/JmFwYb5XMI8J1L4WKRlsM/1d48tJ9ixQPdY10fuF54v/+n9lMllc
	d1hmZPXTj8dv+iwLPjD2UMAQW33aNVqmCjoPdOjo99jLVtnysJ58X6viQIWZTTbn
	leJujAP65dWt5oXIS4FHJ59WWqbTg0/DAjqAy7gq708RT4iJGiUxdYb+bY9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748555949; x=1748642349; bh=Yqp4gPQiF2t22Cq/Lb1GTyt0EzcHF7c8/nf
	SDVHyJgc=; b=pVkHgz0evxcXs0/HCbRR9x2j4xmfOPtfLPMxoahKyps/l7pR9ia
	I6Z/uCQidVXN4XEDgSiPlKLkP8nJ3WXbgSmMq2OkF8A6dhjVrHkPsn6kNLimnM5h
	ILFE9HDqsfydf96ITbV+ZuenLLp3fLN68ab7lADIrt2wzSwqPFrTAB+WlZuyMR3t
	2TdhbbRzV4seZ8hzzAbA45/yjTxhFSiRnpXgOAZ4H+e1pF5XtYvcem+U/Lmn1yj5
	itUH2hs5i5RrfcRXWCZTNuocQ6NzzYuj9RgF2/GeClf56JYQq7I7N5b6ZbfG4hQR
	TauNOw+riaFtAAStQC/Q11HlZvxbXAu1CfA==
X-ME-Sender: <xms:rdg4aPQdsVZbHvbtUjSno7IQ4YH8MdiIS36QuLowqpllYhFlKTgmtA>
    <xme:rdg4aAwVOYd4ydxoTOKY36gwrYB3wXVoQiOcl2DLAEbxnjFcNBOB106alrIQzxfLA
    Po75bqKjO3Uv0_cSg>
X-ME-Received: <xmr:rdg4aE0Wp6LTtwDfIFezKvsjE0g4gGjnvL0VXyVvynAzLsqqNUEnBPBOdgMM7b6ekbnDemkwUoFlBUcxMb9e9H5r3pb4giDK6Y9Ezww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvjedvjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:rdg4aPAYDfkRkaoQRXbeM8kRg4LOSbD_7wm_0saVVqzPPuGdR0Fhng>
    <xmx:rdg4aIgCfyhd7ulNNDy22TQkjt-mclTffvYe8bN7FNr0CJnOj2jYvQ>
    <xmx:rdg4aDrgoCAcIKZq-8LQfyuh_3XUbTSgc4EjswfTb3W1z2SfLrwbDA>
    <xmx:rdg4aDgmCeJ_FANXK1HpplyLWGniR05ea-RIBZqctuxruaa5_0j2qw>
    <xmx:rdg4aEn370RuAVjf0RPDurDGx4UgAGnYoXhfDpVdrtSgyq7XS6cwTqqI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 17:59:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 2/5] reflog-walk: expose read_complete_reflog
In-Reply-To: <3d0697a6-e337-4b58-98d3-304e0f17ae66@gmail.com> (Phillip Wood's
	message of "Thu, 29 May 2025 17:01:20 +0100")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-4-sandals@crustytoothpaste.net>
	<3d0697a6-e337-4b58-98d3-304e0f17ae66@gmail.com>
Date: Thu, 29 May 2025 14:59:07 -0700
Message-ID: <xmqqo6vbhydw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 22/05/2025 19:55, brian m. carlson wrote:
>> In a future commit, we'll use this function and the corresponding free
>> function to read the entire reflog.  Expose it in the header so we can
>> do so.
>
> We already have refs_for_each_reflog_entry() and
> refs_for_each_reflog_entry_reverse() for traversing the reflog entries
> so I'm a bit confused as to why we need to make the internal details
> public.

The suggestion for using this function is largely fault of mine, who
did not think of using the for-each helpers.

Looking at the function signature of for-each-reflog-ent callback

        typedef int each_reflog_ent_fn(
                        struct object_id *old_oid, struct object_id *new_oid,
                        const char *committer, timestamp_t timestamp,
                        int tz, const char *msg, void *cb_data);

I think it gives us the same piece of information, and is
preferrable.

Thanks for a dose of sanity.
