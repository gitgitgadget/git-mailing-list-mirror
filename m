From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/7] prefix discovery at runtime (on Windows)
Date: Sun, 17 Aug 2008 14:44:36 +0200
Message-ID: <1218977083-14526-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUhej-0001rR-Ss
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbYHQMpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbYHQMpe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:45:34 -0400
Received: from mailer.zib.de ([130.73.108.11]:52246 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbYHQMpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:45:32 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7HCj9Ih022115;
	Sun, 17 Aug 2008 14:45:14 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7HCihbN002872;
	Sun, 17 Aug 2008 14:44:43 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92605>

Hi,
This patch series fixes discovery of the installation prefix at runtime on
Windows.  It introduces a compile flag RUNTIME_PREFIX, which can be set to
explicitly request prefix computation at runtime.

Apologies for proposing such large changes that late in the release cycle.
Maybe we want to postpone the series until 1.6.0.1 or even 1.6.1.  Note however
that in this case we should consider not releasing 1.6.0 on Windows because the
current solution in master does not reliably read the system wide configuration
on Windows.

We probably won't see a Windows installer before mid of September anyway,
unless someone temporarily takes over the position of the msysgit maintainer
until I return from holidays.  I'll be completely offline from August 25
until September 13.

        Steffen

 Makefile       |   21 +++++++++++------
 daemon.c       |    3 ++
 exec_cmd.c     |   67 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 exec_cmd.h     |    2 +-
 fast-import.c  |    4 +++
 git.c          |   20 ++++------------
 hash-object.c  |    4 +++
 index-pack.c   |    4 +++
 receive-pack.c |    3 ++
 unpack-file.c  |    4 +++
 upload-pack.c  |    3 ++
 var.c          |    4 +++
 12 files changed, 107 insertions(+), 32 deletions(-)

 [PATCH 1/7] Windows: Add workaround for MSYS' path conversion
 [PATCH 2/7] system_path(): Add prefix computation at runtime if RUNTIME_PREFIX set
 [PATCH 3/7] Refactor git_set_argv0_path() to git_extract_argv0_path()
 [PATCH 4/7] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
 [PATCH 5/7] Add calls to git_extract_argv0_path() in programs that call git_config_*
 [PATCH 6/7] Modify setup_path() to only add git_exec_path() to PATH
 [PATCH 7/7] Windows: Revert to default paths and convert them by RUNTIME_PREFIX
