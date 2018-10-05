Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51511F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeJFEcL (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:32:11 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:52976 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEcK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:32:10 -0400
Received: by mail-oi1-f202.google.com with SMTP id w198-v6so10030110oiw.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oCUVReVcRJvdUsdFrZCcC1WDmXck9VUnVBLTo3wJhh4=;
        b=EdkQYLAI1h4QGkgrujUXcaK5804Zc9k1HoAV8M0ssQxlGXB0pJ+Uasme9kla5FeBQQ
         RanI7yfuEhuuuafmJYaRTCE/FXH+3nTdPKEFIEmhiWlF1GijcMvxWqH1lMlOvlOykthX
         GtoC6WffoTXPIxPctH7wZYgustl8tMMgduwzVmwh0v/TvxzX9NQKJktXWEZgjoca+JZ+
         y9mqK0GeZJaZ8JThcB6ApGWwp+/JDLJhM0mqkgPz0XdjlX3q90+4hy+3hhua9ndpH30G
         yDBY8VEvfPk9FWwY36Ex+DLwobsD8No8Yp4DTJsJrptDcOUqYsS8SAuG8hCwtNj7bCpv
         nS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oCUVReVcRJvdUsdFrZCcC1WDmXck9VUnVBLTo3wJhh4=;
        b=YgoPSTzS55Ra+kgFaH5eVi5REmQJDCtKJIcSzAo7yWK/U/gJjaez3aPjORUnESE1tC
         YyJVDplERW0ifvLljJFbbRmsxbEIvjiZRD30/kR17YuoycWok4JXAlyhYmLtE1lvazpj
         KaRsbFUTzJF+iEPsH7UdYKVmFATHhWrvpKQsdcuQQthJNkqMSeBfbv7FobGE8+DxRjTz
         ok2T2qpJlohHxRdOhOAccvul75u2pMeKS2PtwOdhzpOfqcTZTlJphw3wnalNp814BJno
         pDZrrEmD4ypV4X2jbdO7uPxhz+mzoRh+HrwQHrHc3KgF2sQovlQQjndqGj0LaxNato1S
         e0fQ==
X-Gm-Message-State: ABuFfogOMTvfUuKP8xVMBVqZug8yeT2GwnX2MbOjWSqUI8xwNledGSgt
        xzvUj7Je1tpPJ4St5ftdxcT68vWFaTGTruDqN32cwYBWpENpdP3WVz0p2CclDderGtyjXAkx4XW
        Spe6pNr6TZdWkiT0oWmdyeyhWa8aPLJ5VdEarQSeRuC4bOCKcH3o8GxWccfI=
X-Google-Smtp-Source: ACcGV60q44C9AHm623bow89lH3S1Ho19k+vZyJHO7Mtt8J57AFWWhra37VzwSFAyIjxN2ppTHFNRKwOUHqnI
X-Received: by 2002:a9d:339b:: with SMTP id u27mr7945337otc.13.1538775096512;
 Fri, 05 Oct 2018 14:31:36 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:31:19 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1538774738.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v11 0/8] filter: support for excluding all trees and blobs
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

Here is a clean re-rollup fixing the issue I found earlier. It fixes a problem
stemming from a discarded exit code, which masked a crash in Git. The crash was
not a bug because an earlier test deleted a loose object file. The fix was to
make that test manipulate a clone rather than the original repo.

An interdiff from v10 is below.

Thank you,
Matt

diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 5a61614b1..c8e3d87c4 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -210,16 +210,21 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 test_expect_success 'rev-list W/ --missing=print and --missing=allow-any for trees' '
         TREE=$(git -C r3 rev-parse HEAD:dir1) &&
 
-        rm r3/.git/objects/$(echo $TREE | sed "s|^..|&/|") &&
+        # Create a spare repo because we will be deleting objects from this one.
+        git clone r3 r3.b &&
 
-        git -C r3 rev-list --quiet --missing=print --objects HEAD >missing_objs 2>rev_list_err &&
+        rm r3.b/.git/objects/$(echo $TREE | sed "s|^..|&/|") &&
+
+        git -C r3.b rev-list --quiet --missing=print --objects HEAD \
+                >missing_objs 2>rev_list_err &&
         echo "?$TREE" >expected &&
         test_cmp expected missing_objs &&
 
         # do not complain when a missing tree cannot be parsed
         test_must_be_empty rev_list_err &&
 
-        git -C r3 rev-list --missing=allow-any --objects HEAD >objs 2>rev_list_err &&
+        git -C r3.b rev-list --missing=allow-any --objects HEAD \
+                >objs 2>rev_list_err &&
         ! grep $TREE objs &&
         test_must_be_empty rev_list_err
 '
@@ -228,12 +233,13 @@ test_expect_success 'rev-list W/ --missing=print and --missing=allow-any for tre
 
 test_expect_success 'verify tree:0 includes trees in "filtered" output' '
         git -C r3 rev-list --quiet --objects --filter-print-omitted \
-                --filter=tree:0 HEAD |
-        awk -f print_1.awk |
+                --filter=tree:0 HEAD >revs &&
+
+        awk -f print_1.awk revs |
         sed s/~// |
-        xargs -n1 git -C r3 cat-file -t |
-        sort -u >filtered_types &&
+        xargs -n1 git -C r3 cat-file -t >unsorted_filtered_types &&
 
+        sort -u unsorted_filtered_types >filtered_types &&
         printf "blob\ntree\n" >expected &&
         test_cmp expected filtered_types
 '

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
 t/t5616-partial-clone.sh               |  42 +++++
 t/t6112-rev-list-filters-objects.sh    |  49 ++++++
 12 files changed, 404 insertions(+), 128 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

