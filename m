Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AC2DF14E
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550873; cv=none; b=FlCKmhsMlOeornKGrtxKBC1O9wqAMKqcFE6IicgSUKy+v6NZSdpMANNbc8N481fpLNAqXRR4lzXOTiqPlNMbQsTw2Wd1VcumP8kI5H6/SZn5RLwgWZzhZdQk+32z6EzNcDZNkvE/2DySIPPQXzmU9Xgv6GQblZLvgEszDn/mhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550873; c=relaxed/simple;
	bh=LME3NJ7Txrot3JlZdKIS2JaJ26MUFnOprgsijG9pPgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCZ6zTijjShfta+lTue55zhWthC00ai6O0SFY1Nu3co4SNwvrNohpMB0quSvdFj77EbGnujHbsS7QCZCvo813vFmfTx5XXgkNgoU20XyJOv3Ldfbcggx6J1p/wwK8aRBJ9wIfaHApAdFtYfubU2fOQi/CPvzUcZJIw1BcDmCrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHQKat2N; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHQKat2N"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932cf836259so1780343241.3
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761550870; x=1762155670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LME3NJ7Txrot3JlZdKIS2JaJ26MUFnOprgsijG9pPgI=;
        b=YHQKat2NYZxHUsuc3Siak22okJ63/eFCwEnihzplHBohZn6IRNVXmw/95jayJ+rsPo
         54xpzfHI6/aYhU/B1VxSRTSqd4p9fs+htjpLhDCKgflzhu7oSO6hBSWgiWKlH2W4J/C5
         218CxglW1ALgKzzNJ4TGkTApogfMH49uqqWbd4dRHN3Sv3/0lIa9HkitbFtPeZZaOVa8
         NC8H9roj63qwQ7W9nNXipFCvUuHl3S+YHlPvRAkuymz3EhI/8kDvt5ezhMUHg7LT52Gd
         SC2K0+mFte5pEqRW+L4iPCOwdvHT989bQAPOBnXKf1Cj7l6xFpS06wwCE2bCc07t/B3s
         avbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550870; x=1762155670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LME3NJ7Txrot3JlZdKIS2JaJ26MUFnOprgsijG9pPgI=;
        b=mLe4GH7QMwgggH/INxD1SzsqAApjx77lyQeYbo8/khjsXQBZaUNls1PyOB6opsP7VC
         FMCPNHPWUycl4iE77b/Ebt25YOUEN3vXVOrVRSGn5GdO7BgRR8xY2TQCigVP8Xbaq/YU
         NdthgjLT0QY6OkpUibfsUoB6DkvbuIaS13nV1Be77KvXyLP/8uGV3tmN+HnFBjB6coLA
         6j9JkZsYU3j66krwF2MEgumWJ3/lkKtJHULkBNyPj99dKoHVZ75890Kgk5FzLU11161Y
         lVeYiG0bc9QbznzdGdKBgg7WX0ik5Ye88jrlqS5jROyj5BguCx2AR38WE3t6Avb5F2yF
         RYRA==
X-Gm-Message-State: AOJu0YwtQtPM1H4GaU2yVaRR38ccroDDNd8KimIqukeb6bU+QMFOeNB1
	YiWF+Ewlpkt1lpZccL+r8w8g9efiMb63eCNvBqaZJwoMUv6njibymyFSTG2rQzKgAJSX8i4pRKJ
	nBJ3NlWqVL+2XWJkDoOzFthmbQRiUpZs=
X-Gm-Gg: ASbGncu6uIpHJnrTlI6kDrASYY8rXQ2R5wlbgbVUGY5rpmJeMlqrF1FpMB8WIu1c45w
	62EECELgjWGCTbPjXFKRd8tL4a40YhW8TnTwfOxy+Y2+PrCuqKnYQ+bsXqMSs2GUIe8+TE+FT5i
	8Rg9xl9CU+s4Gts/QEGplkVhS/VdocUP8htDaoi+5z/qtBM0CXRErFdnG/JTGSAS+jRTD9rzDWS
	cS8xiAKZvHDPcrbOEk1utHm5afZQXZn/8Ks5K8p9mxfsVD8DwPo6A2uhdvdurGqtcclx/76rQR9
	pUBke04xZ+tKhp4l9d8X1i9q11Q=
X-Google-Smtp-Source: AGHT+IGMhjKehJurcCnZJd5Y/B6UbUz3ajHg4115w/e+HWtoM1IS+NmhzyN4qIMjce+BSxxxmJoVT6Jp7h7JUdgg1ns=
X-Received: by 2002:a05:6102:dca:b0:5d6:214c:354 with SMTP id
 ada2fe7eead31-5db2e446e33mr3752604137.5.1761550869566; Mon, 27 Oct 2025
 00:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L-Pr9MtQ1=Wrm3tybZFWKDUtDpVcOahoFUgdVcGKJm7Vg@mail.gmail.com>
In-Reply-To: <CAD=f0L-Pr9MtQ1=Wrm3tybZFWKDUtDpVcOahoFUgdVcGKJm7Vg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 27 Oct 2025 13:10:58 +0530
X-Gm-Features: AWmQ_bnAWc1PzismYLXCtLlzSLApVFnDwVAracN80LynPgJzRTt_rtMl-EQkwpU
Message-ID: <CAPSxiM9o-rM63jas8YWu6_-ELrzvsQTyhUs-PXDkmgS9OFe5jg@mail.gmail.com>
Subject: Re: [Outrechy][RFC] Request for final application guides
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Hello, I hope you all are doing well.
> I'd like to appreciate everyone including Christian, Junio,
> Usman and Kristoffer for the guides and assistance during
> this contribution phase.
> The deadline for the final application is in exactly a week's time.
> I'd like to know if there is any new information on how to submit
> the final application as the Outreachy page requires us to record
> a contribution by submitting a link to the contribution and also
> submit a final application to the project.
>
> While going through the mailing list for previous final applications,
> I came across this thread
> https://lore.kernel.org/git/CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com/
Good you found this link.
> where the main points regarding my questions were answered as follows.
> 1. We should use the link to the microprojects for the patch reviews as the
> contribution link.
> 2. We should specify the current status of the patch, 'master' or 'next'
> 3. Send the final application to the mailing list for review which should
> include an explanation of the project we want to tackle, links to the
> microprojects and a rough estimate of the project timeline.
Yeah, correct.
>
> Is there any other information we should know of or is this good enough?
There is no further thing to do apart from the above.

Importantly, ensure you record your contribution on the Outreachy page.

Also, you can check this thread to understand the format for writing a
proposal to the mailing list.

https://public-inbox.org/git/CAPSxiM-YAAMwOvH8KYO+qKahCBHgw-NDb-eHJKNCZyk8xtpeGQ@mail.gmail.com/t/#u

> Thank you.
Thank you.

>
> Bello
Usman.
