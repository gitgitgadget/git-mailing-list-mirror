From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Simplify editor selection logic
Date: Tue, 29 Jan 2008 04:04:57 +0100
Message-ID: <20080129030349.926.45486.stgit@yoghurt>
References: <20080129030059.926.29897.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgnP-0004MM-7U
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbYA2DFB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbYA2DFB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:05:01 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1928 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbYA2DFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:05:00 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgmO-0000Xy-00; Tue, 29 Jan 2008 03:04:56 +0000
In-Reply-To: <20080129030059.926.29897.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71931>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

There are a few other env variables we might like to look at, like
VISUAL. And isn't there a git-specific variable too?

 stgit/utils.py |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)


diff --git a/stgit/utils.py b/stgit/utils.py
index 00776b0..43366c9 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -175,12 +175,8 @@ def call_editor(filename):
=20
     # the editor
     editor =3D config.get('stgit.editor')
-    if editor:
-        pass
-    elif 'EDITOR' in os.environ:
-        editor =3D os.environ['EDITOR']
-    else:
-        editor =3D 'vi'
+    if not editor:
+        editor =3D os.environ.get('EDITOR', 'vi')
     editor +=3D ' %s' % filename
=20
     out.start('Invoking the editor: "%s"' % editor)
