From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Documentation/gitignore.txt: Fix the seriously misleading priority explanation
Date: Sun, 22 Jul 2007 01:53:49 +0200
Organization: Organization?!?
Message-ID: <85wswtp8va.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 02:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICPWy-0003oX-KR
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 02:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXGVAmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbXGVAmH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 20:42:07 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:46212 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753287AbXGVAmE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 20:42:04 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 3D875336C2A
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 02:42:03 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 310E928EC28
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 02:42:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 0964A3425E2
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 02:42:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 046061D1E182; Sun, 22 Jul 2007 02:42:01 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3722/Sun Jul 22 01:57:48 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53206>



Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/gitignore.txt |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index ea79d74..9c83095 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -18,21 +18,26 @@ pattern.
 
 When deciding whether to ignore a path, git normally checks
 `gitignore` patterns from multiple sources, with the following
-order of precedence:
+order of precedence, from highest to lowest (within one level of
+precedence, the last matching pattern decides the outcome):
 
- * Patterns read from the file specified by the configuration
-   variable 'core.excludesfile'.
-
- * Patterns read from `$GIT_DIR/info/exclude`.
+ * Patterns read from the command line for those commands that support
+   them.
 
  * Patterns read from a `.gitignore` file in the same directory
-   as the path, or in any parent directory, ordered from the
-   deepest such file to a file in the root of the repository.
+   as the path, or in any parent directory, with patterns in the
+   higher level files (up to the root) being overriden by those in
+   lower level files down to the directory containing the file.
    These patterns match relative to the location of the
    `.gitignore` file.  A project normally includes such
    `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
 
+ * Patterns read from `$GIT_DIR/info/exclude`.
+
+ * Patterns read from the file specified by the configuration
+   variable 'core.excludesfile'.
+
 The underlying git plumbing tools, such as
 gitlink:git-ls-files[1] and gitlink:git-read-tree[1], read
 `gitignore` patterns specified by command-line options, or from
@@ -49,7 +54,8 @@ Patterns have the following format:
 
  - An optional prefix '!' which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again.
+   included again.  If a negated pattern matches, this will
+   override lower precedence patterns sources.
 
  - If the pattern does not contain a slash '/', git treats it as
    a shell glob pattern and checks for a match against the
-- 
1.5.2.3


-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
