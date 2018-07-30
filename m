Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94A91F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbeG3Uvk (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:51:40 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44995 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbeG3Uvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:51:40 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so5191347ybk.11
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voJL7VRr/MB9AXHRIAgoSWtTCd+T1Do/5jcPfpI+xi8=;
        b=XnNf2LxkPYt5SoSyTWv05pmLOUiHk1CcVeVAq/tZ12ZFS21yxDywjfwgSxRHRGWh61
         xtHd62IN8iLyEj9ORQIWc/Hjuj0O2kpN0mTEasvn3lBrnQAcilpyv9iJOZExcQKvDkxt
         K2ePjVgnWGCClf5c4Lb9LpqMloLY0+kNRIPNA6pQWyf3WJJn14Z3BHAUyO4N7xPH1ARw
         qnxsxLUzfn7gvlvAE77jmTD9Yy/Gpcj3T7LZD0H9ys2JsgDLJmX3KndaEI6iyZpKxI5O
         fCOzOzrkmkaxtZv7QMJqNVqwsUeL2wy4zev84MEAGSPVhw/Q0RjUpqzzI4Csi2My1kVe
         42fg==
X-Gm-Message-State: AOUpUlFnrTlB96n6k/m/KKsqEJ89x/XlZ/wOWMa+JrMha7NwbNl3Isnd
        xKKwOEk/wYy5yKJEDh4wEltD/fY1k4uzCHcjC4WfY/ts
X-Google-Smtp-Source: AAOMgpd483667rfQDhZqt5hHCBmixsV52j0XT3BWA0spoiCbvGpR2n4vCXWtWcrDySq1iPazrbGZSlBlrQkFF9rpzx4=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr9814826ybq.295.1532978115020;
 Mon, 30 Jul 2018 12:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180730092929.71114-1-sunshine@sunshineco.com> <1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net>
In-Reply-To: <1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 15:15:03 -0400
Message-ID: <CAPig+cRaxgNVkvjumgiMY_ssmvKWRh6USBdu27WbBrT7y7SP3g@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Akinori MUSHA <knu@idaemons.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 8:14 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 30/07/18 10:29, Eric Sunshine wrote:
> > It was only after I diagnosed and fixed these bugs that I thought to
> > check 'pu' and discovered that Akinori MUSHA already made a stab[1] at
> > fixing one of the three bugs which this series fixes. Akinori's fix has
> > the somewhat undesirable property that it adds an extra blank line to
> > the end of the script, as Phillip correctly pointed out in review[2].
> > Patch 2/2 of this series has the more "correct" fix, in addition to
> > fixing another bug.
> >
> > Moreover, patch 2/2 of this series provides a more thorough fix overall
> > than Akinori, so it may make sense to replace his patch with this
> > series, though perhaps keep the test his patch adds to augment the
> > strict test of the "author" header added by this series.
>
> Johannes and I have some fixups for Akinori's patch on the branch
> fix-t3403-author-script-test at https://github.com/phillipwood/git

I don't see a branch with that name there. There are a couple "wip"
branches, however, named wip/fix-t3403-author-script-test and
wip/fix-t3404-author-script-test. I'm guessing you wanted me to look
at the former.

> That branch also contains a fix for the bad quoting of names with "'" in
> them. I think it would be good to somehow try and combine this series
> with those patches.

It appears that your patches are fixing issues and a test outside the
issues fixed by my series (aside from the one line inserting the
missing closing quote). As such, I think your patches can be built
atop this series without worrying about conflicts. That would allow
this commit-corruption-bug-fixing series to land without being tied to
those "wip" patches which address lower-priority problems.

> I'd really like to see a single function to read and another to write
> the author script that is shared by 'git am' and 'git rebase -i', rather
> than the two writers and three readers we have at the moment. I was
> thinking of doing that in the longer term, but given the extra bug
> you've found in read_author_script() maybe we should do that sooner
> rather than later.

Agreed. That seems a reasonable long-term goal but needn't hold up
this series which addresses very real bugs leading to object
corruption.
