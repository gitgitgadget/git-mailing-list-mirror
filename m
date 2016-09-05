Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C8621F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 09:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbcIEJpd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:33 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60354 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932408AbcIEJpa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:30 -0400
X-AuditID: 12074411-a07ff70000000932-aa-57cd3e9e6cea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id FF.8A.02354.E9E3DC75; Mon,  5 Sep 2016 05:45:02 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtN008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:00 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/8] Better heuristics make prettier diffs
Date:   Mon,  5 Sep 2016 11:44:45 +0200
Message-Id: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqDvP7my4wep5KhZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4Gs2yvmM1v8aOlhtph51dpi8+Z2FgdOj7/vPzB57Jx1l91jwaZSj2e9
        exg9Ll5S9ti/dBubx+dNch63n21jCeCI4rJJSc3JLEst0rdL4MpYue8Oc8FP8YrDR48xNTAe
        Fuxi5OSQEDCReLzzL3sXIxeHkMBWRonFX49AOSeZJD4+e8sCUsUmoCuxqKeZCcQWERCXeHt8
        JlgRs8BfJonFj+6ygSSEBWwlJn3ZwAhiswioSvy5tA8szitgLnHlzwxWiHVyEpe2fWGGiAtK
        nJz5BGgBB9AgdYn184RAwswC8hLNW2czT2DknYWkahZC1SwkVQsYmVcxyiXmlObq5iZm5hSn
        JusWJyfm5aUW6Zrq5WaW6KWmlG5ihIS24A7GGSflDjEKcDAq8fBO0D0TLsSaWFZcmXuIUZKD
        SUmUt0D1bLgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4dFkA53pTEyqrUonyYlDQHi5I4L98S
        dT8hgfTEktTs1NSC1CKYrAwHh5IEr5otUKNgUWp6akVaZk4JQpqJgxNkOA/QcGcbkOHFBYm5
        xZnpEPlTjLocc9bcWcskxJKXn5cqJc6bAlIkAFKUUZoHNweWkl4xigO9JcybBLKOB5jO4Ca9
        AlrCBLRk3e7TIEtKEhFSUg2McrxSTd+eynp6PTVPXiZ/fq185qcbqw6lZ4TJrqo6VZFydvFd
        QWvnv9d2bZCcqpXdq2Z8rnTNtt1tf/X9eSaIBFjrPd8cbhzI+zLyHKehkrXTjOLDMfKdB/54
        usabHSvXbr3g9c5Jgvve5Iftsw8EORbEXy1+s+W5dloh40xOto3WhxImzTRSYinOSDTUYi4q
        TgQAoLIGWyQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v3 of the diff-indent-heuristic patch series. Thanks to René,
Junio, and Ramsay for their comments about v2 [1,2].

The heuristic itself hasn't changed since v2. Most of the changes are
in the tests and in how `git blame` is wired up to support the new
options. Changes since v1:

* In "diff: improve positioning of add/delete blocks in diffs":

  * Make `score_cmp()` static.

  * Add test t4059 as part of this commit, not as part of its
    successor.

  * t4059: Create commits to use for the tests (rather than diffing
    loose files with `--no-cache`), so that the same prep can be used
    to test `git blame`. Split the tests into multiple smaller tests.

  * Add a test that `--no-indent-heuristic` overrides the config.

* Add a new commit "parse-options: add parse_opt_unknown_cb()":

  * Allow "-h" help text to be generated for options even if they are
    being handled by code external to `parse_options()`.

  If there's already a way to do this, I didn't find it.

* In "blame: honor the diff heuristic options and config":

  * In v2, I suggested making `blame` honor all diff-related options.
    Junio explained why this was a bad idea. So this version only
    makes `blame` honor `--indent-heuristic` and
    `--compaction-heuristic`.

  * Add some smoke tests.

This patch series is also available from my GitHub fork [3], branch
"diff-indent-heuristic"

[1] http://public-inbox.org/git/cover.1471864378.git.mhagger@alum.mit.edu/
[2] http://public-inbox.org/git/a27aa17e-f602-fc49-92b3-2198e4772e47@ramsayjones.plus.com/
[3] https://github.com/mhagger/git

Michael Haggerty (8):
  xdl_change_compact(): fix compaction heuristic to adjust ixo
  xdl_change_compact(): only use heuristic if group can't be matched
  is_blank_line(): take a single xrecord_t as argument
  recs_match(): take two xrecord_t pointers as arguments
  xdl_change_compact(): introduce the concept of a change group
  diff: improve positioning of add/delete blocks in diffs
  parse-options: add parse_opt_unknown_cb()
  blame: honor the diff heuristic options and config

 Documentation/diff-config.txt            |   7 +-
 Documentation/diff-heuristic-options.txt |   7 +
 Documentation/diff-options.txt           |   7 +-
 Documentation/git-annotate.txt           |   1 +
 Documentation/git-blame.txt              |   2 +
 builtin/blame.c                          |  12 +
 diff.c                                   |  36 +-
 diff.h                                   |   1 +
 git-add--interactive.perl                |   5 +-
 parse-options-cb.c                       |  12 +
 parse-options.h                          |   1 +
 t/t4059-diff-indent.sh                   | 216 +++++++++++
 xdiff/xdiff.h                            |   1 +
 xdiff/xdiffi.c                           | 635 ++++++++++++++++++++++++++-----
 14 files changed, 828 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/diff-heuristic-options.txt
 create mode 100755 t/t4059-diff-indent.sh

-- 
2.9.3

