From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK)] gitk: Avoid handling the Return key twice in Add Branch.
Date: Thu, 13 Nov 2008 23:09:18 +0300
Organization: HOME
Message-ID: <200811132309.18520.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 21:17:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ida-00062k-6w
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYKMUQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbYKMUQn
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:16:43 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:39385 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbYKMUQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 15:16:42 -0500
Received: by fg-out-1718.google.com with SMTP id 19so870285fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LYtwick1DIDaA+iB8/iQ0EUQ8fgaRxNxpmqCkr4BFIo=;
        b=GjKP5mxnJXuXj5d4MItv43ZvijBiXQ5fhe12320EcbrY8x/b/vV8q/SW5qdeJMptbV
         Sg+oAQkP4hoknOz+0R+VBRiNRIMLmIu5w6gBprhA0w/FdfsCqXvqIpumdpVprcXRpahh
         xAt6EHrVYlcifDUM9SCsBtD29VQjz4JSYFH10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=hcoqC9S7ItVsX/6s6AyiK9wXbd9gaDIgsjF8qiwl9K9lKv8VbWg++q06WhXyHFkJ1z
         3KnUd+vtQaJ+aa8Ff3joCRgkuWDGX7gxRi1JjQI3dDC150g8P714es65VIGdzNIvTcS7
         BJSPq0icqt6fqLxciB/xnZD3L33D2HU/P2iZM=
Received: by 10.181.59.19 with SMTP id m19mr36212bkk.91.1226607078989;
        Thu, 13 Nov 2008 12:11:18 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id y15sm5329641fkd.17.2008.11.13.12.11.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 12:11:17 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100909>

This reverts commit 63767d5fb8fe236d8fdeba44297ac925701b27a0.

A similar change was made as part of commit 76f15947af7,
that added bindings to all dialogs, and this duplication
causes mkbrgo to be called twice, the second time after
the window has been destroyed. As a result, an error
window appears when the code tries to access widgets.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 3353f4a..46896a2 100755
--- a/gitk
+++ b/gitk
@@ -8208,7 +8208,6 @@ proc mkbranch {} {
     grid $top.id $top.sha1 -sticky w
     label $top.nlab -text [mc "Name:"]
     entry $top.name -width 40
-    bind $top.name <Key-Return> "[list mkbrgo $top]"
     grid $top.nlab $top.name -sticky w
     frame $top.buts
     button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top]
-- 
1.6.0.3.15.gb8d36
