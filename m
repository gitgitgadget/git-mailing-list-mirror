Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 268F71F428
	for <e@80x24.org>; Sat, 11 Aug 2018 20:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeHKXZy (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 19:25:54 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36352 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727638AbeHKXZy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Aug 2018 19:25:54 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7BKmsrb008586;
        Sat, 11 Aug 2018 13:50:27 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kswngrew2-1;
        Sat, 11 Aug 2018 13:50:27 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 46A0D2230FD5;
        Sat, 11 Aug 2018 13:50:27 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 3C4172CDE5F;
        Sat, 11 Aug 2018 13:50:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 0/6] Add missing includes and forward declares
Date:   Sat, 11 Aug 2018 13:50:18 -0700
Message-Id: <20180811205024.11291-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd4454f3f9b
In-Reply-To: <20180811043218.31456-1-newren@gmail.com>
References: <20180811043218.31456-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808110232
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes compilation errors when using a simple test.c file that
includes git-compat-util.h and then exactly one other header (and repeati=
ng
this for different headers of git).

Changes since v1:
  - Followed Peff's suggestion to make my simple test .c file first
    #include git-compat-util.h; removes the need for inclusions of this
    header or stdlib.h or stdio.h throughout my series.  (Patches 6-8 of
    v1 no longer necessary at all.)
  - Removed the explanatory comments about why various #include's were
    needed from v1.

Note: the final patch has minor conflicts with topics in flight in
next and pu; it can just be dropped and I can resubmit it later if
that is easier.

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

--=20
2.18.0.549.gd4454f3f9b

