From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 14/31] Add setFetchRefSpecs and setPushRefSpecs to RemoteConfig
Date: Sun, 17 Aug 2008 22:43:55 +0200
Message-ID: <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp98-00038o-L3
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbYHQUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYHQUpI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:08 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbYHQUpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:05 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cVJRM7rwZ3YcVwl2LmbCc1pZeuRmhQeTAep+m258LZk=;
        b=DQSNMmYEzGvCCs4OWKsTrMK5+Y80Gp3ry1vq+w7gH7GGh+fD/e4iPTQYG348FNfj7/
         AQ7sudJFzBWIhRao5KY0FVEMKVPf8+sKMV8aV+WtAJEs5CdsQuyrkxDIArlHt9TmEg8p
         wsHJ/8YHtVpp/tvsW2ojQ8VZFMetxaAhixt1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Zsdhv98V1eS93ezdPJFu774Xdv5h2dL1Hc/K/2o9ZMTo7GrNgQfyCVsUWfWKUKF7O/
         2T6IaCbkrf72qAnwJqH3H4+dGZRX7FLvORupvYIohjtJsMb0QDxyyLBfin8kawLMtJxY
         mX+Han7x15eXsHDhgdjiGLYiGyCWpIjkwQ+eY=
Received: by 10.103.225.2 with SMTP id c2mr3465542mur.93.1219005904749;
        Sun, 17 Aug 2008 13:45:04 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id n10sm888452mue.0.2008.08.17.13.45.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92643>

These methods allows us overriding whole collections of specifications,
saving unnecessary external code.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/transport/RemoteConfig.java   |   24 ++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index cde5d43..5b5e4d1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -267,6 +267,30 @@ public class RemoteConfig {
 	}
 
 	/**
+	 * Override existing fetch specifications with new ones.
+	 * 
+	 * @param specs
+	 *            list of fetch specifications to set. List is copied, it can be
+	 *            modified after this call.
+	 */
+	public void setFetchRefSpecs(final List<RefSpec> specs) {
+		fetch.clear();
+		fetch.addAll(specs);
+	}
+
+	/**
+	 * Override existing push specifications with new ones.
+	 * 
+	 * @param specs
+	 *            list of push specifications to set. List is copied, it can be
+	 *            modified after this call.
+	 */
+	public void setPushRefSpecs(final List<RefSpec> specs) {
+		push.clear();
+		push.addAll(specs);
+	}
+
+	/**
 	 * Remove a fetch RefSpec from this remote.
 	 * 
 	 * @param s
-- 
1.5.6.3
