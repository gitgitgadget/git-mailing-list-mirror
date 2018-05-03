Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BB4200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeECPad (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:35007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeECPac (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:32 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LqF9o-1ejcKr3W8u-00dpjl; Thu, 03 May 2018 17:30:25 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
Date:   Thu,  3 May 2018 17:30:20 +0200
Message-Id: <cover.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jUKgJAahPbISM+YMKApGo7frLfrh/RbsqtpqaNty3gVjzF4JtgM
 kmCNrK9QqlHQ87aZzUFrxTjPUANTRGQWPDq7OfduxUb2NSWjElsXdi+KbpA3+yEJF9xQCut
 dQIEZdWWjpOzIDyhu5Ks7bDNJkiMoWtQe9gdDSQEvtiF0V25JH4GC0HDXHXetT35WsJYxs+
 B48etxbkiYFVY3DOfD0Ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+thg21maFVs=:R+l8UNSzPtmIt9lnzkBEkF
 wru206tlCUag6y5X/8KDj1LsXlgm80n7OTpHCmNocqRzQ6/aEcPGRkyhc1VgbVvHlUYSoPAsB
 I+k0h+pVAHOtjqjuljfX29vdu04OhSMs3x4/THx5kThyMPH+bTRH36HSux+kJNLTHlly/ngwZ
 OQp5yZwOTuLLQKJ7ESWMnyUz03A7Qjr+kkraZJmWPRivzAOpBRNg6RMONG2vzeo9XF1V4gk3H
 d9HxdB/5V2mk7BO9r27PeTarIF/czKqTefnqyPJBcrq2lWWGWFAu1U3RvSfKyNhKt9Y9AbGQ2
 q7hHxmP15jXG/ZHUKeer4Hi8VLl//zib25Wk2DfLJJ57iebDEpJ+V71rW/dDeyJsZa2wkffxQ
 qNpdieJ5w68w8sILaFeN3e7k02uKNalarCC82van+zHIQvtrtRStrLbg9O46sNrq9GcxOwau4
 48NlMkIqz9TlNsQk5aiHexeqOim+iKSekc1xUTiKOVJnPkOWDLndqouKqYsCukuTO2SXNKwhW
 Ao62iYaxUtefDz6aTFStFZft871HMzYVC6ug/dye3B8ZmiEpMaUNjSlpPgXeZ5v01b3bGdxNv
 Ho4J34kdJIPGGR9SVpcvt2rpPjNEZkxT3z351zKESyA1WccXLqcmyWUZOU76IU6rHFjvQxfsE
 xXnUbZUAKqnTtVIAVNdnKlEM7iHWSYdVrWneM62KUbxkOrC8n5KHLz/CJFsj/EUTe0evmgMnN
 t/CQIPhOeXG3l2Ko13PyLw6Lm6DhStpwK8MHELgJ4eqd9oEsIcxwYJTBitrIxOnwIyukYllLZ
 8qDSmQv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The incredibly useful `git-tbdiff` tool to compare patch series (say, to see
what changed between two iterations sent to the Git mailing list) is slightly
less useful for this developer due to the fact that it requires the `hungarian`
and `numpy` Python packages which are for some reason really hard to build in
MSYS2. So hard that I even had to give up, because it was simply easier to
reimplement the whole shebang as a builtin command.

The project at https://github.com/trast/tbdiff seems to be dormant, anyway.
Funny (and true) story: I looked at the open Pull Requests to see how active
that project is, only to find to my surprise that I had submitted one in August
2015, and that it was still unanswered let alone merged.

While at it, I forward-ported AEvar's patch to force `--decorate=no` because
`git -p tbdiff` would fail otherwise.


Johannes Schindelin (17):
  Add a function to solve least-cost assignment problems
  Add a new builtin: branch-diff
  branch-diff: first rudimentary implementation
  branch-diff: improve the order of the shown commits
  branch-diff: also show the diff between patches
  branch-diff: right-trim commit messages
  branch-diff: indent the diffs just like tbdiff
  branch-diff: suppress the diff headers
  branch-diff: adjust the output of the commit pairs
  branch-diff: do not show "function names" in hunk headers
  branch-diff: use color for the commit pairs
  color: provide inverted colors, too
  diff: add an internal option to dual-color diffs of diffs
  branch-diff: offer to dual-color the diffs
  branch-diff --dual-color: work around bogus white-space warning
  branch-diff: add a man page
  completion: support branch-diff

Thomas Rast (1):
  branch-diff: add tests

 .gitignore                             |   1 +
 Documentation/git-branch-diff.txt      | 239 ++++++++++
 Makefile                               |   2 +
 builtin.h                              |   1 +
 builtin/branch-diff.c                  | 531 ++++++++++++++++++++++
 color.h                                |   6 +
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |  18 +
 diff.c                                 |  76 +++-
 diff.h                                 |   6 +-
 git.c                                  |   1 +
 hungarian.c                            | 205 +++++++++
 hungarian.h                            |  19 +
 t/.gitattributes                       |   1 +
 t/t7910-branch-diff.sh                 | 144 ++++++
 t/t7910/history.export                 | 604 +++++++++++++++++++++++++
 16 files changed, 1843 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-branch-diff.txt
 create mode 100644 builtin/branch-diff.c
 create mode 100644 hungarian.c
 create mode 100644 hungarian.h
 create mode 100755 t/t7910-branch-diff.sh
 create mode 100644 t/t7910/history.export


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/branch-diff-v1
Fetch-It-Via: git fetch https://github.com/dscho/git branch-diff-v1
-- 
2.17.0.395.g6a618d6010f.dirty

