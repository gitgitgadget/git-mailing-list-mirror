Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3643242D84
	for <git@vger.kernel.org>; Tue, 20 May 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752005; cv=none; b=AcvNiBmK1KFcsbhC3jPYefluwPq+EThPiaFrGigl/U1m6BHplPm5+e3qTeSGnQVgE1I05peRBZh2jLX29g4W87JdjY6B8Gg5LKalEfBhurjdrI4TOe456PxLBHpGRKwVcgGSneC8oxD3uEDk3T1Sw2YOfMU9FX+r6DS/VAYumpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752005; c=relaxed/simple;
	bh=uakbNjDxf8H3eF2chE77b1aAXLcZjaWfxI1JcOIpwkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xx9LDyDBeMR/uPoGObEg09J/752dNWTZmUjMXY1GZtlQvVH8PI1Ny6im6PRvtF7Yf3ZxsKCr6dOkqmqcC2Y6R9NQxy7bxkwkBYZeh5Fsixhv++FZ0XG8GYjfcNaGJFsRdUwiXWZmp4613Ij8ZJW4Xe+CDcePsuxfZuNMwSz7vvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CRn9Ovsd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nouBko6d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CRn9Ovsd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nouBko6d"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 914F21140135;
	Tue, 20 May 2025 10:40:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 20 May 2025 10:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747752001; x=1747838401; bh=+T7MCtAvZq
	md/GrCs5TY0frFRmuvH9dfwEElH0TVZ/0=; b=CRn9OvsdkNr1yjxSZKhg2i/Drp
	TfGVkiX+JuVKI//FMnWcROi4SDxxBG4ILFrIvF1Ljvef65w7P/73wQWovwztFnDP
	9epmkx8j4lxcL//dNF8luT9fPMTGIWNIL89SW5dIbg6qodEP4bxrHggaHy6sT6Gi
	oWNkJ1D6O5ttLkhojt2d2NXYklpai3W5pRTRpAYEjtmwVW8mHKyssBJm7+zTTay8
	5pa3twqVs+NDLMuyrZ4jjyD+58y/FPCV//LvY1Qt4h9Pq31AKGd8jb2VkVk+Me0R
	krz+C5OeWx0ny+MUciIxl88h1THr7RkpT31BCWTsCD10JVGFX3udnIZb8f6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747752001; x=1747838401; bh=+T7MCtAvZqmd/GrCs5TY0frFRmuvH9dfwEE
	lH0TVZ/0=; b=nouBko6dMWbMqrtxyNgSblzzqmv0qA2TwDMJiwxmpTo73RPnxZV
	+f74FXAJBxjAo7cbsK8SLDql9A1S7nkR5nIrXZcqsisSpCTbS/FJFiBF2gb1hbFa
	+ZV+NNDXFskzUw60UlaD9b0WbDZuJK3mxY1HhE2TyxV6OayAVpeSHf9kaevKG3ee
	68wnx/CcPEfeKr9dkXdv/YVOFShge/Yo7B2cUE8OkZfjr9bsTxIbtZXLMbW20elT
	nY5ug1EqlgviMWrzQYvoyqU6hmRjZ2BfFQlxRctCMacwgB7g9RBkl1gCy6Xn9f2+
	xRvyKCxT7rRY/v+/4nXC3MzXDZMjgpWC/nQ==
X-ME-Sender: <xms:QZQsaIRrGN_B-8UGYcKH0E8XwnuvnMwoNsvsUM7yaK-2j7QP928SKg>
    <xme:QZQsaFx7pMv0V4dheQ3deblUooD_lPA0cma7J86fiNMwigXI1Z6oyLS-CQilXRmEX
    tRk-uCUUtj1WA5DIQ>
