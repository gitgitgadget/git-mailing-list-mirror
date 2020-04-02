Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B255C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B2A2078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiSeaF7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389987AbgDBRBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:01:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33842 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732625AbgDBRBr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:01:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id m2so4220567otr.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khKqxa+hyahdtqIdXiBT5otxi+swTRV5jgRsP6VbbSA=;
        b=CiSeaF7D50CUngfrCgnZcpiYw47ylnCzN0QJV2jV5bMNw6Xs2k05Sxpkz2lUPiNcFS
         LZzwJ9fh+AhpSSrePXa+SgYhwJb07X9Ta+7swrErn5ctHlgvKJMxLt1RP3zCkuX9rrsZ
         tnGtdAPLq1qzjB/GZruZy4pRR0Kc+mIZhyCY91ZOMrIkOVs5iEZk40NFk8zLmjUfpTVD
         RxugjRV/idkHuL8hTXlsLAF8UW3zL4LuIQwRSWmaPRdssroDmmG4vl9Yh9ptKylOcEKM
         jxBD1oymYUBfelxZQMW7a1E9JSdGfBq3naVDqVIf/xWN+S9oujdjXCK6EctXimJRo8mD
         t/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khKqxa+hyahdtqIdXiBT5otxi+swTRV5jgRsP6VbbSA=;
        b=ZOVU685JqblTdiiW8tt3u4p55MiWrv0cIBoEEXOv9wO5oilqI5jb6CZzjvp1UaYhil
         I1TyixPzo5sOAsupHoawiMhMPW6JONoMnxwa+ksK6JoSvLSFXOXoFBnjAvSNJmeSkZtM
         S2EdK/hbk39aXx6Uv4X5xmHvhAy5SMy2jUcC+xykZnPg8Xp+gfxlkXQ0BbR25rkO3Zeu
         yLjfFGRdEcppPeiw2iBt//ij58hSzzoCywHmVWbCTwA5Slsra1hJfxL3FL+HD/6x8UGI
         DHSYQlJcaBnG9oeshZar2KMWhx1lwIWO0fV5F86WL0BvNDjHjWVAB9Q3H8XfnwFucjzn
         EmtQ==
X-Gm-Message-State: AGi0Pua+UaER5ZQd3cd+0mgLVHx21YIxEPOVEn9YpLyx5+XZPFKnn8sk
        jH2HgbMHiFClYXreCfuyYZu9K0AFOUZmR9+EQRY=
X-Google-Smtp-Source: APiQypKxmMaj3NAi00GAC3niLag+Cf6RqZpCPdWoN8A3LHFVT3lSBGe4uOW0jOs+Qg3+ulRA5MGldySLBjLC72vZNOE=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr3264837oti.162.1585846905169;
 Thu, 02 Apr 2020 10:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com> <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com>
In-Reply-To: <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Apr 2020 10:01:34 -0700
Message-ID: <CABPp-BE_mimSRg5wf0Yzn2s-dX=64ZS1jGszqwHzr3aju0bj=A@mail.gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, Apr 2, 2020 at 2:25 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> Thanks for fixing this
>
> On 01/04/2020 21:31, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > There is a lot of code to honor GIT_REFLOG_ACTION throughout git,
> > including some in sequencer.c; unfortunately, reflog_message() and its
> > callers ignored it.  Instruct reflog_message() to check the existing
> > environment variable, and use it when present as an override to
> > action_name().
> >
> > Also restructure pick_commits() to only temporarily modify
> > GIT_REFLOG_ACTION for a short duration and then restore the old value,
> > so that when we do this setting within a loop we do not keep adding "
> > (pick)" substrings and end up with a reflog message of the form
> >      rebase (pick) (pick) (pick) (finish): returning to refs/heads/master
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >      sequencer: honor GIT_REFLOG_ACTION
> >
> >      I'm not the best with getenv/setenv. The xstrdup() wrapping is
> >      apparently necessary on mac and bsd. The xstrdup seems like it leaves us
> >      with a memory leak, but since setenv(3) says to not alter or free it, I
> >      think it's right. Anyone have any alternative suggestions?
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-746%2Fnewren%2Fhonor-reflog-action-in-sequencer-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-746/newren/honor-reflog-action-in-sequencer-v1
> > Pull-Request: https://github.com/git/git/pull/746
> >
> >   sequencer.c               |  9 +++++++--
> >   t/t3406-rebase-message.sh | 16 ++++++++--------
> >   2 files changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index e528225e787..5837fdaabbe 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3708,10 +3708,11 @@ static const char *reflog_message(struct replay_opts *opts,
> >   {
> >       va_list ap;
> >       static struct strbuf buf = STRBUF_INIT;
> > +     char *reflog_action = getenv("GIT_REFLOG_ACTION");
>
> Minor nit - you're using a string here rather that the pre-processor
> constant that is used below

Yeah, true.  However, using a mixture of both styles is consistent
with the current code's inconsistency about which one should be used.
:-)

> >       va_start(ap, fmt);
> >       strbuf_reset(&buf);
> > -     strbuf_addstr(&buf, action_name(opts));
> > +     strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
> >       if (sub_action)
> >               strbuf_addf(&buf, " (%s)", sub_action);
> >       if (fmt) {
> > @@ -3799,8 +3800,10 @@ static int pick_commits(struct repository *r,
> >                       struct replay_opts *opts)
> >   {
> >       int res = 0, reschedule = 0;
> > +     char *prev_reflog_action;
> >
> >       setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> > +     prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
>
> I'm confused as to why saving the environment variable immediately after
> setting it works but the test shows it does - why doesn't this clobber
> the value of GIT_REFLOG_ACTION set by the user?

The third parameter, 0, means only set the environment variable if
it's not already set.
