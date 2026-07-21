Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81D3EDE79
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654228; cv=none; b=BT+SZL01bG4PzKCcQBy1d3/Cfx9Ysy6GN3na5QzwR+Gq81MH8cbXCxoRC8irReYwpQswfNLJ0C29YuM+2DvmVIFRlP8nmtmwqX5auRBDbCG2hcsgJmqNEQNXEGqlHTVpMZonLOh8vGygC80kplovvW/kMLIfnjcTnjNevNmDGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654228; c=relaxed/simple;
	bh=Xs8KVND059TmEMykuUl9v/64o93Aq+8X8P7bsfS8AZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d3/MtN0wMPGuAB4sT2sG4LdrdY9GztOR3bldy1akdy9wChQm64H+HOacKpoVBK9VLXYdkr5usezxZHtUKtOTa50Zo79rSI3Y3lmzbnxxk9Cjr+31PY/Ca35VpirWI7j4DWbI8BIJylcOIL4eW4ui9TWcFQ0QcBBJdSde0goLwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CazVvk4j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X5YsfrsN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CazVvk4j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5YsfrsN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24019140013F;
	Tue, 21 Jul 2026 13:17:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 13:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784654226; x=1784740626; bh=fepdGgmPO9
	z2H78dQ6GzsqY2bxfAcTD5UM4riZlVK5w=; b=CazVvk4juIMNJwJ2fi40n4g1E6
	Mc32mwdK0lmtlldZ9rsbp+ggFbKet8Nufor4Wz/Q8xvYRU8iwDLjZIq4X0cyHiAe
	S0SKbBF5x65mu7l/7gGbA2jVu17NPMYDNdtxUgzkhtf4QGfPaCmLGXX7pDfmv/M7
	4qZdZ2ped7wcdDUUunZmmusSfUVKopEkwA0MAMvbO4A2tEMZTh5FUWXNQfOfQlyh
	D7yPX6PZRHiZSggx1h68n13Bcl4Hra4FTe93RHOQKEHqlvoTynTkI3lHR1rN1WMn
	atdz9zngBX8Z12VVsPQrEpJbVhP0+XWA68nLXj0eVxQEOoF7yN1O+aQdLj5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784654226; x=1784740626; bh=fepdGgmPO9z2H78dQ6GzsqY2bxfAcTD5UM4
	riZlVK5w=; b=X5YsfrsNP1Gfjy5ECpDhOSWX1y9dDZGTtE6+FQbiZHxeo9Ji4Tf
	adVMAZnryOpg6yNAeAZpjnSlQTtn//NTV8azl7jcvgBJNKhoziPLZ1sw+XQC+e8V
	HsXpXgImcb4K/qxQjgsjMHnY8r4MLboS8daZvO48QMgg3qfNyvIjiB1l2sTb/4Q5
	2yFNOExzRDne1raOhuVYlHOZVVLiK6b+O73l/Rqu/b2vlyZ7VO0Y4tiM2nAVvdd7
	gAXN+2PKocYsnmVkpjwrnJuX1jQLcMwQgh5tyjGTYbMTFDXtxzTP1qU6t0tDLOvY
	O+sKgIKOPiIUZqrNXikiypoSan+3+sMgI0A==
X-ME-Sender: <xms:kqlfauI72tAYivncZU19R25lWxBb_0mq9qirq_ZXZekF1nW3pi32Pg>
    <xme:kqlfatJLP5LfFC6CopYR4mXcmYPC0uJl2XgaE1rV2bn93Nk1vmgkHKrrZFskFeQW2
    pAlBd9Cp2wlY1KvS21bVKxNFntLfBExP2_eX48pZfYa5_Ex46LWlA>
