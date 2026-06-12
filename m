Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD5395AE5
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244020; cv=none; b=A6eKqn6SbFf2Xv7vCHtOUbCHQa//jmFI9/jcgdpPt5ajArOMRGj2V85GAA41L+Wx9g8mzQRPF2lMUF9PwX12vihft/1XmW8XEMyOJlvB78cdXdm771++fSvHheIFaY6TT5DsaWqUppuUlPr/rYdQijlQpp7uqE69rCNz0Mt81S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244020; c=relaxed/simple;
	bh=GcIzKni9As9RqlUscuTOGt0MZYCFgmun/N22OtiszRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5Hhbba4XU4vSGQChCpX9pC3o9m+3+UmBcSNLuaYp4OLzg2J8Rb54tFra808PTL2kyrN+rqPIzRzD9OA8AJblUqHKelAceIUxJ2MumONZ1cVxd0urz4YRFsvnEaUaiLk490N8TaGni/A1/8eIvC2LfKnc912bdXJH/E8ReNP1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kgC+XR5Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+SA0qFJ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kgC+XR5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+SA0qFJ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D769F14000CB;
	Fri, 12 Jun 2026 02:00:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 12 Jun 2026 02:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781244017; x=1781330417; bh=wrzF0s8CRW
	t3URLVsPSjznzJVNU06xM9TzJue5bvJ8g=; b=kgC+XR5Y2/l8m4JBxwFhE+ZzN5
	ddW8j/zKaPoFxNW2GOhBUH3atrdneV4RfWNylnd1Pz7tVhxv0R3cTDqaJdGp4CYE
	i2SVRzvhXj9w79NbpyvwcgsZJnQMw2zxj9gp1tMqOl/xJQWZiSp42yCLFRpijfRe
	/tpGyg4OHVV8zsz7EV2l6cu3xTlyBcCkyYW6Qdh6XyZfEIw8+4O/Qy4RD6PQt8gV
	xDR8LWY28s/st6Y8301Si5CwYijh4uYABN3hFbQsv3YgQiV+XKGaaG1RrItPR5gi
	eu5Oz6EDpS9/+jjZFOxgAXKHCTJCNDY6Ehn67wV0kIKftCzRoM0gu9JxXWcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781244017; x=1781330417; bh=wrzF0s8CRWt3URLVsPSjznzJVNU06xM9TzJ
	ue5bvJ8g=; b=H+SA0qFJtjSHKFgq/q4QSZ91qq1zT5bv4aD74aN+JNbI3dJS6QC
	6UXFgfRMN6/bVg7MBbuTL/g3xXOEH9B+Bla/+lBLLPNmQfAbUVWSojvWgFo3x8k+
	c3fa9DvFhrRvjlamQcEBaBdDgjJ3Q6ZyXD/prqO+IbKY68xaDNfH4P22/lwpwXEL
	12hCXYnkzNWZEdGy2HnOrQlal5eXOUcfysTzRDdkon93k+4HYoZX+604jAPL1dmu
	N8vTAn6BbgOjj/dRuZkissBdyncChjp8M3PPLCDpQKUHKg8eG+Q5vUn0rgzwWopg
	GzblIzqc65ZnzaogOR8i1nR76M6Vh2tkryw==
X-ME-Sender: <xms:caAraq8in5ksZTZpqn4P8O7SZMZRtmng_BPRMR84CqHxVwDd09JToQ>
    <xme:caArague0vWauwkd2QWh2J4gdf4Bec25NU4k4XMQ3_2d-Owja_Bd9CRuXowFxYmt1
    PE42O50bgKQRhYunLnJQImRIIrPdfYCfRZmMJZj5l8BGHDJlf0Y8Sg>
