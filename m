Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB793B0582
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489311; cv=none; b=Er/AssdyQLnjUH/GV7wcYyH3iZAnJy557UG+StWyyiXdA/Q9mq74LfvozJcV17BIaMZeh29xM78PaHeUNIRddE0MLkXIYqFgK0+T88lQGJVaMMuUVJyOCNVu+WmkwzvU9Gx7iTXnAG2EMi5tzkdy/26AxKSY01jIPhLn0vaW8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489311; c=relaxed/simple;
	bh=LraLVQ61RlqVenHMoLpnQKexzVz88atgzUHEPWn7kr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fk/jDDr60N3ySkSGHYkwDySdtqppnzJXN/rjkg4Dnce4iJI/0JuWhvwiqOO5cysbp8/CdXBUBNw4dTEKDf+1ScgV3QPI19ZHZ2Ha0p+9MyyLto1JWZYdpTIBVG4RbqwMJSEZXDqHhRM0D/O9tlYq6BshCII+mdHjcCHt+dpvLVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AeHBgnYP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xz8CPQPK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeHBgnYP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xz8CPQPK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E52A37A0203;
	Tue, 15 Sep 2026 12:21:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 12:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789489308; x=1789575708; bh=hkEv9ZiJ91
	BpaWWLn4XCFSEIhFk47a9DKZps+O7T/Gg=; b=AeHBgnYPtWtbCuYlMiJo6+MUz4
	vv8zwlaG4nCeA8PrRhM/BYxbOLPYMoLWsTE7Vi/1S3Sf1pvwZcBMOypuIq81aThb
	800QX3TuCuImzL47LCh6Obtla9UpK4XkyEL+wJ2ASrlp2C4qvDHKp+YJdcE2JaGM
	tT2YWsPXnMYOJH6cjW+Jttfiquj+RegHSb/iqACovHd7SlL13ruPpMztHzTQbGGz
	faQf3cQSdP/h/w46X7nMyydvkwuYi5/a8/UYrNG6jl9sjlxt62bt441walXvaRnl
	nGzK3yatyBZag0oenlqAu3rHuKiolvT4QgHfwJoSc7Y0A04tWMvH1Y75NOIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789489308; x=1789575708; bh=hkEv9ZiJ91BpaWWLn4XCFSEIhFk47a9DKZp
	s+O7T/Gg=; b=Xz8CPQPK9kUOXpnWREYDVWBm6yFp99Hhs6CSEZCMWxITNFQC4P5
	3PnFGf28FeCAhWslvm+j0Ef/2WSgyZeeeTwYN2WZ3T9t0dAUWePQCQhWio5sCvLm
	UibswQXSY+804AmLGheKc75Ym7aadPsa6mf0e7hGyrN8aRnucJ0tammHjVIp8an0
	9Id3qWzEbqrRzArBJLovTajZ/QH41enyjngWbq/DO5M7mtsTWFjv7+xUxazJkiwh
	k8mNFEa0QbgTd0IaDl6agZ8BkKC5FtLOtPrWft5pD+UbTyaqYDDJJDx2P6PFXOri
	CLxofVu9TIzOMi/+seq8dVcgOgK9tqmcoiA==
X-ME-Sender: <xms:nHCpaqHc0SyuaM_8r3Mu5-FFQgzfute0SkgUa4XNQe5KiXrbH93Y0Q>
    <xme:nHCpaiVXLgfeR7aJyXXhixTQ88r34g4YH75NS9SmOuOPnaoI8bRlwaY1fIV4nRMqt
    0QivycSjkYII8Qe76i3bsnyPgsIl-5PeyL_f4lCCg0N2lLCCpLAnYM>
