Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F2C433E9
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE5E64E33
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhAaUNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhAaTfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 14:35:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED08CC061225
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 10:49:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id df22so442924edb.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzb5Rd4otDji3CVRtFiO6GeDTbZJpkdAHsQc/YDMB9s=;
        b=MA448glZZf0Hc1PKzBAIeNwg7hac/6KqGgwxmQV4Drv70lAyKRDhRyrCj6L0+CzYNo
         3SD34EHLGTF2IX1uh94jX7GjPgDJhbZvd3X9/8TfAUzn0qVU1ZNTDm7dMgpf9stdaG+m
         EqhtqRAi1nQcwMAsdyp2SoW0hBRKs931Ci856vmgmDMxjqu3eDNIphlAyziSmFplZcaI
         TcMf1wJynJxl0SYRmxk8gwVz8PpbwpNuiAJ4t9/2Av4o0IiKEm+e8cvh191qpTU1CjI8
         FbJ83IQ0al8kNwLcG60fg34LpcpMuMAM2J0zDmMDd1Gad3bRLZhbCyjIF0LrSPB6iut3
         rMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzb5Rd4otDji3CVRtFiO6GeDTbZJpkdAHsQc/YDMB9s=;
        b=GelnbGWvMSbLrXwP/STvFOaTNZir9Nyv4ShcLNaLE6YM32lKYSe0aHpHJDrfeIDWgD
         ZJ+5C6qPlZqtd5QbP1sMLInym33DzqEwtyo53s5snA75MC8VzQccfIh+XCJYPmUdR28m
         bocdVHpOyNRzfmmVn9VphsZVOgW/WQlL3Z2+QqArzpP/T3wRTRuhDvU/h3w+A6o9wVHZ
         rLeGbj6Z+pXOLeUvgiL70RzaQv55ts8NvP/KottBHu9g1LJbDHtCVF5AUeo1WyFIj5r8
         LGEU86PKN2SxUpfPToh753li5uVSz5mRWxdt2ohPhoWrgsBMUB1TPz7U3tZ5R2J7hjgv
         9TFQ==
X-Gm-Message-State: AOAM531S28Ki3lLEueE/Tw51ObwTFThSjl9up/WdQhpuY55EhAScmXn6
        Dv8wZ2ZD5EcOR4k/jcnOrrPypiCFTGWPpHT+qcM=
X-Google-Smtp-Source: ABdhPJxQwtbCbamNAjhEARVNm1d77P40KmzbMMoKiI3UVdYXK7acoBLY1XJbcYgsnVA5NGYjRW1Aky98sxo/JT3Lkmc=
X-Received: by 2002:a05:6402:134b:: with SMTP id y11mr15127971edw.88.1612118979357;
 Sun, 31 Jan 2021 10:49:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.854.git.1612021544723.gitgitgadget@gmail.com> <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com>
In-Reply-To: <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com>
From:   Lance Ward <ljward10@gmail.com>
Date:   Sun, 31 Jan 2021 12:49:27 -0600
Message-ID: <CACPHW2X2UGAVmNM+cHXs6dwVfZbgLFZ0iUGU89h04H5czAt1Ww@mail.gmail.com>
Subject: Re: [PATCH] status: learn --color for piping colored output
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Thank you for the comments!  I made all your suggested changes, except
for one which I wanted to provide more context on and ask a question
about before proceeding.  Please see my responses below.

On Sun, Jan 31, 2021 at 1:31 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Jan 30, 2021 at 10:51 AM Lance Ward via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Many users like to pipe colored results of git status to other commands
> > such as more or less, but by default colors are lost when piping without
> > changing the user's git configuration.  Many other commands such as diff,
> > show, log and grep have a --color option to easily override this behavior.
> > This allows the status command to have a similar --color option providing
> > a simpler mechanism for temporarily forcing piped colored output.
>
> Thanks, makes sense.
>
> > Signed-off-by: Lance Ward <ljward10@gmail.com>
> > ---
> >  builtin/commit.c             |  7 ++++
> >  diff.c                       |  5 +++
> >  diff.h                       |  1 +
> >  t/t7527-status-color-pipe.sh | 69 ++++++++++++++++++++++++++++++++++++
>
> As this is introducing a new --color option to `git status`, it should
> be accompanied by an update to Documentation/git-status.txt.

I've added the option to the documentation.

