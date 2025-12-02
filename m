Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C433F9C5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684937; cv=none; b=L3HMaN9H7MlmZsCadT5FeSwSbTcwdHjLSseoviVSG6X+O4IXonMmG8uIprcwD8wOpf3wGT5NtyIEYN3J6T+9yrqu4SGyH1yqf4UfddQM1k9RG9biLEYLPdyKjSaRSmb0y4jno6ioCHjT31ZkEuVCf0Qy36xlAdMCailaxIIQ0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684937; c=relaxed/simple;
	bh=1unSlbc5aIxlq2DkkN6EgG0dRCcXvUMTF2eAly2admo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfYnIVIq1pjLpCPIa/c0+lavFCCWE0NxPSdzvdJjeLMcUJxfTB63l/MpJtmkeu5beXslAvdkT5hGXvCQ33jVIcQWh6ZZ2GHF+zpbupvQFMQqGFWmyniEQ95tl6JuJEQGF3KhcgTaeVpf6EjDAuoRwGX3XZsTj6qSxEQ/4qxgx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5RdYy8p; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5RdYy8p"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so9557001a12.3
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764684933; x=1765289733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1unSlbc5aIxlq2DkkN6EgG0dRCcXvUMTF2eAly2admo=;
        b=D5RdYy8pbE9hgnEJbeKzIxzGv7QdQHPBa2AIugDwTlEii96Ta241tK/AVsXl4C7ZK9
         98BFwJ5uubGuHS5yFcHwZS0/FUAgjsoWoGfJKpdJzLHCUamkHZ/M31mSfQ2vPHLyq/mm
         8ba3Zsk3qL9psjvxcF/aOXUtkKhC6Q0+7fMcrI5aaJxHOcMIOFoRF+tGgPt/IH0tVp8j
         a12NuVPetb6ftTSS3eKnHRa9R0mOqPKm7QjsWR1T+OYf/zTqwtsb3g/Kw5/swmNZPC//
         YH19IZXSWosi7oTXyCrM7m2Kj2yvQ93EH42Wk06sBjmldtlFcwjUS3/3eK32rsmqH1rJ
         XuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764684933; x=1765289733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1unSlbc5aIxlq2DkkN6EgG0dRCcXvUMTF2eAly2admo=;
        b=Eje5voyDRTL7+D4nIBThTHW+na47vl2/UPAbSLQYkiSY5MVM+t2aDYEfEJtCRSq5qp
         VFTGm09bdrlXR4K0zR6WMTHvUk9+AKyr7gGMxCV+zbt1nLZiO8GkI4TMidMaTRQLjt8Y
         OYaQ5ppXwEqDkxCKKnLClv3EyicBCAa6g1xnfTLNtpLSrflXqwZZuB8PSkNpKNgpMSEQ
         EWnP90o8bwTDNb84E6L1C2BXmCDe++uxf1htX6+qKjW4tiqo/IHJmGOlHgIFvh8Uw4nc
         drBudb5GB8B4sC42V5FVLoX/gjW1YorTvI6hYr0WDoJ2YCndww2st7hSw55dKHW+Bgu6
         4XmQ==
X-Gm-Message-State: AOJu0YyEvYcr7EXWljhSHzMYGppA7oyWc4qpmzLU5h4MBityU+tWFe53
	wQFgFez3UkyclcX7VTbQy7gBN8aLJiHaImwMyeA0Il0skNgENBxKYi0nZ1NU/LnibPmKJpY7ZUe
	ygrjAgKubSEqhtJvAJ2XbvfM8ZKyikZNTwg==
X-Gm-Gg: ASbGncs/ge0CILpTJQoq86+XJYDCn6n+VuX7qU3SVb/aTRjAH+tK/NqFeSQ8AWI92JM
	5e9JBm4UMWv3U6ly4K2Z9t3BKOH0hEALyKWBxCkIAVi8VbyJP+TAkNQKG9Ck+9MRj3durGlgQsU
	+ZwnZajA5QWExFs5OazKXCBesIvgQlJsY4EWj9b3dhKnl63hnEZ1PcoaQPQWAeffzH5sEtQs8h+
	Yjb6/OMIDETpZGJuY12zM6I26hqRHGigQIvm1ZSqakULPTn7nF/qfMG1/axqsyDeJNcUnw=
X-Google-Smtp-Source: AGHT+IFVnTHI/06wcf2w2O7SSn0ADSQRhaqj5djlnU5nYyMge3pN+wW2qnG7iPFfdz6nK9tMTBCv/43USQ65l57V7+k=
X-Received: by 2002:a05:6402:2691:b0:641:72a8:c921 with SMTP id
 4fb4d7f45d1cf-64555ce5292mr37082741a12.23.1764684933034; Tue, 02 Dec 2025
 06:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
 <CAPSxiM_0TXR268AfQatBhTdK9it6ep6dTFd63EEOW1qtQ5f0Zg@mail.gmail.com>
In-Reply-To: <CAPSxiM_0TXR268AfQatBhTdK9it6ep6dTFd63EEOW1qtQ5f0Zg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Dec 2025 15:15:21 +0100
X-Gm-Features: AWmQ_bk1GT6j3nXUcNytHV6YyY-mmeV30K9sZH_kFRh60rH2trH0W5c2hPcNTe8
Message-ID: <CAP8UFD1X_gkSnNdjutB8JVdkUaHTWdY9XiN4yEDgF+8JTrqD-A@mail.gmail.com>
Subject: Re: [Outreachy] Git Internship: Refactor in order to reduce Git's
 global state
To: Bello Olamide <belkid98@gmail.com>
Cc: git <git@vger.kernel.org>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bello,

On Tue, Dec 2, 2025 at 12:21=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Tue, Dec 2, 2025, 3:10 PM Bello Olamide <belkid98@gmail.com> wrote:
>>
>> Hello Git Community,
>>
>> I write to you with great joy, humility and gratitude to have been selec=
ted
>> as an Outreachy intern for the December 2025 - March 2026 Internship pro=
gram.
>> Working on this renowned project gives me the privilege of working with,
>> and being guided by, some of the best and most impactful engineers.
>
> Congratulations on being selected.

Yeah, congrats!

>> My appreciation goes to everyone who guided and assisted me during the
>> contribution phase. I have learnt a lot already, but I am eager and keen
>> to learn even more.
>>
>> In the coming days, I will be working on the project
>> "Refactor in order to reduce Git's global state" and I hope to make
>> significant contributions both during and after the internship period.
>
> Looking forward to your contributions.

Yeah, looking forward to working with you soon.

Best,
Christian.
