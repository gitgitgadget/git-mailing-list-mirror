Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89095182B7
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397768; cv=none; b=c2mMJI8JLm39uSM3hwSLOM05QUQUfpHiJktNhFoc52DTyP2mNJTfs4wFnblBOWfNOCA1hKLh31ME98oHC2O9Y9FfMVTbhehGH+uj9TClYxWGJucOWJVvjZ2/b0lEa6b4IKzoVDXaoQ/SVCbIpok9niLM0abDiPjpdttthq9ei2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397768; c=relaxed/simple;
	bh=1VQGsUVya9f/qiTt9gC68n2QIQbemcSPpyCghmxxLkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPFNm3I1GQoCh9N3pPFGNt6kIc3/klQNvpWeunTwMgABqvLcA0cnQzYBH1TBvdEfDR61bbYvqnsRNSNILBzNstkPbhwq1w19YQN6GCUGqFyFcQsPY5KavKP0RT24symmoA+gUFfm3ynoUXutTANKjhwYccOsfnyyh+rW0ejTRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTCe6ojS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTCe6ojS"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso4295419a12.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744397764; x=1745002564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VQGsUVya9f/qiTt9gC68n2QIQbemcSPpyCghmxxLkY=;
        b=fTCe6ojS7x4PL9mhHb6apYfA5kHF9b8UabBNGZVcuX1O2QCj/IjldepLXFOebiWQGZ
         MIBPeBBAfWv3Y66o5t0Oi0cE91OrhjqV9I1l3pZyIfloRI68nVHuKgv0FPwmEKMJl5cl
         gCfQw6j+WjRL9reYDIgIUQN2jruule30rTx1L1bZqkubC+lKlS86UT1cgHOChe+NgBCB
         xMpA9UHnoB0inyMR0u9kO/zWbBp1G/fYiGMgSIDWc56xq9Ngd/tuxNEm5Q0UmBD4wy85
         70tqhhAPYSgOWKrWFobFRFN9jfRvqm0LPCZLfSqJ8B5ZRwMvygFezHDC0T8w+QNDqbnj
         KZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744397764; x=1745002564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VQGsUVya9f/qiTt9gC68n2QIQbemcSPpyCghmxxLkY=;
        b=ilkZK+u8v0LHMGwsZwe84LCX9/fkQOzKnrCOlPKi++N+DeO5Mw2ar2TShbRr/KVqUW
         yWEHTT++05O92aLItw67tdAcKmY7Rol4sxFneK0tLLWWyumE4ApGhRg0GDnkXe/7IOfe
         ZSDdeUGRKOKjuCHfGUpOIX01KQ3NtHYZEJjr1B/7VAbtojBfsbhu9079lsNItWgprk4o
         6UUBMJJF8811rusvz2qghpoapI9mRLFwH2U2GpUJxtu33YWBDqUGMsGQkqDtzmw49PD9
         ldbvNKBMuDrXfil74mvcMqsUyLtG0d2BzMnusQxtFG49M4WUT+16Q3FKx6YQIMFYqGBp
         5amA==
X-Gm-Message-State: AOJu0YxL/LoRROyFTEM/ww9UzGj5LeL0GHY8xJjraeBMnFzlhnXGUBdU
	XL59zftz6syjh7MVwoXx5mM3F4o8gFpbOUiF+fpv7oChnVRUlPD38+7xaIf83qvtp3CoLx/GqFK
	F7Osky08vLFIHDP7eQy18YzBbKNGMxFsVdWr37w==
X-Gm-Gg: ASbGnctWwzcYaOO/jB9fcrBAtCx9ctUJP/0zwK0HnpJxWS8XXEtLxLY7cc4fGk42lD1
	QYWw2rLM83uuozYdyQvyGrhy7jxEdz+Ro6oNhpYAoEh/V08ta6OWx5EwZW/jqsucPAq+d/D2Tss
	3UdJaVLFRhc4VtOfM6zf+BYUtlvhWU46IaL36oWh+VruXkjeCVKAVSGeOp
X-Google-Smtp-Source: AGHT+IHkDzzuYLU63A8Sc/2kYd2dp2lsbqawOqpuY7uJJJVR8PupZKqzZ/zSgASn0O6csqg87ZtzReYewWbBF2nlP18=
X-Received: by 2002:a05:6402:3508:b0:5ee:497:d713 with SMTP id
 4fb4d7f45d1cf-5f370116437mr2998725a12.33.1744397763623; Fri, 11 Apr 2025
 11:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AE8657E8-D68A-4B86-9644-B57AEE743794@gmail.com>
In-Reply-To: <AE8657E8-D68A-4B86-9644-B57AEE743794@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 11 Apr 2025 14:55:52 -0400
X-Gm-Features: ATxdqUH6KBa3RHgdeGH8tiDkRVAtUnPW_LTpuVfXrGLYklSn330gOFMpzUJZ-V0
Message-ID: <CALnO6CC9QiaE5xdSVr_PYm=TPHPR=7US2KEFeo5DzYs4KouzbQ@mail.gmail.com>
Subject: Re: Bug in git-stash
To: =?UTF-8?Q?Filip_Skogstj=C3=A4rna?= <f.skogstjarna@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:29=E2=80=AFAM Filip Skogstj=C3=A4rna
<f.skogstjarna@gmail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> edit a file
>
> `git add <file>`
>
> edit the same line again
>
> `git stash -k`

I think you might find the following thread instructive:
https://lore.kernel.org/git/ZikMqXeDnOqK_wlq@thechases.com/

Cheers,
--=20
D. Ben Knoble
