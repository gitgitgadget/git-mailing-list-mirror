Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AD2C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJDQe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJDQez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:34:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBC95AC
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:34:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so19097473pjs.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fBI8iFVF95SRi+Zx7mCA14YKIPPivIeNaSHzzeWNMvU=;
        b=csbcJjQK0X3mSsDEVEKrNXMWGVyEr6DoKcPC5atl9i0vKKJkeNOUfctLAYKEzjN0eh
         5qta6oo3ZDXi8WCCFgfjY0hgnrabMqJXnvHROhb12SPJxbHWE+RFBee3Fykho8wfDOfC
         wE+QofkupkXnYE1E6Bqbg/Eq0ctDJQ7PVF3ABbGCCcUviX6STqszjJ1r3kxbH4liClMs
         SWGBe/NRJAaRgqyHKMntyOrw9xuU9jh59fENVKiUIg53f7vl5tzCAA3OsyEe97WLhU5G
         K24CDfULuzW6ZLNxIblvM50RNBNzLq9m9f9HUIXLWsL2vNfRvP9UrYI4ZjiwpMaJ67Ms
         zcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fBI8iFVF95SRi+Zx7mCA14YKIPPivIeNaSHzzeWNMvU=;
        b=1OXais9SpNBFn811aeYCTXhR0AP0g8GVqRwgtgQldbOslFNc10N8UcRGIzbTTogDZ+
         03G06diUR4CrdOBYrLe1MGCLt5cia37Gowyco3Myws8AjBzbB+CzXAl0FIIN9poNK+bw
         vAQDaCe4rwAKL8zd1YCGbxhApp33/MewwVAt84VloOu5D0z12VxQpZMq3cBpbs14p9t5
         ScuEBd3gA8pWamqGEm0qA9ktv6dZaHPEL22KX6o+2s7o/yLvhFSDH9iDjnaMKUj8MKm8
         rYUwXi6YQM90t+VISu2D8wjgZZDY7HB3+BbIuczZa7m/Qvu3sXBE7tkctd+peAJ8t8yE
         IqPw==
X-Gm-Message-State: ACrzQf28ZYHEwMZw9VYf2TQH4eRtEG2PbhpCd4Bko2ERZ0zRCEapGMr8
        sSHl95W5pv8sgs8yNc2zO+bJ
X-Google-Smtp-Source: AMsMyM6XLquV+qnYEDW02dwr+zCjfvwG0mKBv59tRpGsE5wNBrdhgz/9rxsWsW3PerzeezUz/rtjUQ==
X-Received: by 2002:a17:902:ce8f:b0:176:d5af:a175 with SMTP id f15-20020a170902ce8f00b00176d5afa175mr28607224plg.123.1664901292368;
        Tue, 04 Oct 2022 09:34:52 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b00174d9bbeda4sm9140704plg.197.2022.10.04.09.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 09:34:52 -0700 (PDT)
Message-ID: <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com>
Date:   Tue, 4 Oct 2022 09:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Bug report: `git restore --source --staged` deals poorly with
 sparse-checkout
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Cc:     martinvonz@google.com
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo wrote:
> Filing a `git bugreport` on behalf of a user at $DAYJOB. I'm also pretty
> surprised by this behavior, perhaps someone who knows more could shed
> some light?
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>   git clone git@github.com:git/git.git . &&
>   git sparse-checkout set t &&
>   git restore --source v2.38.0-rc1 --staged Documentation &&
>   git status
> ...> 
> What happened instead? (Actual behavior)
> 
> I saw a staged modification (Documentation/cmd-list.perl) and the same
> file reported as deleted in the working copy. Specifically,
> 
>   $ git status
> 
>   On branch master
>   Your branch is up to date with 'origin/master'.
> 
>   You are in a sparse checkout with 64% of tracked files present.
> 
>   Changes to be committed:
>     (use "git restore --staged <file>..." to unstage)
>           modified:   Documentation/cmd-list.perl
> 
>   Changes not staged for commit:
>     (use "git add/rm <file>..." to update what will be committed)
>     (use "git restore <file>..." to discard changes in working directory)
>           deleted:    Documentation/cmd-list.perl
> 

Thanks for reporting this! There are a few confusing things going on with
'restore' here.

First is that the out-of-cone was even restored in the first place.
Theoretically, 'restore' (like 'checkout') should be limited to pathspecs
inside the sparse-checkout patterns (per the documentation of
'--ignore-skip-worktree-bits'), but 'Documentation' does not match them.
Then, there's a difference between 'restore' and 'checkout' that doesn't
seem intentional; both remove the 'SKIP_WORKTREE' flag from the file, but
only 'checkout' creates the file on-disk (therefore avoiding the "deleted"
status).

Elijah's WIP design doc [1] describes 'restore' as one of:

> commands that restore files to the working tree that match sparsity
> patterns, and remove unmodified files that don't match those patterns

albeit with other (probably related?) bugs. Given that, I think the correct
behavior would be:

1. if '--ignore-skip-worktree-bits' *is not* specified, do not restore any
   files outside of the sparse-checkout patterns.
2. if '--ignore-skip-worktree-bits' *is* specified, remove the
   'SKIP_WORKTREE' bit & check out all entries matching the pathspec to
   disk.

Fixing this should probably wait until the design doc is finalized (I've
meant to follow up on it for a while now, but I should have some time to do
that this week). In the meantime, 'checkout' will at least allow you to (for
better or for worse) avoid the "deleted" status.

Hope that helps!
- Victoria

[1] https://lore.kernel.org/git/pull.1367.v2.git.1664353951797.gitgitgadget@gmail.com/
