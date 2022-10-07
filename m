Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46813C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 02:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJGC4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 22:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGC42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 22:56:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71CFE750
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 19:56:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q7so1793012ljp.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEZcGvZ6TKct1JDwxz3jXdnoNPqSQha5Og9t5G6w/2Y=;
        b=L+X5+ckx0Y0ONCD2aB9EJcTGljGZNL2j2u9C+FFfeQCFiLQhuFQhWtmom6vI7y2kjD
         tn1J61QbB1JbLVDB2HtAsbQkotxUmmnelDMaUw3HUWSCaQZsuryiCf+3lXyXuNoeYnYf
         sPP/DWuZj0spm02x74f5fU1576GWNVnRy2eqQb5HCvya2GPoIKPjQ6+wg6nW86TmXFDu
         aogDPEYdHAgeWVViT2rmFYlA5NEkVteGh9jYkbWIJMbmfnV6EnoNRqv/ol7xtypHkHbf
         jMMb33gUJhLgXgk4ot/m3OZngJCfDr/o3t9ZK7o9NYBZVGe+8RCF0h1W4Yidj6VGq6fz
         0Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEZcGvZ6TKct1JDwxz3jXdnoNPqSQha5Og9t5G6w/2Y=;
        b=WseBbRBRgRkfY8tceAT1TrkdRvSGdfXW/+N/SZ/TpFlYVRpFUyG+ZjH0aNrH9FiWfn
         sU//16Y0ofptyW1bHt3DB5Udujz4/jjzxttrHr/eU9sckq6nvAXvUFVm67ZzNtLc4SZJ
         S+si6a8hweUO9xoUmjqu89h9xAtHP6s0+3stovRPtlAlV2VZ/LKh1qQFMx0wTv7hIWJE
         pRuBgRSgZ8RR86BNhFMNWyqXzemHY9NLA14Nz1WYymYi7PT5FWHt7mrJ/cW7UYDh7Ph5
         Nf6j8sglug3jTVAz1nC7mKrVyl4CKwKy26QOaHLjOBMJMYnENhA3Wq4hIlw4HSnYd3Ow
         3Q7Q==
X-Gm-Message-State: ACrzQf03aCz6Iz7JI93mER7y836Wy42qK1o1eKRgi8kJho//7a5gV3sF
        5QXObNB895GtnLWn2W9YaofH17zr1+Ewf9nuP1k=
X-Google-Smtp-Source: AMsMyM4C0oKEkmGv/W83MtqKiO68wfG0B4Fe/fjvhQW5S3wV7U7OGh0J0UzHlNU/hkA1KRfT0IY7MdfgNaWGbDSoihY=
X-Received: by 2002:a2e:5d1:0:b0:26e:1d6:eb2f with SMTP id 200-20020a2e05d1000000b0026e01d6eb2fmr936634ljf.194.1665111384274;
 Thu, 06 Oct 2022 19:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com> <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
 <5d926706-6ca3-ce07-f8f2-771fe126450b@github.com> <CABPp-BGoJqtx_=p+GfqAhgs+4Zic1mcbs6pkMKy7QAnxTwB4AA@mail.gmail.com>
 <66eaae96-7b6a-ca87-fee5-e185a560744a@github.com>
In-Reply-To: <66eaae96-7b6a-ca87-fee5-e185a560744a@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Oct 2022 19:56:11 -0700
Message-ID: <CABPp-BGgmA9dPjkUjMa8LntWBz3g9ya7z00BBAn4Ja1EV3VVdQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2022 at 11:27 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 10/6/22 3:10 AM, Elijah Newren wrote:
> > On Wed, Sep 28, 2022 at 6:22 AM Derrick Stolee <derrickstolee@github.com> wrote:
> >>
> >> On 9/28/22 1:38 AM, Elijah Newren wrote:
[...]
> >> I'm specifically talking about 'git log'. I think that having that be
> >> in a restricted mode is extremely dangerous and will only confuse users.
> >> This includes 'git show' (with commit arguments) and 'git bisect', I
> >> think.
> >
> > Thanks, that helps me understand your position better.
> >
> > I'm curious if, due to the length of the document and this thread,
> > you're just skimming past the idea I mentioned of showing a warning at
> > the beginning of `diff`, `log`, or `show` output when restricting
> > based on config or defaults.  Without such a warning, I agree that
> > restricting might be confusing at times, but I think such a warning
> > may be sufficient to address the concerns around partial/incomplete
> > results.  The one command that this warning idea doesn't help with is
> > `grep` since it cannot safely be applied there, which potentially
> > leaves `grep` giving confusing results when users pass either
> > `--cached` or revisions, but you seem to not be concerned about that.
>
> I'm not convinced that warnings are enough for some cases

I'm not sure I'm following.  You suggested earlier in this thread that
we may want to provide a mode where commands "don't just fail if you
can't get new objects, instead inform me that the results are
incomplete".  You re-emphasized that in your most recent email by
saying "To be _absolutely sure_ that on-demand downloads don't happen,
we need an extra mode for Git and new ways of reporting partial
results."  So it sounds like you're suggesting a mode where partial
results are a forced option, because how else can you be "_absolutely
sure_ that on-demand downloads don't happen"?  And if we always want
to allow partial results, don't you need to inform users about those
results being potentially incomplete?  How exactly does one inform the
user that results are incomplete if not by a warning?  Something seems
inconsistent here, but perhaps I'm just misunderstanding something?

