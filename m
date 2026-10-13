Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC97559CB1
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929156; cv=none; b=lZ6LkVM7gwFSvoM2kd1BC9Ly4/dXtdD+jqmkXijPD7Ueb7RZ8iilkGBDOhumYzfAexfQceUDE+Y0+2wfGJjk799CPKZAbg8KGV8z4qARBH+69395MZX5aLLCWkZWPGIF+LHmQimeokrakcr3fk/wbIchVRokPJ+wEHyuSjRzxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929156; c=relaxed/simple;
	bh=OA910o9NrekAB9etiKJkW+0pM31juEyXeaIgjyGw6aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GiZMdQClk99EXxqAKkA8s5Ler5gKZgIUA1Rcwsf2zDrex/rHPu9MXguP6MpJobBzlJYfKITJKCvqaDwbVIxWTjpzg+eZ9tdZEpYlGMLH8OMThP0WSTRHZcNVoj3owtrUxZWUW8xTYf3cJRWORtpWqRigXzgVa8umlfqn11MAVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H+H+1ki1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFsm9d7h; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H+H+1ki1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFsm9d7h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AA4D91D0012C
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 18:05:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 13 Oct 2026 18:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791929154; x=1792015554; bh=DAytLiB2Ou
	ahDL+6IXifApFolqD6ljzpgXR/dX1EB6U=; b=H+H+1ki1pKZ2ENFfvJ3akMeNOs
	GY2ioSsGEpv7m6b26d81W4FKIVqHArZdXLHKr7/7853elqT/hOQOJkTtc6wesgk3
	d6PFVKDSYgC266kanpO5JNe/daS/pryWubtUkK6APyfL/4FBY1TlNG42KIOp1RGy
	xhSvBGvxh+Si+lDBj5s6aUWFqdSVeMLoS1Gwt/07vRWMuQ87/8N8RZaKcgMMTBIv
	5FCjBHVJn4xGzZe2g9W7Xutc+ZOKn4l2o3H89arApI5V6sfqjH1rGtI7InQ4lT6X
	0BSdy3QZo3daARHTWeM1Rfgs7oS25f9A6v5IexGZXDyWAXegCU5/aFQwWstw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791929154; x=1792015554; bh=DAytLiB2OuahDL+6IXifApFolqD6ljzpgXR
	/dX1EB6U=; b=fFsm9d7hNl8xSGH7RWx1HeMkXsfRLbdfam+QGKjoo7QKguoXtt+
	XoPtWAEWD5C3JeC7FDSVc5hniamXU61oCwx078cs3vtbD0bvw2Cur6Ez9a5nPZdf
	pAnNNSnIVbiulDfoXSWsTFCCyzK6qHizwmY/9pXra6zmWz/WvrzhlaYauf01+zXh
	nWgw2/sz10nnsxtcLsuHq/Vva3cSOmDrQiMTg1znnksjY0uJmFvurzniU4sskU5z
	0IzrFy38/mnf+ZfRSCm5zHabVEOHMxA4IUidE+2u8OgDPDnfotaVrfKA73CKXW8y
	i0/RoKOl16gploT3C9/Et+vtth+ru0HTr/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791929154; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RbGF6F1nghz4lmqUJJUqI3/wEnvtiLqYtwPtXzuxpj85kWm
	ZDikwBwk5vP5lZy8o/LXiEKlllpgAEh0dtf5brYWy/vUNDibb46BkfjSv/s6oY20
	lZy9VN1swKBj5xvS80IG0o7EoXwVX/nzlZ3RV8iRzo3S/y7v4boEmSuK19Sz1x8O
	EW7hVuoz/fBPsYdzZhPr2ASlKgyZDYPNFoEcF7oXAJa/YDtebOBwoSd+J5GzbQWS
	mrB/AM28Bu4k5yYNsCgmGNERWjgYFK6/0P2eHIYLtkR7/PUhAKrBVcWjtTE7Mh0g
	wdVz4hcIInKTHEy26DDuhBXi05FesjyWHihSIRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+b4OJgosJy8CPiEjHfr7yDrC6dS113TeGAp71s72wXw=:OA910o9NrekAB9etiKJkW+0pM31juEyXeaIgjyGw6aw=;
X-ME-Sender: <xms:QqvOauMTjbYfp1hvPbvqdBb3HkKR-0OCZrqfZY_R-Mf4uVv4zxacfg>
    <xme:QqvOagqrpKD4Ajb55hUExkTYi-YFajlDlxNaq2rZTn72i92Ol_MIus98tn7klM9Wc
    a3u9ICnpYb8w5_GijeRNIsi3wZ0TsCrXLzZpXS3s7b2TYjmA-YisQ>
