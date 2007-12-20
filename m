From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-commit: add --verbatim to allow unstripped commit
	messages
Date: Fri, 21 Dec 2007 00:33:24 +0100
Message-ID: <20071220233324.GB3052@steel.home>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Utl-0004tl-Dr
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbXLTXd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbXLTXd2
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:33:28 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:59291 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbXLTXd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:33:27 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvznCE=
Received: from tigra.home (Fca98.f.strato-dslnet.de [195.4.202.152])
	by post.webmailer.de (klopstock mo6) (RZmta 14.6)
	with ESMTP id z03cc7jBKLKjVM ; Fri, 21 Dec 2007 00:33:25 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4449A277AE;
	Fri, 21 Dec 2007 00:33:25 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A061056D22; Fri, 21 Dec 2007 00:33:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69022>

Linus Torvalds, Thu, Dec 20, 2007 22:40:13 +0100:
> On Thu, 20 Dec 2007, Alex Riesen wrote:
> > 
> > I just happen to have a corporate template (for perforce messages, I
> > reuse it my git mirror repo) which contains "#" and at least one time
> > lost my bash comments in a commit.
> 
> I think that this is a real bug, but I don't think this is something that 
> we should add a flag for.
> 
> Basically, I don't think we should really strip lines starting with '#' 
> unless *we* added them. In particular, I don't think we should strip them 
> at all unless we're running the editor.

Right

> That may be enough for your case, although it still does leave the "use 
> editor on a template thing", so if that is your usage scenario, I guess we 
> still do need a flag for it.

Yes, I afraid I need both. I use "git commit -t" almost (submission in
perforce takes careful planning) every day. I also would like to keep
the empty leading and trailing lines (perforce default GUI P4Win does
not show them, but our scripts which check the descriptions will test
the description text according to template which does have trailing
empty lines).

> But even if we *do* add a flag (like "--verbatim") you should at the 
> *least* also then remove the
> 
> 	"# (Comment lines starting with '#' will not be included)\n"
> 
> printout! Which you didn't.

I did think about it. It wont be read, I believe (at least I ignore
the status listing git-commit generates today). But then, it can be
removed for verbatim message as no one (I think) will probably care.
Including the "Please..." so it does not look stupid in the commit
message later. Will do.

> > It also implies --allow-empty.
> 
> I disagree with this one too.
> 

I agree. Will remove (I am not even sure myself, why I did that. It is
not even tested)
