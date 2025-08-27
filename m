Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441E1EB5CE
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302830; cv=none; b=U28LC5BwUpahB3Xx3Rxi5hW/AwxipBytnYCVEysv02y9qfYvwXXguC8p45q0Eef98djdQgjD+LZFQr4fqX0uHUTiSQvGNcgZMELIExjKK5CLBhMFdgG9av1eOhozuaQvAR7LERe3MZqpR2k6fjrIJM4C7MSuJfi16aFp8pZTq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302830; c=relaxed/simple;
	bh=v5HDPLeTJBBiAbkRonCfR8WbXx4TEmlHDAqwnRP5RTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FE62ygXCuKDriiDyogf+JI7es/91m/+6CCeH8wEl/FscxJ1BSSGzW6+gq0HoXuqoki4azVx+jirhUCGQx7xgSUoRbiaswpB1D4dTRjqw7x7s4EZX5jOLeTR27l3F+KVjQgNx7ALoJIPXbzbAx2Tg7FcaVOshraG/OlfX2Sz6vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZLNFZ4e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZLNFZ4e"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7720c7cbcabso327364b3a.3
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756302827; x=1756907627; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiJtUq4+rCtaeEI/cVzeXyuJIobFxHkQErgdrK4+cRU=;
        b=YZLNFZ4e1gLzH06ABwwhS6PyrnQQJZ7/bXM35U9xhHarEpqNTTLBcPoMRf7GcHiYTf
         6vNX8vYeKzjMXWeb22dv/YfYetbq+lJtk/XGMWZMhFLuEFJ6uguzvDf4MWJpkIkVcZRV
         35ydlS9gkasAmrg8ZTCzNH5BjYppYwKSgQjJnm+KA0pE+cBRoKkmpy17cnZJAzPhMR0V
         n24jP6+Ilmw2pd1DjfkPYUOH79hZH5ej+0azsdb9tSpHo9U+UM8mymoHUO1NyiFeOYS2
         oS0NGuhn6/2ebQM6OCehfk5I/oDWOB5uWi+4CGiPvnCK9TUwQ08R5Ke1O0y2WGY1MUXv
         6Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302827; x=1756907627;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiJtUq4+rCtaeEI/cVzeXyuJIobFxHkQErgdrK4+cRU=;
        b=ehX1uXakqz5xCwO9ljXtBTOG+ODWTgNETXJD5vl/99cZSfmpNmexPjwTZRLSH48wjQ
         kXySjGbxMWNDBfJyYdq/5ykheJLZCLf+vIPUP6meJAcKCkw29kULF8G5WVET+hZgXlt+
         Z+1lhjprXAYG4a2tMovJsHqFXTu7yUWzg3Cfq0tlt9n0KnUz2RTWJRz28T4ausBcfPfR
         WMJpKomQH3AZ+SjYllyV06CGfhnj+OYC/LWy02/KPKFtH48GMW20cT67ZOhud5Gr46z6
         ykE6vPwppAby0uX3CVOoaFrH9FWEydC4tpdM78sMu5EqHyADGmJZyCpw6yL4XSeTOrRx
         3sTw==
X-Gm-Message-State: AOJu0YyGNAEmKYXt0DZ07RnRHuu61X4jc9Tv2lODXAR3JzRvX1n+91C/
	2QgHDkV3oGEZEx+a8YTAuVXF+SJZ55xMlV573F51u5wv5cW5Z88CqM5CJdhdxktThC6cW8n9n82
	egQ+rSlqjPOUhUCiAEGMJQqDL2CGV09quY6io
X-Gm-Gg: ASbGncu97VHOGCbORGa7jZMg0QSqNTdvyqCEaoeOU1OQXedIKYedF6dw19DhWslatof
	bm+CX/TiVdeqiRNhZnYI9bqVh9xOiHxPfuCA+h2rbZJQ0b/uoffdI1Piwe1oNO3UGzP6TE0imHV
	41pcm7J6XA6mAmQanmbiMRTzP4vdhq5cIqB7zV7R/iKd5g2trV9oJqNlsQdi/LRnhJ/6d1U8WI1
	SxcH1GKdA==
