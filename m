Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BE3019D3
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656137; cv=none; b=rws5WrngnP12txtrZ8B+i0ECKez7bZz6IKwlJTSdXlj+vshiOauakBX5IcB3oiegQIgMy9IdEGmyH4ABKauT+bRY3SLCkN1b5opsnDNThjfBcNbTPTI1Ht7Ki6AhV1XqOvYfxwFiiwWAidUNUvJzsw8txN2apVQSmjMxKEDRgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656137; c=relaxed/simple;
	bh=X63ihEiysw6+75rWoM0QRDkJp43Uhy78aar5HxP95MI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ujt1+oi8r8DnJeGEmNKJ6MFetMl5qlSHwFBw8FRtX/UaKW9jF/X9awoaAMEO7DAVrsbaVvvkmZihfj7m2RVKcf993ZVb9mlY3edVxkQd9lR+xMX+NowWo1E6llUEFFWMDG/s+3a9YxrxptP9gxvpIWwmYaHz0B3N3R+4wxmbWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTX8qWZM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTX8qWZM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3164978f11so131782966b.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656134; x=1759260934; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X63ihEiysw6+75rWoM0QRDkJp43Uhy78aar5HxP95MI=;
        b=lTX8qWZMKV2pyl7YzRgmXPasEFVZNRFeUO5hf31idavq9G3ZiTdLi6czsWaqsE42fz
         ncx2mTt+xfFH9tw7C7XcOUYsD3g6SZ45qyVS76LngnWWdWH5UL7rAq6FD9us11iUGWMs
         iIc/KxLe5CKOm9r6q93Zc42F+dMNMk9ZLfPXT3MudoZe/YdBZyOeT6EWjPodT0y8Sgek
         x00R3BbWlz50mhEdfYLRfL2Rgc0GhU6tv8SYsCnhG5aH7nrbGOBOVo6vmWqgViuW3NzY
         A68oC0NSn6KDHTxHRmr1P/r2dHvj5W6/pVedf+8i09DejUE6C6uXs0LVJkUBnuXhh7dh
         Ed4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656134; x=1759260934;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X63ihEiysw6+75rWoM0QRDkJp43Uhy78aar5HxP95MI=;
        b=WZAOIiQuGW/JXck1x07tNPx7HLL5lqP++apPZXXaDI+IlfYx2WpwJKS93S5dPC846b
         r2LJ+A2kttPPbh3gYG8EahfDxvpPoNvrI6+Et8IOy1MIupCmtdTrTUFVH84yTP8X2SJu
         cU41yHNA7E5SF2y4MD5HSQeH8wvRce6MZDBW1sLwg+RG54lA60gipEOVgbVDNKkFCbOa
         BccC4FiuxAg9eTNA9wr9MGXkVkGMT1Hz1Noq7FDUhmrBJu0nT1X6D5Mxt6sPmP2Y0uOz
         VCqrBaty8O2biCOodOr+CQLweR8BMnWK/sIt8dqTse1vpS0OTZWBq7y1zkC8Gcmvz4yY
         WdGw==
X-Gm-Message-State: AOJu0YxLz3CAriP9r+0nsWQYzD3lkru+Orj0dZ6lUyK1CVApkCFLXcew
	Am5s6rCXJ3OPcM/DDYlJQcpkj7xSSkDXhwFXf/3rASYj+heqsCXwV/xgavKtwohHoQ6x0VCo8cM
	kdzi1fdGOZC6CawHniXMIr6q1NQiKvPUG3+5O
X-Gm-Gg: ASbGncu29J6f+6k5suVA7UC1zguriBX11Mybb9pgPg8BMQcpZKsVkjeA+A+MbQgxjyQ
	w1pfk6Uetr4b1/22Y89PIy/Cl/PfU5gXFRQuDhm0iF/W++t4/xzTFANGKi8eOM7AEy4cD1e/vPP
	1jmNkwHixl3+b+MJjEDXbhhDb+t6dNXpGOtavEKaW3tmicnq13RClUVUBfmHpBsuHwMmaYem3ni
	AJmRqVX0dtIQLN3Ttdv354OhE2zmfrzBbzAxTVT
X-Google-Smtp-Source: AGHT+IEHTAOssAaODYnIzexSuv1QqSakg35cyKbSka/2UmncEJByx7cou0y2OLa/hD/bIJBXcWaUzkslAbD6ScSLbms=
X-Received: by 2002:a17:907:94c5:b0:b28:c29d:7b2d with SMTP id
 a640c23a62f3a-b302a17b96dmr308273266b.39.1758656133937; Tue, 23 Sep 2025
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marcin Wisnicki <mwisnicki@gmail.com>
Date: Tue, 23 Sep 2025 15:35:22 -0400
X-Gm-Features: AS18NWBIPmj2sBvLkuwtkvDLeuo1DQptoeWtQTysZqagY5K8foqmX-tMx4gK-wE
Message-ID: <CAC9GOO8KCuLCZguZm_dg2MKS=cO=YUb9Uc+VLNTZSXMiO9wcig@mail.gmail.com>
Subject: [BUG] No context menu in gitk on macos
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

# What did you do before the bug happened? (Steps to reproduce your issue)

1. create repo with one commit
2. gitk
3. right click on commit

# What did you expect to happen? (Expected behavior)

See context menu like on Windows

# What happened instead? (Actual behavior)

Nothing

# What's different between what you expected and what actually happened?


# Anything else you want to add:

[System Info]
git version:
git version 2.51.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Jul 14 11:28:30
PDT 2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6030 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
