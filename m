Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6818D1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759222AbeD0Vjd (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:39:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:51219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757815AbeD0Vjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:39:31 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LtEtL-1eDuty15it-012pc2; Fri, 27 Apr 2018 23:39:25 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 00/11] Deprecate .git/info/grafts
Date:   Fri, 27 Apr 2018 23:39:18 +0200
Message-Id: <cover.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:NiUaotsQRj5V/Wumy/l5FK5MVz6tK/qdgMVvdn7x7x/bh5gk9G0
 lkS58pKd+jw8ZktFos+4MELmhufXn064xt/nTBQUpquUsEobayBc1gn1twPU7Ft2na4t0N2
 R5W/iFyJnjgsT1LPjEP+rdG/+5Gm4bhlDTArxz4ovRLL855tZNskHbdGOcQLk5HY2S6YqI5
 hyCl6Lsiy0UBV6fU2Bemg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s2Xng5BGpNA=:bZrvl/V36hWwZ+FxwFLyX0
 kQQ7vtoZboaPjtaNwGNrN+61uqcftSrzqw9lR6drCYe5qE/5hgHsSS+EbVNBNNiuX7G6CYtH4
 dWlNPz78zPGoL1qvI5QgrKpGa+aCyaKY1BUM8LXb5BzFng/QWkHF4DS+NmT6fD1UuAJmq0uLO
 VW8zjWWZ0yyMpJB+kziYHJWfZwGynwi330TFSOZLOiq1PlmQdYlxpoyrwYiHP/vn1xZ9rt4Pm
 18Enr+Wsd9l9qxEDS/E8VjN01S9DC5Z3FDj8DZlPrs8p5EWs7Xq0IKlL3Q4yKYGD45ae3mECW
 OsNfyjaKypAQ1q1fyuSEOzB1M4XZpYyB08cx9q5B6gq6HphCZqXs1e1P5iCmVrnMkHir9lwwC
 YWpH5tRSnd3SUaXl7RCxhFxz7+L0tkASJ5c1KeaqGRaAF/Oyzf4+dkRKnbLwb17pxGaNg7uJR
 i3pjoiAWkAfYX3+LR+x1GefhMr1bej7kImHrEVz/e+JGDKucQwF/YnTLWvEW0kNCmdTyPUL/p
 hzvC7A6w+zJaVMbwgiNFKNe1kN7XAct1sn/y12tDiHG/+iRF/Ok8rzjBs4ZJZ07hfd/0R2nAE
 Orp6uivnWfKhbUrJWbC9lzXgneIrwFfmM2ntpv69HKA3Xv0tdb6K+OsdJCMhZDX2QTsoreUi6
 A8+XE70iCOmem0LUJbCWVJSgidNCN882Wp31VLca08QzxOy0QnK1h4w4lJ1K0Obszhwzu7muX
 gEiDax+mZ2KvMJ+pdeOesAcbN7+Rz8KqccVRRh2nxnj0Kkqfg9DJmF9E6cwke4rTkEdJx0/cq
 kl3Wy5Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is fragile, as there is no way for the revision machinery to say "but
now I want to traverse the graph ignoring the graft file" e.g. when
pushing commits to a remote repository (which, as a consequence, can
miss commits).

And we already have a better solution with `git replace --graft <comit>
[<parent>...]`.

Changes since v5:

- Disentangled the lumped-together conditional blocks in
  edit_and_replace() again.

- Moved fixup (a superfluous argv_array_clear()) from the patch that
  adds a test for --convert-graft-file back to the patch that actually
  introduces that option.


Johannes Schindelin (11):
  argv_array: offer to split a string by whitespace
  commit: Let the callback of for_each_mergetag return on error
  replace: avoid using die() to indicate a bug
  replace: "libify" create_graft() and callees
  replace: introduce --convert-graft-file
  Add a test for `git replace --convert-graft-file`
  Deprecate support for .git/info/grafts
  filter-branch: stop suggesting to use grafts
  technical/shallow: stop referring to grafts
  technical/shallow: describe why shallow cannot use replace refs
  Remove obsolete script to convert grafts to replace refs

 Documentation/git-filter-branch.txt       |   2 +-
 Documentation/git-replace.txt             |  11 +-
 Documentation/technical/shallow.txt       |  20 +-
 advice.c                                  |   2 +
 advice.h                                  |   1 +
 argv-array.c                              |  20 ++
 argv-array.h                              |   2 +
 builtin/replace.c                         | 223 ++++++++++++++++------
 commit.c                                  |  18 +-
 commit.h                                  |   4 +-
 contrib/convert-grafts-to-replace-refs.sh |  28 ---
 log-tree.c                                |  13 +-
 t/t6001-rev-list-graft.sh                 |   9 +
 t/t6050-replace.sh                        |  20 ++
 14 files changed, 258 insertions(+), 115 deletions(-)
 delete mode 100755 contrib/convert-grafts-to-replace-refs.sh


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/deprecate-grafts-v6
Fetch-It-Via: git fetch https://github.com/dscho/git deprecate-grafts-v6

Interdiff vs v5:
 diff --git a/builtin/replace.c b/builtin/replace.c
 index acd30e3d824..35394ec1874 100644
 --- a/builtin/replace.c
 +++ b/builtin/replace.c
 @@ -326,10 +326,15 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
  	strbuf_release(&ref);
  
  	tmpfile = git_pathdup("REPLACE_EDITOBJ");
 -	if (export_object(&old_oid, type, raw, tmpfile) ||
 -	    (launch_editor(tmpfile, NULL, NULL) < 0 &&
 -	     error("editing object file failed")) ||
 -	    import_object(&new_oid, type, raw, tmpfile)) {
 +	if (export_object(&old_oid, type, raw, tmpfile)) {
 +		free(tmpfile);
 +		return -1;
 +	}
 +	if (launch_editor(tmpfile, NULL, NULL) < 0) {
 +		free(tmpfile);
 +		return error("editing object file failed");
 +	}
 +	if (import_object(&new_oid, type, raw, tmpfile)) {
  		free(tmpfile);
  		return -1;
  	}
-- 
2.17.0.windows.1.33.gfcbb1fa0445

