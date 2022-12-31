Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C5AC4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 00:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiLaAd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 19:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiLaAdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 19:33:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B7140FB
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 16:33:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id n1so23503348ljg.3
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 16:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjyFjEOaNC/fLH7KxybLs/+aZzExobqlHB+ElsjkfRk=;
        b=b4l/k5I90S0jzUsMB98Y7yqOg7nhDjFUTbhrUCQV+GNYeTUqXgjxcVahFMOmh8qqRR
         gXW8q6G7JgLZjoYwi+rHQLK1aqy3miVcM8ujx2V/N/r59581jRg+WIbck7/mBOs7ARM1
         lv1hHq/ut8Hn5jNAvF2omdbmvAb2PPZkEgloPSwJnn0BZ3Nu/Y/DGyr7BERkh2GOqViv
         OdPv87wE3rGL9FHQBwP5cuWTFsSMGUJgNSfS7mOzEUWxmM80Fe97HFp9zEx0A1m9NtSi
         cOSGRo2EryCmApDS/4AemS6Jy2JEBanSsEX3lflC7qLCh2OQCqugiOMhUJSnTrp8GYtu
         gYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjyFjEOaNC/fLH7KxybLs/+aZzExobqlHB+ElsjkfRk=;
        b=CNxLbaWn0KYhCIZkbTyBSRpn7GK5NSTxhJ+pkiDIQpturdTAvcHwTtALGdz7D1Jw0o
         WvMziG7TOLes5/Ku1D5MzpnS2YF1UB87N0btuGqRs7h7dFD/58T96SKy6oYWCADT82ov
         SmWanzUpLMMbr2zgEP7whbdEXNoGI6QxMvhHS9Ex9GTyk2WGcv13wvzTXFa3KBbi5BEh
         VW7gXBYtmZ2wgzmfKbnEwhR0IoFHMI1CrYmUIFRuH9Pwab82stUZFRaEwI4UgOaySRy3
         9v+c3oHrzH+aPJDroPkH7M2uIF9BjgGWBWRDbzrlbsIwwho2cD+Ci9eDdd7Dgx9OZ34+
         W0Jg==
X-Gm-Message-State: AFqh2kprsfpVseosfKMWnGQefkhhMAgyuWpx3tTp/7wOCeSrCqEsbuYL
        qOSKnqCvikg7Mi/V6dCTsmyMfrZk4eeNU0x09YI9NWFZvIj3kgPw
X-Google-Smtp-Source: AMrXdXtC7wB9aR2Y0UOsJu5YU8gV2G0Xe4Jz6I8rXWYWuv680p0qhCUU2qFqvPIxPrN90ALf1p0+f1RglP5+s52Qw8g=
X-Received: by 2002:a05:651c:22b:b0:27f:b397:db7d with SMTP id
 z11-20020a05651c022b00b0027fb397db7dmr1578314ljn.323.1672446801254; Fri, 30
 Dec 2022 16:33:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c266:0:b0:23b:5e81:46ba with HTTP; Fri, 30 Dec 2022
 16:33:20 -0800 (PST)
In-Reply-To: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
References: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
From:   Samuel Wales <samologist@gmail.com>
Date:   Fri, 30 Dec 2022 17:33:20 -0700
Message-ID: <CAJcAo8smwU2ddB96J+G2SOAP+FU2p4ejB2JX9+5QHdQEn43htQ@mail.gmail.com>
Subject: Re: is this data corruption?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p.p.s.  git 2.20 has the same problem.

On 12/30/22, Samuel Wales <samologist@gmail.com> wrote:
> i am not subscribed, but am of the impression that's ok.  please copy
> me directly.
>
>
> tldr: git diff is showing differences that do not exist in the files
> themselves.
>
> i have nothing staged, nothing fancy like stashing, etc.  this is a
> repo of mostly emacs org mode files.  mostly ascii text.
>
> git status and these commands show nothing unusual:
>
>     git fsck --strict --no-dangling
>     git gc --prune="0 days"
>
>
> the problem that seems like data corruption is that a few lines appear
> twice as - and once as +.  but in the current version of the files,
> those lines exist only once.  here are the lines.  there are 2 -
> versions and one + version:
>
> +***************** REF bigpart is a partition
> +biglike and homelike are distracting nonsense i think except
> +to describe inferior filesets.  anomalous subset of home
> +might be called homelike or so.
>
>
> emacs magit shows the same problem.  however, it shows a slightly
> different diff.  i did a meta-diff on git diff vs. magit, and there
> are about 800 + real-content lines that magit shows but git diff does
> not.  i do not know what this means.  wc -l is like
>
>   62540 aaa.diff
>   62965 bbb--magit.txt
>
> idk why a diff would be different with only + lines being different?
>
>
> in summary, what is wrong with my repo, if anything, and what can i do
> about it?  nothing on the web for git corruption seems to say much,
> other than pull from github or whatever.  this is my own repo, the
> original repo, so i cannot do that.  org annex has an uncorrupt tool
> of some kind, but it did not seem relevant.  i do have rsnapshot
> [basically rsync] backups of the repo and the most significant files
> and dirs, but i do not know what one does to use that to repair any
> issues.  i won't get into why, but changes were made over months.
>
> is there a protocol for this?
>
> would git fsck have balked?
>
> thank you!
>
>
> p.s.
>
> i have no reason to believe this is related, but git diff has
> intermingled emacs org mode entries.  but i don't have to talk about
> it in org terms; in generic text terms, it has intermingled parts of
> different paragraphs.  as a user, i'd prefer that completely unrelated
> paragraphs not be mingled, regardless of minimality.  if possible.
>
> with respect to the intermingling only, unless this is related to the
> possible corruption, i will presume the diff is correct, in that a
> patch from it would produce the same result as a patch that does not
> intermingle.  i believe this intermingling is because diff does not
> understand org, or paragraphs for that matter.  in org, an entry
> starts with "^[*]+ " and ends at the beginning of another entry or at
> eof.  they consist in my case mostly of ascii text paragraphs.  just
> as with paragraphs, if you move an entry, you don't expect it to be
> mingled with a different one in the diff.
>
> i have been told that this cannot be fixed by merely telling a
> slightly improved differ that stuff between stars is worth preserving,
> but that a parser, not merely a couple of regexps, is needed to reduce
> this intermingling.  i have also been told that difftastic uses
> tree-sitter, which might get such a syntax for emacs org mode.  and so
> maybe at some point git diff can use that.  idk.
>
> idk if any of this is related but i include it for completeness.
>
> also, please don't laugh, but i am using git version 2.11.0.  i will
> upgrade pending various library and os stuff but my main concern is
> not for git, but for possible corruption in the repo and what is
> possible to do, at least given rsnapshot, to fix it.
>


-- 
The Kafka Pandemic

A blog about science, health, human rights, and misopathy:
https://thekafkapandemic.blogspot.com
