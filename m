Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8771401B
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669188; cv=none; b=JC40VGnnrtKev9N7LRGryHSLbdxR+XAZ3MFK1baTzshB6lRqXZnWLTnSlhnO111f7f8QhEi1yuLZ2V/FkWpPuqJJlhTk/JQxziTQgQMSUo/GhiPmcHhEfunlr3dXopjf+XLUfSvWO8wnVZVUBRkIrn3UNWgTWxIe3D4NKIjUslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669188; c=relaxed/simple;
	bh=wddBVKAfXZOHW8CuLHmuJGPq/xnGy95TwCz/XUu0BX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma22TV2nw8aoG6YzA9nVw1mw90fmRu8whklbt3Iz78oQkGYIsM8m6HP4l6/9rn2QTVl4L9/E3yF9O5cp0jVK8jYA4x8O1vVBO7amHJzxSepxPjqy/j8lvDLQNYYFYillS2Cr10n6/9sxrgkOEq7eNokI/wDXmtToXKUxPhkZYpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3GguSThx; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3GguSThx"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d57d8882eeso567704eaf.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721669186; x=1722273986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUnm9kv/NGamr1mwJu74j9AbSEjAYKMxPws3PZWkpMU=;
        b=3GguSThxVgmY+2JpO1+HZO6cGaVLnZ1h36mqprKM65GpMxuqAUp3gIeLWz5GWLCZaG
         aKavaiLJtB41M6LpV3I54spovDNMuBEb8WZWv2mPoadLmqfgKh8Xw3mR3u8OjYgrl1A9
         DFYW1qOLoPWo1GOINB3Smam7/vEE8JrQe8m/iBXw6YBT77kdup9aMY/zGzYD4qLuRZTo
         ORWlNHnP/cqCvp2TYY8/iHn8wz5mIQi7x9LZy15FX6le7rTdGZk2r3CwvPKhQ/3C8+J8
         a1uA6vc/SiJK8vDmXZQkpMVMq+D5EzeBz6CADlcY2AwyaB63VjPNS8HfLj7GLE8eFRsD
         a+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721669186; x=1722273986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUnm9kv/NGamr1mwJu74j9AbSEjAYKMxPws3PZWkpMU=;
        b=vC37rOCBtkd5059jRCd+qRe049I99QJMOhgwHGjRznHtfEcLjvL8ijn8iGdfM7MVLc
         +M2zWvZbBOqIEm28PeR2b2LpVoCPS4GP0mG2lpKjrr9n8Aa4P5iOK7mf2hS1VrVGJHZv
         qIckO8PfBJZ2KrbXr0v77BRpMvIRC5megKhZJaBTptkAwd5ibR5HRksfgAcy9oLHmTqX
         dzg0bItzsk6IcvQsk3qJuRKcaDPbGI7dWgU/KhLRuwDJXDafstdePobr/30cF5IzviWA
         5pRAD4J7+C4JLwcq/BtkLst5PpxZqZw+RrD1+7IrQXCwfncAUx456oedbADZs71LMa8Z
         nysw==
X-Gm-Message-State: AOJu0YwKWVqD0k/nwxP7fb3OwfYAgojgHMS7vAIQEt7hKbI0bjAFmNSU
	Q06PhuLx7G5l0dLw6cjn28lJ/WPsfnP8eVosdgC/NTOr6WP3OCYCMEq0aiglZJOVv0IY4LN/vL4
	CdodsMMATt0f5d/EpB4H9J1LT1tGiLPlBiN9I
X-Google-Smtp-Source: AGHT+IHFG2YtlDO60opyNCm4PRKEAe/tsrJXlbqTlINQ2DHvJwbHqjSPMfSq4SkJIGyQMEIt3Z5Y8XkMABVJwjo6CCQ=
X-Received: by 2002:a05:6820:2107:b0:5c4:79a5:c37f with SMTP id
 006d021491bc7-5d564fd0365mr10832741eaf.8.1721669185513; Mon, 22 Jul 2024
 10:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net> <20240722065915.80760-4-ericsunshine@charter.net>
In-Reply-To: <20240722065915.80760-4-ericsunshine@charter.net>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 22 Jul 2024 10:26:10 -0700
Message-ID: <CAO_smVg8+WCG0dWZNPVbDM4gBJLLHrg96nOCzje6B3hUGneDGg@mail.gmail.com>
Subject: Re: [PATCH 3/4] check-non-portable-shell: improve `VAR=val
 shell-func` detection
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:01=E2=80=AFAM Eric Sunshine <ericsunshine@charte=
r.net> wrote:
>
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Unlike "VAR=3Dval cmd" one-shot environment variable assignments which
> exist only for the invocation of 'cmd', those assigned by "VAR=3Dval
> shell-func" exist within the running shell and continue to do so until
> the process exits. check-non-portable-shell.pl warns when it detects
> such usage since, more often than not, the author who writes such an
> invocation is unaware of the undesirable behavior.
>
> However, a limitation of the check is that it only detects such
> invocations when variable assignment (i.e. `VAR=3Dval`) is the first
> thing on the line. Thus, it can easily be fooled by an invocation such
> as:
>
>     echo X | VAR=3Dval shell-func
>
> Address this shortcoming by loosening the check so that the variable
> assignment can be recognized even when not at the beginning of the line.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/check-non-portable-shell.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.p=
l
> index b2b28c2ced..44b23d6ddd 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -49,7 +49,7 @@ sub err {
>         /\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not =
portable (use FOO=3Dbar && export FOO)';
>         /\blocal\s+[A-Za-z0-9_]*=3D\$([A-Za-z0-9_{]|[(][^(])/ and
>                 err q(quote "$val" in 'local var=3D$val');
> -       /^\s*([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{=
$4}) and
> +       /\b([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=3D=
/ and exists($func{$4}) and
>                 err '"FOO=3Dbar shell_func" assignment extends beyond "sh=
ell_func"';

Is there an example of a shell on Linux that has this behavior that I
can observe, and/or reproduction steps? `bash --posix` does not do
this, as far as I can tell. I tried:

```
bash --posix
echo_hi() { echo hi; }
FOO=3DBAR echo_hi
echo $FOO
<no output>
```

and the simpler:

```
bash --posix
FOO=3DBAR echo hi
echo $FOO
```

Both attempts were done interactively, not via a script.

I'm asking mostly because of the recent "platform support document"
patch series - this is a very surprising behavior (which is presumably
why it was added to this test), and it's possible this was just a bug
in a shell that isn't really used anymore. Having documentation on how
to reproduce the issue lets us know when we can remove these kinds of
restrictions on our codebase that we took in the name of
compatibility, possibly over a decade ago.

>         $line =3D '';
>         # this resets our $. for each file
> --
> 2.45.2
>
>
