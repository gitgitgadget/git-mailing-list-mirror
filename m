Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EE25D21A
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507979; cv=none; b=P2InK4tnZvb+8LUU1mVSxBC6xRG78NI46f/KLBgSYzJGTwZQiricmnGNvuBjfr8eYoWY3hvufwzolGALUbZqE+5ndtO83MAL1uaYbt4qKXqDuzhaFRa91ZPtUiUXVAIySrmfa8+dVPp3q/WdtY3ls3cOYJYzoLcUKZA2loZkxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507979; c=relaxed/simple;
	bh=Rv/JYzRyoYWRdeQfNdaT3P52mh8W0UXXw5f+jm6RLWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zoy2UZH9kExfnjGd/8PaUAzA8Y3XYqhUB97ybUyfIohQSwWxik2J/fjnWzR2kIUKIkjC49HW9ZzDvtq6SB2TIkI6DdK28hUOFDIzf7DhcG+5XoPj10q9QY7i+u+QsZ33/7a4lwA/MGvdqe3em7Yy5bQRRtHtYHSNB5rlRTHYHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WVSiFuZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azDnfKyo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WVSiFuZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azDnfKyo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63B2E14003D8;
	Mon, 14 Jul 2025 11:46:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 14 Jul 2025 11:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752507976; x=1752594376; bh=UIU+tv8zRb
	gFFztaZz7Nx2tn6T/yN6Gi6D2pOQYMTKk=; b=WVSiFuZSTK4JPCQXypetD1Rft5
	Fne/8dfzJLaywfIy6HuvgNbB/KZiYtLq3iw32CPj7AP3Adc/AanOv0q39vajdPTB
	rc4SOA4w6kIPU0AKMkgOiezILqWhcM55duMTNcrxbkkuZdPhZUsBnjT7qyGMV6Jz
	hLkDp8gnoBX/m04QE5kIevhDrra+uPs1D9VhlsYf1JodOLAOnYC9oTuQDCb/qxTi
	PxZ/zNM+WmSI1fA6+Xbjod+GeksClw2QzNxqTeXLYmxSfRDGQ0lYlTLdpGJPKrEs
	UPoAJihZtme8XBS6mIwXnPPu85VXdmCHppnZgW9ReVGdTVEAfSeZv20HkFew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752507976; x=1752594376; bh=UIU+tv8zRbgFFztaZz7Nx2tn6T/yN6Gi6D2
	pOQYMTKk=; b=azDnfKyoY92IZkdwXjl2fvCRtIK4HjgXOytGLWyMSiw74FhlUGy
	GmoQ3S8BDgH0paKhH3ZUfennAXL3if3E8QcDEwnO1RjhStbs4pcrG+mnaTbBU6qx
	8HoK3HYQIN+IsiV/m9+76MdpnvG5x976WFc4XTYIuD3zF6/HD1t3Sz76eZokIGDi
	Lepsuk0hPn1q24RPuQmzvqEcrs1HrYiRWzuITIuimOKwsKr25K+kXueWUXFwB7c2
	kVoPEJUlqwYNPTYV6wVrQCyOagjNIJwoz7wp6XrtC8f3pNd73Pj5YKvIV1fZwlHA
	8DSb49XOrWRXPHN6KXHlqMjXOzWbxy7V9jA==
X-ME-Sender: <xms:SCZ1aGrABmUfpXXAwUpKyfmUWctFYyH-50STkMBEiXB2Lw77ifhk-w>
    <xme:SCZ1aH4x9ZbqEKbvtFFL5_umXPwOmkp9OnVFiRm-Wk3e1VzpLpefwyFcnU20LkSaD
    YZG1mzG32iBOOxVFQ>
X-ME-Received: <xmr:SCZ1aErKz12uBob9oVOqglx2ffUSrEncUDTOlV9aFbIxjskCT8kw1Rm4KuLksfFABBImQKkO1rjybC5T4naZQoejY9fL4w2mPJEo4PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SCZ1aBgZ0bPZ8yLCl04QoVDDggyWH1_ljYPrWhCobU-PzJUBDkuRAQ>
    <xmx:SCZ1aGLARGk2VsXxZBZ809HK_30o2ATEAX_oAl4tSlvbStJQVi1XYQ>
    <xmx:SCZ1aJD_SFt7Uf7Ru5O3xyuEg1ORDMwTJLIO0m8Rz1c4bf-KqRWOjg>
    <xmx:SCZ1aOjwnk_lajocsAD-RO_bchtlA0NbisVB8tWbcnzFWBXA38nNtQ>
    <xmx:SCZ1aIgvSZ-ntvyNZdZpS7P-LRcr_zOKBxlusfyJHb7-PJ43XB1bwuv2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 11:46:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] ref-cache: remove unused function 'find_ref_entry()'
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-2-4f0ae7c0688f@gmail.com>
	(Karthik Nayak's message of "Tue, 01 Jul 2025 17:03:28 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250701-306-git-for-each-ref-pagination-v1-2-4f0ae7c0688f@gmail.com>
Date: Mon, 14 Jul 2025 08:46:14 -0700
Message-ID: <xmqqecuivkqh.fsf@gitster.g>
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

It seems that ba1c052f (ref_store: implement `refs_peel_ref()`
generically, 2017-09-25) removed the last caller of it.  This is
long overdue ;-)

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
