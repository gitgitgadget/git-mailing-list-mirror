Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1483CC433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20DE2074B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUh64pGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgFGUEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 16:04:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52162C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 13:04:09 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id k22so13088054qtm.6
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=biGwet3Rk4DKczz22SXqf8OHygay5YcaOvhjzV7GSis=;
        b=nUh64pGmpWInuvPsdsaBrPIh1F5RUK7EcJJE6vMnza70oP/N3T2o2s486atJ1w0gZW
         h/7E6K9c20fKZRkYD14BBe0ysAE/lWIHAcP6/oFz+6Zqjjqi40i7rMhkH75KXYvOWvNa
         xFzhrx6GFSkK3eu+NXvlUhrgAG8OJupj+EU83OiIbketKt2Pm+hQ/EnVFZCmMImIRa52
         hQE5ZgjUn7qiHblhF7yaAToVNP1lEwS9QQ5sRjm1u9r5YW2MrMzlO70doAGnxdXRvDlS
         1EemgyqdhChoMXAGDIhJYgOLvxOt+3Sv0fyI6OUVEeBAVnK8VVK0+LP1o8+HkdiBNi6R
         rppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=biGwet3Rk4DKczz22SXqf8OHygay5YcaOvhjzV7GSis=;
        b=qQ56B5dlnbF+/RffYbmByQcDAv4T/Qc+WWpjGuV5lTdOwaRwbM/R2EC5QXV83StDbp
         SWDWFa6bFTNF0FRAzUl4KuUaHdyAaPysyJgka4ie/zxl8phcl/WRK4H/r92X0nYKOaPZ
         8bfeL35RXbdpoE1D8p7nge/CnvUN5iDICsh1CiYeNmz943XL8r3OxH/g0UiEWBZDylTI
         vfqqrbmt14OjwKEXc5xGcTuJ1VpgC/NAX+wYG1x0TQTJaE1wnD7VWBkzbZxq/2neCLxn
         jABIO5kHllxy3bvhS/j3mRuoG4v0enSCDTh/kdZJ2j2MO64NxxCrV/KlBWwBQEw43OhZ
         gFyQ==
X-Gm-Message-State: AOAM53315+7CA3ijFxcop3DOMuq6W2rFlAZLXN1JCxy8+0LVOzSk9tHd
        MvNyG1Rz0CAKaI0w/aZW1dgFqJ4W
X-Google-Smtp-Source: ABdhPJxCScQXPwjtD3JH5GwmPyrIGFy1pjJmvtPNH+yvMWMFeH7PODXHR/bfOhlEWuhmw55nqiAdHA==
X-Received: by 2002:aed:3c64:: with SMTP id u33mr20128685qte.56.1591560247849;
        Sun, 07 Jun 2020 13:04:07 -0700 (PDT)
Received: from ?IPv6:2804:431:d77c:2b47:2e0:4bff:fe37:ec7? ([2804:431:d77c:2b47:2e0:4bff:fe37:ec7])
        by smtp.googlemail.com with ESMTPSA id s15sm6101442qtc.95.2020.06.07.13.04.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 13:04:07 -0700 (PDT)
To:     git@vger.kernel.org
From:   "Soni \"They/Them\" L." <fakedme@gmail.com>
Subject: Fetching a lot of repos
Message-ID: <ef6f2275-536b-f4dc-9012-0467b1a4134a@gmail.com>
Date:   Sun, 7 Jun 2020 17:04:03 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For... reasons, I need to fetch a lot of repos, and fetching them one by 
one is *extremely* slow, often taking upwards of 30 minutes.

So I decided to try something different. My first attempt was a complete 
failure:

-----

[soniex2@soniex-pc multigit]$ git fetch 
https://soniex2.autistic.space/git-repos/ganarchy.git +HEAD:repo_a & git 
fetch https://github.com/ganarchy/GAnarchy +HEAD:repo_b & git fetch 
https://cybre.tech/SoniEx2/ganarchy +HEAD:repo_c & git fetch 
https://soniex2.autistic.space/git-repos/abdl.git +HEAD:repo_d & git 
fetch https://cybre.tech/SoniEx2/rust.hexchat.hexchat-plugin +HEAD:repo_e
[1] 2236
[2] 2237
[3] 2238
[4] 2239
remote: Enumerating objects: 87, done.
remote: Total 87 (delta 0), reused 0 (delta 0), pack-reused 87
Unpacking objects: 100% (87/87), 36.06 KiB | 225.00 KiB/s, done.
 From https://github.com/ganarchy/GAnarchy
  * [new ref]                    -> repo_b
 From https://cybre.tech/SoniEx2/ganarchy
  * [new ref]                    -> repo_c
warning: no common commits
remote: Counting objects: 113, done.
remote: Compressing objects: 100% (74/74), done.
remote: Total 113 (delta 48), reused 88 (delta 38)
Receiving objects: 100% (113/113), 30.07 KiB | 138.00 KiB/s, done.
Resolving deltas: 100% (48/48), done.
 From https://cybre.tech/SoniEx2/rust.hexchat.hexchat-plugin
  * [new ref]                    -> repo_e
[2]   Done                    git fetch 
https://github.com/ganarchy/GAnarchy +HEAD:repo_b
[3]-  Done                    git fetch 
https://cybre.tech/SoniEx2/ganarchy +HEAD:repo_c
[soniex2@soniex-pc multigit]$ error: unable to write file 
.git/objects/d2/5baa9c0a78b0007a34a569b774d983b905f0b5: No such file or 
directory
error: unable to write file 
.git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66: No such file or 
directory
error: unable to write sha1 filename 
.git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66
error: Unable to find baf9414a35a2f48ed1b22644fd4522272fb4bc66 under 
https://soniex2.autistic.space/git-repos/abdl.git
Fetching objects: 12, done.
Cannot obtain needed blob baf9414a35a2f48ed1b22644fd4522272fb4bc66
while processing commit 3f9f66712aaa071bd3bb32c46e1e4dc1fed13378.
error: fetch failed.
Fetching objects: 78, done.
 From https://soniex2.autistic.space/git-repos/ganarchy
  * [new ref]                    -> repo_a

-----

So I figured, "okay this is a git gc issue", and started over (rm -rf 
.git, git init) and turned off the GC (git config --local gc.auto 0, and 
that long command to run 5 git fetch at the same time). At first, it 
seemed to work fine, but then...

-----

$ git gc --aggressive
Enumerating objects: 365, done.
error: object file 
.git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66 is empty
Counting objects: 100% (365/365), done.
Delta compression using up to 4 threads
Compressing objects: 100% (357/357), done.
error: object file 
.git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66 is empty
fatal: loose object baf9414a35a2f48ed1b22644fd4522272fb4bc66 (stored in 
.git/objects/ba/f9414a35a2f48ed1b22644fd4522272fb4bc66) is corrupt
fatal: failed to run repack

-----

Well that didn't work did it... I'm not sure what to do about this, but 
I kinda need it to work, and it's currently not working. How can I make 
it work?
