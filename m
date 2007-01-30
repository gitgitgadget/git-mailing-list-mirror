From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 11:04:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
References: <17855.35058.967318.546726@lisa.zopyra.com>
 <17855.36470.309129.391271@lisa.zopyra.com>
 <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
 <200701301950.00195.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HByI0-0002bR-MI
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbXA3TFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXA3TFE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:05:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43037 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbXA3TFC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:05:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0UJ4w1m019581
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 11:04:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0UJ4vkS025960;
	Tue, 30 Jan 2007 11:04:57 -0800
In-Reply-To: <200701301950.00195.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.456 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38187>



On Tue, 30 Jan 2007, Jakub Narebski wrote:
> 
> ...so "git clone" tries to checkout HEAD -> refs/heads/master
> branch, which does not exist. It is strange that git does not
> report error or at least warning, though...

Well, HEAD pointing to a non-existent branch is actually a perfectly valid 
thing. It literally means "I haven't done the first commit yet".

So Bill's repository is a perfectly fine repository. It has a topic branch 
(called 'topic'), and it has an empty 'master' branch that just hasn't 
seen any commits yet. You can work on it as a full and normal git 
repository, because it really *is* a full and normal git repository.

Of course, I do agree that it'sa fairly confusing way to set up a repo, 
and you generally shouldn't do it, but Bill did it that way explicitly. 
Maybe he didn't do it "on purpose", but git at no point in time had any 
way to know that Bill wanted somethign else. Nothing he did was "wrong", 
and it's quite possible that it's what he could have meant to do.

Anyway, it's certainly easy to fix. Bill, you can either:

 - just rename the "topic" branch to "master"

 - change the HEAD to point to "topic" rather than "master".

(and if you do that setup in the future, the way to populate the initial 
bare repository would have been to just do

	git fetch original topic:master

and you'd never have seen this, because the branch you fetched would have 
been named the default 'master' in the first place).

		Linus
