Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0D1494AB
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895763; cv=none; b=B1xX405GH3F+lgD3mxeLSOuZqtajvsI2TkzH9Dpu5CGhuM9/PuQOCn/7kOMnV7k8iY55+R2e9dcU+yWLm2Qf4hXgHjycMlGVsKQKbTJlBMGxtXPd+BfzInm9WS3qY4LFx2WssaZannUPQ5V4P/MiZvdOCk6UQ/vQ0CDZuYt4wR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895763; c=relaxed/simple;
	bh=dAulhDluaDqQIDAbLs7yhsjJQ/59LkpDHg7dqImxVlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+miaN+tRe0X3mQM25Z71KO8w+1TZSsR72fuoZF/CGD5DS/W60EdI+zqBEDrGcIhlFiGh7qZ9SLPFLKGVE5S6tcAh/ssLA0oqoe7zMR8aDkZ/AI+yyjJ5hmB1E393mdPItskz2yY9VO6DLpTJoESv80Svt4PzDbzhqLzJtJr2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMwv36m4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMwv36m4"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46ac799015so1170309276.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 18:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738895760; x=1739500560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAulhDluaDqQIDAbLs7yhsjJQ/59LkpDHg7dqImxVlY=;
        b=FMwv36m4QgHNhhH3t286O3IHeNMKtYTEjCtiZM13BIQ0O0tqCUbnW/KAwshelulEYl
         58Q6khZZN8bR+yoPhYfZQvmzxyBLseubg264ZhJRQEIK7o6kvVLZJdBBMJzuCvlSUXM6
         IEdW7NEI+bq/fy9aj/s4MbT61Dr0ieZj4sbnUyEX6Z5j/0Mofo0ouZ62h0mgAFNF3UsB
         JeklT0PSsoxxfpD/Gn8O5msTYv1so+hdTjD2t0goRAVyWXU89BkwznapxHCXLOLpe7qa
         QoZ4dz/6BVdR+FYAPEFofBcdJ2U/mdXFtvmZBGRb0JzdjcQuwUcMSrLfPPb35eQdpm7R
         TyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738895760; x=1739500560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAulhDluaDqQIDAbLs7yhsjJQ/59LkpDHg7dqImxVlY=;
        b=AIaouioM0jQwVhSKtxhMOzXg+Totbg68uzRKwT4IMJezZkFDxujf+K8Ha8cCGKXYnl
         YZgigeVnn0PcabLdrv29HE12Bmd054xBFUpadFoG/JcsKWvCYNy6lWSMzd7/YOJLw2ZQ
         x6rOpXeGBvGwmCUiUURPImhZJf7rUQ1ws2ZysQfWUMUtAGCZbEqf9PqznY2tptOxuhR5
         98zg2Urgqe/BN3NXNctF4vS62ZFg06pxhjMG0CHSUs4z3en+ep/WFQtY5KP2Y8wXbMct
         HZSYetrSR7FQ1TPc4JS2L6uVvepH3tgCYLPff9Da1Bne6Smfqsm/VzXoZQ1TPGZX+Rsb
         IaSg==
X-Forwarded-Encrypted: i=1; AJvYcCVMsOgORd/msh/Mu5frWzsNm9S1jmQR712vTobMZowqrQ4FZ07f8r/Gbazjg+UfCiKHSk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FRNQGtawSGePXo7XZTxdc2MVqNTxcIah3tVgY+d8d+DuYdkS
	WmMlEDvnQeyKjXsvag2MqRLK/ZzKV0GWTiJDOwmpWCZ6kf/FGoKb2M5toRXlZjRh+RupnmNVkdf
	ds09MAyLBLP+0efRUbNgVS6vjq4PRQLmZ
X-Gm-Gg: ASbGncsU1J5RC3gVjqYSKtDPdnU+pF5+jtbb/StryeHg93wpjbpGCYSlPSNJq72PWiS
	ZSHy9FCFF2pllV+wQgeVxNg2iY7KBKnFOiYEu7butXhFIvvcNEl9jUVGG1NPNxs/uerSh1Vnt
X-Google-Smtp-Source: AGHT+IEF3KHIB02y7/7Auxt/lmcgSqMxCRPvMhGLwG0TP9LxixvqRX4RhPQErQdQa7I8zwCDR74KnQoZ5xwow/oZKCw=
X-Received: by 2002:a05:6902:102b:b0:e5b:44f2:e2cf with SMTP id
 3f1490d57ef6-e5b461e7dbbmr1141187276.29.1738895760326; Thu, 06 Feb 2025
 18:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g> <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
In-Reply-To: <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Thu, 6 Feb 2025 19:35:23 -0700
X-Gm-Features: AWEUYZnWPgKO-eQ8KNImRK5M7OQLUxOktCYjxmJGWDg12U73V9SLAwRRSxh21s0
Message-ID: <CAMMLpeQvJUZJuwvK-H=M_FFedpgazGOPH=7wvPCg3U8RrxEtkA@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 8:11=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> When running "git pull" with the following configuration options, we
> fail to merge divergent branches:
>
> - pull.ff=3Donly
> - pull.rebase (unset)
> - branch.<current_branch>.rebase=3Dtrue
>
> Yet it seems that the user intended to make rebase the default for the
> current branch while using --ff-only for non-rebase pulls.

You make an interesting point. The idea is that more specific options
override less specific options. In this case, "fast-forward only" is
more specific than "rebase" (because rebasing might or might not
fast-forward), but "my branch" is also more specific than "all
branches". So which option should win? =F0=9F=A4=94

On Wed, Feb 5, 2025 at 2:14=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:

> Is there, then, an existing combination that means roughly to treat
> `git pull` with no other options like this:
> - if not rebasing, forbid merging and be equivalent to --ff-only
> - if rebasing is requested (because of branch.name.rebase or --rebase
> or =E2=80=A6?), allow it

I think what we're missing is a branch.<name>.ffOnly option to make a
particular branch fast-forward only. Such an option would be
especially useful for the master branch, but you could set it on all
of your branches except the ones that you want to rebase. We could
even have a branch.autoSetupFfOnly option to turn on ffOnly
automatically for new branches.

-Alex
