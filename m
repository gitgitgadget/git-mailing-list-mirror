From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and securing a repository
Date: Wed, 2 Jan 2008 14:17:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801021406020.3010@woody.linux-foundation.org>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>,
	git@vger.kernel.org
To: Gonzalo Garramu?o <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:18:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JABv1-0007Hv-QV
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 23:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbYABWSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYABWSH
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 17:18:07 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40910 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269AbYABWSF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 17:18:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m02MHiRs009361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jan 2008 14:17:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m02MHhS4007927;
	Wed, 2 Jan 2008 14:17:43 -0800
In-Reply-To: <477B6199.6070601@advancedsl.com.ar>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.421 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_71
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69498>



On Wed, 2 Jan 2008, Gonzalo Garramu?o wrote:
> 
> I was really looking for a permission based system that was part of git itself
> (and thus more portable and easier to admin), and not the OS. Something akin
> to what perforce or even CVS can do.

Well, git by design doesn't do that. 

That doesn't mean that it has to be OS-level permissions (in fact, it 
generally shouldn't), it just means that git wasn't really meant to care 
about permissions itself, and you the user management and permissions 
should come from "outside".

That outside *can* be OS-level things like just permissions on files, but 
more commonly it's things like SSH keys and using the git hooks. In other 
words, pretty much by design, git is meant to be the *core* SCM 
infrastructure, and then you layer your user management on top of it as a 
*separate* layer.

An example of that would probably be gitosis, but I haven't used it 
myself. For the kernel, people literally tend to just use SSH accounts, 
and not any central repository at all (ie the kind of crazy "central repo 
access control rules" that centralized repos need are just not necessary 
at all in a more distributed usage model).

See 

	http://eagain.net/gitweb/?p=gitosis.git
	http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way

for a quick starting point on gitosis, if that suits your needs (there's 
more, google is your friend).

			Linus
