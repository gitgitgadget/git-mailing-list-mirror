Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E74153801
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891273; cv=none; b=Dx2xkYQSBJNMM9zlk4Z2j8k+FpNPLJAX3mUnKNShDZumTB4gXWJcgASHCBP//VuUw0x+e6Nl00Xx0bgxRMVIvI3otRd+2u3Mb5fpOA4k2RMn6VePfgSdFOAnpsT1XAJeDfu5krrJDOnmsrPXcytoQGS757q4yHkpDpRdARaaQI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891273; c=relaxed/simple;
	bh=LW0VztRgSmAeb1N0qK0npHG+k/CzZ5OcgC3sa4UU64I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fyH02hMOJEtB/eDO24VKgjiGe5b/Ajw8OVWFyBfHC7EfxJbxgRviWBHQoPMQ28iPtI0JXVkIPxI1biDXxnZX9N9cTzi6x0i/BsNjSF8L9BtCwgi9PFWTAd1RAcG2NkXh3BN1VAfiADJxLvToYvq9RqJVoynr47UkvYhMq2mCDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JStjn5fi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6YLbbAj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JStjn5fi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6YLbbAj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99F3A114021F;
	Thu, 13 Mar 2025 14:41:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 13 Mar 2025 14:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741891270; x=1741977670; bh=3ogmUNJx08
	GwRpMMZEV8aGRVC13aiOaEHhmH1Q5vimA=; b=JStjn5filJQ+jKd3Ve1WsI1Ywn
	HnfDVRr7x321h3gVRlOt+t1ekRi1Us4YCs6pnxRYFrXxvpZSdD32bwqeG5x8dbvw
	z8euLyIpjg/S9eAmcYgsUblvAzY2l/Sz2DSQPn/nevx1zvrwTvfHDh3SKa7yMFfy
	5vCbxQOsC5bLeRy7YcloZ8Pa7Axu3ZePNLa2nFCyiFZWNR6+VYt6V7Ef641pPXBh
	H+k1dDVtr24lRE6G7/9QzToSFTd7E3KuALQ2k+zTmQy47NGAU4C8aDyZE7ryPCeV
	2B26mx/hr2jNH2bmnE2EXqD8aB6+9hW81T8qqzqnNiFLoqqAHYjbI0ieLLbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741891270; x=1741977670; bh=3ogmUNJx08GwRpMMZEV8aGRVC13aiOaEHhm
	H1Q5vimA=; b=Z6YLbbAj2wv6gzP66TOLoemg+qigIT59mG/D8v0eVxP8PqxY0EE
	v+YXgHFNHrqBETxeQGb2vI0gSLViYTyyY3CKYJi/1XWgEKvnAByw3XFn9190bb8L
	0N7vrON6L2LF8lyLgskn+d/nHOBkjvRCOEuTS+OvFQGgCcmG9LrGu10AgLd4Ro0q
	Og5iiaHqxBdwI5QJx5rlzHpz93tbbWqD4IFlOxNXbmxhDZYxQfgwvqpEK4WlVCpp
	DULDYJjfHCK/7CgO4WaDHCraURdZ3rT0IKfRqkGjKweQHawEdcuWM47q1bkTqFQ3
	1a5RaaL9/+X9ThGkVxgBvNgG7ISbJWqUlmQ==
X-ME-Sender: <xms:xibTZ7qeecPuaCPMvC7k9hLMq6HvWsYxlaUJEUbccPDpGOIV-jjvgg>
    <xme:xibTZ1rN0WZKK9XEnsRKl3_pbwRHRucFCJUF8lQzcjtotnfnXQoNBLV2aK94dxI3d
    OYv4V-SnwfjnwoEZw>
X-ME-Received: <xmr:xibTZ4OjK5jPy_unlqfy_py6s9L-3PClDFJfjl11Bbsk9WGqWRdjXrVcHE1-5d8sTx2UYmWRCw74diL2-wzCJgo7ZfsgB5Ke-aAwSNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xibTZ-68I5sB1XtHR32Z6o3Cmi19TapBQDNzfIID6CM_5fBzOLNXFA>
    <xmx:xibTZ64JofUS8lE5vWGogfoOU2W6mWUHBgspMI2VG4Mp_IMYeStHsA>
    <xmx:xibTZ2gPkpWi_Lb5w06goo24h19XXtDhpv_EDCrs9w9JQKI-q1eNoA>
    <xmx:xibTZ86Qhb9BCiNKTnazKvDa9-CkuPM2N0ehVAHQ2qxWnE59EFc6Qg>
    <xmx:xibTZ8T6_xjjBLItoWST2bHJQZUfzPeelgwevpu0WUFrBCvL3VwTurpt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 14:41:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v5] builtin/pack-objects.c: freshen objects from
 existing cruft packs
