Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F75C2D0EE
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9637220714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EklAIp9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCZVSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:18:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35129 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCZVSw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:18:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id t25so6954381oij.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPPmKc/Fbv141yClgWQDp3sqRQeMT5KVS1UvQQm9pY0=;
        b=EklAIp9r5+OwzcMFRDCPiqeW3k5hVOyJvmDxuyJMiebLMbUKnx/s8Ayc/8YGkvbNvQ
         m9kbkK8DpgAZxXVVtoBOywWz4xI2xWTxaYU83R7Y03bjjjyKIM4MEMnEYdPsggLFZo8V
         vTSHOQg6cR+o9k+zM0SGeq2uLAh3lxLIog5CkallvnLGI9h/oeUKHJBJLV0FUe3Qg9M9
         DT4ELjM2xlVOyf69ke3P2vgfjR72LDVBDqq3lzyb7HuowPAIP+AFyNW8BOxNaUrOWUS+
         Cs8uWXajcAoKZ0AKXJri99+x2Gra44Nsz8XZv474fb2kGalmRl5haoXcop8DkoXZSh6a
         ShnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPPmKc/Fbv141yClgWQDp3sqRQeMT5KVS1UvQQm9pY0=;
        b=eQ5Q+H2iWhMth9unB/2s1ECGkxlLm6oLb0dpqI3lAzC5nujuHGhD92Em95wgCkca8z
         OMPt4TQtVR+PPNJbny3UEA4PQbAI8sFaDArhRY5XkRWWt05JQ/SMf+Ju3YD0KAbRdHLx
         E2Se7ustiGtONjyjgUcHdKuDQuOABCZng9+zT6WtYaWR6IOwRXQTPbggdJNw82k09d86
         A+97ZoZomrPWI9NPIVujmIlSaVJejaN/AR9JNNL2a2pV4nKIKE0Cv4ehGed9vhQE6l7s
         wxoc6pdoDJi8jwOIp4QAwFl2aBRXOaat8Zn7JEKtLi/X79YkF9NUpqD17YpS6hjJXnaJ
         6cyA==
X-Gm-Message-State: ANhLgQ1NRDhU4tOjZigJwteYbg3X8WiPHPDYgz3XqE5PLN8Fguuep/9l
        PwgftF+zS7S1dbU0SMZjxVGpzYE08ODWBCxluACqqr2f
X-Google-Smtp-Source: ADFU+vsrKYWruogOq4kL71QZwC1oNpaGHdnNLwID+wEHyCZkz6bfCS3VzmvOnXlb+QLvgX3i8gRyIvN2Q94llevRL70=
X-Received: by 2002:aca:db08:: with SMTP id s8mr1843016oig.167.1585257531484;
 Thu, 26 Mar 2020 14:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
 <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com> <d4fe5d335771e89dad40f717bf4623854d1efa9e.1585164718.git.gitgitgadget@gmail.com>
 <7ba7311c-08b8-8383-0281-79e58798e0be@gmail.com>
In-Reply-To: <7ba7311c-08b8-8383-0281-79e58798e0be@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Mar 2020 14:18:39 -0700
Message-ID: <CABPp-BEWhavmtDi-ahT+QMWtD6Fe-Ey7cn_82nbetWEQJL=hRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] t7063: correct broken test expectation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 6:02 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/25/2020 3:31 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The untracked cache is caching wrong information, resulting in commands
> > like `git status --porcelain` producing erroneous answers.  The tests in
> > t7063 actually have a wide enough test to catch a relevant case, in
> > particular surrounding the directory 'dthree/', but it appears the
> > answers were not checked quite closely enough and the tests were coded
> > with the wrong expectation.  Once the wrong info got into the cache in
> > an early test, since later tests built on it, many others have a wrong
> > expectation as well.  This affects just over a third of the tests in
> > t7063.
>
> Wow. Good find.

or maybe not...

> > The error can be seen starting at t7063.12 (the first one switched from
> > expect_success to expect_failure in this patch).  That test runs in a
> > directory with the following files present:
> >   done/one
> >   dthree/three
> >   dtwo/two
> >   four
> >   .gitignore
> >   one
> >   three
> >   two
> >
> > Of those files, the following files are tracked:
> >   done/one
> >   one
> >   two
> >
> > and the contents of .gitignore are:
> >   four
> >
> > and the contents of .git/info/exclude are:
> >   three
> >
> > And there is no core.excludesfile.  Therefore, the following should be
> > untracked:
> >   .gitignore
> >   dthree/
> >   dtwo/
> > Indeed, these three paths are reported if you run
> >   git ls-files -o --directory --exclude-standard
> > within this directory.  However, 'git status --porcelain' was reporting
> > for this test:
> >   A  done/one
> >   A  one
> >   A  two
> >   ?? .gitignore
> >   ?? dtwo/
> > which was clearly wrong -- dthree/ should also be listed as untracked.
> > This appears to have been broken since the test was introduced with
> > commit a3ddcefd97 ("t7063: tests for untracked cache", 2015-03-08).
> > Correct the test to expect the right output, marking the test as failed
> > for now.  Make the same change throughout the remainder of the testsuite
> > to reflect that dthree/ remains an untracked directory throughout and
> > should be recognized as such.
>
> I wonder if we could simultaneously verify these "expected" results match
> using another command without the untracked cache? It's good that we have
> the expected outputs explicitly, but perhaps double-checking the command
> with `-c core.untrackedCache=false` would help us know these are the correct
> expected outputs?

This was an *awesome* idea, even if the implementation doesn't quite
work.  It turns out that -c core.untrackedCache=false does not
instruct status to ignore the untracked cache, it instructs status to
delete it. Since we had subsequent tests that depended on the
untrackedCache created in previous tests, this would break a number of
tests.  But I can introduce a helper to workaround that:

# Ignore_Untracked_Cache, abbreviated to 3 letters because then people can
# compare commands side-by-side, e.g.
#    iuc status --porcelain >expect &&
#    git status --porcelain >actual &&
#    test_cmp expect actual
iuc() {
        git ls-files -s >../current-index-entries
        git ls-files -t | grep ^S | sed -e s/^S.// >../current-sparse-entries

        GIT_INDEX_FILE=.git/tmp_index
        export GIT_INDEX_FILE
        git update-index --index-info <../current-index-entries
        git update-index --skip-worktree $(cat ../current-sparse-entries)

        git -c core.untrackedCache=false "$@"
        ret=$?

        rm ../current-index-entries
        rm $GIT_INDEX_FILE
        unset GIT_INDEX_FILE

        return $ret
}


Doing that helped me discover that the test didn't have a wrong
expectation; I did.  When a directory that is not tracked is filled
entirely with files that are ignored, then status --porcelain treats
the directory itself as ignored...and thus doesn't display it.  (`git
status --porcelain --ignored` will show it).  I had seen that
somewhere, but hadn't fully understood the check_only and
stop_at_first_file pieces related to it.  Anyway, with this helpful
hint:

  * I can say that there was not a bug in the untracked cache (at
least not any that I'm aware of)
  * I can update my first patch to do more thorough checking instead
of changing the expectation
  * I found the bug in my final patch that had been evading me
  * I added a huge comment explaining check_only and
stop_at_first_file, how they're used, and what they mean for the
future reader
  * I also no longer need to partially disable the untracked cache in
my changes.

New patches incoming...
