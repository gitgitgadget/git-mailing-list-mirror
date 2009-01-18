From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/7 v2] RUNTIME_PREFIX
Date: Sun, 18 Jan 2009 13:00:08 +0100
Message-ID: <1232280015-8144-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOWMM-0007Kr-CO
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbZARMA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbZARMAx
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:00:53 -0500
Received: from mailer.zib.de ([130.73.108.11]:32932 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765912AbZARMAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:00:40 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0IC0FkR026426;
	Sun, 18 Jan 2009 13:00:20 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0IC0FJ1001758;
	Sun, 18 Jan 2009 13:00:15 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106175>

This series is a replacement for

   http://article.gmane.org/gmane.comp.version-control.git/105109

improved according to the comments by Dscho and Hannes.

        Steffen


Steffen Prohaska (6):
  Move computation of absolute paths from Makefile to runtime (in
    preparation for RUNTIME_PREFIX)
  git_extract_argv0_path(): Move check for valid argv0 from caller to
    callee
  Add calls to git_extract_argv0_path() in programs that call
    git_config_*
  Modify setup_path() to only add git_exec_path() to PATH
  Compute prefix at runtime if RUNTIME_PREFIX is set
  Windows: Revert to default paths and convert them by RUNTIME_PREFIX

Steve Haslam (1):
  Refactor git_set_argv0_path() to git_extract_argv0_path()

 Makefile             |   49 +++++++++++++++++++------------
 builtin-help.c       |    4 +-
 daemon.c             |    2 +
 exec_cmd.c           |   77 ++++++++++++++++++++++++++++++++++++++++++++------
 exec_cmd.h           |    2 +-
 fast-import.c        |    3 ++
 git.c                |   18 ++---------
 hash-object.c        |    3 ++
 http-push.c          |    2 +
 imap-send.c          |    3 ++
 index-pack.c         |    3 ++
 merge-index.c        |    3 ++
 merge-tree.c         |    3 ++
 mktag.c              |    3 ++
 mktree.c             |    3 ++
 pack-redundant.c     |    3 ++
 patch-id.c           |    3 ++
 unpack-file.c        |    3 ++
 update-server-info.c |    3 ++
 upload-pack.c        |    2 +
 var.c                |    3 ++
 21 files changed, 150 insertions(+), 45 deletions(-)
