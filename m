Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A7DC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAC420771
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE/3T6fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbgF3PDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgF3PDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C55C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h4so2490769plt.9
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=0mUVJi2jzPqCugzhUNoSGwV/mW6x0J2wDG8R26vRAtg=;
        b=KE/3T6flmyPu2eNPsM7XE5qyX425YX2D2LhoOO8unlDnC6rVOgWnB0WZFhcmbThf2a
         dsTUpsJ3mVPYZRuVE7rB8z5eIuYmQ4jVz7jAIjxxKe3Fg+kC1cJ8cMrvpMsMgLIlYFaK
         OyUL8frb01WaMK2NfMV16t8Xgb6EYFqbiCVOG/iLRc3QqZAmePGEsKm2zIp1R85Z9sUI
         JTwoZCOOiSFvCDBZMSo/6L2JrqDXfVTP1ZW91Wdwws4x3aZEhNAg1JtpoJ4QCtRzafzN
         w2fy6khpdNw+WiP/I+FvBjcdapwIDqn7+YrodBkh+rJsQkFKhz6in+mYdwN+5B7lS8EX
         CYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=0mUVJi2jzPqCugzhUNoSGwV/mW6x0J2wDG8R26vRAtg=;
        b=Gd0uPZCk7PAINhFlqu3lSWG3h8JxlEXc1HXPVc0ktyl0YJGsfy46X9FQ4Uu/T2BQ92
         BFE5Lyy5CyZXjW211XsmOfY2yoqDCKtOXCph2ZeqljuRbQN2abAsoTz/GiFtnxzvFxQ7
         zJzwUM55mtSsvX+i+ilatMDdLO09IbT/6M1OJqxbc1Ga9Up9bBxgjs7TFgnk9izKblpU
         KQBWC44kw13ptJZf628g0fQbGtEPluMEVAzDWO1lpr/yn7fIoEzLLROcPMqSnMHdGXob
         8SuW8TCHP1uPd0SwjKBY3omQLvcBBrXvrZtGfuGtV+N0f6JWCgMzFcx0AbJnJqZLn8WV
         WT9g==
X-Gm-Message-State: AOAM530GXpx8GLGLCsF8RFfgrRwnsNGQbL9xByNj6p4q79fzvK5b/+gd
        4ISbYlrRIeHFYhfn6ZZ/LXc=
X-Google-Smtp-Source: ABdhPJyT6jNLt3x0QlSBlEiXNEZNZ/VZKD3qHTlrJNxLq1b0ElKeaSNrBkamDcEIBM6NkO/vNjx+fA==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr20858405pjc.27.1593529385209;
        Tue, 30 Jun 2020 08:03:05 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:2e12:1676:a4c3:af9:291d:7f18])
        by smtp.gmail.com with ESMTPSA id mu17sm2886974pjb.53.2020.06.30.08.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:02:55 -0700 (PDT)
Date:   Tue, 30 Jun 2020 20:30:56 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     abhishekkumar8222@gmail.com
Cc:     jnareb@gmail.com, stolee@gmail.com, git@vger.kernel.org
Subject: Re: [RFC] Metadata vs Generation Data Chunk
Message-ID: <20200630150056.GA4111@Abhishek-Arch>
Reply-To: 20200622093451.GA1719@abhishek-arch
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I have finished all tests that I can think of and instead of throwing
performance numbers at you, I am going to try and tell you a story.

WRITING COMMIT GRAPH
====================

The run time of writing a commit-graph is affected by time taken to
compute generation number(s) and write them to the file.

We had the following possible ideas for writing commit-graph:

MO: Calculate generation number V5 and write the offset into CDAT
    (along with a metadata chunk).

G5O: Calculate generation number V5 and write the corrected date into
    Generation Data chunk.

G5D: Calculate generation number V5 and write the offset into Generation
    Data chunk.

G3IO: Calculate generation number V3 and write GENERATION_NUMBER_MAX into
    CDAT and the offset into Generation Data chunk.

