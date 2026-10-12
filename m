Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064648EBF3
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839625; cv=none; b=bcmW95Zj0tIbOldHz3uzFmKSQiskocEYBjDo/UxYJ3h2rXyB2RDsK37tCPT6HfMmv3iwW7HNECrDxLJZMowEZguMPgbKB6lndgkhvlqdRNb9UC7Xsj0Ql6kHuPVv0+GcH9YjOde/Rdv6QHWmNZyvzeXT/493ucQcO2XjordHLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839625; c=relaxed/simple;
	bh=ZUF/VH76AYl+vd4SLn5qIAOREbiytstN9yuZSaQINQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8MTvasVEE68IIDWLSU1zhlTnB+WZek4XyH892wLmOlS2P3/IYc+3j9GBGOtDKMRuDMycF4bo4cnD19P3TfpkyLj2Wr2uDEfMK1AlkrlPYFBaGgp70qrykNBIuW2ixGhxNMlaIfFNIJjks6vMDdiqVTfmMsHLKO3zwtmK3dYqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DN7T5ERu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+h6K88l; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DN7T5ERu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+h6K88l"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 163D3EC08AC
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:13:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 12 Oct 2026 17:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791839622; x=1791926022; bh=ZUF/VH76AY
	l+vd4SLn5qIAOREbiytstN9yuZSaQINQw=; b=DN7T5ERuEvA3id54hrIF/VxCUj
	VBPleXUV/X5r7pBfWrJsMlmqneOLxDAsvX28kfPgcbZ6d5gRuycI0bQRAZUHwRSb
	m8TBFlUU1JubirMfEQJefTAZt75j8shemcJPWSzKKPq8rxLJxo3Dxilcz/HsJi/4
	Z0FkvOj+GDTA9fPLiyUV4ZZqIJL3FB8bKpZtwNm5aDBrhdFJ5B1zixTF8F036C3r
	/W9vBkCMf5YDwDCCONaG2K3WmeKUIiF/bfDlf7dYxf/E2EUWX/o3ffm5Op9zcyRn
	s8Saxjsx9LOY32igiEwVmG+1erDhSqIyVLW0tU7jtj+h/r5TsYhL8pOkuvwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791839622; x=1791926022; bh=ZUF/VH76AYl+vd4SLn5qIAOREbiytstN9yu
	ZSaQINQw=; b=V+h6K88lhZ50y4xs3doNznXb2Rhg+mMMxWNnz3dx/rwxAVvbyyL
	16zW4JGLpRRnvkjWzZy7qchqLg6x/li3FIQcxA5EaIUEfB6GjB6QZhvB29K0DSZN
	7U+BG4RFQeTmtTIXkD8oaIuSBDeGN2h83VxpMHkUfY+Lo4eVcnA9OwskMr9RIeg3
	yin288Z1fw+NW34CqYJYrEqClLROVrsEy4BMJSMmHm/dpeR2lI4KaGNK2Ak/Wr6q
	nBCymxel7+PjHR4Ml0GWRUzGN97nPofsx1I+ebMvtkLNxOBg8mU4fSq+NIod6m1u
	pdgiPnRVkMYm6WiDe+QK4VjW+5EbQmRv5cA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791839622; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GqA1P4jG4diZhRDdNwAW9aSQtkrjU9gffjUcmn/kThmD5OM
	RX5qeMpDMNe+vRECPrC2q6ZgfUBU6Sb2B5AoXGPDqSqUobkWwdhmJJYqmz0UyHGo
	rM7cnNAPXBcdxBy1ib/wKVd8nl6NAnIX4m04AYgQF96JxwiGETu9yLJdPxRl/DU9
	Guv4CLl3mUOTvKiNf7vAFG0p8wkbbJ6oBypZ8KSUy3aQB4QDQ9ZjAlySErrXo0sx
	lIhf/MOSfdXbu3qwr0cbtQtkG4sHF1D1VyRyEf0Iy/F6fXx2jVNZ0iLX+WHy9d6C
	j22VvELsQhllLB615MBuD0KZDdfbN+Fi8hVjbjw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qunrt0Tr5ukiVqf4LDjAsmFvYw4IOz2ouoTEM0kglgk=:ZUF/VH76AYl+vd4SLn5qIAOREbiytstN9yuZSaQINQw=;
