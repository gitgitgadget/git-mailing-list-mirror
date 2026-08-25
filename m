Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01279367B61
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787697418; cv=none; b=TCWeIrKLjqE1xv3P5A8RSdx7Tc9CL/4tEJdLodCcW2ZD82RSQJbQ4aeAfW2eUX7pB4nSaTmI3eUUY08LiYih6i0l5U1gIm/1d4nPQ9Ja6az9LFmEXgh+lbiCfPUM+VJvc4oCW7AKXaZiBhqk1iYLE3sYJInwGRhxQ3bZFhswjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787697418; c=relaxed/simple;
	bh=R2RW5pEi+4IwQCLmM98x2/p0+Jclx2FnG22h0fGoNB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jERVN2HlyvA03BzNtLkYcZwEuUXXZn2MbcrLgUXrzuS5XEVLyMD8IRUFbUGtcYkrJ77uyJQz9j/FDfRjuzh7QUcT7gyltMCdzxEWFmJ4TuE9sPqEdkxKVzWDpkVIaVCU8GQL1cJYd8RYRVqLoPgtLTID/qzJjSwjBIHYVvSps7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fD7MP7rt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lIHxgEDM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fD7MP7rt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lIHxgEDM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2E3D1400050;
	Tue, 25 Aug 2026 18:36:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 18:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787697415;
	 x=1787783815; bh=s/2tTDskiJbQKx6nIvm9Cy5+8LHn+oeOc/k3qCJGzl4=; b=
	fD7MP7rtU+wHBCIi/3w1Oc/fH5Pb2uMNtscCCYE0e2c42S58GMYnV/SChQWDBurH
	c2o/i/ftDOnyzWZdBPnj+sQ6sMPCogFz1Te740bTpeT5PwQ5nGEkD9doBiBTNlxA
	2tXkVlDCrvCyamUAQYlXAY0qXkGRZ2PG0wIslnaJ4wDWFlLS30ohuVud+0gc5sFv
	EP3ntVUu3S7IscUgZyreP+44ReFvNJoRfTK6kEplDNPH3PEjJRABjJ4QpGmtSpYn
	YQBSStXQTduE3ETOTvNXVZb+6tce1BHhxzlcTM1bqqmeXuSvAoBz+OL8hiKA0q9P
	WCk6/EHSIRwPAuzm/3/MLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787697415; x=
	1787783815; bh=s/2tTDskiJbQKx6nIvm9Cy5+8LHn+oeOc/k3qCJGzl4=; b=l
	IHxgEDMT6BmOQFwYa5v2Tt6R/mj9gG3AmHDCGCjcIzmFi/ymH0I3xJ/VHI6jKJwU
	5LQ4Qwiml3YwE378iBgjszUzLe2XMwLaDiFBYrZZ8Uz5gMDlKaIgsOohewgW6eQi
	rkAcZBbiFvXwlwpmeiJpFQ/Ih0gpfjX4KX37oaYXzgUr4kFAX2dnf544jIMPQ1XK
	cIa9JIhxyAeAq9w9zc2TGHxtCcnog51wvNh4gsT9uVZiJQwkfdlwhHK24xLTkdMB
	OgbAehsWp9O36VRqk4gktxptQaRWIbC0YxsKmfTDN9i9TxUaTzdCvg625Z6crkxq
	xL22nv7vf2l/1gd0t37Xg==
X-ME-Sender: <xms:BxmOaqjfZSl4U2aUvQqEhSsj6FrPbmr1BNww7NdfwoIcGnnI4cWGfQ>
    <xme:BxmOautrov1IJjbO_Q6huyM-DYE7nVoDMHwmuiEZ4JgCKTxgjNwqQgnLA0AJGKqSE
    dbNNVbTzlHUyFVmW_H2-uWnW1V35Nbm1E757Qq_DNDGKLiqJxkN7XM>
