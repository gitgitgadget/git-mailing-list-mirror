Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354293EF64A
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410486; cv=none; b=m+/dntUWe7+AxlVn0e4Od9fZobU0xrP1fRFNt2/PxYkRtKij6xWXbVcOz40n1J9oIK+UfHjrahAVJBtfMYRPtTLGSqqN1Ws3qr1YbGCAcbi4x+9rh/3cCNVq0ZLVz8b1nieFuamdOu9fG65i0L+1XLfw3nku8cvnkHebttDkLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410486; c=relaxed/simple;
	bh=1jyq4V9jl9jN+5PijUwlnx9hp1aoEpAUwUyl+Cn3RG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFU4StvcnhuOEK8uefv3YVrR0qVoGos0abbTr6+pHmItbT1KwN+t+V7sKWSyDCIPlnUrBPtnlosaFbNQrDxss107uXZlFejBzs6KXeZ3k+RZcfx9xfPIW0fQB4XZ1RngcNv1DUdDqJlluULkM1WklzkEHzqJJpdCboygy5oqZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SwAZhvOx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fl7yur7d; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SwAZhvOx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fl7yur7d"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 531CD7A0166;
	Tue,  2 Jun 2026 10:28:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 02 Jun 2026 10:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780410484;
	 x=1780496884; bh=ZAUzEUqFQTdZpOO9MBtQEf6WxGuOeTjz4S+x6FHsNEM=; b=
	SwAZhvOx0mb1iaG83+nmeX9gZyQktnAGHy29I0AgMEtCpTmR8nyOE3Pj6121Ezh0
	gOnoZ52/jSu4hTkafow9YQ36thVyzjHr+1QW//yZUiC0EaP26W5a6l11NFsIqHKu
	+g6Um56UIFZ3gGUqGOr+p3RUGOQfunWq8iYoolh6aUe8vKsPNegDl+34lTOGbwuM
	2wshBjE1Kh1mITxu4AMGXWzWy0ZTewapklhg9uO5CfzbpKxZjyC8ZdwSm5RGovR/
	e68vzJyGFdHxRQ9rfkdXtbZ5ksUnZkPMg0ukQNhxJC/2lZiv3FE+OiYgdiRFU+kS
	nb7PzibD2iCGKPcylwVOVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780410484; x=
	1780496884; bh=ZAUzEUqFQTdZpOO9MBtQEf6WxGuOeTjz4S+x6FHsNEM=; b=f
	l7yur7dZ6NgI5RGUVty71p3mW0+ASfNfxeuEC/hYZrLuO6OQLJO/X+MA5TKK7yTK
	Pd2XbG8M5jSBvp7hZxNA9fHUelwDtGsiGGxSDkT4kMG6csJfuvgYjZf5CKhUZMNi
	1rj3QAR4StbCBdTmXHK+5ToCYqUiU9qXywo0p9iwIU+ekmu7iCTy9bQhJhtOWe07
	0ShGFsSUNvhQb+ZwA5Eq5AzzkTXmtXyy/zCPEg2h18tlcAQfjmNImIHpF9C7k1qG
	vpUdz0sG3+GgAPvHQ2rhy3TIPsL+o3k17IoJ1hp6cFIng9OJq6MDwfgTdlHIQlkY
	pthGTFKZqKmhVW2rq06xA==
X-ME-Sender: <xms:dOgearwBlbXkOygYfVJ4iFLYfAhl3i8fsAwFHbvRw4-Q0KkDd992iQ>
    <xme:dOgeaqucIoPfJLcEpUd34WJ-xdjJkbfcOLjezRlQgE1eEfHI5v9Cz3FlB6bXXetos
    _1J867jK_3PjwMsZQc5vuurt_y27BfFiB-aR6a3MlFd4Y2X49iL>
X-ME-Received: <xmr:dOgeaitfoNoODl1wDh3xATXpX7iQ2dlQwFwNWIfoFVdaOsgckb5NBnvgBvFePvanf8oX1265ahT5jEmidnG4U9D2bB68E4WAIj8T>
X-ME-Proxy-Cause: dmFkZTEbGXukQjnLdx25GaMkZWUzWJKlW+kYQDSrF16u/1P1qEMWWP8U//cGcALOu5McU7
    fn5Y+DDIpOdVeqLiEv8a5QpRjfsvG2CZztxZYFa6IMw385xrouEhSeNZ7tTyVzpu8OeqCj
    aS9guRPWeUDO7EnAGez2wEmEPuCAOgYy1OOYCexw6cFuu512V2Wb1wzaTnousEFCXIBeKR
    FCApEXg2KEQ6VVTonkHmLNX6y+6zzwH2VcpYKVvFjgG6DQXKLVQoJUnS6UtAdQ24JIbScU
    vYDfGB1hcfNlgsc4bUrQOTnhzdBrGvWHXGDKViaS3NI19S2pcnPanPehrINDeBrBtOI6ax
    3sSNW7IsRNVMnZu+EOJJ1MXeFi4DY8SsbbnDh7F37RLFSa1mmWiKs1ipRjHIxMjpBF+cwG
    S7RpCb/uUHWLxtHUNmpRFTilF0ZHcoyC+EA1hQ5d6f1mz2LPBeQYZrI/xXVM18rHbnc0kA
    rWFoZLZB5ACCwJX12comFyLq47G/PvockHcaxdRBy3V0+miyw6RGNC+nyYvJOUgMlQQCZ/
    sZXGZEQv9IXfMGjv3W/WC31vR0CsztqGq8yFPxiUVDwOI9do5XwHTVa8CDViUO59NiaZCe
    XUSzfM7gks2bBeGX4HDJIt8RAWpZnsRQqhwvUrZZHCjIH6gpgeP7fdsWcXKQ
X-ME-Proxy: <xmx:dOgeavOqNxrqovayqdtv5g0FPF_okicjuiGD_Q88Up8iZhRJcc9QBQ>
    <xmx:dOgeag2Xr-kCzdj9skebxh-Jwvm_YtWVZZKq8zdxJf5SJLyPJA-Hwg>
    <xmx:dOgearN_BtIZk3KOm4Q0W5FuIGpOLCFjmo8sTaL0sU5MevBIw0gOCQ>
    <xmx:dOgeag07VqQEfxNv8HzKxm_Y65E1VowAuD-_iIOPI9EjgQq-ap-ing>
    <xmx:dOgeaquqZ6J_Zx9Eu1vA4gQHx9I3Ts_VTkitFzaQzHz5a_fORXmDUi4G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:28:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] SubmittingPatches: separate typofixes section
In-Reply-To: <CAP8UFD0ij4BTVTie1dXwTC8M_9gAvroXebFLmQuY7eUCgHrJhA@mail.gmail.com>
	(Christian Couder's message of "Tue, 2 Jun 2026 16:24:39 +0200")
References: <20260602090808.87837-1-gitster@pobox.com>
	<20260602090808.87837-2-gitster@pobox.com>
	<CAP8UFD0ij4BTVTie1dXwTC8M_9gAvroXebFLmQuY7eUCgHrJhA@mail.gmail.com>
Date: Tue, 02 Jun 2026 23:28:02 +0900
Message-ID: <xmqqbjdtuidp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Jun 2, 2026 at 11:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The existing text said something about tests (with [[tests]] to make
>> it easier to refer to it from elsewhere) and then flowed into a
>> different topic of typofixes, but it was unclear where the latter
>> started.  Add a similar [[typofies]] marker to the document.
>
> s/typofies/typofixes/
>
> Thanks.

Thanks.  It is amusing to see I cannot say typofixes when I talk
about them ;-)
