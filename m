Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3E35963
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763741; cv=none; b=JQJylb/g3AEAqjxWXGCxGGKLIlexCayXaf0HmwJkXwy46K9nxsXnoOfsp1WdauJvLbnoH/g/dw6FK4Vfl3qxLHI0F+tJHkxUTYPR+ndXn+wkigZ+XlPgaWRpQt681rqB2KwFbGzGjYgpE8caG6b/CZ6/UtJVvTeKY4TTY9HDCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763741; c=relaxed/simple;
	bh=wQzzZ8bVHzB+ldOA74C0jyxgcSib3ynJu9JNkjzM/w0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fniX5ZdkVMRo1roO3rXSvW9w92TE65fRAAmD6PKxcmrMfVdZJT9Kazizr0QXsLeGzVX7XWRGBr36A9MwyIvEF8onO84uLo1KFbfzGydK/pECN3uMYWa/va9l445eSLIUwc7mfXkFfV68khgeWArqScDbFipOC7P0y/AVee0fBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kZMzwLIr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FYEekKMz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kZMzwLIr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYEekKMz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DDFFD1D001C3;
	Thu, 17 Jul 2025 10:48:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 17 Jul 2025 10:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752763737; x=1752850137; bh=xajx138VXr
	0t4TC+yTVTN2ETEQvUsaV54ql0XJlhCoE=; b=kZMzwLIrdDR1cENzJFrsub1Xbx
	Bz8YDeJmf+T8To99ZaxdUnhhuTUHN9Md2esWUZ8oAUc/7OU4E0DlUyKlcZVbwnWp
	cJxjyxctparnIetluqVjWmxU9JeWkmzG4BmYIfrRP7hLvL0Rw1jbyAcz0Cedeqze
	/GOLdCfPBAv82aYoCVHdofSGnwMW1wAGrdMeWcDHnL3M4W/2O/QzXuk6AF6k2Dxt
	mjyJvCyIkmiXm7+t1T9vy7LZtsECmxiv1IV2P4dpUP4ZVTRPj7KtQSSMrVa9FVZQ
	Vu3U2/VuC0lSX61v01B8eVhTXXzBw6+I0Z7B9ni98+6uA9tjooCRqS3aThEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752763737; x=1752850137; bh=xajx138VXr0t4TC+yTVTN2ETEQvUsaV54ql
	0XJlhCoE=; b=FYEekKMz7snrWrJyDCowhWFNkK0SseDQWL5w+AcSxo54hfP+/3D
	dMDVhZ0jN3Iwn2yK7dsukyyVov+Cp5QxJ5fySwRM8Ia+pI8jYAcGvyr2sZNvBsC3
	pq8YlwYUwIr+F4ge+q7Yj5hlHkm98w/SWZuw1btsfgqdfGpxxAjyBRg/M5QGnDm5
	AoOHfYz7VhLD6SYSEUSwhVtCop5vOI2SOILX0WU6C0xSX8OneitwFKs9UkQbiETK
	TJIqq1T4R0ohwb3DhkJ4NrXETtbn6/Z3W5BBApWH+Nx6wYaL9wIT/kL4SHSs/QkH
	UCIqMSNMskf1er/3F2jmtvSf76YUm7CFNXw==
X-ME-Sender: <xms:WQ15aL7kZh25ncXRCBW3W1uJcya8rDeOIysCCh8kYpk4WFeqnJv99A>
    <xme:WQ15aBmHKShHc-MeqezCy66VVZwENSFgesbRtRAJW-Gfwuut44rQ390tHMEOyGk-9
    w21VY055UaoE83pKw>
X-ME-Received: <xmr:WQ15aArQz-lqsGZUX4yVbIk9M11iHou27u95Rll7qBSjKWMHPnIDz-CqC3G7dza15iAppF2OxYiJzZpYrGR538XnfsgWzjjRI4LmJGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WQ15aAvw6QngC3vs2ou0bBCBcWkwL3JbQwuQ2TEUX8-y8U6jnDTc0g>
    <xmx:WQ15aFFyQ66cMUsYxr-V2uIb8e-LL0yAHNpyo9E5kPS7-LuJ9cy_TQ>
    <xmx:WQ15aJZtgfodk7lOvE1tdspgSR5qyTaRKiFGT4rEhoZAy_nz3puw_A>
    <xmx:WQ15aNUqZZ-J88U-94B-SKc7ifcwRjrsRnDGm147RdieN3cqscW-sA>
    <xmx:WQ15aKga-mHIsMmiZ6lBEMA9cF1F0Z4yJyEdCy03LeUcczmaDHpxhZRp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 10:48:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  schwab@linux-m68k.org,
  phillip.wood123@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 2/5] ref-cache: remove unused function
 'find_ref_entry()'
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-2-852d5a2f56e1@gmail.com>
	(Karthik Nayak's message of "Tue, 15 Jul 2025 13:28:27 +0200")
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
	<20250715-306-git-for-each-ref-pagination-v5-2-852d5a2f56e1@gmail.com>
Date: Thu, 17 Jul 2025 07:48:55 -0700
Message-ID: <xmqqtt3a7u08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'find_ref_entry' function is no longer used, so remove it.

If my spelunking is correct, ba1c052f (ref_store: implement
`refs_peel_ref()` generically, 2017-09-25) is the commit that
removed the last caller of it.  Which may be worth noting here.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/ref-cache.c | 14 --------------
>  refs/ref-cache.h |  7 -------
>  2 files changed, 21 deletions(-)
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index c1f1bab1d5..8aaffa8c6b 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -194,20 +194,6 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
>  	return dir;
>  }
>  
> -struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
> -{
> -	int entry_index;
> -	struct ref_entry *entry;
> -	dir = find_containing_dir(dir, refname);
> -	if (!dir)
> -		return NULL;
> -	entry_index = search_ref_dir(dir, refname, strlen(refname));
> -	if (entry_index == -1)
> -		return NULL;
> -	entry = dir->entries[entry_index];
> -	return (entry->flag & REF_DIR) ? NULL : entry;
> -}
> -
>  /*
>   * Emit a warning and return true iff ref1 and ref2 have the same name
>   * and the same oid. Die if they have the same name but different
> diff --git a/refs/ref-cache.h b/refs/ref-cache.h
> index 5f04e518c3..f635d2d824 100644
> --- a/refs/ref-cache.h
> +++ b/refs/ref-cache.h
> @@ -201,13 +201,6 @@ void free_ref_cache(struct ref_cache *cache);
>   */
>  void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
>  
> -/*
> - * Find the value entry with the given name in dir, sorting ref_dirs
> - * and recursing into subdirectories as necessary.  If the name is not
> - * found or it corresponds to a directory entry, return NULL.
> - */
> -struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname);
> -
>  /*
>   * Start iterating over references in `cache`. If `prefix` is
>   * specified, only include references whose names start with that
