Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B603F9F25
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431102; cv=none; b=by+T2LlfOU7mEzS0PeaUif9Qo3n+L94ED4OOW06cMALBP1n9jliZapb6rrtHz2SNToTVkwlDp0+8a8j+RmD3FOzJGV0f7Ra0+T3UylXexPRaRle9ci5NlZT2AO6JjAmOutd8cDv+IezY8LPpEdy19MqlcQLE1Un9ylKNu+WueP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431102; c=relaxed/simple;
	bh=fNUbwfIKx861F0zQ0doqV57EDM/dnDRya69PiHLoNoE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ozC1RmU4Y/TocU4pnRmo5JGBQuXADCOZ4f0EKnXu/4DgBEIOfVzruOlslUdHJJcboXkBGA1Cd1QebxOEpAHd8oUi/+7665Gq7qPG3kH8gkVEokbHPXBoJHm5dMn/T0bSD6Mw5t/0l82VxWC290vpfqBE+mG3SIRHueXuGZzpshQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SagSiN7Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SagSiN7Q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso23274255e9.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788431090; x=1789035890; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fNUbwfIKx861F0zQ0doqV57EDM/dnDRya69PiHLoNoE=;
        b=SagSiN7QfkWu8xsDuuCiPC8VqP4SpBJRQix92RMwShfUjFupukN+1U4I1RDtdyGFAz
         7BvNTzZx0xifi9jt542f/bcf1JYOlxDgfOA8ZEUPgxpbuPRtPAt8lIn6yWou22UvYqA6
         jmK5xfnhhOS/mCLdYR58jmFD6mXVGQWkcf3MyIDf2/Ft+mdz7GiocDh6j1D2yFTG7tLy
         CjMWM7DA9Jgu108ulHGxUhCJ4dgHoDUe2bsFiPRBNvWJQ4OTkH+A+NSMREStaJnQuYw+
         e3MUM+gOKQgpeVrylvaWkZAZgoAOsC3LmRmPIMDWX6Bbqxk844kg/o7menjChbLxM860
         yeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788431090; x=1789035890;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNUbwfIKx861F0zQ0doqV57EDM/dnDRya69PiHLoNoE=;
        b=cBdEj2UfHQu/PyQ9BgnUlpTGaioOkExVAMhdeXdJPWbRwQkANBPfXa2MJw+FItmkiX
         UvjefgHwXnSZMjeXsweLB1jBZPeVjmVV2CT+RMicvSqfTWa9VEfaPteVsKBMBn/cGoEb
         knqcQE0UIP++QG+K7cBJb+FDsRv+UFjCy+FOg5ZUEcmGg8ik0OreZqk5iuTCN5LgS+11
         fb+AGKaREeWe8JDGATGYvZd+hcR0iwlBxR2jfi3zDWd2kQlf0Ue6twmJG0Y5PyOTcpBS
         GDsowtDmLmOCOdtMd/0Wjv5jgSKse1Ro7ttPLYtz1103LnjCxwmprcXDoYS9Gv9HyCwQ
         qVQw==
X-Forwarded-Encrypted: i=1; AKwUvByWtdA/lk5K9CdTFcD8nddM76K3w5jeMUAy/C6jQm06rpGg/FfOxtbAHLTyvc37DkaNPZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kz4OqB4ok8mbpQF4beQN+Fm2Pv2ASIKmVnOR2VLHWhIqdfKQR+
	NxsDkPdW8f33jnsY2BvNTf2tQ0b9xxgGgP4h47gxqXnCUx8jBmGhi7RV
