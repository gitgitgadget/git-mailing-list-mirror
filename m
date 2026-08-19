Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCE44065E
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163668; cv=none; b=lBLrhQwsp3PG8Bh961xIRHCdnPxzBy7VIebFBgndQKbKYa2preRiVhvEZ0I2REGH5FTY2cGD14fETOfl+pE13Xv8FT+uejbcbLMqqQa4UA3cvVWf7l6nlTX71Ic8Q8xNdVHRQ/2FfpatRtKXiZba0XLmt9bzJXhAYjK+5bAA4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163668; c=relaxed/simple;
	bh=csQ/NAb8OLa3N3W9iQVaHN/7GwV6pR3Vbp/jtHyywwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJiH+E1+6S8lC2XQFY81Dtksw53eRxpEseAAjh5yG8ldN0M57Oc8VQGtXzE+LZ8P/M+f+RT+0Oko+kWDHBFXe6xcppZc1rIOuLxHp2Dow1mIH/sm2RL81IbfJC65QkjbQnmmLkTCoa+71G27dZ5CCq+xARdAuMbWcFK1nCgpSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mnW1Z0Gt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ukf2tS2X; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mnW1Z0Gt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ukf2tS2X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CF3651D0015F;
	Wed, 19 Aug 2026 14:21:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 14:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787163665; x=1787250065; bh=VDMcEk63Gx
	vTVc3ExBwsrKuRIX8Se0vweBkAZZ99JYE=; b=mnW1Z0GtfF3/fJ/v/fYqn9YoNt
	SW3OEIrSkfkRr9wzwPzpTCkVfbT+DWwDFvs5iqV5+Oi4ggkP+h6iiC9LsNcTM7Ww
	glq/1J7H+FiuPepMpJf1x+WAe3DxZzM0vTmZx38H4wCXUooSTMVKFF0T3vE7ratf
	WmySwywYnWN382+WBslP7+0en9QPzgMC0mXbChRWoPk89g7b/UF6SP12VuQ0RSE1
	rvPqXZ7J7HQQqumrnCHHB/vLZ3mcLpUeXa2/jmPlJKJlBWHljVZg+p8rVmI9X3JL
	o1/TwYY+kQ1MBKyjcyue6ebk1omfGzPZ0FJwGkyr1JmZESnf83hphmrhuMuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787163665; x=1787250065; bh=VDMcEk63GxvTVc3ExBwsrKuRIX8Se0vweBk
	AZZ99JYE=; b=Ukf2tS2Xl4czg04buTAPXMVDUpLrcaUKpUkPi4uviI/1jr+3jIp
	AuiMb/2Qu4bz4TsUn3H74QVATmBxmaihBE38wTjn0FmFc8pPlVojJs+t4q7ct9KT
	pKQqkf2VVs807M4S+VqYRIhLwfv8F2Ikhp1WD6vrEjy3pvbjhovaDqJ/gLiTDL0l
	zj8bWBGfeU09VMcFwgRhDe6G6wDHKOUbP4T4nzwIO5aZh1gSUeSLDTuIvXZsmQ3n
	6VMwawtC60xo05zaR0Q+m3SfYFb9JTegbX8GSUypYDRTrXFJ7f3fRdalgJFi1p/0
	X84xIkhbFWvJBqBOTrh+vcICjlXNf9/p6Mw==
X-ME-Sender: <xms:EfSFan727-zHXfLCnwZGK29CJ1rFj504Nhf7wOjBOPYsJDSAE9x-oQ>
    <xme:EfSFajwO9hS9mu1nEf1pxaLlra2f6b_O1sVx5c3fpkfQJUvsKI6jLsDT030ZlBClr
    VA2GzpZCdTgiKVRCrfXg-vL_9vdfA11BZCrRowhQpKxdxdX43_JWZo>
