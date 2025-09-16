Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15A2C2AA2
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006673; cv=none; b=nR13BgT5xa1QosOMyxP9jMPzPQKzWCOe4z7bsW7Gj/QQrYaZ6Yj3ccBt6HA6d3SXMxYJkUJ3oDPgkw+B1VAdJcRqtZgDkDUxzDVnMlUGaqQlRoRdtyC/hSSsMYSMbCGPyoljM5YIoUSzXkuYlVHKCgkI/RfgOBu1s0knVdIR7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006673; c=relaxed/simple;
	bh=FU2S/OMiFra06KWug66QpoCo6glrrNh/W9kPFFaD7Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIs70thFqkp8v6kg9o5IUrvCh1TntbjI7/E6MMj1guff2fjtd0SSzxk5dM9uUl9JPXigstY+V+CVOZU9ZnWwf/PHOwTdBEjjhlbU1MatnPdhd8oW/O9QpPB16Xl8KNy/z0eUJcGkCrUjXTIk6Z5Kg7T6S9iXKZ5wdWW5gDOlTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C1uLSEtR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=advgHbX9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C1uLSEtR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="advgHbX9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 807821D00153;
	Tue, 16 Sep 2025 03:11:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 16 Sep 2025 03:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758006670; x=1758093070; bh=jgNe1k8Ft+
	pezpkiqkoK+tTDwLU2aZ94FkSJp4nzT64=; b=C1uLSEtRAPjC+r65Qm31ErgWAb
	ycouqb6A3nH0dLK+6RHqjSOINEL1yOzDGVAdT6XHQLVkxKb8iX4nauX2C93ySM9L
	Tu22XZ5+KB70cxX/QU5QFyJ74Hduq9/d564PQD9IiIzwjyjs0CkTPxk9CV6fzVI0
	bklul4fLn+xiPtIDtk8ewjkc2iJro3aJSeDbP6+onB/UkWH7U4N2DOtiEt3LjLGQ
	Bn1xCfUdgzSjB/fW4svOU2lCcA2p/oWeDcUmdSNZwLAdYAM5F5ToLXk8F3eU40Ak
	DhbVAIexVcTpTJeubRNNfwKkEiMLt4YWkUL8LLAqrZ+CljolqATZUaOntpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758006670; x=1758093070; bh=jgNe1k8Ft+pezpkiqkoK+tTDwLU2aZ94FkS
	Jp4nzT64=; b=advgHbX9tOTMTvzQOHS+rgYAYGgVsTDAUvK26vx9Vu9c60muGuW
	tx7KRrxZYd9gTSjm9lnL+I9vRSqt2GgmEBS7WITV2/OhV+UBMSBzbyITSf/HxAGT
	bMi63Hakzd9KsMSzvmZiO7uhzSBTXj2hZFJ3y1ZuXnY/VgL+RgXeKA5pAIm95tNu
	2tflsRrWMRgINsFnRUFOTt4RpIOGePHW01IDTYBSZIuLbrl7EUXWqDc+4YDw67qQ
	/btRbcLOPvI+ZmiE+zETFCkuqOq7F/83iuGlelHcBzDJJv7iMgTbU6xOWxx8dqUU
	YEfczJsq/wuF2hJcInGF3xWtJBmpM5nAHOg==
X-ME-Sender: <xms:jQ3JaPLubKYPasUzMXV68Ij-7hvA38myALrfkzjJ_pT-kk75tah8LQ>
    <xme:jQ3JaGYxpRI-0Gd5EvEXW3J9mrraSelxActOX1_LzyhP1icUPxuF2QyIRV3VbLnCu
    ZAV5RAChc0iZmSKOw>
X-ME-Received: <xmr:jQ3JaBIwikHyLkT2-8KVdNNyeO9l4CQJikYCxmsD533Y3-6W40R0MMHjUFxOxHK9ikFGhIYzMYA2NOnNOSOOjCRFi9JPn72h21hYkcwdgQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidr
    ohhrgh
X-ME-Proxy: <xmx:jQ3JaEAfAGYgZTgnP7yI8BvEJTFBfgD-6TtLxyuFSB1T0IMDE37nrA>
    <xmx:jQ3JaGpPsuMvZNUw4_c3jNNctNParvKV6ceDTZNLy2XNKrIxxyfbxA>
    <xmx:jQ3JaPgV0LWPPNOHi7SqM0jAecCVo4HZOcz0WCTU206MnH7TrJd5lQ>
    <xmx:jQ3JaDDrJBGTGCobTlSJHe8DUTCM1uiOw1I37dulms27V3uq9G46sg>
    <xmx:jg3JaLrJDPS7tooNNeSxv3ao672FehWOsNYZqnc1sZmRF2rGygvtxElh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 03:11:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 708560e0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 07:11:07 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:11:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] combine-diff: don't override recursive flag in
 diff_tree_combined()
