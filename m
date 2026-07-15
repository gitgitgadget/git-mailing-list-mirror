Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D12C21C4
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100014; cv=none; b=hk4UExquH3VU7jBD5R4zAZZbfTJ9Vlq4U/3ndguMtnCHaeLu5LgAdiAfMmNpCuSzFTe5tOZDMYtqDkvEDJeEX3Xe/ISuxS9WJJ1/npPnU23c0DCXD8olwCyuxoGohIInB2BTB4CQxsfyo4YJJynAyd1hHgLFqqYUcS/6HZOhRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100014; c=relaxed/simple;
	bh=r8D7OfPjy8H0sXENILZnnAbMDzMNMN649ANT2NUJ9Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYtU28sRInFvLyxk++Y4tziuwxaA0Bd9XCF99/quD3gHkBe1LLNaBoRzoo/52Dpzq4TI0nSqW4TzeDXNcY2cyXsVfIibF8rIdDb6XwuAyhP5tVj3AnHay/bG1JoJGClCfbP7HUFRVW64HMkvnLwl/yRftmtFFjTJVz3OkDMI0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=No+1K2cU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iLucb9nl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="No+1K2cU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iLucb9nl"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E657C14000CB;
	Wed, 15 Jul 2026 03:20:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 15 Jul 2026 03:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784100011; x=1784186411; bh=NPCkqJmQ7D
	nsWjbN5BUQEztUdxbgbVkE/MiDjnf+4Ec=; b=No+1K2cUl6BTBIh7FoJ/M95PVl
	3fZO06YVAXVQL0hbeHhkBw+Q5tePQLVqdK+HPQquCZyx33vmhMC/RVBdgL6yzqB4
	4JPUfXw73f4m5ttjY0bOBR6X3NpSqJX1s9V/t79xScSJeYkWwmwwHLOzXfJ1PHHr
	Dd+YSdjobh7z+K7JbBzJLacPP5o8nonuebQn97tY5JQWDy6LAS3ppO5DbqyeC3bm
	XQfq3EcTTd4jE8hCv80zH3OIzmdVS8DzHz+UT3znJCLMGyshLoyLbOgGfMxnKa6g
	8C6uRnijzCBwFFU+l5KqfPPv9iy2hEw5g+6lx5usjTXl8+ygTRUnRNarBGXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784100011; x=1784186411; bh=NPCkqJmQ7DnsWjbN5BUQEztUdxbgbVkE/Mi
	Djnf+4Ec=; b=iLucb9nlXo+njwVygIHLL4p+7do8jXHzGf1lhUclywFifZ7LGij
	jZ0efrO7T0F2ZEnXSHABA1JZM8xSM35LDB20A6tRfkKmGbKNZhJg1+1i4qeBy+q1
	iuZ2JNYGnaN97nZgWG9Ja0kGp+k+4fm4ak9bo2oa5GXv/rkVyq/077GWAYVmTKHt
	iVZxdZVd9L9uBuKIHTSC7paQ5DV1GDa0lUGbAt9W7LakUGjqLSBiCwbw1ZicHttn
	I7nnWiuzt/6mS4szq3vAPx5Zf+GtU4lvMtkdz3MseoYwL3++bpvuBD1TmgdZKeSp
	P6LYmngZ/F7mSzuxjLOoT14ebH8/9+vT0gw==
X-ME-Sender: <xms:qzRXakN0qID4kgXtLk24-YbwcRbwOfv7XFf3yWh7rw6TpVQXDvrLJw>
    <xme:qzRXaiaqwxm3JnN2NnmTDTymbhK5Wh875LvzZmtNXljKQ8Z3ayxJwklhVCl2vs8z-
    RgBGnAgxcY7r0Mq2BxEvqc_FPZ_X0aBPOWk1UX0fKviFrx5au0aNw>
