Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC93201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBXVC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:02:56 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33204 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:02:55 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so4344628pgj.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 13:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HF2HLzqNQiBLK5kZvdAkjzP+60v7G0IxuGxkQlaVS/E=;
        b=NrFXTb5jUEV6p1ecQ3R+HZIKlFoU45BCbIHpR0Qx2TaoynW4dvbb+uaOp7qVfpXdhy
         OtpboOzYqoc31nG4KAL0WNuf47AKd9gJb54W+Q0lgXXu3gpWmSA/8vs06A2042UMrxga
         azY7QS79QsrWeqDfsA/9FYiHvz5pVSAAkuiTnEjVhQSrnid8oQFEFz/34DIMIhE6McwD
         mKSJ6y2ZNIuwgZXElWOcwgp+YVaOP9PPq3nkGCOJm2f/2NjleFBeZnCT+7oEjsrU5roI
         tWXr/An19DrrN0S6mozfUstI7qSgixvRZHIT2w8Gul9CUU8Kbb4pT71TCazcFW/kXf8F
         J9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HF2HLzqNQiBLK5kZvdAkjzP+60v7G0IxuGxkQlaVS/E=;
        b=QE9+njigpq7s22JC4AA0GKJr//umsKYwgs0saDPNpl2ziszrvOqX8lwJAnTIPjQvjd
         +eWniRpHqZ1szGbHDZLUVG3zOShCYNr+325w6IpbEU3NT8xrMMLMJ+TUzDWxg8qf1mKr
         0WhvN5z2Il+HD07Gh6X0Sa3Hlbf+r5ZS7hKN5q4VeXHOjEWOOGUibQqSeZCgUpyM7Iu1
         ZHxKVLu6+wnkhcM1x9E3pvqQQBTXAmWEi1S7m4AQnoSkwJqmXyHwFJ5NpBKCzjtvl2Pu
         LIxJRdp52VAtn/rpS6uv89Ev6IkOWPR7oP1kkxV2qT84DrcHnAfpOL0CD02YlcSycxxW
         sQpQ==
X-Gm-Message-State: AMke39lwYZMy+OY+NdH3Aqmnw2BoHD0TI7dIfNq9TSaaRsRawVhde1X2H0bRZiZk8UhwaQ==
X-Received: by 10.99.174.4 with SMTP id q4mr6037641pgf.186.1487970174023;
        Fri, 24 Feb 2017 13:02:54 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id w16sm16788900pgc.15.2017.02.24.13.02.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 13:02:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 01/10] submodule: decouple url and submodule existence
References: <20170223234728.164111-1-bmwill@google.com>
        <20170223234728.164111-2-bmwill@google.com>
Date:   Fri, 24 Feb 2017 13:02:52 -0800
In-Reply-To: <20170223234728.164111-2-bmwill@google.com> (Brandon Williams's
        message of "Thu, 23 Feb 2017 15:47:19 -0800")
Message-ID: <xmqq8tov1ev7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Currently the submodule.<name>.url config option is used to determine
> if a given submodule exists and is interesting to the user.  This
> however doesn't work very well because the URL is a config option for
> the scope of a repository, whereas the existence of a submodule is an
> option scoped to the working tree.
>
> In a future with worktree support for submodules, there will be multiple
> working trees, each of which may only need a subset of the submodules
> checked out.  The URL (which is where the submodule repository can be
> obtained) should not differ between different working trees.
>
> It may also be convenient for users to more easily specify groups of
> submodules they are interested in as apposed to running "git submodule
> init <path>" on each submodule they want checked out in their working
> tree.
>
> To this end, the config option submodule.active is introduced which
> holds a pathspec that specifies which submodules should exist in the
> working tree.

Hmph.  submodule.active in .git/config would be shared the same way
submodule.<name>.url in .git/config is shared across the worktrees
that stems from the same primary repository, no?

Perhaps there are some other uses of this submodule.active idea, but
I do not see how it is relevant to solving "multiple worktrees"
issue.  Per-worktree config would solve it with the current
submodule.<name>.url without submodule.active list, I would think [*1*].

Also as a grouping measure, submodule.active that lists submodule
paths feels hard to use.  When switching between two branches in the
superproject that have the same submodule bound at two different
paths, who is responsible for updating submodule.active in
superproject's config?  If it were a list of submodule names, this
objection does not apply, though.



[Footnote]

*1* At the conceptual level, I agree that .url that also means "we
    are interested in this one" feels like somewhat an unclean
    design, but that is not what you are "fixing", is it?

