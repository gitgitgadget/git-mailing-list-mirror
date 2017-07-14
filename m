Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AAEA2036B
	for <e@80x24.org>; Fri, 14 Jul 2017 22:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbdGNWul (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 18:50:41 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33883 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdGNWuk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 18:50:40 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so51989209pgb.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zbdRQ3Jh6U3rx3vz6L6Kb6mipaLEK4PlAITIk0mCJGo=;
        b=AJfKOdYG7fJQ4B0CUuzwOldqKBFIIOn9IMk7gMMd0KdvPd07JdMLaxbzuCNO3iMp6s
         sZbh6G3mdmUiSYVYmnfuk0Hol3D+thG3ysZ/RQpVBI9pPlI23rbxr4gUcimsiuwNuErp
         jKi90POmABFIRgceA4RQzYJLvIA1gYDLJEA6M+ht3qXC7m5T/hmVOxVYaKoxokEw+vSe
         2rvYkFO7KBpGmPP75PIbQLqH5vVzeHlfPbe9Po7tQbS6R/YxvVHiHM4vbIpjYA4EpT7h
         FGBscT3zAHznaQd92XeZ7CzjOgoGVNzgOJJeOvUElkYALuW0VyMN3zgySBZTo40pOVAT
         dC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zbdRQ3Jh6U3rx3vz6L6Kb6mipaLEK4PlAITIk0mCJGo=;
        b=DaGrAkooA48bB71DjnTdRW3qD5esJZI0aMKUFeUvOHrkAwAFinb4xKDcrkp1o18MhG
         TZR7Y/SNUhBvqDmYjJR2HiJKNszJQMN10i/hEVHDBOYOXbNJoLyJuvC6aH7x2/Tt41uJ
         7pTm6PpUAt104HM6dpYgL+uEAggtzTramOIAo9SXHmLft2qrrjd6ugKTet0vyT4P7x/P
         pAos6dpF6AG/C//q/516Gk1rBgA/BeYLn5e8Mgq6+rJ6c9L3Wx8Uvtz4iLHHY9/K6wxk
         WtulqMPvqJaEng/7ogjYbPpb8Ebdt3kBb/DRV2+Gzn/uYuyA/cu94ARPckwMd2jOpxsK
         xpwQ==
X-Gm-Message-State: AIVw1118s+wqRGnS5ihmmnTxPzKunrEfYEkn68nTs6E066HRCMABcKFc
        rhY3PVp9kKDHj9NOF37hstV7v2rmJBym
X-Received: by 10.84.129.69 with SMTP id 63mr19029974plb.0.1500072640294; Fri,
 14 Jul 2017 15:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Fri, 14 Jul 2017 15:50:39 -0700 (PDT)
In-Reply-To: <814284075336e715dd52859e69aeb41226624af7.1500043437.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de> <814284075336e715dd52859e69aeb41226624af7.1500043437.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 14 Jul 2017 15:50:39 -0700
Message-ID: <CAGZ79kYFgR_Lo-hWq6_UanvidG6a9H54qop=sg_33FCsA9Z0pQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] rebase -i: generate the script via rebase--helper
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 7:44 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The first step of an interactive rebase is to generate the so-called "todo
> script", to be stored in the state directory as "git-rebase-todo" and to
> be edited by the user.
>
> Originally, we adjusted the output of `git log <options>` using a simple
> sed script. Over the course of the years, the code became more
> complicated. We now use shell scripting to edit the output of `git log`
> conditionally, depending whether to keep "empty" commits (i.e. commits
> that do not change any files).
>
> On platforms where shell scripting is not native, this can be a serious
> drag. And it opens the door for incompatibilities between platforms when
> it comes to shell scripting or to Unix-y commands.
>
> Let's just re-implement the todo script generation in plain C, using the
> revision machinery directly.
>
> This is substantially faster, improving the speed relative to the
> shell script version of the interactive rebase from 2x to 3x on Windows.

Thanks for working on this


> +int sequencer_make_script(int keep_empty, FILE *out,
> +               int argc, const char **argv)
> +{

> +       init_revisions(&revs, NULL);
> +       revs.verbose_header = 1;
> +       revs.max_parents = 1;
> +       revs.cherry_pick = 1;
> +       revs.limited = 1;
> +       revs.reverse = 1;
> +       revs.right_only = 1;
> +       revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> +       revs.topo_order = 1;
> +
> +       revs.pretty_given = 1;
> +       git_config_get_string("rebase.instructionFormat", &format);
> +       if (!format || !*format) {
> +               free(format);
> +               format = xstrdup("%s");
> +       }

https://public-inbox.org/git/xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com/

So this is the core part that you and Junio have differing opinions on.

> All of the above feels like inviting unnecessary future breakages by
> knowing too much about the implementation the current version of
> revision.c happens to use.  A more careful implementation would be
> to allocate our own av[] and prepare "--reverse", "--left-right",
> "--cherry-pick", etc. to be parsed by setup_revisions() call we see
> below.  The parsing is not an expensive part of the operation
> anyway, and that way we do not have to worry about one less thing.

Allow me go through each of the options which may help
us finding a consensus (at least it helps me having a more
informed opinion).
List of options used outside of revision.c, which in the ideal
world of Git are parsed in e.g. handle_revision_opt called
from setup_revisions:

.verbose_header
  bisect.c:       opt.verbose_header = 1;
  builtin/commit.c:       rev.verbose_header = 1;
  builtin/log.c:  rev->verbose_header = 1;
  builtin/log.c:  rev.verbose_header = 1;
  builtin/log.c:  rev.verbose_header = 1;

.max_parents
  builtin/log.c:  check_rev.max_parents = 1;
  builtin/log.c:  revs.max_parents = 1;
  builtin/log.c:  rev.max_parents = 1;
  builtin/log.c:  revs.max_parents = 1;

.cherry_pick
  is clean!

.limited
  ref-filter.c:   revs.limited = 1;

.reverse
  seems clean.

.right_only:
.sort_order:
  is clean!

.topo_order:
  builtin/fast-export.c:  revs.topo_order = 1;
  builtin/log.c:  revs.topo_order = 1;

.pretty_given
  builtin/log.c:  if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
  builtin/log.c:  if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {

There are two conflicting messages I get:
* only a few fields seem to be polluted (verbose_header,
  max_parents), much fewer than I thought
* we do use these undocumented ways already,
  but not at the scale that DScho is trying to here.

In the reply to the cover letter I outlined that we may have
a problem with integrating the repository struct when using
string arrays only.

Thanks,
Stefan
