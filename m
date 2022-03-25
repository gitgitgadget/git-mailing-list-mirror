Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2703DC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbiCYCAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 22:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbiCYCAK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 22:00:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F828E1F
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:58:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b8so6265003pjb.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TP5CdLw0NEILTOtBMWT0rogLfJ03kEZA+HkBcfuCsb8=;
        b=SDLDFLfsqleFptOO1jbBeIqM4STbfbKRls2mJkMA8gnmAvVvJPpD4tyxQedGf+AzEI
         dK4U6HOfyGIqwEoA8/+mmaR5S4SpSdtwwwkpbekzaYutjbGoo7Svn3+MfH4CWgcWkkLr
         5sG7vIoBGRM/AtRH8CefMpUT160BgFjNk7+41EDYIskNFa6vhGNDCTaUFKdcPYL81vYm
         ea+nsJNkXHJ181njZiMZholL+q2rbdG36LuJYG3O4wzG5uk4Ty+9/JnoYxAfWlMmQpIS
         OT+XHU7LGWuMFSe5ZnAQDCLOVIaXnMpzhVgZEyhayVk2ttz0OtpHS2oELLZr0yc/lWCp
         Bm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TP5CdLw0NEILTOtBMWT0rogLfJ03kEZA+HkBcfuCsb8=;
        b=OpH3waDW+DHM7T7+9BLXWeorGfCDTS5ggiXo9Hj7bmA+L1Omiw+w3R22a4mgtSes6G
         lpNSbsAzZDbdPVSFRM9N532ebMY0W/TzDtwXKjCBN47VnlrOJaT+9qOJhHli/yrlZvib
         FdVpcL62M9gnS/DVGFLN6OkwN7WVIv5K7RlKxQXORaGZHec3FouivZiS30QG1lTwh1pA
         hy9EssRu78MuegxTlWFNyhbRm09GaQETokg5SfqesSqdJWLbSNDo6AqiI50e2u0g6S8t
         JD5qU8AJs8jQQrGUsXZSg64BjDscOIWRjMTSlOpVe6VjGzbTit71QgnJKid6jUUnGOHb
         bO4g==
X-Gm-Message-State: AOAM533d66mXhfw78YKOmTURurt7JR7RZbNTQAeo6DxNgVhJ67KxVBYp
        j6f1YZ4td5eaccbry0TRklFCO9Pg+CAg
X-Google-Smtp-Source: ABdhPJzxE5+h2jZCgOhhsaUsmCg0W9O3ZFGb/BqeFfEPggdQJAx/0gbSO3oy1unCNwL9+nFg+xImGg==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id j6-20020a170903024600b0015387f0a93emr9100141plh.171.1648173516724;
        Thu, 24 Mar 2022 18:58:36 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm5035288pfc.41.2022.03.24.18.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 18:58:36 -0700 (PDT)
Message-ID: <6cb5414a-e1d0-bbfe-3744-f6df5dbb0db5@github.com>
Date:   Thu, 24 Mar 2022 18:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: git reset --merge random behavior
Content-Language: en-US
To:     Maximilian Reichel <reichemn@icloud.com>, git@vger.kernel.org
References: <84FF8F9A-3A9A-4F2A-8D8E-5D50F2F06203@icloud.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <84FF8F9A-3A9A-4F2A-8D8E-5D50F2F06203@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maximilian Reichel wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> Running the following script (test.sh) multiple times:
> 
>  ```
>  #!/bin/bash
> GIT_TRACE=true
> export GIT_TRACE
> 
> mkdir gitDir0
> cd gitDir0
> env git -c init.defaultBranch=master init 
> echo bar > bar.txt
> env git add -v bar.txt 
> env git -c user.name="P" -c user.email="e@mail.com" commit -v -m first 
> 
> mkdir ../gitDir2
> cd ../gitDir2
> env git -c init.defaultBranch=master init 
> env git pull -v --set-upstream ../gitDir0 
> echo foo > foo.txt
> env git add -v foo.txt 
> env git mv -v -f -- foo.txt bar.txt 
> env git reset --merge HEAD
> ```
> 
> What did you expect to happen? (Expected behavior)
> I expect that the script shows the same behavior on every execution.
> 
> What happened instead? (Actual behavior)
> I encountered two different behaviors (random):
> 1. Most of the time the git reset command succeeds and the file gitDir2/bar.txt contains the string "bar" after running the script.
> 2. Sometimes the git reset command fails and the file gitDir2/bar.txt contains the string "foo" after running the script.
> In this case, the reset command produces the following output:
> ```
> error: Entry 'bar.txt' not uptodate. Cannot merge.
> fatal: Could not reset index file to revision 'HEAD'.
> ```
> The full console output of both cases is attached to this mail, but they only really differ in this error message.
> 

I was able to reliably reproduce both the success and failure scenarios with
a slightly simplified script:

# Setup
$ git init test-repo
$ cd test-repo
$ echo bar >bar.txt
$ git commit -am first

# Succeeds
$ echo foo >foo.txt
$ git add foo.txt
$ git mv -f foo.txt bar.txt
$ git update-index --refresh
$ git reset --merge HEAD

# Fails
$ echo foo >foo.txt
$ git mv -f foo.txt bar.txt
$ git reset --merge HEAD

It looks like the error happens because 'mv' doesn't refresh the
"up-to-date" flag on 'bar.txt', so the subsequent 'reset --merge' thinks
there's a conflict that doesn't actually exist. 

I've submitted a patch [1] to fix this permanently, but if you need a
workaround in the meantime, you can call 'git update-index --refresh' after
'git mv' to avoid the error.

[1] https://lore.kernel.org/git/pull.1187.git.1648173419533.gitgitgadget@gmail.com/

> Anything else you want to add:
> I could observe this behavior on git 2.35.1 and 2.34.1.
> The behavior is not affected by whether GIT_TRACE is set.
> 
> I wrote a script that executes this test script repeatedly and keeps track of the possible outcomes of the gitDir2/bar.txt file.
> It will print a line each time the content differs from the previous execution.
> This script is attached to this mail (runner.sh).
> Sample output of this script:
> ```
> execution #0 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: Thu Mar 24 13:22:17 UTC 2022
> execution #203 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: Thu Mar 24 13:22:29 UTC 2022
> execution #204 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: Thu Mar 24 13:22:29 UTC 2022
> execution #264 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: Thu Mar 24 13:22:32 UTC 2022
> execution #265 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: Thu Mar 24 13:22:32 UTC 2022
> execution #432 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: Thu Mar 24 13:22:40 UTC 2022
> execution #433 	 hash: c157a79031e1c40f85931829bc5fc552 	 date: Thu Mar 24 13:22:40 UTC 2022
> execution #489 	 hash: d3b07384d113edec49eaa6238ad5ff00 	 date: Thu Mar 24 13:22:43 UTC 2022
> ```
> 
> 
> [System Info]
> git version:
> git version 2.35.1
> cpu: x86_64
> built from commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.10.25-linuxkit #1 SMP Tue Mar 23 09:27:39 UTC 2021 x86_64
> compiler info: gnuc: 10.2
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): <unset>
> 
> 
> [Enabled Hooks]
> not run from a git repository - no hooks to show

