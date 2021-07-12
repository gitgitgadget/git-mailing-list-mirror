Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233E3C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5E5606A5
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhGLRdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhGLRdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:33:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9CDC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:30:32 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso19621415oty.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GK1VQ67oIghJyh28U/naXxWrkvrX1qoERQFT8nAerN8=;
        b=kbvWRU2HBqDdWeDBNp6gqCJ8lQrxqL3kktdTsxfbuhruSbf6xpI4/6jzWhDmrkQCnm
         wXz6tMccE+2Gz3D263GpoWOMJPtbK5SMEsqVOhG2EKCDO0mDSWeSuzxVBM48xVxvFYlI
         QuWFC2B9iCpHRM6vl+PQl6cJnasVHrFP1oGaae7BcgfiZFCIEd/IfMx/yW8Wzwu365P/
         wTqMsyQg6bynhUrkX4Cq9W4Cuf/fVUF89x1ZekT7ueSlWLwyTI+MGjidXaH0okBrPofm
         tnZOg4b+BvGC5c+zjbDMwG8qNQNqaIEVLPRW6yWbDJaH7mtnSdG4Xb91hvTpgvVhgb5M
         M0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GK1VQ67oIghJyh28U/naXxWrkvrX1qoERQFT8nAerN8=;
        b=pdNp8tQ/AM2eueDTJ0hQ/zEdw5lgHtovnxBRKMKDTEnQskq1i2XHT7uKfZBvNCJzsX
         cZKBpmDbF8nqREqOR57HmZ9O58oDhXPPDIZ0TBZNIJtJ7frrKUbx0T40UUK1Q3SXwnfu
         GrvvozRK5l1b6XmRLAzbiw37aQt6mUgMC/CmHpSDBosmlRJHWQvK4//rA7CZSYQaNwe8
         YEgVIjGfeGlqPrlM8oY8v2LN1OVSQ+5em0fweleH1dD3mzBbrS2hRAYjoe5J3EI0vD+h
         cUeR18sFrk93ufj6J/jIm09XPyN+QkKPSXjtFV4Hm6yu3llXZERC5MeuMqWnSRI5GLIu
         ajsA==
X-Gm-Message-State: AOAM531tmCwO6NsO5kJh7E12YXWtjLDOU1O3tCubE7bJacSqRnk0neT8
        0XxCvFDpxfDuoo0BHUd9Z10=
X-Google-Smtp-Source: ABdhPJwG46GsC+m1730BS/cOk9GT2h1UttPotVfhrD9koTRCI3PzDfYiZQdQtKmYvdFjv5qb+o909A==
X-Received: by 2002:a05:6830:1495:: with SMTP id s21mr119415otq.86.1626111031887;
        Mon, 12 Jul 2021 10:30:31 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y18sm3201452oiv.46.2021.07.12.10.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:30:31 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:30:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, felipe.contreras@gmail.com, newren@gmail.com
Message-ID: <60ec7c3636327_a45252081d@natae.notmuch>
In-Reply-To: <xmqqpmvn5ukj.fsf@gitster.g>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
 <xmqqpmvn5ukj.fsf@gitster.g>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > Thanks for revising this patch, I like this approach much better. I do
> > however have some concerns about the interaction of pull.ff with the 
> > rebase config and command line options. I'd naively expect the
> > following behavior (where rebase can fast-forward if possible)
> >
> >   pull.ff  pull.rebase  commandline  action
> >    only     not false                rebase
> >    only     not false   --no-rebase  fast-forward only
> >     *       not false    --ff-only   fast-forward only
> >    only     not false    --ff        merge --ff
> >    only     not false    --no-ff     merge --no-ff
> >    only       false                  fast-forward only
> >    only       false      --rebase    rebase
> >    only       false      --ff        merge --ff
> >    only       false      --no-ff     merge --no-ff
> 
> Do you mean by "not false" something other than "true"?  Are you
> trying to capture what should happen when these configuration
> options are unspecified as well (and your "not false" is "either set
> to true or unspecified")?  I ask because the first row does not make
> any sense to me.  It seems to say
> 
>     "If pull.ff is set to 'only', pull.rebase is not set to 'false',
>     and the command line does not say anything, we will rebase".

No, pull.rebase can have values other than true, like "merges".

  git -c pull.ff=only -c pull.rebase=merges pull

This should rebase because pull.ff=only is meant only for --merge.

> I do agree with you that the command line options
> 
>     --ff-only
>     --ff (aka "allow ff")
>     --no-ff
> 
> should override pull.ff and

Yes.

>     --rebase
>     --no-rebase (aka "merge")
> 
> should override pull.rebase configuration settings

Yes.

> and also override pull.ff set to 'only'

No.

pull.ff=only is specifically set for when the user wants to do a merge,
*not* a rebase.

  git -c pull.ff=only pull # fast-forward merge
  git -c pull.ff=only pull --rebase # rebase
  git -c pull.ff=only pull --no-rebase # fast-forward merge

Whether the merge is implied becuse it's the default, or the user has
explicitely specified it with --no-rebase (should be --merge) does not
matter.

> (i.e. the user explicitly
> wants intregration of the two histories and at that point "I usually
> just follow along" which is "pull.ff=only" no longer applies).

Nowhere in the description of pull.ff does it say that --no-rebase turns
off pull.ff=only.

pull.ff::
	By default, Git does not create an extra merge commit when merging
	a commit that is a descendant of the current commit. Instead, the
	tip of the current branch is fast-forwarded. When set to `false`,
	this variable tells Git to create an extra merge commit in such
	a case (equivalent to giving the `--no-ff` option from the command
	line). When set to `only`, only such fast-forward merges are
	allowed (equivalent to giving the `--ff-only` option from the
	command line). This setting overrides `merge.ff` when pulling.

That would be a pretty convoluted semantic change.

And BTW, why would these four produce different results?

  git -c pull.ff=only -c pull.rebase=false pull
  git -c pull.ff=only pull --no-rebase
  git -c pull.rebase=false pull --ff-only
  git pull --ff-only --no-rebase

-- 
Felipe Contreras
