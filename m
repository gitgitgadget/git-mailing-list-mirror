From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI MSYSGIT FIX)] git-gui: Fix string escaping in po2msg.sh
Date: Sun, 31 Aug 2008 01:12:26 +0400
Organization: TEPKOM
Message-ID: <200808310112.26506.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo8-00089f-7e
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbYH3VOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755040AbYH3VOm
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:42 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:58555 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbYH3VOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883439fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=h+YS+L078OiVgn7+lwa5XejqqKCeLoYWQP6TpQkr6kc=;
        b=l2/V9NaDqxxvtor8AIl/n9eT2anaxjujBJfYvR/ZPEifkjARlwmtl/fMevJuGFfied
         d+0zrzogmkCKrkU2v51xlbNbZ4GoNHcTQYyH9TqvPDZeI9IQdbc4yB53rCEZIJYJAbfR
         KdlQFY/PLMytbCBz4HTY3GX8X6+JhojJCx1CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=hw8UU4VD6aZsK/ig81QSgaT9yJBauhoJe/nqdJFehn7pKw8nTBAGecG6L27DtuN0ak
         /luGVg+JAzGwIjKbZsKkCM6wi91wP8rc66eONwCBhUOX76sdWQckabwl5hFK3yBMydy1
         WVOXplFyAaRL7bdnrYniwaWrNn9ECdv6y5G2M=
Received: by 10.181.36.9 with SMTP id o9mr4078887bkj.89.1220130873951;
        Sat, 30 Aug 2008 14:14:33 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:32 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94430>

Escape '$', because otherwise git-gui crashes while
trying to load malformed Japanese localization strings.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 po/po2msg.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/po2msg.sh b/po/po2msg.sh
index b7c4bf3..1e9f992 100644
--- a/po/po2msg.sh
+++ b/po/po2msg.sh
@@ -11,8 +11,8 @@ proc u2a {s} {
 	foreach i [split $s ""] {
 		scan $i %c c
 		if {$c<128} {
-			# escape '[', '\' and ']'
-			if {$c == 0x5b || $c == 0x5d} {
+			# escape '[', '\', '$' and ']'
+			if {$c == 0x5b || $c == 0x5d || $c == 0x24} {
 				append res "\\"
 			}
 			append res $i
-- 
1.6.0.20.g6148bc
