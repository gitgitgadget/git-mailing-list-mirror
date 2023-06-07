Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C112EC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 21:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjFGVhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFGVhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 17:37:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7641BD6
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 14:37:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569fee67d9dso23570307b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686173834; x=1688765834;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mRK89x6ugvEurwIP0OKyXBXQuR/YXEC55EarMfas7+0=;
        b=XYNQQ8jkl9y6/zPMoknbhkPmQYlHFMWtpIGpaYJ7XY6IfEa0aRgznwU+W4ju2Dm06a
         5QjlL0at0gDdTsG/5vXVvMBGKA52g5J58kezYPgnLXrpAlKv/Izobh6cMjuHIwj0q3F5
         2v06VPktqSgrWgHwmU3mYhMDEl2twTuhtOlVHj6heutDrKFGSaPdFPmo8QjSR76nDUHq
         jnj+pdohskKXqLYuWPYVbBQdIiPifUbvBdnlf1GmRBG/yK9ASgfB3zunWA2va0fqZC7O
         05+72U7svCNAtaG4/dJcB7c97uTjfUvOurkG9J+egi6tfmXdoEDmHVvQ8LJMdDuv3kU+
         JXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686173834; x=1688765834;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRK89x6ugvEurwIP0OKyXBXQuR/YXEC55EarMfas7+0=;
        b=QcQMpG7bRJ5tKJEhgPGff/NxHeYy3u+u+5rZH8UkO19sJ0cwSJ54TKDHu2bkMJTld1
         voy315NgRodbmEYiyIMWDyK9VP0MMaa4PVn7KsdF+Rw+M0QHIs9MKgHvpz7kJfFyxAXG
         pRcge32/TcvI7X5u1PicSm5gZni3lnG+lfIj6yE1ivKjIQCojbJfMfHEQ7SSgMALHA7e
         mXxLctpmcY35bEntDvbZBEH6H9WwFBANyTgqO5vs5QoDiWuBgGp8kjIq27j9AYWxEmii
         3/Wh29xrAlvWc9R0SouQoU/IfGVx2l0vxf0uwtjqLLhzK45yHVuLevfKSsfNU0Su25jj
         MM5w==
X-Gm-Message-State: AC+VfDzB120luGzVtVUnVurovoYMAoelXuiGewHxK0nSnHnJRaArH9PU
        5Yjwz8mNjvq6hyoPZ61k2dNbYrDjPOI412FoOn9C
X-Google-Smtp-Source: ACHHUZ4ykrpnLFeDfCu9A7cX1AV+JPeuGzwrkj20Z+uPlGiwLq4/YCAyU7eB+YEOGisHM7LPtPCcyOwJn+SmiAKf8G3f
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:83cf:b5ee:dde8:2648])
 (user=jonathantanmy job=sendgmr) by 2002:a81:e90b:0:b0:559:d859:d749 with
 SMTP id d11-20020a81e90b000000b00559d859d749mr175781ywm.5.1686173834699; Wed,
 07 Jun 2023 14:37:14 -0700 (PDT)
Date:   Wed,  7 Jun 2023 14:37:12 -0700
In-Reply-To: <20230607163056.1602219-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230607213712.2589505-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/3] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
> > Seems to break t4216 when merged to 'seen' to replace the previous
> > round.  Could you take a look?
> 
> OK - I see that it fails CI when I upload the merge to GitHub (although
> it passes locally). I'll take a look.

Hmm...so when the test writes a file with a high bit filename, the
filename written is different. Here's the output from my machine
(Linux):

        ++ git -C highbit1/ commit -m c1                                                                                                                          
        [main (root-commit) 808e481] c1                                                                                                                           
         Author: A U Thor <author@example.com>                                                                                                                    
         1 file changed, 1 insertion(+)                                                                                                                           
         create mode 100644 "\302\242"                                                                                                                            
        ++ case "$tag" in                                                                                                                                         
        ++ git -C highbit1/ tag c1                                                                                                                                
        ++ touch $'\302\242\302\242'                                                                                                                              
        ++ ls                                                                                                                                                     
         A        expect   file5_renamed   limits        log_wo_bloom   trace2-auto.txt  ''$'\302\242\302\242'                                                    
         actual   file4    highbit1        log_w_bloom   trace.perf     trace2.txt                                                                                
        ++ git -C highbit1 commit-graph write --reachable --changed-paths                                                                                         
        bloom calculating -62,-94 version 1                                                                                                                       
        ok 141 - set up repo with high bit path, version 1 changed-path       

and here's the output from the CI on GitHub on linux-gcc-default:

        [main (root-commit) 3f37a43] c1
         Author: A U Thor <author@example.com>
         1 file changed, 1 insertion(+)
         create mode 100644 "\\xc2\\xa2"
        + git -C highbit1/ tag c1
        + touch \xc2\xa2\xc2\xa2
        + ls
        A
        \xc2\xa2\xc2\xa2
        actual
        expect
        file4
        file5_renamed
        highbit1
        limits
        log_w_bloom
        log_wo_bloom
        trace.perf
        trace2-auto.txt
        trace2.txt
        + git -C highbit1 commit-graph write --reachable --changed-paths
        bloom calculating 92,120 version 1

        ok 141 - set up repo with high bit path, version 1 changed-path

These were run with some extra code, here for completeness:

        diff --git a/bloom.c b/bloom.c
        index dea883d8d6..ccc3e0ce80 100644
        --- a/bloom.c
        +++ b/bloom.c
        @@ -192,6 +192,8 @@ void fill_bloom_key(const char *data,
                        ? murmur3_seeded_v2 : murmur3_seeded_v1)(seed0, data, len);
                const uint32_t hash1 = (settings->hash_version == 2
                        ? murmur3_seeded_v2 : murmur3_seeded_v1)(seed1, data, len);
        +       if (len > 0)
        +               fprintf(stderr, "bloom calculating %d,%d version %d\n", data[0], data[1], settings->hash_version);
 
                key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
                for (i = 0; i < settings->num_hashes; i++)
        diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
        index 764c6dee0f..1121e7d4cd 100755
        --- a/t/t4216-log-bloom.sh
        +++ b/t/t4216-log-bloom.sh
        @@ -423,6 +423,8 @@ CENT=$(printf "\xc2\xa2")
         test_expect_success 'set up repo with high bit path, version 1 changed-path' '
                git init highbit1 &&
                test_commit -C highbit1 c1 "$CENT" &&
        +       touch $CENT$CENT &&
        +       ls &&
                git -C highbit1 commit-graph write --reachable --changed-paths
         '

Notice the different filename after "create mode", and the different
"ls" output. I'll investigate some more, but if anyone offhand knows
what's going on (and/or knows how to write a high-bit filename portably,
even across  Linux), please let me know.

An alternative is to drop the tests from these patches - so, leave them
in during the review period and reviewers would see that the tests pass
the CI jobs for Windows and Mac OS X pass, and then before we merge it,
delete the tests from the patches. This also solves needing to prevent
unsigned char platforms from running the version 1 tests - there's no
prereq for that yet and we would have to investigate making one.
