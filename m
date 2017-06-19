Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A391FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdFSWIl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 18:08:41 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35723 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbdFSWIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 18:08:22 -0400
Received: by mail-pg0-f51.google.com with SMTP id 132so20327469pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mYHZvFFmjq5HnQYU6CQD995v2bLZfHLUQ+/u0WW9mWE=;
        b=AwX/uzNBEDMpzsbW0wvjFSAdVJl4qIsDgWMsVfRzozVVBkBV94FcvekxMYlQmLMNZm
         bjEOXvtr6NRIAdSefNq9CMKhoMuTdC42jIIWa3OM5XnaqZtRzeMml9OZBEVV3qFzOMB6
         ryQYg1PaAtPVyPjLZqydhJk8FiKy2IHdVR6+5gK2KR78ROY6Vyj1nvRpXShIDdvg9a+W
         Caf6G+Gk+sBObKl0bMb4OfY6Qi2VV2uSqkxC1nKvb6KygG8YQLu1paEak8NoCyjodgrZ
         UQwgCHM54gw3f9taCjCccX5A8/VTBe+Wi5qtRbDW39TTbDbQfdeHSUXZQLvWcuLYXMM/
         jJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mYHZvFFmjq5HnQYU6CQD995v2bLZfHLUQ+/u0WW9mWE=;
        b=rAqdLeNdnWt/6+JZIhVPGLoUYbZD58tmTRjoWt0Vbj71Ir2R2FQh2SqjzNR/2jYhfN
         Mc3Tq4ug/NPdczGCMkYdmDL/a5Upz4nZoW2kBql9Fp8zv9/+RbBxUXrkeMV+69vcifqM
         fChpVJvDPdbdQzXjjMunFixiI/V+HbNKdAqORY51ODDjouvIHXNB86frSOcgcSeowHlI
         +imvjnUPJQy8Lblrs71LXYMAgGA7P3rhhU0re9mO5gOHN8+6MDJn9KDLoKgSD/X2UcBV
         NBuadgYBSXrPe2RZTuqmWD1hE8VdIzUopFacRzemGCkCGxsoakEDAXkOC+7HeRA4a3kr
         uKAg==
X-Gm-Message-State: AKS2vOxpcqq5h3zCbkhE4sqd7QVQ66hJVfaNiuIBX/vFn2fDdfK4UIWG
        qviL9pK//DHJJic2R/xFjsJOM/LrQGXJ
X-Received: by 10.99.141.76 with SMTP id z73mr8264672pgd.40.1497910101135;
 Mon, 19 Jun 2017 15:08:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 15:08:20 -0700 (PDT)
In-Reply-To: <20170619220036.22656-1-avarab@gmail.com>
References: <20170619220036.22656-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 15:08:20 -0700
Message-ID: <CAGZ79kaHXX4ne_hfjVs7PaeLzHc+CbVSZ1hCNz0ebG5F3uJEzg@mail.gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Now, git-grep could make use of the pluggable error facility added in
> commit c19a490e37 ("usage: allow pluggable die-recursion checks",
> 2013-04-16).

I think we should do that instead (though I have not looked at the downside=
s
of this), because...
>
> So let's just set the recursion limit to a number higher than the
> number of threads we're ever likely to spawn. Now we won't lose
> errors, and if we have a recursing die handler we'll still die within
> microseconds.

how are we handling access to that global variable?
Do we need to hold a mutex to be correct? or rather hope that
it works across threads, not counting on it, because each thread
individually would count up to 1024?

I would prefer if we kept the number as low as "at most
one screen of lines".

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  usage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/usage.c b/usage.c
> index 2f87ca69a8..1c198d4882 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -44,7 +44,9 @@ static void warn_builtin(const char *warn, va_list para=
ms)
>  static int die_is_recursing_builtin(void)
>  {
>         static int dying;
> -       return dying++;
> +       static int recursion_limit =3D 1024;
> +
> +       return dying++ > recursion_limit;
>  }
>
>  /* If we are in a dlopen()ed .so write to a global variable would segfau=
lt
> --
> 2.13.1.518.g3df882009
>
