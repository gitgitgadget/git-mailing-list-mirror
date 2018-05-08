Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0727B200B9
	for <e@80x24.org>; Tue,  8 May 2018 05:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeEHFxu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 01:53:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37941 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeEHFxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 01:53:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id y189-v6so987154wmc.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A8NP5MZWiDCm7CY+sEnJIZGGrE2hi6INDe9gU9KjpOA=;
        b=Tx/iOn9WRWaPCbbAC7bfFJE58ZzCdShfG/6WsP4bulw0165k1g4XTsCCtZW1VeOCQe
         5CE66/sRTSpMVi/OKjIfNKm8BwbBI4AP4RcPuAurbm8Jjgo7I1AzSfNtrpvx0NUFdtDf
         QP7d2mDWhScnBIoUOk5e6bKopwarkbFXpRZMJiretY/KoekVqsdO+SCMZv2mjIkpmtPp
         PQhd4kGhojh8VurlJC7Uy1eFwdEQbzMFChPy4IWeGC1EO4jek1QyhuVYoocdkQFb+LD6
         REWGhFbzWcoPsTkvbSgXANtNKN8aFc8l2UAy7U1J8BvWpthHYJdo4LPbnEdA4Udxh9dY
         jwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A8NP5MZWiDCm7CY+sEnJIZGGrE2hi6INDe9gU9KjpOA=;
        b=LZV6sxwNczw4+PXh9cWb09KvV6k0By3pW8eK6TdSEEYkfkk+EqgY9+X26ut61C6DCV
         QXvxpSvMhO5jFwhN3imNQzELCnWRZJAdtKngjEXD7Tn2KaGb6tY8A9zASft6D9wmJcMo
         ErsOqkR2nfy1IIo6XGiTv3GjfvaoefC/0Vqe21FDrSQd6l8EaRdUpAXOkDligSOzd2UC
         A1ceCoVdHFl8XGtY2YIe6Ejab7VI8aENqOjLHjBhErULOog1LO08/ZbL76SbCG+fQsw4
         Q7JrHreKEyOZYHgJ1a7n8sUcx3A7RNIPKMnY7d9ivGt7mUBGf5zefxouJNsA4krAmD2O
         a2SQ==
X-Gm-Message-State: ALQs6tAHNDqU3zwZe5Vo4Jnn8JHXuU4rWiBChS3DfsEeWH0fV1ZxP47r
        5Xe4QZjcc2Rt7L1JkgLsoqs=
X-Google-Smtp-Source: AB8JxZp9q+qn3dp27puIssNwWQNM0xaoin0THhg6MN0c+KeAtQgpNwNGYNHC3sjPahSttqOErCJqXQ==
X-Received: by 2002:a1c:8645:: with SMTP id i66-v6mr2523665wmd.40.1525758828720;
        Mon, 07 May 2018 22:53:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x81-v6sm30575631wrb.23.2018.05.07.22.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 22:53:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick --no-commit does not work well with --continue in case of conflicts
References: <CAFU8umjvEATZguGDmcRMcfAkqn4LW7vf_B9qpLD7uc-E_7qR9g@mail.gmail.com>
        <xmqqd0y9sdei.fsf@gitster-ct.c.googlers.com>
        <CAFU8umjw-gz1UGHwiopHRJ-+v+KS2USqXV-9Qs0ieW8GaLpUsA@mail.gmail.com>
Date:   Tue, 08 May 2018 14:53:47 +0900
In-Reply-To: <CAFU8umjw-gz1UGHwiopHRJ-+v+KS2USqXV-9Qs0ieW8GaLpUsA@mail.gmail.com>
        (Ilya Kantor's message of "Sun, 6 May 2018 08:17:03 +0300")
Message-ID: <xmqqr2mmlml0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilya Kantor <iliakan@gmail.com> writes:

> P.S. I assume, `cherry-pick -n <commits>` is meant to merge given
> commits' changes into the current working directory and the index,
> without making new commits, for any given set of commits, hope that's right?

Hmph.

One step in cherry-pick should refuse to start when HEAD and the index
does not match, even though it is perfectly OK if the working tree
files do not match the index, as long as such local changes do not
interfere with the change the cherry-pick tries to bring in.

The requirement for the index to be clean wrt the HEAD is
fundamental.  When any merge-y operation like cherry-pick, apply -3,
checkout -m, etc., happens, we would want to

 * store the cleanly automerged contents to the index

 * store common-ancestor, ours and theirs for conflicted merge to
   the stages in the index.

and being able to safely say "git reset" (not "reset --hard") to
bring the index back to the state before the merge-y operation has
started.  Not noticing a dirty index and starting a step in cherry-pick
means you cannot tell cleanly automerged paths from paths you had
modified in the index _before_ the step started.

And if you have a range that consists of two commits and
successfully did "cherry-pick -n" on the first one, because the
command is not committing, these cleanly merged paths will be
modified in the index.  Then the next step to pick the second commit
may conflict---after that, you lose the result of the first pick
from the index as some changes from the second step is already
intermixed with the result from the first step in the index.

So, no.  I do not think it makes sense to feed multiple commits to
"cherry-pick -n".
