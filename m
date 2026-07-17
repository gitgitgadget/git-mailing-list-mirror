Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87F26FA4B
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310824; cv=none; b=K7LEHby4qa7K2A2yjB38vWofiPJLGqLIZYN/nsv42wsPB9IZAUEpXyu6QAcQ46uJe0seP8nwhgphsBkgTdcf7lBbKB/AGClgST9lO9PwOPW1pAtGmhUTUW3iTZgnYAwaxZwScVxdB1gFqRVy1Vv04ZnQUbwK6Q3D1APDtD+he+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310824; c=relaxed/simple;
	bh=UZfcbLqmvlw+jRVd71Nn3X22PBHbhyDah4mVQUjU7Ys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qk+mKF0Vidntm/aLj6emU7zCerYvxmPBp8xYRUSACT81bmwKXp7Zlpyw09UTamK4os0l2AsdSa6yYYOStNSUcex0zYiFX3+ZM8GHFPxVHPz2O7g51M/SKV3/1Gn2hRRE7ty3uJ9+yIRsFQW/zkLbLz/d1XCXGh+TctpvX0ywPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w+OgFmSV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YeBYXcpc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w+OgFmSV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YeBYXcpc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23D8A1400124;
	Fri, 17 Jul 2026 13:53:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jul 2026 13:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784310822; x=1784397222; bh=rQF7qGSg/9
	4omtgZ6LpaVptP+RQqLAhfkHn8ahZLVc8=; b=w+OgFmSVvsE2hoQTFJ6aKBtKxO
	sSKcjMI/C/LCtfw9FQdvdCnVB8ixzhqhddiZY72KjHiW3X4BXEsVrp/lw/7kSgJx
	gnn0AwsulO7tmD8tOco/7X/goTAd4MaDI1y5qvsobOKqjA8QkX3Z2hRGrJAVBfs2
	9wrlNFAvBeQ3aqz5Fcy3ywyATwKYJ2wGh1r6F+WtZGZZq5YzzQ/HumkkLa56F7Vb
	vP10PRb+dGJa6q7ajXjSiqN5VCCLW7htyYku/dTpkJOikjImpKnIUygpu9rJM6Mr
	yAPj3a2IEROv4LttrIkc0ajlDEsQHXnBAdy+anQ7q8U5M+J5LL+rty4/e+RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784310822; x=1784397222; bh=rQF7qGSg/94omtgZ6LpaVptP+RQqLAhfkHn
	8ahZLVc8=; b=YeBYXcpcVHCTc8Wl1ulffmOfUbjoEk774nThDSnHWbuolDoikV8
	pTizuQAi/kGKIer8pdBr2arF/J+M4IhD7D3h65HneRxqzkN+Z63ktZQmqTDMD1Uj
	7qAlXp13QeEhaIZiDo4Qx/opKqQ2zFAlNqt+Prnt3qmeymENeEJqPJ+41Xi0Y6qu
	WHy/2JRcf4hIkvqXEuso1pJyqqaMGxWetIKgsf3uqm2cF7I1JAOiAzfPY7sORl9o
	IVo7UPVxBoClZ+R7peRd3luBeb65R8wBcwbUcRzfEu0wLo9uVd4dMaX0ESOUMSoh
	S+wpURYArBDL/6diYvyHrS2x5zIOiiShj3g==
X-ME-Sender: <xms:JWxaagqAGwVVaag3wcLc_8XGP4u50UctR6Lc0bgwVMcmLNbdqiRODw>
    <xme:JWxaatpAJfqCe9mEM3PdT3L27YqfSDmPpL1Xc48J9VrKTY0xFszbmT7r_iEe1iCKM
    AMSyvE5Z8qzcx30RDlGGOfdYzwMKM-dD31o5XiBx99RyxSkp0nz>
