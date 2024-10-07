Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65F199225
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300203; cv=none; b=nuGCKt/HNkSaFKPDh06oEAYPV+C13o20cJriMsRsbEkcogejQ5Uo1vKLo/pGXYN0zxxx8vZx+8Qibj1CRtXRORgoy9yTJDPonECa3LzuadB5f3865XFn3jxm2u6mWI84yIV61DhuPKJfX4moImN7vznVLJUB80utscdqM21uM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300203; c=relaxed/simple;
	bh=EEOoV6cBnKFZn8TMNQFztY5m+34v8bZGdw1yvy+m5g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ8KHeSdxgKANR1/i/yaqlKqaNPEb2mgHBc5sJAzEf2RQmjd0uw3UMEA9ZR2SqtOIwFuhffYEBjRVNwrPghJqkmk3dt9O7cS/UaqaJ2fgFEShEfWC4Q8Fzc2uoX8iZDIFmfvfwheMuPiVI/6bafVtmu7ZB/3dSY2ryDeuQSvJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+kGW93r; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+kGW93r"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a28a1ae1adso1652109137.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728300201; x=1728905001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEOoV6cBnKFZn8TMNQFztY5m+34v8bZGdw1yvy+m5g8=;
        b=P+kGW93rUEyGoRxHQ15dalkrLzmkC5XjfMXgiw+gmnba/6DBlw8Gh8wJ45n/FqZdFs
         iXmBwFSHmxZU504RY0UkrzmcGW9BS0uBhiQnzIZfrZQv6vYXE21eVJCISVHT0NvhdLPY
         HQQzZYjA4ffGssC07LsG3VB9nW1O8F33mY1BHdD7whDxSDxCZ5nikj9pRsvVplEGweoA
         1tO21zfZrnH5S/8BSYrxqVWZkCwn7VNwOBqeEsyETIAZin3riuVt1G630Il/lQko+G68
         dyoCiIx7MOOcPp2GqpJtdd43QmQLyf1ncJDgamma1w47l4E+Mnx4fab9kspLhaPf8aT7
         zCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728300201; x=1728905001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEOoV6cBnKFZn8TMNQFztY5m+34v8bZGdw1yvy+m5g8=;
        b=PYadPiCbtyctWhRs3bxNBs4ok2RT0qom5mDPs0gqvV3CexlCd1Mig3lrI+DRaAhvFn
         gxoryioalM7Pebggkee+CUP7uKsE2L3RBZu34QDUAnrgtaFyeHPhICfft2tAWl+xSGm7
         huNf9V0ijG3GcDJXpwkP3L5vHvr8+WxUjp+GJcz343ErZtmcJ7ptnNuPVZUy7N6rXwU4
         V0QZcWXrL+uzQ6pqQTAKAgYWXt0+/RaKvvur8041na6dAb8syQ+It8EMFCqCJyDaekMz
         OG3dcucbhl6JdBlcurtjCMT8RT8ivP+C01xlfGTPLdtFv7c3ARzY2Gc0lyDjrebLb4ir
         lwew==
X-Forwarded-Encrypted: i=1; AJvYcCVROV+IexUsvF8AXg9vDy1jXyK9peOUlMGjK2FdXbTYz4h61t2UZtpS1SBcx3CY2CQ1k6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCKNo4OZEdywmRQV82QRDx1ZwA2ENIi7D1JKmVTa2r7keIQxb
	lzmRVJ3B7E/PbHZ6dbJojVUOcGYQ1D6lcZO4DyVPcgulmIKHqsOOGWBh3Si1YnoFHaPaARBRNi1
	Mh0tl70eaoxZsJbJPAFc3ZXtP4AbUGhFJl9o=
X-Google-Smtp-Source: AGHT+IFlaxyGyRDeeqfg0OD0jSge41kXiKPT5RHp5EgBVYXcZ7Wxr5ztj/T9oXUNVIRlki3yUza2hjGrVozUcACuals=
X-Received: by 2002:a05:6102:d87:b0:49c:e6a:8ae3 with SMTP id
 ada2fe7eead31-4a405749455mr8646001137.3.1728300200690; Mon, 07 Oct 2024
 04:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>
 <Zv0-Wv03hSea_Tje@pks.im> <CAPSxiM_fTMCzXg3OrcbJrn=UskyCaR3D=xgR4d6PrnnAdoYcCQ@mail.gmail.com>
 <CAP8UFD2QN59LVAJgqwj5V6dJ9sTCHjdDG=XtuWcFkgANmfvnrQ@mail.gmail.com>
 <CAPSxiM8jTxFXZB5ek6nNFy8arKan7GfoiRmaj4jQ81Xfhcf7eQ@mail.gmail.com> <CAP8UFD39hCC8hOxH55_ghgdjqBEK3StPKkiLnR7=whJV6jcO2g@mail.gmail.com>
In-Reply-To: <CAP8UFD39hCC8hOxH55_ghgdjqBEK3StPKkiLnR7=whJV6jcO2g@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 11:23:09 +0000
Message-ID: <CAPSxiM842vVLVt7HJTPxLOjnrQrALKzWi_rNCTmi1Fan1=Z-qA@mail.gmail.com>
Subject: Re: [Outreachy] Potential intern.
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 10:27=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Sun, Oct 6, 2024 at 6:34=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > Hi,
> >
> > Thanks for your reply.
> >
> > I make changes but, I need someone to allow me to be able to send my
> > patch using gitgitgadget.
> >
> > I had two links as the first was failing some test which I solved.
> >
> > Below is the github link.
> >
> > https://github.com/git/git/pull/1805 - updated patch.
> > https://github.com/git/git/pull/1803
> >
> > Also, I will be glad for any review of my approach on using gitgitgadge=
t.
>
> I don't know much about GitGitGadget, so I am not the best person to
> help with it. It looks like you managed to send patches though, so not
> sure if you still need help. If that's the case, let us know what we
> might be able to help you with.
>
> Also if the subject of some discussion changes, then it might be a
> good idea to update the "Subject:" field of your email. For example
> here it could have been a good idea to use "GigGitGadget" in the
> updated "Subject:" field, so that the GitGitGadget experts among us
> can easily see that they might help in this discussion. A good updated
> subject might have been "[Outreachy] GitGitGadget permission needed
> (was: Potential intern.)"
>
> Thanks,
> Christian.
Hi Christian.

Thanks for your help, I was able to send my patch through gitgitgadget
and I can now use gitgitgadget now.

Thank you once again.
