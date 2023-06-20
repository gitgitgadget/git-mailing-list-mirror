Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAFCEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjFTTBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFTTBU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:01:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13D10DA
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:01:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fcda210cfso4892603f8f.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687287677; x=1689879677;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cTXSY6EWiI9m5hbzLzVGA7R/IaagVF1d4v1rKZQeVPM=;
        b=T/MVs+Y0U9m3GKKCk+VTv4VPiPpBXOgcZ+52kYbllwmRcAeq8zJpj5ZJ3Ony8Iy3nx
         JujQ3XhytpIzRik3q7FXZdiBkutNOzKiQXMTXeQbzGZsqL0YY+G3wro7xgnSR2OzQ4HK
         cnD3hHMbAmliYZ35ceTO3/Jxd3lty/CoeHYYemaVLBzEZF722LHAFxV8LAKkxL3eHpkc
         1KzkaQIJV0v+eT0UFFrakQcSJd62BTwicMOpYEFq0vPh0fMgUE572fn9KXRiXk0NIsPp
         cVA1+8fcWkUuYb9ZMwGOHvvRCJ+MAfa2l44ls9OHllWK3UXYpN9oKQ1hmC7o6SvcUM1w
         Zk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287677; x=1689879677;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTXSY6EWiI9m5hbzLzVGA7R/IaagVF1d4v1rKZQeVPM=;
        b=Cj9b2UelIhwM9VZzfoFkVplbA5E3U+s/zwr3sXDT2465NyRwV/Gabb7QV2128XaTxM
         89VbEQFYz2J2puCV/dOQH7RIDw3UAVmsYi0ZxMwKFKtE4IFyBiOeAJBWZnlufd3BhP3Q
         sl5Ouz+N1T7IPRF7WPNltW+UGYSQZzcMSaV0lOgsBUAJFXadmqtQ5JYVAkV+5jU3BELm
         2VY7XHUQk1Z9Y+Zd3qhnEj1hPwxWsZ2uxQcgcEuggtQ/nZKEmQono+jaQ1+9zhpuIhex
         f4F9cpr9PVwTCIZ4NPj3gOmXBxwuWUXeUq7m56h71wkUvmLG2det9YBzuU1jZbnzM+Gi
         r/iA==
X-Gm-Message-State: AC+VfDyPef8ixk8WMj/N4B0p+0gx+cldiFxgRmvAzTbc0fk2XFOwseS0
        hcxEpzb7Ysgx3X7VfGzrlrWjrAj3wbA=
X-Google-Smtp-Source: ACHHUZ7plLhGwy6wcOxi0BZpDc+Qb+12W+RP/SayAitRVA67Wma4aaX39D89i9gDcpbHL/hlQgF4JA==
X-Received: by 2002:a5d:6605:0:b0:30f:d10c:b27a with SMTP id n5-20020a5d6605000000b0030fd10cb27amr9832479wru.34.1687287676443;
        Tue, 20 Jun 2023 12:01:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d408e000000b00300aee6c9cesm2601432wrp.20.2023.06.20.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:01:16 -0700 (PDT)
Message-Id: <pull.1547.git.1687287675248.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:01:15 +0000
Subject: [PATCH] packfile: delete .idx files before .pack files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When installing a packfile, we place the .pack file before the .idx
file. The intention is that Git scans for .idx files in the pack
directory and then loads the .pack files from that list.

However, when we delete packfiles, we do not do this in the reverse
order as we should. The unlink_pack_path() method deletes the .pack
followed by the .idx.

This creates a window where the process could be interrupted between
the .pack deletion and the .idx deletion, leaving the repository in a
state that looks strange, but isn't actually too problematic if we
assume the pack was safe to delete. The .idx without a .pack will cause
some overhead, but will not interrupt other Git processes.

This ordering was introduced into the 'git repack' builtin by
a1bbc6c0176 (repack: rewrite the shell script in C, 2013-09-15), though
we must be careful to track history through the code move in 8434e85d5f9
(repack: refactor pack deletion for future use, 2019-06-10) to see that.

This became more important after 73320e49add (builtin/repack.c: only
collect fully-formed packs, 2023-06-07) changed how 'git repack' scanned
for packfiles for use in the cruft pack process. It previously looked
for .pack files, but that was problematic due to the order that packs
are installed: repacks between the creation of a .pack and the creation
of its .idx would result in hard failures.

There is an independent proposal about what to do in the case of a .idx
without a .pack during this 'git repack' scenario, but this change is
focused on deleting .pack files more safely.

Modify the order to delete the .idx before the .pack. The rest of the
modifiers on the .pack should still come after the .pack so we know all
of the presumed properties of the packfile as long as it exists in the
filesystem, in case we wish to reinstate it by re-indexing the .pack
file.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    packfile: delete .idx files before .pack files
    
    I'm going to submit an RFC soon [1] that approaches this issue from
    another angle, but this should be a straightforward fix to avoid the
    problematic "an .idx exists without its .pack" case that has been seen
    in the wild.
    
    [1] https://github.com/gitgitgadget/git/pull/1546
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1547%2Fderrickstolee%2Fdelete-idx-first-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1547/derrickstolee/delete-idx-first-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1547

 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index fd083c86e00..6b591ddcccf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -381,7 +381,7 @@ void close_object_store(struct raw_object_store *o)
 
 void unlink_pack_path(const char *pack_name, int force_delete)
 {
-	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
+	static const char *exts[] = {".idx", ".pack", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
