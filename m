From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-gui: add a part about format strings in po/README
Date: Sun, 3 Aug 2008 13:12:14 +0200
Message-ID: <200808031312.14804.barra_cuda@katamail.com>
References: <20080803121131.589e672b@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 13:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPbPy-0004Z6-96
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 13:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbYHCLFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 07:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYHCLFT
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 07:05:19 -0400
Received: from smtp.katamail.com ([62.149.157.154]:43450 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751472AbYHCLFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 07:05:17 -0400
Received: (qmail 11132 invoked by uid 89); 3 Aug 2008 11:05:13 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host101-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.101)
  by smtp2-pc with SMTP; 3 Aug 2008 11:05:12 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <20080803121131.589e672b@paolo-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91226>

This should help tranlators that need to reorder words and strings.
Original explanation by Christian Stimming.

Also remove unneeded backslashes.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

On Sunday 03 August 2008, Paolo Ciarrocchi wrote:
> Shawn,
> a simple make in the git-gui-i18n repository fails with the following msg:
> paolo@paolo-desktop:~/git-gui-i18n$ make
> GITGUI_VERSION = 0.9.GITGUI-dirty
>     * new locations or Tcl/Tk interpreter
>     GEN git-gui
>     INDEX lib/
>     MSGFMT    po/bg.msg 391 translated.
>     MSGFMT    po/de.msg 383 translated, 5 fuzzy, 3 untranslated.
>     MSGFMT    po/es.msg 122 translated, 269 untranslated.
>     MSGFMT    po/fr.msg 391 translated.
>     MSGFMT    po/hu.msg 391 translated.
>     MSGFMT    po/it.msg make: *** [po/it.msg] Error 1
> 
> Before and after the following patch :-)

I think that's this commit: c6fb29db5a50df150280b641d3c2a6703589b529
(Fixed usage of positional parameters in it.po and ja.po).
It didn't fix anything and was harmful instead.

Maybe this patch could be useful.

 po/README |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/po/README b/po/README
index 5e77a7d..595bbf5 100644
--- a/po/README
+++ b/po/README
@@ -101,7 +101,7 @@ matching msgid lines.  A few tips:
    "printf()"-like functions.  Make sure "%s", "%d", and "%%" in your
    translated messages match the original.
 
-   When you have to change the order of words, you can add "<number>\$"
+   When you have to change the order of words, you can add "<number>$"
    between '%' and the conversion ('s', 'd', etc.) to say "<number>-th
    parameter to the format string is used at this point".  For example,
    if the original message is like this:
@@ -111,12 +111,17 @@ matching msgid lines.  A few tips:
    and if for whatever reason your translation needs to say weight first
    and then length, you can say something like:
 
-	"WEIGHT IS %2\$d, LENGTH IS %1\$d"
+	"WEIGHT IS %2$d, LENGTH IS %1$d"
 
-   The reason you need a backslash before dollar sign is because
-   this is a double quoted string in Tcl language, and without
-   it the letter introduces a variable interpolation, which you
-   do not want here.
+   A format specification with a '*' (asterisk) refers to *two* arguments
+   instead of one, hence the succeeding argument number is two higher
+   instead of one. So, a message like this
+
+	"%s ... %*i of %*i %s (%3i%%)"
+
+   is equivalent to
+
+	"%1$s ... %2$*i of %4$*i %6$s (%7$3i%%)"
 
  - A long message can be split across multiple lines by ending the
    string with a double quote, and starting another string on the next
-- 
1.6.0.rc1
