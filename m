Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C5B1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 22:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfIPWPG (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 18:15:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38557 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfIPWPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 18:15:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so1024132wrx.5
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zI7PuKaq42/GjUQdvZ4hQT84cIA3RChIn0XcMg0eFc=;
        b=Uk6xX3avm8RI+MaovaVht11eNNQZnmAlU40NG3fa+xHZZIpJz9oK1JSEJ/AEIWjI0y
         StnQ7pa0VdqiUyVo0qpyH/BCnYs/nC3hy6K7dS2Ul1rA3vZWpwiyV099630DcOfQWy+7
         wt9+Mix9dG8bsEr2aEt+f6YDJY9mhIucfudrGxndGBA3RYXKkC5wYuM4vQcciaICX1Tc
         LVTBWZb+TpG1jYkX8zDo0UUHzl+Hd9Pi8KJYJHOmNurqGRAVHQfTwst0sdyOj6J0YPQE
         UXEOHfEzGr1WzZGMOilCbu8mKQSp3i27YeTmVxzNEgqerq51zQMi+zQkQISg9zeN5uiQ
         apuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zI7PuKaq42/GjUQdvZ4hQT84cIA3RChIn0XcMg0eFc=;
        b=rbhIP8j/cDaJ1u2hBSfc4hU/vKtfBqXYegDTBiSTonEKo8fU5zkmJulgTDE3cXB3mc
         l1cumvybKcORvoV3JwcIE5PFW1MLrDICg72vrMmusTOGuDmEGM9V2m1mFBgw/dxCYagS
         2lXfwXkU5MHMvnrfRksNvXD2FxgzFddpZ9KzNe+ErjqzGutiuNCPBsQ+0MGG3WogXSxs
         oDDf1OZN2n/vbykQnDXL7zWeCflEZJD+jz5DzrewAxuwu0C/lWiXHV2ECT4/jsnV7Qm5
         uUABsKuWLXa3D5aw4DQcFtjPA0v3gR+FQMOnar262NPzaJgO9/88tAGFQ4TxWXJet4v+
         I+0w==
X-Gm-Message-State: APjAAAXSPW3QJzASwqVRczXCzjJR0XbKJ5/jwHFeJnDEJ8YkDQe6xCdT
        dd02uBDTqXO3h75OCCU5Egs=
X-Google-Smtp-Source: APXvYqw6VA9kN58hp3Z7aQylPzzv3Re/cirEKA6cD1Xw1ZgGDkgFSOmc5wIJDXH/zGIAMjpbGk5lUA==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr451010wrs.98.1568672104380;
        Mon, 16 Sep 2019 15:15:04 -0700 (PDT)
Received: from szeder.dev (x4db93de7.dyn.telefonica.de. [77.185.61.231])
        by smtp.gmail.com with ESMTPSA id v9sm268761wmj.43.2019.09.16.15.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 15:15:03 -0700 (PDT)
Date:   Tue, 17 Sep 2019 00:15:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: merge-recursive thinks symlink's child dirs are "real"
Message-ID: <20190916221501.GD6190@szeder.dev>
References: <20190916214707.190171-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916214707.190171-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 02:47:07PM -0700, Jonathan Tan wrote:
> This was raised by a coworker at $DAYJOB. I run the following script:
> 
>   $GIT init test && cd test
>   ln -s . foo
>   mkdir bar && touch bar/file
>   $GIT add foo bar/file
>   $GIT commit -m "foo symlink"
>   
>   $GIT checkout -b branch1
>   $GIT commit --allow-empty -m "empty commit"
>   
>   $GIT checkout master
>   $GIT rm foo
>   mkdir foo
>   (cd foo; ln -s ../bar bar)
>   $GIT add foo/bar
>   $GIT commit -m "replace foo symlink with real foo dir and foo/bar symlink"
>   
>   $GIT checkout branch1
>   $GIT cherry-pick master
> 
> The cherry-pick must be manually resolved, when I would expect it to
> happen without needing user intervention.
> 
> You can see that at the point of the cherry-pick, in the working
> directory, ./foo is a symlink and ./foo/bar is a directory. I traced the
> code that ran during the cherry-pick to process_entry() in
> merge-recursive.c. When processing "foo/bar", control flow correctly
> reaches "Case B: Added in one", but the dir_in_way() invocation returns
> true, since lstat() indeed reveals that "foo/bar" is a directory. If I
> hardcode dir_in_way() to return false, then the cherry-pick happens
> without needing user intervention. I checked with "ls-tree -r" and the
> resulting tree is as I expect (foo is a real dir, foo/bar is a symlink).
> 
> Is this use case something that Git should be able to handle,

FWIW, Git used to handle this case, but it broke with edd2faf52e
(merge-recursive: Consolidate process_entry() and process_df_entry(),
2011-08-11).

Cc-ing Elijah for insights...

> and if
> yes, is the correct solution to teach dir_in_way() that dirs reachable
> from symlinks are not really in the way (presumably the implementation
> would climb directories until we reach the root or we reach a filesystem
> boundary, similar to what we do when we search for the .git directory)?
> Also, my proposed solution would work in the specific use case outlined
> in the script above, but can anyone think offhand of a case that it
> would make worse?
