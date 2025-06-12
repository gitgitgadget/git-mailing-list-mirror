Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6421246BAC
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736338; cv=none; b=HEe7plpmfgb6v/w0m2BiX0krhHXfPVr+3GqM2ZJEkoMZH8HujkySQffIZxHzmFXJYeyE/PJ5fSejhhZLuVBrn7v16xgIHQKrbhe00ByVbjcuAnVMUvjSyRw9MoZ5NBjnXtFzJpR51gUFYigRcQwV4z0YvvurmZnZskqI/BO+bls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736338; c=relaxed/simple;
	bh=3taIazY7+pKovu2rNVFyXim8g2avBAY6GIk/uh4+3dk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RqNQkhTT+RpVDf0i28ZKFUo6/9541OvJWtwdZB53PNW9vv8QzObcspU8ipYg0iZ/f74OmbRZuXZ0UtdB5WMWvAgcG4vqNgM0x59PiduJf36/zlLrV5OR7HQNPpmy5xMdwKxp8i1pWTBrhzMsrYgIhVzWyuz+fwUmLpeZD69tRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZwgnfvX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZwgnfvX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a528243636so655682f8f.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749736335; x=1750341135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3taIazY7+pKovu2rNVFyXim8g2avBAY6GIk/uh4+3dk=;
        b=SZwgnfvXINDOHEohh1RVCsNIZJ7+z+B2TjOyGSES8wdB9/VAdcaKP2SQxkUaVazEdV
         mU4aEvOsOFLvn38xiF6UbZxF/SdvTidrkdhvZZXr8/CxMkMhbTCLNKMN6IdQLXbJhK/+
         0XBKND2qSBJ8w4LWfc8WcDfu3AjPDxq+dsJ7njvuouSy6l0+YktC3DUIpxFZojY4rvHd
         /yPwTd3BN002aOm9fzlh/5AlFMreH7IlvYA7a9Bubj3CRxkRoTevzuCc7Sbr+ymGV3tb
         hEv6Mh0u+x6ulPrMDurFcLhWyBTaJNuYh4SzKSLKUrThtNQT7I0soSQhHwaBatgsu0q8
         EoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736335; x=1750341135;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3taIazY7+pKovu2rNVFyXim8g2avBAY6GIk/uh4+3dk=;
        b=h8JyUNnr+AddME0NYNyfrxV4MWpGMvPTZWVe4VOUzAM1EzioIIv+PVpW6pPEHeBfb2
         vN0845zrhBJcD+Hjy3fYek55y/qxcrQvpB7tP5NTHR4h6f+Oh/CbdaLS3fmPYBlTOpmu
         1CIwFSaHMfNCRgp5TRRQmMecy1+VhJ+qAOAtgrM/Lf9JjAQtR6MJ6H27SWtvO5INoyCq
         Cou9HJvbQvr3mYRwGv/ihxNVE70fVlBPjBx44X3vec1US1cOYNB0lSiLZlARMPqLgmO6
         sV7YyHHeLI77EKdXZvs7LE1r5PpY4B7XRIr6feOD22kwhBJgf79xLAP73vBQqDpgDX+o
         rrVw==
X-Gm-Message-State: AOJu0YyxXWGGt9o7zGQ9RgoirF1Xp9cbPPf7RlR3cHYdLLudueX/ozPO
	RlDngVXw1h7ZL5hnTSk0CvqIISFGxyRK/tf8iw0hE268ty+mQn4fcaJcWt838R7qGb3Pb/a7iRj
	qdCs+PgykkfIFWenTvBSRKD+w/bzZ1ylRGQ==
X-Gm-Gg: ASbGncsqTXgTJrZyM0UH87Cr9oji3uKcFaFUBGj4RZDRx56FL6GWBqFAMYb4PasiOZi
	qS0ZjCZ6GAvU2HN4ISbR16m/pDh+RlwKvf0NCvF9bH2FItjEQu5t9Pqzk719EDfNqlZ4QrqDaV4
	WEMNEmr/d4tLNZZWs1G2ohYYtlzvr7JQLHaGAqf9IB50Wrg051AXJeESL5rlxOk9wNzOv04NP0C
	ac=
X-Google-Smtp-Source: AGHT+IH+htoZsIO7Izvqb1vkjiWXMvkA58DBfNd0uvQoFQWGg6wlEx5MkNjPR+ctetvuB68ZtNtnOa8UYXSm1dnFpcY=
X-Received: by 2002:a05:6000:401f:b0:3a5:2208:41d9 with SMTP id
 ffacd0b85a97d-3a56076aa33mr2922460f8f.40.1749736335051; Thu, 12 Jun 2025
 06:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Carlo Arenas <carenas@gmail.com>
Date: Thu, 12 Jun 2025 06:52:03 -0700
X-Gm-Features: AX0GCFvCSEAiPBNfEWaY3PfvvExbUwRS1V4Ovc_hd9NefyJp6VnbBhkHjkbMMDY
Message-ID: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
Subject: Re: [PATCH v2] config.mak.uname: update settings for FreeBSD
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 12, 2025 at 12:36:46AM -0800, Brad Smith wrote:
>
> FreeBSD 6.0 has memmem().

but AFAIK it was buggy, uncompatible with the "standard" and
didn't perform that well, at least until FreeBSD 12.

assuming that the system version is indeed faster than the
one provided with git (which should be true but worth testing)
then it might be better to only enable this for later versions?

> With making 6.0 the minimum version drop bits for supporting
> FreeBSD 4.x.

FreeBSD 4.x is no longer supported and wouldn't even build a
current git, since it predates C99 and is missing POSIX
compatibility with what we require (ex: no statvfs)

Carlo
