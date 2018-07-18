Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142E31F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeGRWpA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 18:45:00 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35933 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeGRWo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 18:44:59 -0400
Received: by mail-wm0-f43.google.com with SMTP id s14-v6so4352039wmc.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bfudNhoXP0wDVXzpH5gdr+4T5qG7ZL6k1f20jlJ3/+E=;
        b=iQqQNY3onqbBgT7NBEapLQWBrOTYIDX99lc9Pk7/anfHerRIk6OmibpFlfSaG9EiRW
         IASbUpkyyglk0gVem2ayxMEPl/fHxTe2KXlNftf/zOxzxggbSkZOe5u8EKRIwVjXOm2J
         uRw1ae8Necr384xaCePfW+xfnPgyZ/lo/9NXQ7fMV8v6s7jzSyBLDBA6BDTqMmcA5k5N
         eo2Pnv6K8JyPcDz3Hl6fUdmly0n64uY+Raqhd2Z7pC4FKvvQg7yCDjIDFJwuxzsVIKny
         qi1dW0NgsqXKu6PxTxMhPQt/BwWk5wqhJnmny6gkSHkgNjaFCXaCOHuUH7suDPO3lLnp
         AoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=bfudNhoXP0wDVXzpH5gdr+4T5qG7ZL6k1f20jlJ3/+E=;
        b=lH5HLG+l2R603gke6n0CHMi7XxAnUQHMJwSzQsF2NPTk43PypO3TZZSRn++rByNtlj
         VxnG3v4PrFxssUIV85KfsEVmJACUzRQ1Qiy+onkGU1L+HSb23HxBCptynOdVDwglbOud
         AXx5mey+Tbbru2oX/zHoWUbrGnj98hMFSEczeIrbxCgPqKUe/hSj2x4hzqZ8JSO6TBo1
         M5c4qjyLrJMUQ5aEhbvYkIavxTUBxE4B6+mmn8EPLo4YMBV/NTXUBxmKKh4+09G7ivOy
         +oxs6gIy8FJZ9xKBMhbflqObfqV0EwGEvpuNGW6dOAy+SV7JBIlO37zytO2giHpGj6zB
         u/3g==
X-Gm-Message-State: AOUpUlFDUqeAWLCJ/qBIeqtDyIhzQvx0rI7SeNcqJymm47LaV/2Kqx1J
        uHwYGL1jjrAQqAvBfHjOGfd8Vr2j
X-Google-Smtp-Source: AAOMgpfkkplclXk9nR8CAPOgrlW0zZyJ/QGFsnh8HLPb19dO/5/XqvXSAYbG2Qc52Pa6E1GA/SnQXw==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr2532130wmd.77.1531951502170;
        Wed, 18 Jul 2018 15:05:02 -0700 (PDT)
Received: from ?IPv6:2001:4c50:46c:b500:153:9cb4:7d6b:694f? ([2001:4c50:46c:b500:153:9cb4:7d6b:694f])
        by smtp.gmail.com with ESMTPSA id q17-v6sm3959803wrr.7.2018.07.18.15.05.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:05:01 -0700 (PDT)
From:   =?UTF-8?Q?Ren=c3=a9_Scheibe?= <rene.scheibe@gmail.com>
Subject: How to speedup git clone for big binary files (disable delta
 compression)
To:     git@vger.kernel.org
Openpgp: preference=signencrypt
Autocrypt: addr=rene.scheibe@gmail.com; prefer-encrypt=mutual; keydata=
 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
 ZGmCwRHypXn0IVPK
Message-ID: <43b401ec-31fc-59dc-17c0-8dd7359726da@gmail.com>
Date:   Thu, 19 Jul 2018 00:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was wondering why "git clone" seems to not respect "-delta" in .gitattributes.


*Reproduction*

I prepared a test repository with:

- git v2.17.1
- .gitattributes containing "*.bin binary -delta"
- 10 commits with a 10 MB random binary file

Code:
---------------------------------------------------------------------
#!/bin/bash

# setup repository
git init --quiet repo
cd repo

echo '*.bin binary -delta' > .gitattributes
git add .gitattributes
git commit --quiet -m 'attributes'

for i in $(seq 10); do
    dd if=/dev/urandom of=data.bin bs=1MB count=10 status=none
    git add data.bin
    git commit --quiet -m "data $i"
done
cd ..

# create clone repository
time git clone --no-local repo clone

# repack original repository
cd repo
time git repack -a -d
---------------------------------------------------------------------

Output:
---------------------------------------------------------------------
Cloning into 'clone'...
remote: Counting objects: 33, done.
remote: Compressing objects: 100% (31/31), done.
remote: Total 33 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (33/33), 95.40 MiB | 19.94 MiB/s, done.

real    0m25,085s
user    0m22,749s
sys     0m0,948s

Counting objects: 33, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (21/21), done.
Writing objects: 100% (33/33), done.
Total 33 (delta 0), reused 0 (delta 0)

real    0m5,652s
user    0m4,173s
sys     0m0,178s
---------------------------------------------------------------------


*Observations*

_time_

- Cloning: "clone" takes always 25s
- Optimizing: "repack" takes 25s with and 5s without delta compression

_compressed objects_

- Cloning: "clone" compresses always 31 objects
- Optimizing: "repack" compresses 31 objects with and 21 objects without delta compression


*Expectations*

Both operations ("repack" and "clone") are using "pack-objects".

Therefore my expectation is that "clone" should respect "-delta" and be about as fast as "repack".


Cheers,
  René
