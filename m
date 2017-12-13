Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18CD51F407
	for <e@80x24.org>; Wed, 13 Dec 2017 23:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbdLMXMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 18:12:31 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:41995 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdLMXMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 18:12:30 -0500
Received: by mail-wm0-f49.google.com with SMTP id b199so8104170wme.1
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 15:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h6HAkLaUNb+zaJB6+Af280gpPQNYspaxUfqZ89fEMtI=;
        b=jsvHs1KFXQ+iDlPVFVmo6NvqA5StJfGjKPtmQ/S7awN47Pg0mbl0aH5rr3KNlU1IzA
         wgZ6tdPu2PQ2vGh5D5zObdMwHwuLqJjtURyjXx8bYQ18NHkGxgS0J8MXTXQm/3DINPaO
         K61sNaLxMA544x8lYQEbqerk55Q5+HqyLOxnzIKJUGj7boSH2IwP1DdOCCyHz9K1o+H+
         L5wxXOijWc4EYWsGpqGXJIYUhiJgM+J5OQDyKB8xSSAlyKbh2EX7F9l/IJVQ37YJqa2j
         gUcY/MpXpGXtNFSjJkmVxhdMGUCgvWGB4AGfNwJ3zN1yPhKipyGoTEv6KJOTZzi5Nxix
         +90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h6HAkLaUNb+zaJB6+Af280gpPQNYspaxUfqZ89fEMtI=;
        b=b9X27wcorGaZlMHeaHS9CXnV+V2UKWUnTUBzLLDfuCrQ+kMIOSxpS57dCy8cCFXx6i
         uOvjPX4r3P7ctBL90QXCLkMc1JbaMBNVHcLLD0AQ7ADuREiHm27Yi5nzqCrmCb8CdsL5
         JDtNnTu0UqTqlyaVyxTP9vPwdZwSHdDBp3epX5hxDj4TsbajHEouYOOvXVwj+e/7G97y
         hobFtYdd661NB5z0nkoVr2dwGw4+eFB8XL232rSHI/v412B+Pny2X8XOlPFXnMjNQBo3
         g5DGq/CqRnhV91iIkGfs8/bPcOSyAsX0rSjZtcpanKQNuieJ+WiqoKKxzPqz04I91X3n
         4Qzg==
X-Gm-Message-State: AKGB3mJDFp+HqfcabTC4uaO/7NbhHG5OgIqHnLIrk92w/gipQ5u2W8Jc
        27QJ1YhR/QHlrjXX+R921LQ=
X-Google-Smtp-Source: ACJfBovkew6UJdhr4oiIc8Pvj5pAEPmx7KDhPHNZGsr+wADYDu0zlKVtit1MaAysnRee6rChn+HjEg==
X-Received: by 10.28.131.73 with SMTP id f70mr463213wmd.153.1513206749006;
        Wed, 13 Dec 2017 15:12:29 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f90sm3256345wmh.12.2017.12.13.15.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Dec 2017 15:12:28 -0800 (PST)
Date:   Wed, 13 Dec 2017 23:14:14 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Reid Price <reid.price@gmail.com>, git@vger.kernel.org
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
Message-ID: <20171213231414.GD24597@hank>
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
 <0692d5b8-5fc7-c34c-0712-11a913267441@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0692d5b8-5fc7-c34c-0712-11a913267441@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13, Igor Djordjevic wrote:
> Hi Reid,
> 
> On 13/12/2017 18:32, Reid Price wrote:
> > 
> > When running 'git stash push <subdir>' if there are both tracked and
> > untracked files in this subdirectory, the tracked files are stashed
> > but the untracked files are discarded.
> 
> I can reproduce this as well (git version 2.15.1.windows.2).
> 
> For what it`s worth, using `git stash save <subdir>` instead seems to 
> (still) work as expected...

I think that depends on what you expect ;)  'git stash save <subdir>'
will create a stash of the whole working directory with the message
"<subdir>".  So while it would indeed work for the presumably
simplified example Reid provided, it would not do what you'd expect if
there are any tracked and modified files outside of the <subdir>.

In that case 'git stash save <subdir>' would include the tracked files
outside of <subdir>, while what I assume Reid wanted is to keep them
in place, and only stash the files in <subdir>.

> but on the other hand, `git-stash`[1] 
> manpage seems not to mention this usage ("save" with "pathspec")?

"stash save" with "pathspec" doesn't exist, and it will probably never
exist.  We decided to introduce a new "push" verb for 'git stash'
because the command line for 'git stash save' takes a message as its
last argument, instead of taking the message with a -m flag like other
commands do.  Introducing a pathspec argument for "git stash save"
would have either broken backward compatibility, or it would have had
some syntax that's very inconsistent with other git commands.

> Regards, Buga
> 
> [1] https://git-scm.com/docs/git-stash
