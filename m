Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1352C79D3
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710572014; cv=none; b=kTjxvTJVEnjPTXixcdbULQokPP33zyQFH8hJrX819eEqeEI+VIrrHzeuJuP/MJ6iHromQsvE3vOBZmBiIuK0Uuk3wZsk4uqEg6RU3b/z6GAO2mdjuLF7bGKi+xUBuA/q+r3a4ZngYabS6Zj2KPXc6W4jqgIPeMhlfR6ebD/kBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710572014; c=relaxed/simple;
	bh=d6XWEuAsmWRBsKXuNhQJyPNpSvGpEKVy9sEsKxAuNZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qn3TmIQTT+gPvYv0zXVVNPgjMpbBSR1q91Z29/ErDO80ym9eeEc3wtIaCczdCmeQtgcYeJoTwxmfaavGEMM9Zyybh/Y9OtpgpQrUEEYC3ma/+YNeZ3DJP5MA/TJCyhXA4GYzXYvwcngtU1PhMBV8CDTUqqiHmnsJ13QRgaGwx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DSbffND; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DSbffND"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a3bb05c9bso52785117b3.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710572012; x=1711176812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1S0+F4VnrrMNO1IUhzR58tJDWSLGP5Q+U207tzboaHw=;
        b=3DSbffNDqrjOa8mCNnomObLKokZCB/4q7NKG5kvQwvCh16NEWgj1f76C7OvPGAvVVl
         Y5NusTcJPRCGwFoPO8+9mNSGXMExVcRJcx2GdcKfLEO+2CGBRy97JpCucV4pgyE+vB7K
         Tlsb+gXqrbYr1cJVauDRv7nYH+Ms9OQ9j22VbgUx1/pW4CEry7Y3h0yr2Fm5ODahYlr+
         xY5CNP1bm9ckWbf+/m3GWRbe8K4Gej3z1GUwTfaULL3b0/Kdvxu2YoByzKKFEXjHDlRK
         svJ4b7N0pOORbYn1OAbJFiNj5GNHIaJe6iXVlcglRnHYnUjY/vNc7pxPdUFOC9YSBAXc
         xMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710572012; x=1711176812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S0+F4VnrrMNO1IUhzR58tJDWSLGP5Q+U207tzboaHw=;
        b=qJd5MtuwaExCiOQH9zvPGwpS4C9mdelXL9xFBXWMNuj7eM4R3pCWhnofivVXDdCgbB
         3tP/S7M0gfJP1u9npACHewDu6C382GxhBoDLUZsit5V32irLKj/v8bhkCyGKRf8IDun7
         M7Ea9aUePIK5l5BHeVNTLj+ydHinUPCv5ADHonO3wxfKM3w9gIm/mfqYPQiWSBSdGVcl
         XV5ubEzehCdJzSt4OBH7/G+Hln5+XBLnZuX84c6M9FGEgzn0d3H0WG5zzEVlV2MYpk1D
         UHBfLbbneFlOxJsSCp69sO4mFXA4d8MLVaJkUjh/yorNMNr9PlIpoEGzRlTBYtRwo7Qx
         cxfA==
X-Forwarded-Encrypted: i=1; AJvYcCUZLGoygwAxPs00TBN6hPxsSwfoSU7dYB5GHvqhzPndiNZcw7Ma5+mGnsGriBHNvKt9//uEUI4i1piRxdFilYmLUY64
X-Gm-Message-State: AOJu0YzGHNc/wXTgfp6t7TttVSLXmMqrbTnYBEp4cZA7H1x58ULQ/58q
	k+UMjR94mHhYSXP0cbBROFsODvcB59QRywWpalV3tdc01808YKnJKDEnWhHgYysODef/lAdrYmr
	pjw==
X-Google-Smtp-Source: AGHT+IF/W2bTo9iedPmZ/hZoj6wqU3rWOHQAh/c3X05S/icHM2Ch3IrvHV7SJ3snCicgSObWDQSkAuTJwYY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:6dd4:0:b0:60a:562:d3b9 with SMTP id
 i203-20020a816dd4000000b0060a0562d3b9mr1291332ywc.4.1710572011918; Fri, 15
 Mar 2024 23:53:31 -0700 (PDT)
Date: Fri, 15 Mar 2024 23:53:30 -0700
In-Reply-To: <20240316035612.752910-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240316035612.752910-1-brianmlyles@gmail.com>
Message-ID: <owly1q8a4qhh.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] docs: correct trailer `key_value_separator` description
From: Linus Arver <linusa@google.com>
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Brian Lyles <brianmlyles@gmail.com> writes:

> The description for `key_value_separator` incorrectly states that this
> separator is inserted between trailer lines, which appears likely to
> have been incorrectly copied from `separator` when this option was
> added.
>
> Update the description to correctly indicate that it is a separator that
> appears between the key and the value of each trailer.
>
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index d38b4ab566..4839c2843c 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -329,9 +329,9 @@ multiple times, the last occurrence wins.
>     `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
>  ** 'keyonly[=<bool>]': only show the key part of the trailer.
>  ** 'valueonly[=<bool>]': only show the value part of the trailer.
> -** 'key_value_separator=<sep>': specify a separator inserted between

Nit: This line was modified to have " each" at the end. If you did that
on the next line, then this diff could have been a touch smaller.

> -   trailer lines. When this option is not given each trailer key-value
> -   pair is separated by ": ". Otherwise it shares the same semantics
> +** 'key_value_separator=<sep>': specify a separator inserted between each
> +   trailer's key and value. When this option is not given each trailer
> +   key-value pair is separated by ": ". Otherwise it shares the same semantics
>     as 'separator=<sep>' above.

LGTM.

It's probably not worth re-rolling, but a small suggestion I have is to
simplify the language a bit to reduce repetition, like so:

    ** 'key_value_separator=<sep>': specify the separator between
       the key and value of each trailer. Defaults to ": ". Otherwise it
       shares the same semantics as 'separator=<sep>' above.

Thanks.
