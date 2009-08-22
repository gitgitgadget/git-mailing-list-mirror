From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/9] sequencer: add "do_fast_forward()" to perform a fast
	forward
Date: Sat, 22 Aug 2009 06:16:07 +0200
Message-ID: <20090822041616.4261.40442.chriscool@tuxfamily.org>
References: <20090822041157.4261.92491.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 06:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeiZY-0005aq-2z
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 06:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbZHVEuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 00:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZHVEuo
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 00:50:44 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38291 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbZHVEun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 00:50:43 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2E31B8180AC;
	Sat, 22 Aug 2009 06:50:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 28A0181805F;
	Sat, 22 Aug 2009 06:50:34 +0200 (CEST)
X-git-sha1: 919541bbadfcc5122ffec0ba45213a29a02df966 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090822041157.4261.92491.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126786>

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
