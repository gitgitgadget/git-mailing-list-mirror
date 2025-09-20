Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FB246763
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758388586; cv=none; b=Tb59qNFKk3b0ExrL69++xhtpRrqTOGR13/HEwygZos8+cvqyTS8tvAzSbZmPMHQAY7fMWw+xTsKXl3zDZ1FuTYUXxjYeLM0JdSTFskxuY7OQM1gNQ8KX2z4ZFMl6KAKTZwBXIdWhICOurDV4mEMGNuqfhrvV0Pgs0a6WU4qCZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758388586; c=relaxed/simple;
	bh=/EW8i1MZjrnNZTEgpa5O2D+xPJceOPD+L8Xh9lJv6oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tmIgasN8/u0Ov+FJ8apIU37a+IhFO3mKyItAg/3db7ngn/oPh9lwudo6+g9HSERw08v0HIWkpB8dOjbeV13jxnMYEGximf5JE4Hp2q+GK9dzvDY6VNeYB+PweXPKkKA+upS4kO1zOSfDn5qneOTrddvsmqoLWiUcCi5Y0jizNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y8U+AIBO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiOnHspv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8U+AIBO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiOnHspv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8889FEC000B;
	Sat, 20 Sep 2025 13:16:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 20 Sep 2025 13:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758388583; x=1758474983; bh=sAaJa9N5e4
	b07i6/nL5t4T8TGWUvaajDsWDLQh9d9gA=; b=Y8U+AIBOlINvlagI0Lh5L1XOMU
	M+brbcNvw1kN6Hw5NaXBZReSjhsiRJWznE/Sf5q2PBxEqcbc6j2EYRQ3ahmx5VqS
	Wbr2opnWtgEYqcn91350CDXIbgm35PgboMm71SFjk/daXEHsugeYZM3tb3RjReBV
	kt20R0LW1AlGmAsma2q60oNMbyrHLr7qC+AJOxcxgaHnI/Thj2j9RsI6OQSMEnyl
	aKofOibau9/csc1/N9EsCdMjkSyBgRiAzI38WthzmSOfFRgZ9Rae5BrzB+FGx2lF
	QatjlxpDT0n9X0fo617F9PM02LJjD0649bwtdvmlpAINTp2Rv6Ts2LgUXHNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758388583; x=1758474983; bh=sAaJa9N5e4b07i6/nL5t4T8TGWUvaajDsWD
	LQh9d9gA=; b=hiOnHspvshJPrFvV6W8D9uXK47I5uzDtLSledZbNKTZpI+E+Hlb
	9WsMpefRoDruUA3CiW3X7XR2pb/NdjOXkDtKgI/Qpo1RLOmKqPxUeDIlaIM025V2
	h0qICk9dl8ZrsPYFRUshZn7TdLFvwxkxl84s0ZIIrKn9MA5RFR7mCEpdkt15fB4O
	LdKkRqfmFAIawrHgNyb230UxXYHZn8tPij6ox1oh8A8xU52paG5Jk0MJMYGmq+3u
	rVwgWocUKiIs7aMOeeQNl+p4AuT3bLIVaJh6QltcsynLT/qmvx89a/GeDYdFqpHD
	2iV4+LwX0abJpZqubNtY1MGuMpyS6fSDT6A==
X-ME-Sender: <xms:Z-HOaIt4thDas0T-xXyKFrXisF5G-fNy_0H0g95zDX6Ro5QH9qOtJQ>
    <xme:Z-HOaDARZqNTq5YaXOZdTD-jzmuCSWtI1AjeN1XWS7h-DnjbJyOZfJeXkFxjo2TKm
    N7Ky0bBRmnUdk0rFQ>
X-ME-Received: <xmr:Z-HOaKPf1UyJ6g4FMyfF8M_j0K4uBSJTSJyWHvRNlJf_Alru3sXvKodhC3GDOzwhoMc7Fi1HXHK-XrCvu0q9TiGO-13SIBHjBZLT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Z-HOaMx-9ak1reX058xUm55kDvDhEc4-0iV3zemrAthRZV4VwAoTrg>
    <xmx:Z-HOaKWkzwvDecPHcPKCOhLflAMS1sSQ1AUC4SA0HFz08Y913T1NPg>
    <xmx:Z-HOaOOzS-cIxIDe2vt4dsxOrhiseMqk2ip7Nj9D8Nimvm21t9y1hg>
    <xmx:Z-HOaMCEhrxzfRYhoC0VALk1mTpCA3BV1bo7-GF1YzpNQ11R7b9H3g>
    <xmx:Z-HOaAutM8Wg3cPT-UqVmHkoie768ZnTfxyU8OIt59Npg1eL6UWTzsqD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 13:16:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in
 xprepare
In-Reply-To: <784cffcef564b31a32c401b35f33610b85126f7b.1758294992.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Fri, 19 Sep 2025
	15:16:23 +0000")
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<784cffcef564b31a32c401b35f33610b85126f7b.1758294992.git.gitgitgadget@gmail.com>
Date: Sat, 20 Sep 2025 10:16:21 -0700
Message-ID: <xmqqh5wxxcwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Move xdl_prepare_env() later in the file to avoid the need
> for static forward declarations.
>
> Best-viewed-with: --color-moved

Two comments.

 - This is a bit unusual to see in the trailer.

 - It turned out that it was a very effective way to spot a typo for
   me.  You should try it yourself before you send out your patches
   ;-).

> -int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> -		    xdfenv_t *xe) {
> -	long enl1, enl2, sample;
> -	xdlclassifier_t cf;
> -
> -	memset(&cf, 0, sizeof(cf));
> ...
> -		xdl_free_ctx(&xe->xdf1);
> -		xdl_free_classifier(&cf);
> -		return -1;
> -	}

The "--color-moved" painted the line above, with a single closing
brace, as removed, which stood out.  It turns out that ...

> @@ -460,3 +394,53 @@ static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2
>  
>  	return 0;
>  }
> +
> +int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> +		    xdfenv_t *xe) {
> +	long enl1, enl2, sample;
> +	xdlclassifier_t cf;
> +
> +	memset(&cf, 0, sizeof(cf));
> ...
> +		xdl_free_ctx(&xe->xdf2);
> +		xdl_free_ctx(&xe->xdf1);
> +		xdl_free_classifier(&cf);
> +		return -1;
> +	    }

... the corresponding line in the postimage was shown as newly
added.  That was because it was indented incorrectly.

> +	xdl_free_classifier(&cf);
> +
> +	return 0;
> +}

If I do not spot any other issues in the series, I may just "rebase
-i" to correct this single line to reduce the risk of mistakes,
instead of asking you to send an update.  We'll see.

The change is sensible, and the proposed log message does a good
job, too.

Thanks.