X-ME-Received: <xmr:EfSFamyK8MfM07RhJda53Ek3UUV3aoqf4gB60UPx8NbIbN-KCfX-KqcDOI1z6qZ-vhq04I2ZUpIcQC1GL9NnAsAiQ7_0N4JpVw>
X-ME-Proxy-Cause: dmFkZTGiveYpRIC+9VJYl39BPVhktA7G4r1jtONph9VYRzvD7fxAG/3L07YleesLj1Evm7
    22MjkaJBcWk+IJtM4G4IqNSBA0JUBbpMyftu91Wy2BuvOX35ASuCoMmX+6dmfGu1gqWJRL
    tLjMnCax+OnNNMMghRzbrpAADpJ5PvfW8Z8ZCs6QxM8GKb2CbkCkIbBgW/QR5Z08lDZuKt
    cd43//wsgaYp1sHNElreZYHyfGlE16HBOyT7O/qhZ2cyL7S0W1krlAILKaHpieYHUaZ4tV
    gehVZm701RI+HZORQ56riOfnJtaxqs0HBd5/1Hh61fA45F1XFNKZ72xtO3ehJaiFjC/KLf
    FzsmZiHvIgt+n/8KXsRg5Ebqk0dvEsHaQrapksYjOZnFIyu/k3CguV8wSKOFAykqs7ACF7
    OUsXeVkSo1nddcfhYMHb2Q4sCqiCzsLi8MPFle8C0kzrls6meO6vBaOo3VaKNVRf66gpdn
    jI0MxnTq7zlC+bJ17/P5PXY6NLKovtevlODdDmAZGjzb8fRivjAEa3KisLkDARsqgFyU3H
    C4AOwtDpiNhGD9pa4yI12vLEyfjJm+tNo8w630x1QaD18WVF2ObfUqNZgO9veOZoyBi4zg
    yqsBc3PA5mLLAxOoRrGhGyFdzM3JKoJrf2MSPDQ9qtygUhO8vQdFbQBYkT7A
X-ME-Proxy: <xmx:EfSFajwi-QZys7SoRy4VneIB-01y1Zsm3kVzbhgy0NfFcGaxM6MraQ>
    <xmx:EfSFaoY4O5noQg6jFO2mhMTucu44Dt60tRIjxIRQqXhBqKEvsscMdQ>
    <xmx:EfSFasXOg8ZaA9nxztZfJSMl_8ofH7-LwKvcNv7J6NPEMjV0Ly-UZw>
    <xmx:EfSFauhPubu5F6O4fgEMxzBlpMgoTlAhpPQ16fJf3seQV9Fu_JjGrA>
    <xmx:EfSFanAnRkjif-1ObHz1xC3HA_mJ-1eQAM2pQ_RQq3st1MG6qFUHaZRY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 14:21:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
In-Reply-To: <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 18 Aug 2026
	22:34:06 +0000")
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
Date: Wed, 19 Aug 2026 11:21:03 -0700
Message-ID: <xmqqbjayug34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -31,6 +31,35 @@ static int find_pack_entry(struct odb_source_packed *store,
>  		}
>  	}
>  
> +	/*
> +	 * Recovery for a concurrent-repack race: a MIDX can name an owning
> +	 * pack for an object that a simultaneous repack has since deleted,
> +	 * even though the object still exists in another pack the same MIDX
> +	 * covers (e.g. a kept base pack that geometric repack did not rewrite).
> +	 * If the object is present in a MIDX yet none of the paths above could
> +	 * serve it, its recorded owning pack has become unavailable.  The
> +	 * regular fallback above deliberately skips MIDX-covered packs, so
> +	 * scan this MIDX's packs directly to find the surviving copy.  The
> +	 * bsearch gate keeps genuine misses (objects absent from the MIDX) on
> +	 * the fast path.
> +	 */
> +	if (store->midx) {
> +		struct multi_pack_index *m = store->midx;
> +		uint32_t midx_pos, i;
> +
> +		if (bsearch_midx(oid, m, &midx_pos)) {
> +			for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
> +				struct packed_git *p;
> +
> +				if (prepare_midx_pack(m, i))
> +					continue;
> +				p = nth_midxed_pack(m, i);
> +				if (p && packfile_fill_entry(p, oid, e))
> +					return 1;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }

I'll prepare an evil-merge to rewrite this line to

			if (p && packfile_fill_entry(p, oid, e, bad_pack))

to adjust to the API change another topic in-flight brings in when
merging these patches to 'seen'.

This is strictly FYI.  You do not need to rebase on top of the other
topic, until I and/or the author of the other topic ask you.

Thanks.

