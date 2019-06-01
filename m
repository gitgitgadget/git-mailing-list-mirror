Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722D91F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfFAAgO (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:36:14 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38944 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFAAgO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 20:36:14 -0400
Received: by mail-pf1-f202.google.com with SMTP id f9so8672198pfn.6
        for <git@vger.kernel.org>; Fri, 31 May 2019 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8CTj0xSur0YqR5KIAqQBkiTR4InnVN9IePuIBtcw7u4=;
        b=FdXv5PO7OFb0q5H9P2X9JitaJON9kYkQu4MvD8PSpWB2wezUePgYjrhJGySr4U0+mF
         mzOUTnc/EbdpseZIhMthtNVhv+whrI6kl2B/7wsuOKklwXLjv4sJZutiFnTlMXMa9Pt9
         2X3Ox/Lb3xUwXRTZq2T5/JfAZZuIMgD6oyJ+2SaXFnysir/oxgnol7c+9stCrhwxBvwA
         KWiDIbyRZp2HtS+x5v7CYKdWGh87PDNfe4aElZ1vbrNSXDc6dQ1+MBjuawq2nLMYmruk
         LxkHv2XEjRP0waqaU55EbvkfyltUKCfqGf6xp9+qjD3LGUjOiTrLGuxo4axFv7qQVBxf
         wK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8CTj0xSur0YqR5KIAqQBkiTR4InnVN9IePuIBtcw7u4=;
        b=c6thQydCW1chdLlTNqib2svPNDNYj8vtPtuUtn8opUJX+dg6ZQeOuqqDOzJY65Mt/P
         GISeWEmVF1wNqLm/DE4/r97P+v5hvrn6l5Lmzrk7wWTn5joumX1I54inu3S3bHRGGhjJ
         D1zRN6ciVb2eJL593SVIGraaPR++c3r+CFmlLSyr+urv5fYPCkiVZDtZ/Kcv0zEPaZeO
         FpGzIaPFdl7t8wUHGoc0J1hjSCfIb8JjT04SUeS6VbUYh8ZjHGPO6f0DOixFJAGDOPS5
         WLiUL7sHOHn+aRtM0TvBjvvt8LJdVbMMkd1CzteU1C1khdpk+RLH9S5/tbvinVnm9Zrk
         sshg==
X-Gm-Message-State: APjAAAUqk6Q+uQBN9vMfKS6zgRHPtKqXdT6p2EIZ8HK228yKbHXzonp+
        fieyfWRrNvIBa21E9VzdH8/7OrvHlZZcyo0tvxhoGaLTudI1iWpUNxnaZWPrGTk9DMrw8Jui5L5
        s0DnreQLsSNzRdY47A29tJ3mEJk6iWKSBMGAEHiOa7rtun4GyeCLJ4h/yLtA=
X-Google-Smtp-Source: APXvYqw/xnbBoJiD9SA6COcOHAIb8Jcu4l5aZRJQbJ/bShntrY7Xt5C5EF0CpskfFmY+kksBM+U/+lZ6M6fQ
X-Received: by 2002:a63:1b1e:: with SMTP id b30mr12355406pgb.180.1559349373311;
 Fri, 31 May 2019 17:36:13 -0700 (PDT)
Date:   Fri, 31 May 2019 17:35:54 -0700
Message-Id: <20190601003603.90794-1-matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 0/9] Filter combination
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a roll-up with hopefully all comments applied or responded to. Notable
changes since the last one include:

 - Added an ALLOC_GROW_BY which is used twice by this patchset to make growing
   arrays safer and cleaner
 - Cleaned up the URL-encoding by (1) using hex_to_bytes rather than rolling my
   own helpers and (2) making error-string-generation non-conditional
 - Switched to an array-based data structure rather than a linked list for both
   LOFC_COMBINE filter spec objects and the filter object itself
 - Changed the list_objects_filter API to be cleaner to use
 - Changed test cases to use sparse:oid= rather than sparse:path= since the
   latter is being disabled.

Thank you,

Matthew DeVore (9):
  list-objects-filter: make API easier to use
  list-objects-filter: put omits set in filter struct
  list-objects-filter-options: always supply *errbuf
  list-objects-filter: implement composite filters
  list-objects-filter-options: move error check up
  list-objects-filter-options: make filter_spec a strbuf
  list-objects-filter-options: allow mult. --filter
  list-objects-filter-options: clean up use of ALLOC_GROW
  list-objects-filter-options: make parser void

 Documentation/rev-list-options.txt  |  16 ++
 builtin/rev-list.c                  |   2 +-
 cache.h                             |  22 ++
 list-objects-filter-options.c       | 264 ++++++++++++++++++---
 list-objects-filter-options.h       |  32 ++-
 list-objects-filter.c               | 345 +++++++++++++++++++++-------
 list-objects-filter.h               |  35 ++-
 list-objects.c                      |  55 ++---
 t/t5616-partial-clone.sh            |  19 ++
 t/t6112-rev-list-filters-objects.sh | 197 +++++++++++++++-
 transport.c                         |   1 +
 upload-pack.c                       |   4 +-
 12 files changed, 816 insertions(+), 176 deletions(-)

-- 
2.17.1

