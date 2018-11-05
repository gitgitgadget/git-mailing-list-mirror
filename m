Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF7C1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbeKFDYY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 22:24:24 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44251 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387651AbeKFDYY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 22:24:24 -0500
Received: by mail-ed1-f44.google.com with SMTP id n19-v6so8262166edq.11
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDORuLM/5pwjgT1wjr/1OVds9u7DTm8WrG1eHK3ne5o=;
        b=f/0NdwH4wIxV/qw/9umNJeF5u4Q6EuWvf/1Cxw1QADKhmyBtW4agvyen2ARX0VCMtk
         whtp+9LWqbHny2mCcrC6Vqrci2WkbPfVg4nBFJi71ghJZiaqCDWkX6o3To/lrEUV0gqE
         E2zG6nsWYDa4vI4ikK0a1GwY/eO4eiPSXdzMXmLmhztA4VjfHo6SUmPS0tLDd9ko8HRd
         r5Dy/zeUNA6HBQD2iUPQ+yFxb59Ciwm1t5pv34aCS+i9Y2za3kcreAOMXIL7l+bB4fR4
         bDfar+bUeK/qo1gnGWm4CEOnm8gvppPrqtPkX7yGgeqwyK/jBq+UhkLGmgPN+vhMOkqT
         InrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDORuLM/5pwjgT1wjr/1OVds9u7DTm8WrG1eHK3ne5o=;
        b=LJiiC0JjRIPJBwL1Rc+507/L2yzV/PY91tMxbQJbkzfPECCGUIy6UgnC2DyDhYqNOV
         1H/HajJhARIVPgZBo8AE+6aZ2SyATqWGfvKBdtYjVMrzgzC67CqqcCxyK1XUE28Untqr
         p7ZaxZ10dq0/hV4vPomVOq/dGB8KiDfXerlqFHbznfc2AvscJBDU87W80ceyjcUaJeNr
         LyY7OYBQgku0pHSnxovE12hakL3Mn6ZBYm+VsBKHnvu1QhJr12p8Bwyl9hUdwV3BEojo
         uxkMIAIaC1xzTN61ejmLSb7MO+1fwqG7rgJHbZeSZraxnOu5F9Y9AbZj6Y+l7b+vVD7a
         nV8g==
X-Gm-Message-State: AGRZ1gI3lECahjkt5IpVcniIFor35B5R/Qa5jasNp7G6WodevIVPZjsc
        Y7khO25t7d3Yu/9KPUCBW/2MZZft7//LkLjIejxm0vW/7umgpw==
X-Google-Smtp-Source: AJdET5cJGfDkRsoRXeMQDhNTVxRrEnoL+91NhDAnxA1n1u8rJYyVoTKca2a329fXFsjZT6dAp9YYShJSwkY2kNPS7J4=
X-Received: by 2002:a50:8ce4:: with SMTP id r33-v6mr18687833edr.231.1541441012988;
 Mon, 05 Nov 2018 10:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20181105010032.GN731755@genre.crustytoothpaste.net> <xmqqlg68jlny.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg68jlny.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Nov 2018 10:03:21 -0800
Message-ID: <CAGZ79kZQQ2BqaANTQU_eHgOS0nBp9YzyTx1WAfpgADOyeLs4XQ@mail.gmail.com>
Subject: Re: Design of multiple hash support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I'm currently working on getting Git to support multiple hash algorithms
> > in the same binary (SHA-1 and SHA-256).  In order to have a fully
> > functional binary, we'll need to have some way of indicating to certain
> > commands (such as init and show-index) that they should assume a certain
> > hash algorithm.
> >
> > There are basically two approaches I can take.  The first is to provide
> > each command that needs to learn about this with its own --hash
> > argument.  So we'd have:
> >
> >   git init --hash=sha256
> >   git show-index --hash=sha256 <some-file
> >
> > The other alternative is that we provide a global option to git, which
> > is parsed by all programs, like so:
> >
> >   git --hash=sha256 init
> >   git --hash=sha256 show-index <some-file
>
> I am assuming that "show-index" above is a typo for something like
> "hash-object"?

Actually both seem plausible, as both do not require
RUN_SETUP, which means they cannot rely on the
extensions.objectFormat setting.

When having a global setting, would that override the configured
object format extension in a repository, or do we error out?

So maybe

  git -c extensions.objectFormat=sha256 init

is the way to go, for now? (Are repository format extensions parsed
just like normal config, such that non-RUN_SETUP commands
can rely on the (non-)existence to determine whether to use
the default or the given hash function?)

> It is hard to answer the question without knowing what exactly does
> "(to) support multiple hash algorithms" mean.  For example, inside
> today's repository, what should this command do?
>
>         git --hash=sha256 cat-file commit HEAD

There is a section "Object names on the command line"
in Documentation/technical/hash-function-transition.txt
and I assume that this before the "dark launch"
phase, so I would expect the latter to work (no error
but conversion/translation on the fly) eventually as a goal.
But the former might be in scope of one series.

> It can work this way:
>
>  - read HEAD, discover that I am on 'master' branch, read refs/heads/master
>    to learn the object name in 40-hex, realize that it cannot be
>    sha256 and report "corrupt ref".
>
> Or it can work this way:
>
>  - read repository format, realize it is a good old sha1 repository.
>
>  - do the usual thing to get to read_object() to read the commit
>    object data for the commit at HEAD, doing all of it in sha1.
>
>  - in the commit object data, locate references to other objects
>    that use sha1 name.
>
>  - replace these sha1 references with their sha256 counterparts and
>    show the result.
>
> I am guessing that you are doing the former as a good first step, in
> which case, as an option that changes/affects the behaviour of git
> globally, I think "git --hash=sha256" would make sense, like other
> global options like --literal-pathspecs and --no-replace-objects.
>
> Thanks.
