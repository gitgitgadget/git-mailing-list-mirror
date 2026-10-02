Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7E31E84B
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956167; cv=none; b=hle68oH1QRIb4EMEhSFC9RKPPr/moQDfQMkkEbqBD7K1u6SpMlMKFGdb4Lv9xy8zRQyd0b6ekZQn/RTFepbE+KEGjoMM/j+J0VyslQXuqoFwA1yGT5dTrcxv3yuXrENIoIt/F8bYSv/vyjwFurBn+EO0puCLg7FAx3fs+YRT71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956167; c=relaxed/simple;
	bh=lKhO3yR2UZX1WT8WYlc64dhPz0bpn4Oj6J7mgHRbXTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tYyh9yzSdaypqZeBDNg3+k/+vP/d7bPloBA3GImeSveibScm+UeOP1SkqSgAHBiN0SPnVEHHeeKvvUxN8pEj6OYwU2HhVAD3+/ZhQ1OWRBLQkr4NJTBOZAcemfPNLGMMtBv7gEQ+07xeMUx477rY9FUgNYka47ATHNMnkORZEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ajuovLAA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnTUjq80; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ajuovLAA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnTUjq80"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id ADC321D000DB
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:49:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 11:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790956160; x=1791042560; bh=wCu0HwyPML
	9k3hzQA/6Qw0ie32C1GZ4KuuMkHxFldWQ=; b=ajuovLAASzunQ1SYmrxHGj77KJ
	MBg8VL5crek64pMR2cvaoBJWVAEO9/ff/Rw447HfJgeL2E5E/6P9W6P22K1LGj8d
	rD3YBDzNdQhkv2MYNNKAY7BzSDYLPHzOBg27SYcR8ZMuR8HzlWOdOPgINz/rqbqY
	/2jI3SNMln7QTn2ErLZ1QCl5XLjUQnEIKF92a0m+alFwon0JKA/Bo0jpRJ14nwVt
	8wDOacgSHkQRDwgJ8hBMb+rz0CHeZYSbBs/8ZYovHcAgV8i9L7MbRXLLGL8WxLcs
	NQNxSWZ+9NgR+pn5vfEYIvtNJFmaK08rIwia1HMKNYAxj9ONVS/XLlfUoRWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790956160; x=1791042560; bh=wCu0HwyPML9k3hzQA/6Qw0ie32C1GZ4KuuM
	kHxFldWQ=; b=dnTUjq80qaqt2vEkbu45XNJB591iWBM+49g1i/xr3QhwwrlJkQs
	il3WE+ZDFVH4rXp8OLVQSolit1nIItb3gYVFWGCZJni2sS+A98Rq5kJ73RjtfxoO
	xargd7hxiDYqMvl0E6hUqCwjPTqxqp1uJjBZgUzJ/3GOC8WjI/7VLjMUKuvQqU3U
	jbHh6mTs0G3hlgDNw9oBcSMEDLui9s6dMfhtHKb5JpHvJO9ir2xajOLBbfDdMwCx
	ImE32GzldwaipV6DlsuYepichKfac3+T2QqBSmuKGidSaViOibbcZ0JGPaTwqFM9
	2XqWdxoWyd45Gbr6LxUjIogC3vGgsvfU9yQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790956160; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BzFGMZtD5NUYc6JqJITSSl2zJYVxBxp8WQCb0Pr/MfGCbu7
	W7GT40RtEEu2ZwM5DyiXPOqa0TKxB+xZp5J/GxKTK6BQb6NJVu61eamF6fX7go2r
	gIqJ3bD9by13I3qtHg93/Q6/9i3X/z/9IcyGMd3sb6zhPS0S+6Lf2DXbDGJfxuCd
	Z13QG6kRAB/tHbmkQbVsAVqwvESnAvSuuAEPzDKi276/paT/R0rLijwIk9Y02Atc
	U3EiW8pqTs7Y4EfHjH3vPKpuwHiU6qdxS/gxlfgYU7MOteSneu9Oc9XK+HLcy1S7
	J1gPKsWuVpBiNKQsayPrB8VZ7cyORTMXSw0F0eQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wbjUhwVkDuCGcWLNoEz9ae9oCwD2dtsRzP5yCQL+HWg=:lKhO3yR2UZX1WT8WYlc64dhPz0bpn4Oj6J7mgHRbXTI=;
X-ME-Sender: <xms:gNK_ajEkt83wsjAw76bxlqbeQHlx0HBzmEVR7kR4lG5--D0ampDzJA>
    <xme:gNK_anxmfK5OnDGDug8eCZT6_wFS1RBt63uVoPxVP8GLD8IxjLn9QNDb7W9X0SJ-o
    u74R2w9CXjRB7_ayMoWCHkyHRyME_Z3RcTktxyvgNno3xZf4cVpb1M>
