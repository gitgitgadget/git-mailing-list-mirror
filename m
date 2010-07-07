From: newren@gmail.com
Subject: [PATCH 0/2] non-incremental mode for fast-export
Date: Wed,  7 Jul 2010 14:46:00 -0600
Message-ID: <1278535562-14875-1-git-send-email-newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 22:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWbO0-00071p-7D
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 22:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab0GGUiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 16:38:22 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49786 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0GGUiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 16:38:21 -0400
Received: by pvc7 with SMTP id 7so26696pvc.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=EoAwbrQC/Go2+HG6invZVj8HR8hw+C8BHEdeD68mB5g=;
        b=jdnLMu6aSjQ9HrXWc8TQcpATlWm/WpFYKxN23rVinJIiCgCwyPrOmJPUgJ7MZnsjuW
         c17olY97hq2dBZ1nt5UVVe3VBrt3ZOo1Vn+1obwqANO5uKn+1aI+bfyuX7OwdpJw22YV
         NoX560A4U2D4Cos17zuaDVlxui8h1uVQNwxIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=kTKVZQJu/mFvlkHOkNkefSXdIW0C77HCLUSpB+0uAz4a0f74liEEBNUWbvIDXj7aaH
         Ac5fpEL06OnC5FDwZJx+y//+MPcq3rKr6LNWSYqQ4pp9rUEML7t4W+ZhZazqego/H30D
         6PjC0VHbcJIbA1OQdh32qVi0ZC2zFTgXo2/X4=
Received: by 10.142.204.17 with SMTP id b17mr23532wfg.137.1278535100346;
        Wed, 07 Jul 2010 13:38:20 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id c26sm7589013rvf.15.2010.07.07.13.38.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 13:38:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.14.g19914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150501>

This patch series fixes silently dropped files in uses of fast-export
involving both --import-marks and limiting files by path.  It also
adds a new feature: a --full-tree option to switch from incremental to
comprehensive handling of files in commits.  The two changes are
related in that the bugfix consists of simply automatically activating
the new feature in a case where it is required for correct operation.

This obsoletes my previous (single) patch submission about the
--full-tree option.  Changes since that submission include splitting
this into two patches, automatically enabling the feature when needed
for correct behavior, and providing more explicit testcases that
probably explain the feature better.

Since we're in feature freeze, it may make sense to split this patch
series so that the first patch can be applied now and keep the second
patch in pu until feature freeze is over (the series is currently
based on maint).  Since the second patch depends on the first, though,
I thought it made sense to submit them together; let me know if you'd
rather I submitted them in some other manner.

(I'm not sure who to cc on this; other than Dscho who is out, I appear
to be the biggest contributor to fast-export.)

Elijah Newren (2):
      fast-export: Fix dropping of files with --import-marks and path limiting
      fast-export: Add a --full-tree option

 Documentation/git-fast-export.txt |    6 +++
 builtin/fast-export.c             |   11 +++++-
 t/t9350-fast-export.sh            |   79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletions(-)
