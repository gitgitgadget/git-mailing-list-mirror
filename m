Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900E34A79D
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508418; cv=none; b=NS8D9wpfirNEODFY02T9Ny8acROiuFCmfSz1HIOwBQpXqpuDi/OvunYo0XdB/z8UmfjPF86/VmoOnppxvrG6JcxlsABEII1++E9tkTsqihTMaEMb2GKQKMlDx4kZcNECD/6ibxoHBjOKRuH68YwGQ95zBpqZ6wxSR9LxhzZ+bog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508418; c=relaxed/simple;
	bh=AG3jhZCGm3mHwDZMc8a7NfDzvxh0O/Xm6vuDPXUOCkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snosqvzr1DdAF8uTTAoBQFhHppl6Fh4yVQvwdZeKBImMLdSeO7R/wNNJVCsm4QxO+wOm7Zz10JQ7ex0ToKZ01gSc/vE1iCPrSS7XGPpcbDBl4NkPUlwO2+wfjfo4bub64Y23a+IA/xzo3XWrnpswdEbEHI/+4DlwzFgJ092mE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bg885YpI; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bg885YpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782508412; x=1783113212; i=l.s.r@web.de;
	bh=rv3fPlaA4LGoPGjSAnLSDZrqPVLwORNZ0sOzL2oIlQo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bg885YpIyDqbwzF7V8NW1Ndo78j4U7Eog849GF0XtVyknBsStOhgh1Ykoxw5rNop
	 XFeyCLyF0TY0JHlcs/IfxE2A0uKzfhxiv+JFFu/rpMldOnxcXB6cQxRJcI+Bj9MWF
	 eVIqJ+PR5OHa5mpVlId5Y85RK0HLs3gxKzsY20ys53v4oteE45nMqzZGyF5/5Sw8I
	 Lt3vNZo+FlGHRvHEvWuJjmv8bDLMGJebYnrLdB08dGdxwLJLmY2IKN0hclIYvVDev
	 0gM3vcDYf6OrhtBvD72QWJak0DIlnHsnWuFtRsb7PT2azRgX4ewAjuDMjjiCHGhSj
	 vdPd4AwlusW7JdpXMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECGl-1wTZDF2y9N-009ecK; Fri, 26
 Jun 2026 23:13:32 +0200
Message-ID: <bd37b80d-9eff-496d-8f1f-436594968678@web.de>
Date: Fri, 26 Jun 2026 23:13:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] commit-reach: introduce struct paint_state with
 per-side counters
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>,
 Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <e82e0c72b6fc72b214f40efa9586c77790881f93.1782479286.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <e82e0c72b6fc72b214f40efa9586c77790881f93.1782479286.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OI9fH7VeI6rhHWNnF0MFJjmKD59uOQrKyu4xZM5jojknd6Gn7zt
 csPVh3mQB2i1WXmRXxMiPiHN6toBh1ohGByHwKcGyFsdv1dgiopR1ykebsQCZAr94FavJHJ
 ZaKwORWEQvII4hZK+lmqMT0xtku0zvya37vJjIfU92mAqPy8gtN/92dpEvv8uNzjxmJiuYu
 G77yD7q1vWaWZ+xNq0h3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/icbsCYlBnY=;aggr2N7WUFKmd8Itxvlb/ZoZ4Qh
 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

On 6/26/26 3:08 PM, Kristofer Karlsson via GitGitGadget wrote:
>=20
> diff --git a/commit-reach.c b/commit-reach.c
> index f6a438550b..0f29b143bd 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -97,6 +97,75 @@ static struct commit *nonstale_queue_get_dedup(struct=
 nonstale_queue *queue)
>  	return commit;
>  }
> =20
> +/*
> + * Priority queue with per-side commit counters for paint_down_to_commo=
n().
> + * Each non-stale queued commit occupies exactly one bucket: PARENT1-on=
ly,
> + * PARENT2-only, or both (a pending merge-base candidate).
> + */
> +struct paint_state {
> +	struct prio_queue queue;
> +	int p1_count;
> +	int p2_count;
> +	int pending_merge_bases;
> +};
Can they become negative?  Wouldn't size_t be a more natural fit,
matching nr from struct prio_queue?

And some bikeshedding:

Why abbreviate?  parent1_count and parent2_count would be slightly
easier to read and associate with PARENT1 and PARENT2.

And pending_merge_bases is a counter as well.  Why not call it
like that, pending_merge_base_count?   Well, that's pretty long.
both_count?  That's quite generic and nondescript.  Call the other
counters parents1 and parents2?  Nah.  Or parent1s and parent2s?
Not sure why this inconsistency bothers me to begin with.

Ren=C3=A9