X-ME-Sender: <xms:hk3Navh8bB8SxAftXmiTdZkdD5clrc2RrATaVp9zrDJ0e2TD3hFWwA>
    <xme:hk3Nag-7pCtAF5EhRUMdE2s1nrjHdYGoeq_PnbV3mI5IGmGYZczVCQ04Rx1rDrSDh
    1sGGcHHroQzy0BVr2_n4fdKwAsUhjtIVoXy0l9fqMNBo4qE-A46M_g>
X-ME-Received: <xmr:hk3NajVPh4pPLdXV5EBCkFpyU6l-ZuYtAgl44oV1IGcfEbwx4xst--G5AhkEV1qFV1eCJzjhxsR3nzhYdI2w-LxYip1_L9MVG87U>
X-ME-Proxy-Cause: dmFkZTEKdAB+1UoAqJXx6MDlDCgxhVvjPgUh2CvCXVep8oZWsT5S9/MIqKk/4Q/oRtHk2/
    1yV6jPcAj2h/uYAbNrurLL1XG44l8QxV4RmNZSNcx1rtAp9H/q27cNVs61cWLQ9tNYLUfq
    8yj2tDkdQ0fYct5Q9LVWJ+tGJEZzhCnOuxleVY0JHGpAFVMokmUMKr3KWDRYQTTkS8MRSK
    XSTwBLBj92hTqfcI7BAWX/tBE6G1Li8sS1xWIpah6kZ82BtEd/o8E1Nei9CM56LZYws3b8
    DQ7VGzuRgKCyeds1TtshENc6QZJY3lcYIjM0K7ctMiNzdVj2DpibbDl5RxvSH3eCc5+No3
    nHtF1J/wrEazyqLvKsrlmjwYKC7mgwaObgfaqNPE1Y6EJfgBtvxf4BB2tXInObP8P1FRt3
    EhFf5OAvMMOsuUhysinDgXQ/Qm2CMFcEE8GIostYiOPBi7aJzWdfxNrCPS0H/9IIgg9yqy
    4YxNEKi7oXzs6D/vhYbLC9sNlQz6QPCe9wv0/nIg5n8Iofws22pZJpJ9vwgOh7A+oJhj1B
    otL/4IDOk+2UIzcZQhQ14xiczTPKteoq0nAMLGT82JBSPLy8nyJPCxBiNtOSbiBoJvy131
    6mOTstNYoXg3nYmSyof4TUQf4S7toq2RmZF3Xr12TvbK0w8vxFH1o7gV1gPQ
X-ME-Proxy: <xmx:hk3NasANRJkry2qSGaTsQkAbQYJ4jpZAGjcQYKtoXvRRhb_54CEuKA>
    <xmx:hk3NagFXW1yCmDeOBpzsgqOyE1YsPWe5tzu27mnwmBUninKwckKUoQ>
    <xmx:hk3Nal7Yxu03C4FtTL0hz3TDPJknp_8q0rEF68c6sIjhlrcMNoCZYQ>
    <xmx:hk3NaunMXFLsrz7KrtmrTaAxaDecX1PmaZGZ30g1EDZ7f6Kef4AFTg>
    <xmx:hk3Nap5p6m3lpB75B9pAC7ph4R8JbJ3gN16iRWyQ0vvqjXIWv1qD7vMV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 17:13:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ravi Mistry <rmistry@google.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Ravi
 Mistry via GitGitGadget <gitgitgadget@gmail.com>,  Abhijeetsingh Meena
 <abhijeet040403@gmail.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
In-Reply-To: <20261012192157.1835972-1-rmistry@google.com> (Ravi Mistry's
	message of "Mon, 12 Oct 2026 19:21:57 +0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
	<35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
	<xmqqtsmsdpxz.fsf@gitster.g>
	<20261011222929.2957901-1-rmistry@google.com>
	<xmqq8q43eszt.fsf@gitster.g>
	<5fcd107d-b620-44d1-91b7-e5f9965171cc@gmail.com>
	<xmqqbj8yan77.fsf@gitster.g>
	<20261012192157.1835972-1-rmistry@google.com>
Date: Mon, 12 Oct 2026 14:13:40 -0700
Message-ID: <xmqqwlrm4o6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ravi Mistry <rmistry@google.com> writes:

> For v4, I left the behavior as reading from HEAD:.git-blame-ignore-revs
> to match hosting sites for now. Maybe consulting the working tree could
> be explored in the future in a separate series if desired, or please let
> me know if you or Phillip would prefer to change it in this series.

It needs to be justified in some way other than "match what the
forges do (which is to use the one from HEAD)", but other than that,
I think it would be more ergonomic to pick up the copy from the
working tree (with local modifications) in non-bare case.

Thanks.
