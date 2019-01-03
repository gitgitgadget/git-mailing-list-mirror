Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65551F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 20:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfACU0A (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 15:26:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfACU0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 15:26:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so34811026wrr.0
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 12:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h0ziv8AvF8fQpNRkeWSa43ygtCQPGaGNjX//3WTZkxI=;
        b=rhTuDkYY+XuHDDr0/YG16xEykwZ5I4RHSbx9vQ2P+F5uWMS59Sryw2YO+ov+7t9yxv
         0TxC9Xx00jnNsURa7yMNmz7kmY+jybxnlxIYhayWSTUa1cb888bZB90q5DcrC2ltqn+D
         JN7Js5Ahm81t2I3+xI3caBrXmkREOa6zloLtyIbjhigy71mhyCJGl4UwijG+/MFyOiEP
         JsHUMyxWwX5XTEbronWzKYiqhZsHqeFKdsCu1F/j9S25vvGtOnEZyzUAgdGLX2jGxjVv
         pz8u9nLBFDvp1hZjjiPUsN6zsVeWQv6z6wbe26FxNJyD7XfHZV2mqp9ZR7fRHDnZShp8
         XWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h0ziv8AvF8fQpNRkeWSa43ygtCQPGaGNjX//3WTZkxI=;
        b=F/h8ac9Dv6C6O/1K+mYsJ2OPx3QogcK+s2GA4ZZTf/OnxAON9XqK92umzjGAA7wtOW
         R+DStVj5fOMxHKDfkHykWdW0LmUNxX5mHV0NnbNq+OFDAS3b+lBs30A/vc0LNXCkLhsC
         3MzAg+IlpHHDYtHZcrEb717Xe6tE1pHD4mu8U7qYbSvAts/D5WAJnVmO41zQMn4Eg2+s
         pYSRDAromUC2Nl9PU28Pp6hehYdEy1ZlNxlU2BWDA/zfYr3jAZAWrsbAyifxuKNRaL28
         U6pgwkvzVI2UMwCT2pI7QJ0o9c8wnwDtEJG8KHTjDRpkY/vume4OO/7xI5TEVymJaCzj
         tjoA==
X-Gm-Message-State: AJcUukd5OxQ3fmijallLNMMoHx6lNNq602n9d9BH+K70VEgNm9YX8RO6
        J8Dn+tsfd6KLcx1MKN7C6ag=
X-Google-Smtp-Source: ALg8bN6lmhtxuluNLcXctFXVJiAuUCs2F6FOHbPYqV6qaI4S1XPWPLksdSRfgYSX1BPDnn9QzxRb3g==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr39261385wrp.8.1546547158295;
        Thu, 03 Jan 2019 12:25:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 133sm31615479wme.9.2019.01.03.12.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 12:25:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Regression `git checkout $rev -b branch` while in a `--no-checkout` clone does not check out files
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
        <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
        <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
        <CACsJy8C=O=ZDvD0ReSJOyAsNDEb5Yz-iFvs7oV5zAXaFf-dw5g@mail.gmail.com>
Date:   Thu, 03 Jan 2019 12:25:57 -0800
In-Reply-To: <CACsJy8C=O=ZDvD0ReSJOyAsNDEb5Yz-iFvs7oV5zAXaFf-dw5g@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 3 Jan 2019 17:04:47 +0700")
Message-ID: <xmqqef9th4iy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I plan to revert this commit anyway when the new command "git
> switch-branch" comes. The optimization will be unconditionally in the
> new command without this hack and users are encouraged to use that one
> instead of "git checkout".

I tend to think that the behaviour is perfectly in line with what
Ben wanted to have, which is to make "checkout -b new [HEAD]" not to
touch anything in the index or the working tree at all.

It further is possible to argue that what is strange in the whole
episode is what "clone --no-checkout" does.  In such a repository,
if you say "git status", you'd notice that it is reported that all
paths have been deleted.

Now, if you instead do

	git clone $src dst
	cd dst
	git rm file
	git checkout -b new

i.e. starting from a clone with normal working tree, manually
removing a path or two, and then create a new branch starting from
that state while carrying all the local changes, you *do* want to
see that 'file' to stay missing.  After all, "do not lose the local
changes; carry them forward" is what switching branches is about.

And from that point of view, we could consider that

	git clone --no-checkout $src $dst

is equivalent to

	git clone $src $dst && git -C $dst rm -r .

Having said all that.

> Meanwhile, let's see if Ben wants to fix this or revert it.

A "fix" to Ben's optimization for this particular case should be
fairly straight-forward.  I think we have a special case in the
checkout codepath for an initial checkout and disable "carry forward
the fact that the user wanted all the paths removed", so it would be
the matter of adding yet another condition (is_cache_unborn(), which
is used to set topts.initial_checkout) to the large collection of
conditions in skip_merge_working_tree().

Back when the "optimization" was discussed, all reviewers said that
it would become maintenance nightmare to ensure that the set of
conditions accurately tracks the case where the optimization is
safe.  Now they are entitled to say "we told you so".
