Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E25C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 02:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B38610E7
	for <git@archiver.kernel.org>; Fri,  7 May 2021 02:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhEGCc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 22:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhEGCc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 22:32:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6BC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 19:31:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso6741851otm.4
        for <git@vger.kernel.org>; Thu, 06 May 2021 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJOK0iFCCYYW8IyJ7t0G74llB/o5/fhkm9g5Kgd8brk=;
        b=ksTQ8PLUYq75z5ovNgsDxjM4W5Jj4M4v2goSQlVEIvOBu5tbsWV4lQrbNq/LGYh6ci
         iM2p+LznIlYeU2hxjLLD7PSebHpcB2A7B07r2ZRuFmO0GTxnUyFLGQWuo7ADpUHSVmv/
         +gvPlmt68AJJmnJTUoJYir4c/6IYBpI/ksLpah82MOj8kJNgbHYXGTjEe97KZLo8CCB1
         IIbmMr19JScBajhL+t2cy4dJaTnrS9mdgFZexepHsxRvSkMPAFT6hQI56PPyiXZMKb9z
         H8GcCsgZ9+7oUXiGxNCW2xDXCSPYc0skCS3pT3joP0A+QNcuIfLSmvblAS246pehD3FW
         5gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJOK0iFCCYYW8IyJ7t0G74llB/o5/fhkm9g5Kgd8brk=;
        b=H5/JoQ0eOblwfqUbdme6oClouO2PaJ8iQCFhnh2NKZ0CsrQsHLmSEfsUQ/TYet8sYS
         /SpdOZRzt5HJUaDwg6s5R+Y5XjU+P8OJrP9d0eqGOarQq3VhszY2bYngD7TrZM8oaehC
         4ZnV+y4TKF+bvDjJXfU0GTzBA23TCy9TZDJqUeZjYUvFMIDjMEoPY2mMDfawNhlV59Wr
         gP/FYmmEZWp2GK0jFWCyEiB+3xgNoTk58/tgV9qQbZtgzaFXaPcyfXHWJ7Lqd1dnQw6Z
         GtUfJaiaDleZeJWzlqJBSoeYUGPWfiP79HNdT2Geey+bBTkWvU7Aij0xYmORm4phjMxC
         0shg==
X-Gm-Message-State: AOAM5323MZIUAwQWWVToV2PrPUG75I9zg5APe69TsvvYIQ43JF3XlEJZ
        I1LD+Pwq9I/e0M3vzb97m/AOdMan7UtEfV1Ne7dLfwQTjcEdnA==
X-Google-Smtp-Source: ABdhPJz6v5xi/ECqFjw913B9ggkQGN9K40fQd1EjOqCcl3c4UrCVEmBFCn3wLC6ZI7uWmG7r8FsFV6Rn2sxWeywMHWw=
X-Received: by 2002:a9d:7085:: with SMTP id l5mr6277518otj.345.1620354711679;
 Thu, 06 May 2021 19:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net> <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
In-Reply-To: <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 May 2021 19:31:40 -0700
Message-ID: <CABPp-BH3tbTyA9gj=2vb878d1MQVCTqT7=kS5U+sB6CoDX0Jww@mail.gmail.com>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Gore <Jason.Gore@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 1:51 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Apr 14, 2021 at 10:56:14PM +0000, brian m. carlson wrote:
>
> > ----
> > #!/bin/sh
> >
> > git init test-repo
> > cd test-repo
> > longname="directory"
> > touch "$longname.txt"
> > last=400
> > for x in $(seq 1 $last); do
> >   mkdir "x$longname$x"
> >   mv directory* "x$longname$x"
> >   mv "x$longname$x" "$longname$x"
> > done
> > git clean -ffdxn -e directory$last
> > ----
> >
> > When it fails, it will complain that it wasn't able to open the
> > directory.  It still exits zero, however.
> >
> > I haven't bisected this, so I don't know if those patches are related to
> > the problem or not.  I'm a little short on time today to investigate
> > further, but hopefully this can get someone on the right path with a
> > modified version and git bisect run if nothing else.
>
> It bisects to 8d92fb2927 (dir: replace exponential algorithm with a
> linear one, 2020-04-01). I won't pretend to understand everything going
> on in that commit, though.

I've got a patch series to fix this and another traversal problem, and
the tests pass on all platforms.  Wahoo!

BUT!

On alpine linux-musl, I get an "error: Tests passed but test cleanup
failed; aborting", which makes it report as a failed build.  I'm not
sure how to fix it and am asking for ideas.

Apparently the deeply nested directory hierarchy cannot be removed on
that platform with a simple "rm -rf $dirname".  It throws a "rm: can't
stat '/__w/git/git/t/trash
directory.t7300-clean/avoid-traversing-deep-hierarchy/directory400/directory399/directory398/.....(you
get the idea)....': Filename too long" error message.[1]

Adding a "test_when_finished find directory400 -delete" also gives a
"Filename too long" message followed by a lot of "Directory not empty"
messages.[2]

Anyone have any bright ideas about how to tweak this test?  See [3]
for the current incarnation of the code, which was basically taken
from Brian's sample testcase.

[1] https://github.com/git/git/pull/1020/checks?check_run_id=2523414561
[2] https://github.com/git/git/pull/1020/checks?check_run_id=2523594095
[3] https://github.com/git/git/pull/1020
