Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7912035F
	for <e@80x24.org>; Tue, 25 Oct 2016 12:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbcJYMjD (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 08:39:03 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36307 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbcJYMjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 08:39:02 -0400
Received: by mail-oi0-f65.google.com with SMTP id e12so6796025oib.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RmF0Duv5vvFZRjtGeXfLUmJOBsjUoH0NOSrCO4CCpu4=;
        b=UoFEj6SV0brZvIvggFeRqZh+3wWS07o1CZ3ZCQJB2AxhFl9GbIoNiY4CSIN2rvx2SR
         I/pFTQbUkQ4bjhfEOXTraAKCYrRrtfgErtKnGb7rAQO3fbHTER6zyi/R31aYN5W+9zpP
         ICKN2cbd+yC52wYE8M12a6QJ86FngWZeeDDinBJRUhZb6uvEgneJ4pHCMZfqGjkCOe8Y
         9ck6A1Zq0c3Ubi1udmfwiiFhHZBdxpC6+DIHRdBT1XVEa/AnVmtPZ4PXUlNaToO+jS5n
         uNpuzR6U0oPaZ1s7SFbc8z+xjNmzrcGX4/XwkZYUjMG8igWKMVUDgWm4hhR47fwLdczF
         di7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RmF0Duv5vvFZRjtGeXfLUmJOBsjUoH0NOSrCO4CCpu4=;
        b=eA6hGz5vDWdfNUXp9p0yMMNXUqjgk31EYIqfcay02wAYU/F8FIYZTvqLAXx22GlhIy
         H1qs1RKfMa+tQgWHL10hPzGVi1ut1x5FCK9guGHQy9s7lDDIxJa2qHjgph6TsKwn9wOM
         LYSWqXsep7HVPA1Jc54xOgs65kNPWNdrWsHPNcoTls1QNcqpxPlTU1uQ4HZVxVLSiDTS
         bQ4f5yv8QS2WKcZoMZPGecBPbmtEh9unjwL8K5cuPjcfmQIKsHCverzehzTGedP3AdF6
         Tizxp1GsZeF7Dyde+5PEu3PdR7sFFqd73h+Gi0k8vUgXD/MUAprz3FQ/HMpy3gAc0Czm
         C9Gw==
X-Gm-Message-State: ABUngvc8/08zhz0gomYUbFzP3561SjXylXOGIMIYCkGe03OlCIrtRyJj9UGwMgXphmY0U7hbMkYDiiJpm/2S+g==
X-Received: by 10.107.44.17 with SMTP id s17mr16012102ios.212.1477399141332;
 Tue, 25 Oct 2016 05:39:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 05:38:30 -0700 (PDT)
In-Reply-To: <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net> <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 19:38:30 +0700
Message-ID: <CACsJy8DZWN0RRaDy9w2BVG5pn4FWCY=1YQDsP0V5obrr1wSzZQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 1:24 PM, Jeff King <peff@peff.net> wrote:
> This passes the test suite (after the adjustments in the
> previous patches), but there's a risk of regression for any
> cases where the fallback usually works fine but the code
> isn't exercised by the test suite.  So by itself, this
> commit is a potential step backward, but lets us take two
> steps forward once we've identified and fixed any such
> instances.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  environment.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/environment.c b/environment.c
> index cd5aa57..b1743e6 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -164,8 +164,11 @@ static void setup_git_env(void)
>         const char *replace_ref_base;
>
>         git_dir = getenv(GIT_DIR_ENVIRONMENT);
> -       if (!git_dir)
> +       if (!git_dir) {
> +               if (!startup_info->have_repository)
> +                       die("BUG: setup_git_env called without repository");

YES!!! Thank you for finally fixing this.

The "once we've identified" part could be tricky though. This message
alone will not give us any clue where it's called since it's buried
deep in git_path() usually, which is buried deep elsewhere. Without
falling back to core dumps (with debug info), glibc's backtrace
(platform specifc), the best we could do is turn git_path() into a
macro that takes __FILE__ and __LINE__ and somehow pass the info down
here, but "..." in macros is C99 specific, sigh..

Is it too bad to turn git_path() into a macro when we know the
compiler is C99 ? Older compilers will have no source location info in
git_path(), Hopefully they are rare, which means chances of this fault
popping up are also reduced.
-- 
Duy
