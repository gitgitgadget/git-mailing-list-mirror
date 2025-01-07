Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8C273F9
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293005; cv=none; b=SToSp2y8ty5A0M3wiwgzGARglJmh5pfEQthL/rKqUCDsJMnbT2KxwFzqvBuz//d7oMxFsUrYp6o4JbzsfAdjxySM5C/09t966KWj/gB9psGlHcL5a2asrru42vxDm1ayCflCOtOnybcJy7aw0tCKYpLrKf8sr4S7xsVS8jCEF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293005; c=relaxed/simple;
	bh=8Yoo+FlJXrugVblIy3Hv+ysX5l5TbApGP2HAmMsCSbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsHiptQMibXN+U4TZiv5nl3psYyhXTv/iKOy8QsJkeoXZZq62XapC0Dy8JI6MgUhWa2wOObCsKS/3hD9SKhCWrhLNN3H3mfcidjSj/CZ49V6BEgYDCRXV2UAOA4ATvKYgiSF8h75CR2sxKvUzFSZo00gqHIbu4QY6eLgPKAgufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf+CMk6N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf+CMk6N"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa689a37dd4so425974766b.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 15:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736293002; x=1736897802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Yoo+FlJXrugVblIy3Hv+ysX5l5TbApGP2HAmMsCSbU=;
        b=Vf+CMk6NC8Gplli+oBDOHyTdhpH433azD3omISDG/D+zlGto8rhtITts3gs1HKzhlI
         2W+ZM5p2vRvoqGuklOS+4qUKfWLv9npNb6AjiLXPX4WT5BGC1vAj6YdmAU1PHNPrdtf6
         Of6uSkaP78BH5Xq8h/b7rH7UWZtb6wwfZrWDdF1qjNgK9O8hOH3k/9CjkxTncgHfp7YM
         b8MNL8Lr90mRjwU0VLJ5iwcAiKdnU6mplmxs08qlMYxxHoRQIjqm8RKPu0ExUq6oHpfo
         gX9MLG+oUpXsXgYwH2mEso//WqAoJS45JnwscRWGRRHCMdh7ci1HZjAfuqi5h3ie5tu+
         VJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293002; x=1736897802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Yoo+FlJXrugVblIy3Hv+ysX5l5TbApGP2HAmMsCSbU=;
        b=ssm8WRVuG2aehob7IzchU6A0J+WAjCEDIpjmvg8ojyCdYx8j5DCAgSh2H7OlPhKVZ3
         pfgbabUBaPDwb4VlDCQs7lCF/G0ENXurNRlFMpV4QHgCU1FZHVVZqbpM8OpvTvi+joqg
         4Onw1lGRot2juqSapU1H0vxIOr+vBKgwNOb5luKWvV5SliHihB9xTv5t0l/g9IoQZZpx
         wYaws/vze+2NmcOPvVRmWppqwiZfeK39pJbE0HfOzd5REjqAaBCQmZc9dZvBa0NIefDZ
         LpB++nG1sFacCmEkrmGcJ1hIfiroJAve8ANIrIZ5qhdb7mje/EAohoCEy6XzaMXtD1MR
         2e1A==
X-Forwarded-Encrypted: i=1; AJvYcCWnBU8f6bF9thw4W4/PtGV+EVLFLmmHCapodDTC6ZqotN+4Ku4iTZBwU2ClcEOzNNxL45Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBdeDMIDkyCudmXS17rNbUgI0cf9gqy3YpvnWEa5/hsKkjL1j
	okDwIZM0xtPbZMpk9yj2BR1nC+a7hjJsHge/1ufJB806v2zfVfhtPONSPSnfe0mBjWZ3iRSSh+T
	fpYy7xOrb86ojq9QyCdANMCn+LMI=
X-Gm-Gg: ASbGnct7yBfM55tClHkVdzsJ5FfwjiY4Efj7+V6+PICAGQl1+VCMb82v9ft8d4TgbzU
	gyqM8v95KindwwOwyLcRmOS0JVNcLsq9C18gGPZNeN0eC4PdWRTo2JPVJZ1f9D3q/vl4b
X-Google-Smtp-Source: AGHT+IHbln4ryNYpEpoGzZ8P51zx6rTZKoeFdBDeUXLdpIvwJvA3poSzc9DQyGff0miaoHFiy/mMyQ08klQkPtknisI=
X-Received: by 2002:a17:907:7211:b0:aa6:7881:1e84 with SMTP id
 a640c23a62f3a-ab2ab6fdebfmr47243166b.15.1736293001454; Tue, 07 Jan 2025
 15:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107071824.GA594237@coredump.intra.peff.net>
 <f3ab08db-5dff-4da3-a075-7e9b3eaf1f78@app.fastmail.com> <xmqq5xmqs95j.fsf@gitster.g>
In-Reply-To: <xmqq5xmqs95j.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 7 Jan 2025 18:36:26 -0500
X-Gm-Features: AbW1kvYPbblbQYn-RoMV8JzFyCbM1SvuxYk71Ww7s9jEcAZvAwfESc3KQ_2wmbo
Message-ID: <CALnO6CAUZBB28vCjMF8HRxvdv=N6y6OVyXZF2Yh4rK8c-sQU1A@mail.gmail.com>
Subject: Re: [PATCH] t7407: use test_grep
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 2:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > On Tue, Jan 7, 2025, at 08:18, Jeff King wrote:
> >> get rid of them.
> >>
> >> (It is also curious to grep in the expected file in the first place, b=
ut
> >> that is because we are auto-generating the expectation from a Git
> >> command. So this is double-checking it did what we wanted).
> >
> > Missing =E2=80=9Cthat=E2=80=9D? s/it did/that it did/
>
> It is colloquially correct, isn't it?
>
>

Reads fine to me.


--=20
D. Ben Knoble