X-ME-Received: <xmr:gNK_aigT2UVWBtuKjfsIKZrpyw8gEIqznU68-xW5-lTncZzNvpSMBSG5dMq6kL_kjvXDXFpH-hiIJPMLxHH93bWR4v7UqxwfK5og>
X-ME-Proxy-Cause: dmFkZTGYEPMSmm2I0iTev0vt99atrjsfp9THUHxi1sRWHSI9hQ/t1DsZG/QpTTdTwpkrah
    YzHphhHdhkyfHnlU9qQ6nrVkneeYQN67oxEbFjX6v/WDnSWDceneEs5Qk4GYu3zNIrjoJ3
    wCNNLNjyNuFbEuOJEoi/oaffSYTbrhbzc2fAF4Iz2ghyRuIlIv0UHE6IeOKuPwBQ761LCJ
    K+QK51n2C9C9u3E1g74EBjkAvXc64/3QgOcHLx48QG3HCed29S5MEEBNfX78aG3lVe5Sv2
    ctrcbmRmsCJVLDsoT0ijesxvMaUH1ZBhMJTG3h1bFc2AFty5gsSub7kgUEIILdT8x7ITWA
    Y9F4LXxG2Uy7jnOcKi1EoBoMI437olFDAFQc589yS73cx/AkTpWLxzjxj20ki9cRPmdT7m
    Up7u3q35HaxWLql1Q6NZIwZDNMu0lQKc/Ej9PvnKUPg9+Bwj+FQDM7yKrOBLRgGcfAoVsJ
    5iCLzsONUg6ie7IcfQNZCVV9tpf7HRcse49fCL7XpUj/ltcKEe3PYXkvLLs0VyuKNm6r2x
    jgJbLS624XMTcpD/WSnREObFSfNFwPkrr1lO5jX4tCYBe/lrwTJpGrbHNbDRsvt+mx9cgC
    c24nh21zwEnXbeKtizC8AeIJJLvF8ZgaYP+j3GvzMAQVYPpywPffI62XjwVg
X-ME-Proxy: <xmx:gNK_aqybTQaIXYe2otBiKcF7socVSQ7Gu9sQnctsghPBNofvss9Izw>
    <xmx:gNK_atJL2X0v4VpwqbVKMe7VJQ9vYfHhGVxwCQC1UlZ4mIYpGSFLSQ>
    <xmx:gNK_apR1zduiqG9XIaSXEK2W61oO-ZcfFi0X9RY8T4RXql4ZBhc0LQ>
    <xmx:gNK_atoRYVhkc28Bez78NCkUCE-LXAPL6lcWMVkGgWCVPrHzCc4PEQ>
    <xmx:gNK_apZRzzGxuELKP_ffylgcEI2xWAZJpaf9A7DsHJ6guVJGTpfh44RH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 11:49:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] tag: add --hash=sha256 to sign a tree-sha256
 header
In-Reply-To: <20261002081846.25144-3-scott@gitbutler.net> (Scott Chacon's
	message of "Fri, 2 Oct 2026 10:18:44 +0200")
References: <20261002081846.25144-1-scott@gitbutler.net>
	<20261002081846.25144-3-scott@gitbutler.net>
Date: Fri, 02 Oct 2026 08:49:18 -0700
Message-ID: <xmqqo6dcyuf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Scott Chacon <scott@gitbutler.net> writes:

> @@ -316,11 +318,19 @@ static void create_tag(const struct object_id *object, const char *object_ref,
>  		    "object %s\n"
>  		    "type %s\n"
>  		    "tag %s\n"
> -		    "tagger %s\n\n",
> +		    "tagger %s\n",
>  		    oid_to_hex(object),
>  		    type_name(type),
>  		    tag,
>  		    git_committer_info(IDENT_STRICT));
> +	if (opt->sign && opt->tree_hash) {
> +		strbuf_addstr(&header, TREE_SHA256_HEADER " ");
> +		if (tree_sha256_hex(the_repository, object, &header))
> +			die(_("unable to compute %s for %s"),
> +			    TREE_SHA256_HEADER, object_ref);
> +		strbuf_addch(&header, '\n');
> +	}
> +	strbuf_addch(&header, '\n');

This is a very nice reorganization.  The hardcoded double LF at the
end was a declaration that we wanted to make it hard to add new
fields, but it becomes a hindrance when we want to add an optional
field.
