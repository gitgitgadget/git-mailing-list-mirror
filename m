Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E0DC4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 00:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiLaASB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 19:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiLaAR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 19:17:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06817597
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 16:17:55 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bf43so33649891lfb.6
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 16:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5C8edCvyWiMoxwiGtck/TTuwOpaVRqNST35fbGdKRC0=;
        b=E6IN1pc4GUR2uKzIuAmDI5ysdWIAxKV0Nz8NIDNby+L2uqAiwyGnc87usvqh+k1M9l
         l1pvwQoRg/gz8/ny1pLIa10H/c58zkbUDROaMtiPtIOwq4I2YmN29kPF8v5THyj1QLat
         i6F9TMoGhgwmZFllh8zqnFobwHEXrhBx1H9hBSbOzc1ZPzkvIGWwNzWnZLttxyGZhH0r
         XLEdFFk8QUs285qa724pQyU3GCevCBfu4yvVw/VkCLvN6SkWnes3wplQf3+m8V9tp2zl
         UeHVTl7MeUaKg7d2usJMjUNlz/PmQclJz4pgs1nnBae7329RRR9dinx8nDFY/sqTPC7R
         vwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5C8edCvyWiMoxwiGtck/TTuwOpaVRqNST35fbGdKRC0=;
        b=QIHPu4/drPbc5z32Al8/MFYojKX1V6QfCGkK1K5CqKxbX3W9zIEFGrZaOutPm7Ap86
         S4HYmdU4cyy7/MUXkEzwKoKYOOhloa2YM+oLBNCVZyXOnNB9hIVoPJpQupfxHmBNHU6K
         gUPTczon+HCKheHVGGUkuG84DYZ4yU948mcUK14g0uRCiQNoXdXndDkpUzjC+VO7fZ2B
         b8EOOvTGA3qRPxiq5TEENGUFZr4JyDYpjNabYzZ75fsPqqGZp+nnfub3o5jUzfex+XBX
         VQacNb3xPDMQKy37Hz4UjBAxuPHIkZE0iC3+6qzOLzJm0iTg4eNNduUF+yt1of2dXklX
         awGg==
X-Gm-Message-State: AFqh2koFkALZ/XoUCBDSo+QUjP5hZIWephfnjRm3gag9CySBGMln+oAG
        BPLlnd44RdXAcsThHJQMQk1aHP5N/XmiBvl5FJpSytIgUo+eNHaB
X-Google-Smtp-Source: AMrXdXu8JaW/RzAvYbWFxXwcaUBuSzh5DhmyaWwbhsRtoTuMeLbSj/dZoWNEj2fg3uTuOykpghL0HYdmv6jaY3CqEP4=
X-Received: by 2002:a05:6512:3a8d:b0:4cb:2996:ac72 with SMTP id
 q13-20020a0565123a8d00b004cb2996ac72mr284382lfu.613.1672445872892; Fri, 30
 Dec 2022 16:17:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c266:0:b0:23b:5e81:46ba with HTTP; Fri, 30 Dec 2022
 16:17:51 -0800 (PST)
From:   Samuel Wales <samologist@gmail.com>
Date:   Fri, 30 Dec 2022 17:17:51 -0700
Message-ID: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
Subject: is this data corruption?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

i am not subscribed, but am of the impression that's ok.  please copy
me directly.


tldr: git diff is showing differences that do not exist in the files themselves.

i have nothing staged, nothing fancy like stashing, etc.  this is a
repo of mostly emacs org mode files.  mostly ascii text.

git status and these commands show nothing unusual:

    git fsck --strict --no-dangling
    git gc --prune="0 days"


the problem that seems like data corruption is that a few lines appear
twice as - and once as +.  but in the current version of the files,
those lines exist only once.  here are the lines.  there are 2 -
versions and one + version:

+***************** REF bigpart is a partition
+biglike and homelike are distracting nonsense i think except
+to describe inferior filesets.  anomalous subset of home
+might be called homelike or so.


emacs magit shows the same problem.  however, it shows a slightly
different diff.  i did a meta-diff on git diff vs. magit, and there
are about 800 + real-content lines that magit shows but git diff does
not.  i do not know what this means.  wc -l is like

  62540 aaa.diff
  62965 bbb--magit.txt

idk why a diff would be different with only + lines being different?


in summary, what is wrong with my repo, if anything, and what can i do
about it?  nothing on the web for git corruption seems to say much,
other than pull from github or whatever.  this is my own repo, the
original repo, so i cannot do that.  org annex has an uncorrupt tool
of some kind, but it did not seem relevant.  i do have rsnapshot
[basically rsync] backups of the repo and the most significant files
and dirs, but i do not know what one does to use that to repair any
issues.  i won't get into why, but changes were made over months.

is there a protocol for this?

would git fsck have balked?

thank you!


p.s.

i have no reason to believe this is related, but git diff has
intermingled emacs org mode entries.  but i don't have to talk about
it in org terms; in generic text terms, it has intermingled parts of
different paragraphs.  as a user, i'd prefer that completely unrelated
paragraphs not be mingled, regardless of minimality.  if possible.

with respect to the intermingling only, unless this is related to the
possible corruption, i will presume the diff is correct, in that a
patch from it would produce the same result as a patch that does not
intermingle.  i believe this intermingling is because diff does not
understand org, or paragraphs for that matter.  in org, an entry
starts with "^[*]+ " and ends at the beginning of another entry or at
eof.  they consist in my case mostly of ascii text paragraphs.  just
as with paragraphs, if you move an entry, you don't expect it to be
mingled with a different one in the diff.

i have been told that this cannot be fixed by merely telling a
slightly improved differ that stuff between stars is worth preserving,
but that a parser, not merely a couple of regexps, is needed to reduce
this intermingling.  i have also been told that difftastic uses
tree-sitter, which might get such a syntax for emacs org mode.  and so
maybe at some point git diff can use that.  idk.

idk if any of this is related but i include it for completeness.

also, please don't laugh, but i am using git version 2.11.0.  i will
upgrade pending various library and os stuff but my main concern is
not for git, but for possible corruption in the repo and what is
possible to do, at least given rsnapshot, to fix it.
