Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CEE1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934419AbeFYOeu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:34:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36371 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934341AbeFYOes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:34:48 -0400
Received: by mail-qt0-f193.google.com with SMTP id o9-v6so12107261qtp.3
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hmWt6dHXr1n480ZiMWGDRKtGs6kYBW+uXxa+WTzISeA=;
        b=SSlyjBfQ7hYK66xIa44SIhc61eRDJuM16gR4bkTlCinz5n91seqT8RH7U4tRzP3Whj
         lem45z1bnDLIO5kt/Q6d+Pq/wksFjzfgh1HWDVRMleOPLF09uL3TDE2NkkukwfHTXRwr
         rz/xbA/dtwea0nRmBOoWdU0bh7PD2W/89L+fj5bzBHX8Y7xPkeLalk6c+LDsIr1deMXC
         S9lRFi/RvIu+VQc5CU64i4E0W3x8bNcSODFD9kMd7621IOC0/AML02qmhoC9u/4FA4Nm
         J+IWgj7YYzpi2EOZvoAKgfsYUjYluwQC01XzaF64HnoaMzqjFp5BCDZ9QykQBrsOAPkt
         N+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hmWt6dHXr1n480ZiMWGDRKtGs6kYBW+uXxa+WTzISeA=;
        b=m2eWFnHkPAXkqoxBUGcE8jAaA+DDaw6PihWTDuoBNFIGjO22G2xdBVThVZZJcQzDau
         etphs+/uHvwbLlBdRu3MQzr6z98Oy7O2p4gbuz9+/S3hKhcLRilu46gXc8oJZ+qayO1b
         4gZMr/5xkqqbkQqShrXDpVNNXE3MeJBNi6q2J7YeetvOaPkeUDVPafSQFj+tsUaF8Kka
         8ZeAH0l1d6SYz7KNft0Jghf89E+dGn1UYFi3xR0XROBcNuRFuPtaOotPT9l/pcVJRGoM
         hJv0fJVQWIELVDum8jVvVjp+aVodo8s/bcGZMQqdxOqa9+xe+I2ladt9qMtj/cUo8UO5
         L9lA==
X-Gm-Message-State: APt69E2FefoONYrco+NTbAguaB04NEQogIVItVBCRhmweNuCxRCv7BDe
        MfvmixOvAw92Eecs+V7Se5M/oIra
X-Google-Smtp-Source: AAOMgpcPANv28+j5u2bZSCfPOgpQKCb/v7ai55vEY0vLmkgqUP1LK7TI3aQeIiWPcsxeQmbCDia57A==
X-Received: by 2002:a0c:e043:: with SMTP id y3-v6mr11202618qvk.148.1529937287734;
        Mon, 25 Jun 2018 07:34:47 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:34:46 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 00/24] Multi-pack-index (MIDX)
Date:   Mon, 25 Jun 2018 10:34:10 -0400
Message-Id: <20180625143434.89044-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

This v2 patch has several significant changes from v1. Thanks for all
the feedback that informed these changes:

* The 'midx' builtin is renamed to 'multi-pack-index'

* The 'core.midx' config setting is renamed to 'core.multiPackIndex'

* Many die() or error() statements are marked for translation

* The packfile name lookup chunk is dropped in favor of dynamic
  calculation on read.

* The 'read' verb in the builtin is moved to a test tool.

And one item that I'm saving for investigation while v2 is under review:

* Consider using a merge sort when constructing/deduplicating the list
  of objects and offsets instead of sorting the objects in batches by
  first byte.

Thanks,
-Stolee

---

The multi-pack-index (MIDX) is explained fully in
the design document 'Documentation/technical/multi-pack-index.txt'.
The short description is that the MIDX stores the
information from all of the IDX files in a pack
directory. The crucial design decision is that the
IDX files still exist, so we can fall back to the IDX
files if there is any issue with the MIDX (or core.midx
is set to false, or a user downgrades Git, etc.)

The MIDX feature has been part of our GVFS releases
for a few months (since the RFC). It has behaved well,
indexing over 31 million commits and trees across up
to 250 packfiles. These MIDX files are nearly 1GB in
size and take ~20 seconds to rewrite when adding new
IDX information. This ~20s mark is something I'd like
to improve, and I mention how to make the file
incremental (similar to split-index) in the design
document. I also want to make the commit-graph file
incremental, so I'd like to do that at the same time
after both the MIDX and commit-graph are stable.


Lookup Speedups
---------------

