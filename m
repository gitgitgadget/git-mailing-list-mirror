Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B87C742A7
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 17:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCHRNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCHRNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 12:13:08 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C6900F
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 09:13:06 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jo29so11582333qvb.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678295585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5K+GYd5wdYF+yKKUjOu+jdI8rUfGQdD0mOnyDcKv9zc=;
        b=O/h6DnDzbzihZdIpn9Igtwyy1cPXCimNC/d7u5P4cha015oLDI/NGPERc5qvcLGI5v
         g4Cv3E/jOgrUlc2wQPZPVB65duMfXdmxQ4HfyWUAAVZtFUDJeqN6TljqycAn7EqcCt5v
         KuLMWrtdmaDt/ocbZ7tBrSbt+7wYxYWoS1Yeb0NJo5tNUrSelI/m7yccx9IZA7il+boA
         puoB7Y/rHj9Zi+QnqJiLfZgVYBt+8SvTSu2om7hb8fcNwUX905RZlGb+6HbeC/k2JMtc
         Uie0ukrSYfgaGe7Iyl66DSOOyhA2Dl+qEkKYlzPMq7hhVL1sRwt42LlH7PZFw5rlKWRX
         VQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5K+GYd5wdYF+yKKUjOu+jdI8rUfGQdD0mOnyDcKv9zc=;
        b=Ac48oqmqX3IkOEqqV1uYNXsx/mhMy6B4CrsnQ6wkaDVwvH6StNcwRoqxuwlrA+T6JI
         NYlNhMHqzMaLQNnMEM3mJpfIxxwA/Nq/s+kINAm5Y8ME5pp5LgTBBra+zt9sGie/EIs2
         m5GbGGQ+jD6HZw2th1hl10Rnd/GqsdVHm9cuiZwJrKMFiw5VDWJ7426lm7PMwHtC5oiX
         HIKT29zm7ynm2ksDM/Db1p0JDnxCYbVUIrUYNuBRuum24ub+r72zdajQzL67Xr2rdIrG
         rlQoU5aNEhzCFezxk+Vhsaz7OZ6jEEC2HfvAR9luIKA59JWnej/jWkkt4cMvt1DMs3iJ
         s9xA==
X-Gm-Message-State: AO0yUKXB00JMhEC97uoVZ4EhsrRyHh3+fcIedtiG22Nw2eJ6ZFMBfFcU
        j3ZrYH8OOlkAGTCMMGV51GwG
X-Google-Smtp-Source: AK7set9jVbACQvs90zAF7OPP5B0adudm0DQHqMJru42aRSlSXiN2NWXrXTYVA6PC0coF/hwcmrm2qA==
X-Received: by 2002:a05:6214:2a46:b0:56b:79fa:e6d9 with SMTP id jf6-20020a0562142a4600b0056b79fae6d9mr11485474qvb.31.1678295585632;
        Wed, 08 Mar 2023 09:13:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d0dc:3668:fb01:9900? ([2600:1700:e72:80a0:d0dc:3668:fb01:9900])
        by smtp.gmail.com with ESMTPSA id r8-20020ae9d608000000b006f9f3c0c63csm11778000qkk.32.2023.03.08.09.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:13:05 -0800 (PST)
Message-ID: <87ecf011-415f-20d8-e781-18b97bfdca44@github.com>
Date:   Wed, 8 Mar 2023 12:13:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <xmqqy1o97apj.fsf@gitster.g> <ZAaFQJm6UGYH4YIi@nand.local>
 <901299ac-e543-b7e5-0a1a-c90e667a947d@github.com>
 <ZAiv2I17+/IBF8pl@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZAiv2I17+/IBF8pl@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2023 10:55 AM, Taylor Blau wrote:
> On Tue, Mar 07, 2023 at 09:52:19AM -0500, Derrick Stolee wrote:

>> The prepare_alt_odb() call only _adds_ to the linked odb list. It
>> will not remove any existing ODBs. Adding this reprepare_*() method
>> makes it such that we can use the union of the alternates available
>> across the lifetime of the process.
> 
> Right, that matches my understanding. What I am asking is: since we only
> add ODBs to the list, what happens if we can no longer access an
> *existing* alternate at the time we call reprepare_alt_odb()?
> 
> It's clear that that now-inaccessible alternate remains in our list of
> alternate ODBs, but do all object lookups hitting that ODB fail-over to
> the new ODB? I believe so, but it isn't totally clear to me.

It's the same as the pack-file list: if we fail to load something
from one, then we continue to the next one. If an alternate dir
is completely removed during the process, then looking for pack-
files again will fail to see any and continue without error.

This is already possible by deleting an alternate directory
while a Git process is running and might try to open files in it.
Git already recovers from this scenario.

If you're instead talking about the .git/objects/info/alternates
file being modified to remove an alternate from the list, then
Git's current behavior is to keep that alternate around for the
life of the process, and I recommend continuing that behavior.

There's nothing special that we are adding here that doesn't
already exist as protections when files are removed beneath the
Git process.

Thanks,
-Stolee
