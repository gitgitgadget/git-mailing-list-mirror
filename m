Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E93E6DD2
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357164; cv=none; b=bYdPGMw4Hj71xjDgnM+D1GBhhy+J3l67Dcn1BSYpttGxlZkHTXR48Q6jVgDRZlfCafXEiiB3zWtItue3hv2jma19VdRDd43JvK9Efyv0SdLgYCxG0JkheExlXuqPJmroy6itycoa21sButeqt4MVE3lI4cEdfWl6KwKQzKSKCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357164; c=relaxed/simple;
	bh=W4tyUi4afVUvKuEB2tI11GuVu0/IJTuPesU1pTnDLCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fBRzhwgAxvia0qCtqaSX30p6pcT7pbPdhG+DBNJT58y9eO3fGPy4KzPrZmlhHIw5HnAYYbHLg9SscZNS+W8/YxDzMgpCmQpGfcbssdz8NePL23/QADUatk6fzYpbEjVL5WOg+uq+9i8ZZMRqsY6a/CVQueue8nYonJJ4QQzK0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WqKTfL0Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjMT9jEg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WqKTfL0Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjMT9jEg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 388EE1400491;
	Wed, 29 Jul 2026 16:32:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 16:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785357161; x=1785443561; bh=/u8XzgF5Zl
	lSrUN4RdAc1c10WFGNGQBA+1qNIWkugtI=; b=WqKTfL0QFvdHyy5A2uX0yHAHRT
	MUjiGwopkEoHzaiEewEBATe+fPLeVCekuqsxbidQA134XpgfsEd28n4qSka10DJw
	i7vlNEpFeJRzXF4TVc0gMsJKBNHhtemdS18pTgl7b0x02eirYkO8WXR+9ecP5Ho4
	Csers9ERZrtvHAjtxXaAjPwe8V2hKNcz84V8Uk18oN0NMA/hu6/kxJPFXuOlYr5I
	ompvqe36zBubbrG8ncey+jI9hQ57VChaOd5vDkmUZCD3B9E/dBX/LJYbr8CoQCCV
	syIRw2oC4AopFL0bFeDVfJUEz86kPw+ZnGjbrejOQtak0Kelk857Mlp9KjCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785357161; x=1785443561; bh=/u8XzgF5ZllSrUN4RdAc1c10WFGNGQBA+1q
	NIWkugtI=; b=PjMT9jEgTGzm7feEsD1+Ou3xm0E2u1fy78tca5GT9H85zFTFhQb
	WUeSbjqqIqhZbOm+pJ24Hf5vn6BAPrdQyGfEg2/oGw8VDRZXuwSMmuQtKdv8sg0f
	xTi2TF3/tptUlA4iHjEy0RyiVM2L9swawSC2ftATB+roUJZYkiqdQzxn5v0vX9hO
	y9/ctjydVUlaAbZHKdEL7jzj/z28WPeoO4tfMWSkcZYnBL/GBIeJ6Ljh/ab3XH+w
	UbLlDCwERusWQok3KV1H7npGpIMVL1iPkemx+DL097j+NosRFGXKr5rrGQ4kg1GR
	7sBvbkJY4Zcxm4htIGl66Eri+D197NpI+wQ==
X-ME-Sender: <xms:aGNqai5AAbq4QEZZMcr87jM3gAC1zinjyeG3b6e1W5FdYrGFBNkPOg>
    <xme:aGNqaueHTZOxK4Ukklw3D6AJcg1B-lm-tu5YgR2-DNDIo2Of4NVg6FvpgxVEjyOyt
    grTWfPV7Gv10DygE046gZRWGJuyrDaaLER3YNToCZAzYfV3FVE6wg>