X-Google-Smtp-Source: AGHT+IFHr2WNh6bKw5NqmNTFmPder/Z6KUH1I3RIEovNiVNnwxqN5hWKoXeM2SGRbxgpIFtbOFyQmTDHkLGkAng3rWs=
X-Received: by 2002:a17:902:f64b:b0:246:7a43:3f82 with SMTP id
 d9443c01a7336-2467a4378cbmr214763575ad.45.1756302827346; Wed, 27 Aug 2025
 06:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822084910.98308-1-ayushoffinfo17@gmail.com>
In-Reply-To: <20250822084910.98308-1-ayushoffinfo17@gmail.com>
From: Ayush Sharma <ayushoffinfo17@gmail.com>
Date: Thu, 28 Aug 2025 00:53:36 +0530
X-Gm-Features: Ac12FXzkxmJ7mz-Say3-AeGD0fkMzyydlhTKrqWNaFNhBblCCJy5YfOVkB0TZpw
Message-ID: <CABV7AFFLF6SJEk92Kr9x9z2sOk5nZ7Q0gx=GKR+-JNxSkju=RA@mail.gmail.com>
Subject: Re: [PATCH] config: add "hostname" condition to includeIf
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Just a gentle ping to see if there is any feedback on this patch.

Thanks,
Ayush Sharma


On Fri, Aug 22, 2025 at 2:19=E2=80=AFPM monarch <ayushoffinfo17@gmail.com> =
wrote:
>
> Teach "includeIf" to include configuration based on the machine's hostnam=
e,
> as returned by gethostname(2).
>
> Example:
>
>     [includeIf "hostname:work-laptop"]
>         path =3D ~/.gitconfig.work
>
>     [includeIf "hostname:home-pc"]
>         path =3D ~/.gitconfig.home
>
> This allows users to write host-specific configuration without separate b=
ranches.
>
> Signed-off-by: monarch <ayushoffinfo17@gmail.com>
> ---
>  config.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/config.c b/config.c
> index e0ff35d426..dbc1a2bc75 100644
> --- a/config.c
> +++ b/config.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include "git-compat-util.h"
> +#include <unistd.h>
>  #include "abspath.h"
>  #include "date.h"
>  #include "branch.h"
> @@ -391,23 +392,47 @@ static int include_by_remote_url(struct config_incl=
ude_data *inc,
>                                              inc->remote_urls);
>  }
>
> +static int include_by_hostname(const char *cond, size_t cond_len)
> +{
> +    char actual_hostname[1024];
> +    struct strbuf target_hostname =3D STRBUF_INIT;
> +    int ret =3D 0;
> +
> +    // Make sure the call to gethostname is correct and its return value=
 is checked.
> +    if (gethostname(actual_hostname, sizeof(actual_hostname)) !=3D 0)
> +        return 0; // If it fails, the condition is false.
> +
> +    strbuf_add(&target_hostname, cond, cond_len);
> +
> +    // The core of the logic: strcmp returns 0 when strings are equal.
> +    if (strcmp(actual_hostname, target_hostname.buf) =3D=3D 0)
> +        ret =3D 1; // Success, the hostnames match!
> +
> +    strbuf_release(&target_hostname);
> +    return ret;
> +}
> +
>  static int include_condition_is_true(const struct key_value_info *kvi,
> -                                    struct config_include_data *inc,
> -                                    const char *cond, size_t cond_len)
> +       struct config_include_data *inc,
> +       const char *cond, size_t cond_len)
>  {
> -       const struct config_options *opts =3D inc->opts;
> +const struct config_options *opts =3D inc->opts;
> +
> +
>
>         if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
>                 return include_by_gitdir(kvi, opts, cond, cond_len, 0);
>         else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &con=
d_len))
>                 return include_by_gitdir(kvi, opts, cond, cond_len, 1);
> -       else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &con=
d_len))
> +       else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, cond=
_len))
>                 return include_by_branch(inc, cond, cond_len);
>         else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:=
", &cond,
> -                                  &cond_len))
> +  &cond_len))
>                 return include_by_remote_url(inc, cond, cond_len);
> +       else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &con=
d_len))
> +               return include_by_hostname(cond, cond_len);
>
> -       /* unknown conditionals are always false */
> +/* unknown conditionals are always false */
>         return 0;
>  }
>
> --
> 2.43.0
>
