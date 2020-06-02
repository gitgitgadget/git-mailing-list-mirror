Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C252AC433E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 01:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29A4206A4
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 01:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLgJXQsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgFBBdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgFBBdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 21:33:10 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88037C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 18:33:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c12so5112911lfc.10
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 18:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u09MZQrnLyuNM+IY6QuH+D4/TUhdD+CvqIcJJr4705A=;
        b=pLgJXQshL6KaPiVp8wnPtoOducT3LzojgT51q9jXk4Q9Bkj5tmI9nlbNM1KxnZe/3b
         DPc0HCK0KPWvW9PsXIt9bTilueKDL1U0rfpe5mB6SL+2argikeNsN9OqLGoO4iuShxjU
         G+B4siDQV3Bse7ZmhRTPZUROM2h1cTP8vFHvhGk8Y5eQqaLmq8Xcvxu9mYL8EA7NBs9g
         SF3dRnvGnhd0DNGgp8dkQiV3mKwBjtY6IlOlAyejf1ewtd1GRpq08pZWl3sZD/Db75SE
         fk1e921u79gDYy7pcVWGu1/UyAJgFkhnL8OWxCGEyU4Wr/SzvQ8hBeTLvg21cF/gm7/y
         Tejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u09MZQrnLyuNM+IY6QuH+D4/TUhdD+CvqIcJJr4705A=;
        b=SxOcvfrC2T0Du3kaB9Lms67ltz3J6KepT1J4HP/0LkI5hfkKiQVB74e6S09oPmibO6
         AiKBFou0n0UIjPjgO05npOm3DCS1sM+yBub6LxCgb7u63f9LpmD5XHRrhoCV+YP2i9cv
         W5fCtJQfEkKq8HmEast0OnLmAj21KebnCOwGKwcctpvASAn/gdilPgosVRwJfs2DlWYQ
         K+F6pGdlHevGkp03SRb3IeETOlHtDocHsgp1W4j8FKLcDTjlfYo6lRvQPmb5MPDjZ/F8
         ql62fBcUdn/Q4ph4a/PFs/7On8pxdT4qT2I/emRa9CmiusDeBCbycSkuqbYo5RKdXQTE
         fcWQ==
X-Gm-Message-State: AOAM532Egbg1ZDSG+1cha3a+Y/bd1RUim8BJFfkS8ouuWd2Tg5a66q63
        IFTX0IGAoCU45TpydeSgj+jTvapuTt3akIJyAUw=
X-Google-Smtp-Source: ABdhPJy/U41WuGqlvR7eZdg98UXWFQ2Q0wr+HUC7bCBYjGpTrjENkFwS4r2BuSJ9yrjIK91O0SpaZBBAPtXRV/ZBABA=
X-Received: by 2002:a19:bc4:: with SMTP id 187mr12768204lfl.211.1591061587206;
 Mon, 01 Jun 2020 18:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGKX4vGhTbEqZS9+iYA2wZWRRaddQC6O4KV+zLaNYKkZgN36Xg@mail.gmail.com>
 <20200601214003.GA3309882@coredump.intra.peff.net>
In-Reply-To: <20200601214003.GA3309882@coredump.intra.peff.net>
From:   John Siu <john.sd.siu@gmail.com>
Date:   Mon, 1 Jun 2020 21:32:55 -0400
Message-ID: <CAGKX4vH42x7nhCgtJ80fiNeaj1ROVxc-R8gO6xV21-6D3GbQSg@mail.gmail.com>
Subject: Re: Git multiple remotes push stop at first failed connection
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank Jeff for replying.

Yes, one route we are looking into is use fetch -all,  push -all and
wrap push tag with a loop, or may do what you suggest and wrap all 3
in a loop for consistency.

On Mon, Jun 1, 2020 at 5:40 PM Jeff King <peff@peff.net> wrote:
>
> On Sun, May 31, 2020 at 08:28:38PM -0400, John Siu wrote:
>
> > Let say my project has following remotes:
> >
> > $ git remote -v
> > git.all "server A git url" (fetch)
> > git.all "server A git url" (push)
> > git.all "server B git url" (push)
> > git.all "server C git ur" (push)
> >
> > When all serverA/B/C are online, "git push" works.
>
> A slight nomenclature nit, but that's _one_ remote that has several
> push urls.
>
> > However "git push" will stop at the first server it failed to connect.
> > So if git cannot connect to server A, it will not continue with server
> > B/C.
> >
> > In the past I have server C turn off from time to time, so failing the
> > last push is expected. However recently server A went offline
> > completely and we notice git is not pushing to the remaining 2
> > remotes.
> >
> > Not sure if this is intended behavior or can be improved.
>
> I don't think we've ever documented the error-handling semantics.
> Looking at the relevant code in builtin/push.c:do_push():
>
>           url_nr = push_url_of_remote(remote, &url);
>           if (url_nr) {
>                   for (i = 0; i < url_nr; i++) {
>                           struct transport *transport =
>                                   transport_get(remote, url[i]);
>                           if (flags & TRANSPORT_PUSH_OPTIONS)
>                                   transport->push_options = push_options;
>                           if (push_with_options(transport, push_refspec, flags))
>                                   errs++;
>                   }
>           } else {
>                   struct transport *transport =
>                           transport_get(remote, NULL);
>                   if (flags & TRANSPORT_PUSH_OPTIONS)
>                           transport->push_options = push_options;
>                   if (push_with_options(transport, push_refspec, flags))
>                           errs++;
>           }
>           return !!errs;
>
> it does seem to try each one and collect the errors. But the underlying
> transport code is so ready to die() on errors, taking down the whole
> process, that I suspect it rarely manages to do so. You're probably much
> better off defining a separate remote for each push destination, then
> running your own shell loop:
>
>   err=0
>   for dst in serverA serverB serverC; do
>     git push $dst || err=1
>   done
>   exit $err
>
> There's really no benefit to doing it all in a single Git process, as
> we'd connect to each independently, run a separate independent
> pack-objects for each, etc.
>
> I'd even suggest that Git implement such a loop itself, as we did for
> "git fetch --all", but sadly "push --all" is already taken for a
> different meaning (but it might still be worth doing under a different
> option name).
>
> -Peff
