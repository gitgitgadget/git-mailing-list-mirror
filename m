From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v3 0/5] reroll bc/attr-ignore-case
Date: Thu,  6 Oct 2011 13:22:20 -0500
Message-ID: <U4wiHVyDLLG1PhI-8iY3YvK8PNPcrE_H1LfZdeQFnOrSJ5O-Hev7KzBOnrAY-vjiT2yzgWpfSAPFG2-cG0LrUPezOcTUNC6trUWFODOXIkXyJzvz-maBv6HrPKDCs98TTT4OGmgo0j8@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, peff@peff.net, j.sixt@viscovery.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 06 20:23:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsay-0002W7-A9
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763Ab1JFSWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:22:55 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:45172 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016Ab1JFSWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:22:54 -0400
Received: by mail3.nrlssc.navy.mil id p96IMlNK031868; Thu, 6 Oct 2011 13:22:47 -0500
X-OriginalArrivalTime: 06 Oct 2011 18:22:44.0709 (UTC) FILETIME=[F148A150:01CC8454]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183006>

This re-rolls the whole series so that it can replace your current
bc/attr-ignore-case.  It includes the two v2 patches I submitted last
night and backs out the use of xmalloc in compat/win32/syslog.c that
Johannes Sixt pointed out as a recursion issue.  Erik Faye-Lunde has a
patch to remove the existing calls to x-wrapper functions in the function.

Built on top of 5738c9c21e53356ab5020912116e7f82fd2d428f, the same base
as your current bc/attr-ignore-case.

-Brandon


Brandon Casey (4):
  attr.c: avoid inappropriate access to strbuf "buf" member
  cleanup: use internal memory allocation wrapper functions everywhere
  builtin/mv.c: plug miniscule memory leak
  attr.c: respect core.ignorecase when matching attribute patterns

Junio C Hamano (1):
  attr: read core.attributesfile from git_default_core_config

 attr.c                |   46 ++++++++++++++-----------------------
 builtin/check-attr.c  |    2 +
 builtin/mv.c          |    6 ++++-
 cache.h               |    1 +
 compat/mingw.c        |    2 +-
 compat/qsort.c        |    2 +-
 config.c              |    3 ++
 environment.c         |    1 +
 remote.c              |    2 +-
 show-index.c          |    2 +-
 t/t0003-attributes.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 transport-helper.c    |    4 +-
 12 files changed, 94 insertions(+), 37 deletions(-)

-- 
1.7.7
