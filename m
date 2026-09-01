Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169C73542F6
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788302828; cv=none; b=W4i3Ayi3MeCtC1UsfkBmBWqUp1pnyzLGA0Y0pRtuP3t1l3BLUTNIyn9K1tQ6VVEXu2VQ5WsWcJzkfgpItUNaCoxqCBblc5GsyXRSFz41nOXe9awl3+KMJ8ZTsrehSIoKG2BMXkoxV2uPtcT2zyuglw9aSyKHb/uYRRDYK/XINcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788302828; c=relaxed/simple;
	bh=Vd+UjMIe5mtAerxQ7A5RWPfjFHZG4/kv8FpcnkzhmzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JRYmmhYeMu3Xumf+mp9cTR2U3bfEXhMwAQKZt4rhZksGCs+XRIYwF3PjW79ekqDLf6LPMl/CPm17gOUzZR0A9gSlpg7i66DDZF/SsVqLUcjlL5ls536a/woiFrKcxyRkE78tI+rEFEdUGy3f1DN+jVgm9ac2tGfxv5YJFhdnG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZTF1tdgu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrrKbZJI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZTF1tdgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrrKbZJI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 51C167A00E5;
	Tue,  1 Sep 2026 18:47:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 18:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788302826; x=1788389226; bh=4vrIHfcd8i
	c7efFqerGEHhGXK1sljdRd7VMWKW/hOu8=; b=ZTF1tdguGfODaaAOhu+Fyki0q8
	woKB1eSZRUhuI/aQ3r+YurSM+XkF2EzmJm0kU/bN7hvMqd1tRULXUpGMmaSnCVoi
	IOixor5X/WxgfLjLPMp94pQwBR5QiNsLjmz3OfUFCmUEYBM6+6CSichS4nUIOr3a
	fZqMjayUjSQTIrL2w13oe0ki8uCytO05Df+q3dTET64ATnOPDoJ6QFeRF6Vj0Xln
	d9vlb98JuTLVIXnNkYcV9HFKDYuPnRvMR0MtRTEBHnuXkLqcHmB9UGBc/PfVW0Kk
	2CS0gU4M4V3nKkzwszW4Sf7PfuOuc1yqZYsYmT8wJwtkENr2f5vY2kxEp/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788302826; x=1788389226; bh=4vrIHfcd8ic7efFqerGEHhGXK1sljdRd7VM
	WKW/hOu8=; b=IrrKbZJIV84Yvec3vffCk60ZEfycb5CZlq1YXT6m6ctwSjg+IUN
	c37QRHzka07OuWvD+kWp1XBT2CZf9QszFnQ+aI2NYFplPzBDw1zQ3RNEDP2cLAWI
	cnBctqyLiuyYLln6kQdEIAc/95pTFkVUtDF+c4LNWjE1PvvLhQ9Vu+xvXgGYpRhx
	mfAGgWDXSMokC3L6wUVldromiCVWX4Qi7lc2NvIXBdnUaxMpzgd2BNTvvbyDo8gk
	681rRatac+RZYj+eOYENkSkuTINMkMVWFQS2cUmQYMqSKqfN0xS4xn+3nBrGEv3w
	e94dHYovlgLHyusti+E6/KaDiryOqVM0f5A==
X-ME-Sender: <xms:6lWXavry9-ZVn-MaTPlmzE3T42UdfsEwGgwGPuqP-bQmDFGVbZAfnw>
    <xme:6lWXahEIKZinjtChTojytU2gevS4fnM5sABSUE901TiUkb44E2nK261CLGOuQCmAn
    793Qrd0urjMZYAht-0NrnUKxSyJ6OiIJszL6ceGosKeSpO0XdUhJMM>
