Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362991F404
	for <e@80x24.org>; Mon, 12 Mar 2018 21:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeCLVf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 17:35:27 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:39332 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbeCLVfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 17:35:24 -0400
Received: by mail-pl0-f43.google.com with SMTP id s13-v6so10093918plq.6
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=omWw38AaBVLxCbHAb+OVERb0teKRaGiywn5aDx+NkE4=;
        b=UgdWhmdsFomrll9p7CC77R/oBuMrrLRLuBrK3fk7iJl/QVblyeqHMfZepcIMGqY8qJ
         b7FVMSKI9iwNimUUx8zcN9HikmHd4CHI3ilAfgbUM3Lbj+yxveZ4bTwcSpssZS9JyWD0
         9R7QdvWIasAL2Wb0JlSC2ITu09qG35roGT7gZSuZEb7En/9TVQQM6b3sfx8+kLN3E2ft
         XesT/bu46gPvnWOKhSlUb4m/Bx518PTsm4SYEJD9z58Mk08ZudUXpVRjV2BlgEZakEVn
         tTm19KOvguru6RvCK0wcInUYHBERYhTGYQ4KReO9eDaJT7SD02RTPZGXawuYc5WrLUFI
         4gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omWw38AaBVLxCbHAb+OVERb0teKRaGiywn5aDx+NkE4=;
        b=PVKXIKZWpaAdlGwRQJJNgEgKXltmHatMeP5y/pB0gSenBvDUPdCeKfqhsCoY8iVbHb
         rEe+xZar7wnz73pTd2P2iOLd/gLxRh5bLMVr7QBTV84/a2vNyEmf7wsERsu4nVulTWjf
         0CI2b4bPPHuckEzJ842+kb8fhkxu+U4PhbUCph2G+xzvCUgIoYgLiGlSS99DQN7XZd+Y
         1OYTEzuW60skybr03OQMgGwp8x6QExZrQwF+TvQZti6wVD2oJryZnFbGb3oNaH4AfrCI
         0zEjeuCCqVI6qabBuO2eLLqi9kFRlVBfcEky8QeFeobqrS4KvjCbYs6Uhm4Rra6dIjSH
         +KkA==
X-Gm-Message-State: AElRT7F17Ffp1chOtm76dNIAd2VKOF+kzwlcNDbqXz2BPX2yGE/tL0Sd
        xZngMzx656Dh8oyW4HI8XkvKmga5
X-Google-Smtp-Source: AG47ELvb3Pztk9fNZ5tYmckzHmqo/iiJ56h4jUSxqdgqqGHkdt/pUwFiKT0wpwquT4L0mKU/hM9O/g==
X-Received: by 2002:a17:902:aa43:: with SMTP id c3-v6mr9457589plr.357.1520890523952;
        Mon, 12 Mar 2018 14:35:23 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c67sm19396893pfl.106.2018.03.12.14.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 14:35:23 -0700 (PDT)
Date:   Mon, 12 Mar 2018 14:35:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Opinions on changing add/add conflict resolution?
Message-ID: <20180312213521.GB58506@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com>
 <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Elijah Newren wrote:
> On Mon, Mar 12, 2018 at 11:47 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Would this behavior be configurable or unconditional?  I suspect I
>> would want it turned off in my own use.
>>
>> On the other hand, in the case of wild difference between the two
>> files, skipping the two-way merge and just writing one of the versions
>> to the worktree (like we do for binary files) sounds like something I
>> would like in my own use.
>
> I think you just said the exact opposite thing in these last two
> paragraphs; that you wouldn't want my proposed behavior and that you'd
> want it.  I suspect that may mean that I misunderstood something you
> said here.  Could you clarify?

Sorry for the lack of clarity.  My understanding was that the proposed
behavior was to write two files:

	${path}~HEAD
	${path}~MERGE

My proposal is instead to write one file:

	${path}

with the content that would have gone to ${path}~HEAD.  This is what
already happens when trying to merge binary files.

[...]
>> Can you add something more about the motivation to the commit message?
>> E.g. is this about performance, interaction with some tools, to
>> support some particular workflow, etc?
>
> To be honest, I'm a little unsure how without even more excessive and
> repetitive wording across commits.

Simplest way IMHO is to just put the rationale in patch 5/5. :)  In
other words, explain the rationale for the end-user facing change in the
same patch that changes the end-user facing behavior.

>                                     Let me attempt here, and maybe you
> can suggest how to change my commit messages?
>
>   * When files are wildly dissimilar -- as you mentioned -- it'd be
> easier for users to resolve conflicts if we wrote files out to
> separate paths instead of two-way merging them.

Today what we do (in both the wildly-dissimilar case and the
less-dissimilar case) is write one proposed resolution to the worktree
and put the competing versions in the index.  Tools like "git
mergetool" are then able to pull the competing versions out of the
index to allow showing them at the same time.

My bias is that I've used VCSes before that wrote multiple competing
files to the worktree and I have been happier with my experience
resolving conflicts in git.  E.g. at any step I can run a build to try
out the current proposed resolution, and there's less of a chance of
accidentally commiting a ~HEAD file.

[...]
> There are three types of conflicts representing two (possibly
> unrelated) files colliding at the same path: add/add, rename/add, and
> rename/rename(2to1).  add/add does the two-way merge of the colliding
> files, and the other two conflict types write the two colliding files
> out to separate paths.

Interesting.  I would be tempted to resolve this inconsistency the
other way: by doing a half-hearted two-way merge (e.g. by picking one
of the two versions of the colliding file) and marking the path as
conflicted in the index.  That way it's more similar to edit/edit,
too.

Thanks,
Jonathan
