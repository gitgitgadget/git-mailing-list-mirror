Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A6EC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjAQOtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 09:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjAQOta (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 09:49:30 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBB3525D
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 06:49:29 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id r15so4091019qtx.6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSpzM5UySsmhLtCKISIuRkLKrN/fRALzDnZpqxjwgyo=;
        b=VVkVIxDN2bXr3wjRN77NH/Gdx5KDn5nt42iEnsUvJcgaCs4EZhCV80V2NOXLqlaPbb
         jSDmxhUdZNlaiMO7O+1YhuQnbtNzA+p2OcA/0Tb+z3KmLuZXO+dYWuHqFGUKfI9J/U49
         p14AiaRt8dXMJ44WUOAfkqR6710e00ocxQ4v7O4n03DzPUrMGAgcAiCw82M293/O8T5k
         FqvZzTF3hpg8rC3IfchM8BngLdVw6t9AHQO4mHxj0otnS9KjciiH94n7wLVIEFHScn28
         Vx4LcaA4IpdSfVsbe616oDwvKCjsuWVaI7cryqjIg7/4DwfiGrUeXSl4tN1q2vC7wWyj
         1GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSpzM5UySsmhLtCKISIuRkLKrN/fRALzDnZpqxjwgyo=;
        b=ReVkGC2Sf4tXiNR9hAYe6o4pesYY9g/KjBuC3pFoLnmzIDCxIyN6hWAtT977yTo1PP
         Git3+QlvRE8q4M9otEXRJhAhFfW/SRfjQaL3fJHRzeXUGa3NTuiVWM4IvKsvGwq2XVbm
         gXWKsoYlNDbhkRfItyzGSKA12muZCH58dxXnv0GKz3Xe4zGZf5Vo4H+2qMp7k6HTPwWj
         0ackCVPA+gvAFKJlIwQ8T2HPFF8Dtw/XMXRKkBSftG7VcNvicJvKjRngdxNSpqjtKx9n
         BYU5eftJtg6UmhwyJRJEte/oWoTrn+CIeRzeXIcftaqawCFmwArLDaDi38/pMXp0obmJ
         ROjg==
X-Gm-Message-State: AFqh2koq1ieoUrMHgc1utAh8Bfb6PxnDHbSfeegWlZYzUO4kaZWty2cr
        +LHqMDVVvw3pAow34SsZ+N8u
X-Google-Smtp-Source: AMrXdXsht+E9odJA0et3Ds6SB5pC3OeUbaHu1evW3Y8ujbR4ZM9hIKxPcNe0G+71IW17n8IL+4yQmQ==
X-Received: by 2002:ac8:51c9:0:b0:3a8:1ca1:b489 with SMTP id d9-20020ac851c9000000b003a81ca1b489mr3505577qtn.60.1673966968855;
        Tue, 17 Jan 2023 06:49:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:b9ce:4130:c591:f90b? ([2600:1700:e72:80a0:b9ce:4130:c591:f90b])
        by smtp.gmail.com with ESMTPSA id b3-20020ac86bc3000000b003ab7aee56a0sm16103332qtt.39.2023.01.17.06.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 06:49:28 -0800 (PST)
Message-ID: <76204710-356a-2a85-9057-302e6619b9df@github.com>
Date:   Tue, 17 Jan 2023 09:49:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 0/4] Optionally skip hashing index on write
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>
References: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
 <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
 <xmqq358cgn3s.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq358cgn3s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2023 4:31 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Writing the index is a critical action that takes place in multiple Git
>> commands. The recent performance improvements available with the sparse
>> index show how often the I/O costs around the index can affect different Git
>> commands, although reading the index takes place more often than a write.
> 
> https://github.com/git/git/actions/runs/3922482355/jobs/6705454550#step:4:2006
> 
> shows that all other platforms passed but osx-gcc failed one of the
> tests this series added.  Could it be that there is something racy
> about the test (1006.6 if I am not mistaken)?

Yes, you are right. The patch below fixes the problem. Sorry about that!

-Stolee
 
-- >8 --

From 6827205f979ecfa66f4f9edabfb247cff05f0605 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Tue, 17 Jan 2023 09:46:04 -0500
Subject: [PATCH] t1600: fix racy index.skipHash test

The test 1600.6 can fail under --stress due to mtime collisions. Most of
the tests include a removal of the index file to guarantee that the
index is updated. However, the submodule test addded in ee1f0c242ef
(read-cache: add index.skipHash config option, 2023-01-06) did not
include this removal. Thus, on rare occasions, the test can fail because
the index still has a non-null trailing hash, as detected by the helper
added in da9acde14ed (test-lib-functions: add helper for trailing hash,
2023-01-06).

By removing the submodule's index before the 'git -C sub add a' command,
we guarantee that the index is rewritten with the new index.skipHash
config option.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1600-index.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 0ebbae13058..9368d82f7d7 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -88,6 +88,7 @@ test_expect_success 'index.skipHash config option' '
 	git -c protocol.file.allow=always submodule add ./ sub &&
 	git config index.skipHash false &&
 	git -C sub config index.skipHash true &&
+	rm -f .git/modules/sub/index &&
 	>sub/file &&
 	git -C sub add a &&
 	test_trailing_hash .git/modules/sub/index >hash &&
-- 
2.38.0.vfs.0.0

