From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] fix git-p4 editor invocation
Date: Fri, 22 Jan 2010 00:55:15 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001220052140.1726@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 06:55:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYCUN-0007xt-BV
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 06:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab0AVFzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 00:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266Ab0AVFzR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 00:55:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45610 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0AVFzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 00:55:16 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KWM005YKWG3QM10@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Jan 2010 00:55:15 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137739>

The strip() is required to remove the trailing newline character,
as already done elsewhere.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 48059d0..d1512e0 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -732,7 +732,7 @@ class P4Submit(Command):
             if os.environ.has_key("P4EDITOR"):
                 editor = os.environ.get("P4EDITOR")
             else:
-                editor = read_pipe("git var GIT_EDITOR")
+                editor = read_pipe("git var GIT_EDITOR").strip()
             system(editor + " " + fileName)
 
             response = "y"
