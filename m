Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CD625
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708738401; cv=none; b=u7YhQVManl/tf2YjcMPyWS/cxFRorwDBWeO+E/5kKCVcPmuDjllao4nlmLrt5JPRNS46207I4mp+eb0cF46yOSId41Qi7IgU4qoZLH8L3kGe4XmfKJJ6HIPGstnfsug3V1gLdfRwS2+cVd+SWZUCcFN2ry/HCJdiqaidawcaW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708738401; c=relaxed/simple;
	bh=G6vBVxWgAXpTFBKfE6luye0lK5pKuzV9ei3er8NE+74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvzDdR44lRFbKWTQ7e33KZHmqobEz2ARC/ic+HJQI7jxOcyOQMlI+h1fyJhkwmBSY/0rNc8ZbRUjA0OmBrBBhUu5UC2x7EeLP5GS5+d4JT/0UXyVKnbfvUmthShevLcMatVAVBOrc8bzf47BpBsIZgtGZV6HDMwPbLqMbCjcIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEAtvvQo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEAtvvQo"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so2000985e87.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 17:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708738397; x=1709343197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/14pAFdobclGUGXfmRCJoNLxvWSnGqDcraRF4nJjZY=;
        b=aEAtvvQotGJt2bdx2x5lF04VP9aOtXKnYWvRkFI7Ji2QA+6V02n7QQWCzdgUCYa2+T
         D+6SRFUFx93YrOUTQC5C/KhN9d+U7wdmWyJrLWUIRn9d9Hr2FU0E3cK1VUHpzB+4myWf
         uAfVsS77RCqa/oNy8KPjnd7l8Neij9lHA+C4BMQ9ekD+rQ3xjkGv4LxS6EonEfdjhbIm
         QY171txf23lzLIG7GQ4bkuknIcKPg4evPoHcSPMygXnToGAj32lfrSkHYqxVg6G8dRmF
         Nk9QUijP3VAC3IrVh2rGA9CRClaBwtME98qY3rAr+B78k+3Og/2JHsQOqgVoDoAHKkOK
         dzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708738397; x=1709343197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/14pAFdobclGUGXfmRCJoNLxvWSnGqDcraRF4nJjZY=;
        b=XDlgxgTNTeRkSvKjNLnW+o/Cc36lijQe9UJWRKWGtR+9C8SuCCTDRFTkAbJOzz/Px3
         wwSUyYbnxmA5/NcrHJ7NYGd3nvIy012vZgLh8D4b4nf76qNMGqKMJNNQrfIL1fCvCcHt
         L491IJed6cRL31Or98RLTUEJ6LtzYPKp1W6EXEx4k/rY8NBsV/EBsOb7/b2u5QiEOxTZ
         5bCannwlEscdw/eLoz4QQrKc2e6QmrIx3vY5Vqyx2TpKilpRqFGIqMfGflvehyhqeI7Q
         2XmS00ICLWTZO5kD2fkkxnbFvo5tPcI4zdL2DphYVrPCFLpN6w+CWmGthVfl4kunD7TQ
         6CPw==
X-Gm-Message-State: AOJu0Yw8w6GMWNpjZQ62fKqTKZJaKLuWp9VQm2jN7YNwH2/JnjjWIBqt
	GwrMpsgvUOQoW6PhO5byfN8EAAQRIrN2e0VMqAz1ZIyE+9Uo5ikokX4CJVq6v7uvnVG+3qo+++H
	ax6tCZ3rW/TA7xoQIqfeHEFeGz6LGR/CBM8Z0
X-Google-Smtp-Source: AGHT+IEHU2PBTQug5VIKW6AtZfSP39GnmavYuwmmR5L3PS9OZax468Ngfs8BWg6TzLP3CGu72OLreZvfy3TBM6aApr4=
X-Received: by 2002:ac2:414f:0:b0:512:bed5:3d87 with SMTP id
 c15-20020ac2414f000000b00512bed53d87mr676884lfi.23.1708738397418; Fri, 23 Feb
 2024 17:33:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com> <20240222175033.1489723-2-calvinwan@google.com>
In-Reply-To: <20240222175033.1489723-2-calvinwan@google.com>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 23 Feb 2024 17:33:02 -0800
Message-ID: <CAO_smVh6PyxbnXfo0K1aDjEFPc3jTF4X_grerkxNZJdQe8V3sg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>, 
	phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:51=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
> From: Jonathan Tan <jonathantanmy@google.com>
>
> pager.h uses uintmax_t but does not include stdint.h. Therefore, add
> this include statement.
>
> This was discovered when writing a stub pager.c file.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  pager.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/pager.h b/pager.h
> index b77433026d..015bca95e3 100644
> --- a/pager.h
> +++ b/pager.h
> @@ -1,6 +1,8 @@
>  #ifndef PAGER_H
>  #define PAGER_H
>
> +#include <stdint.h>
> +
>  struct child_process;
>
>  const char *git_pager(int stdout_is_tty);
> --
> 2.44.0.rc0.258.g7320e95886-goog
>
>

As far as I can tell, we need pager.h because of the `pager_in_use`
symbol. We need that symbol because of its use in date.c's
`parse_date_format`. I wonder if we can side step the `#include
<stdint.h>` concerns by splitting pager.h into pager.h and
pager_in_use.h, and have pager.h include pager_in_use.h instead. This
way pager.h (and its [unused] forward declarations) aren't part of
git-std-lib at all. I believe this was done for things like hex-ll.h,
so maybe we call it pager-ll.h. The goal being to (a) not need the
`#include <stdint.h>` because that's currently contentious, but also
(b) to identify the minimum set of symbols needed for the stubs
library, and not declare things that we don't have any intention of
actually providing / stubbing out.

I have some more thoughts on this, but they're much more appropriate
for the next patch in the series, so I'll leave them there.
