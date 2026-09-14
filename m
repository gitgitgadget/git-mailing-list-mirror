Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA2386C3D
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369109; cv=pass; b=KQIiBTZTRFUKLPtfqUbmVtllbzkGRbLp0njS1t23Z+gznDnY10gOKwtLj2s2sVVqEKmfFiCT6abHjzO0fIqC8vs46eYkJKV0iPmt6ZfYzscuO5r/d04ajFeoo1NCXgDuPKXqDhAQaccBMqRgC828Gxv12an1IcmUrePijpuYW04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369109; c=relaxed/simple;
	bh=2gxR4s6mdfgHzj44fvxuzARnpmfvo4ht+B/LiUub6ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAh3KlMD71Y1AZDRq6QcvNa2s6v/jUCAEpDMv14NJOhzRGAdXz+oGjQ2SokzKV6TB3m+RLh6yCH475wmSNrtAUcZJhlImm9KmvTM4pmxa20op9VyUpQcq9v7Tvzd6FTJB1mXRDnB2K1R4mV7LCehLIYtUiHHHQGW4cQxD8trTLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewo6pTfV; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewo6pTfV"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so3123269a12.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 23:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789369106; cv=none;
        d=google.com; s=arc-20260327;
        b=MZSQdNOLafIH6N9Kq4Fx3o00ZQ076PTnI75mMpYRDe9aHpevFFX6KfsJ5jtOjqICqt
         ExApJPbU0vZVmOpd9QDaoUm+YZ1F9gNz6R7ATQ/epfwDKeP/UiHCOfXLrBmxXgAek0l7
         CpJy0j7am/5DV3k33LZJP+s0885281l789ki+NAuxMsODKWJL4b3wMAnFo4NCNLU6yEa
         Jb0Nz1tAcj3mILqIhXGg/OFDMIcK2UfWUB7bjmlD1/ad5cu0yq9klGCymoJSmENeuV8M
         Z4r8XdJO23aK+afveE76kNZ/g3JaQmOHMMPF2+ti5h32mJ1bHZakMaNCs6fUCgmFHgx5
         6WXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2gxR4s6mdfgHzj44fvxuzARnpmfvo4ht+B/LiUub6ec=;
        fh=crLpfNo+W7oFQTkA0Cd5Xt62ztYsOXo1PAwlspQRoes=;
        b=afJsXKEyX00pC/wy1/PMvcz0q+nhG06hxxb+DwXz21grYyLFpcgsxb6eMJTEgkKa5h
         Wr1zvhy6y0Q2Hb8HbvlS9VyUVfapKqoKtBxnLFB9eUDx06uAks6R+o6jgpdYGw36DYPH
         90K++aTPcdkXYeqrPCmDOuDEjM4VjbrEly0Uf2Jw1IOebwvZovHm8FZGpe4niThe9N2Z
         K6STLv4MEgAlFRMhAiwGq0nbvMALFOlBSPWUkHliXUQJSeQ2ZGwKayLJ6Ll1AyvAZndL
         xk1MxmUR4eGTO6r27pNHUOCTXaOn4/FigTDlMFiayjsNnwDbJCvh5shKxnsN6S0uFdgC
         ZaaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789369106; x=1789973906; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gxR4s6mdfgHzj44fvxuzARnpmfvo4ht+B/LiUub6ec=;
        b=ewo6pTfVlNglDR8MNnxEf/KOWJFAw+DZfOdesGrUhlQnLIFAy6+eUsrtvFwsfD7xds
         2PSrRxx0nYGGj10oTSXZFjnNtWXs+DrfAkX3gxA/lE9Uh3Ei6/SLgo+MneXYop/oGAfp
         ClEMbwmjhhAShw0QLHDHcBrs7jsTqVat5Y5XuBRQNjtHv8nB3QzUIM05NVVdhSqUDyrQ
         W5ewF7kReviYkDyeNeetEoq9vFCgIM8GuIXOD7N8qI2S5/0TllaCgQDXvOq6R9Hy7nta
         SyloYJJLTGwljC0l7bGO3TxYK3Msi2KP6KAUMbODy/Vbm+s5JX+Q4Tap+5uL77jA5v1L
         UqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789369106; x=1789973906;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2gxR4s6mdfgHzj44fvxuzARnpmfvo4ht+B/LiUub6ec=;
        b=RMc7MEBKXGe72nfM7iNv9eioW96gNkcGEOH9sEqCxsSkNLZtmDP5gudyI6hcFxwPF7
         n2nzGd3/eML+kOCHoMpRP8CCHHmgU28socNTWvVNpzq7wJcSPPFIYGTO0+deWrY0KcEz
         Fb1jdIkdIYIjGU3f58nbc/WNFOMdnp1T7pWUqtiYdN8C8ADUEuzxvIw8HH+2XNLS8Kzf
         VAxgsfRiBGBMvsmUTrQK7Aa5KphzQ+N+gL1Q2R3bEg0FuGZMYqAYGEnEwh3N8Mspv2DC
         ZqIIQtmQCwu4LTXEjcSj18wjGnGUPDAMBjj24b0rKcZizTaS2cDfGHrRnSjJ/cxqcZy4
         OtoQ==
