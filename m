Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF8C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067D622525
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1ukGEUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgBQSl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:41:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32866 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgBQSl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 13:41:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so7851444otk.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDRJl9pxJUCBScoVA4nqzlbjb6WYQWR3bdNjzJQMsRY=;
        b=Z1ukGEUjTqStZXE3xXP9lfMNHC50vGvcRVx2XQOxg4fmSomi7325U3QBs6N5yXVaEx
         O6cuZAXAWeq/A4hGG0UV2YOHLgtr/4LS7ZHioB5BiSrnMdAqd1jKrAUyHY8T0ndNZMgl
         OUVOn7wHL/OeA5iVDoQfUv1iX7Wk5Vf7cJltx01ovMDc0HY8N4i2VVe+91Us9mBSmjRi
         Fn3oeNZPzh84w0/LZm4VBHr61anXCpKuSg3YvblKXAAyPtQ0Hex4I+D97l0/fWv0lOGi
         gAUbfbtkrg25u/3oaX2NUXEHTkm8DZ6EfXnd23Wx2Gj8SScUSeRumjthNb1cTM99SUgz
         kpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDRJl9pxJUCBScoVA4nqzlbjb6WYQWR3bdNjzJQMsRY=;
        b=Ex8ULdUJU85RB+XoCaDnrMw5iPgUWfimUuqv6CiEOlRdK6keGSt531w1XzUAe677m7
         TKWpnbrXyCOxo7zlg6fYK1hxvMCW1PbH+uzMXxENKsmUwa8YhC4dy92MDu5YRqoIUYbe
         9lVn9Fx7/5p5Qu0Kw+2Db9rr536AKALxZBhYhegyZ58Gw4yyQE/9HthU2NL9vc5Acss9
         WoDtT+fS9uap4q92xoO0JzXRP/ZxzW8AZtb1A0gECgaDNsl82sXe11o9mGLBSvIeuAK6
         2TegQSiOdlMp7Cm1PFPNTOTc9lZYgFGdwXkLyTrAu+28BdKWWZXohkGVgl3InSqEOGmH
         TA/A==
X-Gm-Message-State: APjAAAULdq4hh5TxqD2Npxj/SspLoNCdVmO6gvHC+L+Ls2Vq3sNgNiT3
        NUE/ylee9XWGIf1HZ2dqlzdOc2Nxfi3RI6NQkKk=
X-Google-Smtp-Source: APXvYqynDEVOgvbkc+pj3X4PjrcHt+8k5z5YzxiqyBn8MR76V2AjFhRtAKwb7sTYYk9+j77gnb1Kv+0JQbr2QpNF5+M=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr13373707otl.162.1581964917913;
 Mon, 17 Feb 2020 10:41:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com> <xmqqimk5ks39.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimk5ks39.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Feb 2020 10:41:47 -0800
Message-ID: <CABPp-BEbojaeYkSMR7vntW0SkWf6dVOko5H=jqT-Yv2USRerxA@mail.gmail.com>
Subject: Re: [PATCH] check-ignore: fix handling with negated patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 10:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > check-ignore was meant to check ignore rules the same way git status and
> > other commands would, and to report whether a path is excluded.  It
> > failed to do this (and generated a few bug reports), however, because it
> > did not account for negated patterns.
>
> I suspect that the above distorts history.  IIRC, it was meant as a
> tool to see which exact pattern in the exclude sequence had the
> final say for the given needle, written primarily as a debugging
> aid.  In that context, "This rule has the final say", whether the
> rule is a negative or positive, still means something.

I can reword it; how does the following sound?

check-ignore claims that it reports whether each path it is given is
excluded.  However, it fails to do so because it did not account for
negated patterns.


Also, I think the "This rule has the final say" functionality of the
tool might still be useful, so I kept it -- see my updates to the
--verbose flag (mentioned later in the commit message).

> It is just the behavior is _much_ less useful for those who want to
> know what the final say is, and I tend to agree that we probably are
> better off changing its output to reflect "so, are we ignoring the
> path after all? yes/no?" because we are pretty much done with
> debugging the exclude API implementation.
