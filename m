Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC537E5D9
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187194; cv=none; b=QvQCiehElRy/rzweG6+r9lwTKVrwWKGfgZ6bwRvtRzED4DrxbuepqGta5a/BWIDZwL+WqCfR6hLuFO3jA7qrZ++4vda0BAd+Y1RurPN3MagHFNiK+8LFTTBmZavCQ2xhUWYYO465VGEE0iuMM4v9s1smL9g1YE1ZTmT+Oxp6Urk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187194; c=relaxed/simple;
	bh=K5oNZ2Ktx9p0ulV2hqcrZCDJKf/JYXYW2juQ00ryj3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX7KZTVcBwz750xGScXVrBAo3SDNAhn1NWC1ZuWLmROinQfzUPYup/76cWqpbHsGztbiztbRBCTwYRM4vW9Y7KcH9isR25GYLRJ1RbdhTV5DRWr2b6/e3lMxQhQHdGHMNTU77qMAQQ4uZS9Nz9RCNgZe1fx3RIIjMLfUnp5rRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WeEl8N3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRGaKTr5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WeEl8N3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRGaKTr5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E29BEC0C68
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 03:59:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 03:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791187191; x=1791273591; bh=2xA2sZjc9u
	6ULKz2KAA9R5qKDR1iLDlZOeukNHQJDFM=; b=WeEl8N3nW3dJDzYtfHFuxoRa60
	sy+LiorNMcTEJOHO71ZQ5S1yyQY6pKLOTDK87DgMUNcRDitOdmNbEfnONaezx8WK
	9mWLitC40ohZNWl59bjqgYUWwixgsCDSwsa2R/9G6olUDQglf824Aw25CXz96ZPl
	NHPM2hlA5XVEgye6/9oAgspWaQV4GdMuf1kbCflcPLCur5XejQYOb4viHk0OtxlR
	4T4N8sxSTALSvhQmI+wg3G7cMI2x9GusKpiEx3Xv+f78o9AXoNesq8PaiP+5MQVR
	S43e3Y0fY7S5+q6BzNQ0ZEdAa2r00sdXS0likmT4M/V170QwJzxLPdLXV20Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791187191; x=1791273591; bh=2xA2sZjc9u6ULKz2KAA9R5qKDR1iLDlZOeu
	kNHQJDFM=; b=YRGaKTr5YQM20J+/HYO5DTp6eeKWWDIOIthxlPIrCJqkgujftA2
	i5BZGMLjwNLkicC99xo89N6efDh2FDfsNTy1xXQ843DdbSIQHM0yiyETKjdGFTXO
	Glww633s53n9J1nH9E2irk5oJf2f13IBxmcD7WKqKQLI4rgg2rblwoHFrekv0G/U
	WsP9MCJ+PqdsYXZm/p+QTbGI4nvvcCJWhpkKDiDo3/xgi+ocm9rbZtTWzEWhOCQy
	pn2CnHBs3m27wU3L6bbP5fpw2gZRtFTXPiFqB1sIZL477CGNqzfo5t40AyMuiIuL
	yykQGN/hK78uuplY2JfK9pBtozpZYSbGCYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791187191; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RgpHmsBPpmqLY9J6oiMOCM2T7KMGJlMBqT5FZoBCo2bWdZR
	3YSGincNYZszBiNaS6QYqINfxgXIyDSt4loKGGn4zjUiQ3CP01dm4nWRTqSYOCwg
	L3eyTDo61QIgMrO0nQowOnPoP0wdAaJrbYKDuiWvHCFjdqXm1r0dI8ioRV237dN3
	Dl1MjaRh9Cwy7ji0AhjnmGeQ5rpyUZh2oA6+cbAxtrneYTJd5pEiYA1ASlPkot6H
	cEIE2nT8CyZjR3Jb8OZbB3JPx7cayRd0c4iCAu6C/Fyb+qo2q7DcXfmAlBrBz7B0
	WHqgXGz8szc8lfp4RaqSrzF6YO1Th9lvzT6nVcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1fpu2z1uULDe2dUoZjZ3wiqBRoGP26VyCJu0PKv3OmU=:K5oNZ2Ktx9p0ulV2hqcrZCDJKf/JYXYW2juQ00ryj3c=;
