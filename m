From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 05/31] Fix RefSpec javadoc regarding spec expanding
Date: Sun, 17 Aug 2008 22:43:46 +0200
Message-ID: <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:45:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8L-0002uV-KE
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYHQUoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbYHQUoh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:37 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYHQUoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:34 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=isYzmcMFJRROSMTc81KH1NcIIvIwRS1rWNTiG2HvMSw=;
        b=vMY19tytUZVv4J1SDtw4l16qP10YdEjSTx0RSacI2rSM+CDNL51L3a5CJYLPm2w9J2
         e9d09FvXX4GtMJioNQiqYx5dZ6Y4TM0a1qGhlJiFBCfBpR0g5z5+5pVvF43IZRjdinLx
         Oztcf840HfocpquvkyOS5ePkxl6bNbnlPMbas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kJw8MMIcfRJzUNK4lplGe/l4ViHlaYOGedGt9CVIa5rWKAZci3gVR1BKesrlcNcucI
         GzRrAn8cycmFucqcJUpElocMTQQoWDyV1LOh2bHu3To5DHE4YJHVm9pgL782U2pXlfCv
         OcbqJ25uwTxS03nXW2vygevHxH3tNAFDMW+rU=
Received: by 10.103.22.11 with SMTP id z11mr3467672mui.106.1219005873815;
        Sun, 17 Aug 2008 13:44:33 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id u9sm3168744muf.9.2008.08.17.13.44.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92636>

We can give expandSource() a wildcard as argument, so it will produce
new wildcard spec, which is still correct.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/RefSpec.java    |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
index 25d5977..e489233 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
@@ -331,8 +331,11 @@ public class RefSpec {
 	 * otherwise expansion results may be unpredictable.
 	 *
 	 * @param r
-	 *            a ref name that matched our source specification.
-	 * @return a new specification that is not a wildcard.
+	 *            a ref name that matched our source specification. Could be a
+	 *            wildcard also.
+	 * @return a new specification expanded from provided ref name. Result
+	 *         specification is wildcard if and only if provided ref name is
+	 *         wildcard.
 	 */
 	public RefSpec expandFromSource(final String r) {
 		return isWildcard() ? new RefSpec(this, r) : this;
@@ -345,8 +348,11 @@ public class RefSpec {
 	 * otherwise expansion results may be unpredictable.
 	 * 
 	 * @param r
-	 *            a ref that matched our source specification.
-	 * @return a new specification that is not a wildcard.
+	 *            a ref that matched our source specification. Could be a
+	 *            wildcard also.
+	 * @return a new specification expanded from provided ref name. Result
+	 *         specification is wildcard if and only if provided ref name is
+	 *         wildcard.
 	 */
 	public RefSpec expandFromSource(final Ref r) {
 		return isWildcard() ? new RefSpec(this, r.getName()) : this;
-- 
1.5.6.3
