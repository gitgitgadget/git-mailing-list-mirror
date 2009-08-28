From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH master] t/test-lib.sh: provide a shell implementation of the 'yes' utility
Date: Fri, 28 Aug 2009 17:32:41 -0500
Message-ID: <hFaZixUUvhrEV7wTTph3baQERVcA7g0KV0MihRGD1StE5zN58p2u1kJ9hdFMxNeyvn0_E3JvnFM@cipher.nrlssc.navy.mil>
References: <tK_IWVRokJuwYhAJ3h5cvYFUGHzmrYoRPbMxLQUdj2eLINK_28NnVA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 29 00:33:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhA0A-00085l-PL
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 00:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbZH1Wcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 18:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZH1Wcu
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 18:32:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35649 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZH1Wct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 18:32:49 -0400
Received: by mail.nrlssc.navy.mil id n7SMWnbl024836; Fri, 28 Aug 2009 17:32:49 -0500
In-Reply-To: <tK_IWVRokJuwYhAJ3h5cvYFUGHzmrYoRPbMxLQUdj2eLINK_28NnVA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 28 Aug 2009 22:32:49.0046 (UTC) FILETIME=[78E70360:01CA282F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127359>

From: Brandon Casey <drafnel@gmail.com>

Some platforms (IRIX 6.5, Solaris 7) do not provide the 'yes' utility.
Currently, some tests, including t7610 and t9001, try to call this program.
Due to the way the tests are structured, the tests still pass even though
this program is missing.  Rather than succeeding by chance, let's provide
an implementation of the simple 'yes' utility in shell for all platforms to
use.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/test-lib.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a5b8d03..f2ca536 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -685,6 +685,21 @@ do
 	esac
 done
 
+# Provide an implementation of the 'yes' utility
+yes () {
+	if test $# = 0
+	then
+		y=y
+	else
+		y="$*"
+	fi
+
+	while echo "$y"
+	do
+		:
+	done
+}
+
 # Fix some commands on Windows
 case $(uname -s) in
 *MINGW*)
-- 
1.6.4
