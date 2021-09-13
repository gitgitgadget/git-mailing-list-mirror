Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E7FC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C79160EE7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbhIMSNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346945AbhIMSNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF75C061762
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:26 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oo3-20020a17090b1c8300b00197449f1879so32261pjb.9
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A7f2M2btflFsV+NoB9gs1HClVFFqFQlFmShKN4oBrEs=;
        b=axc+SIO65bd6T8laKt9pLsNUQrMDVS3Gi63mjb0dNZWdGj1c02LkfZE0meQqJ/6SQS
         xZ0ys/qfIgBYThGxVvHPmTvQLjjxqjxBKJ3q4DQuTQkcZJ0JJ/5jSqQRnWbKFrujOtu4
         Ibhq6lWUAgKFJsgDwCvmTOAmDBhh+pjHeDtLcjeI3awoLR/ZQ2sKKqVrPssTLWWVI6BC
         WA4hUjOMmvOcpnjdkwfrClRKIVzrUW1Uc45zMtQqVkMEMkfmA5BGL5ZCpfsAEl124wOn
         k+zbDH1mCPqVyokJdXzw+OZ+wmpXvwEdxSK3zy5OkEIXRAt/crVQs+EiQEzbJOv1G26d
         7IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A7f2M2btflFsV+NoB9gs1HClVFFqFQlFmShKN4oBrEs=;
        b=J380AGqFFB7t72dWEMXHqkS4NLFdLJhlkpBJEeh+Sq50/8yXZIyfuaiXUkAqO15MBh
         iBUTg/ikJ+9eK7SEGnVd8nig/vP5iLtPe5H9dlv6kDZncNmXaHbpTJd1LxH7Hdx/qejz
         hsRSE8L2CSmw0mZci0SrI/gqfjF8E2ECLai9oP83fUbNytWNC0M0QxhvzP6A9dA2eIBu
         n/d3w/wDg8dUsT3tr9NG7PSZRISrMaHwJ+aB/rLqSw7IFbpQP0YXGv6/6soeqi/VwtpW
         vFurE3O/aEcYG/vok3PwLLCmnNz3jlLwYi7wgLtvbvFzYAqt7JmHuHvsOZPetVscHuk2
         anDg==
X-Gm-Message-State: AOAM532CQKay86S4C+dmog05uljun0e2O+5LVC3mPQnM5oQTjfv7+iXe
        islUEhY3KRI4BuHhSyYxwJ4L8o2u3TbVzoXQBNX5H0Er5eXjc0RD37jAwuNc2yxxQGGEFydBu8b
        ruQSOtPVDaOas04ZCttIiY/veqVFr8Qf8kM8NI0Fv4IhUlhuB0bxwh1AmNEyR8/E=
X-Google-Smtp-Source: ABdhPJwBTcdso/ZaBne36W2cQbx+Y3bYu265LenefgA0ZDJVyVJ1ZBkQYzk+7Al/Ov3xgr/RqoXbtP+LEeFqwA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:be08:b0:134:924:1733 with SMTP id
 r8-20020a170902be0800b0013409241733mr11610954pls.64.1631556745643; Mon, 13
 Sep 2021 11:12:25 -0700 (PDT)
Date:   Mon, 13 Sep 2021 11:12:18 -0700
Message-Id: <20210913181221.42635-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone! This patch was created in response to something we observed in
Google, where fsck failed to detect that the commit graph was invalid. We
initially assumed that fsck never checked the commit graph, but it turns out
that it does so only when core.commitgraph is set, even though we set defaults
for "whether to use the commit graph" in the repository settings.

Instead of using the config, let's use repository settings where
available. Replace core.commitGraph and core.multiPackIndex with their
equivalent repository settings in fsck and gc.

I'm fairly new to the codebase (this is my first patch!), so I have some
questions/concerns that I wasn't able to figure out:
- prepare_repo_settings() may have undesirable side effects or may
  not always be callable
- I can't find tests that cover the changes to gc, so I'm not sure if my
  understanding of gc is correct

Let me know if there is something I'm missing :)

CC-ing Derrick Stolee who has done work on both prepare_repo_settings and gc.

Glen Choo (3):
  fsck: verify commit graph when implicitly enabled
  fsck: verify multi-pack-index when implictly enabled
  gc: perform incremental repack when implictly enabled

 builtin/fsck.c              |  5 +++--
 builtin/gc.c                |  5 ++---
 t/t5318-commit-graph.sh     | 23 ++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh | 15 ++++++++++++++-
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

