Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876C143C77
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336950; cv=none; b=mBGTjY3x8CRdzgnv1RWZofkkq6XGfIJpCyVuA8drVMTPNCZl+9bKlwS2mOosv70pfrdleWtzDYiv8EnOnHKDsWNUECXmqTXuUz1jR1RiOlsCTg+hmYlW5Smnl3r8/JSV5llfviZDZiVKJpvaMT3Fjt1t6udpubPeJ9b5Pdht5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336950; c=relaxed/simple;
	bh=rpo/KvDMrwz07Ef/b3QVZTXXIpN6rHLwv3Er6ONF4tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUbltU6RqE3SC0IxNDk1TlAE2aem+uIqg8oFYxJRmxpKsXx9NaXZAeQJI39Gth2VSuIwk7rnne3EPRJwxqvZ8PtKua1hl81msLUbBiAwmRYsj8nJzZobrGWB6hKrKPcQB2WrWTcqHfiWbFddvcAuqFOeLAm+FKaQF5Aa7con40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbpqEJ+n; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbpqEJ+n"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7ec2d71059dso223035939f.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336948; x=1719941748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYEOKb05tEbXFqn331yUJNQgjnUeoLqW1yOTjTfgzT0=;
        b=XbpqEJ+nEMDMto02kKgBX60s0sqGEfDW6HmApF+mf5AZtUxDn0vh3OVmc0+39o/Fay
         WuOwCLJ3mgUge0uqSu6B3s7YbNScDOMhejV8eTqr9fI3JplcSLu74Iq/HPta8QshXoxq
         Ip2FY7f7IjPA9Cp0D1URTQC+qQH5qV/SKN444MbYN3u0Jqk0jRCrbqOTd69OEovXreDb
         Sd7uSrQ0eut2W12qnZ9waijD7U0ijv1nNCFyNjmjAQJFP2+xFz/HTXnBO72xqsJRnxxi
         ZjiQxhsEI03QnJLTeyxtzCDnY2QIAwgJrds0vXkFFKwGWQ64XE1Toydj1qIk95HaSmn7
         lvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336948; x=1719941748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYEOKb05tEbXFqn331yUJNQgjnUeoLqW1yOTjTfgzT0=;
        b=uwVAp437T/yYSbqcRSdLr5Eldl6IoGHJGaVvC0dLRFs5QbZu9F2Jla/mCqb6H1osbs
         d1U3QHw/h+aC2NADB5i9Zf6g7hkZr+EQpVdSUOwT84tq2axX6tQzT6KSIg4YtAs37vX/
         fCIE/EG8auJr4GNH/QDI8SwyaVUEdmEklvKWdQRrlRd5XaI23z32T0/V+/EpjL/x3D7R
         3SHxZ+rCBpbBjJwO5xxszZjYYF+pSObrG5Hk4QH61WnkQEJJKvL1s8Pr8L99OGVYjOKb
         qYdAXvyXj6+taIDt2DmQGHs08+DSm8oGcVc9u8J5qhk9cRQvYMEpQ/kXUpTxEbi4/D9S
         ZL0g==
X-Forwarded-Encrypted: i=1; AJvYcCWUjH32slrhCGQ5sYiOViWE2zYBorgLRsAPX/uaWvFA1UhVCx3ne1cjH9gTry63TTZB1nbc/6BfcCBOSQ9LRArzfbmr
X-Gm-Message-State: AOJu0YzwFE4ovdOIbU/3P1Aa7F44l1Tq8ADYZ/k/LIWLZnRUa9NMo4SA
	uZUY7GpqmRuwdWW5XH7yDoUrh1ya6W2QD/RfNn3E37xMMcei/06nFB5zl6uiQURDdRFyvECnCKY
	mF3Ea60TxyRTe+fx37e0saGBdRHY=
X-Google-Smtp-Source: AGHT+IGtbNwFGEVsYXDOzS0b9eKjCCIpBybsErIEq/oXWT+PNzKnFE1YYRFVbESnh7zeMNHxGikvSMINVPwG7nI9Bp8=
X-Received: by 2002:a05:6602:148d:b0:7f1:3eed:c85f with SMTP id
 ca18e2360f4ac-7f3a722db3emr931372239f.0.1719336948388; Tue, 25 Jun 2024
 10:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102439.GA222287@coredump.intra.peff.net> <20240614103122.GG222445@coredump.intra.peff.net>
