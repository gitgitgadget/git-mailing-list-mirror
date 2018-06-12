Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BE61F403
	for <e@80x24.org>; Tue, 12 Jun 2018 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934781AbeFLX6c (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 19:58:32 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:41852 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934607AbeFLX6b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 19:58:31 -0400
Received: by mail-pl0-f43.google.com with SMTP id az12-v6so397641plb.8
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9fYWj5a/JD8q+ekfzj9lniYW42rEVYh5sxWsAsHl2Uk=;
        b=CnV+MhovQTIaMc+RPnLc4S/iBcXV9v4SrUD2ekDOE+pY//sQ9ssq4nTFoJ3hbtG6Vu
         X+by3//BAP+o9Lj0FclF/Djha9iPd1Rkcp3h9NjY5Vy/LO5ISlAQnhNNmH05vms83aDO
         SKalIcC8PCmwQW6nn8YlrSkOMYS6x1RU/xilA+EnNVpSe2pRpcrQY/+BYmzrLGylOZS2
         o7J4S6uLW0GfKkqjYBiFU3Tc9HLJ2/F1ECgfJBGAqHk8pTDp7sGCnUkJ9SfWKNqnOPWz
         8m1FP+yqzP3kw3b63etAHvJIjJVuarnWaaYWWJ7naNZZd2OI5Zrwk65LcM2U2t3ay8XV
         Wn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9fYWj5a/JD8q+ekfzj9lniYW42rEVYh5sxWsAsHl2Uk=;
        b=QsChe/bLEQSOoTj0qoAxMFY/eVNXfZHZGgYDhVbsqJLNwqA6UPupLB89bCaxs7PQNc
         BRyDXdlvR8v7l/14ssrWR++fEPmFIHAhzYnDu9F6VL3qa5sOj0hFLdUzyBekOxYjc1BK
         V/VGDnCNG9r0LqknWjgXPDlLlqn9RtgsoqQI/2b1Aj5IEDSl8KCYk8il57xjtLHr0TyU
         NXK4gPzvYl5nyX1CkJWUHoEOAK8IXpvWs7IF7vs/QJX8bFtmxGb50PAj5jCXQ0CeLH54
         PWP5Ybe/eyE3gchiyoXDnTBaKnH+unBIsLoJLfUY891IY0DHlixTUIyssMvxWzmVP017
         qfHQ==
X-Gm-Message-State: APt69E3s8D9InGx9fwkb2zI+IGblJqNXeHYajBsygej91ro5bTj6ZhfO
        gSHXMm8kzL3LkK8yj1GG56EQ9wkpC6Q=
X-Google-Smtp-Source: ADUXVKKvN/SDbEV+7NhNM6kUwoIdUYyYJPCUKWMZ8+LIIwPLjE7VaBa1+LWZCNm/a/6ZF6BSVd7Dbw==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12-v6mr2577679pls.169.1528847910952;
        Tue, 12 Jun 2018 16:58:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b2-v6sm1790674pfc.44.2018.06.12.16.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:58:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/3] submodules with no working tree shall unset core.worktree
Date:   Tue, 12 Jun 2018 16:58:22 -0700
Message-Id: <20180612235825.12271-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch teaches checkout/reset (with --recurse-submodules) to unset
the core.worktree config when the new state of the superprojects working tree
doesn't contain the submodules working tree.

The last patch is teaching "git submodule deinit" to unset the core.worktree
setting as well. It turned out this one is tricky, as for that we also
have to set it in the counter part, such as "submodule update".

Thanks,
Stefan

Stefan Beller (3):
  submodule: unset core.worktree if no working tree is present
  submodule: ensure core.worktree is set after update
  submodule deinit: unset core.worktree

 builtin/submodule--helper.c | 26 ++++++++++++++++++++++++++
 git-submodule.sh            |  5 +++++
 submodule.c                 | 14 ++++++++++++++
 submodule.h                 |  2 ++
 t/lib-submodule-update.sh   |  5 +++--
 t/t7400-submodule-basic.sh  |  5 +++++
 6 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.18.0.rc1.244.gcf134e6275-goog

