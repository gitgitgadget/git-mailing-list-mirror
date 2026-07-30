Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20923B19A5
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443392; cv=none; b=V/41/CXkIyg6uovYx6nPzZ5H8CQUtp7viE+1dyJZIgn776gfkn3Ai0/zie+2LSfnoTJxGX8E3vMElb/mYJDLERbccwonFuvZ2iJWeWdAEu2+zI+nWlnzYQGqcLosF98C4Stq6fnIacbIugd5hYPW/skQHndp+WOrxp9sz+qxz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443392; c=relaxed/simple;
	bh=18nmPTjST3nwwE7sA4r+WttglfCOW8eJklXBvq36xbU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YA+qiCd/SHTElQXzrN6F6PxE8i7Tqtqi93RggqIt8ip4IR175DD6dkObfjFW2nNP0SKjkMEvjmr+WE6aMZm0O+BvBlc3xEz8ufl6xvaUCIgjwswn+WW2obGVc6Hglj5l94PGlzBCSbIaqPq+Dro1bthwNyrRZRI5NEzfGZ0GsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hUwGo/MR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUzj6+eR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hUwGo/MR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUzj6+eR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 57F49EC0128;
	Thu, 30 Jul 2026 16:29:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 16:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785443381; x=1785529781; bh=suwG9oyPCa
	rz1xQMEFwxHoa1RCsu/3Qrxyw9sf/6Ddc=; b=hUwGo/MR+KjEwJcPwfGNCc8yGs
	fpEp7EkiQ6ogChHUavO4nxeawlXaywFtFlEBgi5aoHiYRN7J4JLkb6XiQpc7QISf
	n+JlBeyqWVvBhUUVJLp1wFoSOVWmv66ZkKDgaBfrNCNBpDBQAzGxNK6wejCUJWAh
	+wZZEh1xGwZNB1vDaKN98GvDyxfr2EhQW2oRuDTBL7YGIJ2gaIWKKPgzV9AFpWBf
	j0vMOq7Z44uV6yXleEznR+H1Jb3HBTlISifdTZazK550iq4HKswk6jo39sXVTqIZ
	izX6ipg/rANXSjslsoD++TDcRU4v5WfJXpxjRLlVuPYD8ucCmt8xnLvLKQqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785443381; x=1785529781; bh=suwG9oyPCarz1xQMEFwxHoa1RCsu/3Qrxyw
	9sf/6Ddc=; b=gUzj6+eRYZWL6CntE7Up4VKMLfsr75H2pqrKN51qpRz8ANa6IAz
	aNaGL6q3Y9uJ+TL2PWF+Tn/rFwCzyAMOJojOpOmirmzDa48uacIFRcd19coeke4x
	ZJ1WDgSlTcUcMR1oWYL3+KbLQNbB4UP+mQVlLwUNI6j28M3+n6G3kG7JvFqYlK5t
	WdySvmdLKZSNI3Kjk7H09Zl1yjBv0UQr/4pGx7AQgYxtMIozSawj2RJOT3n42gox
	VlSKv48WRS8yLAtUek7vXY3y5F/HStE8VNGHG3+EEtGTzntIvNSGWLfQZ/HzUme9
	Mhss1aGd6iVvPpHk9qNtDoHHNz6fwNTIj6g==
X-ME-Sender: <xms:NbRraoj26YUM2KAoAiDDaUo8Kxo9QDf52n5Eob3tlhexLOJuZ2cmoA>
    <xme:NbRranDHD0YgDGpChBxwQsAPvTchWfAQmHPlVTZ6LEvCcA2fNM16s9gXmnsEJBh8c
    PTHBCcyWsvCW8wr--MQsoNUBKm-pussflJ_Q-HSjJCYDQXSHix7t48>
