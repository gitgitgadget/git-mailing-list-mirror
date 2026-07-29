Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC38424D47
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361897; cv=none; b=dPAhs2FJXmf2s+HvLW7iaZq5oW4dWmKcQftfIfYukbjeX+ufhHE/CQ/qAxkmXMtF1bAkIzdBdP7JMZ7BiQexM9YEBAcpxOvWbdcI1BuBDXKLqRuqoe3itqP6zBYDYJGHKD5h5CnqcRqU0KO4OSXdCNd/ha36ZvP/LoLi33U40q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361897; c=relaxed/simple;
	bh=lw1uX1Jt0QHhGis7iB9X9hGDh5QiPGzKn7xsg7m75/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TuPVwdoeB0Z9orkL+a4QzxUVFAcdoO2qRJ7FccDX33BvdgVJfIas1GNOuRGHA+EgzvxddqPoxjFMbVCNrN/0b6T5DVfQd1SJVXpVjxUTdJUe5WzV0+HKMqQpP5/Cf3IdQQzGji2Vgdsnh8PrkCkiItg7nHWocxT9PdW4hZGblfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IL68ymt0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JtzxojLY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IL68ymt0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JtzxojLY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCA85140001A;
	Wed, 29 Jul 2026 17:51:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jul 2026 17:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785361891; x=1785448291; bh=tEENUpjf2t
	wkIr5MP8QEBPyW3gUJ90y3jiSC23DdCNg=; b=IL68ymt0oWtR7Q0lzBMFvqlhaX
	cdf+F3psaMZ1A6ISoJzRr8GG4CwQOOSmpRtoREmSShuxzt6g1s8d3cW08BsMAQLq
	TD/PnzvzgR+KEb6AWqlKBmEVaV9dCaLvtIFGyunQrklynvwl0RXL+jKSuHZ8TtHg
	vWlp+g+kIamEnZwCZg4TEqqkR+hnn/biOMITXUUiK9+L+D8nOeJWgykkZ6Qtv36i
	DDhECON34KflZQHzK0hjKIM5BXOI09zbCiq0E5lMqqs3jKivhuJDIvRiadBnzaDk
	HtGYGYF2a94IK+q44JYveV/v4E7E4EczUfKJewA6wuePfvhpjeTYSoL79jKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785361891; x=1785448291; bh=tEENUpjf2twkIr5MP8QEBPyW3gUJ90y3jiS
	C23DdCNg=; b=JtzxojLYUf9LwXtt6eKsUl0C2XSZZm1iuPW29VH5AXvzKHI9XjN
	7eyXNLlTxMvl76dNPkWxaa/kLqJiCmjwfQjSWrM3/ov3tD8jrpaLI/mGEl0C5A97
	SEH/YcYBIccekhbR0yiyj8bbNDGtgDqlP/8PHuKjOdt9DmcPyJnajbVr7EsjoYva
	ANkPPfSVhkMq5uzOVLWvXru560B5hWWsP77aiJBLz26rwwq7oYiQJvcqY4S6VJXK
	PKC/fD0wxQfZbOxwpATCY+88AxkkJZLIihtkFR/0ceg6bF6zJ0zn8VdMQyNmAPRb
	Ak4a2Dl+Rg2Hxy2qJxQk5WRH1V32gVc/dYg==
X-ME-Sender: <xms:43VqapGFf0tjyKjYZ8jlzPRl_XaxWL1jqaJrLaqs7OPul5ScSXAZUA>
    <xme:43VqalXlJvohFQhMUbVtyF94mo2ML880Oi9o2GGLk0shwqeRtN1N2eQrIDWyEQwNg
    7bkX5C0AgFp0p6zRv824qOJKb-zY9z3e_ONsij4IUW-nV8EAZJw>
