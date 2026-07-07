Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BE34DCC8
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437900; cv=none; b=Ln63R0r7jHjJ1zzgUGtM7GuYrVt/CrwB0c3ILEMLLFh/OSBmX+oSuDNh5N2hbNktFsYbPeiui71PbjiwyzwbPzaxdptLuOwEexiuHPiIPWzEjaSjwjL4Emjqa1p4pepyDKtdffPz8H36BHeoOszfUVauMJGG8tbtbEy+EKvMTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437900; c=relaxed/simple;
	bh=vTEXI+VxPPV820lI1lcifeesK92jv3/ELr39Y063cZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6P3NUulDtIJ3J7U1W8lVs9hRTcY9vyJANKBuYWazji7eG7w3CAkngjBdGhpBYzE+bLTLqXF7DhsSigGqUePUIyZU9KefRcHZ/rhOBrVGD6yOiUQM6Nyec+UuDkY7xN9cad8DLNNg2PPIUC6Z4lKCd92/e3Pk6F3q8ghV3bI40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hMJZqDq1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ig6ysLc4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hMJZqDq1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ig6ysLc4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 61A59EC0200;
	Tue,  7 Jul 2026 11:24:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 11:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783437898; x=1783524298; bh=x7RdsLWT5g
	JD2K17l0xCaiN+GPLiwQkOLHVGOLCIK2M=; b=hMJZqDq1RLYDuL5CfCh6EhNKt4
	Jd3on3/7giYOenKtdHaTz8ffLek0ZuIzOtZI9NsVSL65udGw2slVJKtZuWavs/SM
	L/8nqBs8TVLLbvdOIsQ8QdwQoWgTyyglDsBuSLSkgAKSECicXY9qhihZc3yGZNVa
	gMAovqlTCC8ROKHaRoN1XpKykHfA0+KYzHzLxgYzK4Xr86jN7Szhws+LRgB56OEx
	dITMF5hRZBoiEjYuH6mkXpr8ISGGYy06r/xQ0EVqZ8CPWEVl7dd2ZIBlm6rvfoay
	9j0cgiTCOjN2sMQvDj99ZjH6gxEW55UthODB2Ywl4G/onGOAcrxarCE0Q5sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783437898; x=1783524298; bh=x7RdsLWT5gJD2K17l0xCaiN+GPLiwQkOLHV
	GOLCIK2M=; b=ig6ysLc4IhCFAjxIDoXG5lFlfPr80Aqzx9vH0pjnRYuF4GOC7JO
	AHQ2SAsV0ay+R2AQcPpZy8yHDPhUs+W+OvPWL7GrTNtul7DdIg0zbhDWaTqE7Pwd
	oiQ+btluU5Ee6wCyzyne5PPcdnrghQisETIPavRUQOVQKUHli27Jac92lAtxVcuU
	sPcpV+n/pGi1dIaxDi94vHbP/UBUdeBZcO9x1BhsisevPZQavm9c/iErCh7yv8SV
	dPoGWapDwRihWIVy5m3gwUhDP7VDUmir24zOwcZDelDRuiE+EcTjlGJub3f0zaMg
	o2OifastsLLRPBKvG1lPaK34nJ3JQVqXkgQ==
X-ME-Sender: <xms:ShpNasBZMqpI0ucSwXRxIsjVjKY-NVtpM_UTAINv3b-CNpyDO-UFIw>
    <xme:ShpNal-u5KInY5JWdFMt2-FKhqAGo5jJSrOD9eK-OWEr64tfG-g9J9WIMt8XyPCyr
    W_rpvuU7pACJZA7Q5X61roJNfAOByou_Mwg31rvFizKIlkBplKsbg>
