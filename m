Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03ACE1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbeHNURN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:17:13 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:36416 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeHNURN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:17:13 -0400
Received: by mail-io0-f201.google.com with SMTP id w2-v6so13559009iom.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qWZpJSU7NvSQ8PCbu7IDdWZCpHfkuRLO9fiDWMlOm98=;
        b=PtBhpe2HvAwj3GH+mTSP0Oa5tED0xFHpvtF7iYC5yeeqjgMghnzzP17W99A9xjhQ84
         NP6pXQ/t6pqOsza/45Go7UVJy1WnSGOdSFS9+DJDUupeJG3lZj6q1CetzE0mS/x2TMl3
         ubmpZxYwL20LlSU+xi8iM9CIxX1aNNfvmKU6MCuqosyiY5nO0CObAYF9yItaEygWJHXo
         LkthKEj0KsPzuLqxv8z+cWnC718et9Cnzve5xqU6wTp3mf4Pq7A6SYkv6ByPL1gSj0aY
         ny6KjLbweiQDdc6j453Fz59rcGLNrnX8mh2zy5UimBpCLw9PgEqIT02nAHUMdal3Ox0C
         NmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qWZpJSU7NvSQ8PCbu7IDdWZCpHfkuRLO9fiDWMlOm98=;
        b=ScyxiZug4JcdUisNTv+FQDP5oWlZL+jBNFBnMgOVmW24mXx1mzlCxko5freHKWS+rP
         a3CgAjQTyWuEWfMfheP7TT/fFGfJnGwdqDo6emexN3CQlcp7LKSbrlZdokiYrBeiL84B
         cL0o0qWmaFzKtpsxA+Wymrj/E796Uvll+I3ydOyPubQSF80r69TTFCnWbrvBo7dy/omS
         28nwj+RuTdT4+Gi6pNH3lpn1JPNpOdu5Hfbxf8DHU00YvB8gboBrKvlpoSlWboKodWEH
         SVmGwiDtULBHHXIb43hYj4y3U7zDzb56DpORRxmDWwgZVdY3XspwZM5iZupbdHsbLAnF
         HALQ==
X-Gm-Message-State: AOUpUlGJVViptuA1fYpn1OgARTrB8keDFCf1oN9msGShJVC3slptHB+h
        KO/TLKPWD3SO0g7jtZtEKmkCBopXY/4MAgjGTRxfKp2ymw/WIDg+16YiCs7Bjji/Gc3PZWWrYD+
        RI4eGMyOsXCxK8lpU6e77y/10NG9eEV7SHs3tN+t2RvasYFbatuCwq79bOaM=
X-Google-Smtp-Source: AA+uWPy0/K3O5T5QKTZUtfqpQdD03JRNcOYzpNMi1IxvIBAwBxEN7d3Mo5GwyIcPcDrG/SPPEfsZAwtub7jn
X-Received: by 2002:a24:a44:: with SMTP id 65-v6mr8824560itw.19.1534267746316;
 Tue, 14 Aug 2018 10:29:06 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:28:07 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1534267611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v4 0/6] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've applied or responded to all changes suggested by Jonathan and Jeff.

Matthew DeVore (6):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  list-objects: always parse trees gently
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   3 +
 builtin/rev-list.c                     |  11 +-
 list-objects-filter-options.c          |   4 +
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  50 ++++++
 list-objects.c                         | 238 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  11 +-
 t/t0410-partial-clone.sh               |  66 +++++++
 t/t5317-pack-objects-filter-objects.sh |  40 +++++
 t/t5616-partial-clone.sh               |  38 ++++
 t/t6112-rev-list-filters-objects.sh    |  13 ++
 12 files changed, 358 insertions(+), 118 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6-goog

