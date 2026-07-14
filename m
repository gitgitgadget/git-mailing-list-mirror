Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE1360EF2
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046297; cv=none; b=Qg+QOx0LJ5kF+6DnudyEmMg6KYW9RXVP2kqkdaWy9MXHou4Qdbu2kOQhq3LiEsSuFzM4haNM+MB5811etVP2P8GDPrOTKYk4V7Ykni1Z88RXXu9WEjWwAIm1UygiP9r6XlzPaS1t2gnuL4LwLK4ClhrVRluVDkPAe1c94a5SIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046297; c=relaxed/simple;
	bh=2XI8BNFQQcia93A1vsk847tO1cEzhUiNuFDKmsd9Fiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJPwiZDbM1WzsZIVgv9N1ibttjnXxpoctES2JMNiZyrJZjPa1ShWJgrp5CPOE/GNJQCvvnEOLVG/TXVtGCwk2fgxX93xhuUfi96Uib25KnxB1YF2Arz6VYUxthtmSe5FUx9OSXpAtmoItz3jkDCrlCabs5+7kk4lpLn3fPFKwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EXgAnhfj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSbaSTZE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EXgAnhfj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSbaSTZE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A51FB1400069;
	Tue, 14 Jul 2026 12:24:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jul 2026 12:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784046295; x=1784132695; bh=/IFBFVvV3q
	cMxOkSbCycUvuyccuxkduNOZfpj2KElSQ=; b=EXgAnhfjUmUdQl5W4eWR3Mx6uX
	0puv8YF3HI+djm7p0UVvxEvgbVzbs3Z0LPcqrzmJDMK73srZnmJc0NK3oZ8J7xMx
	JmKlfF4XZmiUJMIjvBY+4pkr1lfBfjgX8ShO4gJb2/EzEbU65aOO9+PyubzV5dtX
	2Ly3xXbs2AqFZYJnsjGMSnIess1eCPHHU0BLDaK8c3PQwMs9rThMWYbNEQ3x5310
	tu1KbhPyT/A6Xl064f/Xk1/7aGm+jatNHzDWrPe3DeV+245N/8rik30RSPrqKBhO
	n81q5LOvBCQIknn/rvwLWnepxtlzbN3He/Ue9D3J2KoXV9PtsOKQ2K6JiKOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784046295; x=1784132695; bh=/IFBFVvV3qcMxOkSbCycUvuyccuxkduNOZf
	pj2KElSQ=; b=KSbaSTZE9oryx3iBp4DQRNF3XXF4fNmG6Jm1ESxdVqmw4n1aVnX
	YD4wKpSShJwm09ksf77HRfyisq72fAuU91mdjx/geeSF0f3EnILUhxGWx8FRXiHX
	jdncBIYKXmDCSimip4klFbv35mGz5h2eQVFtVJMA5NWIeqS/SO00bRxWM8b5kccW
	LBqjLw0xCc6vY1iwVGrhV//ievueEINs/u/K1FLnTuWjVFNHWdi9BuoqoZI1lvsg
	9FC50sHqZIyu19dgj7jOqT1dKM7tp9wjTht2kjMG+NsYDu9ICsWgNnZb20ZjPlFI
	QHFtRz84BhPZ6UVbr3IO3ZKaiSEd1SdNTGA==
X-ME-Sender: <xms:1mJWap-LcmND9nxfdoElS6TS2nG-a1vVXjXDBItkqjo3C5NG42Y3Jg>
    <xme:1mJWagQtfgzIUwB5V3P_V9hde91wP37A6JeRuOrLT72x1gmaxf4CszdLfIybcX8vK
    rBE73gsLPOE86TjZKL8Z9hbszXkkxkYVz0vqj_8y3JBfawttb0xUNc>
