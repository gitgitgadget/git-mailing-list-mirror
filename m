From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] sequencer: add "do_fast_forward()" to perform a fast
	forward
Date: Fri, 07 Aug 2009 22:40:50 +0200
Message-ID: <20090807204054.6280.5650.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZWNb-0007QS-NI
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933789AbZHGUtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbZHGUtT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:49:19 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55722 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbZHGUtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:49:18 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B52C78180B5;
	Fri,  7 Aug 2009 22:49:09 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6D3258180EE;
	Fri,  7 Aug 2009 22:49:06 +0200 (CEST)
X-git-sha1: 096bea8de5be12e407de8c7c287aab62da08aa4a 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125222>

From: Stephan Beyer <s-beyer@gmx.net>

This code is taken from the sequencer GSoC project:

    git://repo.or.cz/git/sbeyer.git

    (commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)

but the messages have been changed to be the same as those
displayed by git-rebase--interactive.sh.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index be030bc..0cd7e98 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -171,6 +171,15 @@ static struct commit *get_commit(const char *arg)
 	return lookup_commit_reference(sha1);
 }
 
+static int do_fast_forward(const unsigned char *sha)
+{
+	if (reset_almost_hard(sha))
+		return error("Cannot fast forward to %s", sha1_to_hex(sha));
+	if (verbosity > 1)
+		printf("Fast forward to %s\n", sha1_to_hex(sha));
+	return 0;
+}
+
 static int set_verbosity(int verbose)
 {
 	char tmp[] = "0";
-- 
1.6.4.209.g16b77
