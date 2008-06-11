From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 00/10] Build in merge
Date: Wed, 11 Jun 2008 22:50:24 +0200
Message-ID: <cover.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XI3-00007M-Pu
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbYFKUui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYFKUug
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32875 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYFKUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:35 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id F02481DDC5C
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:31 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7928718DFDD; Wed, 11 Jun 2008 22:50:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84653>

Hi,

It was almost a week ago I posted the previous series here and there
were numerous improvements since then.

A short changelog:

 - introducing filter_independent() in commit.c

 - avoiding commit_list_append()

 - using parseopt's skip_prefix()

 - avoiding unnecessary strbuf_addf() in builtin-fmt-merge-msg.c

As always, comments are welcome. I hope I addressed all the issues which
were pointed out in the previous thread. If this is not the case, please
correct me.

Thanks.

Miklos Vajna (10):
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

 Makefile                                      |    2 +-
 alias.c                                       |   54 ++
 builtin-fmt-merge-msg.c                       |  157 ++--
 builtin-merge-recursive.c                     |    8 -
 builtin-merge.c                               | 1128 +++++++++++++++++++++++++
 builtin-read-tree.c                           |   24 -
 builtin-remote.c                              |   39 +-
 builtin.h                                     |    4 +
 cache.h                                       |    3 +
 commit.c                                      |   56 ++
 commit.h                                      |    3 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git-compat-util.h                             |    6 +
 git.c                                         |   54 +--
 parse-options.c                               |   11 +-
 parse-options.h                               |    1 +
 read-cache.c                                  |   31 +
 t/t7601-merge-pull-config.sh                  |   72 ++
 18 files changed, 1482 insertions(+), 171 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)
 create mode 100755 t/t7601-merge-pull-config.sh
