Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2390124C06A
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754022; cv=none; b=NnhsUDH98KQbxrUMrNzP5IHF3XmJ5PAEw+/jHuMEZP6pi0+TSkCALphkPp1QKt1lXvxQv6CPTS6M1CWSyEHXRzUz24bVyEzwpFYsTvLPhpcV86bFuoQHJjzxq7Jlrex0XtnAIgBeudV0DRsHopk5bYNZxoKghYip9B/m/t16LfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754022; c=relaxed/simple;
	bh=3sg3OfJlTsZuwRjLLfjq1WDmxCXMy/2H99n1qEqQoPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zyrttv63C2s8u5waJfh0e9ek1pTXDtGsXLY0UIfeTeB4AzmFzfanTf2YiVVcp5XFHto5SM3rbkmq6mgkxxUH5NSrqmQMv2yjNsapBCQrV3jGYaNaRPr2bqC5HFY/lT7M9dEG2wNRDhx/5VtM1PwtzBSX6jOTnLK+pJ78fqA858E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aDQDhCm3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aqe3mpbj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aDQDhCm3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aqe3mpbj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 38ED9138042D;
	Tue, 20 May 2025 11:13:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 20 May 2025 11:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747754018; x=1747840418; bh=ohHvA6R3/V
	+YkE+Boxza9+SM03EEO4WL3XCkqGVskcY=; b=aDQDhCm3/F++3+yPjTkI2cF2HQ
	qLjBUPgUNe8YD7xyR2TD9seTRV2tObgdHWe6P8ubq8zF3U4J+G6jfLO0XUm7dDUH
	rbz2j4lcxrle/cUois0dyCO0JSzOB3TSs5HHp/kqhWQ8+3A7WIS1Bq0BlifDMKCv
	rczMko72rT4T5JGgKTiQYdQOQGzVvDocJGPVz+5cTZsBYF/t3DuMDTqui9c8T4en
	DcexwRLRckC+F8N7brJIHBKgWuuLtpU77dAw3sZmKpjj8Xb7SeyKuMpSw09Q3uuo
	pDN0HLHy64wLVjUHMT709rowZ7XfgxG95M5p9dq9WX3HkD8KcqBgHORE86DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747754018; x=1747840418; bh=ohHvA6R3/V+YkE+Boxza9+SM03EEO4WL3XC
	kqGVskcY=; b=Aqe3mpbjDaLuGtCuKtg8Xar1oS6PTWe510wNJN/DyfcgWOakWqg
	kNFl0ZMup4R4XrXu/fHTTLJm4lEDfPk0dZ7zGWYic8i9oUAc1xRpe5v1TeKHDXb6
	bGa3jMdRJPozwpbzE+Vug4vpEEpfnP5Cl3Gq9sRNppNkAEpAAKzJFo0bU2zSkU2M
	HwI8Jwsy2BQCck8ml6wqZmZE5ywRySz09d8Zg6pQ8u55OYKSmxo7svXYQT/OcL45
	7F1Z5FTuMre6hDu/FdTs+I5O6j5/+629ud4Zvm7fR/OH9nM2m+xTx4RJXgaoJ9TV
	jD86P67hJs4n2vj2vnifzjn+vCNVr/8tWKQ==
X-ME-Sender: <xms:IZwsaOceDAcvj2LKTSwKGL7WieMuemr6Z9pVyfEJX75LSLbMzYovSQ>
    <xme:IZwsaIPO1vpPdX3pmHtV-VXgOgbf7GBApRCR7yODUVEQ_8coXh_lxB_boqF5RhA-e
    T3BPB9amU2126brmg>
X-ME-Received: <xmr:IZwsaPj3I72QzCOrIDR06Rzqxv9iwBekYbKfw3q-iACBCac8pPF1mjkASB1m3TQ6roR2AXvDEn-wEQcKI8n_OXtYyEQLNrF4BWpgPss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehheculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgf
    gggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgih
    htshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedv
    ffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlh
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:IZwsaL_QnMbUQitZChVSSHD7P9ivT7FZjl6x_slU9_KP6WDZAah4xw>
    <xmx:IZwsaKs_qMLZI_qzcfu0y_HiLfUhEJHi3AJeUYjrfIcOuACrk2UITg>
    <xmx:IZwsaCFaYYc0yo2Nfnos3ZkuBRYG3gB4PEVu6kEYuF6Jm9B4tDCgHg>
    <xmx:IZwsaJOXdkKDqVF_jAzMMQBMJ807LmHgZZWGVAULuZw7m0PqcJLdsQ>
    <xmx:IpwsaAHH4xGEeKeurVtxsNnctuqJ7IH9KdT1pNUPLr9M89-KPSIvJ8Rg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 11:13:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 3/4] pathspec: add flag to indicate operation without
 repository
