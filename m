From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: fix browsers [Up To Parent] in sub-sub-directories.
Date: Fri, 19 Nov 2010 21:43:48 +0100
Message-ID: <1290199429-30421-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 21:44:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJXoN-000394-55
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 21:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab0KSUny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 15:43:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38347 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab0KSUny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 15:43:54 -0500
Received: by fxm13 with SMTP id 13so1055554fxm.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fe/sUXHDU1Fm6SgOlSX4ji1iWdXywyonfOAT2/Eaz6c=;
        b=jUOFO2Fdlv/qKL6TsS9GRpBlXumNBNq32Ryzfz+3XUwitGlBs7FgY9J5xXe+yZY6QV
         7x9zxBFkgo/E2Fy1R9dXs50zsw5gvCElhY3THBCStRfPdlE296HzGBre+8YdAyUApMLf
         vi4NuCf4gy1sNrdi/Wpt7/UDGG+llP9lKwDKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qR1NuAPvkmfP39ZLUuZ5V1d/dlJ2QNAhRzETAQFMx7CdTX9nvBulk2jZ77/d+w6WRX
         zo9vXP3PjRc+RC80AwoVoDmzV4zKpoH/nYt1q9A/n3GXOJbFUloEV7rvq6YAMgWiTD9/
         cePznSn0x8AnVfHeATy70W/BWbNnNBWfwODbQ=
Received: by 10.223.114.135 with SMTP id e7mr1350745faq.78.1290199432686;
        Fri, 19 Nov 2010 12:43:52 -0800 (PST)
Received: from localhost (p3E9905AB.dip.t-dialin.net [62.153.5.171])
        by mx.google.com with ESMTPS id p18sm667949faa.40.2010.11.19.12.43.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 12:43:51 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161784>

browser_path used to end with a slash, so the regexp matches the empty string
and therefore removes nothing.

Fix this.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 git-gui/lib/browser.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/browser.tcl b/git-gui/lib/browser.tcl
index c241572..a8c6223 100644
--- a/git-gui/lib/browser.tcl
+++ b/git-gui/lib/browser.tcl
@@ -121,7 +121,7 @@ method _parent {} {
 		if {$browser_stack eq {}} {
 			regsub {:.*$} $browser_path {:} browser_path
 		} else {
-			regsub {/[^/]+$} $browser_path {} browser_path
+			regsub {/[^/]+/$} $browser_path {/} browser_path
 		}
 		set browser_status [mc "Loading %s..." $browser_path]
 		_ls $this [lindex $parent 0] [lindex $parent 1]
-- 
tg: (6f10c41..) bw/git-gui/fix-browser-up (depends on: master)
