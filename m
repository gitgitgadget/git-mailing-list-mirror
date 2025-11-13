Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53932ED5F
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021840; cv=none; b=N5FuyETnnzKC2uECCW/eewabE5k8p6zn4IXr1/wBdSp6kq82KOvKKQeh7eA1RBchRchWTMKk8eBMaDY+v4PnCfEkUcbx5cm+pJsvnkXij+2t31HD24ac9lP+vZlxudX5QRDlo42h+xNArKgW77O+TeMaYdyNvWlEivuI/GHCD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021840; c=relaxed/simple;
	bh=HpSEJFGFqg5uSvZIn1My8AGMcTErQjEs3pRIwGGYxUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVMZ7sxOkGBUjPnrgyXIp899Z0afmZdp4Otf/Dn3/5HJss+mb2o9PKwd7gSdP9UApvFoCdHKpqVWlY7Q1cEw1d7ClHg8FboJLEQw2mFsxOnsxBkcl1yG8vtqk1n3lRr+il5kOSNjlOtu+mTE4pgDd3GTUslpUeGjllc/KSnwWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=EumueJbl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="EumueJbl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297e982506fso5653695ad.2
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 00:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1763021838; x=1763626638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnu2rHgR9ZNxjNwmpoTxJKBAQfV6sxQAINMMlPqHoPE=;
        b=EumueJbl8a7Q1vVFQknv0H/XPlWwZYUWF/3Z4xiwImTW1DPZ7eECjvVgODc6VJVkcW
         TtQTWlppR6zgNO3YHNM9UL3FuBygCf9uVpbQWtBvFCmENp4oX66yXA2jwFMxTLUr8O3C
         q/olnRVB4cMMFmX30Sx8LAanPIxYZFVldpEDXiPqNFpsEr6G/BjSaeKs8PH11Zeo9t6R
         Y3+W+8qDp0ACEwWMSTwCOSvkspmEeWDohrObb52CWgG5DiVMIPPBcnpykUecUU1x3cag
         0Zit+nuUk0ZnURmXhqYRzcNscElETfaQ84mPBdwTflMUDxfcROA+TcUgN9LPbgh9VhBg
         ihFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763021838; x=1763626638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fnu2rHgR9ZNxjNwmpoTxJKBAQfV6sxQAINMMlPqHoPE=;
        b=MzmSJ1hrVENVQXNd4fFcPeIwwwJdLrWTYgsNvaUqFVv1K6OCsuC8jsuCi0fiGVmc7D
         kRwTxmB39b2HuA3qRsAT1eKcNKncIPoFFsQys7QXmyNj+Wy7F1bR7NeLrQ0J0ly+5SUW
         ZvWMaeMg9qsCZjpPiHlLBL4kT4qXJVeM/YfoXW8nqRpbyM+cJfk44n1X2q5Mldw66QEV
         2KhJAMDThD2HoFC663yviUO0M62MVj+A6DpZqOtbpzTU0k4dYlep8XoTkUFRO43gkZeA
         bHU1J5Ctw7NsGuILGMxKRR+5zb+yci11pRKvpPCB9aW/vDzpOfTn94lkRq6hJMKZNMZd
         hA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtg0pXwahb9l+1kGdNv7oTAy+cA8Mz4cM9Nv5f1i9SUDeUkrKkuCWT3b7INCpLCQgWLdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygjKpN5qNL1D1MVZUXqnnlYVz81wlQ9wY9e7CrDnTo0Cpg1v4I
	v9GuzRdPS2vk1Z/dxU4mYADKXIBUJGlu6wIFebro/vimVkxSAM0P/Gr9KtLS+NCOJfgdljKduQM
	tvRg7z5GRwLlfR+R+ITV6ApPVx1+Op9/9DXbDbNLoJmiV1ZhQ6RjNYVkDxjnf7JhjOYl6BQw9QN
	0/JGS61gxxFPw5DqDuNmdfvxmwukMLsZ4WEJGpVFDgdgfqrtWrLGBz1h1GyC3GIojS8QNbPaY3D
	7PhuRq8R2s4aaa526wOkEPz+xsh3xJt44TvV+J+fyTfSeMYj2lL7Z6Hdv5XLXV5ruH2qA+Pv3lI
	25lfSViOnu0je78=
