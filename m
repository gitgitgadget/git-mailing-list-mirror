Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF6220248
	for <e@80x24.org>; Tue, 26 Feb 2019 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfBZUsc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 15:48:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZUsc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 15:48:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so3555413wmg.4
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 12:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FdFq7zCLO3bxSncASlsmjVrxyBDXrYpB4Ca0yCgM/RU=;
        b=FFMxpDOaeeBEv2F5bttfHS+shH434Epj0UJQ7LB8yFPZE9UKWXUJ/BoTw5MqxMP2T1
         vtw3pBjw1CLohlI23p3C60lVvhrt99CV0i0vctHvPO63RTShh1DmzVT9MVdBI4q+kbia
         CbEoTUtoroj7sqFQWrFSb6TSs7cBCYihaGKWAforxYTexVnhmiTT24m2YRNhHn1sInZC
         pipVgFV/C3hcNWxSBsVQVNLJYOJrCDmORFjWHzkUVmtOJaTIuF0Pj687iGKYy22wYcC+
         dYhfQ1cTNUTa1dFFuKr0Z5pMlpMoR5PxJ1chlSJVxQJyw5XYp/2SvMO4ehjTVbbehQgt
         BUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FdFq7zCLO3bxSncASlsmjVrxyBDXrYpB4Ca0yCgM/RU=;
        b=Nnj/h+kQd8J+yydzQvGCZ3Wb+3ehr5EVKKqHyKKboqktudhOlLPD/FUKrEKLwAadP5
         7v69VN5grABCC+qpESB+XtE2xMimW+L79tndJecVPT7+R3vU7B1KuLBO1j7vxxdYozKu
         Z4k1a8pxM76dyRmuvrkaI7IzND2flIn7KcJS9Kx4vRisaLUikeeO/mU/eOMYX3N52i77
         v9Bxi19xCGCPOwQ2VMcGyCp2/byiy4d74AftjEhPLxdj4IlEA0LplHi0z1vqFnXmb6hu
         fHF29CDCB3Y1IZtg69hY4G54aItzX7yKm2qYPkx5hg92J4RbIgjwTUvpNYJ7YSquFmjy
         BhaA==
X-Gm-Message-State: APjAAAWf3YWksE3ThweJAfxmdjcWm024vlnYlrzrwuZH6lmCkQ14b95O
        2arpZESysCW9pDZGO3d1p5wZ2dWGnpg=
X-Google-Smtp-Source: AHgI3IYLwT3/wKJZhmjRdXHOjfq0y6VClcjwOfxomrE6bcZB0f+OtCHuj+R8/UtjOGf+pNjTe6+yew==
X-Received: by 2002:a1c:a789:: with SMTP id q131mr29276wme.82.1551214110596;
        Tue, 26 Feb 2019 12:48:30 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id p16sm29700358wro.25.2019.02.26.12.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 12:48:29 -0800 (PST)
Date:   Tue, 26 Feb 2019 20:48:28 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v13 00/27] Convert "git stash" to C builtin
Message-ID: <20190226204828.GD27711@hank.intra.tgummerer.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <nycvar.QRO.7.76.6.1902261330560.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902261330560.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Mon, 25 Feb 2019, Thomas Gummerer wrote:
> > 22:  51809c70ca ! 23:  56a5ce2aeb stash: convert `stash--helper.c` into `stash.c`
> >     @@ -13,7 +13,7 @@
> >          called directly and not by a shell script.
> >      
> >          Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> >     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >     +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> >      
> >       diff --git a/.gitignore b/.gitignore
> >       --- a/.gitignore
> >     @@ -273,9 +273,11 @@
> >       		return 0;
> >       
> >      -	strbuf_addstr(&stash_msg_buf, stash_msg);
> >     - 	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
> >     +-	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
> >     ++	ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info,
> >     + 			      NULL, 0);
> 
> I do not quite understand this change, though. The end result seems to
> look similar enough to the previous iteration (except for the kept line
> wrapping which I would have undone in this patch), but how come that the
> `include_untracked` crept into some earlier patch in this iteration?

The reason for this is that previously we stopped passing
include_untracked through in patch 17.  As the option parsing in the
create_stash function was still in place at that point, it felt
incorrect to not pass it through to 'do_create_stash()'.

None of the tests failed at that point though, as nothing was actually
passing the command line options through anymore.  The last user of
that was removed in the "convert save to builtin" patch.

Arguably that would also be the right place to remove the option
parsing, rather than in this patch (convert `stash--helper.c` into
`stash.c`), but I tried to refrain from too much re-ordering to make
the changes more easily reviewable through range-diff.

Maybe I should have held back on these changes as well, or made the
other changes, dunno.  I wasn't always sure where to draw the line
between changing too much, which might hurt the chances of advancing
to next, because of the review work required, or doing too little,
which might hurt the chances because the series is not deemed in good
enough shape overall.

So what I ended up with is what I felt were the changes necessary to
advance the series, so we can start working on top, without the fear
of stepping on others peoples toes as much.

> The rest was obvious enough, thank you.
> 
> As I said before, I was very much in favor of getting this `stash-in-c`
> business moving again by advancing it to `next`.
> 
> From my perspective (which is not informed by any official statement about
> the role of `pu` or `next` because there is none as far as I know), the
> purpose of `pu` is to get patches into a shape where the original author
> is no longer the only one working on them. In my mind, that moment has
> long passed, and the fact that `ps/stash-in-c` is still stuck in `pu`
> really held me back on working more on this.

I mainly held back on doing much with it, because I didn't want to
step on Paul-Sebastians toes (and I thought we'd be okay with
advancing the series with the fixups on top).  But hopefully this is
now getting us into a state where we get this to next, and get further
work on top unblocked.

> So if you manage to get this finally cooking again, all hail to you!

I hope we can :)

> Thanks,
> Dscho
