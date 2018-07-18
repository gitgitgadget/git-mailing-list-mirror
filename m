Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280611F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeGRT6e (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:58:34 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34544 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeGRT6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:58:34 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so2299647ybq.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZnHn3zBqMWkT5fX2xMgDK/UQjpw3rzspDC8aPJipj8=;
        b=mRFIcJdnulow+bju58y+i4A5IncDiFJfKgYHkSIAfc/IOX9RwvH7NureuuS1SJMi6R
         aLXCx6I8SJsZlyotZdz+ooZCvo8afi/IYRx5s6utNHo+yefhI5VzvDgjuy8EDFu4K1Z5
         JWgGzIx0x0VMC8G4LEQJYd1midZPLP3gg+7vpuNMIveD4sGzEzQ4sHCKlbtlb3mznLBU
         vhJDqFGEQ+MkDERrcB0N2TQ/jHSpO9XGkcJh084273R/7B1U8o63dR/w0DaauBHYKgs7
         Cfd9KTGEa9WmQeQz7GbyVadJ+yCD5hTqAzkTlfPu/McKxGY3wjvwheUXwnBPEVnBKF8N
         Zs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZnHn3zBqMWkT5fX2xMgDK/UQjpw3rzspDC8aPJipj8=;
        b=I6g0uEJrSlQB/Y9QNXeqxw0w+wKKcYROzuW2pA5PMmJhmezAC5Jg5IRDcfsaMggU/f
         wAAPpBEVWD4m4EnLJjaR6MLxk4ECMw/vgzIvD+1eD4xSDAp+ZRPqHaBhdypGkElpJ9LU
         GHB5xUKpA23PzHJrrZgIRSi6T1vPypatuiDMqAB0718Kf8V2Z00oWaWV0denN1pGgR7G
         /KQhdbAhrQk5kM9/WKTF08lXABmS/OzSgKcy77TH3U+VQ98xb7TW86aeQOkL5IFFzGQk
         wqmt0ZIewOH/in+I9YbeRnTXhzFUF55CcQ1YnfKmUzP9PjZipkNu6UNQ2rnW4TW9RLUV
         CAdw==
X-Gm-Message-State: AOUpUlHyukbdjt30as5S7sfCFMEVB+otV52SnABG/q/1g1xVaorpsLZy
        5jRgpg3sjok+Z3CEk86r7njYObgqLasUlH+79huKJw==
X-Google-Smtp-Source: AAOMgpdNOjwK8TA9td+JwRwiJ8pH7vZWl3f9YCc1LSuDVuw3v4ccWSv6y1AD8Q0xBUBwHlevf9Fdj+7HPHiXYQ1rS6A=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr3930259ybp.352.1531941556343;
 Wed, 18 Jul 2018 12:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.11.git.gitgitgadget@gmail.com> <22dc9ce8364dd20876ab5eb626ecc6a7396d3b3e.1531926932.git.gitgitgadget@gmail.com>
 <xmqqd0vkjsx3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0vkjsx3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 12:19:05 -0700
Message-ID: <CAGZ79kZ9oeqidNMppOx+PNfp-4RdDhLzvQHhm45Ceni=g1Q_7Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] refs.c: upgrade for_each_replace_ref to be a
 each_repo_ref_fn callback
To:     Junio C Hamano <gitster@pobox.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -317,7 +317,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
> >  int for_each_tag_ref(each_ref_fn fn, void *cb_data);
> >  int for_each_branch_ref(each_ref_fn fn, void *cb_data);
> >  int for_each_remote_ref(each_ref_fn fn, void *cb_data);
> > -int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
> > +int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
>
> With a signature change like this, any change that introduces new
> call to for_each_replace_ref() using eac_ref_fn() would get
> compilation error, so this is minimally correct.
>
> Two things that bothersome are that
>
>  - for_each_tag/branch/remote_ref() and for_each_replace_ref() now
>    work and look quite differently.

Yes, this series is not finished; we need to convert/upgrade for_each_tag
et al, too.

>  - existing users of for_each_replace_ref() who were all happy
>    working in the_repository have to pass it explicitly, even
>    thought they do not have any need to.

All callbacks that are passed to for_each_replace_ref now
operate on 'r' instead of the_repository, and that actually fixes
a bug (commit message is lacking), but the cover letter hints at:

    While building this series, I got some test failures in the
    non-the_repository tests. These issues are related to missing
    references to an arbitrary repository (instead of the_repository)
    and some uninitialized values in the tests. Stefan already sent
    a patch to address this [2], and I've included those commits
    (along with a small tweak [3]). These are only included for
    convenience.

> In this case, even if you introduced for_each_replace_ref_in_repo(),
> making for_each_replace_ref() a thin wrapper that always uses
> the_repository is a bit more cumbersome than just a simple macro.

Yes, but such a callback would do the *wrong* subtle thing in some cases
as you really want to work in the correct repository for e.g. looking up
commits.

> But it *is* doable (you'd need to use a wrapping structure around
> cb_data), and a developer who case about maintainability during API
> transition would have taken pains to do so.  A bit dissapointing.

My original patches were RFC-ish and a trade off as for the reflog only
there is nothing in flight to care about.

Given that we would want to upgrade all the ref callbacks, we have to
take this route, I think.

Thanks,
Stefan
