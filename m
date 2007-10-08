From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/6] Allow caller to customize title of error/warning
	message
Date: Mon, 08 Oct 2007 10:55:12 +0200
Message-ID: <20071008085512.9734.33911.stgit@yoghurt>
References: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoQ6-0003VA-3U
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbXJHIz3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbXJHIz2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:55:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2221 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbXJHIz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:55:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IeoOP-00024e-00; Mon, 08 Oct 2007 09:55:13 +0100
In-Reply-To: <20071008085430.9734.75797.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60302>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/out.py |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/stgit/out.py b/stgit/out.py
index 3464175..d3c86b4 100644
--- a/stgit/out.py
+++ b/stgit/out.py
@@ -85,12 +85,12 @@ class MessagePrinter(object):
     def info(self, *msgs):
         for msg in msgs:
             self.__out.single_line(msg)
-    def note(self, *msgs):
-        self.__out.tagged_lines('Notice', msgs)
-    def warn(self, *msgs):
-        self.__err.tagged_lines('Warning', msgs)
-    def error(self, *msgs):
-        self.__err.tagged_lines('Error', msgs)
+    def note(self, *msgs, **kw):
+        self.__out.tagged_lines(kw.get('title', 'Notice'), msgs)
+    def warn(self, *msgs, **kw):
+        self.__err.tagged_lines(kw.get('title', 'Warning'), msgs)
+    def error(self, *msgs, **kw):
+        self.__err.tagged_lines(kw.get('title', 'Error'), msgs)
     def start(self, msg):
         """Start a long-running operation."""
         self.__out.single_line('%s ... ' % msg, print_newline =3D Fals=
e)
