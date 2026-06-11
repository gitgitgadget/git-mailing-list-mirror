Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED4345CAE
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217166; cv=none; b=HGQHKrj9pxLf6bso5mMKsPfDQwv7WKINqRILRpoEdbs9GLIt/HUSl8Jrp7a2FKWaJmHX5h8EKIWMPosGVXTnzFfm0eXoLNZezelRYVo32kJfBkFot8rP+qPHtduTTmpgEvNMzhiqWXbDyLVSG22wl5GANuS0RpZqe5lINfD1YdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217166; c=relaxed/simple;
	bh=WE3c7xleQ9E3+uXR1qPdVjxLr88bMtySUdeX3tDZAE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O0ysgSUTf0ELeXel90mt8Pv10+y5BuMpxigqHZvVSSDUMna5Yvy2UT+TOPA6yhkChrdh4tcQEenz6dF5NmXmst/K8bdID248Pl8qM0c3KIUvnuHt6B+X496ZaLcF5MqSC9JmH2pDuSXF0lmFToZqNoHyXHnIWsKwDy7o0q3J300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EnbgF09s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcHzHkZN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EnbgF09s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcHzHkZN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E5A72EC010A;
	Thu, 11 Jun 2026 18:32:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 18:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781217163; x=1781303563; bh=rxXDKCxhHg
	xHTVOiv+7yqhbqoaSHOgECMgcXE0VnSoU=; b=EnbgF09sT/29s8K/QEbIM7Bh3S
	J4xtVbUADpSwXkFxd984Fq4+wwEK6HDJxm4/vxc6/VD3PSFmQAIcv/vrEMiV/WEQ
	vngETvjSTHJLXaFiJP4++uvPy6tqM2sNgoXtu5wW/QfyiPLxc/eh9vQVSU+3BP+C
	c0SjTPEbtMZg8ocMCo5LP6aToU0YsbHE4Q9q5KRhFqBdtee7Wh0xvkAsH5pT+M3I
	PaEjvFa0OD0Ot2YZL8JvWXLM+onRTDIwzsyFiWeVdIdraikKzGmZjBu0WKtStxAW
	ygoPC2xuJT3S2HyrH+lyVe7pwG/h4Mvrme2OCeaEBpaqYTNsT4MC9Pzv2WwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781217163; x=1781303563; bh=rxXDKCxhHgxHTVOiv+7yqhbqoaSHOgECMgc
	XE0VnSoU=; b=ZcHzHkZNKHiZOOMi631R0zxEC/WIFNG3pCu7Azz4i52e5unRf29
	iW6OKpdHhosl1FOFouhES8iAMmCOcqPoyo0aUEjW6SPPRB/uEOCTUFMcaZFGe0Wc
	/Dhn2Laz8rTdOrOXdsJhlB1cOPDykdN3NIiQk/SIFcuWi4pbjkouT/vom3VV7Udi
	2S4wfbjh8LoR061ybAnDA+F9EXTLaah6fQRFsCo7zN0xDDEpeOGkdhbPDhAC0Q0I
	G1Zl3kZfX79vHovZ07UHd6JX5RI+3CcfQkHQiSfW9vw8YwYiZrn0Gei7nN6A65UO
	JePU3P7LGJYh4sWetz5FSg7yYc9g4YZX8JA==
X-ME-Sender: <xms:izcrat4flvQfezN3Xtx_Yc7kpHVbZVGKpPzYnSjiylIhR-MxcGxDSw>
    <xme:izcrah7GY0wStEfOIVBMXOzjuH-mf5_ptcS2l2vmf99yd_EDSlFivWryBdq7eKKLk
    2iM1URd35szgTEXN12xpDy6Bv_oV9aMpyq-GwsJx0oQbgedUAkCsg>
X-ME-Received: <xmr:izcrapdcDEB6IX6ezy2iVT99m6vc8gBVmVxw5zXqxgEtztmtXzVXd8nYZHJ72y31ggypfyXEjXDHBPSvGSCp2I59oHOaFCNqUjhY>
X-ME-Proxy-Cause: dmFkZTEXy8LfkKSQzrZ1fON8IxdgsL/4w7JGyhPmASOK8ysKQ7t3hmj3WHeeVD3sqgrl04
    xVnLMSC2Zgtevfp+8h6i+kx4SFX+atzj62E0SuTEHYHLlDGk7j154U/N3SXK1qIsbt1g5v
    FjTyZFg0wGuEta7GtolT8CyD+F9P+nhQyr74OjZXR7jWcV9cwTsQIH1n3/QGxgUvuqeROz
    guc2P0RkJY9RLl0A90F6b4WykvBuyuKu0rtIOzlQsKX8ai5IAP2IsJ34ajs1TbuLlrZkH+
    T/V/hyzItQ423G7iEW9jTgMqLNer+HtYmFCmO/yYRO4OllTGLJOhjcFakTXmBHde23LRNq
    8WhXwNWuHYlfkssEGS5XTrHoq7Oofb2xvNA92vxp2Pig7TFpbJX7yMJu9hpFy+CozcJZSh
    ClUTNlrWJLkc/ciRQg7SVAdvbofPeFfUxTARwiBwWqn5p/h7RnaUKc3zU6C7TSfrW4Yrkk
    yjC5g++1FdOhkJVwrOKRI+3H+om6rrAQnH5Pt6ajFrsEyit//RVb9yT5VeIJQJmeJBVORM
    EeHygQXOHNmDxxC/jyxwW3ZRdAnWPqsZo5EQylgoNeLCbcakW1ly4heC/YV+ZaL14/YcOF
    Z4wHTUOqYXAA0yzs+QDm6EXCWsw7CZPeyzbV2Mtr0yqymhFOmkIkTqmP6TvA
