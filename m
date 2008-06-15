From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 18/20] New CountingOutputStream class - stream decorator
Date: Sun, 15 Jun 2008 23:45:47 +0200
Message-ID: <1213566349-25395-19-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-11-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-12-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-13-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-14-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-15-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-16-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-17-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-18-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:49:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8061-00026j-N0
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYFOVr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbYFOVr7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:47:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:50674 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbYFOVr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:47:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3138098fgg.17
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BsTkhmzZgZa/+tR+hJytk8c3iKQf7PEvCMw7E9ev50U=;
        b=uc5DPKGNcL80IG247w3lFN/Z1D8EYeUuUtRenjaHZKoO85ABr3q/Ljxn4tahK9hpVi
         o/8npcSBqo6I1F21Q0XJp6IN3DcpNXsNbcu4I59JqHKA1fWlduUi+E1K6n41hCRj0XWa
         wjYivNO4vVFZRSVFF6ENCnTaBKX1qA7kv3+98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AsxGR1F8um5E1eO+uh5T5bx4DUw8ZEekIKJiL5pCHO7TYqXuPSE1RyuXQAT8rr9Yxt
         ieANDcin9SmcwAWCG3A0GyFhV4dsUvkosxb1RPa3qGrUMCMyc4kqUDUzJVDZkvsYxk/j
         IY9XFJ7CgWxjv+8eOcoaD/lZK8DYGfx/Z/JoI=
Received: by 10.86.82.16 with SMTP id f16mr7257858fgb.9.1213566473325;
        Sun, 15 Jun 2008 14:47:53 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 12sm10839394fgg.0.2008.06.15.14.47.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:47:52 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-18-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85143>

This decorator provides information about number of already written
bytes.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/util/CountingOutputStream.java    |   89 ++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
new file mode 100644
index 0000000..574bb96
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
@@ -0,0 +1,89 @@
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
+package org.spearce.jgit.util;
+
+import java.io.FilterOutputStream;
+import java.io.IOException;
+import java.io.OutputStream;
+
+/**
+ * Counting output stream decoration. Counts bytes written to stream.
+ */
+public class CountingOutputStream extends FilterOutputStream {
+
+	private int count;
+
+	/**
+	 * Create counting stream being decorated to provided real output stream.
+	 * 
+	 * @param out
+	 *            output stream where data should be written
+	 */
+	public CountingOutputStream(OutputStream out) {
+		super(out);
+	}
+
+	@Override
+	public void write(int b) throws IOException {
+		out.write(b);
+		count++;
+	}
+
+	@Override
+	public void write(byte[] b, int off, int len) throws IOException {
+		out.write(b, off, len);
+		count += len;
+	}
+
+	/**
+	 * Return number of already written bytes.
+	 * 
+	 * @return number of written bytes since last reset (object is reset upon
+	 *         creation)
+	 */
+	public int getCount() {
+		return count;
+	}
+
+	/**
+	 * Reset counter to zero value.
+	 */
+	public void reset() {
+		count = 0;
+	}
+}
-- 
1.5.5.1
