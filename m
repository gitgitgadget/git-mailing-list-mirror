Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53C1DF25A
	for <git@vger.kernel.org>; Thu, 29 May 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549229; cv=none; b=m8gt1sH9tZo6kgTqQcR/aSGw1ZxawrcqMO5pzsas72sJDfkXH6srQ1GOKRNRtXadMHd8+fQO+kgslwkAvSfMwzmpBjsDWTaGVfU5Up8CQadZQDK/104lAme9LUXuwZ4J5T5Pw7hsklm9BWcRzQVT84rnE9Rvx+8GxbsnE/91WQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549229; c=relaxed/simple;
	bh=AvikOv4yo5xi3jiGuN20O4N74nxZzNPJukAuAQNJRTA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Gl4uYWyy4IClxtzf0qKn5MIgxbvsnFEeLzXndeKh6uC7nVExnhfnQS6j4sYvPLOoBV/P8mA1hszoXXFF+rLqNx1a3ThcWU3MgtbpmukUx2xs40Ce8Yq7pwGnc++TNkzg+1kgdRPltEPe2Mamqb5HgqM9Hty7UwkN6CNJT6TvUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIIKHoGM; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIIKHoGM"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso2495246d6.1
        for <git@vger.kernel.org>; Thu, 29 May 2025 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748549227; x=1749154027; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PswKHg7Zwj2+9lUuhy11dn/ojAN12i/2o0kxhDVR3c=;
        b=NIIKHoGM7WdoCGtYfsX3reM74o82WXe3qdh4x+IGPhmcjqHMLpt+sgYWI/CoXf6HKJ
         vtn12+J1uLbiU7Vc10ibp+PA9RWCvZwngR1GV8kqpQ3XTMfN/96Z5rLe+1f2LHyXQJWl
         OPrrUtbxg+uJeHYLnFZD9zy/SA5R3/rGNSoX7q1GSfOE7yggTMRP6tZO7Pr2B3ziwHh4
         5xEtSVINpFHNrzAuaWoMGAL5IQUfJJpGC6VJgfVw0v2OCRnHH+gO90tmHuaY8WodrdiR
         BUa+Hs+vFfLT4ZWmxnCRSUmVVPElczTsNSZ0/GkbvLoRP/Em/oQYanROFkgVw6Vb6frK
         sjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748549227; x=1749154027;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PswKHg7Zwj2+9lUuhy11dn/ojAN12i/2o0kxhDVR3c=;
        b=GftbF06hqbf+cijXl60xXiDd30THUhuUHKw9PoBxDL5E2pXS+cvp76Mb1yeWFhHp68
         musoqerH9CoAKiKwgZtZXS0Ex1JJd+0A8FscTi5cAckr0R7UUM7mBmTFH3c6uO9oxuTc
         iypkNLD5etOASUFl1KVRty1gJb+NYn1FlQ7tftZIoKszURENxRYoyRAu/WE/pfuUOOsk
         MWbthh/C8dmbI0pjwLtj22WkBnlBg7J6OrQtzXEypnSUsbtXGio+2BEWsoL5CZQShTbz
         cZX4SLYJONCj9rqkk4RT6t69ocj9AgCFmCWlEBrYI4ssc8ib3kTrB8kpSl08gQydvQDl
         ijpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/PMG5nSl31adxXPJvV/3T6C4l6KkrY6knOXE1e+e+xSJcwHutypVrwE/h0YFjvlwtVKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OFd/33wDWGvlVRT6sHb67yLgIfNX2rC3cssOlaAdJS0Igh4S
	1gQGAcMV3tlSA4anRHzhRZk5UU0W2XiO5PH0Bor00WMvvhBPPQ/7jGXCRRtzaaHGnSHCZgua4Tm
	CnLWpDuVhWJiAIvI9oHJ5HfL0klgWhfWEhrp5