Message-ID: <aMkNiC_s-Dt4iRPp@pks.im>
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>

On Fri, Sep 05, 2025 at 03:06:31PM +0200, Toon Claes wrote:
> Function diff_tree_combined() copies the 'struct diff_options' from the
> input 'struct rev_info' to override some flags. One flag was
> 'recursive', which is set to 1. This has been the case since the
> inception of this function in af3feefa1d (diff-tree -c: show a merge
> commit a bit more sensibly., 2006-01-24). From that commit there's no
> clear indication why recursive is overridden. But this breaks the
> recently introduced subcommand git-last-modified(1) in some cases
> (i.e. when criss-cross merges are involved). It then would exit with the
> error:
> 
>     BUG: paths remaining beyond boundary in last-modified
> 
> The last-modified machinery uses a hashmap for all the files it wants to
> get the last-modified commit for. Through log_tree_commit() the callback
> mark_path() is called. Here the incoming path is looked up in the
> hashmap, but because the diff-tree machinery internally switched to
> recursive (even if the last-modified machinery wasn't) the entry for
> 'dir' was never expelled from the hashmap, and the BUG() statement was
> hit.

Okay. So if I understand correctly, the issue here is that once we do a
recursive diff we skip directory entries and only print blobs. And
because of that we never manage to blame the directory to any specific
commit.

What this doesn't explain though is how this is related to criss-cross
merges. Why does the error not happen with "normal" merges?

> Remove overriding 'diffopt.flags.recursive' in diff_tree_combined() and
> move setting this flag to the callers which relied on the recursive
> behavior.
> 
> Because internally diff-tree no longer runs recursive, this results in a
> nice speedup when running `git last-modified` on git.git:

I assume this is only the case for `git last-modified --no-recursive`,
right? Do we know to set `diffopt.flags.recursive` in that case already,
or do we handle recursion manually in that case?

> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 49dd4d00ebf1bcc644383ee99df3a9e05502b89b..6ef0438d36dd1091d2806b46306f2b5ee7274bc0 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -16,10 +16,21 @@ static struct rev_info log_tree_opt;
>  
>  static int diff_tree_commit_oid(const struct object_id *oid)
>  {
> +	struct rev_info rev_info = log_tree_opt;
>  	struct commit *commit = lookup_commit_reference(the_repository, oid);
> +
>  	if (!commit)
>  		return -1;
> -	return log_tree_commit(&log_tree_opt, commit);
> +
> +	/*
> +	 * log_tree_commit() calls into diff_tree_combined() which historically
> +	 * used to enable diffopt.flags.recursive when option '-c' is given.
> +	 * To not break backward compatibility, set 'resursive' here.
> +	 */
> +	if (rev_info.combine_merges)
> +		rev_info.diffopt.flags.recursive = 1;
> +
> +	return log_tree_commit(&rev_info, commit);
>  }
>  
>  /* Diff one or more commits. */

Don't we have to do the same dance for `stdin_diff_commit()`? There's
also callsites in git-am(1), git-log(1) and others. Why don't we have to
adjust any of those?

> diff --git a/combine-diff.c b/combine-diff.c
> index 3878faabe7bb2f7c80cffbf3add6123f17960627..305414efdf436d53fee8d79aa4219f6a4dd3445e 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1515,7 +1515,6 @@ void diff_tree_combined(const struct object_id *oid,
>  
>  	diffopts = *opt;
>  	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
> -	diffopts.flags.recursive = 1;
>  	diffopts.flags.allow_external = 0;
>  
>  	/* find set of paths that everybody touches

With the above I'm a bit worried that we're changing behaviour for
direct or indirect callers without noticing. Our tests may not detect
any regressions, but that doesn't really prove that there is none.

An alternative approach could be to introduce a new flag that causes us
to not override the `recursive` flag. It's quite an ugly workaround and
makes the infra even weirder. But at least we could be sure that we
don't alter behaviour inadvertently.

Other than that I don't really have much of a better idea.

Patrick