X-ME-Received: <xmr:qzRXaoqes8ZWZDser8PdOERhNV-3TUuabZ9vXjP7Y5lbkPqB57xp7fbSF_GfNWX0UWsOsJoMKkER2ZTJWxjmlxGb6B42OcjLoLzqJfA>
X-ME-Proxy-Cause: dmFkZTFpvR21CFpfKegl9P+JkRQoQGAT3do5UBJWu+gVbC6vyigc99D83W9Dee3eYGRGQL
    uCN8c3wM83umkLIv8TyMZ7PBVEM8GgvvGL7th8LCJ2cyRVVOo1y87o0ofsKsstFB55FYdK
    obQLCLpIYFYqv1LdpOaTadmGttBymXt2dYjngmXxNlTuEWf1jYmgbaJm7QEW20BxnGRDVH
    OEcaM+B/H49lA3TssPbGXxjgEevtAb7ai+mhdWvbSfuTSOggr3NxdVLIm/FGr4IiK0C886
    MhN3CgP01qAqL6Wpj9QGl5H3m7HbUNQhbU1bH1HAWeYuqjL39vD6izW6YaV8aXZUDvVvsd
    LOtjglar16Jtz+vOKnRL2tIDIMx9lX90cg9tSk+P2PrwsTvZn+Cjs/jZ3sNBuJfavdl814
    46YxOfx1jickOHlGYWPZOM+eJWJssWp2eSAmMTdSc8XaZDX95kxchMafTlq40aaCC3NHEI
    0iBqN3CMdM5RvmiBptx5oNbeZSsM/Z7Uv9CshS6xKX2zIS1I9q8yzw0Yf8xXuytrl7/+0s
    omW3GjFOvNhmmtRvAlNRggoxjojlisUCZda5899kY/d33yLWDXnVLMWCVuKFsbur83MSZg
    irxbTu/2RO/NlVWjzUYkRw3wK5UZxmnQrvmyLViUOWcjGG+qxx0MxxkXakEg
X-ME-Proxy: <xmx:qzRXamYA7bbngnjQFI7hhPcPac_cnQgfyYmFEwTrD3Vxj5d-pv6_oQ>
    <xmx:qzRXagRLrg0KWkqiBaymNRJ3AguGtDmhE_KZWdaMrv-KEKgQYNzBoQ>
    <xmx:qzRXat4J3RQwQS3GMh1_sYANOmdJT6iKq5yLlVaaaHTT22ZRoGttag>
    <xmx:qzRXalyxdYNDVuCbbfxKyoglzpJTC2bqLQoQUN18-t95wGKJT6KO6Q>
    <xmx:qzRXapTj4VcHtDhrzyBFR73uNbvQn1kFar9aMQZnA6xezOVgtcCO6Adb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:20:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <20260715015158.48559-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Wed, 15 Jul 2026 07:17:22 +0530")
References: <20260714220042.GC4095533@coredump.intra.peff.net>
	<20260715015158.48559-1-gatlavishweshwarreddy26@gmail.com>
Date: Wed, 15 Jul 2026 00:20:09 -0700
Message-ID: <xmqqwluwpvme.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> In response to Jeff King:
> - init_commit_rev_flags_with_stride() is used as foundation.
>   Current stride=1 gives 64 branches. Dynamic stride for >64
>   branches can be added as a follow-up.

If that is the case ...

>  builtin/show-branch.c | 143 ++++++++++++++++++++++++------------------
>  1 file changed, 83 insertions(+), 60 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index f02831b085..70436007ec 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -34,16 +34,9 @@ static enum git_colorbool showbranch_use_color = GIT_COLOR_UNKNOWN;
>
>  static struct strvec default_args = STRVEC_INIT;
>
> -/*
> - * TODO: convert this use of commit->object.flags to commit-slab
> - * instead to store a pointer to ref name directly. Then use the same
> - * UNINTERESTING definition from revision.h here.
> - */
>  #define UNINTERESTING	01

... it is a bit premature to lose this TODO comment (which was
written, inspired by what I wrote ages ago, in [*1*]), until that
happens.

On the other hand, you can and should lose our own #define
UNINTERSTING here even with this "slab stores a single u64 word"
rewrite, and instead use the common one from <revision.h> header
file.

Thanks.


[Reference]

*1* https://lore.kernel.org/git/xmqq36yud9bp.fsf@gitster-ct.c.googlers.com/
