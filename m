Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE35EC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 02:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B1D610C9
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 02:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbhHZC0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 22:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhHZCZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 22:25:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B4C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 19:25:13 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z18so2836817ybg.8
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 19:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5n7AjO7L8Nujnewv+NHGsDJEOxJEYwqtlle/jee+lAc=;
        b=j2kj1AYvDaobsB0Z4y5Ep0s3pmP7lEajKvClXht0mlJ6pqrwnGlDPkv/bJsbohYQgE
         D2WE7V1HL6Smbcrbw68x4AJflBQm/V4C1xLcw+hYFt9EKF8fd9146xFs7Nq2Sb3yYMhD
         pha0BjAkGqKJjkDsI6ucWfxhUdaHhdjPbMsw0feX1RYlpwOaMV3tPXUWAVCIl9UaAH2F
         JyomT25y96Ss76z9Vaz1Qvni2ZaXwTM0+6r6sIKYGZnFsQlN38kT1YCEEa8Hpez8OADM
         z0Z+PS1oHMWrsZbao61/YpuQFBSG1jZ4SrQZpKrlZelFlGqBWUoXpEGuy9SzguXmwWN1
         ONLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5n7AjO7L8Nujnewv+NHGsDJEOxJEYwqtlle/jee+lAc=;
        b=YdEPX5FhQndjP5k+0+G69IhELGdixYl4StxjhiA4I5e6E11P5UIdV1MIhFydnFfUoe
         9+2Ikr75ccn8YO2w3QBHPE+qysdYF07iGPEbRNkv+4eDOF3CVzQmEJwOGv5Dl5FgiPof
         dmd5XNLzVALfStnUOGffqMU7X6zYvcC9bNvz7q2RoGnR1nASiJq31E40STHEkADayHz5
         BYXoofAkeFvz1AyZeP3dmhZ/wI2kw20QZT9bwPaUFhavEdIBfA0Eej+BuVBdRqHi+qsQ
         TjAgbYGFw5jKDl1Vt/xqJG9CL641rm4OfnbJSkuR+EwM+wfroZLom8ibLbJKgI0NrW+1
         6y2w==
X-Gm-Message-State: AOAM532mnqozrNsplXwDHNOJ8Qvl7iZJvSizEHY0+/Z8gqy016wP9uFG
        frAdwOPGnHXZW8ZNgStRom6a5Bx5B+YBZ5ebKZA=
X-Google-Smtp-Source: ABdhPJwAKRgXBuGNnqpc5p0NjzIorNzU55p7slzugCoUnIKhU3/CUCqRvm4/Ec+kLA7I4/ywlgGigp9sRpxpxfpZ1u0=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr2150514ybk.403.1629944712446;
 Wed, 25 Aug 2021 19:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <20210822161325.22038-2-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
 <CANYiYbE6=+jbhea71r7Swqc012EOpaNiRequTeZQqfWnnB8gNw@mail.gmail.com> <nycvar.QRO.7.76.6.2108251316540.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108251316540.55@tvgsbejvaqbjf.bet>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 26 Aug 2021 10:25:01 +0800
Message-ID: <CANYiYbG7VD5SQuSiO9pAf2YEgC5X8dOczJKunTbBoxvkfGGVrA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Aug 25, 2021 at 8:14 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > Yes, this is a solution I also want to try at the very beginning. But
> > some l10n team leaders may fork their repositories directly from
> > git/git, and name their repo as "{OWNER}/git".  I want to try another
> > solution: check existence of file "ci/config/allow-l10n" in branch
> > "ci-config" using a GitHub API, instead of cloning the ci-config
> > branch and execute the shell script "ci/config/allow-l10n".
>
> I understood that you were trying to imitate what git/git does.
>
> The problem, in git/git as well as in your patch, is that this is highly
> cumbersome to use. Yes, it would be better if there was an easier UI to do
> what you want to do, but the current reality is: there isn't.
>
> The main reason why it is so cumbersome to use is that your chosen
> strategy scatters the CI configuration so much that it puts a mental
> burden on the users. I, for one, have no idea what is currently in my
> `ci-config` branch. And new users will be forced to struggle to set up
> their fork in such a way that the configuration does what they want it to
> do.
>
> And in this instance, there is not even any good reason to make it hard on
> the users because most will likely not need that new workflow at all. That
> workflow is primarily interesting for the l10n maintainers.
>
> To make it easier on the vast majority of contributors, I therefore
> suggested to introduce an easy-to-parse condition that lives not only in
> the same branch but in the very same file as the workflow _and_ it does
> what most users need it to do: cognitive burden penalty averted!
>
> Even better: the condition I suggested can be _easily_ extended by the few
> l10n maintainers to include their particular for as target repository.
>

I agree with you that the "ci-config" job is cumbersome to use, and I
will follow your suggestions. I may also want to try to implement a
github action later to check the existence of a file in a branch using
GitHub API as an supplementary way.

> > > A couple more questions/suggestions are below:
> > >
> > > > +  git-po-helper:
> > > > +    needs: ci-config
> > > > +    if: needs.ci-config.outputs.enabled == 'yes'
> > > > +    runs-on: ubuntu-latest
> > > > +    steps:
> > > > +    - uses: actions/checkout@v2
> > > > +      with:
> > > > +        fetch-depth: '0'
> > >
> > > There is code below to specifically fetch the base commit, but setting the
> > > `fetch-depth` to zero means to do a full clone anyway.
> > >
> > > So maybe the `git fetch` code below should be dropped, or the
> > > `fetch-depth` override?
> > >
> > > Since we cannot know how deep we need to fetch, though, I figure that it
> > > would be indeed better to have a non-shallow clone (and a code comment
> > > would help clarify this).
> >
> > If we want do a shallow clone, maybe we can try like this:
> >
> > 1.  Make 'git-po-helper' works with a bare repository, so the initial clone
> >     can be a shallow bare repository without checkout.
> > 2.  Will get two revisions, base and head revision, when the workflow is
> >     triggered. (In patch v1, base and head revision are named as
> >     commit_from and commit_to)
> > 3. Fetch the base revision and head revision using command:
> >     git fetch origin --depth=100 <base> <head>
> >
> > We used a fixed depth 100, because we don't know how many commits
> > these two revisions are diverged.

