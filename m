Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABB1C2AC
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836448; cv=none; b=bCayim0XzdHgKaIFW2GEO2ikU+FvotGrz0MmNxfq7EdSpDRK/lpDXUixckMaaXmx5wQu2NaVXgSOhMSPvNTyIX882je4BlmJgu7F6NRNHCq6gaa96bdptVq49+ck1DzSpWflnMnW1hxYndENHVZPBcFQnGDNYpccOId00ezjEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836448; c=relaxed/simple;
	bh=wLWm3NghU0S7z7GFcCjOgu6LEVL3wqxcXy3XjoUR68A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCp4wWxZb76QUKQx/rs3AuUVEcPBKaOf+MhYcurt1fSJk+LnUFkOqFHC+NsWfpktM4EKc1MJ9YZBucIqDBXk3jmuIdxiD80wAzR9JlLDgVk2KeCCLc6H3VQNKjyMha0x/vs1tR5YvVkrqDVgc0p9dTVhnQQ4GknNnsv1TQXR4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKkbdg8Z; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKkbdg8Z"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4141c4438so11376041fa.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 10:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709836445; x=1710441245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/IUvd7kF0tw87pqbfmIieS4VK3OZV4UhZbMhRRgOkw=;
        b=UKkbdg8ZyU5QpEsWI5yxVRP4VTWC7YgHXk7+t7BSbqDimsvDkyH/K3WNJ7na3zDsXp
         HVBQ2IWgX3ibCAazWZp3nySkW5u2kV4sq3fH2a+bIW6CTwZU4HZelNGwo6aR3743yI6t
         FRmNK9Y3j607CAJd6+meo5ArwKjoa0NRTiX2uGaXK+LLq6yGHmwUkTYPj9cG/NWUa0i+
         WvRx0qEU189yocV2pSA/sdYBiautusDHsPaOjEf3WT7ScDK57Rvyn8/Uy4F0TK+/pKD8
         wBSGvfqA+aLNq/9EIJyY9qAA6+/WWeaQgtDGRHEhAGHBKmptQLa1OWYTU8Bne/SvYoyT
         7aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709836445; x=1710441245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/IUvd7kF0tw87pqbfmIieS4VK3OZV4UhZbMhRRgOkw=;
        b=SypXDuG4PH9YDwXEoWhs8hHsauudZXy5RDDru5jXvcVEdlLJHq/SkwYgibqfQetPUZ
         fJELNl1fqobfkj/n7CbRTkLNj2yjaAyEiFNdhzw9HUjLrHVIcO/Iav28qcp9ufpRcyal
         M+pc3t0UAun3bsOF/p8iwUagIvl3an8+e0WUkXP0owzePZXm5klfHvXudMnhNGBA2mKS
         GhlNmwuTDvN3s3dLCgpFli6cddZcFH+HTlHBDO5PJBtQnc9UXENCSPlT7bjkb0XAanNc
         8tYkKUvpUEhhCOBBBanIUyK5oiIbo/OVX8qN605qPOd8PWvp+Zq38tRNc0fiOlxZOor7
         xV6g==
X-Forwarded-Encrypted: i=1; AJvYcCWOGXxlRJ5I3ANp4rrfndQBfxAzp8zTzGH+eYiqTafdW5MeIj6xGjKef1lHlAqvh0Pi9noXEZH9BDIUoVr3LhZH3f3U
X-Gm-Message-State: AOJu0Yz6886W5Vu3b34ChTNFe+4dG1wQWw5Ev7mk4CoMTOp91lGe+mlN
	6Ms9rcYzmPpCsjNbZhp8p5H64qwiMJPcjWGGJEwpYOQrTCxdmGzyU/06EM+B0I4GnWUZ0QU1SC2
	4qlixQVUcIk7sMv7XgsFrfPtjhmo=
X-Google-Smtp-Source: AGHT+IGo0WPABgxIR7Q5RT5AveZUxYQhfHiYLthFC52tDUqAoQFL/SCVYP32TvNjpDNi/ilgMc9DgldpJ68J5yJXOPc=
X-Received: by 2002:a2e:a546:0:b0:2d2:346a:f199 with SMTP id
 e6-20020a2ea546000000b002d2346af199mr2138366ljn.47.1709836444487; Thu, 07 Mar
 2024 10:34:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
 <pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com> <CAP8UFD31udQB2e=+G-LpCevuS+JxQdWqwaq=5qvGEn21595faQ@mail.gmail.com>
 <CAMbn=B73boxu1HDy2UHGz83wxnE7=udmbSv4nFsV+ngA0Bn0Sg@mail.gmail.com>
 <xmqqjzmdnbz4.fsf@gitster.g> <xmqqfrx1nbde.fsf@gitster.g>
In-Reply-To: <xmqqfrx1nbde.fsf@gitster.g>
From: Aryan Gupta <garyan447@gmail.com>
Date: Thu, 7 Mar 2024 19:33:53 +0100
Message-ID: <CAMbn=B7J4ODf9ybJQpL1bZZ7qdWSDGaLEyTmVv+ZBiSeC9T+yw@mail.gmail.com>
Subject: Re: [PATCH v4] tests: modernize the test script t0010-racy-git.sh
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, 
	Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, =?UTF-8?B?TWljaGFsIFN1Y2jDoW5layBbIF0=?= <msuchanek@suse.de>, 
	=?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQSBbIF0=?= <jn.avila@free.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I was wondering about the same thing.  I still see an unwanted "[ ]"
> > around Kristoffer's e-mail address that will break responding to the
> > message in your [PATCH v4] e-mail that can be seen at
> >
> >   https://lore.kernel.org/git/pull.1675.v4.git.1709716446874.gitgitgadg=
et@gmail.com/raw
> >
> > so, the experiment revealed that it did send some headers were
> > broken.
>
> This does not necessarily mean GGG is broken.  The majority of the
> patches I see here from GGG are without these funny [square-bracket]
> around addresses at all, and this was the only patch (or it is
> possible that your other patches may have had the same issue; I do
> not remember) with that problem.  It might be caused by what you
> feed GGG (e.g., the messages you give it in your pull request) that
> caused GGG to hiccup, perhaps?
>
Ohh yes. I think I got the problem. I have fixed it. Can I try sending
the patch again now?
