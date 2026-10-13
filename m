Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE94EDCD0
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891050; cv=none; b=MALz5egpbhA8zEczbwBI2shaYbb8JxatJ76jJsKt5177QPHTWPcLSsrQLBpu0P8Ii4Q0Xq5UawwsrviQheMdMvwKuDXqi71UOqb52FpWQ3N/L5D4vJ2GFeKlqzQYWdTyiA7+iT+eKsai/FF8r35rfd6M1VhGF0yIWCF7SmGQ/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891050; c=relaxed/simple;
	bh=8dn8n4t9lqreFgjJ90omtSY7UAmppyodt9JYLQYHTGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRdQLhOTwlPulAG/LGyr/MpCi076707ISMvnDDjP93Ynwl3l/zrQF+mk5wV4LhaYXDKtHO8ZVcFZ8+uyABP1rYwa4h2hvfqt/vjEuxoZsZWlSEDKL8cKsuX30jrcKUhEJuvoxGXjZGFGWcY0qCjRap9xq4IkpVt15YQ3nJ8Nk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o1bclxv+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H16i6QU9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o1bclxv+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H16i6QU9"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 440AE1400155
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:30:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 13 Oct 2026 07:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791891048; x=1791977448; bh=K7ktU/0lGt
	Y4rd3FmQbU0s0w5RZeXzS40gAjOZWmOJQ=; b=o1bclxv+xbUmLeustVU7uElV44
	LKyAT08DtRLcCBxiNyPVlk6kzXLK5Edqh/beVCLwFPhlbOkJPuJue3OX6wYn4XuJ
	qjSQp2zFsCGGFazbQm2lhyrfA/ajRMWbPMun5IVUYia7fYa1XFLT4uF43bVW+83W
	wjGB/pAyqL74EqBDm9x7J/drIv28W9Ajna4tqJAa7FWGtQqXInjfALunU0vlLyMl
	zKrdb/h9uS5e0m3WuL9GcaQNj94mwgWcG97ofz9XmY4B5fxZflOYvtWbj8V2g9JY
	CNFza/yxV2uCbozRqX4oRcj8VfEqEotcY6uHd/spI4t9a3oOgeiy6QwdBcrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791891048; x=1791977448; bh=K7ktU/0lGtY4rd3FmQbU0s0w5RZeXzS40gA
	jOZWmOJQ=; b=H16i6QU9Bv3anx+qDWq/FrE+dbeX6hCDwI4KKqC4XWKHhpAou9w
	RdZehC5mtmjJWj6pTk/CwgIs9ftjU3nCDy5rAZyxaNIXbBzfZnCN5uQ9L32ZAXnC
	GfVv5TeaTy0Okf20xF75JUB8jYkeB1UwnGP8tA8QXpSslLhIoKVaPm0OL1vrf7IP
	itdWsjNiurTSJN8ErCtBY/P0B0zsuNi550glJaVWVM9cwadYjPJ6OD+RnQf9/A+m
	OwAQ7SaqKeFcyB5itVCUY8Z5fpydO5kXj2QYVSFQhnomf0RvhIu+5b7lkA+uAuR9
	Him8Rk5qx2N8xhTTPcO0WB1drkPEQX7HPPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791891048; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IN5v0qBHwNQVFBXKLcwKT7xxI5EqyjJCgO17HEP44bPzkvq
	XSFdTML582ZL0aqT+Vc6Fw2GxIrFi9jjqUgm25gywyAMI0Yow5b2w9dHWW8OOo9s
	geCbi+rSpDQ7v59UquWF3bRK/cZ1nTllfblu1EnJgHqOCJedLY26YXgx/qECxrtG
	w0RngljiFmaz74tEdU9ijCDI7xvjN5byhV2VRZeEnJwYvNuJHjddcRh/YdK56fSP
	wBiPn/X7yYZeX8Rbk73N9vyxSE2sKTV2r07YaAl3qw3q76qHGPw02jxsCYsm3ysw
	why+20RYI70AyEMsup3BVIRpcr2yGMOR2XA2wZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:V5rDOeVguXNwxApqlC0YA9yNJD7HBWNbgkIaeqz/fo4=:8dn8n4t9lqreFgjJ90omtSY7UAmppyodt9JYLQYHTGM=;