X-ME-Received: <xmr:ShpNas-gGSbl9L3rB5_dhmbYprwW6AMeNk_GCfMrcr3oTgFQ8QgVAknPjjtMOyli1c0xc86ptvfbpsx5xzHIVsRg5sHg8-6HIEOPGb-LgQ>
X-ME-Proxy-Cause: dmFkZTGTmrTfx+dntehQBGZQ0ligB7wD9zdTKvSFJj15QaY8MMTd/HmExCjfUu/4sCNyu/
    g6Pkcm3ixLjYnnaWqplFasObNejY9qpsxJ4K0XATMC706LOxmK0NnMnYZmIvHURCP2F+/U
    wntgk8ctjyPTsSBszoJJTekI3wujIUOzf8ULPqe9VHAq8Gm7NQeifG9HAvMdPHxwdxevPV
    vcgcSRQHxDXpShaa5OlVDPokNvvmQWTrgqSUt5+rJcUDIJ+PfSK8dpGtadiwAdva9PJaNj
    so5F83g3gIK/kiM2BuGT5GElcOgOnlIfRn9HuI2mnV7xap1fe7xwnFclbOtk0ppje065BL
    uDcTYfltnqnBxUcGD+2cdhqxbrzYPuKZv3HXQcb8tc9ojUSqVCp+9HQna06roy8yxND4NN
    q+PdGYEtT1fslMd5Fgm0T6RpUGhp5Zh61AqK6XPq4wsxemzq6Qeia+7HfH0/AbKXWMQxJp
    LpPagDeTr8Rq0dp6HM79BHWZzD7Ylp16hrDxaUOR/IvfoEm2KXkR3ZBgdc46c/ZVa+d3BM
    cIVuAqIduDzm48C9lebcwQN/VCNU7EszVDGwRRaX7Fqzn2E9C/73wQRHG500R8a5/zqLHS
    mDeEbE6jZM8or4+9AHH+jwa3yQ6zBujrOxLrMMZzF31YO3adpRrH6XUKM1bA
X-ME-Proxy: <xmx:ShpNasf1AekW8Xgx7YyrfzuNGqrxW4jFAlt3jltkzCTxDk6_oB5vhQ>
    <xmx:ShpNalHre4je4AD1tcRtncdt1-rddtlkrqowAJBWRHeD2xqAhiWZRA>
    <xmx:ShpNaqd4a6kQNhzlfVQ9VTNA2MW3oPwGCSfxvQpZXKU6hLMkKPgL7w>
    <xmx:ShpNavFy7yqK57ADyZNuvDmAitc3DlfuPARWkAjMGN3ZwlH2byO-yA>
    <xmx:ShpNalNQRNt2Uw1Zs9UavJlOmU5nIDxIHag5UENj7fAiaycHIrIiDCUl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 11:24:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c0783ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 15:24:56 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:24:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] reftable: fix quadratic behavior when re-creating
 deleted refs
Message-ID: <ak0aRtvSxSyIWieg@pks.im>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <1459371d3ab2f237152e20040987b4cb6a5eca77.1783344957.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459371d3ab2f237152e20040987b4cb6a5eca77.1783344957.git.gitgitgadget@gmail.com>

On Mon, Jul 06, 2026 at 01:35:56PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> When many refs are deleted and then re-created, update-ref exhibits
> quadratic behavior.  With 8000 refs deleted and re-created, the
> runtime is ~15s, quadrupling for each doubling of input size.
> 
> The root cause is the merged iterator's suppress_deletions flag.
> When set, merged_iter_next_void() silently consumes tombstone records
> in a tight internal loop before returning to the caller.  This
> prevents higher-level code from checking iteration bounds (such as
> prefix or refname comparisons) until after all tombstones have been
> scanned.
> 
> This affects two code paths during ref creation:
> 
>  - refs_verify_refnames_available() seeks to "refs/tags/foo-1/" to
>    check for D/F conflicts and must scan through all subsequent
>    tombstones before the caller can see that they are past the prefix
>    of interest.
> 
>  - reftable_backend_read_ref() seeks to a specific refname and must
>    scan through all subsequent tombstones before returning "not
>    found", because the merged iterator skips the matching tombstone
>    and searches for the next live record.

It probably not only impacts reference creation, but also every reader
that wants to search for a specific reference that doesn't exist.

> Fix this by removing suppress_deletions from the merged iterator and
> instead handling deletion records at each call site in the reftable
> backend, where prefix and refname bounds are available.  Tombstones
> are now returned to callers, which skip them after their existing
> bounds checks.  This allows iteration to terminate as soon as a
> tombstone past the relevant bound is encountered.

This option is still used by downstream users of the reftable library,
like libgit2. So we shouldn't just delete it outright.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 4ae22922de..8c4f119ff1 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -633,6 +633,9 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  			break;
>  		}
>  
> +		if (iter->ref.value_type == REFTABLE_REF_DELETION)
> +			continue;
> +
>  		if (iter->exclude_patterns && should_exclude_current_ref(iter))
>  			continue;
>  

Okay. I was first wondering whether we should move this call earlier.
But we actually don't want to, as this is the code that precedes the
above:

	if (iter->prefix_len &&
	    strncmp(iter->prefix, iter->ref.refname, iter->prefix_len)) {
		iter->err = 1;
		break;
	}

So this allows us to not only skip the current iteration, but completely
abort iteration by observing tombstones that sort after our prefix.

In any case, as far as I can see all sites where we iterate through
either ref or log records have been adapted to handle deletions.

Thanks!

Patrick
