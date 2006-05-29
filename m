From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 10:00:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605290956190.5623@g5.osdl.org>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca> <e5d6i0$rnf$1@sea.gmane.org>
 <Pine.LNX.4.63.0605290910210.8863@wbgn013.biozentrum.uni-wuerzburg.de>
 <447ADAEF.3030806@Intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 19:01:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkl6y-0008KX-Vb
	for gcvg-git@gmane.org; Mon, 29 May 2006 19:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWE2RAp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 13:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWE2RAp
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 13:00:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751134AbWE2RAp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 13:00:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TH0h2g009271
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 10:00:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TH0ghR012428;
	Mon, 29 May 2006 10:00:42 -0700
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
In-Reply-To: <447ADAEF.3030806@Intel.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20952>


I realize that you already found the solution (Core.SharedRepository), 
but:

On Mon, 29 May 2006, Salikh Zakirov wrote:
> 
> 2) I have 'umask 002' in my ~/.profile. Somehow, it does not help,
> because ~/.profile is not read on non-interactive SSH sessions
> (to verify that, just try to do 'ssh somehost umask')

The ".profile" thing is indeed read only for interactive tasks.

So use ".bashrc" instead.

The reason I mention that is that this has come up before: if you need to 
do things like setting PATH to point to your ~/bin directory (to use your 
own version of git rather than the system one), or if you want to set 
environment variables like GIT_COMMITTER_NAME etc, you should always use 
.bashrc, so that you get the same answers whether you log in 
interactively, or whether you just do "ssh host git-cmd".

		Linus
