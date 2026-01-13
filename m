Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6B187346
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284078; cv=none; b=SowuXdpSeV3ssoTpeoQtbZDPnewydA1ykoxsDUBvU3DqnknXONOTkGimsF621ziAIROZfUsAineoZZTNvyyqaEzXBPUHN+VFlf9S/fzjY+VFVIq+vEotpKRb0SaGYqRjDXuysPkIJRtzOz/lhUkXfdDGEE0R77zJxYAj4QV3jDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284078; c=relaxed/simple;
	bh=SJ6tvgp04AQ3mf76lGDYu+trdRhp54QGSUewJWXC5gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa0cDktSPXc6LmVvWomDmrw0bouLWYx333Sj8Kq4hzPa9DPEZ5rPk6tAMJ0YAEyyWBHzYgasJQvJ4Rj0IbolJafqzFBeTW3Mcjg1f3A7PR6Q5Syt7wRq/0+tHi4IgD5sr/JPUK9U0VLxCl62u+tMhnvcfQhjcE9p8odybi42xl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIiaRsqN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIiaRsqN"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c75a5cb752so5409636a34.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284075; x=1768888875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7RwQ63rDtRZD2yPoWGwiHUpyomQGhwh4++wPvAmg7Y=;
        b=RIiaRsqN+5CDvAAZh79IOgTfKOG3TYY79AyfdDXjJAZlLQOoywRRe3CMaXcFNW71SS
         z5edGLJfPXx2H/nOGXkTC4n62lvlayT6bkBTw9Gan2LJGex/JEJxj7rSWWW2HDY7Yvaz
         lvUXYQEJgCQ7JDaQW+Gk+bjnKZszXznOFAcKlTF0YY52Zzk/8QG2q0FcB3JEAeGsw2IM
         lfviQkF+2IwyvbiejZKRbxDlBoz/6qloVd/qTfLfIEDKZsO85v02W6YmAQ4czZA/ZDLp
         id8kg5kcdlhx0gI5fcr7Go4OUt9YYf8HXDuTi2T8AeQppl549I4ji+2++/DoDn7/17PO
         TcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284075; x=1768888875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7RwQ63rDtRZD2yPoWGwiHUpyomQGhwh4++wPvAmg7Y=;
        b=aZD0rdRPpDPoIeDSrMSAOSxJZQTL8D8vqxCfYEuM8zTEPytKyRsEhOUnqx9rVS6hwT
         ViBTEzUCRhiQ7Qvol2Dv3VjUQ4UcSFhzGSGLd0D+p9C6vFhoC4a4yDfqPGImkceF6wSO
         D3g6eg2BYgs/lyrR1saDyFVk9AP4OHJ/VZtXNvY6T5SuDI7uVT36/lJivKuy6Vkf96Ah
         hueShrhpf6W5uLX5lHUHWE79hHEBUgVwvm3a+IMPoqcBHizfNiuzTkNUU19c0Yzt/Cfz
         X0OSclQQCGoKwTMtsO7MmQzsge9t346bEncm75IWpjTh31HeXCOYqcYV/OKF0tjymZ/O
         mBig==
X-Gm-Message-State: AOJu0YyB6d6RvSkReAn4F2uDTgdDtlDn+zjcuq1/5ju4Z1h5mXxfCBvQ
	nsAHzbOYD6Nitk7AhgNIYGzGOejiWY0T2/PtcEHmbug7tGM/wBZDeZiO/W9KgB9R6HCEBRvHBNS
	DuYi0+EQjJK/obLsJBdB07gFAtR5PcrQ=
X-Gm-Gg: AY/fxX54fCT3eaT5OFUsMwkjGbYyP/LDi19iebbTOV+6bFl4y+JQTUjLelmk4J3T+5Z
	eXtLK+srePVw8GcrGW8SELEhabW5C8dHE25uv7WT3ZVvrMUZnccOCDOHVcL7eLD9rgHUlVE+d+8
	te6XT4smzPYANhpRYOoale5BYLDJ51rbEmzQ25kbViWXUln/yU9CTS21pa87Bh38qlE4q+81i8w
	VMXehuLosIsW3pBJZMD+yM8m2Qyg8hG0haDWQLDQLRaYjGBXjbL/LduXCjb/1GmTGEKt7MTs/uP
	2gwdOX/wLSDC1526Trpjr4qENWQf
X-Google-Smtp-Source: AGHT+IFANRGOeCFpJ1schhNMXgwDACN2teZDjBkSLETIvB8ttF8GBIXEM2UM8rnmdt2xlwVdY6MvnNas0Lf+L0j8bz8=
X-Received: by 2002:a05:6820:f002:b0:65b:3480:6453 with SMTP id
 006d021491bc7-65f55081da2mr10339603eaf.72.1768284075520; Mon, 12 Jan 2026
 22:01:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im> <20260112-b4-pks-history-builtin-v10-8-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-8-e3c6aa5b4cec@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 Jan 2026 22:01:03 -0800
X-Gm-Features: AZwV_QhaYfdt_j8VG1PXIwXWSEkrzmQJguAffHtgxrThjNJKVgZwuVZwrRrMoEs
Message-ID: <CABPp-BHq35ySWhud-_53BXE1ed=V7MqjrpWDzgWkcs7o_Lum-A@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] builtin/history: implement "reword" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Implement a new "reword" subcommand for git-history(1). This subcommand
> is similar to the user performing an interactive rebase with a single
> commit changed to use the "reword" instruction.
>
> The "reword" subcommand is built on top of the replay subsystem
> instead of the sequencer. This leads to some major differences compared
> to git-rebase(1):
>
>   - We do not check out the commit that is to be reworded and instead
>     perform the operation in-memory. This has the obvious benefit of
>     being significantly faster compared to git-rebase(1), but even more
>     importantly it allows the user to rewrite history even if there are
>     local changes in the working tree or in the index.
>
>   - We do not execute any hooks, even though we leave some room for
>     changing this in the future.
>
>   - By default, all local branches that contain the commit will be
>     rewritten. This especially helps with workflows that use stacked
>     branches.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

This patch is now a mixture of my patch and yours; all the changes
since your v9 & my patch look good to me.
