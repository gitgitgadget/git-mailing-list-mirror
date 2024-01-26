Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6323743
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300271; cv=none; b=uuKPZ8IguurDcIegmyB3Adz3Au0b/ezWX1aEDCUZ9m94p97PEsjxSULYM9lSTOKNAJfFUsrbVssb7CsOxKYSx/xMg1sYedgPuUg78oRuHsQ/26+LDiPm7QvdqQwnZofZa8qm5EbriKJKDWxhekta773k197yG5fmuGQk6z+G/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300271; c=relaxed/simple;
	bh=k4DcT56HXJY36qEd6+anFIgl3uRstdjJqJcZyByGpRQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rChQHJ2h3TGKCIDOIKewn3RlFKs0LRj+WXYoFEv6viai0KANHxAHvhuonE0XCuQJD6FtIHSYqXjEDvlPg7o61sxhHXRYby0ejgKy+HMc9Z4B+q2dDT0afAscawumpgEWW5XVSoeC/E8ApjRbDWK5Tei6a4KqCROtJYtveAZhcCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPgkf/52; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPgkf/52"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21481a3de56so407946fac.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706300269; x=1706905069; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+kOAQpvNhv+PPDYOY0hVuY9nEUn9f8HCBfzw3FxsUbw=;
        b=TPgkf/52XMUDlUREJWh6GR3D/5dCKdBxfOzlQGyzlAnov9zvf65KI68e72bVgr9e9G
         a0TQN4zvBPSiXJECCwroncO2bEX3ZIbqX9U4hI1KrMckhX/YF0X/CVkyjKwu16/LKJvl
         fnfaiWsdTAspFxw3qzoQ9Pr/Vfiu3kbPA4e+bjdQV1JjMw3dWa5fVHqhoXcVlZmDbtll
         IRPAaiNszWXYAkAiJIlH8Nc+70GZju1+TqC9uAdDrdMRnpPBDvqrqTWTA49WhOXt1f1I
         3M+ZLrQrSyzwHXGYoiAxtU/d5XwzTj7Nj1hb41QywuQg4+B+dYyHr+jRc/70HXDoUIVD
         gvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300269; x=1706905069;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kOAQpvNhv+PPDYOY0hVuY9nEUn9f8HCBfzw3FxsUbw=;
        b=upPMIFPMQTicTTxIsvTf0iaMoLSoah3k/pTJo2sOU7ojPDgFJ/GlmQfVgxIgRgeDlI
         /Sk/hLaPjf7Ejkzs4K8RpgcRV9KsowvLgRgcAwqlNrwvsZm3N9yNj37DFCkJPvPS6f9S
         9vCEgv2AxBD3Ss5fxwkrmH5O99ueMlsoo7qoZQEhRrF/mLUGjKrrCGs7kYic/rk4iXIF
         t26o3sTjFIV6mKuxO3LqOuJmGhMmgF0r8NcFW/F5nUx/VpD12bCFy3xVIQIkhEUyg8B0
         vEbQdX72x1/7oPqEWQjD0ucVN/8bybc80gYZhgs7aTCgg0OD9rTjAxDahSRSNdNZcqhF
         RrNw==
X-Gm-Message-State: AOJu0YzC1O0GHPrJ7konAbrsIVGsDSfwAq2vURBis3/gvzdO96xpunaD
	8ljmE9xYS0Oxw/bu7APoy+BSzvuMFUxxiVAG3sf0sXNsGVj/qG/1wzaVrHyqfum0jqSf7+ZcKRg
	phnaQVWoMKpvEPH6gcvaUfPV7L5k5SUhCpV4=
X-Google-Smtp-Source: AGHT+IGQdw657fE3Uz33VR2HOqBgmoIxSn7UbBXPj/W9iUus+2F6vqHJhiRT0AlOEL/HcX4STDCw7hYhoHQ8wbkKNww=
X-Received: by 2002:a05:6870:d287:b0:214:d4ce:2f26 with SMTP id
 d7-20020a056870d28700b00214d4ce2f26mr205815oae.49.1706300268893; Fri, 26 Jan
 2024 12:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stan Stanislaus <islaus@gmail.com>
Date: Fri, 26 Jan 2024 14:17:39 -0600
Message-ID: <CAOa6pvGV6Uu+N8tt73vaWgx7trgppFB6Hb_W-Wo8e39MMbJ6Og@mail.gmail.com>
Subject: git-for-windows: Rarely, checking out a branch will fast-forward that
 branch to the branch that was just switched from
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

- [x] I was not able to find an open or closed issue matching what I'm seei=
ng

Setup

Which version of Git for Windows are you using? Is it 32-bit or 64-bit?

$ git --version --build-options

git version 2.40.0.windows.1
C:\Users\StanStanislaus> git --version --build-options
git version 2.40.0.windows.1
cpu: x86_64
built from commit: 1d90ca2906dd4b7ddaf0669a13c173ec579d794a
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon

Which version of Windows are you running? Vista, 7, 8, 10? Is it
32-bit or 64-bit?
git version 2.40.0.windows.1 Since it's in the Program Files folder
and not the Program Files (x86) folder I'm going to say 64-bit.

$ cmd.exe /c ver

** Microsoft Windows [Version 10.0.22631.2861] **

What options did you set as part of the installation? Or did you choose the
defaults?

# One of the following:
> type "C:\Program Files\Git\etc\install-options.txt"
> type "C:\Program Files (x86)\Git\etc\install-options.txt"
> type "%USERPROFILE%\AppData\Local\Programs\Git\etc\install-options.txt"
> type "$env:USERPROFILE\AppData\Local\Programs\Git\etc\install-options.txt=
"
$ cat /etc/install-options.txt

** Editor Option: VIM
Custom Editor Path:
Default Branch Option:
Path Option: Cmd
SSH Option: OpenSSH
Tortoise Option: false
CURL Option: OpenSSL
CRLF Option: CRLFAlways
Bash Terminal Option: MinTTY
Git Pull Behavior Option: Merge
Use Credential Manager: Enabled
Performance Tweaks FSCache: Enabled
Enable Symlinks: Disabled
Enable Pseudo Console Support: Disabled
Enable FSMonitor: Disabled
 **

Any other interesting things about your environment that might be related
to the issue you're seeing?

** Using poshgit for PS **

Details

Which terminal/shell are you running Git from? e.g Bash/CMD/PowerShell/othe=
r

** PS **

What commands did you run to trigger this issue? If you can provide a
Minimal, Complete, and Verifiable example
this will help us understand the issue.

# m =3D> git stash; git checkout main; git pull
function Invoke-Git-Stash-Pull-Main {
    $ErrorActionPreference =3D "Stop"
    & git stash
    & git checkout main
    & git pull
    Write-Host Ran $MyInvocation.MyCommand from `$profile
}
New-Alias -Name m -Value Invoke-Git-Stash-Pull-Main

I'm on: git version 2.40.0.windows.1**

What did you expect to occur after running these commands?

** I expected the main branch to be checked out in the same state I left it=
.**

What actually happened instead?

Very intermittently and not consistently reproducibly, main is checked
out but fast-forwarded to the state of the branch I just left by
checking main out. This issue seems to be the main issue here, too:
mhutchie/vscode-git-graph#284

I also posted this on the github.com/git-for-windows repo:
https://github.com/git-for-windows/git/issues/4778

=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90
  Stan (David) G. Stanislaus
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90