X-Gm-Gg: ASbGncsA0XxwMN+yxi/U3dagGpCPuLbuUSwQ52aejzbxEaHQBjdgXZXaj6z3IHo/XiW
	IMcL0phq0cBbtzaFlIEZ+p+pDSPBdJMVR09dBvnwf7ZEnKOwmlgRkhOsAkcH8iU+8p2gkVIW0J4
	YW9wNxdf277EIblXZWOKJVlwvFtIBfQQv1KUELx31jFspG4lN6lPLLsot7Or+534itpfvqtg6/z
	46Y/w==
X-Google-Smtp-Source: AGHT+IFmRdJT9/rm2WXJIx1b9Y9xgdwRW3TfnaKJ4BRRHW23D9f7CLJRBSUv8+ZhskImsYe61Pi9s59ssXaWDwVGF40=
X-Received: by 2002:a05:6102:4b08:b0:4e5:8eb6:e8dd with SMTP id
 ada2fe7eead31-4e6e40d655dmr1344519137.5.1748549215352; Thu, 29 May 2025
 13:06:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 May 2025 15:06:54 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 May 2025 15:06:54 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 29 May 2025 15:06:54 -0500
X-Gm-Features: AX0GCFtewBngkv7aN-Iu68OQ_7eQlt59dsHX8mz3jN4kmMJub9DqQnjHrkR4mKc
Message-ID: <CAOLa=ZTt4eFLZ3kak4g_kW=UH0YGbUMFgB617wvUzTtQ4me6-Q@mail.gmail.com>
Subject: Re: [GSoC PATCH 0/2] Update MyFirstObjectWalk with struct repository
 and meson
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000da95e706364bd646"

--000000000000da95e706364bd646
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi!
>
> I was studying for GSoC using this documentation, but I found out that two
> things were outdated:
>
> 1. The lack of using the `struct repository *repo*` parameter in some functions;
> 2. There were a instruction for adding the new command to the Makefile, but
> there are no mentions to Meson.
>
> This patchset updates this documentation file, and hopefully will help future
> new contributors.
>

Thanks for this. These documents are often missed by regular
contributors since they don't refer to them as much as newcomers. So
good to see that it is being updated.

I've left some small comments, but overall this looks good.

> Lucas Seiki Oshiro (2):
>   MyFirstContribution: use struct repository in examples
>   MyFirstContribution: add walken.c to meson.build
>
>  Documentation/MyFirstObjectWalk.adoc | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> --
> 2.39.5 (Apple Git-154)

--000000000000da95e706364bd646
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 280b9735f7165710_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nNHZsd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFVBREFDSTFYeG1xUzZhSlZoSjA3OGl0dVYrNjJWawpwZzFCUlVQM0tE
YnBnb2UrbXhXZ3J4RkR3T2J0dkpDWmc4cEczOVpoZjdLaU5PN3RIQk14RzE2aWtVVjZyNEYvCjV6
VXJsbW9kWWszbHdQWXl2ZXdoRU4yZlRPVGtrajNmdjhzQlRPQlVINmc1TmJMQU5CazlCbXFPSFl2
cUN3K0gKQUNwTXVOSnd0WmRFWWUzbFAzekNGYnBSOTlFRGpkVWo4S0VXVGlaVzFyT1V1WTJ5UGg2
Sk5mRlBYVjdYMW9xbApZOUJPTWg3Wlg0TE15MTZwc1hUMUlCUnNrNXhiQ2dsMmJsZm44ZUtna3hB
T0FmNUw1KzZWeG5USW84c2w4VWhlCitISHkvdk42a0Nzc2ZYMVBmOVp0ekh6WlJOU2xMeUlJd0dD
M0xxenhsU3dlcWdEOCs3akY4U0M4NmMrTlM1c0kKd3NvQjZ6WDdiWXpwblZxYTljR0Z5MTZMZXpk
MVNIRlRiNTVQMXV6MWl1QzBaWWhJNEhoOVRVeEg1SFRydnd5bQppSVBQS0U0a2ExdVQxTS8zc25o
MkUwSkV1elZEQjFOODUxNnBDR21BSmpjS2MyaFBqOVYwbTFSSjNWSng5QmdICnNTaTAxOUJHbHpp
RHFoV3lHdFNEZkVpT253elV1L3YwbG50OUJVbz0KPXQyN00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000da95e706364bd646--
