Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF9322E
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711822; cv=none; b=SFP+I6+hr6StmPdFqCDnLX0DsqaqrQ9IV+pJdk7LHDllcHp4DZDW9OE7rTW0CoNT1TXLQUMb5dmr3AmvgqxNkUd2bzOzoy/7cipcpSKrmdLZImyaFS97JmeoL7ADDVp/9AQemw87V3DbZJsVeYTmIziPfWT73zXtXT38S/F5SnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711822; c=relaxed/simple;
	bh=ZO6FOq3/esj6XyM3QwMmvItIqjs8cm2qZgua2O37Plk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OlweLWexcgz1xwtLUaChpyNQKcZEU1mRY81umFY1+HNxfozDHR9LUXljl1Q0Ww/wweFTnQL45rXVEmYuhvLQnwp0VJfPbbq7O09bDQXBIBmYxXjVxlinQFYW6PviXC5DQwOTTtarHB9ECh9t9U4TEaTVDPV1MZ/rTj3L2TIqA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJX05zjS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJX05zjS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22104c4de96so28118855ad.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 19:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740711820; x=1741316620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZO6FOq3/esj6XyM3QwMmvItIqjs8cm2qZgua2O37Plk=;
        b=jJX05zjS8BZua5pFYSAdNwHIOKyw00XrP6X3iit54Acr68Mxya07L+BLXZK4pq02XP
         RRLjeoXtXLn/CFETZhOdsUELxCxMV41/Y4B6V19kSsvFdgkdqbc3yLjgj1hRLNS9t5BQ
         6+/6weLpgtY3nIenhA9rwag0bbm2XrQpJOfSqYUkc8idPcXM4Tq8n63LK9xC1TWjlyPo
         xHHXjb+J+UJZ27jSMLTrPYDIc3yVVugpJdmKXRBggOur/Io7KpQ3A5SAA5DFvr5XZsK0
         3vGpCBq+H2B2t8n6SVZUAUsZcqoNKOlXJP4yWS4w5Bsx9ykssSUFD99TQxGT0c4Dwzc9
         0h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740711820; x=1741316620;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZO6FOq3/esj6XyM3QwMmvItIqjs8cm2qZgua2O37Plk=;
        b=TMZJTA78wKHzaH/yePHuOob1Ja7gQAt74XB3FAReRtgjkoiXnrj/NiqMrK5n6h83SS
         JW0T5mSbkrysZ475QZ/2exG4a0vXfyFfaQDDXUPLKO2HBo260zxJoSyP3CFtJZjY+kHA
         nuzN9ty6JTMFnevSwYJr4kjbcycBfL9AxH8zU8/kx8rzhNnmnTRJS0eXPHK0jIFLs+pD
         4ZijhIZeUw6ag8fcGmj0zuTzmT1SdJNmUA0zHrOZ8cV1qDSKb/pbeTFNze7fInhJA/mz
         l6heBm4Ulosz7WlXP6R2Rc0xikFUNkMl7CG7P87px6jZXYSQQtMmIGakGFUBUZ0ol9yB
         SJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUzeUSGELdptTAHitAoZNv/Lxob+L0MW6/lCng6wZm0pfcZTwXxD0Ovt8+XTBiY3KY02Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+3acgdxl6GXr3Buphq/Xa0Gg3mfOQVpOETInb6ETp/0T9XRX/
	RocOqLYBCs5gtJ13mSWTAS2uNgZlJG5VzDvLW13ZiUQ2NliF99ID
X-Gm-Gg: ASbGncsl4GYLt3+040WRi6qGNXzMXlTsuu7DiL5Bnz/hW2SLQQzGGyA4iibbwMehhML
	ik+StiR+QKdxW+Ij5qiUmDRcfSpAEC4rVT71jRmX6R+FeLnG8QqJd5RiVJUqpuFJA3Tec+kVZ9s
	TX7c0LeEbL8qyUTFDYWnKFQBJis25E1EzwtjTPclWJfXAOE2tvQZ91V6Fb/VKekmYL9t64n/EVS
	pCJ++RKaSyGwmE8yBVfVbwXRn4LL9LLndSeFIxOTtFpyNyVf0tbK6BIUUrHwx/tUC8WpstTQ/wx
	I0KWp3swhTd1SadkKUkQi0wrlD7TAV7sNx6Gag==
X-Google-Smtp-Source: AGHT+IHb7inB4Kp78zBuXjUe/6eKx9wICPL6VtUT80RUOUJMUT0RrbhVncE/vLimlIx5Jo/Q6EuuXg==
X-Received: by 2002:a05:6a00:1409:b0:72d:8af9:bc64 with SMTP id d2e1a72fcca58-734ac365d3dmr2856167b3a.9.1740711819431;
        Thu, 27 Feb 2025 19:03:39 -0800 (PST)
Received: from ?IPv6:::1? ([2401:4900:4a98:2ab7:3fba:31df:18e6:2eba])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe50fd6sm2553852b3a.72.2025.02.27.19.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 19:03:39 -0800 (PST)
Date: Fri, 28 Feb 2025 08:33:38 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
User-Agent: Thunderbird for Android
In-Reply-To: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
Message-ID: <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christian, Patrick, Ghanshyam, Karthik, Jialuo and all,


On 19 January 2025 3:43:29 pm IST, Kaartic Sivaraam <kaartic=2Esivaraam@gm=
ail=2Ecom> wrote:
>Hello everyone,
>
>It is that time of year=2E GSoC Org Applications for 2025 are open now[1]=
=2E
>They are due before Tuesday, February 11 at 1800 UTC=2E It's good to see =
that few contributors have already started working on microprojects this ye=
ar :-)
>

I'm glad to announce that we've successfully been selected as a mentoring =
organization for GSoC this year[1]!

Christian, Patrick and Karthik,

As you're already members of the organization kindly log in to the GSoC po=
rtal to read and accept this year's Program Rules and Org Member agreement=
=2E Let me know once that's done=2E I could then add you to this year's pro=
gram=2E

Ghanshyam and Jialuo,

As you're new to the program, I've sent you an invite=2E You should've got=
 an e-mail about it=2E Kindly sign up via the same to read an accept the Pr=
ogram Rules and Org Member agreement=2E Let me know once that's done=2E I c=
ould then add you to this year's program=2E

Let's look forward towards for a great summer this year! :-)

[[ References ]]

[1]: https://summerofcode=2Ewithgoogle=2Ecom/programs/2025/organizations/g=
it

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
