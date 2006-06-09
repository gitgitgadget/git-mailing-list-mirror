From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 15:11:42 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF410507957855@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 21:12:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FomP1-0005Oa-PC
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 21:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWFITMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 15:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWFITMM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 15:12:12 -0400
Received: from ahmler7.mail.eds.com ([192.85.154.81]:62400 "EHLO
	ahmler7.mail.eds.com") by vger.kernel.org with ESMTP
	id S1030410AbWFITMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 15:12:12 -0400
Received: from ahmlir4.mail.eds.com (ahmlir4-2.mail.eds.com [192.85.154.134])
	by ahmler7.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59JC56q027322;
	Fri, 9 Jun 2006 15:12:06 -0400
Received: from ahmlir4.mail.eds.com (localhost [127.0.0.1])
	by ahmlir4.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59JBCbP017500;
	Fri, 9 Jun 2006 15:11:12 -0400
Received: from usahm011.amer.corp.eds.com ([130.175.214.152])
	by ahmlir4.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59JBCN2017495;
	Fri, 9 Jun 2006 15:11:12 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm011.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Jun 2006 15:11:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-daemon messing up permissions for gitweb
Thread-Index: AcaL9/nDLOctQzc2RGaqo70T9kDZFgAACK5w
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 09 Jun 2006 19:11:43.0253 (UTC) FILETIME=[8B571C50:01C68BF8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21542>

I just triple-checked, and both those things are already in place.  The
default umask is 0022, and all the config files have:
[core]
        repositoryformatversion = 0
        filemode = true
        sharedrepository = true

I see that the case of the value is different from what you typed:
SharedRepository 
Is that significant (as almost everything is)?


Mark Post

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org] 
Sent: Friday, June 09, 2006 3:06 PM
To: Post, Mark K
Cc: git@vger.kernel.org
Subject: Re: Git-daemon messing up permissions for gitweb



On Fri, 9 Jun 2006, Post, Mark K wrote:
>
> As far as I can tell, the problem is happening because these files are
> being written out with file permissions of 640, and since Apache is
> running as user wwwrun, it can't read them:

You can either make sure that people have something like

	umask 0022

in their bashrc (or that it's the default umask), so that they do things

world-readably by default.

Or add
	[core]
		SharedRepository = true

to the repository config file.

		Linus
