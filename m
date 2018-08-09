Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911571F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHJBM3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 21:12:29 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:41890 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHJBM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 21:12:29 -0400
Received: by mail-qt0-f202.google.com with SMTP id l13-v6so5808160qth.8
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tryl0tbH/G7Cdo77Icy3xTUlaZHFMFZqHBgkL3kf4q0=;
        b=XVecE8nWAPgVKZDfIONhxLY87jt+9XkEoUYwAEFcftnAFfiwbYDL2RSM5+dixxSnTQ
         L14g7MBTvqZ9Ghjzf3J8gJdgLrh3ASzDAOtZR6UN+KyC3lrhlcqr1zkF7mMnRRFGjmFe
         HAJlYvZAipHBJOONMiFb6GgfGzbVAxf7lw3PdHQpFSaEukACsEpIcPW1DQt+TDxRMUzE
         nenDoUdiLd9V4sIFVSW7rag62ggl/j3p4KqsSG3vFxIxtYwtqLBdZzmx+7qWL88lFLiI
         vDVGJQUHTYCwhcptw+YF1lUBE90lgjBOs09XnU1ij0QpkhNXRO9WZs56nWXSJ7sWh6k2
         OxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tryl0tbH/G7Cdo77Icy3xTUlaZHFMFZqHBgkL3kf4q0=;
        b=Ml9NW4L+32Ca31MjwOvuuuRVVg5e1j0rDbe59fbjq7C1MTncGJKElD8WWNB28JKT2K
         oc3Qn/Crgu5g0doSdMp2biq21PAMyrC+ezzhR9samAiZmQPB6jkTV3/LoSPNlD9dkmo6
         p/5AX8KgrPBaOzWyYLceZnXPc/6UPdgEYgvHcqHcZ7oBSX26E6GpvyRwfAlTYYPyUiek
         UpMEJ1hyI3eVP58HtPk663Fl7bdUe380Oq5M001ziR8ms/fLIWjTWjMQLX6pUFuxF1b0
         iI0DvegqIV/kFsMLmCzs2wk9Tm63e657c/Tnx0t7FUCKgReppuuIuMH4Cuaexkx8tugp
         lToQ==
X-Gm-Message-State: AOUpUlHb5GJQYD7hLc5Esw73xD00xanfGQzD+ANWUNN+px0kkN7oDxKJ
        5Td7rInTvJjMXo1y7NE2pTnk2H1KqXAXr4spmDb6CBgbm5Ag/DsKXtFSuOAKHfzIzwqyEnB4fVl
        kWc7SwAr2KVFR0gKmcszxjTWOijfVUo1rJSayK1HXgZqQFioYfw8LAC5Oq2E=
X-Google-Smtp-Source: AA+uWPzimnXFJZhDshFDyp/3pw3xkGTnJNCdFuMMgqR+6Ygj92ZQbnbflIqX8Y38vX1JfvmFMcWFdNCF2eXC
X-Received: by 2002:a37:ddd3:: with SMTP id u80-v6mr2170372qku.16.1533854729802;
 Thu, 09 Aug 2018 15:45:29 -0700 (PDT)
Date:   Thu,  9 Aug 2018 15:44:59 -0700
Message-Id: <cover.1533854545.git.matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [RFC PATCH 0/5] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series does two things:

  a. (patches 1-2) introduces "--filter=only:commits" which filters trees and blobs
  b. (patches 3-5) better support for promisor trees in the rev-list command

The intention is to enable initial partial clones to be very tiny by only
including commits. Patches 3-5 are necessary because, even though it has already
been possible to have partial clones with trees missing (there are tests for it),
there have not been any filters which support this yet, so it seemed necessary
to make rev-list handle this case better.

Thank you,

Matthew DeVore (5):
  revision: invert meaning of the USER_GIVEN flag
  list-objects-filter: implement filter only:commits
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  rev-list: handle missing tree objects properly

 Documentation/rev-list-options.txt     |   2 +
 builtin/rev-list.c                     |  12 +-
 list-objects-filter-options.c          |   4 +
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  43 +++--
 list-objects.c                         | 226 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  11 +-
 t/t5317-pack-objects-filter-objects.sh |  30 ++++
 t/t5616-partial-clone.sh               |  27 +++
 t/t6112-rev-list-filters-objects.sh    |  13 ++
 11 files changed, 242 insertions(+), 128 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

