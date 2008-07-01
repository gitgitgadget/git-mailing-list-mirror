From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 00/14] Build in merge
Date: Tue,  1 Jul 2008 04:37:47 +0200
Message-ID: <cover.1214879690.git.vmiklos@frugalware.org>
References: <0ed87f20b5fa79f4a16f23a522cfc7c52f77ce0e.1214878711.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 04:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVlX-0004mN-QN
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbYGAChx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754415AbYGAChw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:37:52 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:44514 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbYGACht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:37:49 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 0103A1DDC5D;
	Tue,  1 Jul 2008 04:37:46 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BA1521A9909; Tue,  1 Jul 2008 04:37:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <0ed87f20b5fa79f4a16f23a522cfc7c52f77ce0e.1214878711.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86982>

Sorry for the resend, but I again squashed an unrelated hunk to the last
patch, so I'm sending the changed patches:

08: Add new test to ensure git-merge handles more than 25 refs.
13: git-commit-tree: make it usable from other builtins
14: Build in merge

I really hope I won't overlook this next time.

The interdiff from the previous version is empty, I just moved that
unrelated hunk from patch 13 to patch 08.

Junio C Hamano (2):
  Introduce get_merge_bases_many()
  Introduce reduce_heads()

Miklos Vajna (12):
  Move split_cmdline() to alias.c
  Move commit_list_count() to commit.c
  Move parse-options's skip_prefix() to git-compat-util.h
  Add new test to ensure git-merge handles pull.twohead and
    pull.octopus
  Move read_cache_unmerged() to read-cache.c
  git-fmt-merge-msg: make it usable from other builtins
  Introduce get_octopus_merge_bases() in commit.c
  Add new test to ensure git-merge handles more than 25 refs.
  Add new test case to ensure git-merge reduces octopus parents when
    possible
  Add new test case to ensure git-merge prepends the custom merge
    message
  git-commit-tree: make it usable from other builtins
  Build in merge

 Makefile                                      |    2 +-
 alias.c                                       |   54 ++
 builtin-commit-tree.c                         |   71 +-
 builtin-fmt-merge-msg.c                       |  155 ++--
 builtin-merge-recursive.c                     |    8 -
 builtin-merge.c                               | 1148 +++++++++++++++++++++++++
 builtin-read-tree.c                           |   24 -
 builtin-remote.c                              |   39 +-
 builtin.h                                     |    8 +
 cache.h                                       |    3 +
 commit.c                                      |  136 +++-
 commit.h                                      |    4 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git-compat-util.h                             |    6 +
 git.c                                         |   54 +--
 parse-options.c                               |    6 -
 read-cache.c                                  |   31 +
 t/t7601-merge-pull-config.sh                  |  129 +++
 t/t7602-merge-octopus-many.sh                 |   52 ++
 t/t7603-merge-reduce-heads.sh                 |   63 ++
 t/t7604-merge-custom-message.sh               |   37 +
 21 files changed, 1811 insertions(+), 219 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)
 create mode 100755 t/t7601-merge-pull-config.sh
 create mode 100755 t/t7602-merge-octopus-many.sh
 create mode 100755 t/t7603-merge-reduce-heads.sh
 create mode 100755 t/t7604-merge-custom-message.sh