X-ME-Received: <xmr:JWxaaqOGAj3lsr71TT069Hl2iG1duhx_1ESTlDIIR_BDJ7oTY_1GuCIzBgLgo4JFZrwKR1yGmCMdl8nkkcbWO6ydi7UKMhjipfZiFT8>
X-ME-Proxy-Cause: dmFkZTEp/sB6hLqg+8hVHIdRTAclBLukcB5r666+OHAPVnih8pQigWPaQJpq/VbLkcO5Tp
    77KOOiPhmDHU3NTt3Y3aJLVEvEtGfZA5UHWxcjL5ys+j3s1a3w7T8+VRounqCqgzcgwJZd
    pQ+lGsV/wQvAB3dM8qI6VFNGijyFRiTTTZfpzRrExmtaGNuuWZI2PpmUNfl4z7KQtEs3hV
    zcVZp/IpXte9j68xAC+NYMfC9c65pIU+xJILOsBVre5W2bpee4uMNwDV0DGq/nAIymLBdi
    Fh/NwkQd9iF0f7Jlq/YlU4dR40a5FxdTL/DAK0wB0TwnkcJMvGHiRY4wN8qxYuhWgv37ng
    mt3M//ZAnRAhnwVW62ATN+CJlGcoRwCkh2J/9AGjJcLuAt0t4oYinriSVYMm5bof5JfZqE
    ihs8cB1sUOefdegYTS3ttgsK7yisjzodfg2iZDqN7ugwVOLzh7RlVPIsyRVDP4NtJW7IFQ
    RN93P035BuCfHZuFINkFUSN2J2mKdDGGU7hUPr/ENINCov2HO/V9tMnq8yHL0+VvpCBZ+C
    6RnkwmSOBtIkP0TzU6F0cHvkeIoN12EVd8JCvKL/q7Rxw4+1MTxrHW3hjEmbK+cKdJvhqC
    gUGpNZ+fzAv6XAvMYloNFgBAzofEZN54a/daF0FoBK7Cg/2xUQNQh6QU0LiQ
X-ME-Proxy: <xmx:JWxaamzTbZBWjmKLt5SH7tazT9Gv9XJfs8BNkIgKL6h43vckK-3y6Q>
    <xmx:JmxaartCh2d7O-yiWVgcgmDSwJJO1pW3nKKrfPEHcw8OeIcVetI2ng>
    <xmx:Jmxaan65hZcgpu1xKCPOImPzvtWWmKpbxXeBWkZh5TyZtF-W3vRLtw>
    <xmx:JmxaaiRCqnSHx8FtVEK-aCmLJ4pOVZFuzApfyxoEMTXittVIMTGcaw>
    <xmx:Jmxaaps2EO9eUDR3QxmAbYXmEesT1S2Jpntn_aEKRxhOiZ-KDLCFv5Jd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 13:53:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v7] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <xmqqse5h63js.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	17 Jul 2026 08:25:59 -0700")
References: <alntPJy2VwVK75qj@pks.im>
	<20260717103454.62750-1-gatlavishweshwarreddy26@gmail.com>
	<aloHDhoerEhIXxFA@pks.im> <xmqqse5h63js.fsf@gitster.g>
Date: Fri, 17 Jul 2026 10:53:40 -0700
Message-ID: <xmqqcxwl33kr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> We've seen a strong uptick in threads that are obviously AI generated,
>> only, and at times it just feels like one is merely talking to a prompt.
>> This just doesn't scale well, as it leads to constant iterations and
>> back and forth without much thinking being involved. So we require the
>> other side to stop every once in a while and invest the necessary time,
>> too. Otherwise the community will simply stop working, and that doesn't
>> serve anyone well.
>>
>> Sorry if I came across as harsh.
>
> Thanks for saying this.
>
> When viewed in that light, what the v7 patch does is extremely
> incoherent.  It gives the impression of having been generated by an
> automated assistant and sent without human oversight, or perhaps
> drafted in a state of severe late-night exhaustion.  For instance,
> the commit message claims to have lifted 'max_revs' completely, yet
> the proposed documentation updates still reference a hard limit of
> 64.  It also removes the local definition of 'UNINTERESTING', even
> though the comment immediately above it still advises our future
> selves to migrate to the shared definition eventually.
>
> It appears the automation was not used merely for structuring the
> reply; the changes in the patch itself show signs of having been
> generated and sent out without any human oversight X-<.

By the way, the two items that follow 'For instance' above are mere
examples.  Addressing them alone will not suffice.

Like you, I have no desire to interact with a human proxy sitting
between an automated generator and the mailing list, relaying what
the machine produced under the guise of having reviewed it, without
understanding or thinking through the implications.  We want to see
changes designed from the ground up by human minds, not synthetic
slop.

It is fine to use automated assistants to proofread what you have
produced yourself.  To judge whether to adopt or discard their
suggestions, you must possess a deeper understanding of the problem
domain than the tools do.  At the very least, to employ a 'human
produces, machine assists' workflow, you must first compose the
draft yourself before asking the tool to polish it, which inherently
requires sufficient domain knowledge and forces you to think about
the problem.

In contrast, blindly relaying what the machine generated, while
claiming to have reviewed it carefully, is something anyone can do
without even realizing how superficial that review actually was.
The 'machine generates, human reviews' model is fundamentally broken
when compared to its converse.

Pardon if this sounds even harsher.
