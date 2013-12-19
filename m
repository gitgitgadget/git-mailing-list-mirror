From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: Fix typo in proc blobdiffmaybeseehere
Date: Thu, 19 Dec 2013 08:14:00 +0100
Message-ID: <52B29CB8.8090304@viscovery.net>
References: <52AF0688.3070104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 19 08:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtXoN-0007RI-Ud
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 08:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab3LSHOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 02:14:09 -0500
Received: from so.liwest.at ([212.33.55.18]:60083 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab3LSHOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 02:14:08 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VtXo1-0006Zh-HE; Thu, 19 Dec 2013 08:14:01 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 18BAD16613;
	Thu, 19 Dec 2013 08:14:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52AF0688.3070104@viscovery.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239516>

From: Johannes Sixt <j6t@kdbg.org>

The recent 5de460a2 (Refactor per-line part of getblobdiffline and its
support) introduced blobdiffmaybeseehere, and accidentally forgot the '$'
to access the parameter as a TCL variable. This resulted in a failing
"Back" button with the error

can't use non-numeric string as operand of "!"
    while executing
"if {!$ateof} {
	set nlines [expr {[winfo height $ctext]
			  / [font metrics textfont -linespace]}]
	if {[$ctext compare "$target_scrollpos + $nlines ..."
    (procedure "maybe_scroll_ctext" line 5)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 12/16/2013 14:56, schrieb Johannes Sixt:
> To reproduce, start gitk in any repository, click a commit, then the
> "back" button (left-pointing arrow button) or type Alt+Cursor-Left. The
> error I get is this:
> 
> can't use non-numeric string as operand of "!"

It turns out to be just a simple typo.

-- Hannes

 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 33c3a6c..1f14796 100755
--- a/gitk
+++ b/gitk
@@ -7922,7 +7922,7 @@ proc blobdiffmaybeseehere {ateof} {
     if {$diffseehere >= 0} {
 	mark_ctext_line [lindex [split $diffseehere .] 0]
     }
-    maybe_scroll_ctext ateof
+    maybe_scroll_ctext $ateof
 }
 
 proc getblobdiffline {bdf ids} {
-- 
1.8.5.1.1587.g3845a3d
