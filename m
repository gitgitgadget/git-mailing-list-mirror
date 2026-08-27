Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FC476CE7
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850040; cv=none; b=av/nH0dovw4n4Fe9CRL5zXMxfsX+VFdvelJ5IRUcoHBSu2PiH8iTcQiUZhRXJ8cCntniHLhsFyycgHGB0pR1EMKIvsJM2Bmwz8b0Yf6yRwhh80bQGkdLj9mpPS+h/nijn1opmsOMyvHbL5rGW2PvWRgmur41HOY3KllGyAuZCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850040; c=relaxed/simple;
	bh=8q1dlLnlzrheKpn69qgd1AkAdKgDRc6PDMrJk0nKLrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIOo9P2U7M7rnRdLWiyIxG0KHpg8W8V05mUGXx5qX2JZ8ZTOb45cMHAX9tt52nbA8rHWtRNWm+a3RHsscmh7b7B93UrCOWRrjuE5U5MQM0NBha5l5YKW2y6ydXQzx0YujdWzzNzgvkhsprSISd91sf0vaQ1GAf7lDmxNdp/wJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hxkVd7Rb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xuw60WrD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxkVd7Rb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xuw60WrD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A69914000FE;
	Thu, 27 Aug 2026 13:00:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 27 Aug 2026 13:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787850038; x=1787936438; bh=keLXMc56A+
	Z87wCiMrc31VGbeFKsZ1pHTGsw3RUyhw0=; b=hxkVd7Rb2k37b6q02LeNKgl/WN
	7LXWMixnWkhbjq4aRXmyj1jA2Pxmwkc/RIMGEJ3JJvXw6t7FeVoFWeHUiAQOMa+m
	rUKEvEJfAiyUnrMQHaVIjf+exxidRJZXb7QXDKJSln/YfuwY2IEv+E5sDzLKB6pi
	uV+3xE84/N6Du31m5C/Pufl+6OTQjWUQTOxVF6MetLOOGlF3jTQIp/XcJC0miH2I
	3REu8Mki62nG3Dy3ttnmvhhO2cxORIQN19vohltBustZ7A4r3thVbLLQKviClEeX
	ZwQDTlK922Z7JW4XgYzZnELAVZhIHin0STKzWWvDPtIgKf2IGp835fbIEsQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787850038; x=1787936438; bh=keLXMc56A+Z87wCiMrc31VGbeFKsZ1pHTGs
	w3RUyhw0=; b=Xuw60WrDXvhxCYXmHzgJJ1cOnEKb4X58E3ESUCGZsyjCVMwi8TP
	PfisDc0Jk+VHnaSbcqJsMgr2KtvcdQlFSggTDZTr+HMg2yG05GuT7iCLIL6P+TEN
	Id1QYJ3ZBEoMdy8lOiHE2QaMxoy8UXSRhJskB4gc/0OHMbJoKME4T6l82u6/rgBn
	N0olRmtrgirViin+skmAyya9oLjq2Mx870Ihd7rF6z/hYcuikB+tkJn4xHzRdsq/
	dO47f7pY6Rz9MNncVr4PyUrCsIubvRwXRElOKHiThn60QI/B/Z3IKjlZayNgrnnt
	+Ux8RpLVIn2tjrYha8rI9B7TR9j4kfRFnDA==
X-ME-Sender: <xms:Nm2QahdLc7wToixSxi2kcp05qbyM_qSkyLPJcVvpevD6swg-0w_7NQ>
    <xme:Nm2QamNj8GCQDUnEWZ3G7CkDj-fx35Q0tfqvy2CCZzNBRm0NAOKP9Xn5j5I9xiysK
    ycEpUJ1OnVjcK694JuVReSkW5y4-vOUh5dKZqdtxgE1bLQDfmzN4Rg>
