Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B86485CEE
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036119; cv=none; b=M91WPxo5ZtWHFCkRHi3HbypUSRIHAShk4XtnVfmQ3+dr05JyHdbXvsfkc9fcNxtCM3//BQrYwM7udybOG22rE2F7a4n43cJSOxzm7tU+QaGu6gnocxYrOPbAr79TWySqPreyVKY1Ged/lwIpnZ7/ZLEcnb+PotnRkPOMlo4OHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036119; c=relaxed/simple;
	bh=NYvFwsuwzDfU1Nnxf0rCM8aQ6WzO7+j5YXVpYDws4FQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iiu3rlFe6U651oH1g7udGLlCokHY2OMEMu28RY0Uj1YMbF1aR4E1DK4VuP6DX5EcpcH0xFBCbJBX1rGGds2XvcUB62iwjpxTjkM+2r4Udc8wiTppR4go8tJzLsxPdO4SCOoUJPK9qmHsPXfdn7sv3yghLjtf6V0nuwKu+0zURaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N2Z7WoUI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CAx7gi0o; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N2Z7WoUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CAx7gi0o"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B77E97A0061;
	Thu,  6 Aug 2026 13:08:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 13:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786036114; x=1786122514; bh=Xt3XsBa48N
	wggvmsKB+htwKcz/EawHw3J0SJOhIW+NY=; b=N2Z7WoUI6ID/nLxUIrs90jUHJh
	tbgG2Grfhw98bCRB4dbXRnTpkUjuMyedmx9xMd9NumMeh4SpFXbmjvYBiC4OLhl9
	tYnyviRg2MKP+nJNMI/7H3Kmt/6WW7AsEAAnyYkJvSfwuiiMwQnXjnxrcZmJmuwN
	G8GiDZ6XlD9kQ1Cr940gkZRWlEtO8hjukSH8vxAXncjJICDcH3CRBPQ+Cf8ulpjb
	CcdSQPCPnWSIgx8Ivuy0SukN4Sz1LcPuqcSr1azHYqO7bzNqRQ82BWsJKj41VyTZ
	u6FFF93I9qnIDGirAmS0wcVJceNAp9GvvPprD90hrCAEws9hXBdzL1C5qkiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786036114; x=1786122514; bh=Xt3XsBa48NwggvmsKB+htwKcz/EawHw3J0S
	JOhIW+NY=; b=CAx7gi0oR4ntp0w/v+zTTEZL0MhnP6KAcO+JAWUpltUhjxTUs4V
	28e2tsAgaTWAZHWPpXUBIpugqBfjL+yRr06fTQdEebcu078NQZbudJzdWLx/qRtj
	dObtvhqnK1pJMw+ryqWuWXCT/BB5F5Arh+BBhlWzK0wFExO/TU3+pf4AK0AZd/Fx
	LmdfsCHLHFlKwvWyUtDTj2VAUOI3JBoCoUytZUMFT+5Y//F1pJf/w6gockwe4XJ4
	hON6XlBBHhY3URcX+HAik0jsSslzZlhcvq3mIkxhHAc9FX9+MjLTILhyjXERBRaX
	Rt+nqz+noX2OzJIXOrKUHa1gDO2qEB0u1LA==
X-ME-Sender: <xms:kr90ap056azpzccjDJc60ajS-AJIYuBoXTuPDzfM6Pr0RTtQ3h9GvQ>
    <xme:kr90aniNnh2vX-faqBeH3cpelINSzQlzeTSrRKrH8XdtDeMeOq7xDxxGq0pYuJOCb
    5UBSot9IjOpUpdAWY1pFG1pgbmhB8R1IXio5PWXmbpS45ND8ROQsiI>
