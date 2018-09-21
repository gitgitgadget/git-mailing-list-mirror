Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCD61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391491AbeIVCWz (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:22:55 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54888 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391318AbeIVCWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:22:55 -0400
Received: by mail-pl1-f201.google.com with SMTP id h1-v6so1901269pld.21
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L4nhYMME9Uhrn0FH75AUvWb7gxz6+YcGgY1givV/ThQ=;
        b=GoYi/ULA9nQeft5z3k2MAQB1I6IxkBVyB4J9sqegCfbXFGSvedcdrpyRqTgndc1mYM
         2D9LIn1Y3ZBwj9045iv+94nsBOlOp5PQXztXyopzmGQV2iY0l1z2UJnKGMaXQMAofv0G
         k9pHzZklTv3PO/lSkBbYd+tPn8HkNA0heNpW/OUggYNHvUhOqyXfkXNNvbjiFMSVKEeo
         S6s2en1BzgS/lAOj+Q13sCVLaTsOWdcELH60btLAyrkYxZa6i3PkRNoefv5NFW5eF+t1
         MgkedGImtcXkJBArUDl8ysVN585fCxqtuzqwylxgqFJz6uAMBrmNQQQSwJaTeZjZY1Vg
         WqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L4nhYMME9Uhrn0FH75AUvWb7gxz6+YcGgY1givV/ThQ=;
        b=rhYulrI0ZodMrZuE/OQ4WzPegS7tEF3vV/GOiac6MM2peM+H/HKAuPFXQ3wU8afGKY
         ycvwSoGhedWKzTBVXqRm+G0MedSYETTmGOemYLRGq2sch8zL2cs5pp/OH4BM9AhfanCE
         xQQqbeSdUpNP+VzgspWgyGcnY/kCZXnA+qIFgP2dRuNdvk38HKfKg143CEyPt2OXqU+K
         85FuvJWnrQeHxefMG02HruWiWT9uT2exJN9kFoRTpk4fOGtB7emnFDEt2IUp+kVtkLhg
         RuJI+FB+4RQNqUKXoXDHaTgSpc8S/kfNBiXwwurzYcfHLA4buTmC0QLcidBJlPJv8Al7
         ABfQ==
X-Gm-Message-State: APzg51BEzNRNiAn4Ejoc5b4D1orUe3OR9HKphz2rE0pBJIWEUdpjPbuA
        +uS4nv1edwfnwx0EzFsnV0+oBpDQF9yF8W8YTTKkwfWfYP+5bkrPsp58BTRWe8FgEHmm8GLdDzR
        iI1MJuOueoJv6oulaNpJO6pYKsa1a0eea4DpTpOGVFVw4crJZKXErDmv4SVA=
X-Google-Smtp-Source: ANB0VdaEn7rf63wxdjEUtxVH976t7YRIFVtlwlSbsw9OH1iHYTfpKmVZX60A9pG8Fou2T7yAB4p4/fjCfdyM
X-Received: by 2002:a63:7b44:: with SMTP id k4-v6mr2098441pgn.77.1537561943241;
 Fri, 21 Sep 2018 13:32:23 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:31:56 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1537561420.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v9 0/8] filter: support for excluding all trees and blobs
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

Since v8, I cleaned up the test scripts in the following ways:
 - correct order of expect/actual arguments to test_cmp
 - correct pipe placement
 - put flags before positional arguments

Also, removed some junk in the commit message of the 5th patch.

Thank you,

Matthew DeVore (8):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  list-objects: always parse trees gently
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: use BUG rather than die
  list-objects-filter-options: do not over-strbuf_init
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   5 +
 builtin/rev-list.c                     |  11 +-
 list-objects-filter-options.c          |  19 +-
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  60 ++++++-
 list-objects.c                         | 232 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  26 ++-
 t/t0410-partial-clone.sh               |  45 +++++
 t/t5317-pack-objects-filter-objects.sh |  41 +++++
 t/t5616-partial-clone.sh               |  41 +++++
 t/t6112-rev-list-filters-objects.sh    |  42 +++++
 12 files changed, 396 insertions(+), 128 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

