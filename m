Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982821ADA7
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832443; cv=none; b=ODTQ9oRJQnjOwDBCqHFva3ALAuDILUfmI4yX5pAaYVVW+y2tzC/UCu1ulxezaZLph2F6MG0dMcgh3QCpy65a1VpLymIPsathM1pgebKaL2kD6A74lm8Ey22tyKmMPDd/ce3fjnhQgDUW1UOFB4wdNEND0WGv49NAlxMedT7Gmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832443; c=relaxed/simple;
	bh=xy1JZIoYtcLez/QAOCx1jgS1mosxHKtlpELRC3VZhwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WOJuGMJfMiimsYT9RuISf0MFEhAjZ/LdTaBQPBcEIHbO1UPsBJBx4TDcMlMJEVR5vhNajTaGhk/OL/CwlJJTit4wnyXdaRqdwNyZ7noz0FBt94ODj/18iPjn2APJ1F7F1PSJFKMUIL3X/gH1BUYpUiIycmYUmXNAHIhjdzzaJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jupq5oY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFq80C4m; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jupq5oY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFq80C4m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03AF914000FC;
	Wed, 11 Feb 2026 12:54:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 12:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770832441; x=1770918841; bh=cE6GR1Nypk
	JbUOU7r60pRBGCSAoEZP51YiGG6221S1k=; b=Jupq5oY3DOB4uCl3Z5dyzztslV
	M7ho7W8Wk+8hKaqwExRjjfuavfuaUmN6Oxjfxirbr6k1ML8gFB2qawJv4jhiY+tC
	jVgHqFHCEw2bNuRQFMDSNPi1dluXCh8dQVWYHgsVgApy+1yPS1QrFoGjCgX/98cC
	VI+sdjtqWIVHITZ5f8GAvNUFkh8yu7dtM1A91Om2wUPN2WxzDfl/y+5IjsiofqUk
	qOwPi+fr2mLxBWv4cZVQu2ZtsNgUeun6hyHmqcLqkOVDVkkO57puollvBMwuSJlY
	T+3vB63ylj8Y8exFa9dC0aJfCnXgQ5XEMIE/8z+YGKoZkzBk2QePf+8Oxp5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770832441; x=1770918841; bh=cE6GR1NypkJbUOU7r60pRBGCSAoEZP51YiG
	G6221S1k=; b=kFq80C4mlFYNQf2DahL2taLv2hlscf6nROgtfkSYAcdEMXdskfX
	+B6eaPXa+H+GDqeAK3FV4VfwgvKyvtbvZh5/gAgv6hZcdEQTycs0aYrPO/dbaF+M
	dzqkrT+Jtyh+YyLeahw3NOUCC/ptkGYQA7T73iO9gdb9oRDh12zvE7ftemMohdTH
	AZfLksMs+VxMCpo/cb01VMtfECjWQ1UKEf0J1w74kdzm30LY0Y3VqnVqoY9tVgZC
	dGpK4oNNGvq8DcPxY74ofraRPcJ9Y6wJCEYEOgGAAk41hrb7RiaCN4J/Cp+2z+y7
	gzcZRcivKw27KylTuSDZdu+FD4dBQLaIAdA==
X-ME-Sender: <xms:OcKMaYO9QApm5B37BB1ydrki1IdKT_BUHYTAAQQU4VaxXCKL8ZBadA>
    <xme:OcKMaWZaaohEJxe3-J6IwfZbdMydNb01DygWJgVec9TPjGbBqY9pjYYuRCcYTOMwq
    OUzkUrztthSfZjcYTPvtVQR3wlh-gQvqp9WNqOnFDoEuCGVYaSSwg>
X-ME-Received: <xmr:OcKMacopBqFKw-eA56y0PoP85yYGjTi5MhUb-EG8usImOn6aODRxjFo83WWJbPXHh_7JTfHwOSVBNpG-Z3TxJttWMv7cCUpKDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:OcKMaabKLbT9Cy0j6kn2EfS4J2cmDtyn3DJIyMfuFgdK2z05FstRTg>
    <xmx:OcKMaUTo-Qofep6ODPAb2uPdlCS9UU-q6-43J2TJtzqEHjPDPjdM5w>
    <xmx:OcKMaR5-VlQ74lOhal7vh3bQ9n5xFn9ro1rzAagTG84_NDvk18_2NQ>
    <xmx:OcKMaZywnVNlS5Dk_fHh_rMt7DNBOj8mCHIjZ59NZhYOWRbpEboXjw>
    <xmx:OcKMaZqTGnolu-pR0Iemuero0XBp-2qmFMyj2x9fhiVTKcpZERHBCn9A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 12:54:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore-break: prevent dangling pointer
In-Reply-To: <20260211041128.48412-2-hanyang.tony@bytedance.com> (Han Young's
	message of "Wed, 11 Feb 2026 12:11:28 +0800")
References: <20260211041128.48412-1-hanyang.tony@bytedance.com>
	<20260211041128.48412-2-hanyang.tony@bytedance.com>
Date: Wed, 11 Feb 2026 09:54:00 -0800
Message-ID: <xmqqfr77upxj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> After we have freed the file pair, we should set the queue reference to null.
> This prevents us from encountering a dangling pointer later on.
> ---
>  diffcore-break.c | 1 +
>  1 file changed, 1 insertion(+)

Missing are sign-off and tests.

This reminds me of 56d388e6 (diff: avoid segfault with freed
entries, 2025-12-29).
>
> diff --git a/diffcore-break.c b/diffcore-break.c
> index c4c2173f30..9b11fe2fa0 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -222,6 +222,7 @@ void diffcore_break(struct repository *r, int break_score)
>  				free(p); /* not diff_free_filepair(), we are
>  					  * reusing one and two here.
>  					  */
> +				q->queue[i] = NULL;
>  				continue;
>  			}
>  		}

