Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45D3AC0FB
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354876; cv=none; b=Inxmsrp7oErqfrfbKusB0AWUZej9/h2cVQXjS7YhIadUOz25Eg2l+3BPqpZV8Fjr/G9WGXHmsZapPgdaSV/yWppNWl4hsp+PmNM+PbFNkKSg58+9pov7jr3KvIiTAmlROxMeIXNhf2CnIOmcIgyk0AEvQVbsr9ko/Wq/wbEjDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354876; c=relaxed/simple;
	bh=XijdhyfdnWFp5DxUQwAfkxC62AFgunTKdvZkPbodTJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ad688VLtecBOxiIKZrOB9N1ZPf8do5FFs8T6HwTFAtVSDutEhA9etWbhihBNUZUqbVJdnfT3s+A4/3gcIJS60tWG/X9nSJi92RNgUF5/yBHwrSXECRz0gTOvqkidLpH2EwxCBhh//fIBgQjnxiXm0cFXNLc6rHxD2/AKTV+rsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jn0vqeCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bA0eVVLk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jn0vqeCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bA0eVVLk"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C43FFEC01D0;
	Fri, 25 Sep 2026 12:47:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 25 Sep 2026 12:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790354863; x=1790441263; bh=RTftR3CRqB
	XJ7mC6JCdggk7+7n5S9J93JqoqESDmHJY=; b=jn0vqeCw1tMUcPgeNAhOshABox
	h+8mABXiTCWb0OhVoAQXz0cFAnq0HAU1qFP6mH+7fvN6LsOyIXy8M5Iumh+/a/4P
	LTwx/VjUtv4YVP8rLw6fANDaLJurllt1TmJ22zfh6qwSENpZY+xWEVMtoG8pPnyr
	B0wjfn/0bRJAuoR6xFwS0lUnnWaV6paWihfHH8f6NHbMBWxmebstosBBFV1WsSNd
	0tICWcgKUsJyeLOwQzKvT5ikJUrTW76ZMscT2Guboe8fWvjYE/a8qpObxD06pk5u
	ojVxXzD+k1lzEKy6Ory+Xp0F+29bgLJD+kcApPsBavrMbBK3s2yt7iBN31fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790354863; x=1790441263; bh=RTftR3CRqBXJ7mC6JCdggk7+7n5S9J93Jqo
	qESDmHJY=; b=bA0eVVLk8ktGrIE5cLFjSGdklRmuGrd4k839hJ6b7/AjofOvSyE
	GijBtLwCCeYwp1hiVONQU4b7tzps2b6WD8v2X6TjGH8tyCfLIQc8P+sxTcVmBpBH
	kXM0tmj/u9KxvleRkR1oO9INTnPtj8DWmwcZ3GSGjnBEJvCaR9jQArufZTEH/wnS
	K+bq8mZ2wZkElSTDI0ZW3O8nim/XETp6NawM9EjHaHMzivpQZXckWFPdi2Xmkis4
	Oe82vz1Uxa8SGrjEEYymTdjKl23bHGxTSGtBkbBn5R5844NI5PZVQANlWT2C64jz
	ld5YqGASglOGx4rZdCtDPcWzlwUfJllGETA==
X-ME-Sender: <xms:r6W2ajLVmPy9iK6Fq7UeYd-b85oaCcPcAwxJPWl-9oZETwozsWZTpA>
    <xme:r6W2aumph3S1Gm8XpDlqo95RtxrHxc0IRiYD2zXM1ZoHmomCpFgZutZMcXigSLkvQ
    ElFPP_qrr9gHKCFp_cVlFBuceFuf_iSl3PjDVmUnqs5uLkjpK738Q>
