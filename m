Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E471F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfARSGH (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:06:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53003 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbfARSGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:06:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so5339254wml.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FhiQoE9tvdpmA8mNf+lY0xZTjdS3I7gQCsa73hw8YxA=;
        b=D9c5czU7ea32VVRXCOOr/UXTYIVVMzo6QOnzvlTAbvQvEE2xTSNjwRPMXqVJiwNgr1
         tr357/law3Zi7AcKnY8t+oeWpVC3Oax0r2FlfG+sFwAZ+2IHZGxCa8l5XhllagHex9y+
         c4cXF1BFI0vsKYepUVwY7tym6U/2USv9WM5mFWns0h6pr0g9LY/OGnANTcOpWDkjutf8
         +kh2e7g3Jzs2LkJ/vu+8Fut/y/kCysFNxfGG26lfIByICtFsjt8flPg7wcCsfiIEtsup
         i8BtmgBAH9rDYrGYdps4jahzXlczR7oaMaikV9gSM6VhqE1zOjlM7D5/HMBbQGJw/h20
         hWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FhiQoE9tvdpmA8mNf+lY0xZTjdS3I7gQCsa73hw8YxA=;
        b=t241kUe7M9yatHtvqIhZ67lhV8Bq4lQAjU7Muc2lp+9Dca4z9fhXOB1hhHykejHDf6
         syJunvhidmpTMdo/3/IJn0+Ejz4J5xjL0mcRSixjrlO2OwmXa7IdRC4q/DuRuSFPwAGN
         OLdVdxkBAxsTISVuvB+WO07fC/6hs+tRVzXZZ+oAd3/QKaGvW88fOdchbSDpyUMzmxMa
         QPQFsGcoIw8VpuF2sqiQHDVDim+koLl3g0BvEfF2yZdafdh/OslxS0bux+GC8wsFK9RQ
         3P3TGfyqGSp7XqSI4gx6y8vVrVkWGinmQddtOMWF0WH/kPsmOcDSTgwvBOlJdsdTrMWX
         F+cQ==
X-Gm-Message-State: AJcUukfatM7pycAaOubNs6caqVP/Gx29v+Jj6Po7PzeLIZkM+09/t56D
        KvZl1BMrktid3+9HuAFCsoRaHxni
X-Google-Smtp-Source: ALg8bN7/YTmkmEXFO8HDAollzjm98NLHUlDZDPCPoGyhzcSzEmgfVBBAg/LHyXz4ZYg5F29uU3erkQ==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr16301103wma.76.1547834764785;
        Fri, 18 Jan 2019 10:06:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y13sm66934229wrn.73.2019.01.18.10.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 10:06:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Let the builtin rebase call the git am command directly
References: <pull.24.git.gitgitgadget@gmail.com>
        <pull.24.v2.git.gitgitgadget@gmail.com>
Date:   Fri, 18 Jan 2019 10:06:03 -0800
In-Reply-To: <pull.24.v2.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Fri, 18 Jan 2019 07:09:23 -0800 (PST)")
Message-ID: <xmqqef99lu2c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Especially on Windows, where Unix shell scripting is a foreign endeavor, and
> an expensive one at that, we really want to avoid running through the Bash.
>
> This not only makes everything faster, but also more robust, as the Bash we
> use on Windows relies on a derivative of the Cygwin runtime, which in turn
> has to jump through a couple of hoops that are sometimes a little too tricky
> to make things work. Read: the less we rely on Unix shell scripting, the
> more likely Windows users will be able to enjoy our software.
>
> Changes since v1:
>
>  * Rebased on top of master to avoid merge conflicts.

I do not appreciate this very much.  

We already have a good resolution prepared when merging this to
either 'next' or 'master', which also resolves conflict with the
other topic that requires this topic to add "--topo-order" in its
call.  Rebasing series means invalidating the previous work recorded
in rerere.

	side note. The rerere database entry can be recovered from
	master..pu with contrib/rerere-train.sh).

>  * Adjusted the commit message talking about double entries, to clarify that
>    it talks about HEAD's reflog.

Good.

>  * Replaced a misleading action parameter "checkout" for the reset_head() 
>    function by the empty string: we do not check out here, we just update
>    the refs, and certainly do not want any checkout functionality (such as
>    hooks) to be involved.

OK.

>  * Reused a just-prepared refs_only variable instead of repeating the value
>    assigned to it.

OK.

>  * Fixed a stale comment about the shell variable "$upstream" (which should
>    have been negated to begin with).
>  * Fixed error messages when files could not be opened.

Good.

Will take a look.  Thanks.