X-Forwarded-Encrypted: i=1; AKwUvBygrRY9VmZmmu9T0ldZ3XjSaJioz6N0MzL6WKO565V+rkhumyj/Uo+27YGPyO1L2wN6IdY=@vger.kernel.org
X-Gm-Message-State: AFuF++mz4M0zCulKXGguEJcFarasqD4bpP/nc/8zv637Ae1AkSXjulfe
	cCV34OiHvSdLuMUyvytofW10hBf7iu/6tT+w8r1pWGw9orXREtlKPqsbkE3ylM/VBOFzB0NOfex
	lL3H+mK5cNkdlrbLYKtXJ5yJM61+wMJc=
X-Gm-Gg: AYBFou2AHt59+oSjML1181BHcjBP3xT+ThEyWKh49FecBdGi57aeduqO6M1p3UV5SF1
	3/6HLxQO/L9TTae+VvlkJAFhkQqbvR+FI7459CaQb2v39QWqY5D1jtj1zGAx4DIChhwSnez+IHk
	FTPwkwHRWGc0+W0KHlD+agmf1ge9Zo/j7NwHmdszI96TCGDwVCOYRoJYJdTIR7NC2pOJtvW+C+t
	23wipyk4ZBfx5+g4zcNcn/i0RaTaUMntGHE2hqBgeKgR5tSfdxP+B5XLSOCeeoPrb2zwW0zqgdQ
	qrpmhTJppYAwVtfKSNl45CuK1oz582GTOV2q/916uaEgMlc1W7sL+IGv
X-Received: by 2002:a05:6402:414e:b0:6a9:941e:ec76 with SMTP id
 4fb4d7f45d1cf-6a9f6219af1mr703620a12.2.1789369105513; Sun, 13 Sep 2026
 23:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com> <aqeTas30Vs3aGE9D@pks.im>
In-Reply-To: <aqeTas30Vs3aGE9D@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 14 Sep 2026 08:57:49 +0200
X-Gm-Features: AcwNN1WILFNQJA_Vi2IBwEvV87j8fVJQJNLsY4htzW6NIuNwimtqYKEDy6OC7MA
Message-ID: <CAHwyqnUG_ta=m5e7rk-35D0Dve+GeQX3eNuFf_U4kSd5+Sqy+g@mail.gmail.com>
Subject: Re: [PATCH] ci: drop no-op gettext link on macOS
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> So I'm still left wondering whether it really isn't required anymore,
> and if so why it stopped being required. Links to passing GitHub and
> GitLab pipelines with that change would've in this case also helped to
> demonstrate that it works without that line.

It passed on GitHub: https://github.com/git/git/pull/2402

I'll take a look at the rest of your comments as well, thanks for the help!



Harald