>
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > @@ -1410,6 +1412,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
> > +       if (use_color != GIT_COLOR_AUTO) {
> > +               s.use_color=use_color;
> > +               set_diff_color(use_color);
> > +       }
> > diff --git a/diff.c b/diff.c
> > @@ -261,6 +261,11 @@ void init_diff_ui_defaults(void)
> > +void set_diff_color(int use_color)
> > +{
> > +       diff_use_color_default = use_color;
> > +}
> > diff --git a/diff.h b/diff.h
> > @@ -501,6 +501,7 @@ int parse_long_opt(const char *opt, const char **argv,
> > +void set_diff_color(int use_color);
>
> This new API for setting `diff_use_color_default` feels a bit too
> quick-and-dirty and assumes that the caller has intimate knowledge
> about when it is safe/correct to call the new function. Did you
> consider the alternate approach of having wt-status functionality set
> the appropriate diff_options.use_color value at the time it drives the
> diff machinery? For instance, as a test, I added:
>
>     rev.diffopt.use_color = s->use_color;
>
> to the functions wt-status.c:wt_status_collect_changes_worktree(),
> wt_status_collect_changes_index(), and wt_longstatus_print_verbose(),
> so that the `use_color` value from the `struct wt_status *` supplied
> by commit.c:cmd_status() is automatically applied to the diff options.
>
> (Note that this was just a quick test. I dug through the code just
> enough to locate these functions as the likely correct place to set
> diff_options.use_color, but didn't spend any time verifying that all
> three functions need to be patched like this. I also didn't verify
> that my changes won't stomp on --porcelain's explicit disabling of
> color, which is something that ought to be checked. There's also some
> custom `use_color` handling going on in wt_longstatus_print_verbose()
> of which to be aware.)

I can understand how this may look "quick-and-dirty", but it was actually
my intent to create a function which assumes that the caller has intimate
knowledge about when it is safe/correct.  I will try to explain why.

Originally I tried to use what I thought would be a much more appropriate
method which is to simply let the --color flag set things the same way
as the config option status.color=always does, but I noticed it does
not work the same when piped.

For example the following produces full color output:
git -c status.color=always status -v

However, running this colors only the status, not the diff:
git -c status.color=always status -v | cat

Right now I can only get what I expect by running:
git -c status.color=always -c diff.color=always status -v | cat

This appeared to me to be inconsistent behaviour and lead me down
a path trying to figure out where the color was being disabled which
made me realize that the status command shares code paths with
the commit message and porcelain output.  I wanted to be very
careful not to do anything which might break either of these in some
unforeseen way which is why I created the function.

I changed the function name and added a comment to make it clear
that its usage is a special case which may have undesired
consequences if not used appropriately.

If you feel existing unit tests would mitigate any issues with commit
messages and porcelain output I can try going the route you
suggested instead?

Also if you agree the behavior of status.color should be the same for
both piped and not piped output I could add that to this patch as well?

>
> > diff --git a/t/t7527-status-color-pipe.sh b/t/t7527-status-color-pipe.sh
> > @@ -0,0 +1,69 @@
> > +# Normal git status does not pipe colors
> > +test_expect_success 'git status' '
> > +       git status >out &&
> > +       test_i18ngrep "original$" out
> > +'
>
> None of the text being checked by any of the tests being added by this
> file is subject to localization, so use of test_i18ngrep() is
> unwarranted. Use plain old `grep` instead here and elsewhere.

I made these changes.

>
> > +# Test new color option with never (expect same as above)
> > +test_expect_success 'git status --color=never' '
> > +       git status --color=never >out &&
> > +       test_i18ngrep "original$" out
> > +'
> > +
> > +# Test new color (default is always)
> > +test_expect_success 'git status --color' '
> > +       git status --color |
> > +       test_decode_color >out &&
> > +       test_i18ngrep "original<RESET>$" out
> > +'
>
> If someone introduces a bug which causes the non-colored tests to
> incorrectly emit color codes, then it will be easier to debug the
> problem if you also pass the output through test_decode_color() even
> for the non-colored tests rather than only for the expect-colored
> tests. Thus, I'd recommend calling test_decode_color() in all the
> tests, even if you don't expect color to be emitted.
>
> Also, these days, we don't normally place a Git command upstream in a
> pipe since its exit code will be lost. Instead, we capture the output
> to a file:
>
>     git status --color >raw &&
>     test_decode_color <raw >out &&
>     ...

I made both these changes also.

>
> > +test_done
> > +# Test verbose --color=always
> > +test_expect_success 'git status -v --color=always' '
> > +       git status -v --color=always |
> > +       test_decode_color >out &&
> > +       test_i18ngrep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
> > +       test_i18ngrep "GREEN>+<RESET><GREEN>1<RESET>" out
> > +'
> > +
> > +test_done
>
> You have one too many calls to test_done() in this fragment. I think
> you only want to keep the final test_done() and remove the one prior
> to the last test.

You are correct, thanks for catching this.
