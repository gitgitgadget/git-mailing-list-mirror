Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0689B20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeLJSGV (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:06:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44097 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeLJSGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:06:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so5307844pgr.11
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Xhv2LmjaSPH1XS2vCqVrf/cERbAT8vEfmYBD8fsXKyQ=;
        b=CnUUXIxnHbO8J8Kp/RHV/k2Pw8zlZ0JLjkcoUhvIgpeHMh0LmATARtMtBO2WLCeY+y
         FqcNDIaI1IejSCCpbkq/xrep3hYPgkzR/mbiuWN9d7859YRzA5MV4a5NO/ktWi3KSnAH
         4IVNRWqynJFyyQiIExCDBAK9K5qq4SHHgre9xiDhR6UQmrjmQ3Q1Esc5wVE5DWhYAetC
         lkq3QlShtUzxhNsPn7lg6WLhaq8E0n0HbkZOmwm++NA6ROgomfY8X0pLThZdiC+TsxpG
         CD/JfX9qr2r55875ibM6ZpV9g/OBWyFga7Jnh4XpRHnFs8FWlNsMacldFQJe3OPqddCn
         p/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xhv2LmjaSPH1XS2vCqVrf/cERbAT8vEfmYBD8fsXKyQ=;
        b=YNvhXNX830/HiWVQVunkHW0UpmQ04HhqN3KVAMiDQZpJEb7s5Z+fv1asvogy2ACpG8
         Ll7NtPKt9mCcXnm3eRMdDO5Ae/dr/Sg78ZRti/MRf/OENDUp13Tvsg7zaRhW1dEVCDbj
         cDUk+fMMizyHUGvLid62QaIU3TyI9wlTU9vfwRgl/+I5mkVqzoT+UEjgTfFKNTnD9H6M
         QsV+9ppcIJylFYRVVGZeFuCTJC3snFipUsaIEfTtNLW24jc8s1rqnjj1gj6qbwOXiU1s
         dDOCYKTBbFMe5uHoZ2Hjr6qOQJL/Zhm4ePtyBj5RFAQUyUJFqx/MKMmhSRHJMVuNoQDG
         kKVA==
X-Gm-Message-State: AA+aEWaHVmQq/47C6aaBePIHI5+CtkikqH+E8Haql1BFCHZz2qbzke0F
        Nk2VuEYejrNVJ6dXU6bTKfUUfB1g
X-Google-Smtp-Source: AFSGD/Xb3801Si2fzQpzI/pkhmfVcbVXmB2AcL07UdbnUytVwzQz5KHEuWzn5PqNUCSbU8xSGQFmOg==
X-Received: by 2002:a62:9913:: with SMTP id d19mr13241275pfe.107.1544465179532;
        Mon, 10 Dec 2018 10:06:19 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id m67sm18840973pfm.73.2018.12.10.10.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:06:18 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:06:18 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:06:11 GMT
Message-Id: <pull.92.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/5] Create 'expire' and 'repack' verbs for git-multi-pack-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index provides a fast way to find an object among a large
list of pack-files. It stores a single pack-reference for each object id, so
duplicate objects are ignored. Among a list of pack-files storing the same
object, the most-recently modified one is used.

Create new verbs for the multi-pack-index builtin.

 * 'git multi-pack-index expire': If we have a pack-file indexed by the
   multi-pack-index, but all objects in that pack are duplicated in
   more-recently modified packs, then delete that pack (and any others like
   it). Delete the reference to that pack in the multi-pack-index.
   
   
 * 'git multi-pack-index repack --batch-size=': Starting from the oldest
   pack-files covered by the multi-pack-index, find those whose on-disk size
   is below the batch size until we have a collection of packs whose sizes
   add up to the batch size. Create a new pack containing all objects that
   the multi-pack-index references to those packs.
   
   

This allows us to create a new pattern for repacking objects: run 'repack'.
After enough time has passed that all Git commands that started before the
last 'repack' are finished, run 'expire' again. This approach has some
advantages over the existing "repack everything" model:

 1. Incremental. We can repack a small batch of objects at a time, instead
    of repacking all reachable objects. We can also limit ourselves to the
    objects that do not appear in newer pack-files.
    
    
 2. Highly Available. By adding a new pack-file (and not deleting the old
    pack-files) we do not interrupt concurrent Git commands, and do not
    suffer performance degradation. By expiring only pack-files that have no
    referenced objects, we know that Git commands that are doing normal
    object lookups* will not be interrupted.
    
    
 3. Note: if someone concurrently runs a Git command that uses
    get_all_packs(), then that command could try to read the pack-files and
    pack-indexes that we are deleting during an expire command. Such
    commands are usually related to object maintenance (i.e. fsck, gc,
    pack-objects) or are related to less-often-used features (i.e.
    fast-import, http-backend, server-info).
    
    

We plan to use this approach in VFS for Git to do background maintenance of
the "shared object cache" which is a Git alternate directory filled with
packfiles containing commits and trees. We currently download pack-files on
an hourly basis to keep up-to-date with the central server. The cache
servers supply packs on an hourly and daily basis, so most of the hourly
packs become useless after a new daily pack is downloaded. The 'expire'
command would clear out most of those packs, but many will still remain with
fewer than 100 objects remaining. The 'repack' command (with a batch size of
1-3gb, probably) can condense the remaining packs in commands that run for
1-3 min at a time. Since the daily packs range from 100-250mb, we will also
combine and condense those packs.

Thanks, -Stolee

Derrick Stolee (5):
  multi-pack-index: prepare for 'expire' verb
  midx: refactor permutation logic
  multi-pack-index: implement 'expire' verb
  multi-pack-index: prepare 'repack' verb
  midx: implement midx_repack()

 Documentation/git-multi-pack-index.txt |  20 +++
 builtin/multi-pack-index.c             |  12 +-
 midx.c                                 | 222 +++++++++++++++++++++++--
 midx.h                                 |   2 +
 t/t5319-multi-pack-index.sh            |  98 +++++++++++
 5 files changed, 343 insertions(+), 11 deletions(-)


base-commit: 26aa9fc81d4c7f6c3b456a29da0b7ec72e5c6595
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-92%2Fderrickstolee%2Fmidx-expire%2Fupstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-92/derrickstolee/midx-expire/upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/92
-- 
gitgitgadget
