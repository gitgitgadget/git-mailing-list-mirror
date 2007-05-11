From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/5] Generate patch names of more uniform length
Date: Fri, 11 May 2007 03:40:10 +0200
Message-ID: <20070511014010.13161.42319.stgit@yoghurt>
References: <20070511013400.13161.9160.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 03:45:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKBw-00057b-4W
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbXEKBpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 21:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbXEKBpB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:45:01 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:33773 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754744AbXEKBpA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 21:45:00 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:58795 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HmKBn-0003vh-3v; Fri, 11 May 2007 03:44:59 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HmK78-0003TK-UM; Fri, 11 May 2007 03:40:11 +0200
In-Reply-To: <20070511013400.13161.9160.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HmKBn-0003vh-3v.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HmKBn-0003vh-3v d4f06ec792933b893d7544426282c941
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46923>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Cut the generated patch name at 30 characters after getting rid of
unwanted characters, not before. This gives patch names of more
uniform length, since consecutive unwanted characters were replaced by
a single dash.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/utils.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/stgit/utils.py b/stgit/utils.py
index 18198c0..3612a4b 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -175,13 +175,13 @@ def call_editor(filename):
=20
 def patch_name_from_msg(msg):
     """Return a string to be used as a patch name. This is generated
-    from the first 30 characters of the top line of the string passed
-    as argument."""
+    from the top line of the string passed as argument, and is at most
+    30 characters long."""
     if not msg:
         return None
=20
-    subject_line =3D msg[:30].lstrip().split('\n', 1)[0].lower()
-    return re.sub('[\W]+', '-', subject_line).strip('-')
+    subject_line =3D msg.split('\n', 1)[0].lstrip().lower()
+    return re.sub('[\W]+', '-', subject_line).strip('-')[:30]
=20
 def make_patch_name(msg, unacceptable, default_name =3D 'patch',
                     alternative =3D True):
