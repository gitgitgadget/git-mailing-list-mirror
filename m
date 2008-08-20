From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 4/6] Fix proposal provider for fetch in RefSpecPanel
Date: Wed, 20 Aug 2008 04:57:38 +0200
Message-ID: <1219201060-4307-4-git-send-email-marek.zawirski@gmail.com>
References: <48AB84A2.7010905@gmail.com>
 <1219201060-4307-1-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-2-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-3-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:59:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVduZ-0001o0-W6
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbYHTC6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYHTC6A
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:58:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:15858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbYHTC57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:57:59 -0400
Received: by ug-out-1314.google.com with SMTP id c2so647198ugf.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2uTZrVwwE7d/3H61HnnDm8xW5UAn4a1oFlWfazwcSxw=;
        b=ZoJcnRpjZLN6brEEieXdAJlFn8DYKXY9FtWEqNkVOyDsL/iGFwITTnmLROMIjC/Uc0
         1eZOUH6q3nEPytz40fmN3zulFeYcDFKUH6m6rLLt4sh0MM31z5SSbJqLt2igTR/ieUlU
         ie1T7PQ72qboRdB4fhZQUQ36EAO0HnORHQV9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jS2EFuIQLC8E1nB+wuMkyx8BjBstD+5PQBbM2KHIlVbHraze9tsb4HOgwKlpp6LLMy
         qu3cgBDaTpQRhw1maJJ9sWnd29LI0mN2NLGJT+dFj8QzKVZbrqLsS4S4/7V+96czbBHo
         CcfF/97sK04tJOA9AG1NJrZaXtF65MJg5Ufv8=
Received: by 10.103.208.15 with SMTP id k15mr5333825muq.84.1219201078450;
        Tue, 19 Aug 2008 19:57:58 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id e10sm1367576muf.14.2008.08.19.19.57.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:57:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219201060-4307-3-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92957>

Proposal provider for destination fields in fetch was inappropriately
proposing illegal local expression like HEAD^, while we should propose
there only refs or wildcard expressions.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../egit/ui/internal/components/RefSpecPanel.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
index caef4d2..1621434 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
@@ -323,7 +323,7 @@ private static void setControlDecoration(final ControlDecoration control,
 	 */
 	public RefSpecPanel(final Composite parent, final boolean pushSpecs) {
 		this.pushSpecs = pushSpecs;
-		this.localProposalProvider = new RefContentProposalProvider(true);
+		this.localProposalProvider = new RefContentProposalProvider(pushSpecs);
 		this.remoteProposalProvider = new RefContentProposalProvider(false);
 		this.imageRegistry = new ImageRegistry(parent.getDisplay());
 
-- 
1.5.6.3
