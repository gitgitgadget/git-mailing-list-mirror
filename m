Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1708B1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbeHOUrf (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:47:35 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42370 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730284AbeHOUrd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Aug 2018 16:47:33 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FHqo9o019788;
        Wed, 15 Aug 2018 10:54:11 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ksvpj7b8d-1;
        Wed, 15 Aug 2018 10:54:11 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 67E11228A04F;
        Wed, 15 Aug 2018 10:54:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 5A4F62CDE73;
        Wed, 15 Aug 2018 10:54:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, ramsay@ramsayjones.plus.com,
        jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 0/6] Add missing includes and forward declares
Date:   Wed, 15 Aug 2018 10:54:04 -0700
Message-Id: <20180815175410.5726-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.553.g74975b7909
In-Reply-To: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes compilation errors when using a simple test.c file that
includes git-compat-util.h and then exactly one other header (and repeati=
ng
this for different headers of git).

Changes in this series come from Jonathan Nieder's reviews; full
range-diff follows below, but in summary:

  - Squashed the final patch from the previous series into the first (Jun=
io
    already applied a previous round and resolved the simple conflicts wi=
th
    next and pu, so making it easy to drop doesn't save effort anymore.)
  - Added a new patch to the series removing the forward declaration of
    an enum, for portability reasons.
  - Added Jonathan's Reviewed-by on the relevant patches
  - Remove a few includes and forward declares (which were initially adde=
d
    in previous rounds of this series) that are no longer necessary (due =
to
    other includes)
  - Fixed wording in commit message for patch 1 and added some comments
    about methodology used to come up with the patch.

Elijah Newren (6):
  Add missing includes and forward declarations
  alloc: make allocate_alloc_state and clear_alloc_state more consistent
  Move definition of enum branch_track from cache.h to branch.h
  urlmatch.h: fix include guard
  compat/precompose_utf8.h: use more common include guard style
  Remove forward declaration of an enum

 alloc.c                  |  2 +-
 alloc.h                  |  4 +++-
 apply.h                  |  3 +++
 archive.h                |  1 +
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
 fsmonitor.h              |  3 +++
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
 packfile.h               |  2 +-
 patch-ids.h              |  6 ++++++
 path.h                   |  1 +
 pathspec.h               |  2 ++
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
 62 files changed, 152 insertions(+), 18 deletions(-)

1:  f7d50cef3b ! 1:  e6a93208b2 Add missing includes and forward declares
    @@ -1,6 +1,13 @@
     Author: Elijah Newren <newren@gmail.com>
    =20
    -    Add missing includes and forward declares
    +    Add missing includes and forward declarations
    +
    +    I looped over the toplevel header files, creating a temporary tw=
o-line C
    +    program for each consisting of
    +      #include "git-compat-util.h"
    +      #include $HEADER
    +    This patch is the result of manually fixing errors in compiling =
those
    +    tiny programs.
    =20
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
    @@ -38,15 +45,13 @@
     --- a/archive.h
     +++ b/archive.h
     @@
    + #ifndef ARCHIVE_H
    + #define ARCHIVE_H
     =20
    ++#include "cache.h"
      #include "pathspec.h"
     =20
    -+struct object_id;
    -+enum object_type;
    -+
      struct archiver_args {
    - 	const char *base;
    - 	size_t baselen;
    =20
     diff --git a/attr.h b/attr.h
     --- a/attr.h
    @@ -60,6 +65,19 @@
      /*
       * Given a string, return the gitattribute object that
    =20
    +diff --git a/bisect.h b/bisect.h
    +--- a/bisect.h
    ++++ b/bisect.h
    +@@
    + #ifndef BISECT_H
    + #define BISECT_H
    +
    ++struct commit_list;
    ++
    + /*
    +  * Find bisection. If something is found, `reaches` will be the num=
ber of
    +  * commits that the best commit reaches. `all` will be the count of
    +
     diff --git a/branch.h b/branch.h
     --- a/branch.h
     +++ b/branch.h
    @@ -213,10 +231,6 @@
     =20
     +#include "cache.h"
     +#include "dir.h"
    -+
    -+struct cache_entry;
    -+struct index_state;
    -+struct strbuf;
     +
      extern struct trace_key trace_fsmonitor;
     =20
    @@ -428,6 +442,18 @@
      	char magic[4];
      	uint16_t version;
    =20
    +diff --git a/pack-objects.h b/pack-objects.h
    +--- a/pack-objects.h
    ++++ b/pack-objects.h
    +@@
    + #define PACK_OBJECTS_H
    +
    + #include "object-store.h"
    ++#include "pack.h"
    +
    + #define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
    +
    +
     diff --git a/patch-ids.h b/patch-ids.h
     --- a/patch-ids.h
     +++ b/patch-ids.h
    @@ -464,9 +490,6 @@
      #ifndef PATHSPEC_H
      #define PATHSPEC_H
     =20
    -+#include "string.h"
    -+#include "strings.h"
    -+
     +struct index_state;
     +
      /* Pathspec magic */
2:  e46bf7d601 ! 2:  f199566088 alloc: make allocate_alloc_state and clea=
r_alloc_state more consistent
    @@ -6,6 +6,7 @@
         refer to it as void *, or both use the real type (struct alloc_s=
tate *).
         Opt for the latter.
    =20
    +    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/alloc.c b/alloc.c
3:  aec8ddda59 ! 3:  169c90a96f Move definition of enum branch_track from=
 cache.h to branch.h
    @@ -7,6 +7,7 @@
         for this small enum, just move the enum and the external declara=
tion
         for git_branch_track to branch.h.
    =20
    +    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/branch.h b/branch.h
4:  14e33fb5ff ! 4:  5a36e50d4d urlmatch.h: fix include guard
    @@ -2,6 +2,7 @@
    =20
         urlmatch.h: fix include guard
    =20
    +    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/urlmatch.h b/urlmatch.h
5:  3e02a381af ! 5:  8f247b24a7 compat/precompose_utf8.h: use more common=
 include guard style
    @@ -2,6 +2,7 @@
    =20
         compat/precompose_utf8.h: use more common include guard style
    =20
    +    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
     diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
6:  aca61bade1 < -:  ---------- Add missing includes and forward declares
-:  ---------- > 6:  74975b7909 Remove forward declaration of an enum

--=20
2.18.0.553.g74975b7909