In-Reply-To: <20240614103122.GG222445@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:35:37 -0700
Message-ID: <CABPp-BHDVarb8V+zMmWYdMVgypvmbPLCecPRQ3y9DGKngZzyGQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] remote: allow resetting url list
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:32=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> Because remote.*.url is treated as a multi-valued key, there is no way
> to override previous config. So for example if you have
> remote.origin.url set to some wrong value, doing:
>
>   git -c remote.origin.url=3Dright fetch
>
> would not work. It would append "right" to the list, which means we'd
> still fetch from "wrong" (since subsequent values are used only as push
> urls).
>
> Let's provide a mechanism to reset the list, like we do for other
> multi-valued keys (e.g., credential.helper, http.extraheaders, and
> merge.suppressDest all use this "empty string means reset" pattern).
>
> Reported-by: Mathew George <mathewegeorge@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> By the way, I think the nearby remote.*.fetch and remote.*.push could
> learn the same trick. I left that out of this series, mostly because it
> was getting long. But also because I had trouble imagining how a one-off
> refspec change would be useful. We can revisit it on top if we want.

Yeah, deferring makes sense to me.

>  Documentation/config/remote.txt |  5 ++++-
>  remote.c                        | 10 +++++++--
>  t/t5505-remote.sh               | 36 +++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remot=
e.txt
> index eef0bf4f62..8efc53e836 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -8,13 +8,16 @@ remote.<name>.url::
>         linkgit:git-push[1]. A configured remote can have multiple URLs;
>         in this case the first is used for fetching, and all are used
>         for pushing (assuming no `remote.<name>.pushurl` is defined).
> +       Setting this key to the empty string clears the list of urls,
> +       allowing you to override earlier config.
>
>  remote.<name>.pushurl::
>         The push URL of a remote repository.  See linkgit:git-push[1].
>         If a `pushurl` option is present in a configured remote, it
>         is used for pushing instead of `remote.<name>.url`. A configured
>         remote can have multiple push URLs; in this case a push goes to
> -       all of them.
> +       all of them. Setting this key to the empty string clears the
> +       list of urls, allowing you to override earlier config.
>
>  remote.<name>.proxy::
>         For remotes that require curl (http, https and ftp), the URL to

Thanks for documenting this too.

> diff --git a/remote.c b/remote.c
> index 9417d83e51..b7262964fb 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -63,12 +63,18 @@ static char *alias_url(const char *url, struct rewrit=
es *r)
>
>  static void add_url(struct remote *remote, const char *url)
>  {
> -       strvec_push(&remote->url, url);
> +       if (*url)
> +               strvec_push(&remote->url, url);
> +       else
> +               strvec_clear(&remote->url);
>  }
>
>  static void add_pushurl(struct remote *remote, const char *pushurl)
>  {
> -       strvec_push(&remote->pushurl, pushurl);
> +       if (*pushurl)
> +               strvec_push(&remote->pushurl, pushurl);
> +       else
> +               strvec_clear(&remote->pushurl);
>  }

Nice that after the preparation patches the fix is nice and simple.

>  static void add_pushurl_alias(struct remote_state *remote_state,
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 7789ff12c4..08424e878e 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -1492,4 +1492,40 @@ test_expect_success 'refs/remotes/* <src> refspec =
and unqualified <dst> DWIM and
>         )
>  '
>
> +test_expect_success 'empty config clears remote.*.url list' '
> +       test_when_finished "git config --remove-section remote.multi" &&
> +       git config --add remote.multi.url wrong-one &&
> +       git config --add remote.multi.url wrong-two &&
> +       git -c remote.multi.url=3D \
> +           -c remote.multi.url=3Dright-one \
> +           -c remote.multi.url=3Dright-two \
> +           remote show -n multi >actual.raw &&
> +       grep URL actual.raw >actual &&
> +       cat >expect <<-\EOF &&
> +         Fetch URL: right-one
> +         Push  URL: right-one
> +         Push  URL: right-two
> +       EOF
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'empty config clears remote.*.pushurl list' '
> +       test_when_finished "git config --remove-section remote.multi" &&
> +       git config --add remote.multi.url right &&
> +       git config --add remote.multi.url will-be-ignored &&
> +       git config --add remote.multi.pushurl wrong-push-one &&
> +       git config --add remote.multi.pushurl wrong-push-two &&
> +       git -c remote.multi.pushurl=3D \
> +           -c remote.multi.pushurl=3Dright-push-one \
> +           -c remote.multi.pushurl=3Dright-push-two \
> +           remote show -n multi >actual.raw &&
> +       grep URL actual.raw >actual &&
> +       cat >expect <<-\EOF &&
> +         Fetch URL: right
> +         Push  URL: right-push-one
> +         Push  URL: right-push-two
> +       EOF
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.45.2.937.g0bcb3c087a

Make sense.
