From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] git-gui: Request blame metadata in utf-8.
Date: Sun, 9 Nov 2008 18:53:09 +0300
Organization: HOME
Message-ID: <200811091853.09498.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 16:56:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzCeK-0001zi-8h
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 16:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbYKIPzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 10:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbYKIPzN
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 10:55:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:20427 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbYKIPzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 10:55:11 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1881499fgg.17
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UF5G/XKskWIHavB6VFarNQxz3R+uc3G+82stj0Wl8hk=;
        b=M56KmfLuIYKGZXS018LVF9jm/T1MzmKKcxZZSG6izv2lLgEiOGK/RfMq7QQlV/sSZv
         O+OYrMuvbFW6a0oVX6h3yt54+4JktTL8DH+T63Uv/k+4ghqmfaA1wjeMYMCIkg5U0+k9
         wn0k03DyZIOaXYaNjR6ianpUSONCnvqcG9HlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=ndjy/tNQ6KPgUy1yp4sC+BY+v+UNCb0ghuxcgsQRZrtnLNNbdrIdXKxeDo2X0GQxHR
         vhAzF7q1QWdmETecb2hgMKmN7XSe+5RcCYA23rVIJEgaMMO7jGBgQTlbB/KyaOIp7yPp
         g3g+O60nX3am9kZo5FR3G8oAEupgVeSgto3MA=
Received: by 10.181.229.7 with SMTP id g7mr1768440bkr.135.1226246109696;
        Sun, 09 Nov 2008 07:55:09 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8644112fks.6.2008.11.09.07.55.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 07:55:08 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100453>

The blame builtin now supports automatic conversion of
metadata encoding. By default it is converted to the
character set specified by i18n.logoutputencoding.

Since gui blame expects the data in utf-8, it is
necessary to specify the desired encoding directly.
An old version of the blame command will simply
ignore the option.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/blame.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 8d60f12..4875804 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -559,7 +559,7 @@ method _read_file {fd jump} {
 } ifdeleted { catch {close $fd} }
 
 method _exec_blame {cur_w cur_d options cur_s} {
-	lappend options --incremental
+	lappend options --incremental --encoding=utf-8
 	if {$commit eq {}} {
 		lappend options --contents $path
 	} else {
-- 
1.6.0.3.15.gb8d36
