From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [Bug] Segfault in git status
Date: Thu, 21 Feb 2008 17:01:10 +0100
Message-ID: <D3C27E63-329D-4509-830A-099A7BCB72B7@ai.rug.nl>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Dane Jensen <careo@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSDsO-0000gX-DK
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933539AbYBUQBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759965AbYBUQBR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:01:17 -0500
Received: from smtp-2.orange.nl ([193.252.22.242]:12034 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934050AbYBUQBO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:01:14 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6101.orange.nl (SMTP Server) with ESMTP id 0DD141C0008D
	for <git@vger.kernel.org>; Thu, 21 Feb 2008 17:01:12 +0100 (CET)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6101.orange.nl (SMTP Server) with ESMTP id B9ECE1C00083;
	Thu, 21 Feb 2008 17:01:11 +0100 (CET)
X-ME-UUID: 20080221160111761.B9ECE1C00083@mwinf6101.orange.nl
In-Reply-To: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74624>


On Feb 18, 2008, at 9:36 AM, Dane Jensen wrote:

> Hi all-
>
> Somehow I've managed to create a repository that causes git status  
> to segfault. To be honest, I'm not entirely sure how just yet. This  
> comes after a weekend of splitting a repository into two separate  
> repositories, filtering out a directory from one, and then creating  
> grafts in those repositories to skip commits that now change nothing.

I have the same problem, also on OS X.

Vienna:Project pieter$ git --version
git version 1.5.4.2.263.g5729

which is 'next' + 2 patches

Vienna:Project pieter$ gdb --args git status
GNU gdb 6.3.50-20050815 (Apple version gdb-768) (Tue Oct  2 04:07:49  
UTC 2007)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and  
you are
welcome to change it and/or distribute copies of it under certain  
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for  
details.
This GDB was configured as "i386-apple-darwin"...Reading symbols for  
shared libraries ........ done

(gdb) r
Starting program: /opt/pieter/bin/git status
Reading symbols for shared libraries +++++++. done
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   Data/Metadata/redirects.xml
#	modified:   protege/ontologie.owl
#	modified:   protege/ontologie.pprj
#	modified:   protege/ontologie.repository
#	modified:   protege/swirl_data.owl
#	modified:   test-po2s.db
#	modified:   test-so2p.db
#	modified:   test-sp2o.db
#

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x004a2010
index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/ 
Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c:101
101			if (!(ce->ce_flags & CE_UNHASHED)) {
(gdb) print *ce
Cannot access memory at address 0x4a1fec

This happens in at least one repository, most others are just fine.

- Pieter
