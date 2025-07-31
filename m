Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF31E7C19
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951866; cv=none; b=JwX51Wo4iiRbFaqOyBzeV+WK1pYs9GEs5ogMpxXFqIBdE+/LfWvKRDfhd0bUk+aFyV4cmVUTXs7ZlZeNo8/oq6rnDP17csX23hA8ZkELnlqWvw/8m7e5FZiN6QfzDbQdxntqCLV2vhPhj+e7B/yiXCmcIpRDyS5gwjflu+jcsqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951866; c=relaxed/simple;
	bh=ijlGyZJGttm3RTBfwiLRzkDLddcBtSRRDh1XZbVUN3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BP2GCN2SqzIIB4FX8wLttbcFbGrS7iaz5mLyAoCn78Dq9eDpqw4yyfxMt1s8LimvUwaXO+ts7hn8e4EjCmzEac/3976w1bwGtejJPRuJA6RlqS2r3RksoZvt4NJ06qb3xa1E/0oOEmAQc0AiEVeIgqCLkppjZfmbU2WR38bFDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsBwgGYl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsBwgGYl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so104082866b.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753951863; x=1754556663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1985ESzOSvwyiDLWE0SrMSq8TRgs5GwuGbt8WuaJ6a0=;
        b=lsBwgGYlxOQQJwGWrx2DKkMD/lztFxJgKX6VZ07Fz1fyjNcNl9EyNZuq1Xe35ZEhcW
         PubYRNqBP7W52yfUsJC3gYbGKRU9xsRYuoSKNhx1ecJE5gT9ZOIMh7hSi3oi1fLCEmF4
         sYJreSahlTJ2xCzcpVZyNv4tYmPNmcwbnhEBX5PF3awctZIsJjE0J/1hCsXC4Jc4gG1l
         nYDOYa7/JppaCcMBVeYiwmx4AyUzbmXk9ZbzlsZ/+ZEdaWUVey22xRuZcGq8qSyEpr+6
         LTDDC5Da4KzG/joRCDBM7maPOXKkziu1kpjxprg0aiHDpnoN4Tq02DSFY+lyXAdshI7c
         uThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753951863; x=1754556663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1985ESzOSvwyiDLWE0SrMSq8TRgs5GwuGbt8WuaJ6a0=;
        b=blWnM5QK0jKMnIMeZigttKWmCC2GXK8TkOwmY3TLDnNFN7GjSdBk5tZVxJriYR6B8B
         aIE2CTWAdtkreJbXzb2WB3UH+IIJ7Lh7VulVF3y6uEY1Rg7yJX06Aos7YUlU5N775hEy
         N8QquHK9vh8V+6IbTggbJaibc3Q6GWPrc/UQtr1zE7rxLAmqp5OrLxOO3uLeFCHBAV2G
         mRb16WtbA0de1r7HbLWcuwi1sOx99R3II0m9dz5KE+dYE1qYa3g2EmzSCOwyDkJBbFlx
         qydPiB3FWkUDTzynSItZDQpyMx206KOVOBrqQ5zk+4GvP6XIP4dQLpz0mVldQFRe2rHh
         DO2Q==
X-Gm-Message-State: AOJu0YwvnS+nTqEDv55sjI7qvmx886Gja4fq7ncUWHMf3jVoGEJpz1Bl
	Rg9Wb2hP68fPKef/mjyaQWnbIvKPLrlsLWbA/9tAJM2VJ0MsTGfniOdgAan3A2qON51W9zGdTau
	ptOsW+CbYnDCZcPtVwtZhNJvUVCJIIc3Xbc4u
X-Gm-Gg: ASbGncvyQ7uFYDCxxTRjFgC54PMiT0JZZvmckQN9St5dIMi1La+ib99uPRlsyumhvfn
	RcC8y5MJCkbATzIZouC6k+FRYfVuxS5l4eoWeGn6OTE7HGD645rUNELQLxI9PLvlmOFeHy7MjH5
	at1rgxCFDuV3ETLUQlYm3UxoPTe52gIrBQp8sL0sAwO+2ddq03B9kenhyGixPLo6eoN3iR2Pclr
	8eDiL4FoA==
X-Google-Smtp-Source: AGHT+IGUK6PKsryKGK/xHF9cxGGJeg+IUN6hBFT8z1j44kJbph0tApdFzJF2D+wnD0Fu3kqXJWbgbAbgNtlbrKt7HC8=
X-Received: by 2002:a17:906:fd86:b0:ae3:6744:3680 with SMTP id
 a640c23a62f3a-af8fd9c20e8mr754205266b.42.1753951862658; Thu, 31 Jul 2025
 01:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731074154.2835370-1-gitster@pobox.com> <20250731074154.2835370-10-gitster@pobox.com>
In-Reply-To: <20250731074154.2835370-10-gitster@pobox.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 31 Jul 2025 10:50:50 +0200
X-Gm-Features: Ac12FXzb2Mk7XbzGk-HOJKwcGE5-_P7T3WEHGfx3eOg5t3LqBjnlNRPvolzVRqE
Message-ID: <CAP8UFD2qAOhRN=b9PB_eXQS1PntZKX95ZK=V4G=10n3iU2xtbw@mail.gmail.com>
Subject: Re: [PATCH 9/9] sub-process: do not use strbuf_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 9:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> The code to read status from subprocess reads one packet line and
> tries to find "status=3D<foo>".  It is way overkill to split the line
> into an array of two strbufs to extract <foo>.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sub-process.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/sub-process.c b/sub-process.c
> index 1daf5a9752..de3235c15a 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -5,6 +5,7 @@
>  #include "sub-process.h"
>  #include "sigchain.h"
>  #include "pkt-line.h"
> +#include "string-list.h"

Is this needed? It looks like skip_prefix() (not any string_list
function) is used instead of strbuf_split_str().

Thanks.
