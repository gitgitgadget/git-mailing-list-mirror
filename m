Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EFF51F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeJLGij (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:38:39 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44762 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJLGij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:38:39 -0400
Received: by mail-pf1-f202.google.com with SMTP id r81-v6so9903562pfk.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cRre8YzOzdtOLOrivCo+JZaFNLkyb7tIbXj6G97zVjk=;
        b=HT6D9/GkayV+a83rISrNSZ5b+2zbhMRrb/2lb7bF3pej07jrKmD4zZooEQS5POwkc+
         ckyn0shKRYBNCGjNeaPJ9xDdY6OBCJFJR62WT919W+MN8GLx5xQCXJsFrR1VMN1E5Am9
         6LIZgeJct1UXFzjXmBfJqvf5CzGM5F2nb1hkJA/dZbmbuKiRYsIx/NeHPmArtG9N+ris
         so8fhWOQPxrJZ+OZHHcphhlN5vORTo4qI2tpaVP9jGowcNi9Tqemh3DfhWdxRz4wQS0N
         G+i0NGyIRNy29H/R8i4oXsYb5ZuE/tc+N/UlwHyAW3FlrK5EifjlB2WpHJLrmNswNf93
         rb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cRre8YzOzdtOLOrivCo+JZaFNLkyb7tIbXj6G97zVjk=;
        b=dTpw/KrBLueeezcVYGcRnylw8pJvR+fJeiXT/VGMnNeZ8VLcvViOf9hitryRZ4ltaf
         GM6i9UeG70VpZZRBO5kiB4v21ocZZZ5Uoi+pfLjZQTEXnsjGS6TlEK95q7mCZUkcQF6E
         cAQNCVIpetR3+4go97H/76/IppvmRceSo23+yHfCLUTjTE1xfZD2TvHoy8VQeRM0hlbK
         BIojEgbpC5mCJe859/IXPmOjpCDrJpLUAVD/XSGEkE1gEL+K1cA9I0OurkiSAkuGzXRF
         8Dql1Yjko2ejDUM1yuLlMRSacstlDke36uIDBcKV/yO1rW5TeSjYnmAIh7npSmUOAE1g
         3Zlg==
X-Gm-Message-State: ABuFfojLBXungwSGiSHQSC5p7ghJLXtpJA3knW5K4qkVrJ8tbP9SlYP9
        1WyXuCvrUt2Fe2KyPWkITxI7x3Jo0+RONJwkfvSYnvzXzaqFa0paemDErUCZXVe3bmETZz4qQYS
        n/DGt7ex3zRjqQwa4OS11oHDqqlBsCg0giKaW5afGA9fGJQtBpZlmoLBVkoQ=
X-Google-Smtp-Source: ACcGV60bVi3udfXkqR7dAGmUXg3OQrsVGZiaM/jjq3cIrwBl3J5lWqNgWlU1TMICM8YKJ+CweVpOxmr7KzAT
X-Received: by 2002:a63:1413:: with SMTP id u19-v6mr1851211pgl.80.1539299351104;
 Thu, 11 Oct 2018 16:09:11 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:08:59 -0700
Message-Id: <cover.1539298957.git.matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC PATCH 0/3] support for filtering trees and blobs based on depth
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds support for depth >0 in the tree:<depth> filter. Before this patch,
only <depth>=0 is supported, which means all trees and blobs are filtered.

The purpose of this is to allow fetching of entire directories in a partial
clone use case. If I do a partial clone of a repo with no objects and then want
to do something like "make" it will be quite slow of we initiate a separate
fetch for every file needed. Alternatively, fetching directories at a time -
as soon as any file in a directory is accessed - is a reasonable approach.

Thank you,

Matthew DeVore (3):
  list-objects: support for skipping tree traversal
  Documentation/git-rev-list: s/<commit>/<object>/
  list-objects-filter: teach tree:# how to handle >0

 Documentation/git-rev-list.txt      | 21 ++++---
 Documentation/rev-list-options.txt  | 24 +++++---
 builtin/rev-list.c                  |  2 +-
 list-objects-filter-options.c       |  6 +-
 list-objects-filter-options.h       |  1 +
 list-objects-filter.c               | 52 +++++++++++++---
 list-objects-filter.h               |  6 ++
 list-objects.c                      |  5 +-
 t/t6112-rev-list-filters-objects.sh | 94 +++++++++++++++++++++++++++++
 9 files changed, 178 insertions(+), 33 deletions(-)

-- 
2.19.1.331.ge82ca0e54c-goog

