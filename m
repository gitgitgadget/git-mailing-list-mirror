Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002E01F404
	for <e@80x24.org>; Sat, 11 Aug 2018 04:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHKHFJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 03:05:09 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37922 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbeHKHFJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Aug 2018 03:05:09 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7B4NhlV005723;
        Fri, 10 Aug 2018 21:32:20 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr1kwmmur-1;
        Fri, 10 Aug 2018 21:32:20 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 78EDE2230ED5;
        Fri, 10 Aug 2018 21:32:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 703112CDE5F;
        Fri, 10 Aug 2018 21:32:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/9] Add missing includes and forward declares
Date:   Fri, 10 Aug 2018 21:32:09 -0700
Message-Id: <20180811043218.31456-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd4454f3f9b
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808110048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was bit yet again by compilation errors when adding a #include of
some header file to some new place, and decided to determine which
header files were missing their own necessary #include's and forward
declarations.  This patch series is the result.  A few notes:

  * Patch 1: This patch is the bulk of the work; I included everything
    here except for special cases that need extra attention and the
    unrelated change in patch 2.

  * Patch 2: This patch is more of a while-at-it independent header
    fixup; it only changes two lines so I lumped it into the series.

  * Patch 3: I could have just added a #include of cache.h in branch.h
    instead, but opted to move things around slightly.  I'm unsure
    which is better.

  * Patches 4-5: Fix include guard issues

  * Patches 6-8: These patches might need to be submitted to separate
    projects elsewhere.  Let me know if so.

  * Patch 9: This patch includes the changes that conflict with other
    topics in next and pu.  I included these changes for completeness,
    but kept it separate because I wanted to make it easy to drop the
    stuff that conflicted with other things in flight (since I can
    just resubmit it later).

Elijah Newren (9):
  Add missing includes and forward declares
  alloc: make allocate_alloc_state and clear_alloc_state more consistent
  Move definition of enum branch_track from cache.h to branch.h
  urlmatch.h: fix include guard
  compat/precompose_utf8.h: use more common include guard style
  ewah/ewok.h: add missing include
  sha1dc/sha1.h: add missing include
  xdiff/xdiff.h: add missing include
  Add missing includes and forward declares

 alloc.c                  |  2 +-
 alloc.h                  |  4 +++-
 apply.h                  |  3 +++
 archive.h                |  4 ++++
 argv-array.h             |  2 ++
 attr.h                   |  1 +
 bisect.h                 |  2 ++
 branch.h                 | 13 +++++++++++++
 bulk-checkin.h           |  2 ++
 cache.h                  | 10 ----------
 color.h                  |  2 ++
 column.h                 |  1 +
 commit-graph.h           |  1 +
 compat/precompose_utf8.h |  3 ++-
 config.c                 |  1 +
 config.h                 |  6 ++++++
 connected.h              |  1 +
 convert.h                |  3 +++
 credential.h             |  1 +
 csum-file.h              |  2 ++
 delta.h                  |  2 ++
 diffcore.h               |  4 ++++
 dir-iterator.h           |  2 ++
 environment.c            |  1 +
 ewah/ewok.h              |  2 ++
 exec-cmd.h               |  2 ++
 fsck.h                   |  1 +
 fsmonitor.h              |  7 +++++++
 gpg-interface.h          |  4 ++++
 grep.h                   |  1 +
 hashmap.h                |  2 ++
 khash.h                  |  4 ++++
 kwset.h                  |  2 ++
 list-objects-filter.h    |  4 ++++
 list-objects.h           |  4 ++++
 ll-merge.h               |  2 ++
 mailinfo.h               |  2 ++
 mailmap.h                |  4 ++++
 mem-pool.h               |  2 ++
 merge-recursive.h        |  4 +++-
 notes-cache.h            |  1 +
 notes-merge.h            |  4 ++++
 notes-utils.h            |  4 ++++
 notes.h                  |  3 +++
 object-store.h           |  1 +
 object.h                 |  2 ++
 oidmap.h                 |  1 +
 pack-bitmap.h            |  3 +++
 pack-objects.h           |  1 +
 pack-revindex.h          |  2 ++
 parse-options.h          |  2 ++
 patch-ids.h              |  6 ++++++
 path.h                   |  3 +++
 pathspec.h               |  5 +++++
 pretty.h                 |  4 ++++
 progress.h               |  2 ++
 quote.h                  |  2 ++
 reachable.h              |  4 ++++
 reflog-walk.h            |  1 +
 refs.h                   |  4 ++++
 remote.h                 |  1 +
 repository.h             |  2 ++
 resolve-undo.h           |  2 ++
 revision.h               |  1 +
 send-pack.h              |  4 ++++
 sequencer.h              |  5 +++++
 sha1-lookup.h            |  2 ++
 sha1dc/sha1.h            |  1 +
 shortlog.h               |  3 +++
 sideband.h               |  2 ++
 strbuf.h                 |  2 ++
 submodule.h              | 10 ++++++++--
 tempfile.h               |  1 +
 trailer.h                |  3 +++
 tree-walk.h              |  2 ++
 unpack-trees.h           |  5 ++++-
 url.h                    |  2 ++
 urlmatch.h               |  3 +++
 utf8.h                   |  4 ++++
 varint.h                 |  2 ++
 worktree.h               |  1 +
 xdiff/xdiff.h            |  2 ++
 82 files changed, 218 insertions(+), 17 deletions(-)

--=20
2.18.0.549.gd4454f3f9b

