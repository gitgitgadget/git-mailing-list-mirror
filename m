Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6859FC4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97612083B
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1FN3vZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgI2Vhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2Vhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 17:37:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170BCC0613D2
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 14:37:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so7091963wrv.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lqPpNRDSYrzIhm6zkdGqiNSbWW9OxYeiyRrtVTBEQ6g=;
        b=s1FN3vZKkb70b+xABSs76anVHSsPEpNB77ZaBi7+BiQ7Np5Jj9jN8KhlAp1KcKN9Xq
         NbYCIBDwpghQzGu5PY18/z3v6oqepXdXOU/WRq+YeHTMK1QntQZ31s24iYxrLbx8ViV+
         u+12LKlNYJ+zgVTdQRzn96+nVkpS3rfzP80wvs97HIDx72Xj3dfCNE0x0A9HmbwSuFXL
         6RV7Ll2+v0kQXwNGsVf+aNZo40y72E9P3veSZVVD7tEG13DaHwdbe7SzABhxsxY3HNFd
         DjuFlbkSDt5A2jbygKmxmblaeMj6BxJT+zb97lYkYykA35EhyExNeIIZNdyu7Yydcar1
         bdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqPpNRDSYrzIhm6zkdGqiNSbWW9OxYeiyRrtVTBEQ6g=;
        b=GgeuJ3yexJeYc0JQK3VxuD+EHGU6Yr81D7M/8XcXEbaCqavS7jK08RK1pBwP8IirMj
         JdVqGgpqBNLCmTL7UWejy0QxWaQib98w2XwUqz4BJ47ccLjiTAZMlBNBRbl2zleIPcax
         XvG5e2Q9q0BXLedpwV9ceO2leQFHjbQwQRB6XhEdNm42iYbcwk+YU3JKehqe0Pz1p5WI
         iiFBtrBEV4RrROlQJ04ovebA7BX1QBMjIk5EWwhopdt5+jAUbIoUQ/yAhzpJ1AmuWlSy
         uTB4E/Pu5n3Qw5r2US1RJk7/iE7mFJBAaXxv9RnatHXBIfGDso94LTOFsUxUsKt7WGRY
         Oe1A==
X-Gm-Message-State: AOAM530WqsnViq8n22UeSBjmIAO3aBrJO1ezcunzypwt4EudfEPgT1xd
        9TfkAuEMhEW4efIPiGvm+bk=
X-Google-Smtp-Source: ABdhPJyV/0Fsy9OSjdN6kXfO62TDe1IgIP/46YPzlNbavJWvW2ViuzNAuI/dEKbJgEeTwK84qcsRrg==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr6937641wrq.302.1601415469639;
        Tue, 29 Sep 2020 14:37:49 -0700 (PDT)
Received: from contrib-buster.localdomain ([212.86.35.59])
        by smtp.gmail.com with ESMTPSA id q12sm7891634wrs.48.2020.09.29.14.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 14:37:49 -0700 (PDT)
Date:   Tue, 29 Sep 2020 21:37:47 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] t2402: add test to locked linked worktree marker
Message-ID: <20200929213747.GC1336@contrib-buster.localdomain>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <20200928154953.30396-3-rafaeloliveira.cs@gmail.com>
 <xmqq3631lg8f.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3631lg8f.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 02:54:24PM -0700, Junio C Hamano wrote:
> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
> 
> > Test the output of the `worktree list` command to show when
> > a linked worktree is locked and test to not mistakenly
> > mark main or unlocked worktrees.
> >
> > Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> > ---
> >  t/t2402-worktree-list.sh | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> 
> I think this should be part of [1/2], as the change necessary to
> implement the new feature is small enough that there is no reason
> to split the test part out.

Sounds good

> 
> > diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> > index 52585ec2aa..07bd9a3350 100755
> > --- a/t/t2402-worktree-list.sh
> > +++ b/t/t2402-worktree-list.sh
> > @@ -61,6 +61,19 @@ test_expect_success '"list" all worktrees --porcelain' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'show locked worktree with (locked)' '
> > +	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
> > +	test_when_finished "rm -rf locked unlocked out actual expect && git worktree prune" &&
> > +	git worktree add --detach locked master &&
> > +	git worktree add --detach unlocked master &&
> > +	git worktree lock locked &&
> > +	echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD) (locked)" >>expect &&
> > +	echo "$(git -C unlocked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> > +	git worktree list >out &&
> > +	sed "s/  */ /g" <out >actual &&
> > +	test_cmp expect actual
> > +'
> 
> This seems to prescribe the output from the command too strictly
> (you do avoid being overly too strict by removing the indentation
> with 's/ */ /g' though).  
> 
> If the leading path to the $TRASH_DIRECTORY has two or more
> consecutive SPs (and that is not something under our control), the
> 'expect' file would keep such a double-SP, but such a double-SP in
> 'out' would have been squashed out in the 'actual' file.
> 
> I wonder if
> 
> 	grep '/locked  *[0-9a-f].* (locked)' out &&
> 	! grep '/unlocked  *[0-9a-f].* (locked)' out
> 
> might be a better way to test?  That is
> 
>  - we do not care what the leading directories are called
>  - we do not care what branch is checked out or how they are presented
>  - we care the one that ends with /locked is (locked)
>  - we care the one that ends with /unlocked is not (locked)
> 
> After all, this new test piece is not about verifying that the
> object name or branch name is correct.

Sounds good and I agree with the all, and seems even easier
to understand the test code this way. Will address this change on the next patch,
although I'm not sure whether somebody could run into any issues when
running the `grep` command in other platforms. I'll look into it.
