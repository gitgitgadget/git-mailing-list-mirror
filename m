Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102F26F2B6
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041991; cv=none; b=NPHywHJ8r4skAu6/pPY8PqfB+1Ilit11oT58EnZR9MLfh1Aa0n2v3XfOpJe5WsdAaPYcCyHzarJitQUE6lm/LlpDSqqfLZv9OJqqOsJGyxbGvKwi/O1rPaPGiJ4PHGINcn+L4wOCk6/cZK6o9FWiGooQE8oijCXbHjyUOHzUyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041991; c=relaxed/simple;
	bh=snMbTxejdN4o2hliVLmS9Ttm0/yh20AXmqjIA+YI5eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktnwC/zPBKgBLYiy9RliLmK3jC2p2fYg2ZJayCWxMIukA68vupEoPdEbI1Gv7IDIJdhedDO+tliCBA7Myf0EU8zBBAs/zg3Z2IvRlP8yHr8bfGwNbU7BizHVsvvSNf8qy3ys+vWPUnER6FMI6jyL1NI3Rn85O0u7g7uZqQsJvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwhH8pI9; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwhH8pI9"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-948da744f87so187030039f.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 19:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764041988; x=1764646788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx3fSua4hjkVktw24C5pC/fasEHIWaiw62OUbuzDRpY=;
        b=HwhH8pI9YnfuXUdb3d2Jjeoh4DAWDmR5x6b7B5AcdyJ4FSbmiQ5SfoQrKAMpFBuGxP
         qF6MohhXYRaQpDFBP1oFDwZhl5ID/pL6M8Mg3YwpN+0qappIOn3RzAP/KyAO2StLn8m0
         +8h1kZ9NGrigFmuY71afEpI0NZ+9fjaTbEcjG3+OIJ4ZLKLbCSTOpZxaHPSFQTWrC51K
         G5LncYRokcfS2Ef1FvYxSN+qnxFgIj1qZaOxz5+wSjD7RBb4S1N5Bhzk5KeEDu1VQbKu
         tFghGopvGYT/V+hSoW5gBK0BX0RWjtHtYBoGGJYMeUaIrM7+5lrLKV+4N8OCW02/tTyG
         hWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764041988; x=1764646788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fx3fSua4hjkVktw24C5pC/fasEHIWaiw62OUbuzDRpY=;
        b=g4wgbT9U9+vujpzdTTCY9Mkb7V6ldC/6NAcu6oHayM/Gh2oINQaHwSKqkmr/fTg8MK
         H7dpOMf+PsDoHeOar+BeGzZUjZhkutJtmlAiNIwjWwesMxRyNV7hlKENXKzQ+M1xzkt2
         0I3p+Quyp2/hKGdUllk/wl7pn5qtKBS03iqFu4pPRT/EzJ0E1J4WmTH2RdTVNfwbtI+x
         SliPm9Yah/azYTSPvU8Nt2KPBgiBcOiwBSHqD4A9CXBwJTrdpgoCyLhmL+4XMzb5Up00
         O1OsFLG/OLyEEm8E/WWILAI/lFtsk6Pf6IxCBEOZSFh34L7grrZ52rXMe+0Rk7OWv46a
         riWg==
X-Forwarded-Encrypted: i=1; AJvYcCV17KJd951gRJ6OnO3U7rPQbT/g4k8lOl1ldyeZmnSe9xKxbrluVnu+KBMFqLHHNK5lEZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+455Q5yH47fcdniy5DmaKylG4ADcLKZkww1do5SRyR9tpx0b
	UbipqFVgZLPZAdwfrAwZX47tFULWwUpx8heP4Lo7hyFmVBeSR56omiG+kaV2fgoR/qVIXd0MNvF
	yMyqELo72sayIuoIi297fcNBHKDJ4nvL7+Q==
X-Gm-Gg: ASbGncsPadNdKvIPIOdYYhPa0mvOtqJAxDHMoclHAKWoojhCbEUvdtGKrqrE3EhsK+C
	hJ+V3uFsy6oT++M/NFLBmc70+YXdow0qCLB4upbxZICjcl4YDKIJ08iAOrAavj99xnyIE2RtOgI
	g/PEQ3NOLsn/NgDaZPP682zd+60gJkKP40ON3PX1KUL3pFThZAMyfxriOP4xVWxUx5M/DTD3rso
	8fBKYeqQ1Fgy6GPv+j3+xc639UI32BPVA3WcZA9IFX6Qt7GZpX7J974+8MGHhSJf8EL6vuBbu1/
	0p8BgN5e+3bXTukcIsMPMEHAFIyj
X-Google-Smtp-Source: AGHT+IH0sPu/3NUuvLWlSaI94CK+2NcOaM9kvYYT8EiNRsadODxt3arMesXEMkLoS1ug2syyjNNdHEdMyG8KM4lArZ4=
X-Received: by 2002:a02:c730:0:b0:5b7:ec76:1787 with SMTP id
 8926c6da1cb9f-5b99963e57fmr1055153173.12.1764041987753; Mon, 24 Nov 2025
 19:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g> <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <CABPp-BG-tLuydXkctsitFzozEq-=A+qTf2qOe1vYm+NeRnWsOA@mail.gmail.com>
 <d9194329-266e-43df-ba11-933ecf83b8f8@gmail.com>
In-Reply-To: <d9194329-266e-43df-ba11-933ecf83b8f8@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Nov 2025 19:39:36 -0800
X-Gm-Features: AWmQ_bkFmNLyCar6nGvdY4g4lsFUMOHlPhHpxvgtwXkxnwSXf1vSxsowYREbWSE
Message-ID: <CABPp-BHTYQOooGcwYTQFPXnDG1TL-d=97a7YyBDQgn9QgO1M_Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 8:31=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 23/11/2025 02:30, Elijah Newren wrote:
> > On Fri, Nov 21, 2025 at 6:31=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >>
[...]
> > The range is included in the command above: "--ancestry-path
> > ^${OLD_COMMIT_ID} --branches"
> >
> > And because of this, we don't even really need to "find" all the
> > branches as a separate step, it's just part of the same revision walk
> > for rewriting commits.
>
> Oh, so --branches means we consider all the branches and --ancestry-path
> excludes the those that are not descended from the commit we're
> rewriting - nice. We'd need to be careful about modifying the commit at
> the tip of a branch though as in that case we'd exclude the branch from
> the set of commits with ^{OLD_COMMIT_ID} and so "git replay" would not
> update that branch.

Ah, indeed, that's a good callout.

[...]
> > My replay-edit work used a just slightly modified form of that
> > function,
[...]
>
> Interesting - I watched you're git merge talk about it recently and it
> looked quite impressive.

Thanks.  :-)
