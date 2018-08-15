Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF401F404
	for <e@80x24.org>; Wed, 15 Aug 2018 00:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeHODMm (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 23:12:42 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:33580 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 23:12:42 -0400
Received: by mail-yw1-f74.google.com with SMTP id c11-v6so28323181ywb.0
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EUKgc91nur9Fntt5GuFoiJ1oWYlRfwuwUPCFAtI4N70=;
        b=A3ja+se72VKYrK+nrbnD8bwmvSd0QJkXOCE4m3TfWGn+uEZB5R9FS3rJJrpTnjP44e
         6srfEd0DbgCbaXJQK1aZ1H3a5mAhvqNzyB8F1dkbYBGDPJUFWK3sDQrLa5B0SLHU2NfG
         UmHreA25Pr9mEL1GA8mVpdL7Q/4AX1/3wu77ZD3guB+ccAnxAzdFRDbIWq4UfA4aj2O1
         xuYF/25+WFvd0EUhJsHsJi+2ZJe7kz2xeGD0m1WRbjFGw0vzMLb/0AYD71RT0EZ2A1DO
         6Zcl1CB5LNXnGc6efvOgVvJT9564F5Y/zVt8hBNBgn8/mDcx+GCHq6jVc+HP+ZaqjbaM
         vMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EUKgc91nur9Fntt5GuFoiJ1oWYlRfwuwUPCFAtI4N70=;
        b=ZG+hVJsPRKAykPtHb+JRIfyqIcAO8jUPBTX6OZbejhIAnYFDB0T+KhBpGZq6jitjgv
         9aK31T1RyeRpLoeYBUa/9bwsKaTAyeFka6393BSt3snSS4KwMBnUxvsZGfG6Y9ht9vPm
         K8GpehyusInrSz+kxx3Vzq0+0XY9O9WEkkGXDCPw02S67y7hNPNqaiKYhGMbt9zzFsOE
         oT9q3PT8emOXo5aRynnqYjfFxJZUTl2o1bvDl/xO4VMCH6PR5YlmIusWGsR7V+8n14Mi
         2GDavkZEj1eXFhNddJzD6PGFF3qmVpLHsU21XizM7YgWz8R+GmR6K8WqXjLus7p4cP3h
         UGcw==
X-Gm-Message-State: AOUpUlGm5RR/xOpVXfVFih2SMBKZIBGP5j3v/GcAkfYa5JBYgCrEWMN+
        XwFVBC8ZTPcry5hLjrOg3160UOki6OZeOjiQ3m6TnI4tFZQEwC2PavGEkB9LTtFm2uHfvqXqrW0
        aJqGGSvxtzWQ2zyvV122LFOT6B+eLcKMPnQq/V4CvdduOYMIOr7Lrps08L2g=
X-Google-Smtp-Source: AA+uWPzxbtvQ55LKqW4U9sqHVrXYGpMcJQcRsclAkJ6r4mWq0lnbxLAU+HTRGnKcFIaJ1QmQSejIAMNW80c/
X-Received: by 2002:a25:6108:: with SMTP id v8-v6mr6721606ybb.44.1534292582360;
 Tue, 14 Aug 2018 17:23:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:22:49 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1534291033.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v5 0/6] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please take a look. I believe I have applied or responded to all suggestions
since the last iteration.

Matthew DeVore (6):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  list-objects: always parse trees gently
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   5 +
 builtin/rev-list.c                     |  11 +-
 list-objects-filter-options.c          |   4 +
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  50 ++++++
 list-objects.c                         | 232 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  25 ++-
 t/t0410-partial-clone.sh               |  45 +++++
 t/t5317-pack-objects-filter-objects.sh |  41 +++++
 t/t5616-partial-clone.sh               |  38 ++++
 t/t6112-rev-list-filters-objects.sh    |  29 ++++
 12 files changed, 364 insertions(+), 118 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6-goog

