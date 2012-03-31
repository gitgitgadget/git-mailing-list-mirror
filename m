From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] var doc: default editor and pager are configurable at
 build time
Date: Sat, 31 Mar 2012 03:42:34 -0500
Message-ID: <20120331084234.GD4119@burratino>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
 <7v398qq1ei.fsf@alter.siamese.dyndns.org>
 <20120331084015.GC4119@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rodrigo Silva (MestreLion)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 10:42:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDttY-0002av-0P
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 10:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab2CaImn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 04:42:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38294 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab2CaImi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 04:42:38 -0400
Received: by iagz16 with SMTP id z16so1964112iag.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dpm8bdTK9TG+BSJToGtOEPBH1nfEF2B03hRzaLsm+EY=;
        b=WzuXWFu5S8QoDwme2tnMULZC0Rtb/emy8oxTp4lxCbaSg8nHVfPkKNEdPMZVIH1gTw
         9sZy66eh1vDaWDQNFBTizqzib+4+Bghi7X29AlwZFclcVd+3l+4fLHYC4fTV1dKZgT4j
         gtJ1AmYD3m2oejmCfWZJOjlViTPArGQaDRga+n8384fXXAnkc5v04NcXWsrdm+qINtnW
         zrsdfmAxQ2PzFvmRfyJa/w4bLkDNoo1j8pe/UWK7nF26sQEQzPSpv1t7s5faRd2ZB14a
         RDsUKRvBSu7f/AUjyc2Y3hxg7AlxKzKneBWOIforLDTPFXvhWjyXUSKyrdf9E0OtRxE8
         QZOw==
Received: by 10.42.180.66 with SMTP id bt2mr681468icb.56.1333183358159;
        Sat, 31 Mar 2012 01:42:38 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wh1sm4875567igb.11.2012.03.31.01.42.37
        (version=SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 01:42:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120331084015.GC4119@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194439>

Some distributors customize the fallback pager and editor used by git
commands when the user has not indicated a preference via the
core.editor/core.pager configuration or GIT_EDITOR, GIT_PAGER, VISUAL,
EDITOR, and PAGER environment variables, and git's build system
provides DEFAULT_PAGER and DEFAULT_EDITOR makefile settings to help
them with that (see v1.6.6-rc0~24, 2009-11-20).

Unfortunately those compile-time settings do not affect the
documentation, so the uninitiated user who tries to understand git by
reading the git-var(1) manpage can easily be confused when git falls
back to 'nano' and 'more' instead of 'vi' and 'less'.  Even if the
distributor patches the distributed docs to reflect the new default,
the user may read the official documentation from the git-htmldocs
repository online and be confused in the same way.

Add a few words stating that the defaults are customizable at
compile time to make the behavior crystal clear.

Reported-by: Rodrigo Silva (MestreLion) <linux@rodrigosilva.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-var.txt |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 5317cc24..beef9e28 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -43,13 +43,15 @@ GIT_EDITOR::
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
     --nofork`.  The order of preference is the `$GIT_EDITOR`
     environment variable, then `core.editor` configuration, then
-    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
+    `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
+    time, which is usually 'vi'.
 
 GIT_PAGER::
     Text viewer for use by git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
     is the `$GIT_PAGER` environment variable, then `core.pager`
-    configuration, then `$PAGER`, and then finally 'less'.
+    configuration, then `$PAGER`, and then the default chosen at
+    compile time (usually 'less').
 
 Diagnostics
 -----------
-- 
1.7.10.rc3