In-Reply-To: <20250520000125.2162144-4-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Mon, 19 May 2025 17:01:24 -0700")
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
	<20250520000125.2162144-4-jacob.e.keller@intel.com>
Date: Tue, 20 May 2025 08:13:35 -0700
Message-ID: <xmqqwmabjoww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> A following change will add support for pathspecs to the git diff
> --no-index command. This mode of git diff does not load any repository.
>
> Add a new PATHSPEC_NO_REPOSITORY flag indicating that we're parsing
> pathspecs without a repository.
>
> Both PATHSPEC_ATTR and PATHSPEC_FROMTOP require a repository to
> function. Thus, verify that both of these are set in magic_mask to
> ensure they won't be accepted when PATHSPEC_NO_REPOSITORY is set.
>
> Check PATHSPEC_NO_REPOSITORY when warning about paths outside the
> directory tree. When the flag is set, do not look for a git repository
> when generating the warning message.
>
> Finally, add a BUG in match_pathspec_item if the istate is NULL but the
> pathspec has PATHSPEC_ATTR set. Callers which support PATHSPEC_ATTR
> should always pass a valid istate, and callers which don't pass a valid
> istate should have set PATHSPEC_ATTR in the magic_mask field to disable
> support for attribute-based pathspecs.

All very sensible considerations.

> diff --git a/dir.c b/dir.c
> index 2f2b654b0252..45aac0bfacab 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -396,9 +396,12 @@ static int match_pathspec_item(struct index_state *istate,
>  	    strncmp(item->match, name - prefix, item->prefix))
>  		return 0;
>  
> -	if (item->attr_match_nr &&
> -	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
> -		return 0;
> +	if (item->attr_match_nr) {
> +		if (!istate)
> +			BUG("magic PATHSPEC_ATTR requires an index");
> +		if (!match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
> +			return 0;
> +	}

It is a bit curious why we do not check PATHSPEC_NO_REPOSITORY here,
but it is OK, because it is a BUG for istate to be NULL when we have
a repository anyway.

> diff --git a/pathspec.c b/pathspec.c
> index 2b4e434bc0aa..a3ddd701c740 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -492,7 +492,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>  		if (!match) {
>  			const char *hint_path;
>  
> -			if (!have_git_dir())
> +			if ((flags & PATHSPEC_NO_REPOSITORY) || !have_git_dir())
>  				die(_("'%s' is outside the directory tree"),
>  				    copyfrom);
>  			hint_path = repo_get_work_tree(the_repository);

This is a part of generating an error message.  We die early to
avoid having to call get-work-tree when we know we are not even in
any working tree, which makes sense.

> @@ -614,6 +614,10 @@ void parse_pathspec(struct pathspec *pathspec,
>  	    (flags & PATHSPEC_PREFER_FULL))
>  		BUG("PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL are incompatible");
>  
> +	if ((flags & PATHSPEC_NO_REPOSITORY) &&
> +	    (~magic_mask & (PATHSPEC_ATTR | PATHSPEC_FROMTOP)))
> +		BUG("PATHSPEC_NO_REPOSITORY is incompatible with PATHSPEC_ATTR and PATHSPEC_FROMTOP");

Hmph, I am not sure if this change is correct.  The magic_mask
parameter is passed by a caller to say "even if parsr_pathspec()
parses a pathspec using a certain set of features properly, the
caller is not prepared to handle the parsed result".  If magic_mask
lacks PATHSPEC_ATTR, that does not necessarily mean that the given
pathspec contains any pathspec items that do use the attr magic.  It
merely says that the caller is not prepared to handle a pathspec
item that uses the attr magic feature.

If we are going to add a call to parse_pathspec() in a code path
that is specific to diff-no-index, isn't it sufficient to pass
PATHSPEC_ATTR and PATHSPEC_FROMTOP as magic_mask without this
change?