X-ME-Sender: <xms:aBbOavtBH-xfF_wapyaCJ5f8UK9f2igO4ZZGFJZi2qnbeWm-CI7C2w>
    <xme:aBbOanWAJzcB4KLUKbZCqzRIl0ZpEhGW8sHyqANU0g2RTidaRyic_fn6zEn_FOkJA
    -mAvDucm2M07JVb1na0pKKp7myTb-DyQt7NfzguAj1jJ9Y48FPrjjs>
X-ME-Received: <xmr:aBbOarFiKX44to5x2ypzvZIJSrwduRv9kOFjBJ5f-CH5oob6A-cwZw>
X-ME-Proxy-Cause: dmFkZTGzjXA8j5O11SJ3k62NgptvBHilkrbtCShV8IEwYm+6Rpcpi/ab7d+JaRQuBS/QEE
    PUIfXqRPt/fqeCKPS9K0GlJDP/yE/5PJNg1uoPW0YwCgYWFVssFm9Xu5LI++9USHcbay8c
    rGYz3yXmqC38o0YPGF6DppJZDhyHVwWofkvNDyM7l3dDwFT4oaLZR1ycirvPcbQfC3TUON
    qkBHajq6avwgDDQf2+O7Ds0T9AKqYp8HBkx6YbELUc19DzGI3QOOw6ws8+IKdqisgfld8u
    w7otVbtOviBKAL0J5u6IaC8V1V1lZr0T+cHgkSlEsXWzCinhS23j6iV450mqocAl9hyRfX
    UDaAQYim7EZLgKBa3lJ8pvhlVHIqs08RYqjn8ybU2hGIGeb59vwnREhVFGq5WT7gzoT7JV
    k0TVaKDOjxL5W1wLhW1bpoG2ATMJ1ufOQez1Oqab+5lVxWuq7nLLRqVnElHyRdC7OVxDiU
    3qAGSyERYXwiyLn2r5KIwTi+dxflqox1hjAsS5N5dm3ZjoAn6kypm8xB72kO1nqpupuYD+
    XsrpF5IhoBRX0vHKUo1HXOvpjJ0csgvYt5GMMmxGN+LBpSBS29EuYsFq4LZcs0SeNN+Cr8
    KiK1PdYpwCnVy+Et0HDRz5mhvkKO3Ap5vgRB5kCXwB+T1JJ0SZd14KpweXGQ
X-ME-Proxy: <xmx:aBbOap01F-WPgLDUHf0BFcUluaXqyFpjhCQ01iaEdFFwuUJb5NOSBg>
    <xmx:aBbOatOe3ixpbxJG6FsmRdmFgf7ciEg5HHLwOYm9KFcZ2aBZ_BjJdQ>
    <xmx:aBbOao6L-4VVOjC2HdgALs-OKVaTzHfJ5I0Ia3dO6DNivEgmjR2fDA>
    <xmx:aBbOan1HnSzXU1kY5b_yFANCIIJhOwINOjozF0CFQIx0R_qTR4sZcw>
    <xmx:aBbOahHeeF9q8Nb373yZqeIYbr1dnet8k_EmZpmYvPjd2aNyQ9vlaz0v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 07:30:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e90ab045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 11:30:45 +0000 (UTC)
Date: Tue, 13 Oct 2026 13:30:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, coygeek@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH v2] repack: do not rebuild packs on --dry-run
Message-ID: <as4WY96-KXQT_PTc@pks.im>
References: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
 <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>

On Sun, Oct 11, 2026 at 02:30:50AM +0530, Siddharth Shrimali wrote:
>  builtin/repack.c                |  7 +++++++
>  t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c4360382c1..7797972642 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -387,14 +387,21 @@ int cmd_repack(int argc,
>  		if (dry_run) {
>  			struct oidset_iter iter;
>  			const struct object_id *oid;
>  
>  			oidset_iter_init(&drop_oids, &iter);
>  			while ((oid = oidset_iter_next(&iter)))
>  				printf("%s\n", oid_to_hex(oid));
> +
> +			/*
> +			 * Only list the candidates to be dropped; skip
> +			 * the actual repack
> +			 */
> +			ret = 0;
> +			goto cleanup;
>  		}
>  	}

Okay, makes sense. I wonder though, we later have a check like this:

	if (pack_everything & ALL_INTO_ONE) {
		repack_promisor_objects(repo, &po_args, &names, packtmp,
			(drop_filtered && !dry_run) ? &drop_oids : NULL);

Is the `!dry_run` check redundant now because of the above early exit?

Patrick
