From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] index-v4: document the entry format
Date: Fri, 27 Apr 2012 16:02:45 -0700
Message-ID: <xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
	<xmqqzk9w93zu.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 01:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNuBg-0002P9-Fj
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 01:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab2D0XCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 19:02:48 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:50013 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab2D0XCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 19:02:47 -0400
Received: by bkwj5 with SMTP id j5so60328bkw.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 16:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=VrmkKP37MZiWfKuhNEX0aiDi2TNQyTuvIm/vfRF+kd4=;
        b=LQJKkwsZL+ENnH9tpPUGQf/YI87+FH8488ZoKj+06dHhpWR9+DAXr5fzE8QdYQ4cvp
         54+/ZKD2OHEiWcheHle3xrr/mbhAgj5jKrWN9cY1hGxrmFnYmHgRF6SW1nAKYZCNwiJb
         Y8XA1D773216JP28PjKRMDg6CKneKDIgS8UVQhWD8Z2n1Rx0DRslB2l9ue9V9bEjCesl
         5o7I+v/rifEYvT+u2hSh0Lpa4tYjaJ4qC/evzVdeleBRqgFZzYohBwjdH6MfEvRiKWMN
         QoiTZRy6P5VvN37JAqGg4CrsOnUsUpQvaTn3KG0lxFw5r/2NPtVoVskaiY8ktKC432/R
         JVmw==
Received: by 10.213.35.77 with SMTP id o13mr756343ebd.4.1335567766529;
        Fri, 27 Apr 2012 16:02:46 -0700 (PDT)
Received: by 10.213.35.77 with SMTP id o13mr756336ebd.4.1335567766404;
        Fri, 27 Apr 2012 16:02:46 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si7627636een.0.2012.04.27.16.02.46
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 16:02:46 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 3977B5C0050;
	Fri, 27 Apr 2012 16:02:46 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 9D89AE125C; Fri, 27 Apr 2012 16:02:45 -0700 (PDT)
In-Reply-To: <xmqqzk9w93zu.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 27 Apr 2012 15:58:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmMjcWzWZPtDIZTxIZNrHWfYqlLB5X4+YjS1lj+dSRc0U0j9qBR7JFDKRtT6tFWPV2qdx1PVs62+H6O2KFxBy03XecEnGlmhN8xCJU7of55o5aC59ayRusaBcBKhfwVKkrqPFl41HErHtX0xaZ1ZqysHKFO5OwMXqKIYYZ+clpKHU8MXOU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196490>

Document the format so that others can learn from and build on top of
the series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/index-format.txt |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 8930b3f..9d25b30 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -113,9 +113,22 @@ GIT index format
     are encoded in 7-bit ASCII and the encoding cannot contain a NUL
     byte (iow, this is a UNIX pathname).
 
+  (Version 4) In version 4, the entry path name is prefix-compressed
+    relative to the path name for the previous entry (the very first
+    entry is encoded as if the path name for the previous entry is an
+    empty string).  At the beginning of an entry, an integer N in the
+    variable width encoding (the same encoding as the offset is encoded
+    for OFS_DELTA pack entries; see pack-format.txt) is stored, followed
+    by a NUL-terminated string S.  Removing N bytes from the end of the
+    path name for the previous entry, and replacing it with the string S
+    yields the path name for this entry.
+
   1-8 nul bytes as necessary to pad the entry to a multiple of eight bytes
   while keeping the name NUL-terminated.
 
+  (Version 4) In version 4, the padding after the pathname does not
+  exist.
+
 == Extensions
 
 === Cached tree
-- 
1.7.10.526.gb0571
