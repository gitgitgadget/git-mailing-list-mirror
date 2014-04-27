From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 2/5] test: add test_write_lines helper
Date: Sun, 27 Apr 2014 21:15:47 +0300
Message-ID: <1398622524-26207-2-git-send-email-mst@redhat.com>
References: <1398622524-26207-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:16:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTcR-0000HU-1K
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbaD0SP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:15:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15960 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbaD0SPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:15:09 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIF0ME005916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Apr 2014 14:15:00 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3RIEvRY024367;
	Sun, 27 Apr 2014 14:14:58 -0400
Content-Disposition: inline
In-Reply-To: <1398622524-26207-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247213>

API and implementation as suggested by Junio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/README                | 22 ++++++++++++++++++++++
 t/test-lib-functions.sh |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/t/README b/t/README
index caeeb9d..2d6232f 100644
--- a/t/README
+++ b/t/README
@@ -596,6 +596,28 @@ library for your script to use.
 		...
 	'
 
+ - test_write_lines <text>
+
+   Split <text> to white-space separated words and write it out on standard
+   output, one word per line.
+   Useful to prepare multi-line files in a compact form.
+
+   Example:
+
+	test_write_lines "a b c d e f g" >foo
+
+   Is a more compact equivalent of:
+	cat >foo <<-EOF
+	a
+	b
+	c
+	d
+	e
+	f
+	g
+	EOF
+
+
  - test_pause
 
 	This command is useful for writing and debugging tests and must be
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 158e10a..f581535 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -717,6 +717,11 @@ test_ln_s_add () {
 	fi
 }
 
+# This function writes out its parameters, one per line
+test_write_lines () {
+	printf "%s\n" "$@"
+}
+
 perl () {
 	command "$PERL_PATH" "$@"
 }
-- 
MST
