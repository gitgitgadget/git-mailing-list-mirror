From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 12:05:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091201210.5498@g5.osdl.org>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795782F@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 21:05:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FomIn-0004Gu-Tm
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 21:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWFITFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 15:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWFITFq
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 15:05:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030263AbWFITFq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 15:05:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59J5fgt025209
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 12:05:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59J5bVI025851;
	Fri, 9 Jun 2006 12:05:39 -0700
To: "Post, Mark K" <mark.post@eds.com>
In-Reply-To: <5A14AF34CFF8AD44A44891F7C9FF41050795782F@usahm236.amer.corp.eds.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21541>



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
