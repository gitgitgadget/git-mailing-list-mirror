Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673781F453
	for <e@80x24.org>; Mon, 29 Apr 2019 09:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfD2JQ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 05:16:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37379 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfD2JQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 05:16:28 -0400
Received: by mail-it1-f195.google.com with SMTP id r85so6477781itc.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kkTgXX5vsCulHRc2eoQk+Uf5xGoVoNrc9rDV51R24PY=;
        b=F94rOxL4x7d0JaPJfTgxamyoo2IFBaj8ni2EkbUf0JA1gK/59EzIs/P3v88TWCse0Y
         Ky+40GA4smQTvBOFIcYdpsLlSmdOqHdfVKacDlZC5fkaIL9O8KUK0nULawPWi2BsioeZ
         4+eQh8g5/Rhj+ciZmmqWH+WP4kVf9SU0uZlHPpivAMQ2HhlJU0Bhy5hCNcfdH9v17jRT
         7sNtq8i+ODv6A0w7ETWcPO8kxfjE/07wjDPzjMZKiePpieI6oOFvmjEv0QMTCvcRVCnc
         H3XS8+TQ5CaFhUdyIZ/HvMFW77HCmIuU+C+/fHIj0LVPYOxJkZVFhLqy5s6leAV/TEbe
         vgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kkTgXX5vsCulHRc2eoQk+Uf5xGoVoNrc9rDV51R24PY=;
        b=k7sRDtPsZ6jrNzPnVMMmbj5T4ixrLuGwpLxx79Tq8IM5X+Wpy/jpau45/0sCTTAPR3
         sIgUnITiB8OSERXMMLOwOcqHCD3psANbbI+wzbC19z51Ck0bFFHSKVtTIj1DaR1HEOX1
         U6ZhaccStO1UuE9Cm6ZFX5RQuo4kXFNETdDhnIEbl50VM37lQz/jdbu8WMgTW98Yi86u
         i+T4qXli3NjDb2aC6OcpPS5/fWsY+l9HYeWJn25+7sDcNSQtJRd+HS1zvPExCsqCFjmc
         ybPg+WXk6UYbbYmEti9w4iZjnNPnKKXe8A1zmYsEQEJnlEY6LCUly89DgpooBDAufb3a
         TDnA==
X-Gm-Message-State: APjAAAXHOAHVZVNQdw/fE3BLZir1znEqjtSVYsnc/M3HdcnFtGajZdu+
        iO8QT9Hu7D4pqrpalRbbRzththMfDA/R/kFjzG4=
X-Google-Smtp-Source: APXvYqzapt3dPiSh5sPF3AzmHOEhGKRShhtDtqpZT5ZYP+pTX8JFSbkqxcmXQwWH5l0GHXqkALLR3b1rtIIBG9jVWjg=
X-Received: by 2002:a24:5493:: with SMTP id t141mr15758616ita.10.1556529387846;
 Mon, 29 Apr 2019 02:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190321131655.15249-1-pclouds@gmail.com> <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-24-pclouds@gmail.com> <78c7c281-82ec-2ba9-a607-dd2ecba54945@gmail.com>
In-Reply-To: <78c7c281-82ec-2ba9-a607-dd2ecba54945@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Apr 2019 16:16:01 +0700
Message-ID: <CACsJy8ASYRwUGV8VnVKLhBqdv9V+UTAhb6U3+4BUjJFnJ+2Viw@mail.gmail.com>
Subject: Re: [PATCH v6 23/27] switch: reject if some operation is in progress
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 5:33 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> On 29/03/2019 10:39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > Unless you know what you're doing, switching to another branch to do
> > something then switching back could be confusing. Worse, you may even
> > forget that you're in the middle of something. By the time you realize,
> > you may have done a ton of work and it gets harder to go back.
> >
> > A new option --ignore-in-progress was considered but dropped because it
> > was not exactly clear what should happen. Sometimes you can switch away
> > and get back safely and resume the operation. Sometimes not. And the
> > git-checkout behavior is automatically clear merge/revert/cherry-pick,
> > which makes it a bit even more confusing [1].
> >
> > We may revisit and add this option in the future. But for now play it
> > safe and not allow it (you can't even skip this check with --force).
>
> I think this is a good compromise, lets see how it goes (I think I
> broadly agree with Elijah's suggestion to allow the switch if we can
> safely switch back again if we want to add --ignore-in-progress in the
> future).

I probably will revisit this topic much sooner than I thought. I did a
bisect today and found out "git switch" would not let me choose some
"random" commit to test, which I suspected more likely where the
problem was, or at least helped reduce the bisect steps. I had to go
back to "git checkout" and was not so happy.

This probably falls under the "safe to switch" (and not even back)
category, as long as switching does not destroy any data, since bisect
is basically jumping between commits with a clean worktree/index until
you find the right one.

> > +static void die_if_some_operation_in_progress(void)
> > +{
> > +     struct wt_status_state state;
> > +
> > +     memset(&state, 0, sizeof(state));
> > +     wt_status_get_state(the_repository, &state, 0);
> > +
> > +     if (state.merge_in_progress)
> > +             die(_("cannot switch branch while merging\n"
> > +                   "Consider \"git merge --quit\" "
> > +                   "or \"git worktree add\"."));
>
> I'm not sure merge --quit exists, 'git grep \"quit origin/pu' shows
> matches for builtin/{am.c,rebase.c,revert.c}. The --quit option for the
> sequencer command does not touch the index or working tree (that's the
> difference between --quit and --abort) so the switch can still fail due
> changes in the index and worktree that would be overwritten by the switch=
.

Eck! Let me check if --abort is the same thing there or we need to add --qu=
it...
--=20
Duy
