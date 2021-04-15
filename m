Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FFAC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E2D61158
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhDOUZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhDOUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:25:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C9C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 13:25:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so1696011lfp.0
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ivOUOAPnluvn6dDjV4/VE4kbhcu9fLTKnp75bt368o=;
        b=fBA/RJHJlgAwjEkI1zImu26V6rYxjVtmxvLn6R206tbC4nS975cBmlgYxLkmzNftwF
         RrLR/PISwZFdHEZSPz9re/sfWsWUK/+QwjLCbj6vcNxKR92TEX+a38465PyHjXADhpHt
         OWgr4mm5nxSt4gYIKwVGMtAmMl2L48zyxxe7RHVf3+m9RcTwOjjE2tVgtWXHDcpCFb0K
         jTLgGEoKbIvSu3krzWviHG22wrsVfmiDsstv4eGAUfGXp8rxBtPAKydap1Ljceai3QjW
         L5VYJ3U71GlQmBdO+2N8Gn3XMs607EG86Re/984u9xM27e2RM5CejzIz/cYeXx0oApXg
         MwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ivOUOAPnluvn6dDjV4/VE4kbhcu9fLTKnp75bt368o=;
        b=HEwqU5HGBuffLEFnjDkIHwY1XNQX0JCwISb4azPf3LCVQkhNKQppGDkhLU+eGYmTRh
         75l3l1zUwU2aHvEs4pUgyM6ovd2tS7afRV8CmIXtssCao4nJKKYxWwmYBblB7sHMhOhp
         K2Y8TW3AGwB4+VHz438I/l16Pm4vYtM+w2WMOtmhAuOB7GobUeiOKk8SpeGXEETD3dhK
         uVqyREcOj2siJam0uhkvaLxSKY02Bycz/YiNHG4tGu7QBAlAJJ3zSmzsEkPiGGkGANeq
         f3KRhsRZAdBeUmTgsUAIkWkKz09B1IV75wPc9mOvLzR+zF+y64aNFK1Ij7DALmzb/y+G
         ElzA==
X-Gm-Message-State: AOAM533rYhoZ3ceCgQYf3i6/M/CkIysOwegR27mhN6jl7oV+VlcmA1bP
        oUTKChVF+frZZYkWDQIEdlBM1mftxwzzDx1wot0Qnm9bRiifWw==
X-Google-Smtp-Source: ABdhPJw2zvFVaKHcdMyDmGCDVeET495j/DB50ylryDsQz1fDYN0mFsdX/emKEpQ2OKK0B/n8PoTPj4B3Pu1X71Mg/+M=
X-Received: by 2002:ac2:546e:: with SMTP id e14mr539181lfn.502.1618518303856;
 Thu, 15 Apr 2021 13:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
 <xmqqtuo7pb2b.fsf@gitster.g>
In-Reply-To: <xmqqtuo7pb2b.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 15 Apr 2021 17:24:52 -0300
Message-ID: <CAHd-oW4sqJpeJywgRJCkchX0uZFSxD-UnguRJcRcQQywd+scbA@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: do not report packet write errors twice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 5:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > On write() errors, packet_write() dies with the same error message that
> > is already printed by its callee, packet_write_gently(). This produces
> > an unnecessarily verbose and repetitive output:
> >
> > error: packet write failed
> > fatal: packet write failed: <strerror() message>
> >
> > In addition to that, packet_write_gently() does not always fulfill its
> > caller expectation that errno will be properly set before a non-zero
> > return. In particular, that is not the case for a "data exceeds max
> > packet size" error. So, in this case, packet_write() will call
> > die_errno() and print a strerror(errno) message that might be totally
> > unrelated to the actual error.
> >
> > Fix both those issues by turning packet_write() and
> > packet_write_gently() into wrappers to a lower level function which is
> > now responsible to either error() or die() as requested by its caller.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  pkt-line.c | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
>
> Nicely done.  Duplicated error message literals do look, eh,
> repetitious, though.
>
> I wonder if something like this on top would be an improvement.
>
> Upon seeing "return error(_(VARIABLE_NAME))", it may be distracting
> that you now have to move to where the actual message is defined
> while following the logic of the code, but as long as the variable
> name captures the essense of what the message says, it may be OK.
>
> I dunno.
>
>
>  pkt-line.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git c/pkt-line.c w/pkt-line.c
> index 39c9ca4212..d357c74fcd 100644
> --- c/pkt-line.c
> +++ w/pkt-line.c
> @@ -199,12 +199,16 @@ static int do_packet_write(const int fd_out, cons
>  {
>         char header[4];
>         size_t packet_size;
> +       static const char size_error_message[] =
> +               N_("packet write failed - data exceeds max packet size");
> +       static const char write_error_message[] =
> +               N_("packet write failed");
>
>         if (size > LARGE_PACKET_DATA_MAX) {
>                 if (gentle)
> -                       return error(_("packet write failed - data exceeds max packet size"));
> +                       return error(_(size_error_message));
>                 else
> -                       die(_("packet write failed - data exceeds max packet size"));
> +                       die(_(size_error_message));
>         }
>
>         packet_trace(buf, size, 1);
> @@ -222,9 +226,9 @@ static int do_packet_write(const int fd_out, const
>         if (write_in_full(fd_out, header, 4) < 0 ||
>             write_in_full(fd_out, buf, size) < 0) {
>                 if (gentle)
> -                       return error_errno(_("packet write failed"));
> +                       return error_errno(_(write_error_message));
>                 else
> -                       die_errno(_("packet write failed"));
> +                       die_errno(_(write_error_message));
>         }
>         return 0;
>  }

Nice! :) Maybe we could also avoid the static strings without
repeating the literals by making `do_packet_write()` receive a `struct
strbuf *err` and save the error message in it? Then the two callers
can decide whether to pass it to error() or die() accordingly.
