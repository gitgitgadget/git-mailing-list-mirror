Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ABAC32771
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 04:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00D2084D
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 04:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StxnYxmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbgALEPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 23:15:31 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:35008 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732129AbgALEPb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 23:15:31 -0500
Received: by mail-pj1-f73.google.com with SMTP id l8so4430183pje.0
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 20:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=51zD1dS0xPInbrXbE6ah9Dn/Z9PNzYYlTEC549vqe6Q=;
        b=StxnYxmVQq/9caD2BYvS+kla+cT70oH18hHW3+sj6zzwxF27njcRA/+o1qpDc1Im5q
         A6Oh3uOwjTu3MEx8Sez8pUL1eBbhxu4RuFhbKyZvv/GXHOv2pX6vsrthyrzN1lHJl/x2
         2a3VhDDvQonm9OE2Rqn5KLdyJzJAhMIojg8CHEUaEzbKkwiE6be+tFjunDI+GIVqi/Zq
         twDsGKwp18b6FzBBmCuEgtlBH89TNSGdYitLFFLBRKceN6qogLIJG1FMNveXObRINega
         ynzMvjI0DUbwioZo9ZObMDGButhTWdXkZghqjmGUkShRlB5pPhnZ7ApT7TaX9liAaoUc
         wBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=51zD1dS0xPInbrXbE6ah9Dn/Z9PNzYYlTEC549vqe6Q=;
        b=NebiMEBohXG7cTdlZJGAkWUqvO3XqIrXIw1w+twCMflCszYZaS8jqc/DUP1mJ6ShJH
         lbvLWUpsXp15CBeAPxlXUfw9pIjifeaW1qFvUF1y5UCnjCu6e6fnamb372IJBSr9KjQq
         D+TchzkdXlaTCfEwtZyL2dd0rEsy0T7tHzc/8ID64vMVVXVSSvAIKrP7r013LVKgK/z7
         BYIWo+sJrwHdsF1HOwNCLd67TvgB08+/cu/bNXOlwmPVlxlh0MR+0KRPjsIyXEdhWUmf
         uhlSKTFqGG6owbdyrHyJ0sD18gV8wKtidEjMI99CCoK792u3QgZcUfeBwQN3kpxvZ7G1
         3kWg==
X-Gm-Message-State: APjAAAWXR4EVkXeg2xCfczl+I0cGiC9+970p7Drlo6RmYK1po7MAnHOe
        WlVkewkg+XNae/z8BV2uZEvAtxS4W+8p7ZLZm8gQa8tl3YsAIGt9HNH1bgQpaIbroBbiYQ/+c4x
        HWHJqchBvxN1p0bb9LcTQy7xaM1voLiNezlo6uchQZGNAK8gsAEqripxMEXBOD2GhaOYh/lQlcW
        NV
X-Google-Smtp-Source: APXvYqw70Y0IofMg6abC4N/a3/8k8z1Ofb+9n9yL9r3kmNYp/qHaozpbkUd32t/jc6JEp4VlvLckacGjVulCtxaVYndZ
X-Received: by 2002:a63:1119:: with SMTP id g25mr14344527pgl.359.1578802530434;
 Sat, 11 Jan 2020 20:15:30 -0800 (PST)
Date:   Sat, 11 Jan 2020 20:15:23 -0800
Message-Id: <cover.1578802317.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 0/2] Skip a connectivity check during fetch --filter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same optimization in dfa33a298d ("clone: do faster object check for
partial clones", 2019-04-21) can be applied to fetch as well, so this
patch set does so. Patch 1 makes the check more robust, and patch 2
applies it to one of two connectivity checks performed during the fetch.

As mentioned in patch 2, when fetching from a local repo, I got a
speedup of 6.63s to 3.39s. 

Jonathan Tan (2):
  connected: verify promisor-ness of partial clone
  fetch: forgo full connectivity check if --filter

 builtin/clone.c |  5 +++--
 builtin/fetch.c | 11 ++++++++++-
 connected.c     | 19 ++++++++++++++-----
 connected.h     | 11 ++++++-----
 4 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

