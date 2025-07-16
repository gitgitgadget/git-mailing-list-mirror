Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36A28CF40
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663890; cv=none; b=Sh+Bj6crWiG3Mfr6RBHoYmI2MZFzkPnbTgN6oV/xU9LX6QwxfbN9FnhtPe4Eh1XH0L9lWQVBtSRoI3Du+D380vnapr6K+rr2KbrkFMWV02y5Wu4UM58M0MFzW49CYqtewdh1EMJgel2aQw0ssF7Nd1NP7Maaf0XRt4qbrClQuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663890; c=relaxed/simple;
	bh=8HDHqbjsliJtJN0e88PPDKRimGdZGSrIcGnYbDI7LKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYBp+/m86BEiML8b0sZIhgFai1PeaBacO6r9dlenfcdkHMPFR+7kZPy1plRfgqoGUt96eneo6Ss/3Xxm6Fu7NFPpQ7hmewb/yXtJGyxmsm/Xg6IxAajGlQSmfZ5UNjJ2NrGJbo0ZxfFPmYtKaYoGUTl6jr3hS00UjFPCEoggd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs4YsK53; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs4YsK53"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23aeac7d77aso50554045ad.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752663888; x=1753268688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws/cU8jNMYO4whnP3D8pkeaPqU7C5OBG83YmQBRMuAc=;
        b=cs4YsK53fNl2PMhMkDrd8om2JtzB1wB2SV8FY2wLqCMajyJ+tUf96vyDZiyRUvluFz
         B4h5fmSuHmAz5f9LLNSaPYooxUnafVrKjjowiZRXxPXpa7+ckNrb1xAX8izFEyBLxTuX
         hZ7CXVSfbHfDW5huix1Ycal4IhQS+jPMyknp+I4HGMdYEfhDIsrfQGOvscpQc5Z3yVr1
         i/w8jCIaqFZsN6rCpS2h4N0Di1e9cELj1LNQuvG7A4tDnu+DTK9vvt0hZtYpUcc/oDdc
         aiGcTsJYLgOHJjcmFYwQ/H8k3iWGwYSKk8zXt0/QR4MkBabpkQ+dUre51F9yqGzcWPQz
         k2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752663888; x=1753268688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws/cU8jNMYO4whnP3D8pkeaPqU7C5OBG83YmQBRMuAc=;
        b=KHcqgGRp3sheqgrf7ChYMdvC557Y4zSRI+4EifQVkVOvhChUGW3sPkiayBI2eU3Rmp
         RR8010NMy3hn50TvBi61f2A/xWkOR+wDEeJjOsyhz/ow3NSpC8MEmEXwfkyFigV0HW5I
         8stEkCcydqLi8GuLsSsyYISkiLlYf12Z04fDnw8tJ68EgVScwnQvnR9hkOCTjBipKq3a
         z7iL+LCR11GGk/NNT7bc7e6uUjlDWsl9G8/7eDRoKgFD2df6Qi3BwC3wtb76CHOBcVR3
         VOYPUwEkpgPS7JP4GbruHlpuVRu72cDhihMnmMcJ97qFUJ6SWdiK/75sjlPrPrkb3Rzo
         wSuA==
X-Forwarded-Encrypted: i=1; AJvYcCW+RM3Mgf1yQkfpuyA6/FibGBkgbuStFhGHE+B4TSLlWNBNMmbFuCuWd/pUH2tAKirv7t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FTEnHMd1kkiT9I3XtksNjvDrytWjXt34UqDlWfI94e06Ma2K
	i0zhKArxpJu7B+YqhFUHuL7zDb3K/DA0iOxZf+8UQb9q7Uayz8yGKHM+GhoSoeGVN5GL4kzRMll
	PwnNgLvEfiOMsiQmysvDD7bovLauZOps=
X-Gm-Gg: ASbGncubbGus6pPFMAzzCgAb2knqCcB6gt5YJoe6NckDCYr/rDtGLYq8QnTTAEHXjMd
	n+0vZg5XOQeyrXA2Kg+Bw6CSaaowpPi70orPtOnUthVMfyqdPQ07hu91LNaybkr84WQbqJ2SCJ/
	EmcZqHg0LWNI0Kec+u7WYiZOiV/orZK8YtPM1qGufMhjRTa7RYGn1ZvKSpL6lGbSxE66BPzRKYk
	Szcj2Uu
X-Google-Smtp-Source: AGHT+IFs7xTb7wqYtxs1HlCYbu0E9ILu6CwRri8FPORZrLfwcDEHuOpHrhueODa9GCuxaRqYUGSuhorPnUr06oHAlE8=
X-Received: by 2002:a17:903:198c:b0:23d:f986:6472 with SMTP id
 d9443c01a7336-23e24fbedddmr32426625ad.25.1752663887867; Wed, 16 Jul 2025
 04:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752602474.git.ayu.chandekar@gmail.com> <2a3c2d323bdb520a37a099b361be9ec5f2d5d46f.1752602474.git.ayu.chandekar@gmail.com>
 <xmqq1pqhgnby.fsf@gitster.g> <CAE7as+aN+j4CteHUrr+R+CbZ=qi=mehYW2xQEG4ZcQYvXqJsaQ@mail.gmail.com>
 <xmqqcya1f2vr.fsf@gitster.g>
In-Reply-To: <xmqqcya1f2vr.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 16 Jul 2025 16:34:36 +0530
X-Gm-Features: Ac12FXyDUs-TpKVmXguVxT2rOiDMPVM03d3sFhPSp88BLLEajhT_BkYPJ0rPBuA
Message-ID: <CAE7as+YxajFO0FfMe2wYpT9okYQoevZAghDD29d7E0P82-A_Hw@mail.gmail.com>
Subject: Re: [GSOC PATCH 2/2] config: set comment_line_str to "#" when core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, phillip.wood123@gmail.com, 
	shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 5:00=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> > On Wed, Jul 16, 2025 at 2:53=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
> >>
> > [snip]
> >>
> >> This patch is exactly what Phillip suggested in
> >>
> >> https://lore.kernel.org/git/9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail=
.com/
> >>
> >> isn't it?  Makes sense to me.
> >>
> >
> > Yes, you're right. I should add the suggested-by trailer for this patch=
.
>
> I am not sure about that, though.  A verbatim copy is stronger than
> implementing what was suggested by another person.  If I were in
> your position, I'll probably say something like
>
>         The patch text was taken from Phillip Wood's message [*URL*],
>         with the commit log message written by me.
>
>         Based-on-a-patch-by: Phillip Wood <...>
>         Signed-off-by: Ayush Chandekar <...>
>
> In any case, this overlaps both textually but also intent-wise with
> Phillip's "let's mark core.commentchar=3Dauto deprecated and remove
> the support at 3.0 boundary", which is planned to be rerolled to
> make it a failure when the user uses core.commentchar=3Dauto.  It
> would be a while before we tag Git 3.0, so the fix in this topic
> will be necessary until then.
>
> Thanks.
>

Yeah, Phillip should actually get the primary credit for this patch
and Suggested-by does not do enough justice.
I will send a new version right away.

Thanks!
Ayush
