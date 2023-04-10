Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24462C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 13:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDJNel (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJNej (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 09:34:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F646B9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 06:34:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id dw2so17052226qvb.11
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681133678; x=1683725678;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqaJDqNdVTnL8OQ8Wwlosdfql4AjafTBXTVfbspp6fw=;
        b=g9oQ6axZYTUyFhdURlMyNAzL1XUTcdwPjXuHWhrNLUPQSjqdgG8ldfPtm/Iix9Bfhk
         6LQV9hIOAA0k5+rBFL70i9t5TYwN4NFnPwjVJOBjkJR6Q2ncGbx4vupQLreD+yFZIW+U
         uQs3UoSPnxrE9R86yOVzpeUxSXjIgS3QFuVdchjCB637wKpB2c4+9DSpQEAzaBru3Oky
         mXP7XC9hYpk/ptugr5o0Wolt4Z5TUGsUx5AbEe+nZ1XMSz35VAqmgK1YQj8am0e5T2ZR
         sYJXjxVaegKPGQvOCJIf1b/LxVuMgvcF+QItg4DCfbh9gxxsmQieNyMF60S8M3+7SS1b
         QHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681133678; x=1683725678;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqaJDqNdVTnL8OQ8Wwlosdfql4AjafTBXTVfbspp6fw=;
        b=6tDJCheweHJYAJxUEuhdSkxuxGO8ccQDDREnCz30Fpfnoe8ndGuOIFTHv/AOd2pezd
         uGDp4tgb3Id3qrLRVQWI3zvK3MceToeON22TeynyVLWKxKM/5bEdNNHRPfwyrw4fXnv+
         EhCm4tpASq9o+DtBOHMEwghnWj+AI6HJKd2ADwXHnHuQEifrAZicxEnzH2rU8bfJMVxg
         HJJvo7RSUWULIe4v9RzXNsxH4hb1DDMRo8e8+TBBk7T54Hm2Y/lB8spkxRpfsEm1cG4T
         XfTdnr6QCxI99BFeWChGz18Sd0NkMmOjSqAZLN3C4JdDxnjsYdKZeHrbUnG4CL5g4p6H
         Z41w==
X-Gm-Message-State: AAQBX9cd8orMrzbriiFhZ8d1nFEjm1NrJSDgkPekFETcKCZzLwmnQ69a
        JHJhMzo/eavge2shIGyqQcI=
X-Google-Smtp-Source: AKy350Y/8x4J0Jnhdfig3chvGIYAoGiNaejIDu/IrBVHhKk/rHZYPW+5dJlv5WQ72EjuUuD+ohJUFA==
X-Received: by 2002:a05:6214:c61:b0:5e9:9eb:e026 with SMTP id t1-20020a0562140c6100b005e909ebe026mr14653899qvj.29.1681133677782;
        Mon, 10 Apr 2023 06:34:37 -0700 (PDT)
Received: from [192.168.67.200] (dsl-155-42.b2b2c.ca. [66.158.155.42])
        by smtp.gmail.com with ESMTPSA id g19-20020ac870d3000000b003e4c6b2cc35sm3000564qtp.24.2023.04.10.06.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 06:34:37 -0700 (PDT)
Message-ID: <37127bb2-8fa2-5908-6824-bb9be9bb0c3b@gmail.com>
Date:   Mon, 10 Apr 2023 09:32:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Guillem Jover <guillem@hadrons.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <ZCiZCM+AAUnjp4Ml@thunder.hadrons.org>
 <xmqq355g6f6u.fsf@gitster.g> <ZDLvUxp0d33VgFQY@thunder.hadrons.org>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: =?UTF-8?Q?Re=3a_Add_a_way_to_disable_=c2=abgit_clean=c2=bb_per_repo?=
In-Reply-To: <ZDLvUxp0d33VgFQY@thunder.hadrons.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-09 13:01, Guillem Jover wrote:
>> I doubt it would make much sense to file a feature request to Debian
>> or GNU/FSF to disable "rm -r" in certain directories.  I am not sure
>> why "git clean" should be any different.
> Right, but I see a substantial difference though, «git clean» is
> part of the git toolset to manage among other things specific work
> trees, where that behavior is controlled through configuration, and
> is as such confined within those specific realms, where also the
> properties of what is being tracked might be different.
> (With GNU coreutils rm you can confine it within one filesystem with
> --one-file-system, but TBH I've never had the need to use it AFAIR,
> and it's not enabled by default.)
>

Hi Guillem,

I agree with Junio here - there are many ways you could adapt your use 
of Git to safely manage these types of repos... for starters I don't 
like storing the .git directly in the folders I'm tracking, I always use 
separate repos with a script to compare the contents vs the real 
filesystem. Something like:


#!/bin/sh
diff -ur `hostname -s`/ / |grep -v "^Only in /"


In this example the repo tracks files from / on multiple hosts using 
hostname as the first component; diff won't descend into "new" dirs so 
this runs very fast too, and can be piped to diffstat to get a summary 
of changed files.


Also if you fear accidentally recalling a dangerous clean command from 
history, you can set HISTCONTROL=ignoreboth then prefix any dangerous 
command with a space, or use HISTIGNORE to selectively ignore got clean 
commands. That works with other dangerous commands like sudo reboot, rm 
-rf, etc...


The HISTCONTROL way is even better imho as I would always save/recall 
the command with -n appended (no-op) to review what would be done (ex 
sometimes there could be a virtualenv in the way that I forgot to remove 
from ignores) and only when I'm happy I'd remove the -n and insert a 
space in front so the command doesn't get saved.

Regards,

-- 
Thomas