X-ME-Received: <xmr:caAratoiGFXmKmAbY1fWfKDspJ-O_xhVRUiOttnhfj4y4X_MMEMUODF-tYjRwZsNIaCOPTJLu6c8Mad3Kk7dJWfIxEk-DCpQKN3nJHr2SEg>
X-ME-Proxy-Cause: dmFkZTFaF2QER7Q2AZSXbzPvKv6TpfuyWVF7vLmvSS4+9DmhRxIGrTU8SOPn3hG6njaRuj
    RaXsI/ldmUdoBYIr0OIct7gf1QpwFafZ+9uTdYf7KPUbhEgReIzb154bznvzFxDOQF0K1e
    Sz3Ky0AuZMPOGw+FVOA4hg2xmGPBIEhnH49HUWYdLG0hbignrMac6Oq1xT0JpCbIu00OjR
    pL3TIsgllXAS7qM3UqzNYPRUeQ1nnNhJfDabHQ6KdLqWqYHVbtKAt70fMPJ1VbyxmITW0c
    75iF/eERlny+N8ZQRYeh1tWtsrR86XzqkIIrnxiuOUJ4/7ZBdACnxwuEIhIz5aMFRe/fkR
    Gv9o6voYRiGU999GadAtuyqMLJ4UNeNd4vlHKPBrIa+TJgBqAz6FxbXefXoVeK3FKT/Zcn
    Rv/XFdZwtuS2bjeAMyJwafeHaOjgAtW8hCracnv2/ifA+mJF8SbPSXWX8B8TvjW+VQ/xId
    uh3P9YX1ONB+UAcXWt9gBkO2i4texAcXvDlXK/Pn4hbjV2EAFt8cc5djr9oQH/7+e8+my+
    XnOWEkH4gpPwgo7idMWUkZPiqxe/LMvLvY5/qDNzat1Ky3IPrCy8ee75pC+wyFZBMxJHMp
    +IKPLhWMDi/TtJm2V+0xQKzS1Hhjss3LHOF08iueNIf79nSiHoILapnGqVyg
X-ME-Proxy: <xmx:caAratn7aD-5UoKbdTw_MOp0kGrCLk_oSjST1JwDV5-gSs2LA0KDww>
    <xmx:caArahyvypU9mnc35k4OLRKm8Hq3_jnpjAw6yHxt56GVYsKqbrOEGg>
    <xmx:caAralmiBzT-iE1BjofnKiEiaMOhmYCUyX01DUCCT9Z5mMlc0OH1BA>
    <xmx:caAraqfIvLa2oaD7BJzmHOnpfHmKyQQ5jLrNTd9UeKEKRnBTCtOgpw>
    <xmx:caAramU0PrAvorcfOfmS2bE055iT-B41dtm9y300RwvUyZRsCgnVyHJk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 02:00:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 763b11d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 06:00:13 +0000 (UTC)
Date: Fri, 12 Jun 2026 08:00:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] update-ref: add --rename option
Message-ID: <aiugat0gvprSX5yr@pks.im>
References: <xmqqv7brz9ba.fsf@gitster.g>
 <xmqq7bo4n4ge.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bo4n4ge.fsf@gitster.g>

On Thu, Jun 11, 2026 at 02:37:53PM -0700, Junio C Hamano wrote:
> Add a "--rename" option to "git update-ref" with the syntax:
> 
>  $ git update-ref --rename <old-refname> <new-refname>
> 
> It renames <old-refname> together with its reflog to <new-refname>;
> even when used on a local branch ref, the current value and the
> reflog of the ref are the only things that are renamed.  Document it
> and redirect casual users to "git branch -m" if that is what they
> wanted to do.

This reads much better, thanks.

> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> index 37a5019a8b..3b4df23a86 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
> +git update-ref [-m <reason>] --rename <old-refname> <new-refname>
>  git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
>  git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]

This slightly triggers my OCD, but oh, well. No need to change this.

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 2d68c40ecb..65ee8af08c 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -800,6 +802,32 @@ int cmd_update_ref(int argc,
>  	if (end_null)
>  		usage_with_options(git_update_ref_usage, options);
>  
> +	if (rename) {
> +		const char *oldref, *newref;
> +
> +		if (delete || argc != 2)
> +			usage_with_options(git_update_ref_usage, options);

Arguably, we should also complain when either "--no-deref" or "--deref"
were given, as they don't have any effect.

A slight tangent: this is part of why I really don't like commands that
determine their mode via flags: you now have to worry about every
combination of flags and whether they even make sense. With subcommands
we at least only have to worry about the set of flags that directly
apply to that given subcommand.

Makes me wonder whether I should have a look at extending git-refs(1)
further:

    git refs delete <ref> [<oldvalue>]
    git refs update <ref> <newvalue> [<oldvalue>]
    git refs rename <ref> <oldname> <newname>

I always wanted to do this eventually so that we have one top-level
command that knows how to do "everything refs".

Anyway, except for this nit the patch looks good to me, thanks!

Patrick