X-ME-Received: <xmr:r6W2apG2tGVjLzKR0cunDtA3DMZPjLsOTT4osqW23qBCe-fDeO_UKYpUWmty4_tDYxlwRpIwBEvPSd6VtT6tV2poD7M5nrFovbKv>
X-ME-Proxy-Cause: dmFkZTFbkAdrj6mOfIVj5OJs8aFMyasfNdETEvCVm8NhO9l9bmL72EaHGJh9D+cxQMaOIQ
    +3o62NE6cPk/4hhPk+QAzq5lQfJ+cRdFmH4ucGAK6L1Bae49E3Bf/odcXfPLo+X/I55hGt
    DOoAoQOEDdGZOOJywGz+9Inw3IO8hV9It/ocvJiwcdK/aVOn6PlYMT/NfaqIFO+4Fi2dEj
    iXyUFdv+RihdqGekDILB72/Zxhl7emv/b4+1S24kb9iM81tf8HbbR7pVV8QRZuYPONNiNi
    kDVLkfnXgThqkTkYjL03vh/PQrgeuFcSxWbcdSsS6Ikr6z9eGE1IP3SdhpcNCXMo55Y3Sv
    k0aIX+gf/IW/gW8QBL5S/0N1Jm6rW8W9Hjjp/rCJD51lyKfCJ5C8wr3StHFeP1CfRefBcg
    efKxeyhLMYQvCFk1X3GWZd4lqRD3vwc6T8nl1A1+58D+cJcCASW3MmgZCGcSbHnLcaaCTe
    x+jWhEY+d2KZGSMY5zi4Uh+cYPSI9OikPV4UwPyAOQVR/kYYjNMH3/1oRFmzZUt+EdscQw
    Qrzc2CnXDGeNm4JOb8zw3L8y+yxqYcHpd8LBQZpiii2MMpZAZNiEGMdcuvBFTamhy4AJ0L
    Q8/BV2fUbav7obJ1LWgDEGOuh49rc5Me7pZSpVKLSWxd2xnAPHWK/BXo8KLw
X-ME-Proxy: <xmx:r6W2amGFbp7JERlR-QAsnoVNfiRQbbY1B_s6dS7jIPafBYv9tsesfw>
    <xmx:r6W2auNrsT6FR4Tldu-A0O2AHBmzCh4eQ6DPlARJp_cWz2MmVscvEA>
    <xmx:r6W2atFiTnLK4dIrVZO6qmmLnoK9rhFrnVEXPiv-rHu_mu5FF2GFfA>
    <xmx:r6W2atPiptzIXdsVfMsQ9TKWZ0wyNwTX7OUH3F7BZ4fV-W6oJa0LvA>
    <xmx:r6W2amtAkxxtHfwukUlryzl-hHbPgTkUHR-bY_5GWp5yBrBh8Eg287lu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 12:47:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: git@vger.kernel.org
Subject: Re: Rewriting the Git tutorial to cover less content
In-Reply-To: <bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com> (Julia
	Evans's message of "Fri, 25 Sep 2026 12:08:51 -0400")
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
	<pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
	<20260925082723.GB1493716@coredump.intra.peff.net>
	<bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
Date: Fri, 25 Sep 2026 09:47:41 -0700
Message-ID: <xmqq7bk9wa4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I'm working on a patch series to replace `gittutorial.adoc` with a completely
> rewritten tutorial, since a lot has changed since it was originally written.
> ...
> I'm excited about this direction, I've already gotten some positive feedback from
> test readers, like:
>
>> I can say I liked this tutorial better than any of the other git tutorials I've tried.
>
> and
>
>> I really like the tutorial, it's easy to follow and I learned a lot!
>
> I have some ideas for what to do with `gittutorial-2` too but I'll leave
> that for another discussion.

As long as it does not mean that learners now have to read three
documents instead of two (i.e., your replacement, gittutorial.adoc,
and gittutorial-2.adoc), I am also excited.

Omitting some material that is covered in the current tutorial from
the new one would mean that the topics covered by the remainder of
the current tutorial have to be sifted into three buckets: one that
is to be discarded because it is no longer useful to the target
audience, another that needs to be described somewhere in our
documentation set, and the rest that need to be taught elsewhere,
though that may be beyond the scope of the project documentation
and better left to other projects that produce "books on Git".  It
is somewhat unclear from your description what your plan is to cover
other topics that should still be taught.

As we reached consensus at the contributors' summit, we should wean
ourselves away from the mindset that these tutorial materials can be
incrementally polished to match today's needs, so if the plan for
'the rest' is also to write on these topics from the ground up, that
would be very good.

Thanks.
