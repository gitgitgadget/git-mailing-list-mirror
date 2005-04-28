From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 14:44:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281441070.18901@ppc970.osdl.org>
References: <42703E79.8050808@zytor.com> <1114673723.12012.324.camel@baythorne.infradead.org>
 <20050428081005.GG8612@pasky.ji.cz> <1114676955.12012.346.camel@baythorne.infradead.org>
 <1114680199.12012.363.camel@baythorne.infradead.org>
 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org> <7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, Petr Baudis <pasky@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:38:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGgz-0005ef-HR
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVD1Vmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVD1Vmj
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:42:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:52899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbVD1Vmh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 17:42:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SLgNs4015926
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 14:42:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SLgGeF012034;
	Thu, 28 Apr 2005 14:42:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Junio C Hamano wrote:
> 
> 1. Currently, commit-tree does not seem to verify that all its
>    parent SHA1's actually name valid commit objects.  Is this
>    intentional?

No. Me lazy. I think we should check as many _cheap_ things as possible,
and checking whether a parent at least superficially looks like a real
commit object is certainly cheap.

> 2. Assuming that we do want to enforce that parent fields of a
>    commit object name valid commit objects, is it OK to also
>    require that the commit timestamp of a child object is not in
>    the future relative to any and all of its parent commit
>    objects (I'm talking about the timestamp of committer field
>    not author field, although your e-mail patch acceptance
>    procedure seems to be giving it the same timestamp right
>    now)?

No, this is not ok. Clock skew is real, and somebody may have a 
misconfigured machine. Being careful about integrity is good, but trying 
to enforce time flow in a distributed environment is just being anal.

Maybe a warning.

		Linus
