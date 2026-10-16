Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DA36215F
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183054; cv=none; b=H8wrKB7urfLytQupDYwtf18S+b3ULejsNbAOz6FYorRsBZLk7F6gNi/b8DFf8NdJmuq4b6ZOBRAZYCY0r8HN4D2p0wxSiIkBrRp66zi9+Gn3ADG4sGFKoWVtarFgJdqHgOToX6whba9urzC+yDl9PPRRJR4R2XlDwyPuU9DsB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183054; c=relaxed/simple;
	bh=pnuW8uUkUa7RVGbusHvrxjXIpwe/VRfPzQ/+KIssazE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aXLLEoWIMydB6m6PfdMa4NVgsQiwrwUQavHRVPGCydMFa6ksyyW0Xclolk2+JQpZHyKrmNaKYc9oDVnUO0h5NQJ6pWrvx/lUqIBe7Q/Sw9JoZpZGG8YVdyDrKZujy0LxPo3FzTq4cIbG1KySmbYdTLK9ADTmQsrzabaqnZRvN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K/6xgxH6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yN3ugGX1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K/6xgxH6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yN3ugGX1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A83F11400146
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 16:37:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 16 Oct 2026 16:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792183050; x=1792269450; bh=QFcWLcDhwN
	kNh6Gs7pkgRrq+N5lHX1fjxAdc9BSFBvg=; b=K/6xgxH6nOJgjxvzvFFaHs1KDi
	5REBCMCCJn1NwHXVLfJyIC8HLEAoE+FnPW4ALaPpLCjEEWv53s6GEw1y3lRPXoVM
	vgblUZDhxy5RXadXpvS/gPu9seZ/UAyRPtluvPIkNNcesLjyl6Ky+9dtUIA3GVa/
	4Qgi/FGSw8YWaNATpl1lc8TAZ3cj5trV172PPabPbgvM4sq62+lDZguLtC4w82TI
	HPCx6o/nhJwz8Xw3X29xcminEY1jO1lVSvh0sPgSCyyWCX2D52v6wb+RA66PjmHR
	/60gMAxO//WTemvIxLqdgBe/x3hsIa3m4hJ+zRm0NCcrzP1Kme1I1JqflxDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792183050; x=1792269450; bh=QFcWLcDhwNkNh6Gs7pkgRrq+N5lHX1fjxAd
	c9BSFBvg=; b=yN3ugGX1e9z/KCsZM5WnjTYEIbaB5AL0OvL6hT1JZndCnu3k3x7
	kUsD7k0f9pHc9OwCAkDdptHrdJPdm1/H7MrG6SgWE0ZiJyJQHwvAteY6/XaWbyu7
	6RBcq20bVJPc6Qv57gAYl4VekmOSdnmYi0xFbRtcN1//oqW750NAygCNleytkW2Y
	3RFsiOFqkGXH6EiXu7jkHqD49GxTU4r4mB7bSPvkahmpiMl8B5msLdDnrIqpBDOl
	6KeSPNvxwdzayZaxebLw9qhhzBkrJFgT9gB14j69wXITpqf8pXJGODMSaXe6sSAt
	+peQ5TGy7F4ixIJi/uqeoPQCPzeBSlU0daQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792183050; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ld68ZMRwwas7CFiK8a8+5+Dvp+Czb+ozh482FP7KMa6VrFc
	k8Ipg/voaY6ruWF0I5agR7M2ib82vQ3NntKouR2vxUZnrjKEhZtqvH9Cf8i97Qp6
	FDQcFJXD3U/vqEIMKuUNNhPVHzZlbFlZWdXS1cKz0iUb0nnvjjTAEkKg+470Ouy6
	DvzbyiBe9PfdzTzdAMo6ZgX/91bO69t4H4obgl5HrbOQLgEJFxXxwzdAH7dniYuE
	tBf/i0rQYpQTPFaTrz+Y23S98fLDU6AagKfm0ejNLSA1KSUmwhROpwURA3IfgOfo
	1V6wJH4AX+WwzlZpZQRYi1iAL19GeW7OFZftwUA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0BH1uo4b77iy5S8dLMHwaoFxq0zL3WwqGcL52WSQhHQ=:pnuW8uUkUa7RVGbusHvrxjXIpwe/VRfPzQ/+KIssazE=;
X-ME-Sender: <xms:CovSat3yEA2t8eXcrSG83GntMTNgar4-hYxf-hxoM04Tmwp3Z7-1mA>
    <xme:CovSaq_cUm_XQ5mD5gkHqMZ5g3IQXlsHWTyPmthMk1p4YPgdag63Uqvgg1hkFKykP
    1IMXKZVV3NgBuon9h7miIXgaUUrDn3mTwoq8nM62KhHah6ymSyOL3E>
