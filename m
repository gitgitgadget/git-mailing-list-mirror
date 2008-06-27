From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 07/23] Add PushResult class
Date: Sat, 28 Jun 2008 00:06:31 +0200
Message-ID: <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:09:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7f-0000rw-4a
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbYF0WH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756666AbYF0WHY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31033 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbYF0WHU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so330044fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RgVCi09VeaB7WkmAUGdFZvFoQpaSYzl2j96XK6JzlWc=;
        b=WITJ8qlHadHG2bxR2ZHYqwR6ULlAQB2Wc9R9p0AamyzSKgRKgeyE7XOmFxSW2fRBXR
         Wa9YBRxr9nTB1d3+5vHBj76Mey9bDX9H0/1ORCP8nxsXWcbrWvUJdTjXkd0e5O9oSG/O
         /I2FgK68+yXVqIemox9RrykbJmlZv6hLyEsMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tqJUD190rCFO3DXM0zAEeGyiomS8bcIq3oyjolGw4uqbZh1E45AGltaW6KmNfnz0ZW
         WIk/e8K7gR4M9kcnuVVOz357s4dws029MuQfS9YbNm06mrKA4QIMS1nCx6QcFsJMLVUm
         xOcEl3WMoxXjaAdu7K4r2shfJsjBSZWlHZ6Rg=
Received: by 10.86.49.13 with SMTP id w13mr2483009fgw.65.1214604439949;
        Fri, 27 Jun 2008 15:07:19 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d6sm3751880fga.2.2008.06.27.15.07.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86647>

Class represents result of push operation. In addition to the data
provided by OperationResult it also holds information about remote
refs updates.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/PushResult.java |   84 ++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java
new file mode 100644
index 0000000..11e5928
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PushResult.java
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ * 
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.util.Collection;
+import java.util.Collections;
+import java.util.Map;
+
+/**
+ * Result of push operation to the remote repository. Holding information of
+ * {@link OperationResult} and remote refs updates status.
+ * 
+ * @see Transport#push(org.spearce.jgit.lib.ProgressMonitor, Collection)
+ */
+public class PushResult extends OperationResult {
+	private Map<String, RemoteRefUpdate> remoteUpdates = Collections.emptyMap();
+
+	/**
+	 * Get status of remote refs updates. Together with
+	 * {@link #getAdvertisedRefs()} it provides full description/status of each
+	 * ref update.
+	 * <p>
+	 * Returned collection is not sorted in any order.
+	 * </p>
+	 * 
+	 * @return collection of remote refs updates
+	 */
+	public Collection<RemoteRefUpdate> getRemoteUpdates() {
+		return Collections.unmodifiableCollection(remoteUpdates.values());
+	}
+
+	/**
+	 * Get status of specific remote ref update by remote ref name. Together
+	 * with {@link #getAdvertisedRef(String)} it provide full description/status
+	 * of this ref update.
+	 * 
+	 * @param refName
+	 *            remote ref name
+	 * @return status of remote ref update
+	 */
+	public RemoteRefUpdate getRemoteUpdate(final String refName) {
+		return remoteUpdates.get(refName);
+	}
+
+	protected void setRemoteUpdates(
+			final Map<String, RemoteRefUpdate> remoteUpdates) {
+		this.remoteUpdates = remoteUpdates;
+	}
+}
-- 
1.5.5.3
