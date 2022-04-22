Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA209C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446092AbiDVJjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357468AbiDVJjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:39:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4EE1CFCD
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:36:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so9704903edu.10
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XsMzdfUgkpodqkAhu5tfSsjWuoIjGb7kKp1PEQsVCcI=;
        b=oXyXTJGIiNL894ZkSAPckzI0/e53THIZQoh1BrJZRogxZBi3PHqyK03icgmH6cDCx+
         Ve/pdCw7ia4wz8cuVzNNwlEQ8x16l7//ai0lhf0yYEDf6nUuRcXtEpBHpn2SdphAEmxD
         ylau+Ep4E+WQq/zFgEdwfOVje6JLc/Bk5Ja8TSYoXRMADnRe9uPS9KydXA1SmEW+Vfrh
         Xjbo0UquNpO9G3z3cbxZ5Wv1WpSibIT6WzZBuQn888ZzZMm9sHz6Ji3Vq4pC8JOxbEsr
         sWMahQmcGDdjrXsOCfk1/HY7UL9SMwW95TkBRZzsSLOU07OrVZxEgmgssPIlBDK79+BA
         BZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XsMzdfUgkpodqkAhu5tfSsjWuoIjGb7kKp1PEQsVCcI=;
        b=E84btmaLoJKMQl5XywPZSipuIDw1Q7LVlScZC6/L3zJpQxei3+ceoa1AGeGxqwezox
         CObhuzxFPV9aZjCKpLNFqLbtl0QZh6NFCqWCSnDVjxUreritc1jCiD+jl11mok7wCyQK
         7+RjijsNutBj1uACT3GS+5CT50BE+qX6b4MSYlrrt3UNurMxPoMfh2Lh6UUYabGwTW2W
         gCwtXT01ZdcFmdqKJ3BHYO2LuD7D9pZDlCmTLesIY0B6WYyDNhl9NuOXnN/BdA3TDWd3
         GPc9YYUT9j970KEUJiSf8AVZ2xGJbfTPeBlUUx5MamjCqcpuzmotkctkHWI+1+rrNkpP
         jjSQ==
X-Gm-Message-State: AOAM532ubjITMWy2G/IP1tKl4vputeq7xodxGttjOmzUhNc/mn+TtWjA
        cOZpdboTem3j7k7FiIqJwjQ=
X-Google-Smtp-Source: ABdhPJxinX1T6EWK9DXJsiVo1yt5Hc8voHCyrSAoeGqIdI6Q4NTqKa3XyKJE5UQsih9aI92jmmhhTg==
X-Received: by 2002:a05:6402:1cc1:b0:413:2cfb:b6ca with SMTP id ds1-20020a0564021cc100b004132cfbb6camr3730173edb.265.1650620182479;
        Fri, 22 Apr 2022 02:36:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7dd58000000b00420ca195de9sm672114edw.25.2022.04.22.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:36:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhpi9-008du9-DR;
        Fri, 22 Apr 2022 11:36:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Attila Csosz <csosza@designsoftware.com>, git@vger.kernel.org
Subject: Re: Git bug report - disk errors on Windows after push
Date:   Fri, 22 Apr 2022 11:27:23 +0200
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
 <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
Message-ID: <220422.868rrx5uju.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 18 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> Hey,
>
> On 2022-04-18 at 07:47:07, Attila Csosz wrote:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> Pushing to a directory directly.
>> 
>> What did you expect to happen? (Expected behavior)
>> Good behavior
>> 
>> What happened instead? (Actual behavior)
>> Disk errors. After pushing to a directory (my origin field is C:\Work for
>> example) the git repository will be corrupted.
>> Moreover causing disk errors not only in the target git bare repository.
>> I've loosed some other files.
>> Cannot be reproduced exactly. However I have decided to report this problem.
>> I've experienced this problem for several years.
>
> There's nothing that Git should be able to do as a normal operating
> system that causes disk errors.  If you're seeing those kinds of errors,
> the likelihood is that your disk is bad and you need to replace it.
>
> Do note that if you're storing your data in a directory managed by a
> cloud syncing service (e.g., Dropbox or OneDrive), then it is known that
> those file systems corrupt Git repositories and you shouldn't use them
> with Git.  That's due to the way they sync data.
>
> However, if this is a regular file system (e.g., NTFS), then Git
> shouldn't be able to cause disk problems, and if it could, that would be
> a serious defect in Windows, so it's almost certainly going to be a
> hardware problem.

I think you're most likely right that this is some local HW issue, but
the report doesn't have enough information to say either way.

But generally as we've been discussing at length in various threads
related to git's fsync() behavior we can and will corrupt repositories
due only to our own (mis)use of FS APIs, i.e. not doing fsyncing and the
like correctly, it's been improved a bit recently.

But we're still in a state of not doing it correctly, and/or relying on
some implicit assumptions.

For something like an external disk that may have its power cable yanked
I'd give it about even odds that it's HW v.s. git's own FS syncing logic
being at fault.

We get away with a lot of shenanigans because we're usually on a
journaled FS, which e.g. on a FAT32 external volume we won't benefit
from.

Attila: I have no idea if this even exists on Windows, but aside from
other suggestions in this thread I'd suggest enabling whatever Window's
equivalent of "sync" mounting is (if it even exists). I.e. to have every
single FS operation by synced to the metal. 

It will make your repository *much much slower*, but it will be safe as
far as any logic errors in git vis-a-vis syncing go.
