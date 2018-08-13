Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31011F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeHMUDa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:03:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:46880 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730403AbeHMUDa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Aug 2018 16:03:30 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DHI4Qp013222;
        Mon, 13 Aug 2018 10:20:15 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ksvpj3buu-1;
        Mon, 13 Aug 2018 10:20:15 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 82569225F2D2;
        Mon, 13 Aug 2018 10:20:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6EED62CDE47;
        Mon, 13 Aug 2018 10:20:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, ramsay@ramsayjones.plus.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 0/6] Add missing includes and forward declares
Date:   Mon, 13 Aug 2018 10:17:43 -0700
Message-Id: <20180813171749.10481-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd4454f3f9b
In-Reply-To: <20180811205024.11291-1-newren@gmail.com>
References: <20180811205024.11291-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130177
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes compilation errors when using a simple test.c file that
includes git-compat-util.h and then exactly one other header (and repeati=
ng
this for different headers of git).

Changes since v2 (full range-diff below):
  - Ensure the first #include in C files is either git-compat-util.h,
    cache.h, or builtin.h (pointed out by Ramsay).  Also, although not
    important, also tweaked a couple other #include orders to put cache.h
    first in some .h files.

Elijah Newren (6):
  Add missing includes and forward declares
  alloc: make allocate_alloc_state and clear_alloc_state more consistent
  Move definition of enum branch_track from cache.h to branch.h
  urlmatch.h: fix include guard
  compat/precompose_utf8.h: use more common include guard style
  Add missing includes and forward declares

 alloc.c                  |  2 +-
 alloc.h                  |  4 +++-
 apply.h                  |  3 +++
 archive.h                |  3 +++
 attr.h                   |  1 +
 bisect.h                 |  2 ++
 branch.h                 | 13 +++++++++++++
 bulk-checkin.h           |  2 ++
 cache.h                  | 10 ----------
 column.h                 |  1 +
 commit-graph.h           |  1 +
 compat/precompose_utf8.h |  3 ++-
 config.c                 |  1 +
 config.h                 |  5 +++++
 connected.h              |  1 +
 convert.h                |  2 ++
 csum-file.h              |  2 ++
 diffcore.h               |  4 ++++
 dir-iterator.h           |  2 ++
 environment.c            |  1 +
 fsck.h                   |  1 +
 fsmonitor.h              |  7 +++++++
 gpg-interface.h          |  2 ++
 khash.h                  |  3 +++
 list-objects-filter.h    |  4 ++++
 list-objects.h           |  4 ++++
 ll-merge.h               |  2 ++
 mailinfo.h               |  2 ++
 mailmap.h                |  2 ++
 merge-recursive.h        |  4 +++-
 notes-merge.h            |  4 ++++
 notes-utils.h            |  3 +++
 notes.h                  |  3 +++
 object-store.h           |  1 +
 object.h                 |  2 ++
 oidmap.h                 |  1 +
 pack-bitmap.h            |  3 +++
 pack-objects.h           |  1 +
 patch-ids.h              |  6 ++++++
 path.h                   |  1 +
 pathspec.h               |  5 +++++
 pretty.h                 |  4 ++++
 reachable.h              |  2 ++
 reflog-walk.h            |  1 +
 refs.h                   |  2 ++
 remote.h                 |  1 +
 repository.h             |  2 ++
 resolve-undo.h           |  2 ++
 revision.h               |  1 +
 send-pack.h              |  4 ++++
 sequencer.h              |  5 +++++
 shortlog.h               |  2 ++
 submodule.h              | 10 ++++++++--
 tempfile.h               |  1 +
 trailer.h                |  2 ++
 tree-walk.h              |  2 ++
 unpack-trees.h           |  5 ++++-
 url.h                    |  2 ++
 urlmatch.h               |  2 ++
 utf8.h                   |  2 ++
 worktree.h               |  1 +
 61 files changed, 160 insertions(+), 17 deletions(-)

1:  2bd09172ef ! 1:  f7d50cef3b Add missing includes and forward declares
    @@ -242,8 +242,8 @@
      #ifndef __AC_KHASH_H
      #define __AC_KHASH_H
     =20
    -+#include "hashmap.h"
     +#include "cache.h"
    ++#include "hashmap.h"
     +
      #define AC_VERSION_KHASH_H "0.2.8"
     =20
    @@ -693,8 +693,8 @@
      #define UNPACK_TREES_H
     =20
     -#include "tree-walk.h"
    - #include "argv-array.h"
     +#include "cache.h"
    + #include "argv-array.h"
     +#include "string-list.h"
     +#include "tree-walk.h"
     =20
2:  854860e967 =3D 2:  e46bf7d601 alloc: make allocate_alloc_state and cl=
ear_alloc_state more consistent
3:  c91c4eaa38 ! 3:  aec8ddda59 Move definition of enum branch_track from=
 cache.h to branch.h
    @@ -63,22 +63,22 @@
     --- a/config.c
     +++ b/config.c
     @@
    -  * Copyright (C) Johannes Schindelin, 2005
       *
       */
    -+#include "branch.h"
      #include "cache.h"
    ++#include "branch.h"
      #include "config.h"
      #include "repository.h"
    + #include "lockfile.h"
    =20
     diff --git a/environment.c b/environment.c
     --- a/environment.c
     +++ b/environment.c
     @@
    -  * even if you might want to know where the git directory etc
       * are.
       */
    -+#include "branch.h"
      #include "cache.h"
    ++#include "branch.h"
      #include "repository.h"
      #include "config.h"
    + #include "refs.h"
4:  550568912b =3D 4:  14e33fb5ff urlmatch.h: fix include guard
5:  1186b37a3c =3D 5:  3e02a381af compat/precompose_utf8.h: use more comm=
on include guard style
6:  0642f8ecf0 =3D 6:  aca61bade1 Add missing includes and forward declar=
es

--=20
2.18.0.549.gd4454f3f9b