X-ME-Sender: <xms:91jDaq_6e10huPHBZ3Lp0ueN9VyMRi1jr7e5Co5g8y3hwpSPyJLhew>
    <xme:91jDaiLuKL40JORkbPAuPLKFuKqvmRjzPr6-iS0-Lhj1X2Bq_p3klHIf_rD5ok02R
    Qj19a3mv-4IAi97nb6x4AFdv1Jj9qTydDisR19v_ZDmh9nvB-lx>
X-ME-Received: <xmr:91jDatb4NfV9KxVYK0lXP12wagwTjvbRDF0RKtJBai-mGr9wHgmsHeIzeUdI5-VC6qNSya8>
X-ME-Proxy-Cause: dmFkZTEEdDeswijo76BZbMQYRip2AQCmwGsZR3uOKcX/rpII1sFJNsitTzmms4kepdvTHX
    sDiCEca5PCWYJpOELmld8tfpkX4dq1XR+kj5ezcba3Qa9/6LwwB9L6FqTjAJT1nPOLXo4f
    2F8b0hKoowVyH10WAZ/WCj6zemRj5lvfXxVIF1UouFVZsfiLkFF3A7SWDzyXc2ZQkTgaWF
    HX7spDgJPWmsA46pgChelzKXxmAMt+J05r82z3BZZKKU80yffDIWw+NlJhyDoM8Z8ngZAD
    uac3B+sL4+w6AaunxGEa2ANxsym4KJPKL7VeQ4C+ofb7RBQrf+MEiFRRzIBwn0FORRoIiS
    +S156OZ5t3IJtIuYDOeYMMgs0m0opKIoukiKWtiZMt7GcKzjvC54N55XuCDd5Mvz+jAkuo
    0ZdOazKNLJ1NNIsF+VzpsihkqsL6rP5kLRDdIXPq+7XDQ8l1qvrtn1A5/ojuwV5M2C2lwb
    g8GVUEsHpwfUztG6vzA2NbjHadZ5MGbzykXemnnXC7QdkLziK8aXII0/vxKic6qr5gHP3G
    F9y3BtGBuTmFXzl1uMPB/mAgE9OR5IZJ7f6nmKolWEdkcxuGMdxjlOx3612EzwQJ13PzWC
    61gearvPbukjdvxJjs/FXtsfq+/OOoQRfPcMWjB+34YqrN575FeZ4QVKDCLQ
X-ME-Proxy: <xmx:91jDasK6ncdAD-5nsmEJCYSeWMv64iABRNY6GsNz5ax4yjYonHCe5w>
    <xmx:91jDajBMLIUGuAVhqGTac9D4n0fjgPOqWnSasTqeLkfmdi87cmTHSg>
    <xmx:91jDapoRIWeu4LLtKONHh4d2_gwci5S3xmCQ4ohh18ibJaVhDwl7mA>
    <xmx:91jDamjkr9IjTWgkGDXJ_eTrL2MT8tfok2ov8AXAN9uhC9Dl6YJbWw>
    <xmx:91jDarZ8d5kxmKogwlGXEqwNrcWSD5w5lBD15Yag4GFNfRCSBUlIHv0K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 03:59:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70216b32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 07:59:48 +0000 (UTC)
Date: Mon, 5 Oct 2026 09:59:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 1/2] Documentation: describe connectivity checking
Message-ID: <asNY7SfEohsOSf0J@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
 <97c11449aeae924436ba22a00a2545254e988a58.1790600552.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c11449aeae924436ba22a00a2545254e988a58.1790600552.git.gitgitgadget@gmail.com>

On Mon, Sep 28, 2026 at 01:02:31PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
> new file mode 100644
> index 0000000000..d20bff6af6
> --- /dev/null
> +++ b/Documentation/technical/connectivity-check.adoc
> @@ -0,0 +1,109 @@
> +Connectivity checking
> +=====================
> +
> +After receiving new objects via fetch, push (receive-pack), clone,
> +or bundle, Git verifies that the new reference tips do not leave
> +the repository in a state where reachable objects are missing.
> +This verification is called the connectivity check.
> +
> +Connectivity invariant
> +----------------------
> +
> +A repository is connected when every object reachable from its
> +references is available locally (with exceptions noted below).

Right. I think it would also be important to spell out the reverse of
this, which is that nothing can be assumed about objects that aren't
reachable by any reference. So even if an object already exists in the
object database, it is not safe to assume that it is fully connected
unless it is referenced.