X-ME-Proxy: <xmx:izcralAkx4YA1IfoxaA7iSW2cJ9WExhk3v51MkheGmdKyKYuOtz6xQ>
    <xmx:izcras-La9Qs9EqW08Bo6RJsE_ZZfC46B-jLzhq0jleCcjGy8gt0GQ>
    <xmx:izcragLP0MSDfgT_xdnEJyCDpYBQGGZEyXfKmQHAgCy2HxFMhkkN4g>
    <xmx:izcralgDp4DX4N4gmnFz9cMc9JVz6HSdLXA84fp3nKbyeoHYiyb65w>
    <xmx:izcramFVFIfsQj5UF1FCnrWbbxnl1AIhFWEqefc7W5jDsItN7pk1pqt9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 18:32:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2] log: improve --follow following renames for
 non-linear history
In-Reply-To: <aipTOsH8LKTSwglj@collabora.com> (Miklos Vajna's message of "Thu,
	11 Jun 2026 08:18:34 +0200")
References: <aipTOsH8LKTSwglj@collabora.com>
Date: Thu, 11 Jun 2026 15:32:42 -0700
Message-ID: <xmqqo6hglncl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

> situation when determining what path to follow for a specific commit
> with multiple previously visited children.
> ---

Missing sign-off; omitting sign-off to say that this is primarily
for requesting comments and not ready for application (often we see
RFC on the Subject line when this is done) is fine, though.

>> Can a "map" cut it?
>> 
>> If a history forked at commit A, with two children commit B and
>> commit C, and you started traversing the history from a much later
>> descendant M that merges these two lines of history (i.e., M^1
>> contains B, M^2 contains C, and A==B^1==C^1), while traversing down
>> from M to B you may find that you need to follow path1 and similarly
>> somewhere between M down to C the path you are following may be
>> path2.  And the traversal meets at A.  The slab records path1 for B
>> and path2 for C.  Wouldn't you need to be able to store both path1
>> and path2 for commit A?  What path do you need to pay attention to
>> when traversing past A to its ancestors?
>
> Indeed, I focused on merge commits and their parents and I did not 
> consider that slab[A] may be set to path1 when visiting one parent and 
> then slab[A] may be set to path2 when visiting an other parent -- even 
> if "A" itself is just a plain commit with no renames and is not a merge.

"A" in my example is a fork point.  One of A's children may arrive
at A following path1 while another child may come to A following
path2.  IOW, in the history below:

      B---X---o---M---o---Z
     /           /
    A---C---Y---o

 * A has the original path at "path0"; so do B and C.
 * X renames "path0" to "path1"
 * Y renames "path0" to "path2"
 * M merges path1 coming from upper and path2 from lower history
   and records the result at path "path".
 * Z has "path".

You run "git log --follow Z -- path".

My answer to my (rhetorical) question (Can a "map" cut it?) actually
was "we probably can", since our "rename following" code does not
handle cases where two paths in a parent is merged into a single
path in a child, or a single path in a parent is split to form
multiple paths in a child.

So the "what path are we following?" slab would need to keep track
of a single path.  From Z down to M, we follow "path".  "path1" is
followed from M to X and "path2" is followed from M to Y.  And from
X to A, and Y to A, we follow "path0".  IOW, I did not think we need
two paths recorded for one commit.

Are any of your test cases added by this patch behave differently
with this version (vs the "single path assigned to each commit"
version you had earlier)?  If so, then obviously there is some hole
in my above discussion.  

One case that _could_ break down is if a rename on one track (say,
at Y) is so huge that it is not recognised as a rename.  Then from Y
down to A we would probably try to track "path2" (because we fail to
notice that "path2" came from "path0") and declare that "path2"
appeared at Y from nowhere.  But even then, we shouldn't propagate
"path2" down to A, so A would get only "path0" which was what we
follow going from X down to A, I think.  Still no need for following
multiple paths at a fork point.

> +	/* Any recorded paths for this commit? If so, restore it */
> +	if (opt->diffopt.flags.follow_renames) {
> +		paths = get_follow_pathspec_at(opt, commit);
> +		if (!paths->nr) {
> +			const char *path = pathspec_single_path(&opt->diffopt.pathspec);
> +			if (path)
> +				string_list_insert(paths, path);

We do not need to worry about deduplicating, as string_list_insert()
will automatically takes care of that for us, which is nice.

> +		}
> +		set_pathspec_to_paths(&opt->diffopt.pathspec, paths);
> +		if (paths->nr > 1) {
> +			/* diff_check_follow_pathspec() doesn't handle multiple paths */
> +			saved_follow_renames = opt->diffopt.flags.follow_renames;
> +			opt->diffopt.flags.follow_renames = 0;
> +		}
> +	}

Eek. That's a subtle workaround to break the built-in safety to
ensure there is only one pathspec element while following.

