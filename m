Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818D61F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeIYDFI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:05:08 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36260 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIYDFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:05:08 -0400
Received: by mail-yb1-f196.google.com with SMTP id 5-v6so8861229ybf.3
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3CLiD0nXmeem9M86nvNBcpgMvsCl97RHtTkYM+36UA=;
        b=p3rVsiv7BlH9MuQ5viXghHU2piRYLyHXosRdg8bas14cu0ZBzr4k5x2NeBhSDTT4g0
         5flabbnlZTcfHkUicquMAHK7UvwFW/Xzzj26D7JLzLPpxVzQUwFZkJfa508n1ndYPpU9
         2oTh0iAK5Iyicmnm3O3VfazyHw6rgjVG5twiBJ2LssFoZFYYQu99nI1wqy18KOrfmGzd
         tZAQeiP95N1v1j99T0uuubmIuWJQ/9npFbg6YQ7Y3M3GXKmG20s5oqz61I2tx5Iq4tVU
         XVecgkQ7tCjvVveI72FasWrAB1UFx2j4iT0z4Q8ddHgKgVgzbCKZPcSbcqGM9n0bar6K
         QOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3CLiD0nXmeem9M86nvNBcpgMvsCl97RHtTkYM+36UA=;
        b=fE1XD/aCh+As9QRLUHrIe8IYBJQp324Sy14mCZ2jvKvacitOfmZ4BpboBA+WonNVvX
         XGdBVj86agj0lbo0uw24eLuVmzXVCr7tJryC869t8+nLXnOXdOg29gvIpRwEZrmLgBuG
         vNb9pPoPXzep3ZRxEL9OaINm1zwnjOB03lg9Fp0fYGjKHtK5LUQiyPfh8u+ReD7EXlfd
         72c8oo7WlhXy8IEYuYJPIwWhMDPMKIUHJRX+aHvX7O6s1dOnoYrTkGBmGo0QdkhJQeWQ
         5rcZ9iuJ2nlDg5uaEFup9WEfk2Clvt3RhAWLsLl7m745perxXfEY3GiJCcL0SEmf704e
         LIVA==
X-Gm-Message-State: ABuFfogHZ3AVbAVw85cHEc+NMGXtg96ADWfPfH5anNw27LHXEw2zcc15
        jC0HTos1O1yjiA3D7rY7LrYNmqRBsMEqArsmlSW9Ew==
X-Google-Smtp-Source: ACcGV628/Tm8H2fFMfOGnKKoYhOBtOPYOjG34grKXuWOBClYMVw+GyrCAiM9XZYaSBxhFHBafwoPenOtgoBgOK43HoY=
X-Received: by 2002:a25:e481:: with SMTP id b123-v6mr319542ybh.416.1537822862319;
 Mon, 24 Sep 2018 14:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180917140940.3839-1-ao2@ao2.it> <20180917140940.3839-10-ao2@ao2.it>
 <20180918171257.GC27036@localhost> <20180924122031.9dbec6b4c2e2a8c1bff3365b@ao2.it>
In-Reply-To: <20180924122031.9dbec6b4c2e2a8c1bff3365b@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 14:00:50 -0700
Message-ID: <CAGZ79kZaomuE3p1puznM1x+hu-w4O+ZqeGUODBDj=-R3Z1hDzg@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
To:     Antonio Ospite <ao2@ao2.it>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 3:20 AM Antonio Ospite <ao2@ao2.it> wrote:

> > The third call, however, looks at the nested submodule at
> > 'submodule/sub', which doesn't contain a '.gitmodules' file.  So this
> > function goes on with the second condition and calls
> > get_oid(GITMODULES_INDEX, &oid), which then appears to find the blob
> > in the _superproject's_ index.
> >
>
> You are correct.
>
> This is a limitation of the object store in git, there is no equivalent
> of get_oid() to get the oid from a specific repository and this affects
> config_with_options too when the config source is a blob.

Not yet, as there is a big push to pass-through an object-store object
or similar recently and rely less on global variables.
I am not sure I get to this code, though.

> This does not affect commands called via "git -C submodule_dir cmd"
> because in that case the chdir happens before the_repository is set up,
> for instance "git-submodule $SOMETHING --recursive" commands seem to
> change the working directory before the recursion.

For this it may be worth looking into the option
       --super-prefix=<path>
  Currently for internal use only. Set a prefix which gives a
  path from above a repository down to its root. One use is
  to give submodules context about the superproject that
  invoked it.

the whole motion of moving to in-process deprecates this clunky
API to pass around strings to subprocesses.

> The test suite passes even after removing repo_read_gitmodules()
> entirely from builtin/grep.c, but I am still not confident that I get
> all the implication of why that call was originally added in commit
> f9ee2fcdfa (grep: recurse in-process using 'struct repository',
> 2017-08-02).

If you checkout that commit and remove the call to repo_read_gitmodules
and then call git-grep in a superproject with nested submodules, you
get a segfault.

On master (and deleting out that line) you do not get the segfault,
I think praise goes to ff6f1f564c4 (submodule-config: lazy-load a
repository's .gitmodules file, 2017-08-03) which happened shortly
after f9ee2fcdfa.

It showcased that it worked by converting ls-files, but left out grep.

So I think based on ff6f1f564c4 it is safe to remove all calls to
repo_read_gitmodules.

> Anyways, even if we removed the call we would prevent the problem from
> happening in the test suite, but not in the real world, in case non-leaf
> submodules without .gitmodules in their working tree.

Quite frankly I think grep was just overlooked in review of
https://public-inbox.org/git/20170803182000.179328-14-bmwill@google.com/

Stefan