X-ME-Received: <xmr:1mJWaqqX-CwV_BGnI7xnpu8EEGdGyjN7dEfFBpTfCZxrrcbkdUCjplZHyAgpN1Az9pWXWJSwIfvEcLnkqfLQd8acbg4QAEt0NyYFS5Y>
X-ME-Proxy-Cause: dmFkZTFsqQrjKwYrejCexP6MoZNYm2PhuC8nv/VenJV7FA4KzvhmKaVaQx1oE5yC8y9Xmq
    iE7AewcSIemCERQTZjXIE/kLJCUhOgYVponYEvhatpU0CqQCun2t3p3axtjzDVFaqIUc0l
    6kHXn0wKHilj11venG5CxFAVI6GCSiSFVClGe8NtEtgQJVxIdQqSDm06UOpsMME0bFM+2c
    TPoue1y/SqoBH4QRZKOYxkHlpbpw9u0ZYNZrDi8RxB7xa5qSGxcRKfqv/RObq3nWdn+0sX
    E9xljsXOlvNp0AIulnfk/BSQPZzhVfRcVn/AuVR8lARsjo2u4r2UrpF6q6qZovAaHesnNm
    OV3wPtYnOMNe9Jv79Y/f3Hq3s0GcS32QqG4RoODLOzTjiUBVS9HzWlFAw1/ei/akzC3sXT
    xAJ1MTJhC6brFt5+atOtDYWOrut+5jLcPnCU/0B9P2f7RsWvul92vk9QMbAUsDvC0iim6Q
    an2QZ9M5rVsEKjxtuvNqO+u+CR6EFWwnmVBSeXzsi04pImZhzSLm9KN9g6louVNGqqAz4P
    jnSs1tT0Gt7R9WzP09/G1yKYycnTpbCGUdfK2KuwppJ985nETQMI6SC4c9fcTjx1lO8BuV
    /D7uWEDBQOLh+MP0v6W3fnXusQxSaCl+2oIl/iuFlrrm3h10b06Hi7TJclmw
X-ME-Proxy: <xmx:1mJWatkEYMiO-lW3exG3iGFoqsxID2-CAlbWfLJJl6cOY_PDEq9IMw>
    <xmx:1mJWajc2ybwfp9jj4JMl0BsJOUEMuncj5yvJv8v44GIAsfyfjRjVUA>
    <xmx:1mJWapo1t-Y5DVPnBHB7G1VsIuDhc_Yi8oi1ldR2zRPAEX5HrwBP3A>
    <xmx:1mJWatMqKZW1c6g5P7ErKlPKm-5g0XbmZ2PGV8omdQ5384UTqeKswA>
    <xmx:12JWal1Y-Gvr-QhPwwrBwhO0MsEFq75NDBkL5Zu-QsVwatic0649XW82>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 12:24:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  pabloosabaterr@gmail.com,  cirnovskyv@gmail.com,
  szeder.dev@gmail.com,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v11 06/10] environment: migrate apply_default_whitespace
 and apply_default_ignorewhitespace
In-Reply-To: <61ef1b0a-72e8-45b3-b6e8-46eb5b34ea91@malon.dev> (Tian Yuchen's
	message of "Tue, 14 Jul 2026 11:19:37 +0800")
References: <20260712111734.1073514-1-cat@malon.dev>
	<20260713035738.1606138-1-cat@malon.dev>
	<20260713035738.1606138-7-cat@malon.dev> <xmqqa4ruyhbh.fsf@gitster.g>
	<61ef1b0a-72e8-45b3-b6e8-46eb5b34ea91@malon.dev>
Date: Tue, 14 Jul 2026 09:24:52 -0700
Message-ID: <xmqqcxwpv8rv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> On 7/14/26 00:39, Junio C Hamano wrote:
>> Tian Yuchen <cat@malon.dev> writes:
>> 
>>> Subject: Re: [PATCH v11 06/10] environment: migrate apply_default_whitespace and apply_default_ignorewhitespace
>> 
>> Are there patches 7..10/10 posted somewhere else?  I didn't see them
>> in the thread (neither did "b4").
>> 
>
> Oh, I didn't notice that:
>
> 	Died at /usr/lib/git-core/git-send-email line 1665.
>
> Will resend very soon.

Thanks.