Wrong tense.  My English! :sweat:
s/We used a fixed depth 100/I plan to use a fixed depth of 100/

>
> Okay, but you did not use a fixed depth 100: you used depth 0, which turns
> off shallow clones in actions/checkout.
>

>
> If you truly want to optimize the fetch (which I don't think is worth the
> effort, as I mentioned above), you could also start with a shallow clone,
> then call
>
>         git config remote.origin.promisor true
>         git config remote.origin.partialCloneFilter blob:none
>         rm .git/shallow
>
> Subsequent Git operations should transparently fetch whatever is missing.
>
> But again, this strikes me as seriously premature optimization.

I like this. Will try.

And I wonder it would be better if the action "actions/checkout" can
support "fetch-depth: -1". Which means it does not do fetch at all,
but only sets the correct ssh_key and auth token.

> > The action "mshick/add-pr-comment@v1" needs this token. See:
> > https://github.com/mshick/add-pr-comment .
>
> Yes, I am fully aware.
>
> What I tried to point out is that the `GITHUB_TOKEN` you receive _may_
> have write permissions (it used to be the default), but these days you can
> configure it to be read-only, as a repository admin. For details, see
> https://github.blog/changelog/2021-04-20-github-actions-control-permissions-for-github_token/#setting-the-default-permissions-for-the-organization-or-repository
>
> If GITHUB_TOKEN is configured to be read-only (which I, for one, do with
> all repositories I can, for security reasons), then `add-pr-comment` might
> fail.
>
> This was the case for the `check-whitespace` workflow on
> git-for-windows/git, which is why I fixed that workflow in cc00362125c
> (ci(check-whitespace): stop requiring a read/write token, 2021-07-14).
>
> It would not make sense to re-introduce the same issue in a new workflow.

I understand your concern.  I will setup read only permission for
github action for the repo.

> > > Instead, it would probably make more sense to keep the output in the logs
> > > of the workflow run.
> >
> > You can see this nice post from ecco:
> > https://github.community/t/github-actions-are-severely-limited-on-prs/18179
>
> Oh, I am aware of the problem. Probably a lot more than you think I am.
> After all, I introduced the Azure Pipeline definition which offered not
> only a very convenient way to get to the logs of failed test cases, but
> also had statistics on flaky tests, and allowed monitoring all kinds of
> insights.
>
> And GitHub workflows have none of that.
>
> At least at the moment. If you want to investigate a test failure, you
> have to open the failed run, but that won't get you to the right spot yet.
> Instead, it opens the log of the `prove` run, which only tells you which
> test script(s) failed.
>
> What you _then_ have to do is to expand the `ci/print-test-failures.sh`
> step (which _succeeded_ and hence it is not expanded by default) and then
> you have to click on the magnifying glass symbol (i.e. _not_ use your
> browser's "Find" functionality, that won't work) and search for "not ok"
> and then skim over all `# known breakage` entries.
>
> So yes, I do know about the (current) limitations of the GitHub workflows
> UI ;-)
>
> > For a successful git-l10n workflow, there are no errors, but may have
> > warnings for possible typos found in a ".po" file.  There may be lots
> > of false positives in these warnings.  If I hide these warnings in the
> > log of a workflow, git-l10n contributors may not notice them. So I
> > need a way to create comments in pull requests.
>
> Or the workflow runs need to fail, and PRs need to require those runs to
> pass.
>
> > See some typical code reviews for git-l10n:
> >
> > * https://github.com/git-l10n/git-po/pull/541
> > * https://github.com/git-l10n/git-po/pull/555
>
> Thank you for linking those! Now that you said it, I thought about a
> different strategy we're using in the Git for Windows project (where we
> have a scheduled workflow that monitors a few of the 150 components
> bundled in Git for Windows' installer, to get notified if there are new
> versions, and the workflow needs write permission in order to open new
> tickets). We use an environment secret (and environments can be limited
> appropriately, e.g. by requiring approvals from a specific team). For
> details, see
> https://github.com/git-for-windows/git/commit/1abb4477f462c3d155ec68d40c961a5e0604ddf8
>
> I could imagine that you could make your workflow contingent on the
> presence of, say, `GIT_PO_HELPER_GITHUB_TOKEN`. That would not only solve
> the "read-only token" problem but also the "don't run everywhere, please!"
> problem. You (and other l10n maintainers) only have to create a Personal
> Access Token with `repo` permission and add it as a secret.
>
> But ideally, you would test whether an environment of a given name exists,
> and I am not aware if such a thing is possible yet with GitHub workflows.
>
> Food for thought?

To make it simple, I want to limit the permissions of the token in
"l10n.yml' and use the default `GITHUB_TOKEN`. like this:

          git-po-helper:
            needs: l10n-config
            if: needs.l10n-config.outputs.enabled == 'yes'
            runs-on: ubuntu-latest
    +       permissions:
    +          pull-requests: write
            steps:

It can work even if the administrator turns off
'read-write-permission' for action of the repository.

--
Regards,
Jiang Xin
