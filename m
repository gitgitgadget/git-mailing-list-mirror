From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/4] Another bundle fix: reading freed memory
Date: Thu, 1 Mar 2012 22:40:47 +0100
Message-ID: <cover.1330637923.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:41:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3DkF-0007Si-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109Ab2CAVk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:40:57 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:45305 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965066Ab2CAVkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:40:55 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:49 +0100
Received: from thomas.inf.ethz.ch (129.132.210.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:52 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
X-Originating-IP: [129.132.210.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191973>

This is about the fourth patch, the other three are just cleanups.
Valgrind caught me reading free()d memory after the recent change to a
strbuf in create_bundle.  Luckily it's the only report I got.

I made a token effort to verify that nobody else is playing mind games
with the .name fields in struct object_array, but I'm rather tired so
it would be nice if someone could double-check.  In any case bundle is
the only user of object_array_remove_duplicates.

Thomas Rast (4):
  t5510: refactor bundle->pack conversion
  t5510: fix indent with spaces
  t5510: ensure we stay in the toplevel test dir
  bundle: keep around names passed to add_pending_object()

 bundle.c         |    2 +-
 t/t5510-fetch.sh |   57 +++++++++++++++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 23 deletions(-)

-- 
1.7.9.2.467.g7fee4
