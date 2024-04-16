Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AE36E
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227060; cv=none; b=eNewhpMr6fQhxx73XriwsJUFsTq4EPWwFyZl4cUIhhBSX7knQwBD3swM1eL8fRNvSSTJeiShfKHyoJVzLFU8yj9Ib9w4Ts8CO0vDa44jJVqQtw9lyQcdsxnZgumnK6W3IGLbE5ee+N60PXbn+az4EkSfx+iR9YnQLFhN/dxKA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227060; c=relaxed/simple;
	bh=CXnwef7X1WyaxvMWUJVHnWRl2WAE0rFSOXvMBw9SRaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VjPc7zHO9+DsQMdpzFmRKybijGT6CR69yzRgApV/hMX4QGHtbCjNHw8817m9m1GeNBbDRh7a+hU8SBP+QmB2XMNSOkrGzBazJAiEcyeXp3RmIsEfXVe4jxAeftyKy2WZv6ALLOnlkMdI4Bp224VY/yhF4l6dnmb/mwi2SSvuDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tkFdNydP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tkFdNydP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 84FD12B76D;
	Mon, 15 Apr 2024 20:24:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CXnwef7X1WyaxvMWUJVHnWRl2WAE0rFSOXvMBw
	9SRaA=; b=tkFdNydP9vVWA1WeI7oDzVRENcATx5BnzKDL7923xhNlaovQll883J
	SPA7CA5Ln3CoDpbL/Y3gjiqdQimEegJ4Di2xAyYPe4gog4bICLBtDJkYlBk68GIo
	T2Vemf3At51FvTRP4dNR9my6kE1sSfkdM0lnssaUJEvb4E9tA/dfk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D2402B76C;
	Mon, 15 Apr 2024 20:24:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85B792B76B;
	Mon, 15 Apr 2024 20:24:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  avarab@gmail.com,  christian.couder@gmail.com,
  me@ttaylorr.com
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	(Josh Steadmon's message of "Mon, 15 Apr 2024 16:20:05 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
Date: Mon, 15 Apr 2024 17:24:14 -0700
Message-ID: <xmqq34rmi28h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A82B7C6E-FB87-11EE-B164-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> The Git project currently operates according to informal, unstated norms
> when it comes to making bigger-picture decisions (above and beyond
> individual patches and patch series). Document these norms so that
> newcomers to the project can learn what to expect.

It would be a good idea to write things down to help newcomers, but
the thing is, that we do not do that kind of design discussion +
design review + implementaiton waterfall here very often (a notable
exception was the sha256 transition design).  I am afraid that
"according to informal unstated norms" is an overstatement.  We do
not have any "process" concrete, nothing more than concensus
building among amicable parties.

Most of the time, technical decisions are made on individual series
and by the time the consensus is reached on the series that it is
good, the implementation should be finished, and there is no
separate "implementation" step.  Newcomers would probably want to
become familiar with that part of the decision process before
joining the "big picture" discussion, I suspect.

> One particular blind spot for me is how the Project Leadership Committee
> operates, or if that's even relevant to this doc.

I think this is the part PLC@SFC is supposed to be of relevance:

> +For non-technical decisions such as community norms or processes, it is up to
> +the community as a whole to implement and sustain agreed-upon changes.

> +Anyone with an interest in the topic is welcome to discuss the matter. It is
> +expected that all discussion will adhere to the Code of Conduct rules.

It is very much worth mentioning CoC here.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3f2383a12c..a04da672c6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -103,6 +103,7 @@ SP_ARTICLES += howto/coordinate-embargoed-releases
>  API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
>  SP_ARTICLES += $(API_DOCS)
>  
> +TECH_DOCS += DecisionMaking
>  TECH_DOCS += ReviewingGuidelines
>  TECH_DOCS += MyFirstContribution
>  TECH_DOCS += MyFirstObjectWalk
>
> base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
