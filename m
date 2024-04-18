Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438715E20F
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460933; cv=none; b=c0jhSauQ+ifOC9LS4xWOjqc8LBFOUE5orqpOi/YB0EGDN14ruvYDEi0M6LYiJXf9JK1wONepk22aQPc6lcXIa8pVnn9NTPIXUVFWT/ARV5JTv8rkcofxJKF+erRan4S14k26zvswE8Tut1sAvbq0nxac4wDp8BicOuR7PVsMYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460933; c=relaxed/simple;
	bh=LIYdoe0cGkFQznn5+IICwrf4on3Bv3hbN3lL2zS+KeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVU4Orx/E3ZcNK6eok5zFzRxb2RSs+s/CiaTRWKPYHuyX1g1f7Gpx7CYZ7/gK2pCsZXIwZjW0ASCzDZYODz81SGyml5q4Tu8heATQJs9WQ4t4JlVXfdxl1EYH5zeLbtWbfjfwV9APYs39HYQd04EduVnqnRtc0PWMAtEU0xhHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de480576c3cso101805276.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 10:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460930; x=1714065730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNna9Ez/kincrcSRBxMEvd4desWCfJVUvrs4B576gHs=;
        b=v1kQavuzHNRGvLQDFPTS6DuRsfGSeB3XSDBfRJ1wuwEMZzrUES4vCpYi5QwUCjcXs7
         wMDmZCCn5HvHF9N6uIf5pnzhyyz+vkRDSW0wAg9J9sKpTY4Pyu/xSmEFMsaqGUft3oTC
         qAfZBZ5FQkCH+KjmAd9tQOnTKJiXjRrBric/StGuZQFyPK4IezrN1cb8pMEvFTwvzYMh
         dac6cH/XJSLze3pU8k9w94LN+NOg/AMeXehT00qTwKzT/AIcbh7PmsZi4z+HPeb0XeR9
         xKq2Mv6mOmIQqJV6dYNr0Kr58zV1dzBTmwI3nF3C0J+o19RubuBo9hH9Oexr+OQAK34b
         pIjw==
X-Gm-Message-State: AOJu0YxuvsQAIzuqUyU9WyQEPinFvEIu7XiRGRHXaN6GiFgtj04q0ec1
	4hWuQJux9gzMDQE4YinCIKjaXzm6o2MZnfHAgokV+4WTQ+RJKVLcf642kXpZ/LBQRm5PiXQaiOB
	W5Xq1MFrxnO/rByP1iAYY6r4p2AM4pORj
X-Google-Smtp-Source: AGHT+IEPPI/mCISQqHTd4VsxfuNqbR7MLvhkHAKaxYIyiR5E3rXfT+cWdjiLzalKlzCvGpuA2X7dnOfY4JZZ7TNKE4s=
X-Received: by 2002:a25:941:0:b0:dc6:54c5:285c with SMTP id
 u1-20020a250941000000b00dc654c5285cmr3837342ybm.0.1713460930504; Thu, 18 Apr
 2024 10:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3188f4e2-9744-40b1-8f05-0896b8679d25@web.de>
In-Reply-To: <3188f4e2-9744-40b1-8f05-0896b8679d25@web.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 18 Apr 2024 13:21:59 -0400
Message-ID: <CAPig+cQr3xcnuoyf58YWbXCekhhRgN+M9=WsN4_PYcK7BydDUg@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: fix NO_OPENSSL on current macOS
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:47=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
> b195aa00c1 (git-compat-util: suppress unavoidable Apple-specific
> deprecation warnings, 2014-12-16) started to define
> __AVAILABILITY_MACROS_USES_AVAILABILITY in git-compat-util.h.  On
> current versions it is already defined (e.g. on macOS 14.4.1).  Undefine
> it before redefining it to avoid a compilation error.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> On my system I can remove the whole ifdef __APPLE__ section, as the OS
> doesn't include the deprecated OpenSSL anymore.  I get a current version
> via Homebrew, which doesn't throw any deprecation warnings, of course.
>
> Not sure if this is the right fix, as the no longer needed section still
> undefines __AVAILABILITY_MACROS_USES_AVAILABILITY at the end, which we
> may want to keep instead.  But compilation succeeds and tests pass, so
> perhaps it's fine.

I think I added the final `#undef
__AVAILABILITY_MACROS_USES_AVAILABILITY` in b195aa00c1
(git-compat-util: suppress unavoidable Apple-specific deprecation
warnings, 2014-12-16) just for completeness; since I #define'd it, I
also #undef'd it to ensure a clean state or the C preprocessor.

However, taking this new situation into account, where
__AVAILABILITY_MACROS_USES_AVAILABILITY is now defined by default, it
_probably_ would be more correct to drop that final #undef.

Having said that, though, it doesn't seem that it is likely to matter
one way or the other as the project stands presently, especially since
you report that building and testing succeeds. Moreover, the only
other place in the project where we seem to care about the Apple
version-compatibility macros is in
compat/fsmonitor/fsm-listen-darwin.c, but even that isn't a problem
because it consults a version-compatibility macro before #include'ing
git-compat-util:

    #ifndef AVAILABLE_MAC_OS_X_VERSION_10_13_AND_LATER
    #define kFSEventStreamEventFlagItemCloned 0x00400000
    #endif
    #include "git-compat-util.h"

So, this patch can't possibly have any sort of negative interaction
with that code even if __AVAILABILITY_MACROS_USES_AVAILABILITY somehow
impacted AVAILABLE_MAC_OS_X_VERSION_10_13_AND_LATER.
