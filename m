From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] fix "diff --raw" on the work tree side
Date: Sun,  2 Mar 2008 01:43:29 -0800
Message-ID: <1204451012-17487-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 10:44:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVkk1-00005Y-50
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYCBJno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbYCBJno
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:43:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbYCBJnn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:43:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 54D532249
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:43:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D93022247 for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:43:39 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.468.g36990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75755>

The second patch fixes the inconsistency between "git-diff --raw" and
"git-diff-{index,files} --raw" when they are used for submodules.

The third one is a bit controversial and changes the semantics and
existing callers and won't be considered for 1.5.5.

Junio C Hamano (3):
      diff-lib.c: constness strengthening
      diff: make sure work tree side is shown as 0{40} when different
      diff: show submodule object name when available even on the work tree side

 diff-lib.c                |   45 +++++++++++++++++++++++++++++++------
 diff.c                    |    7 +----
 t/t4027-diff-submodule.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 13 deletions(-)
 create mode 100755 t/t4027-diff-submodule.sh

