Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D2D1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032953AbdAFTMJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 14:12:09 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33115 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032907AbdAFTMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 14:12:07 -0500
Received: by mail-vk0-f45.google.com with SMTP id 137so317799826vkl.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=slTtVrwtbGk0WxSAB63yzx7YnejMviN2gQHKVWPctYY=;
        b=TiXENNypAIfUzC+epcTTkuPSonG546fai4jvD/xo7US5GnPW3DTvDZLNJCRanzVQqq
         6QwNpU6VM1jhpTdPPyULR/PDF2KAqUNe8YyajyOA+Wt5va3Obtu0hdtpMhuzgr2EM92K
         kHQQ3QtkRkioa6t6CtH4vRcIn99r/1pLZJHVVPgY1w6wlaHpdYcgzFXvXUqP/+JbZJvF
         FG9SzJGN1qr870SpmvbpAbDamVSrVF2j/6S3Ttv+1/5CFxwXHrDS4WNzhx+PckOjG7Vr
         ckWPmuqiJ2gR+uIB6D4U7Ud7Pp5AhposJCluGI0zLn6a2LR/tKVPxuqi7je9Tw7zHmbj
         v5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=slTtVrwtbGk0WxSAB63yzx7YnejMviN2gQHKVWPctYY=;
        b=JD2jPO7dduS7Zr081vR/WaSapPOHK4H6tQzaw6qhpNNpTXjJZAnK37HF4hEg3cLF1a
         VkJzdS8kCe0YSZBWTV2qu5szc4WKT/Am5CgRGY1sbLxDZCOrTE83xuCjWGtDbb6A+F9O
         rzRTMkwH5h/A0D5uq/gWTn4pT8b8kve2TWBjargaP7oENOp+Mj8gK5OMbgXxi+olBcqj
         B+3+KbIK2+TSP/oPhLPKn6q5p0izW0Dv2o3CqsN5CAawQlHk/DiXlFlwFyVYAnh5hGPQ
         fFuAw4y+LPKea5VRR/4vSnVIlJlxzyLT8elkn35Cm0b57ytoSOPLICDeoWzC0N53rSCD
         sLxw==
X-Gm-Message-State: AIkVDXI+Bp2t1eNhX0HiG5QV49yqw+ilLJJk2/bzEVBBuAWmcT7sH1qBEMyup9/iKEn7RxPIz3cHorTtBzYS9g==
X-Received: by 10.31.85.7 with SMTP id j7mr22787764vkb.103.1483729926478; Fri,
 06 Jan 2017 11:12:06 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.1.37 with HTTP; Fri, 6 Jan 2017 11:12:06 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 6 Jan 2017 13:12:06 -0600
X-Google-Sender-Auth: 6ezZRoJZiZr4ti0igFoYUqeV9ig
Message-ID: <CAHd499BREpaHHyN89a1HchyJiQzPpdo3NSfoLLGVONEmX1m19g@mail.gmail.com>
Subject: Rebasing a branch with merges
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the scenario:

I create a topic branch so one other developer and myself can work on
a feature that takes 2 weeks to complete. During that 2 week period,
changes are occurring on master that I need in my topic branch. Since
I have a collaborator on the branch, I opt for merges instead of
rebase.

Each day I merge from master to the topic branch, which changes code
I'm actively working in and requires semantic changes (functions
renamed, moved, etc).

Once I'm ready to merge the topic branch back into master, I have two
options (bearing in mind the goal is to keep history as clean as
possible. Furthermore this implies that the constant merging into
topic from master has made the topic branch look unwieldy and
difficult to audit):

1. Do a squash merge, which keeps history clean but we lose context
for the important bits (the commits representing units of work that
contribute to the topic itself).

2. Do a final rebase prior to merging.

#2 doesn't seem to be possible due to patch ordering. For example, if
I have real commits after merge commits that depend on those changes
from master being present as a base at that point in time, the rebase
will cause the patch before it to no longer include those changes from
master.

Is there a mechanism to rebase in this situation to both achieve a
clean, linear history for the topic branch and allow fast forward
merging if desired, while still not causing superfluous conflicts due
to the merges being omitted during the rebase?

Thanks in advance for any advice in this scenario.
