From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [updated patch v2 0/2] Improve remote helper exec failure reporting
Date: Thu, 31 Dec 2009 12:48:06 +0200
Message-ID: <1262256488-22985-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 11:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQIZq-0004yX-E8
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 11:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbZLaKsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 05:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZLaKsM
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 05:48:12 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:53585 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZLaKsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 05:48:12 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 6F87018D239
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 12:48:10 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0395D6DD74; Thu, 31 Dec 2009 12:48:10 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 618034076
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 12:48:09 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135941>

Changes since updated patch (second round):
- Work around deadlock with pager.
- Fix exec reporting if read end of report pipe winds up to be fd #0.
- Limit number of retries in force_close for unexpected errors.

Ilari Liusvaara (2):
  Report exec errors from run-command
  Improve transport helper exec failure reporting

 Makefile               |    1 +
 run-command.c          |  103 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t0061-run-command.sh |   13 ++++++
 test-run-command.c     |   35 ++++++++++++++++
 transport-helper.c     |   14 +++++--
 5 files changed, 158 insertions(+), 8 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c