X-Gm-Gg: ASbGncuB95nWL0sDp1RuJLGFGPcdQSLoLtYFa8pU58pHoQk6ghbODlkXqXHrMUZnYNl
	CzdjzB/APtnPAd5symo1ozeCwhsfRCL1sqlS5/c0qYDlruiAAypSTeEP+dcK5FC7VxGsGD7OTc4
	2ZD4MuFFq9+1ktds/3LFd6TdsznIFDdG7xvjfBHuoUDp9I2Bsb2/bfjIbY/zHN23kYr6ZWleCub
	QVjdWRqK0PvcvioN66OBhxZ54tXy7rrastd0a6EGjH47hRrZ+TMvAcHJ5DLAw==
X-Google-Smtp-Source: AGHT+IF4BqPA/FmnB5eyGOm6YXOqGPFrt9a3LMPPBt6z7b1v5/CMlutS48uOFZ1dJ2yQfsJ5YeabdzJ0uMMHmGwEtT8=
X-Received: by 2002:a17:903:1248:b0:297:e1e1:beb1 with SMTP id
 d9443c01a7336-2984ed92f2amr88419885ad.16.1763021837515; Thu, 13 Nov 2025
 00:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1998.git.1762930881599.gitgitgadget@gmail.com> <xmqqv7jfryet.fsf@gitster.g>
In-Reply-To: <xmqqv7jfryet.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Thu, 13 Nov 2025 17:17:06 +0900
X-Gm-Features: AWmQ_bndFvI2xMJ8vCRjT1DIthW54KbXQFM6_hLI_MfYkcKiQUF23maSBWDVav4
Message-ID: <CAOTNsDwmMb2P9J9=GDJwyYRihdKQHixcX=GkdL8j6uNL=L6smQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "osxkeychain: state to skip unnecessary store operations"
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Koji Nakamaru <koji.nakamaru@gree.net>
> >
> > This reverts commit e1ab45b2dab51f94db9548666dfd7af626d2aa7e.
>
> OK.  Let's make a mental note that e1ab45b2 (osxkeychain: state to
> skip unnecessary store operations, 2024-05-15) appeared in v2.46 or
> so.

I see.

> > That commit was trying to skip to store a credential returned by
> > "git-credential-osxkeychain get" by setting
> > "state[]=3Dosxkeychain:seen=3D1". However, this state[] is kept even if=
 a
> > credential returned by "git-credential-osxkeychain get" is invalid and
> > another subsequent helper's "get" returns a valid credential. Another
> > subsequent helper (such as [1]) may expect git-credential-osxkeychain t=
o
> > store the valid credential so that "store" cannot be skipped by just
> > checking "state[]=3Dosxkeychain:seen=3D1".
> >
> > In order to solve this issue, the state[] mechanism can be refined or
> > "osxkeychain:seen" can encode the whole information of the last
> > "get". For now, let's revert the change.
>
> Is anybody actively working on the proper solution?
>
> In a patch series that replaces the old commit with a more proper
> solution, it could be a reasonable layout of the series to make the
> first patch a revert like this patch to give the proper solution a
> clean slate to work from, but this looks different.
>
> If the problem you are trying to solve here were a regression that
> happened after Git 2.51 was released, a revert is totally warranted
> at this point in time, even during the pre-release freeze period.
>
> But it does not even look like a recent regression.  Wouldn't
> reverting this change at this point give existing users who are
> accustomed to the current behaviour another regression, essentially
> robbing Peter to pay Paul?  In such a case, I do not think "let's
> revert now and then hopefully a proper solution can come later" is a
> good approach.

I see. I'll work on the following approach and submit another patch.

> > "osxkeychain:seen" can encode the whole information of the last
> > "get".
