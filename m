Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C620DD71
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673606; cv=none; b=GzyyLBZQuIHhPzJPNrD6iOZvy35xKUp7KfdSbnP95VqsLT/2KdtOTOgqhtRJQ4nqd2Sxm8ZPhCYiVD6qmlhMRsBwWytsBXsvSTk0M6r0eviz3YkUyG8GaXxPh0YxQJQTt7UiWzS4J/avH4EZIw86X/OXxsWLX/kLDbdS9I6jGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673606; c=relaxed/simple;
	bh=CDXNvJ0DKTiKAu9kR4oSBH0YjBeOPVthJrAZFjVikMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd+3TemfujvM5V3oqGRsLVzveBH/ENEoDFqpj6fsrIXqCaOTNcs+v/+HfeamW5qvsEnWOuf3x6AXFQsUpW9O1CKuX6DyTPSsEtyvdkGxxCnQ5yT3wEVlR1vXaUqUYZBgiF5sR6rmt/UsgxYgUST7wflHjbPWXUoEXVBdvjAk4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8TP4wd4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8TP4wd4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f0c4275a1so4140185ad.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 04:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738673604; x=1739278404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDXNvJ0DKTiKAu9kR4oSBH0YjBeOPVthJrAZFjVikMI=;
        b=G8TP4wd4fxwOzfegFPUqkOmMkiupHf5JZbl/EZ/Ng/5i34jeDB4DqSaP500b1Z8Rg6
         ALvjFpKAjeZF12mVzndEnWlX3M6pszN7MoDHZrkSZVypE+HPXouC+m+sjlVuALB0rrod
         25YDj9AZ3TsVjtf6oZEH8jT4WqlRwDtJTZJt/OivA5loiQdSfoIdUrPRrBxhca6uVKaY
         u1JOrW0dZHaHQ1lCSVeUEQx0sUZVA+g2hzFE7FSdAT8PElDWM11lGY49PqQ/XIHncQ0t
         QRaIn42LhCfTvHW/wE5rttseJVA8lMWbYxO76v4QY6BfyZcqz9Dsd3GZYHlv/6KAscCv
         aPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673604; x=1739278404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDXNvJ0DKTiKAu9kR4oSBH0YjBeOPVthJrAZFjVikMI=;
        b=LK3ZgGNOjqOmHwadaqLRRvGuBauAwH1ynsK/FrSb7UFbXutshpZvPGvOR2foaw9GVP
         MZetER+TTIxeAm6p7E6urUgVNAeCrfaz0udZ7JZ57ZWhDyBqA6iEOFS318wtvMBBtNwP
         IovHnLmje5I/FpdBiF/9E6MffZMKczaBAZ6ecRnH8pmsxn6szDysNckzjStKJ2MTd9KD
         Sv2Y3Pqk7G3N1yl+Jw2/5Y6jT5aGTH8KmiNNGRCR8YFq9eOHZ/9T/oSyim4GAx82DWyK
         LEF7cSjA0KcCrvWpinlJebhClUxBD2rG7rDm4CrrvhFcwhqviT3WcnGE0pjYbjzCmPAw
         OoOg==
X-Forwarded-Encrypted: i=1; AJvYcCUhg5kdSLCTLzKEHncvotSdAWkr9fefWsTx+2wLizrqFcFyQD8gwik8XzfRkmAxlqaB1FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGrrOK/SrO/lI7ZaL8oaJbH6/4S5qJ5BVEj6qZ7vRkyWaV0FG
	62xN3kWERq74GSF6B15OAGVz1fmdqEhzwa7889UHsHfEO/wnvmMmrK36Bmb50AWlHvtty8uAWLT
	KhWQAogFMZLu7E/CBGfy+0rPE3wKfqQ==
X-Gm-Gg: ASbGncuVuHPMipEVRUVYiHhwmcYXzAWQsOLgpct5T/9/5eiG/0SU56M9+F5VTGq0jKN
	9hEPJRRWIUZIk6xX7ZWzUVJCHhVydg0wSHIIDDIq2Ll5okh3/F2Rib6UJs8qeFFZQ6+C0H5k=
X-Google-Smtp-Source: AGHT+IEXizfRtW3XgPWwMXl1VIh+MErM7NMBYA+vX4YsS73CrTP+d9sNK+i0+3YIg5zo5AkJIcEh9eUC5I7tR+wgaQQ=
X-Received: by 2002:a05:6a20:7343:b0:1e1:ab8b:dda1 with SMTP id
 adf61e73a8af0-1ed7a6e0999mr49069134637.35.1738673604114; Tue, 04 Feb 2025
 04:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
 <xmqqh65b2ci3.fsf@gitster.g> <xmqq34guzi0f.fsf@gitster.g> <CAMoUM6+9SHybvWVp3SKDD4RWesruh=nmMacXn_oL893CPCn39g@mail.gmail.com>
 <CALnO6CB2TjwRWr0=c2nWY5DnwLeqXiaA5fCiEeF85zivmLggjA@mail.gmail.com>
In-Reply-To: <CALnO6CB2TjwRWr0=c2nWY5DnwLeqXiaA5fCiEeF85zivmLggjA@mail.gmail.com>
From: =?UTF-8?Q?Manuel_Qui=C3=B1ones?= <manuel.por.aca@gmail.com>
Date: Tue, 4 Feb 2025 09:53:13 -0300
X-Gm-Features: AWEUYZl9Egfix88WLQDv1AhmlrjnzO4jM3FuFHgSSahGTPwew6QONRXk20k4-IE
Message-ID: <CAPpV+ObaMU+WQM5gVCcY3ypPaobMtbu3dZQByOKPXyiscUBcuA@mail.gmail.com>
Subject: Re: Usability issue: "Your branch is up to date"
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: bram@van-oosterhout.org, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 3 feb 2025 a la(s) 11:08=E2=80=AFp.m., D. Ben Knoble
(ben.knoble@gmail.com) escribi=C3=B3:
>
> On Mon, Feb 3, 2025 at 7:28=E2=80=AFPM Bram van Oosterhout
> <adriaanbram0712@gmail.com> wrote:
> >
> > Ahhhh, this thread explains my confusion when, even though git locally
> > tells me my branch is "up to date", a fetch demonstrates the branch is
> > not up to date.
> >
> > Which begs the question: Why does git say: "Your branch is up to date
> > ..." if at best it can say: "Your
> > branch MIGHT BE up to date with ..."?
>
>
> Well, the branch _is_ up to date with your remote-tracking branch [1]
> origin/main; that doesn't mean the tracking branch is up-to-date with
> the repository origin's branch main!
>
> I find it helpful to break the notion for newcomers early on that
> origin/main somehow is "equal to" the repository named by origin's
> main branch. Git (mostly) only communicates with remote repos when you
> fetch, push, or, pull=E2=80=94in other words (and this bit may be more fo=
r
> Manuel), try to reinforce that things Git knows locally are only local
> and not inherently tied to other repositories. Learning this
> distributed lesson proves hard in my experience but explains a lot
> about the reality of how Git operates.

Thanks for the advice Ben. Very good point. I will introduce the
difference between the origin's main branch and the remote-tracking
branch early in lessons. This is a core part of how Git works.

Still I suggest improving the usability for new generations with a
timestamp of the remote-tracking branch last update. Hopefully in the
future it will be possible!

--
.. manuq ..
