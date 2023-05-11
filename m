Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF54C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 14:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbjEKOVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjEKOVf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 10:21:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C12711
        for <git@vger.kernel.org>; Thu, 11 May 2023 07:21:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so60004045e9.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683814872; x=1686406872;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5LicFixW3LzlQhbi+Vg1vh0S7wCn9mwoJ3asBuNAvjU=;
        b=Ft4zSEcrK3ejN30tST9tCU8pis1aq+fRsfFYhniqmh+aRHmp+AsljuaHC2fflKrE7Y
         ltJ2MJIfGPAMmHqp4AjuUQIPhWl7VvJoQg64XkraXLPwdmB9WB6BOGyyur2Wpu05BhaN
         3gkf0z7/lpJEsLn70PX7j5SXc82gghFzrx87h+7x02x/8+7ed4iT2gcJ1TGBLx4jxzNl
         dT2VFQA63kDRr5Jc0+VXYlkhk1ZujlMErgXmsK3VprV2YO9qu9wg+b3MwgnvOaCk8Z4T
         gQILvYV2L+oQVshCb20WXD7JJTWm5Nm5jgYPylWURvduBDt3cLdPiVhg7md/8+vVOsBv
         5eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814872; x=1686406872;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LicFixW3LzlQhbi+Vg1vh0S7wCn9mwoJ3asBuNAvjU=;
        b=iP5huJeyXOVZgSiY6b9+3skAYbrcqRsW/hSbJjSUd6sP2f6TtsIZIrCHD28J9bgXn1
         Cz1E+xmaufdHFNTIEvOrVzF51JG1XXr6Cbdx2sPwyLFFM+RZBXHjqMkVGBiztJ0ge5xf
         IrsOMyPMyNF6TzntpzEBgGuST04zK+G0gXbPWKLET0Za//pnVE9rOkXBfDAX9T39C1Ex
         JQz3tYdUOYvrSEpYroJPeEspgzVih1i2QvVW78MS5lVxoDTK0QLqYyR+IshICUrKeCIY
         cfrG30RvizT4dNLierO14+9Y9Eks0Uvw3bhbf38Gb/zJUbX5JXNWqCx7hfS8DQETbD4d
         3Daw==
X-Gm-Message-State: AC+VfDxYXVpMUXwAc+yLfsnIxtx7GEg8RRmy4D13X244qJwq4ojgNq/A
        LRYXkCpSgqR+puPPG3Te4aU=
X-Google-Smtp-Source: ACHHUZ4VbX12FiX5xEJRhryGZJFAcgf2i6M6JHOQqHxnXGdpw3yTcqs4N3oP8QfbnlOcFd0es7X4fg==
X-Received: by 2002:a05:600c:2047:b0:3f4:2452:9675 with SMTP id p7-20020a05600c204700b003f424529675mr10152666wmg.0.1683814872210;
        Thu, 11 May 2023 07:21:12 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d5109000000b002ffbf2213d4sm20452354wrt.75.2023.05.11.07.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:21:11 -0700 (PDT)
Message-ID: <288a9935-264b-4dc5-0d63-200c310f326e@gmail.com>
Date:   Thu, 11 May 2023 15:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase --root bug
Content-Language: en-US
To:     Christopher Fretz <cfretz@icloud.com>, git@vger.kernel.org
References: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christopher

On 10/05/2023 21:08, Christopher Fretz wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> Run an interactive, root, rebase, select one or more commits to edit, and then leave the repo in the rebase state for long
> enough that the "onto" commit expires out of the reflog and gets gc'd.
> 
> An example set of commands to immediately reproduce the issue can be seen below:
>    $ mkdir git_test
> 
>    $ cd git_test
> 
>    $ git init
>    Initialized empty Git repository in /Users/cfretz/working/git_test/.git/
> 
>    $ git commit --allow-empty -m 'root commit'
>    [master (root-commit) 01edd93] root commit
> 
>    $ git rebase -i --root
>    Stopped at 01edd93...  root commit # empty
>    You can amend the commit now, with
> 
>      git commit --amend
> 
>    Once you are satisfied with your changes, run
> 
>      git rebase --continue
> 
>    $ git reflog expire --expire-unreachable=now --all
> 
>    $ git gc --prune=now
>    Enumerating objects: 2, done.
>    Counting objects: 100% (2/2), done.
>    Writing objects: 100% (2/2), done.
>    Total 2 (delta 0), reused 0 (delta 0), pack-reused 0
> 
>    $ git rebase --continue
>    fatal: could not parse 10796537ce108c36191d52368250f403afede30b

The cause of the problem is that --root creates an empty commit (known 
as "squash_onto" in the code) which it uses as the "onto" commit. When 
it picks the first commit in the todo list the "onto" commit is amended 
and so is unreachable when the reflog is expired above. I think the best 
fix would be to stop pretending that we have a real "onto" commit when 
--root is used without --onto and either store "new root" 
.git/rebase-merge/onto or not create that file at all.

Best Wishes

Phillip

> What did you expect to happen? (Expected behavior)
> Git should consider the "onto" commit to be referenced from the ongoing rebase, and refuse to gc it, even during a --root
> rebase.
> 
> What happened instead? (Actual behavior)
> Git gcs the "onto" commit, breaking the ongoing rebase; after this, no rebase commands work, and your only option is git rebase --quit.
> The only way I've discovered to fix this without git rebase --quit is running scary commands to manually create a new dummy "onto" commit,
> and then overwrite the onto file in the git directory; I'm not confident that this doesn't somehow cause subtle problems that aren't
> immediately obvious.
> 
> What's different between what you expected and what actually happened?
> Git gcs the onto commit and leaves the repo in a broken state. Without manual intervention to fix the .git directory, or hard bailing out of
> the rebase, the repository appears broken. A user less familiar with git would likely just delete the repo, reclone, and start entirely from
> scratch.
> 
> Anything else you want to add:
> The way I originally encountered this issue was by leaving a repo in the rebase state for multiple weeks, coming back to the repo to finish the
> work, and then having the repo broken by a background gc job. I assume the fundamental problem here is that the "onto" commit during a --root
> rebase isn't actually a part of the new history, and is just "synthesized" to remove edge cases, and so git sees it as unreachable during the gc.
>  From one perspective, it might be argued that this is "expected" behavior given the above, but given the severity of the failure I think this should
> be considered a bug, and I think git should just unconditionally consider the "onto" commit as _always_ being reachable; it's not obvious to me why
> this wouldn't work. My apologies if this bug has already been fixed in a later version of git. Thanks!
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.37.3
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:42:11 PST 2023; root:xnu-8792.81.3~2/RELEASE_X86_64 x86_64
> compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
> 
> 
> [Enabled Hooks]
