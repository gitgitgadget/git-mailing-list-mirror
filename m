From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 00/11] Build in merge
Date: Fri, 20 Jun 2008 01:22:25 +0200
Message-ID: <cover.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:23:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TTd-0006Lk-5e
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbYFSXWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbYFSXWk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:22:40 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46945 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbYFSXWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:40 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 9E56C1DDC5B
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:37 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6A22B18E0E7; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85564>

Hi,

Changes since the previous series I sent out to the list:

- get_octopus_merge_bases() now always does a cleanup

- added a new test to make sure git-merge handles more than 25 refs

As usual, comments are welcome. :-)

Miklos Vajna (11):
  Move split_cmdline() to alias.c
  Move commit_list_count() to commit.c
  Move parse-options's skip_prefix() to git-compat-util.h
  Add new test to ensure git-merge handles pull.twohead and
    pull.octopus
  parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
  Move read_cache_unmerged() to read-cache.c
  git-fmt-merge-msg: make it usable from other builtins
  Introduce get_octopus_merge_bases() in commit.c
  Introduce filter_independent() in commit.c
  Build in merge
  Add new test to ensure git-merge handles more than 25 refs.

 Makefile                                      |    2 +-
 alias.c                                       |   54 ++
 builtin-fmt-merge-msg.c                       |  157 ++--
 builtin-merge-recursive.c                     |    8 -
 builtin-merge.c                               | 1128 +++++++++++++++++++++++++
 builtin-read-tree.c                           |   24 -
 builtin-remote.c                              |   39 +-
 builtin.h                                     |    4 +
 cache.h                                       |    3 +
 commit.c                                      |   51 ++
 commit.h                                      |    3 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git-compat-util.h                             |    6 +
 git.c                                         |   54 +--
 parse-options.c                               |   11 +-
 parse-options.h                               |    1 +
 read-cache.c                                  |   31 +
 t/t7601-merge-pull-config.sh                  |   72 ++
 t/t7602-merge-octopus-many.sh                 |   52 ++
 19 files changed, 1529 insertions(+), 171 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)
 create mode 100755 t/t7601-merge-pull-config.sh
 create mode 100755 t/t7602-merge-octopus-many.sh
