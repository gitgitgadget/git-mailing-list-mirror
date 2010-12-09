From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 8/8] git-gui: handle meta diff header lines only in the header section
Date: Thu,  9 Dec 2010 21:47:59 +0100
Message-ID: <1917eb763e2d36b2d512608ca1546571c8d478ad.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
 <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
 <ae1d2af4dad878c54959a72989cb170376b7fb95.1291927657.git.bert.wesarg@googlemail.com>
 <cc7284fbd48c589af26dd8f3905fb4244fedbfda.1291927657.git.bert.wesarg@googlemail.com>
 <96986a5a805579d1e341fd0f5fa44ccf9b98b312.1291927657.git.bert.wesarg@googlemail.com>
 <83035737417287ef9f1ad246e269f0e31dbe5e03.1291927657.git.bert.wesarg@googlemail.com>
 <6581252c19fb2c89a7f2d3e77e62b32f689d5e38.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPr-0003RY-9q
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab0LIUsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:25 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:37856 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233Ab0LIUsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:24 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so3174895bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=atmAjvp7v95SLFVRVUntnX3JGlDEth4w7oKmx1cB4y8=;
        b=v696LdaLRwslthBBi7Tsfky1i5UXCZTAm/Mum4fR4E5ctNy6ETiOrRbVMCmDf6Ldrq
         Wo8fYUtaN0Gwq+n1SgNAADyPXm9K3ddkhoNfuGWJiM0uC8mI6LaQAmIn6qzWmaP44lmb
         WSH4qJKgudRfMVymijta20Q8QP7qtdmocgod8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P0PoFqtmee6drC+5vdAnNJ+XGvQaCyOzKSl95NtUKwREs7+HuVDyxw00KUy8p4tKui
         /sDKGmyYpgVdc90/VG2ig2U4Sep6rNJlyDQpPGbsy27a3e5ZqA73h+tkSyKriuzH4mSt
         W98W/5/+2aAtybt4Yb4SerHt14rkw0XVlVrDQ=
Received: by 10.204.73.142 with SMTP id q14mr3863123bkj.195.1291927703518;
        Thu, 09 Dec 2010 12:48:23 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id a6sm9076fak.3.2010.12.09.12.48.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <6581252c19fb2c89a7f2d3e77e62b32f689d5e38.1291927657.git.bert.wesarg@googlemail.com>
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163316>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 4eaf7e7..cf8a95e 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -423,14 +423,9 @@ proc read_diff {fd conflict_size cont_info} {
 			# -- Name it symlink, not 120000
 			#    Note, that the original line is in $current_diff_header
 			regsub {^(deleted|new) file mode 120000} $line {\1 symlink} line
-		}
 
-		if {[string match {new file *} $line]
-			|| [regexp {^(old|new) mode *} $line]
-			|| [string match {deleted file *} $line]
-			|| [string match {deleted symlink} $line]
-			|| [string match {new symlink} $line]
-			|| $line eq {\ No newline at end of file}} {
+		} elseif {   $line eq {\ No newline at end of file}} {
+			# -- Handle some special lines
 		} elseif {$is_3way_diff} {
 			set op [string range $line 0 1]
 			switch -- $op {
-- 
1.7.3.2.1200.ge4bf6
