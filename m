Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E1B1F406
	for <e@80x24.org>; Tue, 15 May 2018 20:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeEOUFB (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:05:01 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35944 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeEOUFA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:05:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id z70-v6so509385pgz.3
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rVkUlbmFlQ7uWwuUmI8/vWQvYPt+e5eKyJpHLJj/dGs=;
        b=lhghpWovRmY4RyWETacy/OqN/Yk1hEmb2K6JM2osih3KB6+4hoGBWbQGSvlieQHDg0
         WfXoBJROXr6xnZ2nfGPacJ/YV2KF/3C6uCLnCSNZwrMWvQvkJ5uttifjSzepzFFriUvf
         6yNeJO3OL0JyYUn9OpwTm/hROh6iqIflt5za1wN7idApFXsmsdws7xWVBc+Av+khLXvj
         vdDvVOe0bdj5ICFHMw6Msx8b2xF6+eQogvZZa7BVxq4fyaXc+HK8pPkBf8trTUPoZNUB
         LB8PBJJPZN71F0HIVmFZyK1oLRhG6NHN7qgsOu8dqDwIgVfY9z7OWe2NT5tCCn4rhW8S
         ompg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rVkUlbmFlQ7uWwuUmI8/vWQvYPt+e5eKyJpHLJj/dGs=;
        b=NgkxZR9KLWvdaYt3nILj2FNjWagQw9EC1/m0C2ufvefpFkZh8vB5cDA2+noPPezKz2
         f5SpvZoiyh4TUsDmrY7SJw1ni80xXze2TrSwTbTvDHlVbPz+0LQSjyqc5nQ1iI3EXK8r
         ojIWXi9GDUodh/QlFWYfQPhNfyyYyA/RUFd1Whu8Kp+pAyU4H4xlWIvYTIVgL9ly/ZqX
         0+U+ybnBjXT3g14QIk66zlRkgaXZvcWa4cKFlT3+f8YMYZJK9yabodSkGGxekJPCO1Id
         XlFKSeU6BeLlxHjPwSY0Uyu3QD12kYVn1SsWkH+l4IPWZ3kSCUlsHI+m7T1zoUP93OlM
         8rnw==
X-Gm-Message-State: ALKqPwc/U5hytelN0QLhXYXHM4UeG2/AM2X7aHKJHe5bjBIJ8HEjwiW+
        AFnuL0RoAzvqc8UcJyKeOlo=
X-Google-Smtp-Source: AB8JxZqTRno3fSaUXaAsThsqHgTp5cSfnrVHkKYslMu12na3jNpHeSkre+QXyftw3gQ1PfxmyrkFkw==
X-Received: by 2002:a62:1d52:: with SMTP id d79-v6mr16519313pfd.230.1526414699858;
        Tue, 15 May 2018 13:04:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z129-v6sm989920pfb.108.2018.05.15.13.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 13:04:59 -0700 (PDT)
Date:   Tue, 15 May 2018 13:04:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] git-submodule.sh: try harder to fetch a submodule
Message-ID: <20180515200432.GA40044@aiede.svl.corp.google.com>
References: <20180511231751.162855-1-sbeller@google.com>
 <20180511232840.GB41222@aiede.svl.corp.google.com>
 <xmqqmux5g2pa.fsf@gitster-ct.c.googlers.com>
 <CAGZ79ka_8GmL9j9mTNLkbqN3xNkfCfedzs2st-tH8jMjQ2A4DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka_8GmL9j9mTNLkbqN3xNkfCfedzs2st-tH8jMjQ2A4DQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> I'll resend it with a warning (using say()).

Thanks, makes sense.

> I think we have 2 bugs and this is merely fixing the second bug.

I'm fearing that there are more than two.

[...]
>   $ git init confused-head
>   $ (cd confused-head && git branch test \
>         $(git commit-tree $(git write-tree) -m test))
>   $ git clone --no-checkout  --depth=1 \
>         --separate-git-dir=test.git confused-head/.git test
> Cloning into 'test'...
> warning: --depth is ignored in local clones; use file:// instead.
> done.
>
>   $ git -C test.git config remote.origin.fetch
>   $ echo $?
> 1
>
> (A) Despite the warning of --depth having no impact, the
>   omission thereof changes the repository state.
> (B) There is no remote.origin.fetch configuration, which
>   is weird. See builtin/clone.c:830, that states for this case:

I can reproduce the issue without submodules and without --local,
as follows:

	git init --bare empty.git
	git init --bare almost-empty.git
	git -C ~/src/git push $(pwd)/almost-empty HEAD:refs/heads/upstream

	git clone --single-branch file://$(pwd)/empty.git
	git clone --single-branch file://$(pwd)/almost-empty.git

	git -C almost-empty.git branch -D upstream

	git -C empty fetch
	git -C almost-empty fetch

Expected result:
Both fetches succeed.

Actual result:
First fetch succeeds, second produces
"fatal: Couldn't find remote ref HEAD".

Note that empty.git and almost-empty.git are basically identical.
The difference instead lies in the clones' .git/config files:

diff --git 1/empty/.git/config 2/almost-empty/.git/config
index b51bb0d..ee21198 100644
--- 1/empty/.git/config
+++ 2/almost-empty/.git/config
@@ -4,7 +4,4 @@
        bare = false
        logallrefupdates = true
 [remote "origin"]
-       url = file:///tmp/t/empty.git
-[branch "master"]
-       remote = origin
-       merge = refs/heads/master
+       url = file:///tmp/t/almost-empty.git

Thanks,
Jonathan
