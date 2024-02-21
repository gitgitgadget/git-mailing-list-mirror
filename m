Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31F28382
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708491758; cv=none; b=hG/aEogoLimDoIJmCKteXr5cq497S9UsD9UEpU56z7T8Wq3H13IuCy2FMWnSSMB2a9bhbd9YOpN1wkhH4LPjoNs9nTQIuO/hPoQSLagt+cO92luHZzJDGU3GxetKjq5MsZeXbCG/eTUeZ3SPWj/hRqChHoHv0uhJN1MFjjr4KQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708491758; c=relaxed/simple;
	bh=0lgPUrOFaW3sEsErJIjx/lAVDl3Je3llfR2mtCzdiUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRdYHjM7crmPmiJKV/V2UOM3dlU5AJQtEaeqdq12KlNyn2q45N8xmOAcmUQiWlNYsQ1ZOq0mALbL9OBOwUSFRSBu+B68YdOzV9svuNU6MGd3pPyXuODt4R0h8cPvIwK7qEsVz8UtE/EnS2DRJfKLaxiHrRN0X1nTZCh2f7zc08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf96ZKgw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf96ZKgw"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42dc883547fso1614971cf.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 21:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708491756; x=1709096556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0lgPUrOFaW3sEsErJIjx/lAVDl3Je3llfR2mtCzdiUA=;
        b=Qf96ZKgwFz+wHIkRV0Lhx3RWO8MKP8VSMEI4lCeWbvcHRecmQFSCG2N3H7YRMlF8xB
         WJoGkOk7uLuQgopk4LZI7RNWqiinQNU6q387+UROxkoDYgca9CoV6041E1wCJ786lYQs
         A7alzbXC4513m7TJ9gEYbv/wQqqDfB/w2kuyLw0x0C0v26cwefsubQ5TPCnieICINdUU
         QraEqNQ9Sm9j37FxFJEnHI+OMcFHA0M5EQd7Wt5msqUg638CoeA4GP+R3HWLPNc18obO
         94lJEbYtrXNmKrjTn/K98qOBer1PfIspqcO2t0MTnT3L4hsf/H3TZmYxgxkl10sO7u3y
         aBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708491756; x=1709096556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lgPUrOFaW3sEsErJIjx/lAVDl3Je3llfR2mtCzdiUA=;
        b=Qg3dNfL0cTz2yjpm7XM4On/w9b/b6BslQKXVxoxb0ts96EnVA8cJLzBL2PDchnmkxB
         /4SeQuOaKpBS6oMLP+OaI8+WnQH/sxO9HkshED28pAJ6X5v+geYl78kWy+50wmAa6iwc
         udy0DihefWWk/KDa5ghHoG0Ic1X4bZwiRmWPx/s4Rq10lAKReHBqCZtd/KeTA6jYxGm2
         Hl12mjVrRtD56ECIUvpr4wLU3JsV/eU7XjmM5U2HNdVdDn/asuZUEvgkxhf1NNnXPukQ
         PzsqTbKCKl7UV2pIR4uXw2pDTxiyRtNX3KkxrYGojZs5FWgjEV+jgMIVU+AjRBO9ff5K
         sJqg==
X-Forwarded-Encrypted: i=1; AJvYcCV7xCUMEyXukO+0497OnBgymHElYdR5dU1xIDMliblV6T3P7IQk+4Z/FVm8mwKm48NucqgOVsqRIUWt5fc9OpApfsa+
X-Gm-Message-State: AOJu0YzCagHktmYhOu+QLkJMmAAUjCIyiiAY0i1aoa6E3L50DDV2VZxa
	tpkWu+yVm3CLR1DAgwKY/l1/UL2j1vvgUXsXcZuBkXNAy+AGspHwMLqPfVtDfsaNU5luHn2nfTC
	X533AzQ7rQtXPSJsMwfRJQKSX3wQ=
X-Google-Smtp-Source: AGHT+IFUsI3/W1nSFMeIqkpLHXPfDrZf2qPWdaJUMCxrIwG16Y1vQnIDyp8oJDlBeLpukA2T0+dExdeGvzqm1YseqcE=
X-Received: by 2002:ac8:5841:0:b0:42c:7e8d:9958 with SMTP id
 h1-20020ac85841000000b0042c7e8d9958mr22950994qth.11.1708491756417; Tue, 20
 Feb 2024 21:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com> <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com>
In-Reply-To: <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Wed, 21 Feb 2024 10:32:25 +0530
Message-ID: <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"

Hello Christian, Patrick, Karthik and all,

On 06/02/24 00:09, Kaartic Sivaraam wrote:
> Hi Christian,
>
> On 05/02/24 22:37, Christian Couder wrote:
>> Hi Kaartic, Patrick, Karthik and all,
>>
>> Thanks for creating the page!
>>
>> I have just applied the patch Patrick sent to the mailing list with
>> the ideas related to reftable.
>>
>
> Thank you! I've now successfully submitted the application for Git using
> the Ideas page we have :-)
>
> Let's hope that we get selected this year. We should know about that by
> February 21 - 18:00 UTC.
>

I think it's time we start being prepared for potential contributors who
are interested in contributing to Git via GSoC. ;-)

On a more important note, we need to assign Org Admins and mentors for
the 2024 program. For now, I'm the only Org Admin for the 2024 program.

Christian, could you do the following so that I could add you as an Org
Admin for the 2024 program?

"Visit https://g.co/gsoc site, click on the 2024 bar which will display
the 2024 Program Rules and Org Member agreement, read and agree to the
same."

For mentors, as Patrick and Karthik are new to the program, we need to
invite them first and only after they've accepted the invitation can we
add them to the program.

Karthik, I was able to get your Gmail address and have sent an invite to
you. Could you accept the same after reading through the program rules
and member agreement?

Patrick, could you kindly share with me your Gmail address so that I could
invite you to the program?

--
Sivaraam

PS: Apologies if you've got this email multiple times. My email client has not
yet been able to deliver the message to the list. So, I'm trying other ways to
get it done. Sorry for the noise.