X-ME-Received: <xmr:6lWXapm94Qix9l-Rb911OIQXzlekYIbWu7TJwiQEuS5ieyVsq2TB5Qj8KRaHBfnQN41fiGodc-SSvBjwxXloY577BYIymySW2w>
X-ME-Proxy-Cause: dmFkZTEDY2puQN+F/mQ3t93MLTG88eF90wLxZ1ftGXoSnRjoipDdTmvUzYYKANgJs88X3z
    752CMLPzJvW8hrLwEWdMsXhqSiJ4Yy6KHQwA9Gz9Mi4aLJjPwSXeoZdhXZ9bOJ+rzxjHP3
    rwrk3JUtw/Vmjx7gtOzQ6v6Dr0QczR4svTriKyRE+LImAlMIqlD5KA0HTlqlEq1PklI9WE
    HX8CzWBmKhNBCmeHg46C/nqqY2VCmLy3unmsYFSxrxkAXJmGE4gqG8uYc8C/UrzwaHWb4n
    82qPVsrfqRbExtGkS1Ow4JeQ7TCqs8HHD8XkHnwwA4RHGogb3636pkoZSogLtofNPH3ocn
    9Oj2VARvvxzusZTJMb0unpdojxbQeTO9hM/yA36P2USp22avhAWN/BIqA0adb+hMJ/o8Q/
    NuJULNHr5EjyRLs69WbL8nabzHHjwWq0BAgR48Cm1DHS23E9Nc0wV0wAyVZdA0PhpvEPgv
    oLMsv0SuauC7HRaDexLMVtSmlt0J3PxHMlib7Gnb1fGGu3E9vxB4hZNbAdto4VA3g9Qk6l
    knopJuhM3KtbGIBFdDeXjNGasrKiUOt9VRMQltR7C2siTDxHZ0KKZqubQ1QwpI33BiVbZO
    sXuhsS1j6tzjjF/BwKzkdBLYXDoRpFS9SOSpu7CRdNwl2Z6xnvhmRPOcJ1ZA
X-ME-Proxy: <xmx:6lWXasmzS_jsDsqauLb7mVQEy-zZj_IQaMxuWg4pGDryHmZsP0rdsA>
    <xmx:6lWXaiuebzGKzl1xZP30dXV1wAfJlXzf7Y58aoHBdnFn2eVyeLhUVA>
    <xmx:6lWXanl71niuTSnCgS8eKNxVuu27r91jYPfGKQbFrAll1g8gvLZrow>
    <xmx:6lWXaltSoFVRAq7BSaJVS1BNCau0afFZ1bjRNim95w59u2cOTwht_A>
    <xmx:6lWXapPSRmdub7fZpXkuY8o1cT6eEIfu7nlcfrI-suNLUnzG_BLCvOdv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 18:47:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] cache-tree: remove dependency on `the_repository`
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-1-97a312d5fa25@pks.im>
	(Patrick Steinhardt's message of "Tue, 01 Sep 2026 13:09:00 +0200")
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
	<20260901-pks-odb-registering-in-memory-sources-v1-1-97a312d5fa25@pks.im>
Date: Tue, 01 Sep 2026 15:47:04 -0700
Message-ID: <xmqqmru0lhcn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/cache-tree.c b/cache-tree.c
> index a220372a42..6e4d82f3e8 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> ...
> @@ -775,7 +781,7 @@ struct tree *write_in_core_index_as_tree(struct repository *repo,
>  	int was_valid, ret;
>  
>  	was_valid = index_state->cache_tree &&
> -		    cache_tree_fully_valid(index_state->cache_tree);
> +		    cache_tree_fully_valid(repo, index_state->cache_tree);

Here you use "repo".  I do not know offhand if the two callers of
this function write_in_core_index_as_tree() are correct (they are in
builtin/history.c and not my code), but if they are, then "repo"
should match "index_state->repo".  And if they aren't, this code is
broken.

Either way, passing index_state->repo would be the right thing to do
here.  Perhaps write_in_core_index_as_tree() should be corrected to
drop its "repo" parameter.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 154d6d40a1..20e6d6d824 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> ...
> @@ -2086,7 +2087,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  			}
>  
>  			if (!o->skip_cache_tree_update &&
> -			    !cache_tree_fully_valid(o->internal.result.cache_tree))
> +			    !cache_tree_fully_valid(the_repository, o->internal.result.cache_tree))

The o->internal.result is a full fledged istate instance and comes
with its own repository.  It may or may not be the same as
the_repository.

If this were a misconversion, it would argue strongly for a thin
wrapper I suggested in the other message, that only takes an istate
instance and infers which repository and which cache-tree to work
with.
