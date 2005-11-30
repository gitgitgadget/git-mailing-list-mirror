From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 08:12:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511300809300.3099@g5.osdl.org>
References: <20051130060906.13277.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 18:01:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhUbj-0004iO-Og
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 17:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVK3QOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 11:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVK3QOk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 11:14:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751434AbVK3QOk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 11:14:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAUGD5nO016153
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 30 Nov 2005 08:13:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAUGCxsP027412;
	Wed, 30 Nov 2005 08:13:02 -0800
To: linux@horizon.com
In-Reply-To: <20051130060906.13277.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13007>



On Tue, 30 Nov 2005, linux@horizon.com wrote:
>
> > +-0 -1 -2::
> > +	When an unmerged entry is seen, diff against the base version,
> > +	the "first branch" or the "second branch" respectively.
> > +
> > +	The default is to diff against the first branch.
> 
> Er... why are these flags zero-based?

Because it makes more sense from a "git diff" standpoint to do that.

The fact that _internally_, git puts the first branch into "stage 2", and 
the second one into "stage 3", that's very much a internal git 
implementation issue that makes no sense to expose to a regular user.

> git-ls-files -s displays them as "1", "2" and "3".  All the docs talk
> about "stage1", "stage2" and "stage3".

Yes, but those are _technical_ docs, not docs aimed toward a user. Nobody 
sane uses "git-ls-files --stage" outside of a script, or unless they 
really know git and are trying to debug something.

>From a user standpoint, it makes a lot more sense to say "primary branch" 
and "other branch" , and then "-1" and "-2" make sense (and then the "base 
of the merge" makes sense as "-0").

		Linus