In-Reply-To: <1563552bbda0bc910c9f41b0fabc3225c4d778fc.1741889018.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 13 Mar 2025 14:09:47 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<1563552bbda0bc910c9f41b0fabc3225c4d778fc.1741889018.git.me@ttaylorr.com>
Date: Thu, 13 Mar 2025 11:41:09 -0700
Message-ID: <xmqq8qp8ojsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Once an object is written into a cruft pack, we can only freshen it by
> writing a new loose or packed copy of that object with a more recent
> mtime.
>
> Prior to 61568efa95 (builtin/pack-objects.c: support `--max-pack-size`
> with `--cruft`, 2023-08-28), we typically had at most one cruft pack in
> a repository at any given time. So freshening unreachable objects was
> straightforward when already rewriting the cruft pack (and its *.mtimes
> file).
>
> But 61568efa95 changes things: 'pack-objects' now supports writing
> multiple cruft packs when invoked with `--cruft` and the
> `--max-pack-size` flag. Cruft packs are rewritten until they reach some
> size threshold, at which point they are considered "frozen", and will
> only be modified in a pruning GC, or if the threshold itself is
> adjusted.
>
> Prior to this patch, however, this process breaks down when we attempt
> to freshen an object packed in an earlier cruft pack, and that cruft
> pack is larger than the threshold and thus will survive the repack.
>
> When this is the case, it is impossible to freshen objects in cruft
> pack(s) when those cruft packs are larger than the threshold. This is
> because we would avoid writing them in the new cruft pack entirely, for
> a couple of reasons.
>
>  1. When enumerating packed objects via 'add_objects_in_unpacked_packs()'
>     we pass the SKIP_IN_CORE_KEPT_PACKS, which is used to avoid looping
>     over the packs we're going to retain (which are marked as kept
>     in-core by 'read_cruft_objects()').
>
>     This means that we will avoid enumerating additional packed copies
>     of objects found in any cruft packs which are larger than the given
>     size threshold. Thus there is no opportunity to call
>     'create_object_entry()' whatsoever.
>
>  2. We likewise will discard the loose copy (if one exists) of any
>     unreachable object packed in a cruft pack that is larger than the
>     threshold. Here our call path is 'add_unreachable_loose_objects()',
>     which uses the 'add_loose_object()' callback.
>
>     That function will eventually land us in 'want_object_in_pack()'
>     (via 'add_cruft_object_entry()'), and we'll discard the object as it
>     appears in one of the packs which we marked as kept in-core.
>
> This means in effect that it is impossible to freshen an unreachable
> object once it appears in a cruft pack larger than the given threshold.
>
> Instead, we should pack an additional copy of an unreachable object we
> want to freshen even if it appears in a cruft pack, provided that the
> cruft copy has an mtime which is before the mtime of the copy we are
> trying to pack/freshen. This is sub-optimal in the sense that it
> requires keeping an additional copy of unreachable objects upon
> freshening, but we don't have a better alternative without the ability
> to make in-place modifications to existing *.mtimes files.
>
> In order to implement this, we have to adjust the behavior of
> 'want_found_object()'. When 'pack-objects' is told that we're *not*
> going to retain any cruft packs (i.e. the set of packs marked as kept
> in-core does not contain a cruft pack), the behavior is unchanged.
>
> But when there *is* at least one cruft pack that we're holding onto, it
> is no longer sufficient to reject a copy of an object found in that
> cruft pack for that reason alone. In this case, we only want to reject a
> candidate object when copies of that object either:
>
>  - exists in a non-cruft pack that we are retaining, regardless of that
>    pack's mtime, or
>
>  - exists in a cruft pack with an mtime at least as recent as the copy
>    we are debating whether or not to pack, in which case freshening
>    would be redundant.
>
> To do this, keep track of whether or not we have any cruft packs in our
> in-core kept list with a new 'ignore_packed_keep_in_core_has_cruft'
> flag. When we end up in this new special case, we replace a call to
> 'has_object_kept_pack()' to 'want_cruft_object_mtime()', and only reject
> objects when we have a copy in an existing cruft pack with at least as
> recent an mtime as our candidate (in which case "freshening" would be
> redundant).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
>  packfile.c              |   3 +-
>  packfile.h              |   2 +
>  t/t7704-repack-cruft.sh |  66 ++++++++++++++++++++++
>  4 files changed, 171 insertions(+), 18 deletions(-)

Thanks.  Will queue.
