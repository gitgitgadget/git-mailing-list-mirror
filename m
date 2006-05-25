From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 11:36:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605251134410.5623@g5.osdl.org>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
 <7vejyjpz9a.fsf@assigned-by-dhcp.cox.net> <m13beysnb2.fsf@ebiederm.dsl.xmission.com>
 <7vwtcay5k8.fsf@assigned-by-dhcp.cox.net> <m1lksqdook.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.64.0605251024320.5623@g5.osdl.org> <7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 20:36:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjKhH-0005V5-Jz
	for gcvg-git@gmane.org; Thu, 25 May 2006 20:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWEYSgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 14:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWEYSgZ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 14:36:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030288AbWEYSgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 14:36:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4PIaK2g030782
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 May 2006 11:36:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4PIaGf9002666;
	Thu, 25 May 2006 11:36:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20754>



On Thu, 25 May 2006, Junio C Hamano wrote:
> 
> With the limitation of the current tool, we could do:
> 
>   git-fetch master.kernel.org:/pub/scm/.../torvalds/linux-2.6.git \
> 	refs/heads/master:refs/remotes/linus/master
>   git merge 'whatever merge message' HEAD b307e854
> 
> assuming that b307e854 is reachable from your tip.  So it might
> be just a matter of giving a convenient shorthand to do the
> above two commands, instead of mucking with upload-pack.

It's not upload-pack that needs mucking with. It's simply "fetch-pack" 
that currently will refuse to say "want b307e854..", because the only 
thing it can do is say "want <headref>".

So the patch would literally be to have a way to tell fetch-pack directly 
what you want, and not have the "only select from remote branches" logic.

		Linus
