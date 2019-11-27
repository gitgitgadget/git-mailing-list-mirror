Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B8C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F92C2071E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEq95OZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK0Nis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:38:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37091 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0Nis (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 08:38:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so12111758edb.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 05:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f64JOuDKtjE+TML455JPopNOSvC79fKl5FoeykF9W6M=;
        b=WEq95OZurxh5tWIj2RwuTtjLMoIsMGZUqhlNwoEckNyXQX+51P27JLsfPNrF7E44rV
         WuGuLe9d/eQKfKMtTAkwP/hzXcrNanuY00k9ffVU/to4twbucUO9X/JAFizEIxVUWq26
         H3ZdRYSXN8VxKyEurfVFPHSpvwOD/1uRypTdSLQ76JRuSlWSC9i5VHgUBeqxYPQD+jbu
         l0u1Y4WgvSWKCpeDarFRvFsQhUsAylrLRSViW6uzNKKw6abVbFDYL4JEYOZV5tRtumT0
         l+RQnZivMFJPx7FLHxDrv1YPdKLDvUoFQu0TKSwormWDfGgufRtcAm8ofqyhQ24zCiCt
         v3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f64JOuDKtjE+TML455JPopNOSvC79fKl5FoeykF9W6M=;
        b=TZtr5B9pD8EXPHZ5FFKj7ZoS5WBPzNlu43sRbcJq3IYZ1lYud1SeJypNiKmcrUojzL
         lb9C0gjFXYe1RGAOAV4BlkB7lPc+blutL/2d3qd8gk2NmhdX+kab6gtBM8BKMrkw9wDL
         /CvBRAgJXraNlhqxMr3FUKw1r4/BmTBRGprbgSb6EsZYi8Rh+SF23SUO/wllTpGgI3/c
         JRG9sBaXjz4J7wOMTILdZiZIhMy+x2ml1RxBW/5GowFoej2drsVaYCayfiG1AG2P96pk
         VU45eJmQAoYiJJ3EDxmikK7EXVBXGz3/9B1U9eqrEqM8w7aGha+mqG5Lty64ChNssEwm
         NIIw==
X-Gm-Message-State: APjAAAUeHoqt/+rp1Asqh+MLAN60eOIo7zdYNHTUpiw4ONKgadL5K335
        HMCw4VeSmh/G9409eZZSWu6PPpca0EjDQDN37q0=
X-Google-Smtp-Source: APXvYqwipAy8PEJKFrhE5dYOdm2ZCO4gy0/iw2JIrtXnqvG9TZeI2TxgFrwDKzzbD4wNtn7cA3XKMq4mhE9j4xQDHrk=
X-Received: by 2002:a17:906:351b:: with SMTP id r27mr49921339eja.120.1574861926366;
 Wed, 27 Nov 2019 05:38:46 -0800 (PST)
MIME-Version: 1.0
References: <87o8x06sbw.fsf@sydneypc> <20191125141635.GD494@sigill.intra.peff.net>
 <CAAE-R+8betprfFOH+m_mMATX2mODHQ8pFUpLo4tyLVBVAVtySg@mail.gmail.com>
 <CAAE-R+8dqbxWr9an63OGCL2g1sm1h-ds3yKrzz7Shwq3UyfWxQ@mail.gmail.com>
 <CAAE-R+8yZOchnsa-au+w4JveCQffw9bpGZ54oL+DApa8Y094=Q@mail.gmail.com> <20191127113007.GB22221@sigill.intra.peff.net>
In-Reply-To: <20191127113007.GB22221@sigill.intra.peff.net>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Thu, 28 Nov 2019 00:38:35 +1100
Message-ID: <CAAE-R+_yuOu6kgAcU1xP6eyERtALg0JyrKVZhRfxFQme1xfhZQ@mail.gmail.com>
Subject: Re: A new idea to extend git-blame
To:     Jeff King <peff@peff.net>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What I did is "partial line blame", select partial line, do recursive blame,
stop when the selected text disappears.

There are screenshots at
http://blog.binchen.org/posts/effective-git-blame-in-emacs.html

I already implemented in Emacs Lisp. For now looks it works.

I understand `git log -L20,20:README.md` can track the change before `README`
is renamed to `README.md`. But my recursive blame code can't.

The problem is, `git log -L20,20:README.md` output too much text.
See https://gist.github.com/redguardtoo/a0c178350414449c45e6b67e16249000

It's difficult to track the correct commit if anchor text is generic
work like "true".

For example, the full text of line 20 in `README.md` (HEAD is d9f6f3b619 ) is,
`See [Documentation/gittutorial.txt][] to get started, then see`
To detect the commit adding the word `see`, the recursive blame algorithm stops
at commit 6164972018 because 6164972018^ rename `README` to `README.md`.

That's acceptable in real world because users can base the manual
blame on 6164972018.

But in the output of `git log command`, there are too many
"occurrence" of word "see" so it's
difficult to find the correct commit.

On Wed, Nov 27, 2019 at 10:30 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 27, 2019 at 06:32:37PM +1100, chen bin wrote:
>
> > Just double checking, the feature I suggested is fine, right? I will
> > send the patch asap. It may take 2 weeks to implement.
>
> To be clear, I can't say whether a patch is fine or not without seeing
> the patch. :)
>
> I'm not entirely sure I understand what you're proposing to implement.
> But if it's of interest to you, maybe it makes sense to see if you can
> make it work to your satisfaction, and then we can all look at the patch
> and what it does to see if it makes sense to include in Git?
>
> > > > I re-tested `git log -L20,20:README.md` in git's own repo with HEAD
> > > > d01d26f2df. Looks git log is not what I expected. The output contains
> > > > many unrelated commits. So it will be slow in real project.
>
> Looking at the output from that command, the issue is that it's
> imperfect to decide which lines in the pre- and post-image correspond to
> each other. The first commit is:
>
>   diff --git a/README.md b/README.md
>   --- a/README.md
>   +++ b/README.md
>   @@ -26,3 +26,1 @@
>   -See Documentation/gittutorial.txt to get started, then see
>   -Documentation/giteveryday.txt for a useful minimum set of commands, and
>   -Documentation/git-commandname.txt for documentation of each command.
>   +See [Documentation/gittutorial.txt][] to get started, then see
>
> at which point we consider all three of the pre-image lines to be
> potentially interestnig. And then the next commit:
>
>   diff --git a/README b/README
>   --- a/README
>   +++ b/README
>   @@ -29,3 +29,3 @@
>    See Documentation/gittutorial.txt to get started, then see
>   -Documentation/everyday.txt for a useful minimum set of commands, and
>   +Documentation/giteveryday.txt for a useful minimum set of commands, and
>    Documentation/git-commandname.txt for documentation of each command.
>
> touches one of those lines, and so forth. A human might see that in the
> first hunk, it was probably the first line of the hunk that was
> interesting to keep following backwards. But I don't think it can be
> done automatically (which is why manual "reblame from parent" is still a
> useful technique).
>
> It sounds like your suggestion is to take some anchor text on the line
> to decide which lines to keep following. But then it sounds a lot more
> like a "log -L" feature than a git-blame feature.
>
> -Peff



-- 
help me, help you.
