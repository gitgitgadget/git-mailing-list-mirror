Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644A4087C
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961437; cv=none; b=Q4NeKKsot7lCUiphcMpfl4CCEJJ4nmaKyWW85Ge0XQssH0RFZnylAUAX5RBnhAlDTx+bVBDBI7+QyPqQLZ9o7BCOUcqq0FGeZpoQTdbx5tRvCQeDOs8H2gkzQQ3inRjCg1CTfGjZ5YSvd1ZDF5SNTAzTetdmw+kb2RxkKpcRMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961437; c=relaxed/simple;
	bh=qib+NmGO2BbrC4VMyrpnxIU7uJHDpDnEvuOyLPI6oLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAVGBWN3nPlCZMeWtYnszuHyixkyhqpNF255vMaQ3JkFjS/c9OfGPvU+GREmhstDp2SYW3mAY2HhV1WkDHrm8DTnrBPcW6rp+uHeZLyCS0z0eZNi0xki3kjAiVg/khnYGUvTy5LWkqLYF3R5bY/e059nNfmn2QPhBwhPi9SG6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyec1pDi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyec1pDi"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so474669266b.0
        for <git@vger.kernel.org>; Sat, 30 Nov 2024 02:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732961434; x=1733566234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qib+NmGO2BbrC4VMyrpnxIU7uJHDpDnEvuOyLPI6oLE=;
        b=Cyec1pDiPkw4dQjpFn9QRkMG2TiThPVTPD3qu9w+MgL0wNsWQqo4pBv0htvgnvmfam
         1QqWFBJYl+qWXv32Cav5jv3e94Sx/aJy/ruSfmuO928CTs4Oqlnf12NKiqyZFy8m2YKC
         PnoqNBGjBNdMnGUjvDme3pzLkjTiWPPHFoqn9Nd0J1qJ5UdZhYHNG9Lpk+NaTqg/MTAD
         XOeNkqky8mjzEm/Vq2qctzIG8x0Ev/4hMrLLeBW8ZX3A1Wc0Bdntw8UwrmNKYHDOEa7M
         rIzG3DNDMFShENW3g21VcvXxkdB+KG71BT31YuADAbyybvc1XzyYRLXkOBmi2tcKCKsO
         Okiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961434; x=1733566234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qib+NmGO2BbrC4VMyrpnxIU7uJHDpDnEvuOyLPI6oLE=;
        b=qUssKb9B8gMMHCUDoH01gSInScrfoyCNGXp5m1a6dr9oH7evDLRry7lcZqL/C59FaB
         ugFNDbVhoiVCpJQaodfLNfntoY8NtX8wu6MOECHiGU9GSnSjpl2qp/6kV7MwzS+rVa4b
         lyP1xWiWmkx1/DBgz5qEEMAhcli+DEqXslJ2k5af8Ox9xgAz3YPe3DXLMh2FMBqkg3+f
         vgNPvJMZhxB6wtoVnK45UDex/Vk+EJrOk/qzpWODxQYNRCgWxSo2uBLina2+DiI3x5nX
         FUNcuAReQmzHyYc1pNf8RmHjRuhhJIt0lU+utycecidq+qBK8V+sThEhfehd1I6xKgvW
         P17A==
X-Gm-Message-State: AOJu0YzNGc0Bq6qycKCsfIkIgLlRi5kCkSpUkApH0Lxho6hIvX7bG9vt
	6KIJPAb0zMRArZotMLfzktR+1Vrv0TDnKO/+IW/y04kLLCUoG08PhMXkgbV8bhGApdC3i+RMJ7j
	l3lTOLxEzyFW9tcYiz4vzpDaJATg=
X-Gm-Gg: ASbGncu7odbXQPB6ujRXUNNmYikJybUfBxwIuoZMO7tme3u690IO5fShQX+9Jj2HpM+
	q5WyuilmByBRldOl8D2jCMrw1keKMmjCgZwoctZ9J5f9aqQLfSvEqIDWoT/e2nseV
X-Google-Smtp-Source: AGHT+IGg25X9udUxpMuAzHPpydc/4WNNOtf0RT/w57/TmrhUI6jSMg/T5YDB8WW54izMcUWWr20y/D06HJTXsjBpZnU=
X-Received: by 2002:a17:906:1baa:b0:aa5:c3d3:3249 with SMTP id
 a640c23a62f3a-aa5c3d333b6mr45771066b.54.1732961433745; Sat, 30 Nov 2024
 02:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPunWhBQcAifapqxyq7nY+S5WWhZQhBKgeYLL56U1ewRCa7QDA@mail.gmail.com>
 <1e423f15-49e7-4f18-b6a7-612f1bdd7d5a@app.fastmail.com>
In-Reply-To: <1e423f15-49e7-4f18-b6a7-612f1bdd7d5a@app.fastmail.com>
From: =?UTF-8?Q?Nicol=C3=A1s_Ojeda_B=C3=A4r?= <n.oje.bar@gmail.com>
Date: Sat, 30 Nov 2024 11:10:09 +0100
Message-ID: <CAPunWhDQZs=O-bGo7V07w==+4ptLpaEc7TWgFVNR1epq98BPRg@mail.gmail.com>
Subject: Re: [BUG] Changing remote URL of "deinited" submodule not taken into account
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 11:00=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> What=E2=80=99s your Git version? You can run `git bugreport` to let Git r=
ecord a file
> about your Git and system information. Then you can post it inline here.

Hello, thanks for your reply. Below are two versions where I am able
to reproduce the issue:

[System Info]
git version:
git version 2.46.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 7.68.0
zlib: 1.2.11
uname: Linux 5.15.167.4-microsoft-standard-WSL2 #1 SMP Tue Nov 5
00:21:55 UTC 2024 x86_64
compiler info: gnuc: 9.4
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

[System Info]
git version:
git version 2.47.0.windows.2
cpu: x86_64
built from commit: 1f8a83cba6e88fad4b881885e64cfb89458e3653
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.10.1
OpenSSL: OpenSSL 3.2.3 3 Sep 2024
zlib: 1.3.1
uname: Windows 10.0 26100
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash

Thanks!

Cheers,
Nicolas
