From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem upgrading to 1.4.0
Date: Mon, 12 Jun 2006 20:28:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606122024400.5498@g5.osdl.org>
References: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com> 
 <7v1wtwh246.fsf@assigned-by-dhcp.cox.net> <1150165982.4297.88.camel@dv> 
 <20060612224818.383b13ee.seanlkml@sympatico.ca> <1150167759.4297.95.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org,
	geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 13 05:29:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpzaV-0005JH-I9
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 05:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814AbWFMD3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 23:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWFMD3E
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 23:29:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932814AbWFMD3D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 23:29:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5D3Ssgt019533
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 20:28:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5D3Sq3G013656;
	Mon, 12 Jun 2006 20:28:53 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1150167759.4297.95.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21759>



On Mon, 12 Jun 2006, Pavel Roskin wrote:
>
> > You can get a list of the remote branches whenever you want:
> > 
> > $ git ls-remote -h <remote>
> 
> I heard of that command.  But git-clone only uses it for local and rsync
> protocols.

The native format doesn't _need_ to use "git ls-remote", because the 
native format does it on its own.

In fact, "git ls-remote" actually uses the pack transfer protocol to 
figure out what the remote heads are (it just then doesn't _ask_ for 
anything), so in many ways you can see "git ls-remote" as being just a 
helper around the basic clone/pull protocol.

So "git clone" ends up doing the equivalent of a git ls-remote to populate 
the initial local heads and tags. It's just that for the native protocol, 
it all happens together in one burst.

		Linus