X-ME-Received: <xmr:CovSamPD865w12RS3qysYX70JlClzhKOFQLwm43NWhslE_MgKomASAUU0jvg_ieaK-jYCyzChglRNHDTjrV88llrG2UMiG6yoyw7>
X-ME-Proxy-Cause: dmFkZTE58eFt2rV/fx2TO17XnBK5Wt/ntdDyGCW78oW0GH8LPQ0Fos1I+lUS4/KoZUwIth
    uxmOgaA8ciRi9/ICrsObu4ih3fOPde2VLkDL55rpFVt2Jb7hTUog1tIVWcu5rbehY9qvx0
    nahWTkIzKJ39sOoH1mOnfELiaOOJ+jZVzd1+eJsBI6szL8CIYTjn0ub4uh9hdYyLTnZM2R
    l2Kh6+LLezXGPFechjGv9YZJ6Snq6lAPahxtwkVLC5LqJRhQ32/2r30Z9vWRz2xfArwtRa
    SJ1y5nmT5NyDPpx7aUAiq6McfKQ8OJQFfvBC7t6RrLJQ/g2uq8F3TUMoRXEUm62kMoIrrB
    3CvxQRW3zVrOGie2/bxWCIHmIYOfyfiNF5U5jZ3RzQ4Rs8C0KZnDnSLaVzOEpajHLrtl9L
    mYWmeT67aPWHouzLRDdCihTUpVNyx30D3xkHCfBewaHEPfGSxlQN1867Gx9TdmGsR5LYqE
    KXNcENeVKthqP3hW94d+PBXLx5eJnPdxAaPDfrZIJuD4hV5ogyWxsE5+ItYXxiN8GctM/1
    6CnJgYHh2znPh9NhfLsD+KcK53Ti2ZyO7I0lG0gF85gBwrU8pfJpJTKTH0x7T41+xaan/M
    LDlmscWOO7so2MU3/vl6K51Ti8BV6cpmFeJl1aQwkdGOLTFzjiSMPP5GL8iA
X-ME-Proxy: <xmx:CovSamdNOv4r5MxWZT3xWrwREtXcOyFYLOHwstdRt9sxMJKUMUHihA>
    <xmx:CovSatU7Z4JMTu9IX3wgswYIwccDKR-ex-zTju3qkI5mdWQu4rXQ9w>
    <xmx:CovSamgxDijgLXBVRb-zjtkHh1hZivQG2rAmaykxWHg7H3WjbRs7rg>
    <xmx:CovSak_Bh-Bvm7XtzN_DXOup4C1_wChsAHNjuHRTIdSgj25_LVVjJQ>
    <xmx:CovSanXW42QgvpYzRYNwX0OJVf-PxKLmEIJcARIUii3DbZJijOeJpHcl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 16:37:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH] log: speed up --follow following renames for non-linear
 history
In-Reply-To: <atDnyzC_2oaLF0Wo@collabora.com> (Miklos Vajna's message of "Thu,
	15 Oct 2026 16:48:43 +0200")
References: <as44NVKZA9C9S5ae@pks.im> <as6hmUG5AaL5iLbO@szeder.dev>
	<atDnyzC_2oaLF0Wo@collabora.com>
Date: Fri, 16 Oct 2026 13:37:28 -0700
Message-ID: <xmqqy0bxe60n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

> +/* Compute a path to follow in each parent of a merge */
> +static void propagate_follow_pathspec_to_parents(struct rev_info *opt,
> +						 struct commit *commit,
> +						 struct commit_list *parents)
> +{
> +	const char *path = pathspec_single_path(&opt->diffopt.pathspec);
> +	struct commit_list *p;
> +	enum follow_path_change *changes;
> +	int nr = commit_list_count(parents), i;
> +	int has_same = 0;
> +
> +	if (!path)
> +		return;
> +
> +	ALLOC_ARRAY(changes, nr);
> +	for (p = parents, i = 0; p; p = p->next, i++) {
> +		changes[i] = get_follow_path_change(opt, commit, p->item);
> +		if (changes[i] == FOLLOW_PATH_SAME) {
> +			has_same = 1;
> +			break;
> +		}
> +	}
> +
> +	for (p = parents, i = 0; p; p = p->next, i++) {
> +		if (!has_same && changes[i] == FOLLOW_PATH_ADDED)
> +			/* Never the same, added here: expensive rename detection */
> +			propagate_follow_pathspec_to_parent(opt, commit, p->item);
> +		else
> +			remember_follow_pathspec(opt, p->item, path);
> +	}
> +	free(changes);
> +}

Hmph, so if you have two branches A and B that forked from a common
ancestor that had file F,

 - A updates F in place
 - B renames F to G in one commit
 - B then updates the renamed G on in another commit
 - A merges B but decides to keep the original name F and
   original content, deleting G.

then because has_same would be the same, you do not call
propagate_follow_pathspec_to_parent() to prepare the traversal into
branch B's history when you cross the merge, even when we are not
simplifying the history?

That somehow sounds broken to me.  Am I missing something?

