From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Sat, 10 Jun 2006 14:41:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606101439530.5498@g5.osdl.org>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
 <20060610213051.GB5825@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Post, Mark K" <mark.post@eds.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 23:42:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpBDW-00045Z-TS
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 23:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWFJVmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 17:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWFJVmA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 17:42:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161029AbWFJVl7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 17:41:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5ALfrgt027215
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Jun 2006 14:41:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5ALfqj2001347;
	Sat, 10 Jun 2006 14:41:52 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060610213051.GB5825@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21622>



On Sat, 10 Jun 2006, Alex Riesen wrote:
>
>      ~/.ssh/rc
> 
> AFAIK, it was always there.

Note that since umask is a per-process flag, and only inherited from 
parents to children, not the other way around, if the rc file is run as a 
separate shell script (and I assume it is) instead of "sourced" from the 
the shell that actually executes the programs you run, then this won't 
help at all.

Try:

	sh -c "umask 0777 ; umask" ; umask

to see in more graphic ("textual") detail what I mean.

		Linus
