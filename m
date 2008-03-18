From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: "commit"s without "from" in fast-import
Date: Mon, 17 Mar 2008 23:43:21 -0400
Message-ID: <20080318034321.GK8410@spearce.org>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Tue Mar 18 04:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbSk9-0000LM-S1
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 04:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbYCRDn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 23:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbYCRDnZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 23:43:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41581 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYCRDnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 23:43:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JbSjH-00030V-8I; Mon, 17 Mar 2008 23:43:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 30A5920FBAE; Mon, 17 Mar 2008 23:43:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77485>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> wrote:
> I have a question about fast-import, specifically a (possibly)  
> unorthodox usage of it by cvs2svn.  Cvs2svn generates "commit"s with  
> no "from" commands; instead, it emits a "merge" from the previous  
> commit on the branch, and then rebuilds the entire state of the tree.
> 
> I've verified that the generated repositories are correct, so I know  
> that it works, and I _think_ that it's equivalent to having "from  
> <mark>" followed by "filedeleteall".

Hehe.  Cute trick.  Never intended for it to be used like that.
The git implementation of git-fast-import behaves as you describe,
but I do not know how bzr-fast-import would handle such a stream.

> What I'm wondering is: is there any reason to modify cvs2svn's output  
> to comply more to the man page's way of doing things, or is this a  
> perfectly valid usage?

In my opinion its an interesting use of the language.  The grammar
does not say that no merge commands are permitted when creating
a branch.  It wasn't what I intended, and is really a gap in the
grammar specification.  I'd prefer well known frontends use a
more conventional structure, just in case something were to ever
change about the implementation details of a given importer and
this command set break.  But that's just me.

Maybe we should make this more formalized in the documentation as
allowable, so if it does break for an importer the importer author
has to fix git-fast-import, bzr-fast-import, *-fast-import instead.

-- 
Shawn.
