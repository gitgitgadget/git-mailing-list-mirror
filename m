From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH/RFC] submodule: fallback to .gitmodules and multiple level module definition
Date: Thu, 10 Apr 2008 23:50:15 +0800
Message-ID: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 17:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjz4Y-0005Y2-0L
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923AbYDJPuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757677AbYDJPuf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:50:35 -0400
Received: from mail.qikoo.org ([60.28.205.235]:37780 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757370AbYDJPu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:50:28 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 71D38470B0; Thu, 10 Apr 2008 23:50:25 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79223>

This patch series has two functional improvements for submodule

  - Fall back on .gitmodules if info not found in $GIT_DIR/config
  - multi-level module definition

Patches 1,2,4 is mainly code refactor but the second one also
has some semantic change.

The other patches do the real functional changes.

Ping Yin (7):
      git-submodule: Extract functions module_info and module_url
      git-submodule: Extract absolute_url & move absolute url logic to module_clone
      git-submodule: Fall back on .gitmodules if info not found in $GIT_DIR/config
      git-submodule: Extract module_add from cmd_add
      git-submodule: multi-level module definition
      git-submodule: Don't die when command fails for one submodule
      git-submodule: "update --force" to enforce cloning non-submodule

 git-submodule.sh           |  326 ++++++++++++++++++++++++++++++++------------
 t/t7400-submodule-basic.sh |   31 ++++-
 2 files changed, 267 insertions(+), 90 deletions(-)
