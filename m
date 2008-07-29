From: "Murphy, John" <john.murphy@bankofamerica.com>
Subject: RE: [PATCH] git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
Date: Tue, 29 Jul 2008 08:40:16 -0400
Message-ID: <80915B5E107BED488500050294C6F48712137A@ex2k.bankofamerica.com>
References: <80915B5E107BED488500050294C6F48712136B@ex2k.bankofamerica.com>
 <20080724132853.GA25313@toroid.org> <20080725220544.GD23202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: spearce@spearce.org, Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:41:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNoW5-00030S-Re
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYG2MkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYG2MkZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:40:25 -0400
Received: from vamx04.bankofamerica.com ([171.159.192.80]:33571 "EHLO
	vadmzmailmx04.bankofamerica.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214AbYG2MkY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 08:40:24 -0400
Received: from vadmzmailmx01.bankofamerica.com ([171.182.200.78])
	by vadmzmailmx04.bankofamerica.com (8.13.6/8.13.6) with ESMTP id m6TCeKWJ029095;
	Tue, 29 Jul 2008 12:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1217335220; bh=BY2w7S9wuu1Xo962/vsKDIQzmBGAzHZgRc3wIpbjC
	4I=; h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
	 X-MIMEOLE:Content-type:Content-transfer-encoding:Content-class:
	 Thread-topic:Thread-index:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 References:X-OriginalArrivalTime:X-Proofpoint-Virus-Version; b=Ufw
	ax81z8pTa4IL9Dnep5laZ7SdiaXP16weDNs+G3XWcn1JdXIEFdzKvsB1DUDcZG6XgyB
	sBR9M0h2SjyEIoiaW30il5izrNMoyAeRUDnVvIgBOjRC5ELcaOeFALDQ10+ZVB99/Pp
	AJQZcQ1DRHr4f9Rlu7/shEzYpzGGK11o8M=
Received: from memva2mta03.bankofamerica.com (memva2mta03.bankofamerica.com [171.186.140.81])
	by vadmzmailmx01.bankofamerica.com (8.13.6/8.13.6) with ESMTP id m6TCeDfx025466;
	Tue, 29 Jul 2008 12:40:19 GMT
In-reply-to: <20080725220544.GD23202@spearce.org>
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-topic: [PATCH] git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
Thread-index: AcjuopotNR9rMnzGQU6ah8+V0Afw0gCSrk5Q
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 29 Jul 2008 12:40:17.0618 (UTC) FILETIME=[416E5B20:01C8F178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-07-29_04:2008-07-24,2008-07-29,2008-07-29 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90627>

I have rebuilt git-gui with version 0.10.2.18.gc629 it is still not finding gitk.
I have done some debugging in proc _which
I have found the issue is with the following line:

set p [file join $p $what$_search_exe]

The variable $p = gitk.exe

And there is no such animal

When I copy gitk to gitk.exe in /usr/local/git/bin, it works fine.

So, not sure if this is a git issue or a git-gui issue.

-John 
-----Original Message-----
From: spearce@spearce.org [mailto:spearce@spearce.org] 
Sent: Friday, July 25, 2008 6:06 PM
To: Abhijit Menon-Sen
Cc: Murphy, John; git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core

Abhijit Menon-Sen <ams@toroid.org> wrote:
> At 2008-07-24 09:01:48 -0400, john.murphy@bankofamerica.com wrote:
> >
> > I presume this was just an oversight when git- commands were removed
> > from the bin directory.
> 
> Looks like it. The following patch fixes it for me. Does it work for
> you on Windows?

Thanks.

This patch is obviously correct on any platform except Mac OS X.
On Mac OS X it gets confusing because [info nameofexecutable] is
a wrapper .app which loads its own main script.  That main script
needs to use the gitk location it receives from git-gui, and not
the location it computes from gitexecdir.  So I'm following up
your patch with this:

diff --git a/macosx/AppMain.tcl b/macosx/AppMain.tcl
index 41ca08e..ddbe633 100644
--- a/macosx/AppMain.tcl
+++ b/macosx/AppMain.tcl
@@ -7,7 +7,7 @@ if {[string first -psn [lindex $argv 0]] == 0} {
 }
 
 if {[file tail [lindex $argv 0]] eq {gitk}} {
-	set argv0 [file join $gitexecdir gitk]
+	set argv0 [lindex $argv 0]
 	set AppMain_source $argv0
 } else {
 	set argv0 [file join $gitexecdir [file tail [lindex $argv 0]]]
 
-- 
Shawn.