X-ME-Received: <xmr:NbRratuAbzEKIODKo0b-v2d_G5mAp4Qsjlm4TcPtqqr9krJjT0uBg_EjuF8-6Wo_AZdk69p7lqgObTQw5rrvTsgYDeulJaD3eQ>
X-ME-Proxy-Cause: dmFkZTFUOQR7PsZeXVMKlyvL+7LKC7VU2Fg7nAXLqpmBFM8mM2eLumzKHcrxDGXyCcJ4Wy
    M71dlPw9ojbvZMrfO2A+bp19bh9q3ISTHdjJP3IVKg65vgl5kaB2ei1MruRnPRgJmGs96O
    YtrDG8ER/px4NxYgK41Uch/xMvX8WkUTZjnLJpE5EGTm40EwMSkB5n96cVmKdhK+n4yWjc
    UTYPPEdnPay6suX5p/4L6N7ZQoQGh2WrD35/jFhbsM0uRAiSTyDRsiRsETamCV2/lv6dVI
    Zi0q9pSjLjcSvX+d+YXD8TeNrtloEL2VyR2YsvxhTtVczwTpxuCcytxstBvEbf4FADiYBw
    mtkbttatvhzXYnNgN76q3rGsfW0aSN7unLfnuQXFE/ZP4O/L9JqnViI3WIcWdG67qYf5vP
    MxIm/cU1PRRWqbyK7hMsLE0ancQqIQ0veqZ51cNWTjebYRZlL/nJVPHqtrqw/zKApxUojV
    gB0JlAi06FtXRvbFFrB+t/KEkQmvT6KNmCo5YTRFdUE/Cxnxt9+RJGYZWyMAj+ebb/xWST
    xkge0UY3cjyxdEo6x9243L2/Fm1W9utLXypdA2ikmGX4unoRGSrKdnwnBlkZ+c6aRLyJuW
    VzDcmsxaSFrPpQPlahbNNzhOJ4S965FbxssO8AsnRHnQKi1Pt/K3T/lVkpyg
X-ME-Proxy: <xmx:NbRrakbo_BXrxiEAZz_CRFTogToPvGkpNoCpuY5eH9T5DJ-E38tgIg>
    <xmx:NbRraoVHrFOdJvdW5uKvI-ZkYe0sSkPDmb3manEmgaQKFP47qXIG4g>
    <xmx:NbRrag7dz0rjwzLU_-R_GdgPJdapoRxMy4ZpWFIFbPvtULiL3-bqAQ>
    <xmx:NbRrarhlmGPwHRYCRhui8B3teIYnHxsCfQlxS0sMr8KFGa2JZcxvwA>
    <xmx:NbRrar7oZPTo_6A4_5CPmvp3szfci5HkPPuAR55xCAKUGTF8Q40EJFij>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 16:29:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/2] git stash drop stash@{2.days.ago}
In-Reply-To: <20260730034108.765430-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2026 20:41:06 -0700")
References: <20260730034108.765430-1-gitster@pobox.com>
Date: Thu, 30 Jul 2026 13:29:39 -0700
Message-ID: <xmqqjyqcjk5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Because 'stash' is implemented in terms of the reflog, it can accept
> not only a small integer index (such as 'stash@{4}') but also a
> time-based reference.  This is not a good thing.
>
>  - 'git stash pop stash@{2.days.ago}' picks the first stash entry
>    that is no younger than the specified time and uses it to modify
>    the working tree and the index, but then removes all stash
>    entries that are no younger than that specified time.
>
>  - 'git stash drop stash@{2.days.ago}' does the same, except that
>    no entry is used to affect the working tree and the index.
>
> These two patches forbid passing time-based stash references to the
> 'git stash drop' and 'git stash pop' commands as minor safety
> improvements.
>
>  1/2: stash: record positional index in 'struct stash_info'
>  2/2: stash: reject time-based selectors in drop and pop
>
>  Documentation/git-stash.adoc |  8 ++++++++
>  builtin/stash.c              | 18 ++++++++++++++++++
>  t/t3903-stash.sh             | 13 +++++++++++++
>  3 files changed, 39 insertions(+)

Sorry, it turns out that the collateral damange claim was completely
bogus.  We do abuse the reflog expiration machinery but make sure we
only remove a single entry, it seems, so only one entry is consumed
and then removed.  Consider these patches retracted.

Thanks.
