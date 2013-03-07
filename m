From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 16:15:38 +0100 (CET)
Message-ID: <757358726.204239.1362669338484.JavaMail.root@openwide.fr>
References: <CALeLG_=xzL1SA0G63FGb5v8K5WQOUg4yaodNm6zwf7kU1pAYvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 16:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDcY9-0001Mg-Ro
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 16:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab3CGPPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 10:15:40 -0500
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:33554 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3CGPPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 10:15:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 228E0280AA;
	Thu,  7 Mar 2013 16:15:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7W+tFkr3SBp; Thu,  7 Mar 2013 16:15:38 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 9B9BE2804A;
	Thu,  7 Mar 2013 16:15:38 +0100 (CET)
In-Reply-To: <CALeLG_=xzL1SA0G63FGb5v8K5WQOUg4yaodNm6zwf7kU1pAYvg@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217597>

> >
> > Ok, I can understand that you don't want to import tags for
> > namespace reason, but in that case shouldn't
> > git subtree add refuse to create a subtree when the tag isn't a
> > commit
> 
> It shouldn't and tries not to, but is limited in it's ability to
> identify if a refspec points to a commit or not in the remote repo.
> 

ok, i've studied a little more

* the target for "git subtree add <url> <refspec> can only be a remote branch or tag, since we git fetch 
can only target remote refs.
* in case of a branch, git subtree forgets the branch and only use the commit linked to the branch. for 
tags, the fetch part is ok, it's the merge part that fail. adding ^{} at the right place would probably fix that


> 
> I've posted a patch (which is pending a lot of other changes to
> git-subtree that I'm corralling) that tries to prevent some obvious
> errors in the refspec. But letting the git fetch used by git-subtree
> add and git-subtree pull catch the error and report it may be the
> best
> option.
> 

that's interesting... do you have a link ? 


> 
> I've never really tried using --squash, I don't see that it adds any
> value for me.
> 

my project has a git subtree for a linux kernel and another subtree for buildroot, 

a default .git is about 1.5G, squashing it reduces it to 200M so it's worth it for me :)
