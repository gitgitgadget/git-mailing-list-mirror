From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 09:49:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504190943060.19286@ppc970.osdl.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr> <20050418122011.GA13769@abridgegame.org>
 <Pine.LNX.4.58.0504180832330.7211@ppc970.osdl.org> <20050419104252.GA28269@abridgegame.org>
 <Pine.LNX.4.58.0504190749030.19286@ppc970.osdl.org> <426532D5.3040306@tupshin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Roundy <droundy@abridgegame.org>, darcs-devel@darcs.net,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:44:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNvp1-0005XF-3p
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 18:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDSQrf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 12:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVDSQrf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 12:47:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:11704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbVDSQrX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 12:47:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JGlGs4026616
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 09:47:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JGlETx018785;
	Tue, 19 Apr 2005 09:47:15 -0700
To: Tupshin Harper <tupshin@tupshin.com>
In-Reply-To: <426532D5.3040306@tupshin.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Tupshin Harper wrote:
> 
> I suspect that any use of wildcards in a new format would be impossible 
> for darcs since it wouldn't allow darcs to construct dependencies, 
> though I'll leave it to david to respond to that.

Note that git _does_ very efficiently (and I mean _very_) expose the 
changed files.

So if this kind of darcs patch is always the same pattern just repeated
over <n> files, then you really don't need to even list the files at all.  
Git gives you a very efficient file listing by just doing a "diff-tree"  
(which does not diff the _contents_ - it really just gives you a pretty
much zero-cost "which files changed" listing).

So that combination would be 100% reliable _if_ you always split up darcs 
patches to "common elements". 

And note that there does not have to be a 1:1 relationship between a git
commit and a darcs patch. For example, say that you have a darcs patch
that does a combination of "change token x to token y in 100 files" and
"rename file a into b". I don't know if you do those kind of "combination 
patches" at all, but if you do, why not just split them up into two? That 
way the list of files changed _does_ 100% determine the list of files for 
the token exchange.

		Linus
