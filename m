Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A9204F93
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759656369; cv=none; b=D9p2sX8kOLpXA4TejWd9CrjhwWWdmTCUJe5bS1VeeV5dKSN92Bi8j9rDEu+hOmb9TMEmMQep1cFIAb52NGRHADalVUZmygrL4iLyPNQmHicwa00jJ9NRix9b7RJLLPMU7Q16Vsv6vgHWbmp4G7J8EQvi5lio4rilNPLLkG5KD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759656369; c=relaxed/simple;
	bh=7KzBlDefvgjFxbCu0W91qebBpnfLfmgyeVZIRhwZduM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mY5ZrSfzHU79MTXeuB5iyHt4bX1Bd+yxJ4UpHfR1TGaDhcNyusw4YlMTC48UGw3vpC6Degw1ItGrgvqGBD5LeXJ3MvflG9c0OylS+vdqloT91RHgY+x5Jrd0P0/kuWbC3S7Fi8wFerHEqOKJA18TDRLSiFQVYExQV6NIrOei6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx681VdW; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx681VdW"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-905b08b09f5so1255709241.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759656367; x=1760261167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KzBlDefvgjFxbCu0W91qebBpnfLfmgyeVZIRhwZduM=;
        b=Fx681VdWCaanWeKAWNgYgy5vW5Jb12OUe5OVWRDTFq3K6ykLsCOA4vr8HaxCYVobZC
         +NlFZNtzaLn+8nGPGtx4req/FagEqqDgAufN14jfJ0xWkcRsuQ2p1E+MGo80D5D3mxC5
         4CQHhRXnsI4fj14mqSf5FqvoISAJ/uEfWHi5eQhQVyTAe2WC2YQcAqzFkjG4TiPVUJ0d
         vcvvVljB5YSygnCDHK2N6Lqy8mujyNyH5BmDrZicQ50DrpTZel8mbkGK69O73OA6P+lj
         3eafwDak4Dv4N71tXpU2Sd6C4Yh9Ad1YB/hKdqszNrMFm3M6JJ/fc8Sx08zwu7AOx7My
         PUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759656367; x=1760261167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KzBlDefvgjFxbCu0W91qebBpnfLfmgyeVZIRhwZduM=;
        b=nQfiohnAsVtqVuRllHUPMYumyxNiyaeOdnZG72iIKqMFNpMSuP0PJSWghfdbC1wpTH
         VB0+f+zoBS7OEMtLnhYov+k74MjYOJI/0wcuTtW3kPg3jcSjyb2AMubi1t9DnyX8QaaN
         q66FpjiPnC5Z0M5Ql7s8GfSPaStCMcbSf81/g+5e0c0rzycwfvXM8sxI9o7UM9xySovs
         gvT1e6h8AnmACUKfMrar/TjeVqws2AcLf3OOTgxC1PYhwvAJoSedsgHh/uC5D8J09Y/P
         +cfePDyLsLLlz0UF72NM7gJQtMZY3fdBNTU6tb4SBxl1nDVZY/leZ7h3lPnHILpUA3lK
         YcdQ==
X-Gm-Message-State: AOJu0Yzi3YPy9dx7m910RiyL81e5/ib7wUGTLuCkVDwvoOYy/g+MUGki
	1GSEc/8yOJfPHBzJ8BXlfEbTp3ipSyCbQtPwpWRXOjiVpO28JaJloWznh5I423Juv0+N/neLslO
	V56250nhtayT04D2EG5Rs5Bx0doHITaXintJ0QS6InA==
X-Gm-Gg: ASbGncuObi2LvCPmMMQbDBYFbzSGCLcjP0Z45VWyYB7Na90CBOWJ5SUegsBW+2OUxoU
	Lfv7p8/tli+H5iISGKHVXrV6XI9icb9d3MmVZlUWDjZ4wYL3OFKWp+3tivWEp8gPTB2uLYEzv6f
	Sp3EXBQW8vBGNijOma1DE+joMBmEVD9CQB5SnTiQ4xlJ+JJ908jS5ewzBDA07wq9Sx428ay4/kO
	tm9qPyziFLD7k9V8GjXXVLUF5bJpcSXOj3raElLW3/V+A4TUshKjsJx0YFcE2A=
X-Google-Smtp-Source: AGHT+IHP5WzoREUguXMORonS0TzTZjyaWdMb42wS7gNmo4Rg/zYWUDlNwIIauFn9LVcXweMgJSwtLJGNpSC+YlP+oao=
X-Received: by 2002:a05:6102:e10:b0:5d4:222:9fa1 with SMTP id
 ada2fe7eead31-5d41d0002d8mr3276460137.10.1759656366986; Sun, 05 Oct 2025
 02:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMWvevK2CrA_2mJC-O2HDKag4EaDVrB-0LiqQk0_gKrRaSR_ew@mail.gmail.com>
 <CAPSxiM-hkh=X4rf6QvGP2JnHvP-UJQ9mcmMon91avv9AaLB3Bw@mail.gmail.com> <CAMWvev+ZumUqF1hW9qfJ7o=_t-qwB=wko7oL8r3UFC2xmr0WgQ@mail.gmail.com>
In-Reply-To: <CAMWvev+ZumUqF1hW9qfJ7o=_t-qwB=wko7oL8r3UFC2xmr0WgQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 5 Oct 2025 14:55:54 +0530
X-Gm-Features: AS18NWD5xGpl8bOvI9LsaSLszQqrWg64a2njdYYNRrX-WeXJOgc8YDlzhEl6wwI
Message-ID: <CAPSxiM_N9LSryKf7jks0tqk=d5abaKEAmfnLACFM4Cqx18GN-A@mail.gmail.com>
Subject: Re: Interested in contributing to Git
To: Vedansh singh <vedh2o2@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
Hello Vedansh,
> Thank you.
> I will share my next steps and progress here.
> If I am missing anything, or if there are other approaches to
> contribute more effectively, I=E2=80=99d be glad to hear your suggestions=
.
I think you are on the right path. One very important thing at Git when rep=
lying
to email is that we do not do top-posting to email, we only do inline repli=
es.
It is very important to keep in mind.

Regards,
Usman
