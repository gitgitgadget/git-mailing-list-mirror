Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1731F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeJBVmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:42:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39760 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBVmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:42:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so1824689plp.6
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ppR2khltWpVfUxX9OpzbokmeMpuYCVPqSe2wfimhbQI=;
        b=EgYtu3IoBm5eMslOpWTXU0WIKdeAwH7E9IMklrQmN10gZllmE6JUBcNbri4NBtv+MU
         GSBxNY5+CiCtvTT/jNRfA66jTKx/mQjYwMqgiwUlhCUPWCIGK5UVLry0NtnX5lsExAsm
         baqRL01qKsqi+TgrI91bvuadTX7+Z2goSLn0HPlJBg49DBVE4qOu5Jb3krmmqTLAiPLc
         jR17AmRT+X5CaisVra46P76uOa+KTiJKRC5qMUxrzlMA+Ktc4Z8B8iMSmqRxj1apR62Q
         QGz/nY49DUg19BZvEY5Tj5grYzV13pibDBFSHVxofDxZakCQdZZ1cblDfJ01oKBnJ2Z7
         u4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ppR2khltWpVfUxX9OpzbokmeMpuYCVPqSe2wfimhbQI=;
        b=II5IMzjI2o/blR4wkRfCm7wQYzlw5iX58LGdYoUCzSt8KPObXcgZoCRb9ylP5f0pjS
         GhDasIBFb4TvbmDUr9uR9+FxBKI+7gRoE2/T3tS16540EahVvZVXdzACvltJaStpcJH6
         xUtlzmg0+2iMrk6WP2dOQiZyuzSqV5i7ysNZH7usDLPbsnSBlvYkDt/J5I3TVPo3uVyJ
         GLAqZlMxmxJuAUt4iB4Biw3I7AB/OW1zzPvxqm7c2UXStydtWgK/mmLSfFUcV82LF5gl
         3fm50BhGTH2up7Dn9zkUncuGgSY6mJ8VsY9amp+lxPivVNoQnLb2V6UDGB0X00j94x00
         BuVA==
X-Gm-Message-State: ABuFfojlNV2mOlkZv1JbGjghjBm6rFLqVSiXYhfTsMAEsjFLRiNKOvJZ
        /vWPzj9mnB8BVc0SfTbsHHLqNes7
X-Google-Smtp-Source: ACcGV611ptjthHFEz3nT6tFe/kt+YMK4JFFPkk1yUSOp41qgXBmy4GoIE4aL3NblKh6ATmezfbWRWQ==
X-Received: by 2002:a17:902:261:: with SMTP id 88-v6mr17155138plc.331.1538492324592;
        Tue, 02 Oct 2018 07:58:44 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h10-v6sm25841142pfj.78.2018.10.02.07.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:58:43 -0700 (PDT)
Date:   Tue, 02 Oct 2018 07:58:43 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Oct 2018 14:58:39 GMT
Message-Id: <pull.42.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Clean up leaks in commit-graph.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at the commit-graph code, I noticed some memory leaks. These
can be found by running

valgrind --leak-check=full ./git commit-graph write --reachable

The impact of these leaks are small, as we never call write_commit_graph
_reachable in a loop, but it is best to be diligent here.

While looking at memory consumption within write_commit_graph(), I noticed
that we initialize our oid list with "object count / 4", which seems to be a
huge over-count. I reduce this by a factor of eight.

I built off of ab/commit-graph-progress, because my patch involves lines
close to those changes.

Thanks, -Stolee

Derrick Stolee (2):
  commit-graph: clean up leaked memory during write
  commit-graph: reduce initial oid allocation

 commit-graph.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: 6b89a34c89fc763292f06012318b852b74825619
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-42%2Fderrickstolee%2Fcommit-graph-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-42/derrickstolee/commit-graph-leak-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/42
-- 
gitgitgadget
