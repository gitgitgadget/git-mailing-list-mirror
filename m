Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F7720193
	for <e@80x24.org>; Fri, 28 Oct 2016 03:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936411AbcJ1Dq1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 23:46:27 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36516 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937573AbcJ1DqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 23:46:25 -0400
Received: by mail-qk0-f180.google.com with SMTP id o68so72493453qkf.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5WpXhEnHyOELFCWtah5LK4X6pgzUjQYXKyfhKBNlvIE=;
        b=HBNWxq/apagA6N9/cRmo0x9aFJypWEQYfYCpCOczEibr0jzDR07W/ad5BJYM9vquFL
         pdWJ/+uxrmBBGsFNgY6w2MC6HNk+Og9ZozWhnC6a0oqo6SMglDxWMpT5MvgzEkqZoGMm
         60qIxRuNx0axkwIcZ82xi17dXK4WZ6YEIPOE5Q8Zq89udh377AsFubAjHcZ/IKeh1Z4k
         I0hmlevXrGKWWP3yV/JU0/evhVJ5YwbD5ChpxiWIyI1G7qiKL+qvPFMeENooPx4D3iGf
         sUNDK7Fqwb+bEhZA6yZgA6xpsdGVHscgsN9F7K/7fwgBUIiXXOx6McwXyS/3Uck4jrMa
         ve4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5WpXhEnHyOELFCWtah5LK4X6pgzUjQYXKyfhKBNlvIE=;
        b=MJ3eDk5kygb0x9v3+jhk2+w37XDimAjekt8J0tBAK/a+Ng0+QLYNy7KtNRhY5TeKTx
         qmsSvhykar8GsJVt3+k6aslVL1/ZlhV7f3DjUFjKF7YGAw98q2uu9L297eDNpvBDjGxs
         gXR7rtZOm3zu6xYK0TpYz8aNnfYqf7WcFZ3bj8yYN8Iq4pksAa05TRTQKOWhB9oj7EV/
         hqJLY+20rOF1X7LjejNRAnH117XOIHe4aLV/AtDq8xZAWBKchi4vHAkD6bsT8kqscxOq
         84DyKFl/bFln5adABl/VCw5xd2gS94vKwW8RhPNVCVnCOblKQQJr3HGt8OQpPnx+0Ytu
         vR1A==
X-Gm-Message-State: ABUngvcrhqogsqulAV9qV54q3zrSyf3fPn9ziUwjjaLx5qad3uH5gT6ttzviL6LJDwPbPO4/cdG9e5ocG9C6SmCB
X-Received: by 10.55.64.80 with SMTP id n77mr9619419qka.173.1477626384658;
 Thu, 27 Oct 2016 20:46:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 20:46:24 -0700 (PDT)
In-Reply-To: <xmqq1sz1425w.fsf@gitster.mtv.corp.google.com>
References: <20161027223834.35312-1-bmwill@google.com> <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYm1txscyBpmfJQceCLFrZAN09y-2nV1zCjE2a1+_jrLA@mail.gmail.com> <xmqq1sz1425w.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 20:46:24 -0700
Message-ID: <CAGZ79ka+aTqyNof5o2RMZCXVXbUTKV_yYLbpCd5CG=bbrGzUew@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] recursively grep across submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 7:50 PM, Junio C Hamano <gitster@pobox.com> wrote:


>
> Unless you are imagining "git grep" to initialize and checkout a
> submodule that is not checked out on-demand, I do not think you have
> any reason to even look at ".gitmodules" for the purpose of "I want
> to grep both in superproject and submodules that are checked out."

In tree-ish mode you may have this example:

    git -C superproject rm path/to/submodule
    git -C superproject commit -a -m "delete submodule"
    ...  time passes ...
    git -C superproject grep --recurse-submodule -e <expression> \
            HEAD~42 path/to/submodule

In the last command you need to map the path to submodule to
the name of the submodule to find out the place of the object store
for that submodule and see if it exists.

> If it is working with a tree-ish, again, go look at the object store
> in that submodule repository.

and to find out the object store for that submodule you need the
path -> name mapping at that point in time, i.e. you want to look
at the .gitmodules file at the given tree-ish.