G3ID: Calculate generation number V3 and write GENERATION_NUMBER_MAX into
    CDAT and the corrected date into Generation Data chunk.

G3TO: Calculate generation number V3 and generation number V0, write
    topological levels into CDAT and the offset into Generation Data
    chunk.

G3TD: Calculate generation number V3 and generation number V0, write
    topological levels into CDAT and the offset into Generation Data
    chunk.

Key:
- M -> Metadata, G -> Generation
- 5 -> Generation Number V5, 3 -> Generation Number V3,
- T -> Topological level, I (for infinity) -> Generation Number Max
- O -> Offset, D -> Date

On the Linux repo with HEAD at 08bf1a27, time is taken by different
versions:

| Version | time Taken      |
|---------|-----------------|
| master  | 14.200s         |
| MO      | 14.094s         |
| G5D     | 14.406s         |
| G5O     | 14.323s         |
| G3IO    | 14.175s         |
| G3ID    | 14.258s         |
| G3TO    | 14.331s         |
| G3TD    | 14.419s         |

Observations:

- Writing offset (i.e., 32-bits) is faster than writing corrected date 
  (which are 64-bit long). However, we would have to deal with overflow
  issues.

  The largest offset value observed was of the order 2 ** 29. Assuming
  no further "skips" in offset, we can store around ~635 million
  commits without overflows. This, however, might not be true for other
  repositories.

  A repository with a commit with Unix epoch '0' will overflow.
  If we choose some sane default like commit date must be higher than
  the release date of git, we can store around 110 million commits even
  with '0' epoch.

- Calculating topological levels with generation number V3 takes nearly
  the same time as calculating generation number V5.

- The commit-graph file is larger by 4 Mb (+8%) and 8 Mb (+16%) when
  storing offsets and dates.

Reading Commit Graph
====================

The time taken in using commit-graph to answer queries depends on:
- The number of commits walked.
- The time taken to load commit data from commit-graph.

Number of commits walked for different commands:

| Command                         | Master |   V3   |   V5   |
|---------------------------------|--------|--------|--------|
| log --topo-order -10000         |  48011 |  49954 |  49933 |
| log --topo-order -100 v5.4 v5.5 |   3794 |   3314 |   3312 |
| log --topo-order -100 v4.8 v4.9 |   5736 |   3887 |   3625 |
| merge-base v5.4 v5.5            |  55053 |  57097 |  55109 |
| merge-base v4.8 v4.9            | 635579 | 167468 | 506577 |

- For log --topo-order, V3, and V5 walk 35% fewer commits than
  the topological level when comparing v4.8 and v4.9.

- V3 walks far fewer commits than V5 when comparing by generation
  numbers and then date for paint_down_to_common(). This is unusual
  and is probably due to my implementation. Based on log --topo-order,
  we might expect V5 to perform better than V3.
 
- V3 walks the same number of commits when compared using commit
  date for merge-base.

The time taken for each command rough corresponds to the number of
commits walked, with no difference between Metadata chunk and Generation
Data chunk approaches.

| Command                         | Master  |    V3   |   V5   |
|---------------------------------|---------|---------|--------|
| log --topo-order -10000         |  0.210s |  0.209s | 0.207s |
| log --topo-order -100 v5.4 v5.5 |  0.013s |  0.013s | 0.013s |
| log --topo-order -100 v4.8 v4.9 |  0.015s |  0.013s | 0.013s |
| merge-base v5.4 v5.5            |  0.048s |  0.047s | 0.047s |
| merge-base v4.8 v4.9            |  0.135s |  0.133s | 0.134s |

CONCLUSION
==========

With all this, my inital recommendation becomes more specific as:

- If overflows are unlikely to happen and not accounted for, implement
  generation number V5 using metadata chunk. It has the lowest write
  time and walks just as few commits as V3.

- If overflows are a concern, implement generation number V5 with
  generation data chunk, storing offsets in generation data chunk.

Thanks
- Abhishek
