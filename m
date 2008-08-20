From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 5/6] Fix disappearing "save configuration" label in RefSpecPage
Date: Wed, 20 Aug 2008 04:57:39 +0200
Message-ID: <1219201060-4307-5-git-send-email-marek.zawirski@gmail.com>
References: <48AB84A2.7010905@gmail.com>
 <1219201060-4307-1-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-2-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-3-git-send-email-marek.zawirski@gmail.com>
 <1219201060-4307-4-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:59:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVdup-0001sl-9R
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYHTC6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYHTC6E
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:58:04 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:32303 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbYHTC6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:58:03 -0400
Received: by mu-out-0910.google.com with SMTP id w8so321027mue.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pcLGp0Sm0ewzUb7Hb+JEyzG101fG04bAeNdgSMgVzTE=;
        b=EceP7C3MnQtridae49/Z1Nj5vkd/suqGGO/kirhOnWDucpBaLDCMksbVsBjl6x+YOT
         vImF4DS7HQFtAYOOlggeKmomTi6u3Ifwo0ge4+HswvrCAfGmQcBcNq7R+97Z03bt9qj1
         1D7yQd8c1xSFp2oLDZ8xptStIfVbOms/rzHfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eBHVbIJ3pc7c1VvYhIfGq13qp0e8UM124j7Dalvc/TG+LeW9yvl3bovrIHA/OkLwOE
         C17HS7kBBdaNlAfIu3Gpn+SJliaQoymeNG6WuQV4J803H+W4ethflr72JcbaqG1u7KCP
         CAf+pGzx2TUdEEx4oWjcFrZzP4ktq3h9x0Ums=
Received: by 10.103.131.18 with SMTP id i18mr5339792mun.116.1219201082559;
        Tue, 19 Aug 2008 19:58:02 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id y6sm3211554mug.7.2008.08.19.19.58.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:58:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219201060-4307-4-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92959>

If we call only pack() after controls were layed out, label may disappear
on dialog resize. So we probably need to relayout whole panel when label
content changes.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../egit/ui/internal/components/RefSpecPage.java   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
index 4471e24..b526cf3 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPage.java
@@ -209,7 +209,7 @@ private void revalidateImpl(final RepositorySelection newRepoSelection) {
 			saveButton.setVisible(true);
 			saveButton.setText(NLS.bind(UIText.RefSpecPage_saveSpecifications,
 					remoteName));
-			saveButton.pack();
+			saveButton.getParent().layout();
 		}
 		checkPage();
 	}
-- 
1.5.6.3