> +The connectivity check maintains this invariant when references
> +are updated.  It trusts the existing connected state and verifies

Nit: it's basically already implicit, but I'd clarify that "existing
connected state" is again just the connected state of objects reachable
from reference tips. So maybe "It trusts that all objects reachable from
references are already fully connected and verifies..."

> +that the new reference tips do not introduce references to
> +unavailable objects.  Verification is permitted to stop when it
> +reaches objects already reachable from trusted existing
> +references, since their closure is already connected.  These
> +trusted references include local references and references from
> +alternate object stores.
> +
> +Without this check, a truncated or corrupted transfer could leave
> +a repository in a state where later history walks encounter
> +missing objects.
> +
> +Exceptions
> +~~~~~~~~~~
> +
> +Gitlink entries (submodule references) are excluded from
> +connectivity checking.  Their target objects belong to a separate
> +repository.
> +
> +In partial clones, objects promised by a promisor remote are
> +accepted as connected without requiring local existence.  The
> +check excludes promisor objects from traversal so that it does
> +not trigger on-demand fetches for them.
> +
> +Full connectivity check
> +-----------------------
> +
> +`check_connected()` (see `connected.c`) normally performs the

I'm always a bit hesitant to directly refer to code in our docs. We
should either make this documentation part of "connected.c" directly, or
we should not refer to code. Otherwise, chances that this documentation
grows stale is very high.

> +connectivity check using a `rev-list` subprocess, feeding the
> +new reference tips via stdin.  A normal invocation is roughly:
> +
> +    git rev-list --objects --stdin --not --all --quiet
> +        --alternate-refs [--exclude-promisor-objects]
> +
> +When promisor remotes are configured, `check_connected()` first
> +attempts a fast path based on promisor packfiles.  If it falls
> +back to the `rev-list` check, `--exclude-promisor-objects` is
> +added so that the traversal does not trigger on-demand fetches.
> +
> +Consider the following graph after a fetch, where all reference
> +tips point directly to commits.  For simplicity, only local
> +references appear on the already-connected side; alternate refs
> +play the same role.  N3 is a merge commit:
> +
> +            /-------------L2
> +           /
> +    C1---B1---C2---B2-----L1
> +          \         \
> +           N1        N3---T2
> +            \       /
> +             N2-----------T1
> +
> +    L1, L2:         local refs
> +    T1, T2:         incoming tips (new refs)
> +    N1, N2, N3:     incoming commits (N3 is a merge)
> +    B1, B2:         boundary commits (already connected)
> +    C1, C2:         already connected (but not boundary)
> +
> +The incoming set is the commits reachable from the incoming
> +tips but not from the already-connected side.  Boundary commits
> +are the already-connected commits at the edge of that set.  Here
> +B1 is an ancestor of B2, which happens when incoming branches
> +fork at different depths in the existing history.
> +
> +The check proceeds in three phases:
> +
> +1. Walk from the incoming tips (T1, T2) against the trusted
> +   refs (L1, L2) to find the incoming set ({N1, N2, N3, T1, T2}).
> +
> +2. Walk the trees of the boundary commits (B1, B2) and mark
> +   those objects uninteresting.  These trees are already trusted
> +   because their commits are on the already-connected side.
> +
> +3. Walk the trees of each incoming commit and verify that every
> +   referenced object is connected, stopping at objects already
> +   marked uninteresting in phase 2.

I feel like these phases here basically just explain how revision walks
work without adding any more details that are specifically relevant to
the connectivity check.

> +Deepening fetches
> +~~~~~~~~~~~~~~~~~
> +
> +For deepening fetches (where the shallow boundary moves), the
> +full check omits `--not --all`.  There is no existing-reference
> +boundary at which the walk can stop.  Instead, traversal follows
> +the effective shallow boundary supplied for the deepened
> +repository.  The new content may be below the old shallow
> +boundary even when the tips themselves have not changed.
> +
> +Non-commit tips
> +~~~~~~~~~~~~~~~
> +
> +When a new reference points to a non-commit object, such as a
> +tag, tree, or blob, that object is not part of the commit walk.
> +These non-commit tips are handled by the subsequent object
> +traversal.

Huh, what subsequent object traversal? This part puzzles me a bit.

Patrick