X-ME-Received: <xmr:kr90anQUur4Vrfo3rMq_0KcRr9bukdX5G_7NtPuLWYr-4r-WwPf54shIK58Ce5V-DQhqCXIOgs7erWwsQSBFd_j4ZwrNhtceMw>
X-ME-Proxy-Cause: dmFkZTEJNIhK9KUyE4zEFPOtLCjIeGcXzjQBt4GmtsQ3SQ/V2SY36FVARiIuKc4IDiQkWx
    OKLO1weVyQNkYDq0ymsfeL8raEeMNg81mTegE9xeiIRLmTNUSFA19EXfQHPP6WyBofjNVa
    F7CjaUkaG8/Oxl3a7drGplgEhJZ7TERUaUBRChTm5Y6JfhFFOqpIaKy6NV7zvuL47kKaOi
    r6Es/Zel9khjARXo2OSSOyJlZbCJH/oMcjbDFHEa9YM2cax8E8sQHWcpf2pZ8MPjlICfcq
    NdFVaZKQyPcOaxfn1kxa2VAVAoB43i6ILOr/lqDj2LuOEETxlNrwDs3ZMAaJDxK5NQdlSi
    IoJZkG1De6hAR9n209Rx3nvykdJ+wQDxiImZJQ+F+AEmE/CMHwQzvK1KNgw6hN3pkcvHfd
    ZinZHpdiJ4lPz+Nvk5TmnWX5AAoQNYmPCPmxpDh88d0BuwOqA8lVcLM+3G2IUv6J+2jeet
    FB5qCPLqK2gm9XSnFAo3jSBZZ1v4cH8X1CLhXU0tMjaftLex7yGffCv6213gbBE4trG8/H
    jGFOM4sS+3UZc5Dx/kvgJIiUzs5YXHdqntGe7eYaLNUI9r4FXPPFXalLzrWujDXQMiAt1b
    PC7gGGoqC3Ga4IuiWj3vRX3iqV1oOm26evysNxtDs2FEEPw3Q5aIFjKJUkHA
X-ME-Proxy: <xmx:kr90aghxVb9CJCY0psHtcSx_snulvLucdnKX3U2sHn-hC0IyCren6A>
    <xmx:kr90av7Lr8gX8Yhz5T9UKASTuXfPykxaP-bWHZgeGxIkgkxiFsVf5A>
    <xmx:kr90alCQ2cBY3OQyihZ1cR2-c6L5X6i2xmKMUm-8Lj_3yBuebqqd-A>
    <xmx:kr90auZb3WvsEsoO7Winn8k-Ym5d25arNJJu6Yd7yA3ySn6x5XjOaQ>
    <xmx:kr90ari9_skxa1cqhH21q0fRifkhw9wvCicBNgjc5loPibm_xZO6hUoN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:08:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2026, #02)
In-Reply-To: <DKHZ3ZMG23JK.369PS06XOZPU6@gmail.com> (Pablo Sabater's message
	of "Thu, 06 Aug 2026 17:41:29 +0200")
References: <xmqq8q6knpyv.fsf@gitster.g>
	<DKHZ3ZMG23JK.369PS06XOZPU6@gmail.com>
Date: Thu, 06 Aug 2026 10:08:32 -0700
Message-ID: <xmqqh5l7kwhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> On Thu Aug 6, 2026 at 12:48 AM CEST, Junio C Hamano wrote:
>>
>> * ps/cat-file-remote-object-info-type (2026-08-04) 10 commits
>>  - cat-file: unify default format
>>  - serve: advertise type capability
>>  - fetch-object-info: parse type from server response
>>  - protocol-caps: add type support to object-info
>>  - fetch-object-info: die() on the remaining error path
>>  - fetch-object-info: use dedicated struct for the results
>>  - fetch-object-info: pass arguments directly instead of a struct
>>  - fetch-object-info: detect malformed server responses
>>  - t5701: use test_file_size() to get the size of a file
>>  - Merge branch 'ps/cat-file-remote-object-info' into ps/cat-file-remote-object-info-type
>>
>>  The 'remote-object-info' command for 'git cat-file --batch-command'
>>  has been extended to support the '%(objecttype)' placeholder.
>>
>>  Needs review.
>>  cf. <xmqqpkzxtyac.fsf@gitster.g>
>>  cf. <xmqqldalty3i.fsf@gitster.g>
>>  source: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
>>
>
> Hi,
>
> The topic ps/cat-file-remote-object-info graduated to 'master' last
> What's cooking [1], so ps/cat-file-remote-object-info-type can go on top
> of 'master' as is and the merge requirement can be dropped.

Sorry, but what do you mean by a 'merge requirement'?

I generally keep the same base as before when there is no reason to
rebase.  It makes easier to view the differences between iterations.
'git diff @{1} @{0}' would work just fine, for example.  If you
rebase, you would need to guess from the output of the 'range-diff'
command, which, while much better than nothing, is still not easy to
read.

The above is kept on the same synthetic base, as I did not (and do
not) see any need to rebase, but perhaps you have reasons I missed?

By the way, I just noticed that the commit count includes the number
of synthetic bases, which may be a bit confusing, if not wrong.  The
tooling to maintain the 'What's cooking' report may rely on the
count exactly matching the number of lines below the headline, which
is the number of commits in the 'git log --first-parent master..'
chain.  I might look into changing it to show the number of
contributor patches in the series, but it may take some time before
I get to it.


