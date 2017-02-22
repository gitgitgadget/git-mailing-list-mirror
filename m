Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394B7201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbdBVRSg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:18:36 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36394 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbdBVRSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 12:18:34 -0500
Received: by mail-oi0-f48.google.com with SMTP id s205so4944719oif.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aAdNuveHnYvSTE8yWG77K53nKF/i0h0t7+uEzvcEStI=;
        b=PHkzvPcUBz5r4jrZxpij7gTE6OYNIqffOgQYzrXASbd6PhixPvR8HURPJeP99QJkht
         O2R8EcMy+O4m51oYgA8cGzXKBjdewsHK91E5qwQOsGApvOONZl5aSxOIViDBFpq9cAIb
         9IypMES5Qe5uHaod/V7UivoA12awHnkheVqFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aAdNuveHnYvSTE8yWG77K53nKF/i0h0t7+uEzvcEStI=;
        b=ia+w4yC2nhcR04lXJG76IqdWh3Q3O/quQdRmjGDlounFbr+LWrfq0btttaxODIyY3O
         9SkOHDYFdwDuiwO0+55q5BeKNiqdR1e9ySAVSN2YB37JFOGY4oMtqr7NQYIacK75yXkw
         M4GQETk3/ev/v+T9q+OwDkvL7lg7GTf30NzGXuzHZ2oTn688Uk1l0Lq7UJBSBqNPoJGd
         87cor0JtJeaBZOh5v4OZEsKz5qEEiS92cwwzd9ibEXSddUbp57FZvx4Kfa5Ei/CNaCDe
         9KDTd+E/rfVvlPdzLLqOMFnKEDCPT0+mOdgYXNC/M9CZApm776nL0pTC4YRfqCLNtP1/
         s/ig==
X-Gm-Message-State: AMke39kAVHdxtnLMuJ83e3qkg0rMvPBuxlWw10pECkUpyyzjLj0yAlflcb8Vw9u4SLI9Re+iBYxyf0GSSorg3ioy
X-Received: by 10.202.3.197 with SMTP id 188mr18123162oid.31.1487783913700;
 Wed, 22 Feb 2017 09:18:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.42.51 with HTTP; Wed, 22 Feb 2017 09:18:33 -0800 (PST)
In-Reply-To: <20170217040522.jugt4uuak74l3qjw@sigill.intra.peff.net>
References: <CA+-W3ctdRtLpziJ9TX2hqk7RagMyJpHsrfwj=rN7oXQ8EeUPnw@mail.gmail.com>
 <20170217040522.jugt4uuak74l3qjw@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Feb 2017 09:18:33 -0800
Message-ID: <CAADWXX_S8RWE7pSZ-2JM_JeNT7LfHFgEopt6SUUUQYx0yumojw@mail.gmail.com>
Subject: Re: `git show --oneline commit` does not do what's intuitively expected
To:     Jeff King <peff@peff.net>
Cc:     Luna Kid <lunakid@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 8:05 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 17, 2017 at 02:51:36AM +0100, Luna Kid wrote:
>
>> tl;dr; --> Please add --no-diff (or --msg-only) to git show. We'll
>> love you for that. :)
>
> I think it is already spelled "--no-patch", or "-s" for short.

I think people should also learn about "--no-walk" (or the numberic
walk limiters) to the revision walking logic, because it can often be
useful.

IOW, if you only want the commit info, you can certainly use "git show
-s", but you can also use

    git log --no-walk .. list of commits ..

or

    git log -1 <single-commit>

to show a commit without any other details.

Basically, "git show" for a commit does what is mostly equivalent to

     git log --cc --no-walk

although "git show" then has other features too (ie it shows non-commits etc).

                Linus
