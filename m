From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 09:45:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
References: <20060524131022.GA11449@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 18:46:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiwUP-0000hO-PF
	for gcvg-git@gmane.org; Wed, 24 May 2006 18:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWEXQpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWEXQpi
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 12:45:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932308AbWEXQpi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 12:45:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4OGjUtH011210
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 09:45:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4OGjTwm022738;
	Wed, 24 May 2006 09:45:29 -0700
To: Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20060524131022.GA11449@linux-mips.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20692>



On Wed, 24 May 2006, Ralf Baechle wrote:
>
> I have a fairly large git tree (with a 320MB pack file containing some
> 700,000 objects).  A small fetch like
> 
>   git fetch git://www.kernel.org/pub/scm/linux/kernel/git/stable/\
>        linux-2.6.16.y.git master:v2.6.16-stable
> 
> which only fetches a handful of objects (v2.6.16.17 -> v2.6.16.18) will
> take on the order of 4-5 minutes.  Adding the "-n" option is will bring
> the operation down to under a second, so it really is just the tags
> that are slowing things down so much..

So this is a tree where you already _have_ most of the tags, no?

Can you add a printout to show what the "taglist" is for you in 
git-fetch.sh (just before the thing that does that

	fetch_main "$taglist"

thing?). It _should_ have pruned out all the tags you already have.

Or is it just the "git-ls-remote" that takes forever? (Or, if you run 
"top", is there something that is an obviously heavy operation on the 
client side?)

		Linus
