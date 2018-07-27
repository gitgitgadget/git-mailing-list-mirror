Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FAE31F597
	for <e@80x24.org>; Fri, 27 Jul 2018 00:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbeG0B4b (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 21:56:31 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:36771 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbeG0B4b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 21:56:31 -0400
Received: by mail-qk0-f201.google.com with SMTP id c27-v6so2968603qkj.3
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 17:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3t5Tufo9DNzkuxl0VKRTCVxQMcKwmiVsuLamrfY3T48=;
        b=glBAFaRIQ7ftzMKygN/zxmCIFqJU2Za196aZfeRb06n2ElvW5HIEvpyUO4SIMYm+ey
         zKY8NEB3tZ3Li2izwl7LnFUirFvl+j1RWFqZcI+8F3aPdshTDJ4YR7C3nMb4Dp94yQmv
         3yOwKN8ddaQ8HCZPHXNUUQDlTAmNKUpKzvISaKSBUT6Ct3bSsE54e19ELcPV/wHUSDOO
         AWTSBIO5ltbVL9zZQbBGfwJhbLF3LzA6Wd8x2I5UOIOiZSZzCnOK9cDDkclk8Kl5Fygx
         VMPYxZXXUmGlHsotl6QP5rbnQJsuQ4fkAkNwtU3klcmMqaCx9RbJjpSa2uVWYRpBBRNo
         sR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3t5Tufo9DNzkuxl0VKRTCVxQMcKwmiVsuLamrfY3T48=;
        b=khF0EtLcGtuuj3pRMZXXRJEpo/P2N/okdmu0kNjMjy1sz6EUY/q4bc58Wbt6lFQDXM
         JVolhTkRqHdyvhOhxr6ZEO374Evb0O5IOXq+G3l8XavnhP28/FGSjMCZGdJJM5e0N6+x
         WyVPmvOboXrGf1qdqaSZHvBwAtAlCOEfuQKEMNgqYvGqoyuWx3lqfIlOVwEFPCEFBDR7
         9JmFInWkPw87yV65wQTBj2oRZbgGNDRzhgA2YkKsIT+Qw+m55Stivnl2/+bWr7+in6qj
         5QGKE1NULjh8gQS6U6jYGJUEhi5pdpwe2R/SmJh4jzNHmvk1GNXTjuuKkvl9223Q+rvN
         aHag==
X-Gm-Message-State: AOUpUlEOg9R1vGbanKexkTN5MGsX8T7/VAxyZ9x6EAe61y1kWa6YZpYN
        swP/lad8JrBGZ2RZjp8aZ24uSlC2ZRYOF6x8AN33y4yadey8fLNc7ooKU6GUYyIinvAuRKIzPzP
        SIU9W7svtCwG/nmm+w6IMPrlW2HAnb5Ke/c/Pe0arkVsdVGkwCCVzaDrymc9S
X-Google-Smtp-Source: AAOMgpceJAFlmDehR+kck9akLhI3x50GN+ZjfjZLnhiUPv5iCjKTvO/nBNMeqQCU++UEqC9hS8vVhewDeuDu
X-Received: by 2002:a0c:b0e1:: with SMTP id p30-v6mr2166427qvc.58.1532651835396;
 Thu, 26 Jul 2018 17:37:15 -0700 (PDT)
Date:   Thu, 26 Jul 2018 17:36:37 -0700
Message-Id: <20180727003640.16659-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [RFC PATCH 0/3] Migrate the refs API to take the repository argument
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second patch is the real API proposal.
Unlike the lookup_* series, which caused a lot of integration pain to Junio,
I plan to structure this in a different way, by having multiple steps:

 (1) in this (later to be non-RFC) series, add the new API that passes thru
     the repository; for now do not replace refs_store argument by
     struct repository.
 (2) the last patch is a demo of converting one of the callers over
     to the new API; this would need to be done for all of them
     
 (3) After some time do a cleanup series to remove callers of the
     old API fromly introduced series that are currently in flight.
 (4) Remove the old API.

 (5) Introduce the final API removing the refs_store
 (6) convert all callers to the final API, using this same dual step approach
 (7) remove this API
 
Steps 1,2 will be done in this series (2 is done only as demo here
for one function, but the non-RFC would do it all)

Steps 3,4 would be done once there are no more series in flight using
the old API.

Before continuing on step (2), I would want to ask for your thoughts
of (1).

Also note that after step (1) before (4) refs.h looks messy as well as
between (5) and (7).

Thanks,
Stefan


Stefan Beller (3):
  refs.c: migrate internal ref iteration to pass thru repository
    argument
  refs: introduce new API, wrap old API shallowly around new API
  replace: migrate to for_each_replace_repo_ref

 builtin/replace.c    |   9 +-
 refs.c               | 187 ++++++++++++++--------
 refs.h               | 362 ++++++++++++++++++++++++++++++++++++++-----
 refs/iterator.c      |   6 +-
 refs/refs-internal.h |   5 +-
 replace-object.c     |   7 +-
 6 files changed, 464 insertions(+), 112 deletions(-)

-- 
2.18.0.345.g5c9ce644c3-goog

