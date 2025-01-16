Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5E22D4EB
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054774; cv=none; b=eaTRHexP3PdR/ktPc6BDF2qPKihgOtMAQl1AReysKaW5MMT9G/vG0I93+x1aE15XbK9Jgm80I6529W0Ptl0uM64hbvyL5liowtIPCoijiq12RnlQOA3mxB9j/YP16F6cQ9Pwg2Qt/ZGaQpno0lJlbcwO+xpV6EmqYLfBg7GABDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054774; c=relaxed/simple;
	bh=9GS6sCp7L4K5B15+laWRpC0s9YbeGIpo0q8I29zZgFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hMBHx0Fs+rUU7ryN+naQLJ7P1/J9AmGR2O3DWWwKDYLoccKht0LualUwUzh10iwWLFRvRxqzX8tmys7RAn55uIAbkralKeRiiHTsTc7tQ+RcBNpCYqXh1vcYzs1sDFQvEvmNDf8/M7RD9I9UScaUueeQYa4+ncO364ASdjaj2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QDV8qA/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCJSDk4T; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QDV8qA/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCJSDk4T"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88C2D1140145;
	Thu, 16 Jan 2025 14:12:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jan 2025 14:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737054771; x=1737141171; bh=WWYf5fUJC4
	VMVh3IdsQeKxr8nXGl4VJ2TLVIlh2DPq0=; b=QDV8qA/OQs442CQUytZikBKKtf
	TdLd25g4gUSZ3vrVfFyFMtbSVfvvU92BcpT7JB1Q2B4dtq2rGSHmkzl+HuxZ7xE3
	6VZUyhQshngkitZKtqUTEFhEIl94Jv0hyenh7HttX5h81uwNAhDE1/iBbNqNPQaX
	cjRhXs0zl2xG140LlBI6Id/h0nCvVgd2M0zpNOiOyZ1sBJkJPAkyaeUeBY3XsPSZ
	ihPx6BxEkX8b6REFGcGHVIGKAqAAVn7XPQugfIfPaOYZAksEtPVr2eIKI0DVNcXU
	RxYA60e9yiiquhy9bYerKnPfAPwZNWTj1JEspYM/JflLU8nYdz0+50SHP7cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737054771; x=1737141171; bh=WWYf5fUJC4VMVh3IdsQeKxr8nXGl4VJ2TLV
	Ilh2DPq0=; b=iCJSDk4TT+/qQJtglYWATjCJ1ccaHdRh5Hny1Weh6vfyvALaBQT
	SmCKQRrPe5ccbnIHzbsn0fbfhkil0CquZpDU/7xi5bLmS54afguMbas+qqjTLbI0
	foT8TMDjk5VW6mPCZNyHJUgzY5ul6gs0oUljGMKvP2EIj46dMx05c9C8ZXAiUaWP
	dYcE1SgMwv5bCbbjeE8Kz5aZpw3uz8snaFf3bu1LjfgUZ6FJ7Gn3ou1jfnQazA7M
	zisWjSPMPZ119LEWkHuxY6F242IIkvqZ+JF+pHXwSmVQpY+HwxK+YWMjy4BB9uUw
	RQHVewr2i3LLt3yF2pvxHgOwyr31yvV53gg==
X-ME-Sender: <xms:M1qJZ_WsSTmQ5tWCaJJpCin4QSfwcv2KN20NvOEG6491d4PiV21Opw>
    <xme:M1qJZ3nelMWT45PB0lCFVKO3XA0YoHb9zOYd9HYF8O4pGYMJHV7ZPqeaP--iTcvpt
    LB-GTBey9Hb-QEOjw>
X-ME-Received: <xmr:M1qJZ7bHL93e017fQdOrIFNHoDvb3syvnyxK8B9_ImxI7T6kCQT9hNBDgZUGImvaRPnr-ptxPj0k5N4uvbFb21zFE9FM1hq6KJYd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvnhhulhhlod
    hkrghrthhhihhkrddukeekrdhgmhgrihhlrdgtohhmsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:M1qJZ6X4cE_rV14AJcgz8pM6BTK9oF3ilx7qLEzWlSO5mjHJzXK2aQ>
    <xmx:M1qJZ5ng3dwrPWwegdSExJtIvSMRUNBK3TNb2mC4dVr1Lzm8CYFVXA>
    <xmx:M1qJZ3ezNJ4peaAU6L38KKDa4VkFHwQ6Q-S8qqqRJ-eHIOVJrK9eXQ>
    <xmx:M1qJZzHl_suywmBvbrQGmgURzkX8XSRzjqckITy8aI06m-oYKGDwmw>
    <xmx:M1qJZyCJO4BwXfnunk2qc3ydHmbSkbg8QX-Du7L1UotHtYmIUnTATW7F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 14:12:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/5] pack-write: pass hash_algo to `write_idx_file()`
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-3-a2f4c8e1c4c3@gmail.com>
	(Karthik Nayak via's message of "Thu, 16 Jan 2025 12:35:15 +0100")
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
	<20250116-kn-the-repo-cleanup-v1-3-a2f4c8e1c4c3@gmail.com>
Date: Thu, 16 Jan 2025 11:12:49 -0800
Message-ID: <xmqqjzaur2ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak via B4 Relay
<devnull+karthik.188.gmail.com@kernel.org> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The `write_idx_file()` function uses the global `the_hash_algo` variable
> to access the repository's hash function. To avoid global variable
> usage, pass the hash function from the layers above.
>
> Altough the layers above could have access to the hash function
> internally, simply pass in `the_hash_algo`. This avoids any
> compatibility issues and bubbles up global variable usage to upper
> layers which can be eventually resolved.
> ...
> -void stage_tmp_packfiles(struct strbuf *name_buffer,
> +void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
> +			 struct strbuf *name_buffer,
>  			 const char *pack_tmp_name,
>  			 struct pack_idx_entry **written_list,
>  			 uint32_t nr_written,
> @@ -561,8 +563,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
>  	if (adjust_shared_perm(pack_tmp_name))
>  		die_errno("unable to make temporary pack file readable");
>  
> -	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
> -					       pack_idx_opts, hash);
> +	*idx_tmp_name = (char *)write_idx_file(hash_algo, NULL, written_list,
> +					       nr_written, pack_idx_opts, hash);

The proposed log message should mention the reason why this
stage_tmp_packfiles() function needs to be singled out among many
other direct callers of write_idx_file() function.  

In other words, ...

> @@ -798,8 +798,8 @@ static const char *create_index(void)
>  	if (c != last)
>  		die("internal consistency error creating the index");
>  
> -	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
> -				 pack_data->hash);
> +	tmpfile = write_idx_file(the_hash_algo, NULL, idx, object_count,
> +				 &pack_idx_opts, pack_data->hash);
>  	free(idx);
>  	return tmpfile;
>  }

... this hunk could have made create_index() to take a git_hash_algo
object and pass it down to write_idx_file(), while changing all the
callers of create_index() pass the_hash_algo, but we did not do so.

But stage_tmp_packfiles() got that treatment.  Please tell your
readers in the proposed log message what makes it special.

Thanks.

