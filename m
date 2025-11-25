Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C31157487
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764051320; cv=none; b=dvrYLfckZfOof+i2rC8WHYq1SQQzq9GrmVr6gV3sloinpTTG0Pf8/Vu63EFeBHqpsq0klWYpYJ7k1EC2SH/LYm5KWGOfIKJR4ZwJ83/HVArOXOyGL2on4CYTUsHgzJN+BE2CARfSpYU4pGyJ3QcLSans+sZSSe2Zz/kcMPorIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764051320; c=relaxed/simple;
	bh=qX9MdHEfzbv4rMCD1SLhPMSDm2/wKz+z1hOwaSzoWbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI5P3YJM2FDsdS68wU0L9oyWavL2B76p6DDMCrJve125Gpr2+s6r4MJ335Yi4VNyruob2X3NgoeUg5yVIectt6fiVqebe78d58Y4WfNnWlPhgjEF4gZZMwSJuCOkAwI7CUy51bFjl33L+9966qF/xzVrOCePSD/hz1J+M+oYumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1vu+h+e; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1vu+h+e"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-43320651e53so19309985ab.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 22:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764051318; x=1764656118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnuoA8OywEra/ToLRIxHAGBtgyUY1GiXIDzOxkxbXG4=;
        b=H1vu+h+ev/iEptV96y84m60Aha4+AnZ8gRbUsiHRo4RUV3t0GUGz522qYpL7vPw4db
         JYdU+mWXY4q/2OP4WsrwN8yOvQqzfKPO65bcMm29xOzrJYLUOOre4Flr/Z4lF++iox/1
         tX8AkoaE4jMiPMMVmdD7lAgEp/DLyvAS93x7ndlG5e12Najmpj7aaCZcbT3EO6rEm8DA
         QsL1iQ9PyTI4u7bWb7oRxyIPrKlbXq0e/+FoE31zVg7O7Tff3i+T8ULD8vq5Yy644o+b
         yY5w9b5rNB2hK21NN06wA1IYfW4nLdReDVSrSHd7sDT8Dqdb8bdTA9odSvjbNM7b6oU7
         m1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764051318; x=1764656118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnuoA8OywEra/ToLRIxHAGBtgyUY1GiXIDzOxkxbXG4=;
        b=jx8VbXMlC5Zb+OsGvG31Rgsdw/8ACRwXWqlRlu2HoBpcFe1vBZ/9LNDE8+E9eEgAM+
         TCmw1v9L1JQN3uKJc/Dwd+3lWOiUZihfo0BDj0ucXVjdULuItBMZJwertgVpBQbOadM3
         7JDb8U+Zp4Dh9I6a0rUGe6OxcWxLen1yo9P6TDDhucEHW9+V7XxCZcVSwqCW7qb7cEGP
         TtKayrjacrc8RaYxvOjn6hnuSlha7NjXID+PJX8WxP3OTNJ5YnTT1ZEw8GQzi2MAzzRl
         vWUoIuLhvyAH3Gq4a112ioNXIwUjU+YD0PD1FQ5540F6nmm6p4mNoesY+6TMvVzxme75
         JdWQ==
X-Gm-Message-State: AOJu0YyIEnggSzYdGPqoQ6U9gMPn+3GXMruVEDlcATJPLV8okmEbX49L
	1zKjd6u3tvEZYMhdo+w8pp42a4HgE2RFmH8xYw7cncdgpo4pT6c6X6hRa5Eqi22ifaejGVo7ZDw
	t16pcr3N+MbGhxRXDBb6QH8cOBfDlECQ=
X-Gm-Gg: ASbGncuKoqaAcrbu+IWIA9JLugsHCNhTqLDtmZOpLBwNhVnz4rBWq42043A/PuJVZfo
	MZjsDta8vRctdMRqOkrpygCaC5dxC6085mRaQT8jMNJGW/ebzsKFNvGii+hwOtkyDtigXG0yhBW
	OSd2v9Vwq0U72LUId6DUEtTu6hSQ8huf2e/FnCtWuaZMo59+9Jine0YigTiVzvn5TYEqI08gGx6
	zzMadAzfHTdjAw8ir+UCNStlifQgfy+b/Wab9N2Zi+iUVTB1IR68w2d7axNM0Pnv/iUunrrUy0o
	itmIXZ8whsS3Phis/EGcgTCJeJxr
X-Google-Smtp-Source: AGHT+IEuu11RTzNrVAIH6doQUMinhZZWj9P4ydfaEAp21tbA79K1yLES8N2mdI1UMm/agS/kb2eEVPEzX6/vEapmL3s=
X-Received: by 2002:a05:6e02:258d:b0:434:96ea:ff69 with SMTP id
 e9e14a558f8ab-435dd124f68mr14942475ab.34.1764051318268; Mon, 24 Nov 2025
 22:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
In-Reply-To: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Nov 2025 22:15:07 -0800
X-Gm-Features: AWmQ_bm__GAIe2YzxM24LifPcSNK3B15RX1I_TGiwCwJikFYegmpA5A3XfJ-Ngs
Message-ID: <CABPp-BErdhTjbqDem4Xvc-XbhgLUEpy9-eiaaR1F_diMca--6A@mail.gmail.com>
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests again
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:17=E2=80=AFAM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The quality of tests/test suites does not show as much when there are no
> breakages as in the amount of time required after bugs trigger test
> failures before the bugs can be identified, analyzed and resolved.

I found this paragraph hard to parse.  After re-reading a couple
times, does the following convey the same meaning?:

The quality of tests and test suites is most apparent not when
everything passes, but in how quickly bugs can be identified,
analyzed, and resolved after test failures occur.
