From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH 0/8] The return of -Xours, -Xtheirs, -Xsubtree=dir
Date: Wed, 25 Nov 2009 21:23:52 -0500
Message-ID: <cover.1259201377.git.apenwarr@gmail.com>
Cc: <gitster@pobox.com>, "Avery Pennarun" <apenwarr@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUJq-0004jY-Dr
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbZKZCmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZKZCmc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:32 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbZKZCmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:31 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
thread-index: AcpuP/gthWfSUtuQRFOaWnOartUYJg==
X-Language-Identified: TRUE
X-Brightmail-Tracker: AAAAAQAAA+k=
Content-Class: urn:content-classes:message
Importance: normal
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Wed, 25 Nov 2009 21:26:41 -0500
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Received: (qmail 5444 invoked from network); 26 Nov 2009 02:25:33 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:33 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:08 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
X-OriginalArrivalTime: 26 Nov 2009 02:26:41.0168 (UTC) FILETIME=[E376A900:01CA6E3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133754>

As discussed earlier today, this brings back Junio's earlier patch series
that introduced (and then used) a -X option for configuring merge
strategies.  My favourite use of this is -Xsubtree=<dir>, which lets you
provide the actual subdir prefix when using the subtree merge strategy.

Avery Pennarun (8):
  git-merge-file --ours, --theirs
  builtin-merge.c: call exclude_cmds() correctly.
  git-merge-recursive-{ours,theirs}
  Teach git-merge to pass -X<option> to the backend strategy module
  Teach git-pull to pass -X<option> to git-merge
  Make "subtree" part more orthogonal to the rest of merge-recursive.
  Extend merge-subtree tests to test -Xsubtree=dir.
  Document that merge strategies can now take their own options

 .gitignore                         |    2 +
 Documentation/git-merge-file.txt   |   12 +++++-
 Documentation/merge-options.txt    |    4 ++
 Documentation/merge-strategies.txt |   29 ++++++++++++++-
 builtin-checkout.c                 |    2 +-
 builtin-merge-file.c               |    5 ++-
 builtin-merge-recursive.c          |   24 ++++++++++---
 builtin-merge.c                    |   44 +++++++++++++++++++++--
 cache.h                            |    1 +
 contrib/examples/git-merge.sh      |    3 +-
 git-compat-util.h                  |    1 +
 git-pull.sh                        |   17 ++++++++-
 git.c                              |    2 +
 ll-merge.c                         |   20 +++++-----
 ll-merge.h                         |    2 +-
 match-trees.c                      |   69 +++++++++++++++++++++++++++++++++++-
 merge-recursive.c                  |   35 +++++++++++++++---
 merge-recursive.h                  |    7 +++-
 strbuf.c                           |    9 +++++
 t/t6029-merge-subtree.sh           |   47 ++++++++++++++++++++++++-
 t/t6034-merge-ours-theirs.sh       |   64 +++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                      |    7 +++-
 xdiff/xmerge.c                     |   11 +++++-
 23 files changed, 377 insertions(+), 40 deletions(-)
 create mode 100755 t/t6034-merge-ours-theirs.sh
