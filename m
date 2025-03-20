Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCC1E32C3
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487066; cv=none; b=TcMOqL5qtMfQ/jYmt1wy7El3NubPaqILuoEIU2phyy+thlPZYlDQLlLIdQv4rSvTT5CwcJNZma9nAyzBG24W74DvVR364ez3kajeIBHqsc4lJQhKRSsPTHygT4mw9UQKoiaDKTGpSOrA7XXgh2Ex9xThu+fiAhWUvlhxr9qXRbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487066; c=relaxed/simple;
	bh=5kSrwi3UvKwq+W0+faUlt87fLBzFQMq3KClY0uJVZwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7Tpl0i/5z9nBMRYY+aZQvx2QSdAHRDJr1RO86GE/2392vEHU/wt/WFSY0L07EoxMDCfuUrWbh7J9rQuNbt8tUbHrgbSez89aBr6EnZ36ItcnmIrHrITwjrxHX8DFITuvnjILjhFqMdIQMtYu6HSAnxNmt/xAhJAWi1AR+PBHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUyucq7w; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUyucq7w"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso910941f8f.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742487063; x=1743091863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kSrwi3UvKwq+W0+faUlt87fLBzFQMq3KClY0uJVZwo=;
        b=aUyucq7wDApAyZwz6wAe1KnM4lBO6rA4DQHhceIOHVJS7sYj+op6lwS47vLCkHRwsP
         xA7yQUuDuREX+NTZ0W0Lc8+rU4GUKfWrL3igWnAs0k+SBmO3PHXBlovfpViJHAQksjle
         ZOuO7xQgEHb0w/higzAPq4sAoNLooUxi8rNHxyw3tUJ1kBA96tmFf/Aqvi7QCwpaWmDS
         O00vspCUNEsBtXEI8Iglg+1umIBU54ta5Cmwkkfi6n73sa73e6KokOwW0yFB3k0a5lVg
         WRhUn+MpQMACudOz0prc+1VnRRSz3CqJDT5BQX/OrSKUL7co0RPi5KBABGAxX3rqxF8a
         ttkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487063; x=1743091863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kSrwi3UvKwq+W0+faUlt87fLBzFQMq3KClY0uJVZwo=;
        b=BFhY5/x88o7a94MoxjqWGqQJUp03ppnBJKUOeL7V0BbGKqK8fuh3JfXNrpux3tX1Zz
         Zfjxu2fL9aKAPGlfVhrSMFTbxWjTrUG/atoh3WsbWT7u5i+mq4ySvPmxCliF85pKatZb
         LW9OLGDxVGvcF1y+Ca1USADFxHE72sEXdJWY4ktMNnGSVfgn0ObQmeWlJ05oO6ttBkmA
         CiEbyjFHTWDGMASAbAR5F/LZp0aSCSoUm+uOl95M8ptpOb+VrJz/9Yu8GuiA7qikpmYZ
         1bkb/K32lVghMKy+b9gCh3cEYHcrFN88ehR1ow+YTwyhMukxkT/q4JpL0PRkU07ANo/2
         nOnQ==
X-Gm-Message-State: AOJu0YyVGe4CjfXP14NAnKXHKtpCX8wf2w9IrsWHMjEp0ZdKIDGAx0Jc
	eHwXDqce+3cD3CJPhmhYZgORnLERNIx3RwUE91QLWCIS5xTXVvE5DQGPQQ2SO3YlettcE40JZTu
	0LP11f5xnBB718tc+u7Xyn399IZkHGw==
X-Gm-Gg: ASbGncsEyDEuThHatuXG0deF1TfzkxqdcVy9uvu5HNAHRxOLHbfKDHzXso3Qs5kqZCc
	T3+pvTcVIVV81YiHeSyTBfLJN1dBsLjDHiLuAnhf03nWVqeNJwInPQR7bVegOGn4/jh3JhLuIp1
	MTuovsNXB2KYHbRw4toySgDSkEpkkN
X-Google-Smtp-Source: AGHT+IGaRkzdXXLFfEPlM4bMr5ZxYkhWjqgYb3SkcTDy0JwsDm8jXLPelA1ixZRlnB9Ju9a9T2lyHRukrSPuQgnoXak=
X-Received: by 2002:a05:6000:154a:b0:391:2ba9:4c51 with SMTP id
 ffacd0b85a97d-3997f939077mr76647f8f.44.1742487062443; Thu, 20 Mar 2025
 09:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742367347.git.martin.agren@gmail.com> <5f787ddac2d80391feadb8cf6be379fc8e58652f.1742367347.git.martin.agren@gmail.com>
 <Z9vdQPtmUiuobOP6@pks.im>
In-Reply-To: <Z9vdQPtmUiuobOP6@pks.im>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 20 Mar 2025 17:10:50 +0100
X-Gm-Features: AQ5f1JrFSs79uilmraq6ttWcglqUHKF5bVI3juXon334F2yBvDicH02putlyOCc
Message-ID: <CAN0heSpHZo=+ZwM5wJXQtFVD5jsMJGu8+KmRVcMDUT_ipgtMRw@mail.gmail.com>
Subject: Re: [PATCH 2/8] pretty: simplify if-else to reduce code duplication
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

Thanks for reviewing!

On Thu, 20 Mar 2025 at 10:18, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Mar 19, 2025 at 08:23:35AM +0100, Martin =C3=85gren wrote:
> > First we look for "auto,", then we try "always,", then we fall back to
>
> Nit: we typically have the body carry enough context so that it makes
> sense even without reading the commit subject.

Thanks. I'll add some context: "After spotting "%C", we first ..."


Martin
