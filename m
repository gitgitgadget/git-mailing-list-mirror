Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCA71F404
	for <e@80x24.org>; Thu,  1 Mar 2018 19:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161131AbeCATFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 14:05:22 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41349 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161067AbeCATFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 14:05:20 -0500
Received: by mail-pl0-f67.google.com with SMTP id k8-v6so4181906pli.8
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 11:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WG2x7stNk/QAq0gcdmMIQjvv9wu/G6cZD5HUqUxE73U=;
        b=XcZlb+oivMdgON/HaDKISvfl4g0p8fKJHkklHp7DLsTdOfTYoZITK47XvyLqQ+e8rv
         fWtT7vzvHo9GpQTPjSOhS08YqtnDiMQXEaVz/gYIIhcuL4Fb1Xs+PjuDb1b6XFVtTEN9
         PsI/OzecxAW/RU1yJQi3ag0zL3lh8qm6QRT9CtCdHUFrQHBvEENfflViu/oR2H44bLfw
         7E+XCasgQL1Zrg3srn5nAMxb3IFOS8u9XNspfWFLoMrQkTBKreKq7DuFh+yD7Og2LJyD
         92dU63KgKrhjfSUji9kQvzMgovekkETA3myzkhDGk0qUz6ds7A8TwykYGpZ+eIJdT/5t
         lQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WG2x7stNk/QAq0gcdmMIQjvv9wu/G6cZD5HUqUxE73U=;
        b=NJdjYBg3zywDKJhAKRb85dc9wDwUhv4WV5WJWvuobtGB1j2+GC0CxOHoznQqNb4Lt1
         jVKbeaNH41UsCM3W9kcOs3zTTAFiRYNZtGX/zSZ0nV40bXTH9QpUoT3JDstrGSXG7v64
         //LDeTCVqaWDlu1zqdL/2AhnqJxMBZhK7H0DNnIH9tQix4SLJUXO9dszHgOuXhGYdSMK
         84RCjISjytYEyc08NWR+QqJ1CVCedM6qFb+Z92WIgtHOjPtA/ihZLMwXsUOj8gxbXEld
         moikOEnd+sYIz7bKh4NV0CwZKmP3868c+e+5VPxIc1pCeBwp8h1iOYh3V69fNzQWHvoe
         BvQQ==
X-Gm-Message-State: APf1xPDIeNEqA3N48n7u39vYbzfcu7fx6CH++k0Hzn3yMlIacCnsabwA
        ZCWrn35V+4X2jmUBY/nmk6M=
X-Google-Smtp-Source: AG47ELtJNYcKikLeZyx/ObzE6YbHuw5YmFzUh6MmBs5J8AIr8iWawEC0M2dCpKOvUGR//XUjBRo2fg==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr2857364plz.436.1519931119504;
        Thu, 01 Mar 2018 11:05:19 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a14sm9125005pff.75.2018.03.01.11.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 11:05:18 -0800 (PST)
Date:   Thu, 1 Mar 2018 11:05:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Sergey Organov <sorganov@gmail.com>,
        igor.d.djordjevic@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The case for two trees in a commit ("How to make rebase less
 modal")
Message-ID: <20180301190507.GA165392@aiede.svl.corp.google.com>
References: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> $ git hash-object --stdin -w -t commit <<EOF
> tree c70b4a33a0089f15eb3b38092832388d75293e86
> parent 105d5b91138ced892765a84e771a061ede8d63b8
> author Stefan Beller <sbeller@google.com> 1519859216 -0800
> committer Stefan Beller <sbeller@google.com> 1519859216 -0800
> tree 5495266479afc9a4bd9560e9feac465ed43fa63a
> test commit
> EOF
> 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $ git fsck |grep 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $
>
> So it is technically possible to create a commit with two tree entries
> and fsck is not complaining.

As others mentioned, this is essentially a fancy way to experiment
with adding a new header (with the same name as an existing header) to
a commit.  It is kind of a scary thing to do because anyone trying to
parse commits, including old versions of git, is likely to get
confused by the multiple trees.  It doesn't affect the reachability
calculation in the way that it should so this ends up being something
that should be straightforward to do with a message in the commit body
instead.

To affect reachability, you could use multiple parent lines instead.
You'd need synthetic commits to hang the trees on.  This is similar to
how "git stash" stores the index state.

In other words, I think what you are trying to do is feasible, but not
in the exact way you described.

[...]
> * porcelain to modify the repo "at larger scale", such as rebase,
> cherrypicking, reverting
>   involving more than 1 commit.
>
> These large scale operations involving multiple commits however
> are all modal in its nature. Before doing anything else, you have to
> finish or abort the rebase or you need expert knowledge how to
> go otherwise.
>
> During the rebase there might be a hard to resolve conflict, which
> you may not want to resolve right now, but defer to later.  Deferring a
> conflict is currently impossible, because precisely one tree is recorded.

Junio mentions you'd want to record:
 - stages of the index, to re-create a conflicted index
 - working tree files, with conflict markers

In addition you may also want to record:
 - state (todo list) from .git/rebase-merge, to allow picking up where
   you left off in such a larger operation
 - similar state for other commands --- e.g. MERGE_MSG

Recording this work-in-progress state is in the spirit of "git stash"
does.  People also sometimes like to record their state in progress with
a "wip commit" at the tip of a branch.  Both of those workflows would
benefit from something like this, I'd think.

So I kind of like this.  Maybe a "git save-wip" command that is like
"git stash" but records state to the current branch?  And similarly
improving "git stash" to record the same richer state.

And in the spirit of "git stash" I think it is possible without
even modifying the commit object format.

[...]
> I'd be advocating for having multiple trees in a commit
> possible locally; it might be a bad idea to publish such trees.

I think such "WIP state" may also be useful for publishing, to allow
collaborating on a thorny rebase or merge.

Thanks and hope that helps,
Jonathan
