From: "Mark E Mason" <mark.e.mason@broadcom.com>
Subject: RE: Fatal error from git bisect
Date: Thu, 9 Feb 2006 11:59:45 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D0773A4A8@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:02:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7HxW-0005SM-4T
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWBIUAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWBIUAA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:00:00 -0500
Received: from mms1.broadcom.com ([216.31.210.17]:6661 "EHLO mms1.broadcom.com")
	by vger.kernel.org with ESMTP id S1750740AbWBIUAA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 15:00:00 -0500
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Thu, 09 Feb 2006 11:59:51 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 A583A2AF; Thu, 9 Feb 2006 11:59:49 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 8FDA02AE; Thu, 9 Feb
 2006 11:59:49 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CWW47601; Thu, 9 Feb 2006 11:59:46 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 1C6D120501; Thu, 9 Feb 2006 11:59:46 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
Thread-Topic: Fatal error from git bisect
Thread-Index: AcYtsik1WcqUVTf0RburPSCjDh4RdAAAGqrw
To: "Linus Torvalds" <torvalds@osdl.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006020907; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230352E34334542394435462E303038322D412D;
 ENG=IBF; TS=20060209195955; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006020907_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FF540BD10G9378630-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15821>

Hello!
 
> From: Linus Torvalds [mailto:torvalds@osdl.org] 
[snip]
> On Thu, 9 Feb 2006, Mark E Mason wrote:
> >  
> > I'm trying to use 'git bisect' and am running into the 
> following error:
> >
> > fatal: Entry 'block/elevator.c' would be overwritten by 
> merge. Cannot merge.
> 
> This seems to mean that you have a dirty block/elevator.c 
> file. Have you perhaps edited it?

I thought of that, but even removing the workspace file doesn't get
around this:

[mason@hawaii linux.git]$ git bisect reset
[mason@hawaii linux.git]$ git bisect start
[mason@hawaii linux.git]$ git bisect good
d166b5a220813a08a79312fc384d11e1c57e9072
[mason@hawaii linux.git]$ git bisect bad
a7900c9bdb64c11688719bef9f6373fbc4c276ab
Bisecting: 116 revisions left to test after this
fatal: Entry 'block/elevator.c' would be overwritten by merge. Cannot
merge.
[mason@hawaii linux.git]$ rm block/elevator.c
[mason@hawaii linux.git]$ git bisect bad
a7900c9bdb64c11688719bef9f6373fbc4c276ab
Bisecting: 116 revisions left to test after this
fatal: Entry 'block/elevator.c' would be overwritten by merge. Cannot
merge.

I've made no commits to this tree - it's just an up-to-date pull of the
linux-mips.org tree.  I also have no local edits at this point.

[mason@hawaii linux.git]$ git diff
[mason@hawaii linux.git]$

What's puzzling me is that (as I understand it) git bisect simply
manipulates the workspace, not the repository.

Thanks!
Mark



 
