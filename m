Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBF13957E
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534118; cv=none; b=kph9p299u/i1K59GC8B1nfM+7UtymJVjNZTFtJbz05zRWlcqJc0948gqnhPxOLcgn1JaB13VGTojS8rscUUssG+AVKves8IUH6Sn/Yduf8RkACcGK+bBs7ROn0bc74/jiE9qZMvX+dBN8Vmpd3tU+Q1JQMT2W2cRHstrVIengBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534118; c=relaxed/simple;
	bh=vbX3GkBXIGMIe+2Dz5vRZtSNm6PbrxNkTBXGaj//OuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWEaJfqGZ5kbHY5LYl8aryD8Gj1DT2uxTpfNookUF8iy7Bk87OIpkJPtic9DweZ+ISpYdw301UG/ZlZBY3ix5Av1X26rds8NpMRWdGF9qS3o5U9r0TzKboq2Hy+IpWdyta+zIx/Jzlf3UcAmTVeHdszChN0LvvlOBAE1AUKBxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xrP9FSTx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u+hCGTSE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xrP9FSTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+hCGTSE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EC78AEC00E1;
	Thu, 19 Feb 2026 15:48:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Feb 2026 15:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771534116; x=1771620516; bh=woQ3dZNsjr
	ebscZ6dboVeGn6M8IRiTPi5DfEIorBXd4=; b=xrP9FSTx4hcPrx7SVW/WyF4GBX
	r6Y6xa5K5EpLbV9f80fVbAsR/8LDOvdT5LCU1QoaGNHFkvlpGHq1TSbEmqpD9VK4
	nq4OqyuoE9sHDznHQMmCnmTh2gX/d7NbYejKi7AR7T4TMSsAaUQAJlXcSLq1HFU6
	NOvlgRslTU51CyrK66IHn3gE58jkQDelBPdAI+xCN4+TVA7BpCSoYyQTU9vALqam
	QAFXdUlDe5kuOvr/henB0FuPLYo8i7plDxDbCzZb+hHDJUAKheXIIdd/9/KrvXLX
	aKxOrsFFoyKsSXSGO5jn/WpypKevbGjoZvTQ5TC0qIOFTijRd4Hzm8Wv7IfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771534116; x=1771620516; bh=woQ3dZNsjrebscZ6dboVeGn6M8IRiTPi5Df
	EIorBXd4=; b=u+hCGTSENhDtDDEaashPqmihzfrptGBFOQ4JHHH7qRlEMFrxi7Z
	3sUfJBYwOuEG2k1rkZLL20vQitvA+Gewb0oouVnygnxMvx01vyf0cLC9sZuxOfQI
	kT4s8+n+Tg/JFAN4lyMxAEtauxW8Qpt1Wjoz+DLISNAw+xbryxHFBvDc4E+x4ugR
	FssT7TnFy7ocr1L+LE/drz1npL+mp1ZnhpqpHLE46F2STdjLtUJHcYW13JfFVcgz
	iy0Ys2vGt95PY+rIihPU4VLJeg8i2L3RCNeg3/o2VlSaUriuwNOoNSQc/BoUJvFM
	QyWQnxjsMbrlpZzyniRYBaCez8UmSLJh5tA==
X-ME-Sender: <xms:JHeXafF7E7DUMd_Fa1mco_kaifyCdWFEux16bZDg2V-oBYxttsEYDQ>
    <xme:JHeXaTUMAR0xSKMi6IEfba-t9lZOCzfmuP1fMkaoLokHxC0aSDi5VjN0hIcQlwKMZ
    ogF82jXcO5qI1P0GgHvZiMqUBN9hXJIiG7B3OpUzswr1B6r4YiJpg>
X-ME-Received: <xmr:JHeXaWLeL-_Ybvy_kRditKthhIA8l3znMm0Dhn-gp-zAuFqacbD7mju_xcow9u2RyRWSi6nBvTzWs2HOUhO3DYz8vXuDJzXoRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomhdprhgtphhtth
    hopeguvghvvghshhhighhurhhgrghonhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:JHeXab_JpbAzCFZQVONqp9VqVddWIptAGaHaKQFZZy3gTKa_hYIGYQ>
    <xmx:JHeXaRK2LXVo9HWOu9xo_uHoSFIEhjGdtt3NKI_-ladQY4w3KNFbBQ>
    <xmx:JHeXaYn_OLmLjZEvCp3RXpRCxIsvaF6ckdTWWXt-_LYrrSuQq5b4Zw>
    <xmx:JHeXadP2EPvn-reqemQLW0sMVmR2NpOfM8GYyNE68UHSChz3KyG_Wg>
    <xmx:JHeXaQpFsF5FraFg_AXnhfoDn8quWXTMpGgxVYwY3YOp6BlTJmTSL8MR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 15:48:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t1006: fix %(rest) test for object names with whitespace
In-Reply-To: <d2bf79b3-4407-4fa0-ae2b-fcb3178f36f7@github.com> (Victoria Dye's
	message of "Thu, 19 Feb 2026 12:23:57 -0800")
References: <20260219152407.12160-1-deveshigurgaon@gmail.com>
	<xmqqikbs4iod.fsf@gitster.g>
	<d2bf79b3-4407-4fa0-ae2b-fcb3178f36f7@github.com>
Date: Thu, 19 Feb 2026 12:48:35 -0800
Message-ID: <xmqqzf5431ek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Victoria Dye <vdye@github.com> writes:

>>> -    # FIXME: %(rest) is incompatible with object names that include whitespace,
>>> -    # e.g. HEAD:path/to/a/file with spaces. Use the resolved OID as input to
>>> -    # test this instead of the raw object name.
>>> -    if echo "$object_name" | grep -q " "; then
>>> -	test_rest=test_expect_failure
>>> -    else
>>> -	test_rest=test_expect_success
>>> -    fi
>>> -
>>> -    $test_rest '--batch-check with %(rest)' '
>>> +    # Use the resolved OID so %(rest) parsing is independent of whitespace
>>> +    # in object names (e.g. HEAD:path with spaces).
>>> +    test_expect_success '--batch-check with %(rest)' '
>>>   	echo "$type this is some extra content" >expect &&
>>> -	echo "$object_name    this is some extra content" |
>>> +	echo "$oid    this is some extra content" |
>> 
>> ... I somehow doubt that this is what 9fd38038 (t1006: update
>> 'run_tests' to test generic object specifiers, 2025-06-02) meant by
>> that comment.
>
> That FIXME was intended to call out the behavior of %(rest) in cat-file
> itself as something that we may eventually want to fix. The comment is
> only here because this test happens to demonstrate that behavior. For
> that reason, I'm also not sure I see the value of this patch; it's
> removing some visibility to a quirk of cat-file without fixing the
> underlying issue.

I agree that fixing underlying issue would be a much more valuable
outcome of resolving that FIXME comment, but isn't the approach to
give $object_name fundamentally incompatible with %(rest), making
the issue something %(rest) implementation cannot "fix", is it?

That is a part of the reason why I said I am dubious about the FIXME
comment in my comment.

Thanks.