X-ME-Received: <xmr:43VqagIR4AJPKyBKdrwMejHjQaqEJSJt2pGTrSM6LI5mdph-Fw1MHV8gcf66N5Td5emAoEgCPJrN0M8gQVnhJ7nv9SkPd1QNLQ>
X-ME-Proxy-Cause: dmFkZTEkHHW5iJym1kp534t84KvyaFnPSxd5PL6y2oiOV1ee5qZwVoG43Y2UOvWfWdlWbQ
    3c5p5egJyk3ISxwE8IkofXq28sfZhrLS+tsGYbSEOGmn2Wsjw49pkyUuIsU5Ay4NXDs5ko
    JWoVrwlzH+bllwdtaTUbP6Eh6JeOs6t/iNW8Ni2jiYKEy12FEpMFKDT2Pu8oLRSPholNiG
    SrkJC/B5ybrPIU7uO9iWLL2M5DR8m+/l2XxN2kDtenX9tasmftbAHM6edWiVTkP4M4klRJ
    k0Tr2MQlQG46B50nTk8YMdP3JjZPfjElEXlOD4elA4mgRm4VhLCFu8s3OS6lEnunW74mrJ
    1Lx1fdJrzyyr9xUB2v/GmDMNlMLol2NMRSrKr+18flmuG9UcX8z8s+BM4aa9xJFKFWnnav
    6/v1QTM3/k7lhP22YO57F8pc0AT9L2qlt8wfaBiQzGX2jCyDbkEb0DoD7qaZboVwmRGbVd
    K9fdQA+poCRT8L5emw7JFamrGBHXLA5vMKhq5vRH08bKUydYUXpfRDwqXc8LaOn8tsb3Pf
    oQd2bHg6MygjvGGJoNUMDsJMlAQljPuftLmdpzHcfT6ZPo1vTP4vdPtPV1FDZHSQ/DQRTI
    jqdbWOhMZ25f5/e8RFaRYm3AIHzpgRsMKYKw81HRHiNItWD64wrUnafmSNGA
X-ME-Proxy: <xmx:43Vqat8Xp8vktCxad1GNmVswZweR014tANG2M4OUPmSKLjzP57sf_g>
    <xmx:43VqarK5bOZ2yUye5l0IM0JOSUIhToARQXKegWgqk52_MdE9Z6WXRw>
    <xmx:43VqaqlKz6XSnSbNwh5pSYSDy7JYf3cVAFQeA_mDQMlMwVA9I0PhdQ>
    <xmx:43VqanOzDcDfZt8OPKJJXmtaRGaXixj9aQr28Grtk0B-Ppy5mExaWQ>
    <xmx:43VqarrNnzm2GzZxc8mUnPPdqlVC9-pDdjCdh-eqIDZZx1W0bFtGtlwE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 17:51:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] sparse-index: avoid crash on intent-to-add entry
 outside the cone
In-Reply-To: <pull.2167.git.1783345853272.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 06 Jul 2026 13:50:52
	+0000")
References: <pull.2167.git.1783345853272.gitgitgadget@gmail.com>
Date: Wed, 29 Jul 2026 14:51:30 -0700
Message-ID: <xmqq33x1o465.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When collapsing a full index to a sparse index, the recursive
> convert_to_sparse_rec() walks the cache tree to determine if any
> of the cache tree entries can be used to represent a sparse directory.
>
> As it goes, the method tracks how many cache entries are being represented
> by the cache tree entry. The cache tree node's 'entry_count' represents how
> many cache entries are covered by the node.
>
> However, this value can be negative, representing that a node is invalid,
> and is no longer reflecting the number of cache entries fit within. This can
> happen when the user uses 'git add --intent-to-add' to mark an untracked
> file with the intent-to-add bit to avoid committing without finishing the
> add.

Yes.  If the code were not anticipating this, I can understand how a
bug can arise ;-)

> Theoretically, we could scan to find the range of entries that match this
> directory and determine if they truly do have an intent-to-add bit and then
> collapse as many child trees as possible (the ones with valid cache tree
> nodes). That would be a non-trivial change for performance-only benefit.
> Since this combination of the intent-to-add and sparse index features has so
> far gone undetected by real users, this scenario is unlikely to be worth
> such a change.

I tend to agree.  That does sound nasty.

> diff --git a/sparse-index.c b/sparse-index.c
> index 1ed769b78d..c1fa231a89 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -113,10 +113,17 @@ static int convert_to_sparse_rec(struct index_state *istate,
>  			continue;
>  		}
>  
> +		span = ct->down[pos]->cache_tree->entry_count;
> +		if (span < 0) {
> +			/* cache-tree entry is invalidated, cannot collapse. */
> +			istate->cache[num_converted++] = ce;
> +			i++;
> +			continue;
> +		}

OK.  That is an easy and safe cop-out that is much better than segfaulting.

Shall we mark the topic for 'next'?

Thanks.
