Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9A6A325
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295186; cv=none; b=pTpGev/XAxZgWh8Km1OXlLhviGP+/6HV/YxQkD+Mf1Ds3za6Fo1evqEZzBAzka4j+5tD0GSJV+0RKhNtllDfIztAnpa1fWi8UJVncd6lj9psOsTYBs4cIZp7b2Vmlu0CaDpvKuUmGAf7fjjT5vifF1hOKi4rKUbpTFzGlVryg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295186; c=relaxed/simple;
	bh=kitgErR8gee5scHOnlCZuYODDR84NYc9yj3QSx3ZA7w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cdhTC400Zoy5FubWkOKUD5fSpMH5wcBJTAIV0x2v7k/JazmTGoQ86emeZ1gcqsvH63Vr+azyWnKyb5n+K/tSMzUnMe2WiirEhZ7Aa4j9ZowX7aqKC0vNQrcc1c9JtSthe9C848QRPQXy6o8CPq6WEizd4kxUhtVYq2YSPjeIDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYFz6sGv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYFz6sGv"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-63186c222eeso48632157b3.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719295184; x=1719899984; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ML6DYW4pUL9a0xhpAiT0wPg8PFGUpVe8+zaKFCEGlCE=;
        b=nYFz6sGvirQSYhilFjKny/fQUAZYcad64IeZYcN9aASh2cqileZtTKwL2IJqljOf8O
         KRlc3uRsemlcwq5ns337ijw6aeTPuErmqwepmmJY/3ZzLEdEkx29yKHaxJ24vW6tkOuF
         PfNtH5bNrLcd1zzJozEhRHoTitAAq+ckG3pPIGQhasJV9OZqJOt2DORGXpOa4B1tQdtd
         tb6cp6h+cJOjZ3omeBdrzetrDUMHHl1RlKJGEVH6tJv7bisDKOf4JL/MRJ30TR59uIbI
         ifZrZZe5zfxCYLhkT2sxjmdKytVDPD0ZvfRqbnnpiwXfx3j54fsfzk36O4pi42JM0Ewg
         QBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719295184; x=1719899984;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ML6DYW4pUL9a0xhpAiT0wPg8PFGUpVe8+zaKFCEGlCE=;
        b=F+2/W2Z5iFg09J6W6xVVbZxQUdOHYjl1nM0R3HMVnl7V43rbNKaoITW+4//fz2QHVk
         96JHglvIkENdym7mx28iJuk3cH0NI4j8V+LwfFRL79UHD2rmVBKXZ2XNefraOmbq2pqu
         MIcAI7LYgi4WzL6yRO5MNjyqXSeWse4P7Jvk39pyD1hDTSMR/2JdLd4JEVmAFhQrqdU+
         RHkhFc0KnmaAixKC3Ip6AsBxB1jQwRrTI4jqofnosM1z3oPTMgGUBBPvkyN9qlW3rSXN
         2bz/EQdghVOx27PNp4/xMXKuEmIsmWuCzWp5G2FCTlgEYxfrFpiUEPCDP+EUEro8t8FV
         j8lg==
X-Gm-Message-State: AOJu0YygbndSt3iXGxQAi/qmN1J4RMKcQNZDRKzhFTWv699zrqdCJph1
	xHwKjJZ0TmsMKEMVR5kfMwVTa1Dtvx+R6H4BMs3MjYH8D+51g3yUup/0qyluUp6R/RvSjJ9J9Jp
	8l3Yt4z+ux152VPaQfsuEJ4vJdfPlBcj8
X-Google-Smtp-Source: AGHT+IG9p+1BXR2xUFQ0E4546Q6Y8kRkR59IBl1j5BKdE46iqDXEUD4nkIG4VaR0X+rOsDBT3LM9vQZuMuUF+OR6GPU=
X-Received: by 2002:a81:69c4:0:b0:63b:ca6d:7b8b with SMTP id
 00721157ae682-643ac81d0abmr57663277b3.37.1719295183845; Mon, 24 Jun 2024
 22:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ryan Vu <ryanvu87@gmail.com>
Date: Mon, 24 Jun 2024 22:59:33 -0700
Message-ID: <CAF4erGWF+Lx=K09yFhd_abC2M5b5Ab0vM2uehkdVmridmsHqDg@mail.gmail.com>
Subject: gitconfig - interaction between credential.helper and includeIf
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

I created the following files:

``` ~/workspace/.gitconfig-workspace
[credential]
    helper = store --file ~/workspace/.git-credentials-workspace
```

``` ~/.gitconfig
[credential]
    helper = store
[includeIf "gitdir:~/workspace/"]
    path = ~/workspace/.gitconfig-workspace
```

I then tried to use my credentials in a repository under `~/workspace`.

What did you expect to happen? (Expected behavior)

I expected that within `~/workspace`, the credential file would be
`~/workspace/.git-credentials-workspace`.

I expected that outside `~/workspace`, the credential file would be
`~/.git-credentials`.

The two `.git-credentials*` files have different credentials to the same URL.

What happened instead? (Actual behavior)

The credentials within file `~/workspace/.git-credentials-workspace`
are not being properly applied for repositories within `~/workspace`.

What's different between what you expected and what actually happened?

I expected that `~/.git-credentials` and
`~/workspace/.git-credentials-workspace` would be isolated from each
other. But there are interactions even though `includeIf` was used.

Anything else you want to add:

The following configuration works:

``` ~/.gitconfig
[credential]
    helper = store
[includeIf "gitdir:~/workspace/"]
    path = ~/workspace/.gitconfig-workspace
[includeIf "gitdir:~/another-workspace/"]
    path = ~/another-workspace/.gitconfig-another-workspace
```

``` ~/another-workspace/.gitconfig-another-workspace
[credential]
    helper = store --file ~/another-workspace/.git-credentials-another-workspace
```

This is not ideal as repositories must be contained within these
enumerated paths.


This configuration has unexpected behavior:

``` ~/.gitconfig
[includeIf "gitdir:~/workspace/"]
    path = ~/workspace/.gitconfig-workspace
[credential]
    helper = store
```

The credential in `~/workspace/.git-credentials-workspace` will be
accessed and then stored into `~/.git-credentials`. Git is interacting
with both files.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.45.2
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:12:58
PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T6000 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
