From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/9] sequencer: add "do_fast_forward()" to perform a fast
	forward
Date: Fri, 21 Aug 2009 07:49:52 +0200
Message-ID: <20090821055001.3726.10152.chriscool@tuxfamily.org>
References: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeN6X-0001bm-8l
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbZHUFzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbZHUFzo
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:55:44 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56342 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbZHUFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:55:44 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4D6F0818126;
	Fri, 21 Aug 2009 07:55:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1AB9D8180FB;
	Fri, 21 Aug 2009 07:55:34 +0200 (CEST)
X-git-sha1: b9c5c495f1f609ea9face1a5df092bb6501e5f3d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126680>

From: Stephan Beyer <s-beyer@gmx.net>

This code is taken from the sequencer GSoC project:

    git://repo.or.cz/git/sbeyer.git

    (commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)

but the messages have been changed to be the same as those
displayed by git-rebase--interactive.sh.

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
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
1.6.4.271.ge010d
