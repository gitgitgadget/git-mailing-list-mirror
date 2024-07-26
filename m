Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB303F9F9
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022863; cv=none; b=osghb75ds2ryIfkN+ZLCOYrjX53tfdZDNP+UMEFAMjDi+acZjmFtAIAoXy4G27riwYs1gqZ0RJusegdoMLouG7RRUYJUFxhtqzxx19nIBsjy3adRquKH2dZs6tOB12CqinSUipHWOie5PTm8Q4yY1PxAiagBjUnq+nRsNwg2RBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022863; c=relaxed/simple;
	bh=gAy87yFiY1+YchaGb8OAeTLwlwVL4m6htAxgJBUNgYk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pMHBnPSu7kuQeL0zpKzoBNBZMJiydmBCyOszSvKSmZ/eK7fEDBbB/F+euQ9f6RyYT1w4k6LYvk+6ted7jJ9WhTWtbB4gVrs/QFAu8iO/eG84grsyta3Yq3ubaI8BMfwZRbYJJEiUACnPx9EEjN8c/x6P0Gy+3ahwcKTHD2hdmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVIt41jA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVIt41jA"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f01993090so2427264e87.2
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722022859; x=1722627659; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MR0Dx4nR30UdmbzzH9ZeTVCwfeG0quTa39FqF7vOHS0=;
        b=NVIt41jAm3xoHZp38bJcluu0LtRcIXIQmGWDDQvs8VKWkSsr1fj3F+uNCU/lvc53mq
         Fhk10d1EpD0Ly+uQYyJH++BWfEnkLzAJyjVgbUBkG5AJ/TEJyVy5v9q6UXyjjOR16K4O
         5RdNYJ+KkGJA6GktiJQw1Sg2GbJWbikGdgVsvFD+eqLfo0aI7TrovypOpEkZ1y5kybh6
         SnEpGW8oqmCPyQmAliUUf7owtYQrZpRoXbKDrbccT0YFwbpt1oQAaAUSCQm4hrBPTULW
         8EBfjFHJtemjCWeAa+jYZVNgE9sSHEYXmNQIhPT9FcumDhSsRCAoYr4HLtbaUFPrrgFl
         PHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022859; x=1722627659;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MR0Dx4nR30UdmbzzH9ZeTVCwfeG0quTa39FqF7vOHS0=;
        b=nlGdL/O5Qcgjpj5w75SKiX0QKebr80dxLvRSE3Dvd6RNnBhnmLebKdzb2ZvCtoRxVe
         gLp/xfy2t5dcBxNdesm+4bEAhGReZZNeN1UXbkTwXLOWmEppSMIUGy77S2jwz5r/CGWW
         Y7X2AlvSbkZ48EUw+CsK/UeRRbJu+ZQIHLn7qxiIWLy/TR5l9pohvoKyhPIMjWlIVxBW
         +hZuh21EoAKk1Ai84NwNEV3srAEJQEZjluZxunAgYoJ+es7B7gghr6Rd1PVqobGOcbe9
         y7iMBBDYBoJh3vfBE3pjNBMTgQ9xcPxfTGBFHw7GcYcWHizea5tZQHxFtLkFxV5klAwJ
         KgEg==
X-Gm-Message-State: AOJu0Yz7pmKbN0OXcD8hRKHM6Zl3X83ZX25A996ug52S+YjMlXTlj1FO
	ehuIRQcxcuCZkz6JM1p7AEYtmX/tQrz/O8jEqNOVUAzkaujDm8ddCmKjEFm5lkfPMa6lBlox4eo
	joCihx+tCvwSA9r66iOiI4+VeWkiImusFjYk=
X-Google-Smtp-Source: AGHT+IF4GFaaBLNYuttyTTPv14qXyAVqewj/iXtwuyYyqGE0svnDrGcOY5sL+zvVPGYFFTexuFDFR7fu2f1PWjpLvs4=
X-Received: by 2002:a05:6512:3d14:b0:52d:8356:f6b9 with SMTP id
 2adb3069b0e04-5309b2bb569mr558083e87.38.1722022859378; Fri, 26 Jul 2024
 12:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Abdiukov <tabdiukov@gmail.com>
Date: Sat, 27 Jul 2024 05:40:48 +1000
Message-ID: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
Subject: Bug with bash and OpenSSL usage on Windows
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

  What did you do before the bug happened? (Steps to reproduce your issue)
Tried to generate a self-signed certificate using git bash.

Using git bash, I ran
```
openssl genrsa -aes256 (private key location) 4096
```
however, openssl just hung (on Windows). Cmd can execute this command,
but bash cannot.

What did you expect to happen? (Expected behavior)

openssl to generate messages about key generation to stdout

What happened instead? (Actual behavior)

openssl just hung

What's different between what you expected and what actually happened?

openssl just hung, rendering it unusable within bash Windows

Anything else you want to add:

This is an issue specifically with Windows x64.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.2.windows.1
cpu: x86_64
built from commit: 91d03cb2e4fbf6ad961ace739b8a646868cb154d
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
