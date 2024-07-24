Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90428528F
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809586; cv=none; b=evqi699F/AjK1DcLEdCpxuuIPR+0GDIC5tK3RGsxRMxsHL7BrEhpn6rr8lHB5Uf2xKNcvkVAzN+mLC1dpp0t22DpQDPzOEvC9AY/XaDvmQpdL+7TviF0/Z2lEUDkyUWcbDDbLFI1vc4uLVT8aaus+Y1x0gjJqkFzsDvhjJasmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809586; c=relaxed/simple;
	bh=aO0LCiMDct84RhXjjE+srQi74WJrA+WHiPYFvUNg1HY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rxAgC3bPOlnVFSD7gtO2oOgtsel9KZGhV5+OAzZ8hGzxdiNlk65HId7BpnTuSiivomUe8Fu3Qnr0R3u1Tdou9oPSyJPekf9PrahvQzifCD0IAezwnryBvjj148wogv6xhaNuvgdqVEVJMxN278jO1O/HNyQIkU8Q+KkbEGd9qq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=XiAlKlCD; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="XiAlKlCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721809578; x=1722414378;
	i=johannes.schindelin@gmx.de;
	bh=aO0LCiMDct84RhXjjE+srQi74WJrA+WHiPYFvUNg1HY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XiAlKlCDr6bpAtUjxvGkEYhXGlb+2EP+PZbqA3Go6UtCKzD3qTf9XqQeUPFRteoF
	 biBDdxotys3yA9iEFuIBI1stMNxA3IbNTt9vxS45OxTid9un55q4wqSJ0WU5IaBx9
	 j6jb0i+KbpMj2r6BpORAE6oW2OrIJQfmmntsBOk+XPaW65pbMwp6JukI7HNzmtszB
	 4If2pwsO/jMmkPYagV3hvzvJEoEhmrhXgOlBalc8mvjXy9GnlzAF5SyPqthUpQefr
	 BRjDN9/9rWpfZguFqtufZsl+LOXdMW9Xq2sKXk66YHIMjD+pZV2rtAib+WFX/hgnZ
	 VJQIfaWKWZvoTFs+rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel7v-1rya5P38Z3-00lIJ7; Wed, 24
 Jul 2024 10:26:18 +0200
Date: Wed, 24 Jul 2024 10:26:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Haritha D <Harithamma.D@ibm.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Build: support - Fix to avoid high memory footprint
In-Reply-To: <194BFBB9-FCF0-43F7-BFC2-B055351B5376@ibm.com>
Message-ID: <7cef2d49-2794-47d8-ca56-8118410aeb48@gmx.de>
References: <194BFBB9-FCF0-43F7-BFC2-B055351B5376@ibm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oehsG4r9d44/dLXNCg3G920NZXgPrJ+R7p/XPeICr/EqYWzTLm0
 0/igVHaqUoSBpCjK2Mssf26MbBrtCTL45dGaAIDDtpy2SZkTkdH7m3WAzW/nlIHglRYeBHM
 yARtMAEToQoCZASaq8/+FZl29QfilYggy/fmkqQ2VpxKOvXNZVYDTvlHuFrKnIugO5lgBvc
 U6se6/nEOiyWHvcahAPDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sjTKT7AlLl8=;SqjG37BBlK5EA1Z7eLNKakLR39Q
 ZbspLmGfFm1wTRS+vm/brVrCQvIE9KbDYrmjXEt3Clm75QWLP58VQKpcCEi2g3FT/sOZxOcDc
 H1lnMx9p0uXLkUHDNxFv4j2dCPVa8DD4q+f91S2fxpAOotkd5mOcPcNJQcsxiKNVfgJKMrmm6
 UbYkzASRGD6kZcMDpLHw11Gbsmr8NgcmU5P4a8TU78OcBiE/wAlCfT5gwaRaGrm5khkG8FtGk
 2GmpVFEIVjfBIOt829xcQfru4peryUEbcoWyEEMhm3QgEzGe/33Vmg2LaOv7ktgNYTwYOZGqy
 FZW9RaKtVh2/TT+7V7pE+XwaE9CvjDLaU9+rtSneTEfb+XOdkpy/0KlsGtYaqi0L5ylJf9RyX
 6jLz9hBDzWMQQXhVNXPLikIRUDf7iRDoNmXSfPDw4aG5KJ3VRIKg3q/JmS2dJVEM3cXQ2KzNR
 V/sE+xDTO9Px9t2i52jZoPIWp+jX7iFW/POtKLjhe4g4XaHx/wKxmKLyDwm9VnEXlWRmYweb9
 qjGJGRxLxrPrWWeRTFRPLauFYRvQa4qZvCQp63UD8yb9HWQ+d4DXO9v7XaqofKz66krxcTPZB
 PICpSkZq5bvNyCLEpRdt7znLlptIXGdI2ujJp+Gl8VzwzwcYRe77wQ2DaIqXXl7cc4rUGVWoX
 xij7O9yGngNumokZ5WbexLpKiUrvV5f2zYlXPm8wGWqKwnQRZJShjn18cbL8PKhmRUIYNCwqJ
 EPCEb550U3//yvX1ceeBVwYQC6mfQVeI+9VWMBoSGiZWY5pOTzyZK6dCRSER4zuR+Of41euJf
 U9s+c5VRuazuoFmbgxPfRmTNSLcjP4Z7dVQxMrmJbRQxc=

Hi Haritha,

On Wed, 24 Jul 2024, Haritha D wrote:

> I have raised https://github.com/git/git/pull/1744. The win test(5) test
> case failed stating the reason as "The Operation cancelled". I saw that
> it failed after 5 hours 59 minutes of running the test cases(build). How
> do I handle this?

It would seem that the rate of random timeouts and general flakiness of
Git's test suite has increased as of late.

I started a re-run of the timed-out job:
https://github.com/git/git/actions/runs/10043066326/job/27846613495?pr=1744

Ciao,
Johannes