X-ME-Received: <xmr:Nm2QavhQ0yaqYreUMvb2lJr6mnBHGmwH9t1rPFikM1CQyoLavyv_AnDI4yUKI8HajTqlqB3kKCSOQSrJ0LXYcLve4Rpn4ycwlQ>
X-ME-Proxy-Cause: dmFkZTEYmDytq922yXb4hZTtZL3pQSAgNcKg5izpqyYC8fSiwn/eB3vd8z8AOn7OkdAuYM
    eW3DGQe7xDLLK8+VKgniig28qf25iptoX4Vvkh6PWRQtwKvI5bTwY0OlKW7HRThrPQJsAv
    NHsWs2XBvZ3u3IVDkESMSmwgczplWng2wsc6PmKlz08JrRm+mCkbsFtlo7oAW/zygpZAfM
    EFVs5q+ELxkml60nZsAJOmUqEdMnc27mTPOeKt+OMzrpevvDgHR2/9RQncFxp1pO9268vV
    rzADhhqsmCTcmXCoNfUu/svkO9cNNyLkfyZr/0fysMixStI1rB0oXBgBc43gzLfXB0iVa3
    Z99a9yKI5M/jLk160ckCIpby8Vp1y/WXMd1YGXYVt/Sy9VhwCsPmoTNnmiaTmTjLzWh0NZ
    DIfF6/zGM7t9tbCsWRlggAmOnakUy7TUL1+J8aprFsHdUz76Q5Sl4iEmUHHnN7VYP4nQgi
    raZ6MUfCNQvfnnQak+0lAtc3sc2MloEcJ/AYXi7NEyAjCrnnLa5r9D7pVs99qFDfnvIqeS
    FuLdNAQTdsFEnCiJwGnEHCbCPt4Hwyk0fjmw2AIDgLPHJz9snnYCCF2oSDlhaFTmQNLhWj
    Gq1azbIBlklZwDyVnP6qL4q2B78rWLr+SceA9B7hsqO8jIKrDkIK8i0laa7w
X-ME-Proxy: <xmx:Nm2Qap1XePAl_biUmu7WDHX-nEC5IVo2meRL6GmpymTEKPUk-jEP-g>
    <xmx:Nm2QapiR8RmdECSVxriEc5kAHEWe0T0xhfN7cm9wbO9cgATBrmFenA>
    <xmx:Nm2QapfbX2vdZcy9zcOiZBXWgvjUVzlq6TjX8Kr0snT95kLfu0QBag>
    <xmx:Nm2Qask8OcAlZK9WvQgAyWaaWn8cDwzsF72FCeJrY454pOmtGvbTsA>
    <xmx:Nm2QajBdcDDCgG2v3t9PwjABzOQJ2OBgp9-7Edv8Op1RfO_GKxnE6GOt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 13:00:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3] worktree repair: detect relative path in .git file
 correctly
In-Reply-To: <CAF5D8-vocLWba-rvKxy3WWB1ZHTh1+eRcRWiMqv0M-CX56Y71A@mail.gmail.com>
	(Yoichi Nakayama's message of "Thu, 27 Aug 2026 23:38:15 +0900")
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
	<pull.2205.v3.git.1787344586470.gitgitgadget@gmail.com>
	<xmqq8q5zyvwd.fsf@gitster.g> <xmqq4ignyv1z.fsf@gitster.g>
	<CAF5D8-vocLWba-rvKxy3WWB1ZHTh1+eRcRWiMqv0M-CX56Y71A@mail.gmail.com>
Date: Thu, 27 Aug 2026 10:00:36 -0700
Message-ID: <xmqqse3za47f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:

> Are you concerned about the lack of explanation in the commit
> message, or about the functional differences between
> `read_gitfile_raw()` and `read_gitfile_gently()`?

Mostly the former, i.e., the commit message too sketchy.

I now understand that these two functions need to be more different
than just the _raw() not calling strbuf_realpath() and the other
calling strbuf_realpath().  The functional split is fine.

Thanks.