X-ME-Received: <xmr:nHCpapJmDIsG_FReSroe-LJE8BKHxiCo4iC7alrG0jmj08AzIOKo0P14Ub8mnnFjnwJIbmOUQuf7g_nV7Y-MiPv4U1WW3-wbUv6n>
X-ME-Proxy-Cause: dmFkZTFq1TRlr+8bKaS/a2WAHnmHFAWloCPedjBGX0rp2VT9NyGOeWWBtYw3GMVt+kxwye
    jWpPydoiIXr6ZQCrqjCoOW6ts++Rfe5crrwEqUqDJamD6r08VZ2zx+WVHVKkTope3naXsq
    aFkvAj9FvqDvUGLS46h1YvmEE+V6POVKkH0s38rJzT/w5BFQ1hVBO+DjI0sURiAQ19hVtD
    /Nxyb5K8jqm3JY71atpApwywEpZditI6TxR2ycOZi/kheS1NKrYdhJxt9W80FRpgSGa+QT
    XaOXrXgIb6rOvYZz8FVdTC2/575hSm2SnzOHpfDr9M+isprTog7FnyqOm0YhTqVjIGUvJI
    BlNNyV0TZafjB5djntP8ZXErYS9LjyuzPMbe3X1vlPjlEY6U+AH+OXaHE0qH44itHfqnSf
    yKYxIIY+TC//Zpb8XqIfA2luUMfiKyJXgdwoPrXM/uxLlP9YaFJhEG7pIRl6tYOQmCfgtu
    yzGdrQ5rhxHoJx6YPhrGKKdMFSoX8OQS/Uyl23LYinwLW9PonwBYGdZB2oF8G5XOz+sbMk
    5UgM3gTVCCK8Er/CZDxSIfjp1vA3fFtudsS4sdrPuR617mAaxzFB2nNVhrOAK9qP6QaDhk
    8RxSOTV2wDtyyowsmf6yZBnYZSO9pEQ8hPiyUlruKky4TfvHA9QDUyes998g
X-ME-Proxy: <xmx:nHCpai_mJlzEliu74s1bO4r7aD3bxFoVhjIf9nX-LqeYrHPuMDLh0w>
    <xmx:nHCpasJx89GLtPmenmgi2AgDwy1ibCOn4IP09LaX2fNQXluo6cQcPA>
    <xmx:nHCpankJSoazV102M3X7OVJv0csOxwWy-Ykig2t_QNK8sMs9CvrFng>
    <xmx:nHCpagPSf-MInyn7-JNucK02U4qKX8MwjbtNItfOT5SP3jZYzHUKdA>
    <xmx:nHCpapEI54TkzDyfrbYJ1knMHK-o8ZVErgw8fy5MVDkJH1rwpbZEVQWH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 12:21:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2026, #06)
In-Reply-To: <d199ecb0-aec7-468d-b145-c10903d9fba8@gmail.com> (Kaartic
	Sivaraam's message of "Tue, 15 Sep 2026 14:02:00 +0530")
References: <xmqqv7874nm7.fsf@gitster.g>
	<d199ecb0-aec7-468d-b145-c10903d9fba8@gmail.com>
Date: Tue, 15 Sep 2026 09:21:46 -0700
Message-ID: <xmqqwlsm1o4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 9/15/26 01:22, Junio C Hamano wrote:
>> 
>> 
>> * ks/history-commit-leakfix (2026-09-10) 1 commit
>>   - builtin/history: unuse the commit buffer after use
>> 
>>   Will merge to 'next'?
>>   cf. <20260910160254.GB251185@coredump.intra.peff.net>
>>   cf. <xmqqv78df57r.fsf@gitster.g>
>>   source: <20260910150021.348548-1-kaartic.sivaraam@gmail.com>
>>
>
> I think the code for this patch got a go ahead from Peff. I just sent a 
> v4 with Peff's concise commit message. Feel free to pick it up in case 
> its worth it :-)
>
> v4: 
> https://lore.kernel.org/git/20260915082943.117985-1-kaartic.sivaraam@gmail.com/

Yup, let's use the one with readable commit log message.

Thanks.