X-ME-Received: <xmr:QZQsaF2GDfQof-EszP1H-oRCKn24WPMZxS1E_3jQDoA8kq7U9afhPGT5sxK271JgKkqY_AjSlzKtQWC-7CsuGY7LWKIgJwmzsCgxax8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvg
    hllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QZQsaMAvGdmxs0SmDv74PI5qdvOuOvHtL-7dDtvY9Ykj3Lc7Y4wjOQ>
    <xmx:QZQsaBiZ49H8bEKRLGjN4h02Kk4PI7RwZ8joYKGGqXVnMm-ir2t7Uw>
    <xmx:QZQsaIpbekxZ6otUPHp69snQOXnH3UscFPihbEjfGQ7RP9ASoFo8hA>
    <xmx:QZQsaEiHLACOxz9dUO2lth9dyM0gkOynl1W3yR4EVI8j2Yzt1VpzmA>
    <xmx:QZQsaEa12ToUwiGmey0cSlNdKlYosYxdaGF-HCM2ad5rsEl6LtLxprHe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 10:40:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/4] pathspec: expose match_pathspec_with_flags
In-Reply-To: <20250520000125.2162144-3-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Mon, 19 May 2025 17:01:23 -0700")
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
	<20250520000125.2162144-3-jacob.e.keller@intel.com>
Date: Tue, 20 May 2025 07:39:59 -0700
Message-ID: <xmqq7c2bl51c.fsf@gitster.g>
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
> The do_match_pathspec() function has the DO_MATCH_LEADING_PATHSPEC
> option to allow pathspecs to match when matching "src" against a
> pathspec like "src/path/...". This support is not exposed by
> match_pathspec, and the internal flags to do_match_pathspec are not
> exposed outside of dir.c
>
> Make match_pathspec_with_flags public, and expose the
> DO_MATCH_LEADING_PATHSPEC and DO_MATCH_DIRECTORY flags. The
> DO_MATCH_EXCLUDE flag is kept private in dir.c
>
> This will be used in a an extension to support pathspec matching in git
> diff --no-index.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  pathspec.h |  8 ++++++++
>  dir.c      | 11 +++++------
>  2 files changed, 13 insertions(+), 6 deletions(-)

You use diff.orderfile?  Not complaining, just finding it amusing
that somebody uses the feature ;-).

> diff --git a/pathspec.h b/pathspec.h
> index de537cff3cb6..d22d4e80248d 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -184,6 +184,14 @@ int match_pathspec(struct index_state *istate,
>  		   const char *name, int namelen,
>  		   int prefix, char *seen, int is_dir);
>  
> +#define DO_MATCH_DIRECTORY (1<<1)
> +#define DO_MATCH_LEADING_PATHSPEC (1<<2)
> +
> +int match_pathspec_with_flags(struct index_state *istate,
> +			      const struct pathspec *ps,
> +			      const char *name, int namelen,
> +			      int prefix, char *seen, unsigned flags);
> +
>  /*
>   * Determine whether a pathspec will match only entire index entries (non-sparse
>   * files and/or entire sparse directories). If the pathspec has the potential to
> diff --git a/dir.c b/dir.c
> index a374972b6243..2f2b654b0252 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -329,9 +329,8 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
>  	return 1;
>  }
>  
> +// DO_MATCH_EXCLUDE is not public

We do not use // comments (outside borrowed code anyway).

>  #define DO_MATCH_EXCLUDE   (1<<0)
> -#define DO_MATCH_DIRECTORY (1<<1)
> -#define DO_MATCH_LEADING_PATHSPEC (1<<2)
>  
>  /*
>   * Does the given pathspec match the given name?  A match is found if
> @@ -551,10 +550,10 @@ static int do_match_pathspec(struct index_state *istate,
>  	return retval;
>  }
>  
> -static int match_pathspec_with_flags(struct index_state *istate,
> -				     const struct pathspec *ps,
> -				     const char *name, int namelen,
> -				     int prefix, char *seen, unsigned flags)
> +int match_pathspec_with_flags(struct index_state *istate,
> +			      const struct pathspec *ps,
> +			      const char *name, int namelen,
> +			      int prefix, char *seen, unsigned flags)
>  {
>  	int positive, negative;
>  	positive = do_match_pathspec(istate, ps, name, namelen,