X-ME-Received: <xmr:BxmOar5vhHqClve8hf_X7evkgRNHI6rJOWcz0TmRJOldE5rLin6B8zsUsu7r7q6iNNFoSnpfWPvqbCScadAe-C9ZRo-6ya0bSA>
X-ME-Proxy-Cause: dmFkZTFPrKehXmbcxbIIkuw7TlX3+JabXUY7lIdG4q5QVT2dFQ989ShpmQC9eoaMX46UW9
    GcJvP1aytEOJQConDVcc6d+71YICydMPmvAsjbd3hUfNorU3cGW4/cZjsozIox5IV2DRPS
    S2hJTALU2Ib2pXsJeT5cDzv0ihqurQrctT91Ort72A8tVw0h4j2qb62CbEfRx51M6TWe3B
    V0jlWpBHhMXG2Po2Ndm8RXOdqmnARg8RWWr0vo38mnmnjihtda8/zKBAXtQ9PR5jcLqmZ9
    i+Ixqpg/G9Zkv9L9pupvHrdyD0uwEXhEK/7yiBMcCWq/5Gfxo2bIn+i1M2Isd2tRRN8TMa
    5ELr/Qtdno6ymrtlbPTWM0rRsCPm0iw4AFtMGdT0R5G9Smkzx7qNC/d1oKLdrvuOmSqnsh
    +ur2P+r5Osl36xa/kfHCQxJuxg3jQOGb8SaJl7UgrDUvEl85EvxjbIaSjpFCZVzuF6uBfl
    wys/AA9zIt9+x5Q/wxVlC72kUMPiqiy+FHwvew89u3mEZ5VHSJHxp5xiR8NBEVhs3Ykk3w
    cTaSIfbaRU9gPSpKjGlRinpEb2cS6WWWugGWAvWyt0jt6//jb7huQxOkLemWbuPK3mPiid
    KKSOBdqI0+RujBYvBXA+S7ZkJu/4/BVpHME+AxlvMnx9NkbLysP7O0HETjeA
X-ME-Proxy: <xmx:BxmOaqO33dFZoTDh1dxGYD2EgRGq89ja6T5FFE0-aZhc1Z2_ZZwcog>
    <xmx:BxmOaptxHZnb-pKY1hk6Wln0JlUT30dLZ8Z_vZ2QDugU4_fzIBu-0Q>
    <xmx:BxmOata_rllUb3GlP5fgZExD6B2k154Bf-g9NcHb2iUfPT2FGb-LuA>
    <xmx:BxmOarxoEqt34iJ8ixeICtgF3rdnf3nTPVsjM_dWinGvvTpBA9M08g>
    <xmx:BxmOan9hjmnILoQG1E2GybtaIhnh6ZVNzv9toVJxGhsFWT9GeB8N2MCu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 18:36:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Taylor Blau <ttaylorr@openai.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 5/7] trace2: remove use of xstrfmt()
In-Reply-To: <CABPp-BHxpt1UBTY5LCn9OFMZ6EtOcUPc-61RMWvjpjDBmv1rzg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 25 Aug 2026 15:14:49 -0700")
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
	<7f0bb405ad380fd35ae6381961ac667fd7e5dfd9.1787684181.git.gitgitgadget@gmail.com>
	<CABPp-BHxpt1UBTY5LCn9OFMZ6EtOcUPc-61RMWvjpjDBmv1rzg@mail.gmail.com>
Date: Tue, 25 Aug 2026 15:36:54 -0700
Message-ID: <xmqqy0dtket5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Tue, Aug 25, 2026 at 11:59 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
> [...]
>>+       const char *redact = ":<REDACTED>";
>>+       char *redacted;
> [...]
>> +       memcpy(redacted, arg, prefix_len);
>> +       memcpy(redacted + prefix_len, redact, redact_len - 1);
>
> Only copy redact_len - 1 bytes?  So only ":<REDACTED" without the
> trailing ">" ?  Why?

Yeah, if it were (redact_len + 1) it would have worked better, perhaps?

>
>
>> +       memcpy(redacted + prefix_len + redact_len - 1, p + at,
>> +              suffix_len + 1);
>> +       return redacted;
>>  }
>>
