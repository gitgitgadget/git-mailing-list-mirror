From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-gui: try to provide a window icon under X
Date: Sun, 16 Nov 2008 03:42:32 +0100
Message-ID: <1226803352-26513-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226801378-25501-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Alexander Gavrilov <angavrilov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 03:43:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Xbt-0003KR-8w
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 03:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbYKPCmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 21:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbYKPCmV
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 21:42:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:14421 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbYKPCmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 21:42:21 -0500
Received: by nf-out-0910.google.com with SMTP id d3so955601nfc.21
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 18:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=B99/I3IK3WjKqY1AgFtWwwhKAuM0zTqAhBkZUVWwh4A=;
        b=XfPB/I5rqgprdWaTLgc9urbbHBavfr5PTe06FZ+jbbNwcbyNJAOpygTU1QUzF0tj8S
         +EMbfnuOA57xj3lsXgvhuJ40RGEK7HFYC4mSEOQcDhszuOeBo+StgfXfSu2cfucqqMpK
         pF3M+UeVh0SjeyCK6XK+b8iANhCcC8wW0jcp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tcwfrtcpO0YBqm3iisZszPTgUWYa5V58TzkF2M6cnuPfNEAmVPjDV1IeHE0Hy9Z02K
         zmNupvtLuJxzVexHtAoTlA4LbNu8tMhhBGw/y8OeTN6w4l63jCiVs7KIpPbz92KnTcfK
         zHKSYglq/CiXmsdoH5f/s6mDF+TqW3yZ0wSIk=
Received: by 10.210.21.6 with SMTP id 6mr2666291ebu.18.1226803339385;
        Sat, 15 Nov 2008 18:42:19 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id 5sm1700338eyh.2.2008.11.15.18.42.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 18:42:18 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226801378-25501-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101114>

When running under X, we try to set up a window icon by providing a
hand-crafted 16x16 Tk photo image equivalent to the .ico. Wrap in a
catch because the earlier Tcl/Tk 8.4 releases didn't provide the 'wm
iconphoto' command.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Resend, forgot the signed-off line

 git-gui/git-gui.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index cf9ef6e..6ed6230 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -597,6 +597,28 @@ if {[is_Windows]} {
 	if {![info exists env(DISPLAY)]} {
 		set env(DISPLAY) :9999
 	}
+} else {
+	catch {
+		image create photo gitlogo -width 16 -height 16
+
+		gitlogo put #33CC33 -to  7  0  9  2
+		gitlogo put #33CC33 -to  4  2 12  4
+		gitlogo put #33CC33 -to  7  4  9  6
+		gitlogo put #CC3333 -to  4  6 12  8
+		gitlogo put gray26  -to  4  9  6 10
+		gitlogo put gray26  -to  3 10  6 12
+		gitlogo put gray26  -to  8  9 13 11
+		gitlogo put gray26  -to  8 11 10 12
+		gitlogo put gray26  -to 11 11 13 14
+		gitlogo put gray26  -to  3 12  5 14
+		gitlogo put gray26  -to  5 13
+		gitlogo put gray26  -to 10 13
+		gitlogo put gray26  -to  4 14 12 15
+		gitlogo put gray26  -to  5 15 11 16
+		gitlogo redither
+
+		wm iconphoto . -default gitlogo
+	}
 }
 
 ######################################################################
-- 
1.5.6.5
