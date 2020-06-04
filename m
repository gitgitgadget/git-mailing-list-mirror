Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BD7C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE12320659
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="us31Iu0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgFDKUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgFDKT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 06:19:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501FC03E96D
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 03:19:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f185so5014843wmf.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=134k8f6oBXR6SOUO5cmRwIb/VXWRcxYia37ETK3rDV0=;
        b=us31Iu0tNOrf+HVZneIOft89iIAQ8xDpY/TZ7XJ9otSLxDWtjpM9OKcFNwIIuINquO
         QWxEVFeV5QOuWn7rBB1p60n7mU2gNJG8rN7hQGpsnTx5hmxI0Mdet0lTYMRqdWCLZsrh
         hTMODFDQWUO7Ow9cdqCSY9wP8f/Putf+zbdk+396UxJPctll5uJIjrgwxIQ89itljppH
         CA+dmrcjcv5YQA6lB/wJqs8AwgF+KVP9FF1wxu+gWkYAbjodfHZUIfmRAqlJm0IsyS/C
         +Fi0On/6Maq2DQfhzK5lElWsvG4SocP2qFw045f+rirANPpPRWlTNdYEyp0BhLvX8/hH
         vZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=134k8f6oBXR6SOUO5cmRwIb/VXWRcxYia37ETK3rDV0=;
        b=cVZj21ipWzCa12Jxw4hAKXK3OM387TCvChRtL1IIsX4dk9C8AcK2oZDQDv3POPk4X3
         vTBbZ6WaQmeL2H3LiA0HgUxLwG8nTCNYtbvczpjv8HPtAPkfmqGlZqQRe4VUonoRqcqx
         BJq5AwyS2c4WWBUSPNsoBNscRvsi8AyVdYj9ZI5JLxhGEfrWd6hQXV0tXg2iGy0CRtmu
         SKJVcKw1H5f53fUnfZkEPtx9Dwuq1HDJ5nPow+al5oV1Cpqp4VowvDqtgbn6GBoTgxnT
         PXWN701bYj3NZojGJexeWhpItEyiXMub9Lz55e4wUTc5uS0sv8Q3C4nvb63+A/MYeSXE
         5HAQ==
X-Gm-Message-State: AOAM533hEw5CUJzZiBbPQTH8aRTdmfAaX70u0tuxw/bimW8yn8G8BXHk
        R/pcqcMYr4hUc5tyHAyF3cA=
X-Google-Smtp-Source: ABdhPJwDGYV0X/Z+qthWYMXJrxY5i8OXkCurAC0juM6z19IqYbWJueL/cF8K607lsmvVwerkIPvNpA==
X-Received: by 2002:a1c:bc84:: with SMTP id m126mr3531912wmf.159.1591265997981;
        Thu, 04 Jun 2020 03:19:57 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id k17sm7605720wrl.54.2020.06.04.03.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 03:19:57 -0700 (PDT)
Subject: Re: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Elijah Newren <newren@gmail.com>, Md Naeim <naeim249@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <CADhmr77EbC+3f=Oa+bm18Z_SSEMK8vCjNHQniuvkdfaZdRT_5A@mail.gmail.com>
 <CABPp-BGh0T1xio-pRb=JVNbJDK1PWpo+v877nDfjcm6khn6NDg@mail.gmail.com>
 <63139842-8548-6c64-1214-5469eedb8d4f@virtuell-zuhause.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b83568b8-e465-243e-cd84-eba88c4e95d9@gmail.com>
Date:   Thu, 4 Jun 2020 11:19:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <63139842-8548-6c64-1214-5469eedb8d4f@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas

On 03/06/2020 17:09, Thomas Braun wrote:
> On 30.05.2020 18:24, Elijah Newren wrote:
>> On Sat, May 30, 2020 at 3:52 AM Md Naeim <naeim249@gmail.com> wrote:
> 
> [...]
> 
>> Could you provide any details beyond the subject, such as the output
>> from 'git rebase --abort', your git version, the output of `git
>> status`, whether there are any untracked files with special status
>> (e.g. ignored but a submodule in the way of something?), any special
>> file permissions (does root own some files and prevent git from
>> updating things?), operating system you are on, link to a repository
>> people can use to reproduce?  Without more details, this report is
>> unactionable.
>>
> 
> I don't know the OPs details but I can reproduce with the following
> clumsy snippet:

Thanks for the script, I've annotated the error messages in an attempt
to understand what's happening

> #!/bin/sh
> 
> git init
> git config --global user.email "you@example.com"
> git config --global user.name "Your Name"
> git config rebase.autostash true
> git config core.autocrlf false
> echo "*.abcd !eol" > .gitattributes
> git add .gitattributes
> git commit -m "Add attributes"
> echo -e "1\r\n" > test.abcd
> git add test.abcd
> git commit --no-verify -m "Added test.abcd" test.abcd
> echo "*.abcd eol=lf" > .gitattributes
> git add .gitattributes
> git commit -m "Add attributes (LF)"
> git rebase --root --interactive
> git rebase --abort
> which gives
> 
>  ./run.sh
> Initialized empty Git repository in E:/projekte/test-init/.git/
> [master (root-commit) 7169943] Add attributes
>  1 file changed, 1 insertion(+)
>  create mode 100644 .gitattributes
> [master 61f0599] Added test.abcd
>  1 file changed, 2 insertions(+)
>  create mode 100644 test.abcd
> [master 0acd46a] Add attributes (LF)
>  1 file changed, 1 insertion(+), 1 deletion(-)
> warning: CRLF will be replaced by LF in test.abcd.
> The file will have its original line endings in your working directory
> Created autostash: 310f745
> error: cannot rebase: You have unstaged changes.

The stash fails to stash all the changes because of some line ending
issue I've yet to understand but the stash command exit code is zero as
if it had succeeded in stashing everything so the rebase creates
.git/rebase-merge/autostash and continues

> error: Please commit or stash them.

only for the clean worktree check to fail. The cleanup path from that
point assumes we have not yet created .git/rebase-merge which is not
true if an autostash has been created. This means we do not pop the stash.

> error: could not read '.git/rebase-merge/head-name': No such file or
> directory

When we try to abort we try to read some state that does not exist
because the rebase never really started

> and
> 
> $ ls -la .git/rebase-merge/
> total 5
> drwxr-xr-x 1 thomas 197121  0 Jun  3 17:57 ./
> drwxr-xr-x 1 thomas 197121  0 Jun  3 17:57 ../
> -rw-r--r-- 1 thomas 197121 41 Jun  3 17:57 autostash
> 
> I'm running on Windows, both 2.27.0.windows.1 and 2.26.2.windows.1 show
> the problem. And I'm pretty sure it is not Windows specific.

You're right I can reproduce it on linux

> Although my test case uses EOL normalization, I think the real issue is
> that autostashing for the rebase fails (in the sense that the working
> tree is clean afterwards) and that is unexpected.

Yes. I'm not sure what to do for the best. A simple fix to the stash
failure is to check for a clean worktree after we've stashed and apply
the stash and exit if the worktree is not clean. Ideally `git stash`
would be able to tell us that it didn't stash everything, but that
warning comes from `void check_global_conv_flags_eol()` in convert.c so
it does not pass along that information to the caller.

We should also improve the cleanup code path so that it applies the
autostash (and removes the state dir) if it exists as after a quick
glance through the code it seems we might not be applying the autostash
if `git checkout`.

Best Wishes

Phillip

