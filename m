Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463020D4E9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938574; cv=none; b=N7GNY5rh0UfvxSP5S2Qz5XYkYXaHykmfO2l1F9qMTDAXbnYJ45nh9q0Kg8DPJo6F2crhy8DGTCuDn5EBTV2LuvEo6XbaNUgkt/gbT8GBnoRQR/WMApcOSfl43tNQ7uvyGsw1k/0Hc1R0siVwijZh+cwiv2A+BHZiry7PMKspTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938574; c=relaxed/simple;
	bh=4y2wvV59/Nihf+ekn0jCKbxVtoI1TApgeNUcxHUiLl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVJJrJAy1Pr2p4fo2WcpdD5RTrCLFdbpfhGJ36JQZjLtyecUvUcPR2YzUUnRAzDG2Y6/6Zi7vwaIdR7y+lrCz1HRMABsMB+fSU3pdG1usJiMQcjo/dn0Lih5YLmpjPBzpIm3au11yc0YLfcWh72pJe04TUQ/Q6tRMnlGceB6aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJdaP6Rw; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJdaP6Rw"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-930989f9f81so974090241.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938572; x=1760543372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y2wvV59/Nihf+ekn0jCKbxVtoI1TApgeNUcxHUiLl4=;
        b=cJdaP6Rw4Hu4JaGwodoE+u77Fdt08sCi5mgpjxPT1aowgQZ1Qv5McqqmXUheKKpIRj
         cqbb/lRcFeYZgOoY+iFT5z5M/fj05JjvsW/j3w9iRuTbf40aNYzpZ3TMuagWUr9ptuEA
         tl7GTMJXV4VZKM9cCAtBDFaxNxyiMHYAaSRcg5U18ap6/DtWSuco9zj1Y4fo+JnhiYB8
         XrkGlAYUCQFCmuouYehHho0/oKIHrsptD1m97RTC3fma0B28pMn2RJxmU6tg2YriH/65
         U1vhRnZJclsfhnyJePntvE21zKb9DpI+0HSJ06CV66eoptVE7h+WcfL7xmMCzUJXSlHC
         yPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938572; x=1760543372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y2wvV59/Nihf+ekn0jCKbxVtoI1TApgeNUcxHUiLl4=;
        b=WJWSwn8w6dN5PFlaXNm0RZG4NsRHn/O/UvVqhzKogmuFaxmIE0HNrHzQ2x0vR41Cc2
         FWf/zpPEC56QvFINoIkgFN3/XTijDcJVbn4D+RvOC376QccGYDfM9wxImybCsYyrFHcA
         3fKdvzPdZAO3ajARitCnn6kdV2E1ksqVYnmtQWmzry/vFyA7bzNYGrG4vdWNWu6RCER9
         7yziwQWJazAWl/LqKScAhqzThlESLDBvAJjqIn+TqPrz0EoImtMTaL3Dxfd9DRfpXjyz
         FEg0PQE64RN1pGtPhSTzbIQlLljSIGIsJBAOaZczEb592uuGyJzrtZBjOh2Emq4rV42+
         XB3Q==
X-Gm-Message-State: AOJu0YxMNFehKaXI94gHk7tzbmhnf+hOEDZvJpUbh5tfmDaFwqozVK7Y
	olAdCHQpWaOcq43LxkOkul8ON+DrKP5Stk/kjkAFcis3eTI7oGy34zW01EuWV7Ac4DeosykX1cm
	InvAnGr+Oq3JYoyLB3j4K1ftIAAhUdK0=
X-Gm-Gg: ASbGncv1V0WJWMrz2axGTzb/SntOnixpIkhA4uSaZFmJGfPXwrQSMYCVe8TP4OFW9vv
	UzEn8ZMddPEpuAST7WHenIT1fAsyzPOoaE5UrDovnZK/1H2qg9ij8ckWmteZYZx05P08EbtCS3k
	1seOc2xxN2EaEwv2TMxch439a7L/4KTVlN190LBox5RSKXzDsqblDUgUWhP15T7vOWVOl7CL+Jd
	IJDmZj+o0K2neewJwqhlrjKmjevxtEtB+goBUkKGA8OpOF0m2vllac8tSUNfbw=
X-Google-Smtp-Source: AGHT+IH66IhO1JPyMclB7tG0dmxwXJfi3sMUfjZlhyW8Mdwgw2RFi3ziUkdburBCJNQ8gOOJyxNfmQW6SMAO/DT1Itk=
X-Received: by 2002:a05:6122:8d3:b0:54a:8d5a:a678 with SMTP id
 71dfb90a1353d-554b8a9ac98mr1703201e0c.6.1759938571805; Wed, 08 Oct 2025
 08:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L-nH2T5PdJctHHUpDXP2bxiKvt4oaas+ndsmySecXhHdQ@mail.gmail.com>
In-Reply-To: <CAD=f0L-nH2T5PdJctHHUpDXP2bxiKvt4oaas+ndsmySecXhHdQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Oct 2025 21:19:20 +0530
X-Gm-Features: AS18NWD-7BoL_qKkp4gYprGFzCjIj8utGjS2i9i0mB78iLL6Dv4ZuhT0CdypzOU
Message-ID: <CAPSxiM8c+dy51bo4qNRE+1ex18RRw8FAOcedGwnEqG0=3u+BBA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:07=E2=80=AFPM Bello Olamide <belkid98@gmail.com> w=
rote:
>
> Hello Git Community,
Hello Bello,
>
> My name is Olamide Caleb Bello and I am an Outreachy applicant in the
> ongoing internship round.
> I am excited with the opportunity to contribute to this great
> community and I am interested in working on the "Refactor in order to
> reduce Git's global state" project.
>
> I have also started studying the materials suggested by Mentor Usman
> Akinyemi and will look forward to interacting with the community while
> submitting quality patches.
>
Good to hear you have started going through the links, hoping to see
your patches in the coming days.

Thanks. Regards.
> Regards,
> Bello
>
Usman.
