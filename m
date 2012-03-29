From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v6 0/4] push: submodule support
Date: Thu, 29 Mar 2012 09:21:20 +0200
Message-ID: <cover.1332968667.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 09:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD9g4-0002A2-M6
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 09:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705Ab2C2HVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 03:21:44 -0400
Received: from darksea.de ([83.133.111.250]:34904 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756210Ab2C2HVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 03:21:43 -0400
Received: (qmail 32064 invoked from network); 29 Mar 2012 09:21:41 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Mar 2012 09:21:41 +0200
X-Mailer: git-send-email 1.7.10.rc2.31.gd8c60
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194236>

Hi,

this is the sixth iteration of this series which should contain all
discussed cleanups from the last iteration. The testsuite was hanging
for me with make -j5 on Mac OS X 10.6.8. I doubt that it was because
of any change in series but please verify as well. A non parallel run
passed. If I find some time I will try to bisect that.

Cheers Heiko

The first iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327

The second iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177992

The third iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179037/focus=179048

The fourth iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179731

The fifth iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/190618


Heiko Voigt (4):
  Teach revision walking machinery to walk multiple times sequencially
  string-list: document that string_list_insert() inserts unique
    strings
  Refactor submodule push check to use string list instead of integer
  push: teach --recurse-submodules the on-demand option

 .gitignore                                       |    1 +
 Documentation/git-push.txt                       |   14 +++-
 Documentation/technical/api-revision-walking.txt |    5 ++
 Documentation/technical/api-string-list.txt      |    4 +-
 Makefile                                         |    1 +
 builtin/push.c                                   |   10 ++-
 object.c                                         |   11 +++
 object.h                                         |    2 +
 revision.c                                       |    5 ++
 revision.h                                       |    1 +
 submodule.c                                      |   73 ++++++++++++++---
 submodule.h                                      |    4 +-
 t/t0062-revision-walking.sh                      |   33 ++++++++
 t/t5531-deep-submodule-push.sh                   |   94 ++++++++++++++++++++++
 test-revision-walking.c                          |   66 +++++++++++++++
 transport.c                                      |   41 +++++++++-
 transport.h                                      |    1 +
 17 files changed, 344 insertions(+), 22 deletions(-)
 create mode 100755 t/t0062-revision-walking.sh
 create mode 100644 test-revision-walking.c

-- 
1.7.10.rc2.31.gd8c60
