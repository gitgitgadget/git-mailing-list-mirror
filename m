Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F26C18E5B
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B120753
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knaTU9Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbgCPTYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:24:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40723 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbgCPTYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 15:24:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id h17so463977otn.7
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkcEPrrYVWkXExZJFZ9Sx+fUKKqieNxFHZM+u4n01/Q=;
        b=knaTU9YcLksS+DgsZhpjCbkZcG6a5M8nLaruU86sZCuy05+4hGyZe6EDJP4MfLylzd
         5TjSqzKGRSd/zYvZXMGgn61+OlNskrCYrdrzJGcosDRvSmxvfXTJFONxN2YHR/zWIosJ
         Mg8luCfa2c+EFrnbL0euejjWEJC0MTQEoDsaKyqdjjEl//O+1NB6f3voeAktFYAqJ15e
         2tb18721raYBYgEUEUiI9OkOI/8B8RjSoZXXVWWUKCcTmv6sN/o+r7del/hnXiZnsJSj
         A+bk2vIEpjX/BoXPU6ObYapNZeAkb2EGi/MjAj31rmo11bAZlpQwC2Gy+AGkueSl5idM
         rwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkcEPrrYVWkXExZJFZ9Sx+fUKKqieNxFHZM+u4n01/Q=;
        b=QTVux1Xasvv4hs+EVUbOqy9i9M88yS03KWmiBnXpk7vqZEYd6qW4DNa6SttlEiRbk4
         5jPqrYtNwafGDJq9gfORA+Wq5wCYQGlDpyw4PUy1RgGdS7srObK2E5QxexePzC8WGgMm
         p9nXtkgGGR7myX+BdH/MBWTwNEKLZnMET1OBsAkWw9ccQbkE3amsQTUkWvfiISVpEKtQ
         TN3wYh7yFiv5wC+a+SZFLbhBGjXJLgcsjSYy/MqYb9ZEIc6UbFn/n8McABZ1eK1as4wQ
         9a4HPl+gdSq28eZfA9NbqR/is5nBiIDl1yab+1LkgWxCM9ERDAR5wc9hJzPsh+scXFXg
         MbfA==
X-Gm-Message-State: ANhLgQ2OFbiOEQ1bf2AHNXqbzs3ILZWh2VpVBC7h05ceLKLKFIRojEb4
        k11sss6A/zBqQLtGlAkn2lurXiZZ2SjMnkJVvo4=
X-Google-Smtp-Source: ADFU+vvu38hup5r3RTSA4XeuR72gDuXJxZGodSCO5JoodW9LA4hEZINPClY3zAQSAT8fdqvZvxGG0hpUtM9OnviSrIQ=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr716227otl.162.1584386640700;
 Mon, 16 Mar 2020 12:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <650db6863426ae2b324ba717f898247f44279cb8.1584169893.git.gitgitgadget@gmail.com>
 <ee9e8bc6-252f-8ac5-e769-26302f3eb1eb@gmail.com> <CABPp-BE=VdSAfAWR_2KivXbGOYknhJ=4sbRjVPAS+URNgjLFPQ@mail.gmail.com>
 <137d9910-452b-9c96-b3a4-2b19053f6a67@gmail.com>
In-Reply-To: <137d9910-452b-9c96-b3a4-2b19053f6a67@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Mar 2020 12:23:49 -0700
Message-ID: <CABPp-BEk66Z1iK00SpnQ-Tz6pzwOFBzaHukO=WAEPwaXH0dVUg@mail.gmail.com>
Subject: Re: [PATCH 7/7] sparse-checkout: provide a new update subcommand
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 16, 2020 at 10:18 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/16/2020 1:05 PM, Elijah Newren wrote:
> > On Sun, Mar 15, 2020 at 9:24 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> >>> From: Elijah Newren <newren@gmail.com>
> >>> +static int sparse_checkout_update(int argc, const char **argv)
> >>> +{
> >>> +     repo_read_index(the_repository);
> >>> +     return update_working_directory(NULL);
> >>> +}
> >>> +
> >>
> >> Short and sweet! I suppose my earlier comment about whether
> >> repo_read_index() was necessary is answered here. Perhaps it
> >> should be part of update_working_directory()? (And pass a
> >> repository pointer to it?)
> >
> > Good question.  Is there a chance we want to make
> > update_working_directory() available to other areas of git outside of
> > sparse-checkout.c?  If so, potentially re-reading the index might not
> > be friendly, but if sparse-checkout.c is going to remain the only
> > caller then it probably makes sense to move it inside.
>
> Minh had an interesting idea during side-conversations at the summit:
> have a way for an in-tree description of some sparse-checkout cones.
> The idea was to be able to automatically update the sparse-checkout
> while moving between commits that may have different dependency
> configurations. In the world of Office it would mean that there is
> some file ".sparse/word" that describes the directories required to
> build Word, and ".sparse/ppt" for building PowerPoint. Then, based
> on local Git config, we would see that we want our sparse-checkout
> cone to match the union of the directories in .sparse/word and
> .sparse/ppt. As we move HEAD, we would want to automatically update
> the sparse cone when those files change.
>
> I'm working on a design document for how this idea would work,
> realistically, that I plan to share here and with the Office team
> to see if it is actually a helpful plan. I think it would reduce
> the performance cost of the hook we plan to use for this, and
> would reduce the investment needed for a project to adopt
> sparse-checkout.
>
> All that is to say, yes we may want to add other callers to
> update_working_directory() outside of the sparse-checkout
> builtin. With that in mind, perhaps its name should reflect
> the fact that we are only updating it according to the sparse
> cone?
>
> Thanks,
> -Stolee

Interesting.  Some context on another usecase (which may not modify
your plans but I'll throw it out there for consideration):

For us, we have a bunch of modules/* directories.  Each has a file
which lists the other modules it directly depends upon.  Thus to get
all dependencies both direct and indirect, something has to walk that
DAG.  Being required to list the dependencies in both some place that
the build system understand, and one that git understands, doesn't
sound like fun.  Also, requiring users to list all transitive
dependencies or remembering to run some script to do so sounds
problematic.

We do have a special file that defines teams, e.g. team-1 means these
three modules (plus implicitly any of their direct and indirect
dependencies), team-2 means this one module, etc.

Also, we do record the user's specification of the modules/teams they
want already, but not within the repo as you're doing in e.g.
.sparse/team-1, .sparse/team-2.  If the user runs './sparsify
--modules A B', we record the modules in
.git/info/sparse-module-specification.  This differs from
.git/info/sparse-checkout because the latter has full path ("module/A"
and "module/B" instead of just "A" and "B") and because it has
transitive dependencies (thus may have hundreds of directories even if
the user just specified two).

git would thus be unable to use our
.git/info/sparse-module-specification to do updates, and as above we
don't want to have to store the dependencies in another place, and the
fully resolved ones at that.  However, we do get partial auto-updating
because the build system has a pre-build hook that essentially runs
`git sparse-checkout reapply` whenever any relevant
dependency-declaration file is newer than .git/info/sparse-checkout.

Of course, waiting until a build may be good enough for us, but others
might want updates when they switch branches or do other operations
(merge, rebase, cherry-pick, revert, am, reset, etc.).  In such a
case, maybe we could use some kind of hook?  Is this what
post-index-change is for?  (If not, I certainly don't want to try to
navigate post-checkout and post-merge and add post-* for all the other
operations).

Anyway, some food for thought while you're working in this area...
