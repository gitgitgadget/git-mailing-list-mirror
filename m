From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] setup.py: don't try to import stgit.run before the python version check
Date: Fri, 11 Jul 2008 22:09:32 +0200
Message-ID: <1215806972-18713-2-git-send-email-vmiklos@frugalware.org>
References: <1215806972-18713-1-git-send-email-vmiklos@frugalware.org>
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOwb-0000ey-Qw
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 22:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbYGKUJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755644AbYGKUJS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 16:09:18 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33545 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbYGKUJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 16:09:16 -0400
Received: from vmobile.example.net (dsl5401CCAB.pool.t-online.hu [84.1.204.171])
	by yugo.frugalware.org (Postfix) with ESMTP id 990F21DDC5C;
	Fri, 11 Jul 2008 22:09:14 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D05851A9909; Fri, 11 Jul 2008 22:09:32 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <1215806972-18713-1-git-send-email-vmiklos@frugalware.org>
In-Reply-To: <20080711200735.GK10347@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88168>

stgit.run would import datetime, which is not available in older python
versions. import it just after the version check passed.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 setup.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/setup.py b/setup.py
index 44cc6ea..a685cf6 100755
--- a/setup.py
+++ b/setup.py
@@ -4,7 +4,6 @@ import sys, glob, os
 from distutils.core import setup
 
 from stgit import version
-from stgit.run import Run
 
 def __version_to_list(version):
     """Convert a version string to a list of numbers or strings
@@ -68,6 +67,8 @@ if sys.argv[1] in ['install', 'build']:
     __check_python_version()
     __check_git_version()
 
+from stgit.run import Run
+
 # ensure readable template files
 old_mask = os.umask(0022)
 
-- 
1.5.6.2.450.g8d367.dirty
