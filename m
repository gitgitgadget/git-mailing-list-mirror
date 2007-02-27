From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Implement core.symlinks to support filesystems without symlinks
Date: Tue, 27 Feb 2007 22:41:36 +0100
Message-ID: <11726125012895-git-send-email-johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 22:41:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMA56-0000yR-F5
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXB0Vlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXB0Vlq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:41:46 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:46971 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbXB0Vlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:41:45 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 9B00B97636
	for <git@vger.kernel.org>; Tue, 27 Feb 2007 22:41:42 +0100 (CET)
X-Mailer: git-send-email 1.5.0.19.gddff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40810>


Here is a small patch series that adds a configuration variable core.symlinks.
From the manual:

core.symlinks::
	If false, symbolic links are checked out as small plain files that
	contain the link text. gitlink:git-update-index[1] and
	gitlink:git-add[1] will not change the recorded type to regular
	file. Useful on filesystems like FAT that do not support
	symbolic links. True by default.


The implementation was surprisingly simple:

 Documentation/config.txt           |    7 +++++++
 Documentation/git-update-index.txt |    5 +++++
 builtin-apply.c                    |    2 +-
 builtin-update-index.c             |    6 +++---
 cache.h                            |    7 ++++++-
 config.c                           |    5 +++++
 diff-lib.c                         |    3 +++
 entry.c                            |    5 +++++
 environment.c                      |    1 +
 read-cache.c                       |   12 +++++++-----
 10 files changed, 43 insertions(+), 10 deletions(-)


-- Hannes
