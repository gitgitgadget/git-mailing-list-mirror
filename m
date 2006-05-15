From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 09:15:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
 <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net> <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 18:15:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fffj4-0006zt-Uj
	for gcvg-git@gmane.org; Mon, 15 May 2006 18:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWEOQPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 12:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWEOQPO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 12:15:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751442AbWEOQPM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 12:15:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FGF4tH011801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 09:15:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FGF1p3007714;
	Mon, 15 May 2006 09:15:02 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20063>



On Mon, 15 May 2006, Eric W. Biederman wrote:
> 
> So that it has a chance of being remembered, and eventually fixed
> the man pages of git-whatchanged and git-log only sort of tell you
> that this is even possible.

I don't think this is a man-page issue. I think this is a very basic 
tutorial issue. 

People still don't seem to realize how flexible (and powerful) the git 
revision specifications are. It's not just limiting by path, all of these 
work on _all_ of the "history tools" (whether they be gitk, qgit, "git 
log", "git whatchanged" or your own home-cooked stuff):

 - "revision based limiting"

	"a..b", but also "a ^b ^c ^d" or "a --not b c d" for the more 
	complex case where you're interested in one (or more) commit, but 
	not anything that flows from any of a number of other commits.

	"--all".

 - "commit date based limiting"

	"--since=2.weeks.ago" "--since=aug.5th"

 - "limit by number of hits"

	"-15"

 - "limit by type or state"

	"--no-merges" and "--unpacked"

And finally

 - "limit by pathname"

and you can combine all of these.

So

	gitk --all --since=1.month -15 -- t/

will show at most fifteen commits from _any_ branch that changed the 
test subdirectory in the last month.

And yeah, maybe that isn't a very interesting query, but it's easy to 
explain and understand, so it's worth explaining early.

And it should be equally obvious to everybody that if it works for "gitk", 
that means that it works for "qgit", "git log" and "git whatchanged" too, 
ie this is a very core concept, and not just some tacked-on thing for one 
special tool.

			Linus
