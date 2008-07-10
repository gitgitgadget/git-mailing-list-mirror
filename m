From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 2/5] Don't display passwords on the console in fetch/push output
Date: Thu, 10 Jul 2008 22:17:38 +0200
Message-ID: <200807102217.38459.robin.rosenberg.lists@dewire.com>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org> <1215670403-19191-3-git-send-email-spearce@spearce.org> <200807102056.43912.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:24:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH2gd-0002h1-V0
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 22:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbYGJUWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 16:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753168AbYGJUWq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 16:22:46 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12690 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbYGJUWp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 16:22:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 47865802846;
	Thu, 10 Jul 2008 22:22:44 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GectWJsjUbU2; Thu, 10 Jul 2008 22:22:43 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 9ACB3800691;
	Thu, 10 Jul 2008 22:22:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200807102056.43912.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88007>

>From 99c09cf2321f36eb81043aed2fa6834811ee762b Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Thu, 10 Jul 2008 22:16:19 +0200
Subject: [PATCH] Avoid password leak from URIIsh

The toString() method is commonly used for dumping information. We
never ever want to use toString when the password is needed. By masking
out the password we avoid unintentional password leaks.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/transport/URIish.java     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
index e022e57..632c8ad 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
@@ -318,7 +318,7 @@ public class URIish {
 			r.append(getUser());
 			if (getPass() != null) {
 				r.append(':');
-				r.append(getPass());
+				r.append("PASSWORD");
 			}
 		}
 
-- 
1.5.6.2.220.g44701