X-Gm-Gg: AYBFou1teQyCA8XOAcQuPTHvvQaMp22qWNnk4HP3fVu1h5Qi2fjZSd4WxPxFaghRXqR
	+dFDZQofRaeuGGOf4D0FNHoEDb+2simYYY38sMxvUfAldStlXm+EIZzCZj7Czup0HL9/8c/xWgz
	c7a6kytXGCIutmlRUWaF2lXcbHWn5xPPSLWOaP1Gd86hs4LSu9Mpn1VWKdv8RMClD+oGnHv0t3C
	eLSBNelV3fue4rcmoX+//IF2CyMYxGwBiguRigk8PgzfYC9Mj31W7gtIsD7RHxyNhiJxAf5Hwgz
	PApbNqlgEmZV9YOa9XrIsDB+bMSUEyXr8yoI9NBGBRGavLvRiynaIFX5Uocs8OI64vS/tyXRdGG
	PkE1cRlaJcRBWGTUmapL9SC3QgtU4Yp6SJtW9S85uvC2CLTr72W3Fch98j9zIVx9gjxeZorDg5x
	2+wQjEuStzsk8/iacsv4yDbC5T7gesx3DaR/M+eV5qMQxeyLQNFch6ALhh5ZEqXmdUbfk5V5hqn
	Ustc65esXmuDUQqRkloF3fDLHi8TJ2RU0F5VPz0Wyqk5IUcIQLo1eC9u93QB7/7fJ8KpurClZ2x
	vT1IKqj7nVtwerB6wX318o0Yvr50Ic/OKvVGrIlKlwuuz2GO7rbFoKKopDepgU/16mNzM7vBW3k
	bHFjto9kH/Lu1
X-Received: by 2002:a05:600c:4592:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49ce5828104mr173867025e9.7.1788431089654;
        Thu, 03 Sep 2026 03:24:49 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:252c:d4e6:53b2:a04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm64832375e9.14.2026.09.03.03.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 03:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 11:24:48 +0100
Message-Id: <DL5LWRORZMGW.P7YH0PPIJW93@gmail.com>
Cc: "Git at SFC" <git@sfconservancy.org>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Subject: Re: Participating in Outreachy's December 2026 cohort
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Christian Couder"
 <christian.couder@gmail.com>, "git" <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com> <4de9645c-f067-45bb-8168-1f660e11eb8d@gmail.com>
In-Reply-To: <4de9645c-f067-45bb-8168-1f660e11eb8d@gmail.com>

On Wed Sep 2, 2026 at 2:20 PM WEST, Kaartic Sivaraam wrote:
> Hi Christian,
>
> On 8/26/26 16:25, Christian Couder wrote:
>> Hi everyone,
>>=20
>> Open Source communities have until September 11, 2026, at 4 pm UTC to
>> sign up to participate as mentoring organizations in Outreachy's
>> December 2026 cohort (see
>> https://www.outreachy.org/blog/2026-02-06/may-2026-call-for-mentoring-or=
ganizations/).
>> And (co)mentors have until that same time to submit project
>> descriptions.
>>=20
>> Last year the Git community mentored a single intern. For a long time
>> GitHub or GitLab used to sponsor Outreachy interns working on Git, but
>> last year both declined to do it, so the intern was sponsored by the
>> Git project itself.
>>=20
>> Let us know if you want to help as a (co)mentor or an Org Admin, if
>> you know a company that would sponsor an intern, if you have ideas for
>> projects that we could propose, or if you have an opinion on Git
>> participating again this year, or on how we should select interns,
>> etc.
>>=20
>
> I too believe it would be great if Git could participate in Outreachy=20
> this year.
>
> I would be willing to co-mentor a project this year. I could also help
> as an org admin if needed.
>
> Also, Pablo was interested to volunteer as a co-mentor for Outreachy.=20
> I've added him in Cc.
>
> --
> Sivaraam

Hello,

Yes, I'd also like to volunteer as a co-mentor for Outreachy this year.

Although I won't have as much time available as I did during the summer,
now that the university semester has started, I believe I can still make
enough time to review and mentor.

I do have exams in October and January, but they shouldn't make me=20
unavailable for a whole week, so I don't expect them to be a problem.

Regards,
Pablo
