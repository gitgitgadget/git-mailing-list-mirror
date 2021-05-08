Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7759FC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA0A61221
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhEHRVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 13:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHRVP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 13:21:15 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B9EC061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 10:20:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id m13so11783721oiw.13
        for <git@vger.kernel.org>; Sat, 08 May 2021 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7q7bpGXG9N5+VtIcvwxettXl8OhxjCAv+NpydUdaF0=;
        b=DIxoReDQWZSXBNonfB73Q+of2gGwDcqu1Xe3jA8ksuerUZnDymV9Ki1xAEaGmUifY7
         fBW4g96Q7XrvsDVDg/E16j6aaFCosbi4LowOoVxr8HazIrC6ddfvNONfNezebnqULnzb
         UDPYYtfhV6+X0Gz6+5b4AVIq+XoXJLu/Igwp92PVF4cdiktltXxjyWv5lWdCBCzyHeEO
         zWvgaQPiy3tvpALZ2ECfrMmqgZKhoh5Cx/hnbzqIslGL6LgW/mgXLI7jVK5LZY5k46Jq
         Oxb+MEGNNy0LWXOLHQD9FJX4G7T8ExUmbKmPA7OTLBDbSNS+IPR0sLxjnkr4ZJQhhO+E
         gpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7q7bpGXG9N5+VtIcvwxettXl8OhxjCAv+NpydUdaF0=;
        b=DschYGr4RT7YOOmNd4inJAi7nW+IcolEws3QavUrjsAWyena89d0QZkSSYFCVzrt7Z
         cjPyTJI36ADwYuwJbQ51Kl6r3hrj2bDIf1CHRDsIfDN4q+G1jVoRNTTkDm6HsUr1g5v5
         Qt3iBvhvgrGdD2Wmk2qm7lZsdu5Me4v4I1DdS8jdFWjwDaIu3LqkXI5TorAEZPagNVbk
         l0kptMcBYmhTjS3BhHpfzxLc1yzrq275Nea8hZ9pxhU3XCzJqV21bRuZYNuf4r4eX34i
         ueXzO5hGZMWRmVDZkrej97KMXvFaDraJ/UT5+q73qQGEfgvL+GDfr9BjrVza92kR0y2H
         QSgQ==
X-Gm-Message-State: AOAM531IeXJtQ99k+2Mm4iBaA2jqlBOKo+05U2FWf6TgxxwPHa8SbzkA
        13186bS6ejb0Jx7/1jnWMXnOoRMRQPz+o89fuDE=
X-Google-Smtp-Source: ABdhPJw0uqeIsl4RrXAe6fPC92jB4JvuSM6cEpB8hijjLpp3YFGlR0h9AzN064fRRmyZTl1FRlP4rD1UvfhWyvcEfhY=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr19046002oia.39.1620494413135;
 Sat, 08 May 2021 10:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
 <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com>
 <YJXHrXWVDSgg5TZw@coredump.intra.peff.net> <CABPp-BEyUX8j-_rhNTyR5ZiqeLUWbBS-9q5+gEUWOEHpchambQ@mail.gmail.com>
 <CAPig+cQw5xBK00rtMVw4b6e_21vgp33yYDfdRape202dpWQjbA@mail.gmail.com>
In-Reply-To: <CAPig+cQw5xBK00rtMVw4b6e_21vgp33yYDfdRape202dpWQjbA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 May 2021 10:20:01 -0700
Message-ID: <CABPp-BE4ccB3cVXMqQ-4ZPn6TrRMrD61zHrXNbtNR9GQ9id98Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 5:11 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, May 7, 2021 at 8:04 PM Elijah Newren <newren@gmail.com> wrote:
> > I think I figured it out.  I now have the test simplified down to just:
> >
> > test_expect_success 'avoid traversing into ignored directories' '
> >     test_when_finished rm -f output error trace.* &&
> >     test_create_repo avoid-traversing-deep-hierarchy &&
> >     (
> >         mkdir -p untracked/subdir/with/a &&
> >         >untracked/subdir/with/a/random-file.txt &&
> >
> >         GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
> >         git clean -ffdxn -e untracked &&
> >
> >         grep data.*read_directo.*visited ../trace.output \
> >             | cut -d "|" -f 9 >../trace.relevant &&
> >         cat >../trace.expect <<-EOF &&
> >         directories-visited:1
> >         paths-visited:4
> >         EOF
> >         test_cmp ../trace.expect ../trace.relevant
> >     )
> > '
>
> I believe that you can close the subshell immediately after `git
> clean`, which would allow you to drop all the "../" prefixes on
> pathnames.

Ah, good point.  I'll make that fix.

> > This relies on a few extra changes to the code: (1) switching the
> > existing trace calls in dir.c over to using trace2 variants, and (2)
> > adding two new counters (visited_directories and visited_paths) that
> > are output using the trace2 framework.  I'm a little unsure if I
> > should check the paths-visited counter (will some platform have
> > additional files in every directory besides '.' and '..'?  Or not have
> > one of those?), but it is good to have it check that the code in this
> > case visits no directories other than the toplevel one (i.e. that
> > directories-visited is 1).
>
> I can't find the reference, but I recall a reply by jrneider (to some
> proposed patch) that not all platforms are guaranteed to have "." and
> ".." entries (but I'm not sure we need to worry about that presently).
