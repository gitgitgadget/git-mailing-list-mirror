Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4741DC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143F420CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn9XC+Ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgAaSSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:18:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43150 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgAaSSH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:18:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so7424077oth.10
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9AYZIyJjNtizNzrTAGPG2v3XbQQMvXhJXtmkpIoErn0=;
        b=cn9XC+Ci2q1QfWldAYIMCZgztcY9jadoICh+DaDM+P3TVXXshfzAePCAG68+n+uFVc
         Zh1TUWBuX6qX2/Aqbqm7FQJRaYDCmOhUkzI/6yLqRaqZJ1HAPSxKroUgMtsL7oYmK50C
         Bf2zrl/rCFVZQbw/y1s4f7Pk5APUnh7M0wjSrz9iWY0wYoYfMrBU1uOnhUS9RClO5bPw
         /40NOptMwRxBB/O/qvR37vHWnBvH57cCFukQTnSYy8/+1g6CYiU6pG7g9p+S5nK2jKOE
         ScIEYk6Ya8yYAr1RXfcfrc20E2FnAcfbTrpHE/0ysNpGjJe6ei/sWZO4ZQTzexEcOLkO
         EivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9AYZIyJjNtizNzrTAGPG2v3XbQQMvXhJXtmkpIoErn0=;
        b=OfqX9MaULtNAtM/ajWp9Kh1SOuumBJbs1WOKJTcnT+8bhQFtb4goh5a5qKGUjcxbhR
         qcQjfR7GnYdEWQQNXnQrTnm2vbdRq7+ryjaNSbwJg4Pv0t21BPtXgVWERTfrVr0Pb5VA
         url5m00odMg6x6psByDwcQ/08krzvkEfO/bOKlHGIAd7q+owz9tAk8YXZE6oG1UZAlV8
         VggsMZ6FcfKv4gZIy4tWpS9B+sJyPzgDAbyhy23wWK29AhF7cEoRKrmFI45iYBwxm8Nv
         xDpRMRpxp+qbHy+K/T35LqRqlgOTD/798R/pbYc23GaFYP13Pm5en1ytVH8td3/VutP0
         OUhg==
X-Gm-Message-State: APjAAAXqV9BcQMGkLgzR9qRWh1aLJR8cdx6Hp2cR8fUfz5YXWbcR2OlB
        2EuaGxtElG7IABk2s+wX065iYuMQLbYFvKjZmla29Q==
X-Google-Smtp-Source: APXvYqy0IRKuGzxIQGQxt/9PpFkJ2ahh1lEEZk/t3eq15iB8fnhNSWgNgMmv5tlyMTYfEsSfyN3bfDQ5mA612ecHgy8=
X-Received: by 2002:a9d:634e:: with SMTP id y14mr8888768otk.162.1580494685563;
 Fri, 31 Jan 2020 10:18:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <e6d21228d126d62fafdde185c180f9f5ba64c458.1580335424.git.gitgitgadget@gmail.com>
 <20200131180409.GI10482@szeder.dev>
In-Reply-To: <20200131180409.GI10482@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Jan 2020 10:17:54 -0800
Message-ID: <CABPp-BHy1Yi7RzRcRGCCFfzOnDbgBeHEQz5wjypM=V1hbGjw6g@mail.gmail.com>
Subject: Re: [PATCH 3/6] dir: fix confusion based on variable tense
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 10:04 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Wed, Jan 29, 2020 at 10:03:40PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Despite having contributed several fixes in this area, I have for month=
s
> > (years?) assumed that the "exclude" variable was a directive; this
> > caused me to think of it as a different mode we operate in and left me
> > confused as I tried to build up a mental model around why we'd need suc=
h
> > a directive.  I mostly tried to ignore it while focusing on the pieces =
I
> > was trying to understand.
> >
> > Then I finally traced this variable all back to a call to is_excluded()=
,
> > meaning it was actually functioning as an adjective.  In particular, it
> > was a checked property ("Does this path match a rule in .gitignore?"),
> > rather than a mode passed in from the caller.  Change the variable name
> > to match the part of speech used by the function called to define it,
> > which will hopefully make these bits of code slightly clearer to the
> > next reader.
>
> Slightly related questions: Does 'excluded' always mean ignored?  Or
> is it possible for a file to be excluded but for some other reason
> than being ignored?
>
> I'm never really sure, and of course it doesn't help that we have both
> '.gitignore' and '.git/info/exclude' files and conditions like:
>
> > +             if (excluded &&
> > +                 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
> > +                 (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
>

Good question; no idea.  You can start digging into is_excluded() and
the pattern list stored in the dir struct and try to trace it back to
see if it's just the combination of ignore rules in .gitignore and
.git/info/exclude and core.excludesFile, or if there is something else
meant here.
