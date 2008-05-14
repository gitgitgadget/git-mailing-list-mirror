From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Import version to a separate namespace
Date: Wed, 14 May 2008 03:44:56 +0200
Message-ID: <20080514014450.7043.20656.stgit@yoghurt>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 03:45:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw63y-00045I-Kx
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbYENBpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 21:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbYENBpA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:45:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2539 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbYENBpA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 21:45:00 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jw636-0004hz-00; Wed, 14 May 2008 02:44:56 +0100
In-Reply-To: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.2.152.g77bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82061>

The set of names we need from the version module is about to get too
large to list explicitly, but we don't want to pollute the local
namespace with every name from version. So do a qualified import of
the module.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 setup.py |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/setup.py b/setup.py
index 3be087c..04ca821 100755
--- a/setup.py
+++ b/setup.py
@@ -3,7 +3,7 @@
 import sys, glob, os
 from distutils.core import setup
=20
-from stgit.version import version, git_min_ver, python_min_ver
+from stgit import version
 from stgit.run import Run
=20
 def __version_to_list(version):
@@ -29,18 +29,18 @@ def __check_python_version():
     """Check the minimum Python version
     """
     pyver =3D '.'.join(str(n) for n in sys.version_info)
-    if not __check_min_version(python_min_ver, pyver):
+    if not __check_min_version(version.python_min_ver, pyver):
         print >> sys.stderr, 'Python version %s or newer required. Fou=
nd %s' \
-              % (python_min_ver, pyver)
+              % (version.python_min_ver, pyver)
         sys.exit(1)
=20
 def __check_git_version():
     """Check the minimum GIT version
     """
     gitver =3D Run('git', '--version').output_one_line().split()[2]
-    if not __check_min_version(git_min_ver, gitver):
+    if not __check_min_version(version.git_min_ver, gitver):
         print >> sys.stderr, 'GIT version %s or newer required. Found =
%s' \
-              % (git_min_ver, gitver)
+              % (version.git_min_ver, gitver)
         sys.exit(1)
=20
 # Check the minimum versions required
@@ -52,7 +52,7 @@ if sys.argv[1] in ['install', 'build']:
 old_mask =3D os.umask(0022)
=20
 setup(name =3D 'stgit',
-      version =3D version,
+      version =3D version.version,
       license =3D 'GPLv2',
       author =3D 'Catalin Marinas',
       author_email =3D 'catalin.marinas@gmail.com',
