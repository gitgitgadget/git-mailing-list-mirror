Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E55BA4D
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728009756; cv=none; b=tdmO2vkTDHoAqCO5h2jpgy2TJr4U+BAuK/QCTTnn7VqVtAvdPkf0MwWuEedfgeHU7WFbL0h7yVKaREQYV9CI4xwTE+D7vZL10eZTAehU5HAt4BT6RP23+tUxAJHOh0F3apOP3Qy09xpwobWUaj7n94/MdpKTJiV4f3JVTIYUopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728009756; c=relaxed/simple;
	bh=BmVyE0e8PiFIKDIjzKL1ToS0DfULfpTgLgJYPej02hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SALQL9ZRVQlROKTgJ2yKtFw+jRzazRGLAC0CDn7CYDk9UwSV4C9HH8G9Z1/bKJbEgak1iPpwHTA4Zj9CGq2FWJ/rn1y/gmnNbZnjf4CE4MpxeewX0EY5/vr9rr269Aqc8DLLsg58JXs3QlH1W4KqHbcor8xIDuZCj6vmg+2DZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=IzJL6sns; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="IzJL6sns"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e25f3748e0so17943557b3.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1728009752; x=1728614552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+rnwAqi2OanUSYv/8eWZxDSTQv875qvmBoqUMNHqnw=;
        b=IzJL6snskC720j04rQWcquvP7K8pT2j6jXjZShVwzV7INeJ9lmuK+n4Nf8tngzEGMP
         IoviTDIIQ9Whj0NbHaT2OGOD+KTkIw/L/4YoqXPAxrl/PKvvbhFFOxpDS8GpxAi+nMkj
         SsDpo1jqF8HgTMqoYIZaTnEwKDhin+AQAWkni0NPutKhaZ+zUVFgo4vBDF81fPbsOglJ
         Jc6OomRth7ruY6b9ZdWzidEQ3v1BDpyKsi24oyktzBXzvfWJtbh9qxvYs/zmoXObp89y
         5cBHApLLeEmJZrVx7ie3lzaROlD2yi/n8Bmj8c9ZU2uLNUwEJyKx++AgvcKHP8XuYJEU
         ADpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728009752; x=1728614552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+rnwAqi2OanUSYv/8eWZxDSTQv875qvmBoqUMNHqnw=;
        b=ZCbhUgsv3M/RkHk0LIXv7E+oB/Y2BNDR6BSvkfZ19oyXrj0nD1qS63Wd4sn6L8+W+t
         oZVPNYkIT2xsHqR5ZiNbJcn8gx5mG7X1CKI6AigTkfawLHUtGXYVql1LPt+xngILDCB9
         oJBRCSkwZF2owSG6UqKwcgxZGpumbk7/h2q/KfNiwIkuvXlHNrP5rweXlAkFHgYd9lJF
         MPAVyCyuzHTkaAqggSL7jJ/0Omv/imG1avDNTTRllK1iATFlZdCA1+yaImjXRnfmnM5M
         tXE+jIMZBjuRSH13SLc7ZORfVQklGzo6VGw0Il1BquNNkZNZvbvgizMrZq/c72sMUBsg
         tL2w==
X-Forwarded-Encrypted: i=1; AJvYcCVMbJC3HByE0Z5MLOSGPhaT4dLudm0LL8leT7eRiZRw9bvw9Rh/dHYmsb5/Iz2PZZFsitE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOl8CiYeYOfovHo4JJP5NBctcGyBhESLynZkRuaobuXR8jnv1X
	crHOfuKGMqE2pYzCxBctO7u4M7j4WucXfgvdSjtE+SR8RTkc++GOpKxGTtAJ2iwRaysz7sEScMF
	lLZZU7zKBzGjaEulUwD23S2WjMlmIZ31lsTjlwp9unM+Q7/Vx4i0YdhjW59wxUfWu7MjRdtmq9G
	urHDO8OHg5Tnq/kFgmpCilgY4Sz8ThsjYYrTvc9q3RPdCpBp0kKxuunPlDcbYm8YO0AnSR7zZNN
	OvlXDNGrP0PpC3OnZMZujZuJ4Urygzss8YuX4BHUdb2ZGxvqj2ZR97UJNf8YE5nrGYi5d7dq2zN
	FdnicO+c0P0l3uYljXuBbpie
X-Google-Smtp-Source: AGHT+IFpn34ojq4ezGPHWGgX6Gmj5K2OPuXRweLksYBuz9voDTHsjsVLc8GdjuyS+zX4aeGDJPKoguSJARAk+lG6bBI=
X-Received: by 2002:a05:690c:2f05:b0:6db:db51:1a6f with SMTP id
 00721157ae682-6e2c703c243mr11208237b3.26.1728009752612; Thu, 03 Oct 2024
 19:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
 <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com> <xmqqwmis11f7.fsf@gitster.g>
 <CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
 <xmqqmsjnya1c.fsf@gitster.g> <CAOTNsDz=gV1TQ=N+8V+CdhWkPSogNM-42B+vzhDNWdM-Wz9CfQ@mail.gmail.com>
 <CAOTNsDygwBkNdFX4K_ixL5kP-AvDxWWVXkvfkmV4Kh04ozdYkA@mail.gmail.com>
 <xmqqploimkx1.fsf@gitster.g> <CAOTNsDwSTO_iXqG7-ez0O0Y-xbDbEBa6-EiAL-DL=PR1nbM6Zw@mail.gmail.com>
 <xmqqcykhhyj3.fsf@gitster.g>
In-Reply-To: <xmqqcykhhyj3.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Fri, 4 Oct 2024 11:42:20 +0900
Message-ID: <CAOTNsDzOscsO2iv63J-hXzz0NHhuZNZqLiz+QBy5WAbjzr+ipQ@mail.gmail.com>
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> > Because it's getting complicated, how about the following:
> >
> > * specify MINGW
> > * note in the commit log:
> >   The test is disabled for MINGW because hangs treated with this patch
> >   occur only for Darwin and there is no simple way to terminate the
> >   win32 fsmonitor daemon that hangs.
>
> Sounds good to me.

Thank you. I've submitted [PATCH v4].

Koji Nakamaru