X-ME-Received: <xmr:aGNqalE8LoLtv1D3poOFaawL1hcEMUWJuIKHqmpYiM0YILQnvdnJr5nuje451tkPLszcZT6KpZvk30qIRBLxjnu9krGx_2XF_w>
X-ME-Proxy-Cause: dmFkZTGqpyABh605baYe1B4ZVnkNySTP2S/UAsT4F4J5I8AFJ+CxXyV/c7+MUBcvEsKtcS
    /Gh3gH6MmSx25xDZtFDs2oazuZNIezsDB6PhBwTSurjS/61pFhNQCf20pLGvn5TJXg+s+D
    DLTKj/wAT0UKLJHyk3MxkgbWNg75vYZti+2Xt+gd5nlxSK5V5ii7O7bwFRSfkozkumkm10
    ZoW3GgXlhrTITC/8YAWfw9m1PiCeKo3xTn4KSumto1LEe2Gg/bRIA4TyQdgj1/FdsfQHuU
    NFtnfcT6dEFH7GKlmOCNuAI1382DxIKt8JH90kcrXgENWGCiBgb9NyOaeqU+7r8A6AryIg
    iI5Kefa1QForEPm3XcN88U3K6RmY5ctN2+Ns0XJ6j85EfN9G4Xl5qhnqN2x+rPZDR9C4yH
    iQpJtMbnYgsSluj3wtagfd3svhPuzWTgDMfOfleendpukpHmkvWLKp4gHP+p7P8YkIxzUu
    1QSgDIdF3Pz9WU7jMd3GMcm3NqhhhIUdgrovZKluxPseEMpRcGr+kHnO1j8bNMPvsAV4ew
    ehrNvQopg3vNgVMr163yfCrA62UditA6pAyjr3FLWO+K5TZZsRTOrj+SIDq3WRIRpEDNY+
    snoEITZr8ssIB9I3vVs12W9EfE7/LqMcxVMGfWDjTZBoznaar3UxT+nCApUw
X-ME-Proxy: <xmx:aGNqavQpGd5EEY44IeXC9Hbwb0zvORFq0cbj0KQYLvrJ7IAgBxNRZA>
    <xmx:aWNqarZE2PJiyvu8K8UQjG-IhniUJeG-jGeD8Y_Flu0WK_uEUrTSTA>
    <xmx:aWNqaq17OvE37wF4bKh2udn6Vj6LBHBP9RvkBNonInKoc9SnwlIWtA>
    <xmx:aWNqauoShxP64Wna8o-Ka85zK9KVB60FFBcJM2tqM_lLyRzwLdc2sA>
    <xmx:aWNqalmHw8mSmK9cyGs_FA7-UJ82XD13ugSttYfPcLGY26bz2EpOfwlt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 16:32:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: friel@openai.com,  git@vger.kernel.org,  peff@peff.net,
  stolee@gmail.com,  me@ttaylorr.com,  ps@pks.im,
  jonathantanmy@fastmail.com
Subject: Re: [RFC PATCH] index-pack: optionally allow duplicate objects
In-Reply-To: <ampR7FkErK3CQPyC@com-79390> (Taylor Blau's message of "Wed, 29
	Jul 2026 14:18:04 -0500")
References: <20260728042550.91133-2-friel@openai.com>
	<xmqqik5ybmi9.fsf@gitster.g> <ampR7FkErK3CQPyC@com-79390>
Date: Wed, 29 Jul 2026 13:32:39 -0700
Message-ID: <xmqqtspho7tk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> If we can find useful ways to combine the ideas above with Git's in-tree
> implementation of upload-pack, one could imagine that Git itself may
> eventually send packs containing duplicate copies of some object(s)
> behind a capability. In other words, for clients that know how to
> process such a pack, the server may wish to ask the client to do just
> that in the name of saving some CPU cycles necessary to generate a pack
> that doesn't have any duplicate objects.

I can live with such an extension as long as we teach the receiving
end to deduplicate the extra copy.  Leaving packs with duplicate
objects on disk is a completely different story, as it will become a
source of spreading such broken packs elsewhere, though.

> But I would note that having packs containing duplicate objects is not a
> new repository state for Git. Non-strict `index-pack` accepts duplicate
> entries today, and shallow and filtered clones can store the same pack.

The same as what???

> My series in 'tb/pack-with-duplicates' attempts to fix the known-broken
> assumptions in reverse indexes, delta resolution, MIDX verification, and
> bitmap reuse because those packs can already exist.
>
> If duplicate entries are to be forbidden entirely in order for a pack to
> be considered valid, then I think we should reject them in every
> `index-pack` mode, including the shallow and filtered clone paths, and
> diagnose existing packs in `fsck`.

Yup, I think that would be a sensible longer-term direction.  We may
need a bit more tool support to "fix" by reindexing at the receiving
end, though.  As you say, "cancatenate two packs, damn the duplicates"
may be a cheap way for server side to give union of objects contained
in these two packs, but doing so without even measuring how much they
are duplicating cannot go on forever unchecked.  Somebody needs to
remove these duplicates, and the time the downloader indexes the
incoming pack would be the best place to do so.  It needs to read
each and every object in the pack stream to make the .idx file out
of the stream anyway.