I think, based on what you said below, that you're uncomfortable with
certain types of incompleteness, such as partial revision results, but
are fine with others such as those dealing with partial blob results
(whether in breadth or in depth).  But if so, I'm still not sure what
your statement about warnings means.  If we scope operations down to
the sparsity paths (e.g. potentially giving a partial-breadth diff for
"git diff REV1 REV2"), what's your expectation with regards to
warnings?

>, especially
> for output that is fed to a pager. Do the warnings stick around in
> the pager? I'm not sure.

If the warning is printed on stdout, then yes the warning will stick
around in a pager.  If the warning is printed on stderr, then the
warning is likely of dubious utility since it can easily get lost.
Since log & diff output are not adversely affected by additional
preliminary output, I think stdout is where such a warning should go
(unless folks feel like we don't even need a warning?).  However, grep
would be strongly negatively affected by additional output, and that's
why I've stated several times that warnings cannot reasonably be
included with grep.

But, so far, no one has expressed concern with providing partial
results for grep even if no warning can be given, so perhaps it
doesn't matter.

> > I'm also curious if the problem partially stems from the fact that
> > with `git log` there is no way to control revision limiting and diff
> > generation paths independently.  If there was a way to make `git log
> > -p` continue showing the regular list of commits but restrict which
> > paths were shown in the diffs, and we made the --scope-sparse handling
> > do this so that only diffs were limited but not the revisions
> > traversed/printed, would that help address your concerns?
>
> My biggest issue is with the idea of simplifying the commit history
> based on the sparse-checkout path definitions. The '-p' option having
> a diff scoped to the sparse-checkout paths would be fine.

Wahoo!  Sounds like we have a path forward then.  I'll update the
document in my patch to reflect this distinction.

Note that it's not just the -p option to log, though, but anything
related to patches: diff formatting, diff filtering, rename & copy
detection, and pickaxe-related options.  The one place where the
scoping to sparse-checkouts is slightly funny for `git log` is with
--remerge-diff (because the merge machinery ignores sparsity patterns
when generating the new toplevel tree; however after the new toplevel
tree is generated, we would generate a diff that is limited to the
sparsity patterns).

[...]
> > Also, blame incorporates a component of changes from the worktree, but
> > it's mostly about history (and one or more -C's make it check other
> > paths as well).
>
> Since each input is a specific file path, I'm not sure we need
> anything here except perhaps a warning that they are requesting
> a file outside the sparse-checkout definition (if even that).

Your statement seems to suggest you are assuming that git blame will
only operate on the path listed on the command line.  Am I reading
your assumption correctly, or am I totally misunderstanding why you
would claim nothing is needed beyond a warning about the path the user
typed?  If I'm understanding your assumption correctly, your
assumption does not hold when one or more -C options are passed.
Since my earlier mentions of those options and their ramification
didn't connect, perhaps it would help if I was a bit more explicit
about what I mean.  Let's take a simple example, in git.git, which you
can run right now:

   git blame -C -C cache.h

This command will show lines of text that now appear in cache.h but
which came *from* all of these files:

    * builtin/clean.c
    * cache.h
    * merge-recursive.h
    * notes.c
    * object-file.c
    * object.h
    * read-cache.c
    * setup.c
    * sha1-file.c
    * sha1_file.c
    * sha1_name.c
    * show-diff.c
    * symlinks.c
    * tree-walk.h

In order to find out and report that the current lines of cache.h came
from these other files, blame has to search a wide range of other
files in the repository.  That potential wide range of other files in
the repository is something we could consider tailoring when in a
sparse-checkout, at least for Behavior A folks.

[...]
> I think the following things are true:
>
> 1. It's really important to keep the current partial clone default of
>    only downloading blobs on-demand. Even with a limited sparse-checkout,
>    it's rare that users will need every version of every file in that
>    sparse-checkout, and they may not want that tax on their local storage.

I do agree we need to keep these in mind for some usecases, but I do
not agree these are universally true among sparse-checkout users.
However, our differences on this probably don't matter in practice
since you then immediately suggested...

> 2. Adding an opt-in backfill for a sparse-checkout definition will
>    prevent most on-demand downloads (although it might want to be
>    integrated into 'git fetch' behind an option to be really sure that
>    state continues in the future).

Yes, this would be great.  One question, though: integrated with
`fetch` or with `sparse-checkout set|add`?  If users adjust their
sparse-checkout definition, that might be a good time to allow them to
automatically trigger fixing the missing backfill at the same time.

> 3. Updating Git features to scope down to sparse-checkout will prevent
>    many of the remaining on-demand downloads.

Yes, though I'd clarify "scope down to sparse-checkout where it can
make sense".  Things like merge & bundle have to pay attention to
changes outside the sparse-checkout, but we can get commands like
diff/log -p/grep to scope down in breadth.

> 4. To be _absolutely sure_ that on-demand downloads don't happen, we
>    need an extra mode for Git and new ways of reporting partial results.
>    Without this mode, Git commands fail when triggering an on-demand
>    download and the network is unavailable.

While many commands might be able to produce partial results
realistically, I think things like merge & bundle should not support
such a mode and just fail if they are missing any data they normally
need.  Basically, we'd still have commands that would fail without a
network connection beyond push/pull/fetch, but this mode would limit
the list as much as possible through allowing commands to limit both
breadth and depth of the blobs we act upon.

> So, I'm saying that (4) is a direction that we could go. It also seems
> extremely difficult to do, so we should do (2) & (3) first, which will
> get us 99% of the way there.

Agreed on all three counts.
