From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] Fix git-archimport on empty summary
Date: Wed, 28 Feb 2007 08:03:04 +0100
Message-ID: <es39f9$sqh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 08:05:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMIsF-0003hs-5e
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 08:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXB1HFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 02:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbXB1HFL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 02:05:11 -0500
Received: from main.gmane.org ([80.91.229.2]:56259 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbXB1HFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 02:05:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HMIs2-0007iC-4w
	for git@vger.kernel.org; Wed, 28 Feb 2007 08:05:02 +0100
Received: from 213-140-22-65.fastres.net ([213.140.22.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 08:05:02 +0100
Received: from bonzini by 213-140-22-65.fastres.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 08:05:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-140-22-65.fastres.net
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40902>

I got this while importing bonzini@gnu.org--2004b/lightning--stable--1.2 
(archive available at 
http://www.inf.unisi.ch/phd/bonzini/webdav/bonzini@gnu.org--2004b via 
webdav).

The patch seems pretty obvious to me, and Martin Langhoff has already 
seen it in private e-mail.

Thanks,

Paolo

2007-02-27  Paolo Bonzini  <bonzini@gnu.org>

         * git-archimport (parselog): Cope with an empty summary.

--- /usr/bin/git-archimport     2007-01-09 21:15:39.000000000 +0100
+++ ./git-archimport    2007-02-27 14:28:33.000000000 +0100
@@ -780,7 +780,11 @@
      }

      # post-processing:
-    $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
+    if (defined $ps->{summary}) {
+        $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
+    } else {
+        $ps->{summary} = "\n";
+    }
      $ps->{message} = join("\n",@$log);

      # skip Arch control files, unescape pika-escaped files