X-ME-Received: <xmr:QqvOavEpw_m7-5MZyuGfVjPyHBeVXEp1HsB06aVYvwK9lNTdIdQJ8MGb6YAy00HZcfP8zacByU9eKwaghb1kHFAG5Qg2M_34ZWVZ>
X-ME-Proxy-Cause: dmFkZTEHqsj+/4ZrZipOGOkbX15OuIR35f8LfiRZ+TzmeF2evPwJSWg5Mloh3LB3snXTdL
    a8t0xZ+1UhOusa8P6/Ya1OkPoKuEYJ9sQLkFPBFv4KJX7tPLRxRnefbE5VMWGXYOyOtfEr
    16etxngVFyd65HujqEH/hWvY7Zc0EsZN7RDbrme9o20Vnmps9rtF40ZlGQTDLgVasDXEow
    605oCJs5rQmqOHC7xe7HIEhsEeX/BvIisPE25Cz3HCbTEkwLcLWyZmQUJbl2ddaHT4Bn0x
    7YMh37/e6EVJ5r6lTTwAgFYtI1yoUjLobcmf9hMBp2oXq/yM2k6a0n0o3cYjVKCt+kVmpK
    4t15j/L4fv+WiN00lKtDcZ/5zk1qbNmuvTlNll0JdMkrwp+Il/uDAaZBfQy0e3/5bw8+P5
    HhWKgO6XQmnlyIFA8oO8nFNnQGQRX/vnfqA+U+ge8jz0v7W8csMrpgQKfWI0PFczSInNnp
    F034Ka9LoTEEH5/lw1QqP1hSIjsMJybe5xD0/WGr3q+CJ4Mk+sDuhtqxa2QU9QaSNXNupc
    TafHp9+gtlwMyJ5D+ObZEfdwdLcHXzFh/ZdVG3ynmCFg9WfWeSrbidDmF4+fUyJIqldmtW
    eZSAijzB2Nz7oQ2ZzbyV79fGjytV2tePMVJZAevE6faHOEsnSzqeiWt9TUaA
X-ME-Proxy: <xmx:QqvOalrR4DsBnJuDd2ZskQcM30dUpm93ndueHRdXJUb--adC07QvuQ>
    <xmx:QqvOaobOPexooeiwY6mcESl34MGyqpOvIfDPm8GejynhULrDXjK4jQ>
    <xmx:QqvOauVxlUSMmXnCjoGuhRbGnXnbtOxOnfzUHHTG16u4lE8jvv7Dhw>
    <xmx:QqvOah-zGRuL3x0Y67yJD8fMMicj53V68vpxsP-gLyMK1gOJbfw7PA>
    <xmx:QqvOaszHf1c51XijKInm3brYcDBYXgkIE-5_hDZpfNce_oQM6By-BJeJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 18:05:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jun Wu <quark.zju@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  ps@pks.im,  Jun Wu <quark@meta.com>
Subject: Re: [PATCH 1/2] repository: add core.indexLockTimeout
In-Reply-To: <20261013172315.2997446-2-quark.zju@gmail.com> (Jun Wu's message
	of "Tue, 13 Oct 2026 10:23:14 -0700")
References: <20261013172315.2997446-1-quark.zju@gmail.com>
	<20261013172315.2997446-2-quark.zju@gmail.com>
Date: Tue, 13 Oct 2026 15:05:52 -0700
Message-ID: <xmqqbj8xuugv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jun Wu <quark.zju@gmail.com> writes:

> From: Jun Wu <quark@meta.com>
>
> When an IDE runs `git status` periodically in the background, `status`
> can take the index lock, and this prevents other commands like `add`,
> `commit` from running.
>
> Commit 27344d6a6c (git: add --no-optional-locks option, 2017-09-27)
> avoids the conflict by letting background `git --no-optional-locks status`
> skip the index lock, at the cost of losing refreshed stat info, so
> the next `status` has to re-hash files.
>
> Approach the conflict from the other side: let non-status commands wait
> for the index lock. Mercurial and Sapling have a similar "waiting for wlock"
> behavior, and Git already has `core.{config,filesRef}LockTimeout`.
>
> Ideally all non-status commands can wait for the index lock. However,
> some code paths (e.g. `commit`) load the index without locking, then lock and
> write changes. It is already racy and the wait behavior would make it much
> worse. As a defense, waiting is disabled if index was already read.
>
> Default timeout is 1s, effective but not too long to avoid breaking potential
> user expectation (e.g. "an index.lock error means I should check whether a
> commit message editor is open somewhere"). Tests that are slowed down by the
> default timeout now set the timeout to 0.

Need to change the existing tests is a sign that end-user workflows
that are emulated by them will be impacted, and we'd need to be
careful.

I am not sure if the change is making the right trade-off between
background tasks and end-user action that expects immediate
response.

> @@ -473,7 +473,22 @@ int repo_hold_locked_index(struct repository *repo,
>  			   struct lock_file *lf,
>  			   int flags)
>  {
> +	int timeout_ms;
> +
>  	if (!repo->index_file)
>  		BUG("the repo hasn't been setup");
> -	return repo_hold_lock_file_for_update(repo, lf, repo->index_file, flags);
> +
> +	if (repo->index->initialized) {
> +		/*
> +		 * Index was initialized (read) without lock. To minimize the
> +		 * chance of lost update, do not wait.
> +		 */
> +		timeout_ms = 0;
> +	} else {
> +		timeout_ms = 1000;
> +		repo_config_get_int(repo, "core.indexlocktimeout", &timeout_ms);
> +	}
> +
> +	return repo_hold_lock_file_for_update_timeout(repo, lf, repo->index_file,
> +						      flags, timeout_ms);
>  }

A few comments and/or questions..

 (1) In the unhappy case where the index was read already and then
     we try to take the lock, what should happen when we notice that
     the index is locked and better yet if we notice that the index
     has been updated before we write the in-core index we wanted to
     write out?  The question is what "should" happen, not "what
     happens with the current code".

 (2) Are there cases where we take lock only to make sure nobody
     will update the index without any intention to write out the
     contents of our in-core index?  IOW, we are holding the lock
     only to have a consistent world view while performing a
     read-only operation?  How would this change affect it?

 (3) When 'repo->index->initialized' is true, does it always mean we
     have read the on-disk index already, or are there cases where
     we created the in-core index from scratch and called this
     function with the intention to write over it?  For such a use
     case, what, if any, are the implications of this change? 
