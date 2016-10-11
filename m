Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57301F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 20:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753735AbcJKUxK (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 16:53:10 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36256 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbcJKUxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 16:53:04 -0400
Received: by mail-qk0-f181.google.com with SMTP id o68so53018691qkf.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qeXBfKoKy6niU0RYqecIt1iZhXhXKXNKtV4pzcOyCP8=;
        b=Px6b+ZkNVH0EpLsThxCYudfo+LB3KYQo716iZiHRhkxf8jDx/rbLZQrH4r3GWjLq4f
         iXQIQEZoRhQBze7T37FEnY56gOuuOodHwf1F8tG9sE174F/L8dsDYQiuiq0xcwVaD0K2
         Hriy9h8Y3UKvh96mztC1/WAM27Mp6DKB1Xp00yFEFtkT17HMObU4LB8FU4i+eesHmPT7
         H91LYk+1DgyFJ23mCu1kbfpBTSqs8JjzQd9FgvoQkerX5xYVtvkVu2qY6AsMRmKU8fEv
         A/DS15B1yDcA7OT54lf4pgQQTq16iOKdZEprn5O1bQ6IbVw3eMBk5ypcjVAOswqMbG2P
         eJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qeXBfKoKy6niU0RYqecIt1iZhXhXKXNKtV4pzcOyCP8=;
        b=X8CsyCgFpR/zvH/+OQNFSKYKzQtRuCDGd6E9VP3kcGvw2jdRs17lTcc9cIO/iumZNl
         C+wsedDPfN2Ngxd08Yo/0j+NoqbYnnqOlhMs70ApJVIejwmODOqa+FjWtTNzZQ6i0m9K
         az9MaC0pZCFKVaMxj3Il8V13ZssQhBOBix4dlrlPFm1D1hDgyc1mhP+G+Rubg2m59VJ2
         zpVYevhA+s3kkAOj5rXlu+nSOdr6Bellv3ABvPCRDaDHZDZ26EDZo2LsxKjCKK93UXRM
         Sy7bT1XOQEPQbpFDLFQ+fGBaoufyBBH0HAArj1ya5+MJZ3zCKSZkp6vu5qjrYMOs7Js3
         G8RQ==
X-Gm-Message-State: AA6/9Rnyv8xJTlaFsAXBAkXxmZyqoE9koZuyvfp0ZVmMcvixFM1wI9W2KGGN6F2Xa7oJw9tPzIgKgnZsk34LvcrL
X-Received: by 10.55.56.11 with SMTP id f11mr4938565qka.255.1476219183642;
 Tue, 11 Oct 2016 13:53:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 13:53:03 -0700 (PDT)
In-Reply-To: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 13:53:03 -0700
Message-ID: <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
Subject: Re: Make `git fetch --all` parallel?
To:     Ram Rachum <ram@rachum.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 1:12 PM, Ram Rachum <ram@rachum.com> wrote:
> Hi everyone!
>
> I have a repo that has a bunch of different remotes, and I noticed
> slowness when doing `git fetch --all`. Is it currently made
> sequentially? Do you think that maybe it could be done in parallel so
> it could be much faster?
>
> Thanks,
> Ram.

If you were to run fetching from each remote in parallel
assuming the work load is unchanged, this would speed up the
execution by the number of remotes.

This translation sounds pretty easy at first, but when looking into
the details it is not as easy any more:

What if 2 remotes have the same object (e.g. the same commit)?
Currently this is easy: The first remote to fetch from will deliver that
object to you.

When fetching in parallel, we would want to download that object from
just one remote, preferably the remote with better network connectivity(?)

So I do think it would be much faster, but I also think patches for this would
require some thought and a lot of refactoring of the fetch code.

The current fetch protocol is roughly:

remote: I have these refs:
8a36cd87b7c85a651ab388d403629865ffa3ba0d HEAD
10d26b0d1ef1ebfd09418ec61bdadc299ac988e2 refs/heads/ab/gitweb-abbrev-links
77947bbe24e0306d1ce5605c962c4a25f5aca22f refs/heads/ab/gitweb-link-html-escape
...

client: I want 8a36cd87b7c85a651ab388d403629865ffa3ba0d,
and I have 231ce93d2a0b0b4210c810e865eb5db7ba3032b2
and I have 02d0927973782f4b8b7317b499979fada1105be6
and I have 1172e16af07d6e15bca6398f0ded18a0ae7b9249

remote: I don't know about 231ce93d2a0b0b4210c810e865eb5db7ba3032b2,
nor 02d0927973782f4b8b7317b499979fada1105be6, but
I know about 1172e16af07d6e15bca6398f0ded18a0ae7b9249

.... conversation continues...

remote: Ok I figured out what you need, here is a packfile:
<binary stuff>


During the negotiation phase a client would have to be able to change its
mind (add more "haves", or in case of the parallel fetching these become
"will-have-soons", although the remote figured out the client did not have it
earlier.)

If you want to see more details, see Documentation/technical/pack-protocol.txt
