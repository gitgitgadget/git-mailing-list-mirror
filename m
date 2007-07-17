From: Mark Levedahl <mlevedahl@gmail.com>
Subject: (no subject)
Date: Tue, 17 Jul 2007 18:39:05 -0400
Message-ID: <469D4509.1020806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: paulus@samba.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 00:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAvhP-0001Ha-Pt
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 00:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759390AbXGQWjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 18:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758480AbXGQWjK
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 18:39:10 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:31725 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754AbXGQWjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 18:39:08 -0400
Received: by an-out-0708.google.com with SMTP id d31so337076and
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 15:39:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=tjacHxGlEtimMyhFJ+KFsNYNJ4EEwDFWjsb43HYIVwf+sa2pCsQsTfa49VlP2qnK++yugp1aG3U8MEi4cSzs6/YD9weh6Bx8S93S2fMKeE3xlq+PRpSZoelXFrkKKfqKCfFLCpuEpHeGJ8iwPnN5N2/06desp7zwaChIOq6py64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=U3aUxJ3tCRp+joJMTVtWnaWgxOECdRx4sqkmO8YLFYiBy24OHvJXoenFQNOa683O0+rrisQh6kLSGzp3Vc6F4BIiG1TVrZYnSf1kUkYfYKdRV1mwDQv4kmPCmYVVEzJ6bAWsEEffq+uaXhpfuZpk5a80CLv6ktNf8KqwjOn7hO4=
Received: by 10.100.141.13 with SMTP id o13mr620203and.1184711948101;
        Tue, 17 Jul 2007 15:39:08 -0700 (PDT)
Received: from ?192.168.100.117? ( [72.66.124.87])
        by mx.google.com with ESMTPS id 32sm318730wri.2007.07.17.15.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jul 2007 15:39:07 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52807>

 From 567906ddb2fbbcf07325acc2808346ad6a472df1 Mon Sep 17 00:00:00 2001
From: Mark Levedahl <mdl123@verizon.net>
Date: Tue, 17 Jul 2007 18:35:46 -0400
Subject: [PATCH] gitk - Ignore ctrl-z as EOF on windows
To:        mlevedahl@verizon.net
-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
Cygwin's Tcl is configured to honor any occurence of ctrl-z as an
end-of-file marker, while some commits in the git repository and possibly
elsewhere include that character in the commit comment. This causes gitk
ignore commit history following such a comment and incorrect graphs. This
change affects only Windows as Tcl on other platforms already has
eofchar == {}. This fixes problems noted by me and by Ray Lehtiniemi, and
the fix was suggested by Shawn Pierce.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 39e452a..238607e 100755
--- a/gitk
+++ b/gitk
@@ -101,7 +101,7 @@ proc start_rev_list {view} {
     set commfd($view) $fd
     set leftover($view) {}
     set lookingforhead $showlocalchanges
-    fconfigure $fd -blocking 0 -translation lf
+    fconfigure $fd -blocking 0 -translation lf -eofchar {}
     if {$tclencoding != {}} {
     fconfigure $fd -encoding $tclencoding
     }
--
1.5.3.rc2.5.g66bbd
