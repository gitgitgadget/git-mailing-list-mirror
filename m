From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/4] Read default diff options from the user's config
Date: Thu, 24 Jan 2008 09:08:21 +0100
Message-ID: <20080124080810.25525.82689.stgit@yoghurt>
References: <20080124075935.25525.24416.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 09:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHx8y-00063U-Cu
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYAXIIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 03:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbYAXIIe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:08:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4378 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbYAXIId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:08:33 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JHx8H-0005LM-00; Thu, 24 Jan 2008 08:08:21 +0000
In-Reply-To: <20080124075935.25525.24416.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71603>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 examples/gitconfig |    4 ++++
 stgit/utils.py     |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)


diff --git a/examples/gitconfig b/examples/gitconfig
index cd9b569..c16f786 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -95,6 +95,10 @@
 	# The maximum length of an automatically generated patch name
 	#namelenth =3D 30
=20
+	# Extra options to pass to "git diff" (extend/override with
+	# -O/--diff-opts). For example, -M turns on rename detection.
+	#diff-opts =3D -M
+
 [mail "alias"]
 	# E-mail aliases used with the 'mail' command
 	git =3D git@vger.kernel.org
diff --git a/stgit/utils.py b/stgit/utils.py
index 00776b0..69203dc 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -320,7 +320,8 @@ def make_diff_opts_option():
         else:
             parser.values.diff_flags =3D []
     return [optparse.make_option(
-        '-O', '--diff-opts', dest =3D 'diff_flags', default =3D [],
+        '-O', '--diff-opts', dest =3D 'diff_flags',
+        default =3D (config.get('stgit.diff-opts') or '').split(),
         action =3D 'callback', callback =3D diff_opts_callback,
         type =3D 'string', metavar =3D 'OPTIONS',
         help =3D 'extra options to pass to "git diff"')]
