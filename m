Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414C155398
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743338179; cv=none; b=ROnq1Y0mZAvULKKTUyjgIUZtrHxLprNEMbYf9s3RrZXwJ+gphmrZi/GPr5sAYblo9J0gIUKRR/7JPT1YL4hbEe3hLlNKfAbwqJV6A0bYNsm/PTGfTkTSlpEam5rijfxfTJXyWTBiondIH864AkxRz1WluftC+PGecdp0klOnPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743338179; c=relaxed/simple;
	bh=I8ErgO19hRqx+Ce2BhR5xDi7hEHFDdg3f98oXqFR6uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sk7CFWB9tkYrlNUBOhCt4Ci+0cab2sC9sAd3URSwwFy1CA/fy0aI6yphkBWeE+57+/y6EvMFsKRG27RBCm4bc8uLv6t3FCOdi+dlYB9unCZg5/ZPbS/Jt2wJQKJYJKo/4H9fHxRjgt6OfHpi+Hz3ohphJzwwyUi8vbyTWNOCxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c04ufwGQ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c04ufwGQ"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c6f6f75a81so2023999fac.2
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743338176; x=1743942976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uqcSmnQcwfA1YT0kyWMS1jZ3P1KyAASYt5ePPFOG7gI=;
        b=c04ufwGQIjTMFIEzsUQpDs/2kNwaaV48K4ax/gG1uicJ+5kOQFbm/A7HsdNpupWD/x
         51K5oVewWB52VCPsnDzsjAoJn56DxbjSjpCDzDEoaJhz0CwuRPiVHPA35+5Kmq/ZbMZ1
         YeTpsQUbUKrxLMXSEi/C9fqN4r/iyOlETL1zrb0OarNcZZBjeh8P4anPGIxSpZANDXcI
         TilaOKfQbj6FLuAYoHBcPA7AbCRQVwGYxm7e/ConnLxRI1AW+wHsQu6X4gshtuMcp2Qd
         CzSxiDVZ0PajyTW0tNgX7UkB7zxL0t3vP9eEPdfcBsmS/1OTnfmuR0X+LjM5QQObe4Tj
         AurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743338176; x=1743942976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqcSmnQcwfA1YT0kyWMS1jZ3P1KyAASYt5ePPFOG7gI=;
        b=odvV4JXYNcFiQvj5q1z/M0Tyr7hv7bzFEzqDuDyYU99I1ScWcbzfKtBrICefZJ2i7e
         N4hIO1fkTOdwQ4RXqygQlmW+Rbwet2rXKZj2MEdFL3LQjASMBvK2MzYmGI8HqP7u6fUH
         CNTpIYOvAIiUaNo1DFm9r60xK8ypN1pnKQgviqcVJUJglk5MM7U4pNxNym2P/Z/9FFR8
         8c7HmnHDS+ScDgpUZl/t7YSvQ0LWTowuXxtxdG25SdeoYoz0hVzf8DB/RHl2a00bNuCd
         vKBJV17Ke3D70cQrngeRIyI/6Wm+eQIxD3iu6xDbCeoqtRLRznLvizCwNcl2sUqv5R1Z
         KdzA==
X-Gm-Message-State: AOJu0Ywdvu7UsWS6p26Y2azdf3k4+UQPhF6kpxNEJ4jeFgSxu1kfwI5F
	PcOJUIalmqLBl/LH1pO7DUU91WMRtujstKpVN8eJ0WfRoePqLa9DWb8DZrdcOzzx3w/KR5wQRGF
	9wR8gYU7VpBGXWd2eFm0KH8U6xt0=
X-Gm-Gg: ASbGncuOj32d4qxE6OUCASc4DMiqi+mUWFJVrxkkuva9Lo2bufQpOHNiQA0kuHEc/m9
	1bY3ltm7TRWrrXzE2lhMaByBjPt5D+ZqDDECZheqlBBjxkcOp6d6p0rV1aTqCXlZ9xwleYhqN6E
	ytN0hIG0QdV2XB6dvoz0pwr5nPHwU9vktiHRdafdel0O3b1YAOIqB1FuEYU1uo
X-Google-Smtp-Source: AGHT+IEcn9WT0YpAtox8i2m+yrq4eCW3LmXVOxRIP5D/lbnujY2Qy9629SIl7bIVn4L6KGxB6tM2ymzXQy6NQm/VTLo=
X-Received: by 2002:a05:6808:10cb:b0:3f6:7cdb:6557 with SMTP id
 5614622812f47-3ff0f5b410fmr3200084b6e.25.1743338175872; Sun, 30 Mar 2025
 05:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218153537.16320-1-dhar61595@gmail.com> <20250328200525.4437-1-dhar61595@gmail.com>
 <xmqqfrivd4ei.fsf@gitster.g>
In-Reply-To: <xmqqfrivd4ei.fsf@gitster.g>
From: MOUMITA DHAR <dhar61595@gmail.com>
Date: Sun, 30 Mar 2025 17:58:43 +0530
X-Gm-Features: AQ5f1JotNR8aci7x7iCPA_wUTHv4Z6GckXyi5EmkRcwA1wftHfiAoaSpeQcNnQQ
Message-ID: <CAF=ncLYYcPD=17FBUnnWLW_UmwkasSUzKWm-ZeHjAuWeiF981g@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] userdiff: improve Bash function and word regex patterns
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
	Eric Sunshine <sunshine@sunshineco.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Atharva Raykar <raykar.ath@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Mar 2025 at 00:56, Junio C Hamano <gitster@pobox.com> wrote:
>
> Moumita <dhar61595@gmail.com> writes:
>
> >     + ## t/t4018/bash-bashism-style-multiline-function (new) ##
> >     +@@
> >     ++function RIGHT \
> >     ++{
> >     ++    echo 'ChangeMe'
> >     ++}
> >     + \ No newline at end of file
> >     +
> >     + ## t/t4018/bash-posix-style-multiline-function (new) ##
> >     +@@
> >     ++RIGHT() \
> >     ++{
> >     ++    ChangeMe
> >     ++}
> >     + \ No newline at end of file
>
> For these new test, is it essential that these sample files end in
> incomplete lines?  In other words, are these tests trying to make
> sure that the function line is correctly found even if the function
> body is at the end of the file that lack the final terminating LF?

>No , the skipping of newline at the end of the test files is not intended.The tests are only meant to check multiline function detection, ensuring that a function body starting on the next line after a line continuation \ is correctly recognized.

> If that is what they are testing, please add comments near the
> beginning of the file to tell future developers that it is essential
> that they keep these files end in incomplete lines and why.
>
> If that is not what these tests are checking, then make these lines
> complete lines instead, as they waste future developers' time making
> them wonder if there are valid reasons why these files must end in
> incomplete lines.
> Yes I will do that and send the patch again . Thank you for the feedback.
