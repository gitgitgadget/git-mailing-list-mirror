From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 02/31] Fix Repository isValidRefName() for empty names
Date: Sun, 17 Aug 2008 22:43:43 +0200
Message-ID: <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8J-0002uV-L8
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbYHQUo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYHQUo0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:26 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYHQUoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:24 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UmgdXwPkLyGYcMpsTeMQictk//O1Q0qIZ9I3dlHC3gc=;
        b=qXq5s6rot86mJCqvHu2uAj7OZ8FYxezksVj8SmyjxCr5+K3N9XbcEpisSLZ2ypxpNW
         4aa/M1Cm0XHj0xe6pXxmYMN9TDkIEHJaNq81127Tbbi99w6SymMJIoHR4xqCO82980lL
         gO+Zi3wuWx0ONc/3d2HOAllwt2HRqkqsVZXoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M0lmRfVd71BD7ntjixyRBEJ1VaChSiyWI3kFDinfa7SrCOPLwXvkyAvCU97rxFsHfO
         W2MiNajO/euiOTFP6QVqHY9RtAIpT8T454fZOQ8a/MbH5HHBS2iGqvA5k7YFswIdrKle
         bUK80fZ4JezTvAUgTrfSGVhg2Rxn86r30cYjM=
Received: by 10.103.198.15 with SMTP id a15mr3462105muq.60.1219005863769;
        Sun, 17 Aug 2008 13:44:23 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id e8sm4417309muf.6.2008.08.17.13.44.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:22 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92633>

Empty name is obviously invalid - method should return false.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index a8591cc..17cdb40 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -986,6 +986,9 @@ public class Repository {
 	 */
 	public static boolean isValidRefName(final String refName) {
 		final int len = refName.length();
+		if (len == 0)
+			return false;
+		
 		char p = '\0';
 		for (int i=0; i<len; ++i) {
 			char c = refName.charAt(i);
-- 
1.5.6.3
