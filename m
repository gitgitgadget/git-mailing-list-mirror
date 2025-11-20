Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29C340A47
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654532; cv=none; b=kSz0McfAV09bxh+O5MoEMNrB437Q91jJtanLAAKrpJBnY6v+8Ccco8+S2OeLA9gqvi7foi2vyxrcyKCz1VYg99A/sTJStlmxHiJVH83T4CCFHnvqlppOIjxQX7CVJS4ghsmExlqN77AQcuwxS6wEKI7MtDaP9SblLjcrX/i97nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654532; c=relaxed/simple;
	bh=Dea3ph/GGnOkSHQby7i+wqbE4hZNz4KowL3oVrfVqLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qncd+fLbQurAUSMjJFDTvySmf/zXFy7NVebnVs54JK5+vZs+4PQve3dFlhfsuPr5WCfppUK8CDQOldt1liFkKlgqXXI6lTDCR2ATIS+pUkyeRBozDB5R+0PUHV+3CcerD/jpMLDV23frdjFG421AAZM4l4AMvf/Q0tsko3E08h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcMd7Ouq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcMd7Ouq"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-343ff854297so1501357a91.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 08:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763654530; x=1764259330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YHK7i6OG33zKi9/ZAjli5oCNcHowEl4pxkzepyYbV8=;
        b=KcMd7OuqEKjVJ6NoNFbeqMf1l2+nad5ocPoh4xX4eiiIdhEg5B2i0djtNwzghPyaVD
         sOj44Gav3qg+dofIwDxRF20aRbr9pq8tZkxJBottDaDxKVgJQ23PgBOakWV9vxTfGPCp
         kUGVpD4ZWnECQYwrlHPD+57rdgxYG2SYe1y2BU8ZJci79O3eLYhqbDZe2MUvB/2K2b6z
         1i1pvSUt45lTO8Jm/2Ig8wNmAXhP+Yi85EQxVBnM0esUf769DAydCr90XzutKbiR7G0A
         LOfAdFmt4oKtiNKal7Tg/Cu7nbf+iVtgSwancWPRDy2F4F/MfZZRW3cI6JzVksnwch9p
         InoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654530; x=1764259330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+YHK7i6OG33zKi9/ZAjli5oCNcHowEl4pxkzepyYbV8=;
        b=N2xOw9DDobrFksmzAdkxOLHHcQ9/G/P9V0inQ0Ams7kV+lJ3Mb7oRGqKJ77+NrxE8O
         fbk0jJZiPulWewxkcfAGJj6bWt4UH2Ff/O+2knN3on3J9gULkx0VNHOvyKjKqI6w64Ro
         RTyCfg0Cx0SCUE0nG8hROngJiNyhKQZZxOgA+mKZQt82232XYnwIYUjI/zlTzd+HEWbJ
         vOKJoQBI6aC8aCUSwbMv6c9LB7Ai4Gs6jfLsZNGwIYYybQc4VibfmMfJrIpzJRRZIS9J
         8gmTj2CBuS6UdkHU9aOm9PUQO7ByZ6+85z5VBm0SjkSih32py15VQIukIzu1mbpqnTFn
         3ocw==
X-Gm-Message-State: AOJu0YwN/Y+xyqiuJvLxUCwaYaoskMuZJdvr3xPzM65jGk+VECFKcCtQ
	QrAi+OLbtwsvDbdx08SZwSgomfaF7oEVhvoOrojaVSxB7IlY56ua9zFjYC9e3aMTPBSDOQtkxt7
	fQHSBsd+Rlk/h9jqafWMec95HdgvJMhrJrfAQ
X-Gm-Gg: ASbGncvS+2FHlFsZDvYhzT6XLgFFs59961+WB4R9Qvn+NdmOpMEz0YhYxxI7G+KPol5
	3PTlhN2K953huKCqQpax/DEM1jC8GQgXklZhgo9DQvUdo7ZzyXt70BlQQe2rUnhpbLPXPTwnAEP
	qyEgTZKJuWT56hGgOtUieYRpnqeiyaIau4ojgYIdmPrxkWFDuSvOwuht7WlhOFoS2y+9nfmVOV5
	3VHm14LBxbeqYD0FTo5k7ffKylnYrNcAesboNjEsIM+KNkMel1Re3SyEqdH6sxxDLpSFkSzu5Dl
	Cn5ZQlJ0FdGixylKdw==
X-Google-Smtp-Source: AGHT+IE7sh20YW9ioub5dloqeVdaCVFWcWe46yOofXOTeuHocIw/Asp3LlSPHMnl/vxRA9aOwPVPW4LL0kiSvUWu/xY=
X-Received: by 2002:a17:90b:4f88:b0:340:b06f:712e with SMTP id
 98e67ed59e1d1-34727c395b1mr4402308a91.19.1763654529616; Thu, 20 Nov 2025
 08:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com> <39b17bc64ff0d2e4162437ab745845c055315037.1763232863.git.gitgitgadget@gmail.com>
In-Reply-To: <39b17bc64ff0d2e4162437ab745845c055315037.1763232863.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 11:01:57 -0500
X-Gm-Features: AWmQ_blxF-vtuRruZUDppuGb10pze_dqw5Jgdi8X6HcimTSEHhP_8Aj8gJ3mLKY
Message-ID: <CALnO6CBzE-+51LfgjpEv665oG6kZG9_4YZTv8qgqtNrhh+a-Bw@mail.gmail.com>
Subject: Re: [PATCH 3/3] git-prompt: add quiet upstream indicator option
To: Kiril Ivanov via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kiril Ivanov <ivanovkirilg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 1:55=E2=80=AFPM Kiril Ivanov via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-pr=
ompt.sh
> index 6186c474ba..be23c522da 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -262,6 +264,8 @@ __git_ps1_show_upstream ()
>                 "") # no upstream
>                         p=3D"" ;;
>                 "0      0") # equal to upstream
> +                       [ "$quiet" ] &&
> +                       p=3D"" ||
>                         p=3D"=3D" ;;
>                 "0      "*) # ahead of upstream
>                         p=3D">" ;;
> @@ -275,6 +279,8 @@ __git_ps1_show_upstream ()
>                 "") # no upstream
>                         upstream=3D"" ;;
>                 "0      0") # equal to upstream
> +                       [ "$quiet" ] &&
> +                       upstream=3D"|u" ||
>                         upstream=3D"|u=3D" ;;
>                 "0      "*) # ahead of upstream
>                         upstream=3D"|u+${count#0  }" ;;

I generally advise avoiding "X && Y || Z" as a replacement for "if X;
then Y; else Z; fi" because if X succeeds and Y fails, Z runs in the
former but not the latter.

Here, Y is an infallible (?) assignment, so we should not have any
issues. OTOH, such subtleties may teach novice readers the wrong
lesson ("oh, handy shortcut!" vs "I see how this works in restricted
cases"). Using "if" is a bit more invasive wrt to the patch, but would
be clearer to me.

Our coding style also prefers "test" to "[".

--=20
D. Ben Knoble