When looking for an object, Git uses an most-recently-
used (MRU) cache of packfiles. This does pretty well to
minimize the number of misses when searching through
packfiles for an object, especially if there is one
"big" packfile that contains most of the objets (so it
will rarely miss and is usually one of the first two
packfiles in the list). The MIDX does provide a way
to remove these misses, improving lookup time. However,
this lookup time greatly depends on the arrangement of
the packfiles.

For instance, if you take the Linux repository and repack
using `git repack -adfF --max-pack-size=128m` then all
commits will be in one packfile, all trees will be in
a small set of packfiles and organized well so 'git
rev-list --objects HEAD^{tree}' only inspects one or two
packfiles.

GVFS has the notion of a "prefetch packfile". These are
packfiles that are precomputed by cache servers to
contain the commits and trees introduced to the remote
each day. GVFS downloads these packfiles and places them
in an alternate. Since these are organized by "first
time introduced" and the working directory is so large,
the MRU misses are significant when performing a checkout
and updating the .git/index file.

To test the performance in this situation, I created a
script that organizes the Linux repository in a similar
fashion. I split the commit history into 50 parts by
creating branches on every 10,000 commits of the first-
parent history. Then, `git rev-list --objects A ^B`
provides the list of objects reachable from A but not B,
so I could send that to `git pack-objects` to create
these "time-based" packfiles. With these 50 packfiles
(deleting the old one from my fresh clone, and deleting
all tags as they were no longer on-disk) I could then
test 'git rev-list --objects HEAD^{tree}' and see:

        Before: 0.17s
        After:  0.13s
        % Diff: -23.5%

By adding logic to count hits and misses to bsearch_pack,
I was able to see that the command above calls that
method 266,930 times with a hit rate of 33%. The MIDX
has the same number of calls with a 100% hit rate.



Abbreviation Speedups
---------------------

To fully disambiguate an abbreviation, we must iterate
through all packfiles to ensure no collision exists in
any packfile. This requires O(P log N) time. With the
MIDX, this is only O(log N) time. Our standard test [2]
is 'git log --oneline --parents --raw' because it writes
many abbreviations while also doing a lot of other work
(walking commits and trees to compute the raw diff).

For a copy of the Linux repository with 50 packfiles
split by time, we observed the following:

        Before: 100.5 s
        After:   58.2 s
        % Diff: -59.7%


Derrick Stolee (24):
  multi-pack-index: add design document
  multi-pack-index: add format details
  multi-pack-index: add builtin
  multi-pack-index: add 'write' verb
  midx: write header information to lockfile
  multi-pack-index: load into memory
  multi-pack-index: expand test data
  packfile: generalize pack directory list
  multi-pack-index: read packfile list
  multi-pack-index: write pack names in chunk
  midx: read pack names into array
  midx: sort and deduplicate objects from packfiles
  midx: write object ids in a chunk
  midx: write object id fanout chunk
  midx: write object offsets
  config: create core.multiPackIndex setting
  midx: prepare midxed_git struct
  midx: read objects from multi-pack-index
  midx: use midx in abbreviation calculations
  midx: use existing midx when writing new one
  midx: use midx in approximate_object_count
  midx: prevent duplicate packfile loads
  packfile: skip loading index if in multi-pack-index
  midx: clear midx on repack

 .gitignore                                   |   3 +-
 Documentation/config.txt                     |   4 +
 Documentation/git-multi-pack-index.txt       |  56 ++
 Documentation/technical/multi-pack-index.txt | 109 +++
 Documentation/technical/pack-format.txt      |  77 ++
 Makefile                                     |   3 +
 builtin.h                                    |   1 +
 builtin/multi-pack-index.c                   |  46 +
 builtin/repack.c                             |   8 +
 cache.h                                      |   1 +
 command-list.txt                             |   1 +
 config.c                                     |   5 +
 environment.c                                |   1 +
 git.c                                        |   1 +
 midx.c                                       | 900 +++++++++++++++++++
 midx.h                                       |  20 +
 object-store.h                               |  33 +
 packfile.c                                   | 173 +++-
 packfile.h                                   |   9 +
 sha1-name.c                                  |  70 ++
 t/helper/test-read-midx.c                    |  54 ++
 t/helper/test-tool.c                         |   1 +
 t/helper/test-tool.h                         |   1 +
 t/t5319-multi-pack-index.sh                  | 191 ++++
 24 files changed, 1724 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/git-multi-pack-index.txt
 create mode 100644 Documentation/technical/multi-pack-index.txt
 create mode 100644 builtin/multi-pack-index.c
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100644 t/helper/test-read-midx.c
 create mode 100755 t/t5319-multi-pack-index.sh


base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
-- 
2.18.0.rc1