X-ME-Received: <xmr:kqlfajsClJLOynyC8G2AssoZzL9qMs_C0ziMUp22qADAz3oLl3_9C2qd9NMXu58QLVTJory1_ZJcNtgqhdYEOFt3-owxrmgLeQ>
X-ME-Proxy-Cause: dmFkZTGiHCWZbE/hEQHjmUSl0jDGoxm0KnlicORfl+yYLD2cC9OFQFco8TiejLKiRwldd2
    6Jpr+si35Rqb+5Cy6Av7LZNZ+PCGf8aHI21qoJwEGKGkklNsqK0uTTQT3/BBXAqGfFwX8M
    vMHdk51B+h8MrcawuPcQEr9+vT7vh23JOTjOWl0Z7gk76Xc3yKZ3iWRRwPU2QXu90OKIiI
    nrHJ5YyTQ3pGYtVgaCFvjleMhTC1wqUSRYUdklfDcBkOQ/dYjfrulDa29yNZ3nS8mcq6Se
    xkowzN/icLLxQt7KFApAvrkA5BOzFy17g5zalP4tD77beZI/VkiEx3u+GxbrLuUiHM7Phv
    kz1PcXXGosDo3wZ6IK+2pqoqgWOIisDydLnb9ujOAFroUJ0pjcVIw4wZC6zYSBIm/TGRA5
    5N7p/ZpwFcm7LCdJNf5sFWdYp9+eW19CKK7blIxwrMPazxePSkIVnmtDUOLzfEPLkoqRY3
    nSdNN/lJF5meK906QHtsdlAA/MUIOzyq5zXN6W1Ix3GpJinUw3XnixYXApgpvMm6CmToAc
    at1cHTZdP9Vvcz+gubel/NAMGMOqJ+6xad6oeq9jmfF2jSz1v27A7if67Cnwum50qPHedn
    PYZzPSuCTeHsUyWygm4kdb0/mpobKZaTKcwkbmY+VYOHWv0LIb2Mb7Y9HW8g
X-ME-Proxy: <xmx:kqlfaiQDinSpLwiIoSt1xkHIN3g2l5zbB4jKVWZyWUgYCNMcfauysQ>
    <xmx:kqlfahPkBmgwYPQ4Hmjtl2hDe1UOV8XtILlm-t-ewm7juI5ZFuJCXg>
    <xmx:kqlfavZ78oXCn1HLYujdku8cxwh_LUfGJkcjf0YvBK04-yJHecRxog>
    <xmx:kqlfajzfUAYrgvplgp94xhvV7XKAnc2OsbvRBWHoqx2N52UV0wsPJQ>
    <xmx:kqlfajMgX3BFgTMjeYwsxZ4hThjsbBwW0vj0liedNI5f3dxwiXDS7ZXi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 13:17:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jamie Magee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jamie Magee <jamie.magee@gmail.com>
Subject: Re: [PATCH] t0213: skip ancestry tests under user-mode emulation
In-Reply-To: <xmqqa4s38rbe.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 Jul 2026 19:30:13 -0700")
References: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
	<xmqqa4s38rbe.fsf@gitster.g>
Date: Tue, 21 Jul 2026 10:17:04 -0700
Message-ID: <xmqq33xcz2i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Jamie Magee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> -# Determine if cmd_ancestry is supported on this platform.
>> +# Enable these tests only when cmd_ancestry reports real process names.
>> +# The procinfo stub emits no event; under user-mode emulation (e.g.
>> +# qemu-user) /proc reports the emulator, not the guest. Spawn test-tool
>> +# from test-tool and require "test-tool" in the child's ancestry.
>
> T.r.i.c.k.y. ;-)
>
>>  test_expect_success 'detect cmd_ancestry support' '
>>  	test_when_finished "rm -f trace.detect" &&
>>  	GIT_TRACE2_BRIEF=1 GIT_TRACE2="$(pwd)/trace.detect" \
>> -		test-tool trace2 001return 0 &&
>> -	if grep -q "^cmd_ancestry" trace.detect
>> +		test-tool trace2 004child test-tool trace2 001return 0 &&
>> +	if grep -q "^cmd_ancestry.*test-tool" trace.detect
>
> This will be happy even if "test-tool-trash" that happens to have
> "test-tool" as its prefix appears on a cmd_ancestry line (for that
> matter, things like "cmd_ancestry-not-quite" that has "cmd_ancestry"
> as its prefix would be accepted).  I guess that is OK because we are
> testing this in a fairly tightly controlled environment (trace keys
> are taken from known vocabulary, not arbitrary strings, for example).
>
> Will queue.  Thanks.

Just to clarify, 'Will queue' simply means that the patch will
appear in 'seen'.  It does not imply that I have personally
reviewed the change and found it acceptable to merge into 'next'.

I would appreciate a review from someone familiar with the trace2
facility.

Thanks.
