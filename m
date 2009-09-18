From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Circular references shouldn't be created
Date: Fri, 18 Sep 2009 14:20:17 -0700
Message-ID: <20090918212017.GI14660@spearce.org>
References: <C89280B882467443A695734861B942B28759DB95@DEWDFECCR09.wdf.sap.corp> <32541b130909171440w1a6d2394t4acc6a2f791c143@mail.gmail.com> <200909180051.47794.robin.rosenberg@dewire.com> <C89280B882467443A695734861B942B28759DEAA@DEWDFECCR09.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Sohn, Matthias" <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 23:20:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoksV-0005ry-EA
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 23:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZIRVUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 17:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbZIRVUP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 17:20:15 -0400
Received: from george.spearce.org ([209.20.77.23]:60621 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZIRVUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 17:20:14 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CA04E381FE; Fri, 18 Sep 2009 21:20:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <C89280B882467443A695734861B942B28759DEAA@DEWDFECCR09.wdf.sap.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128812>

"Sohn, Matthias" <matthias.sohn@sap.com> wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote on Freitag, 18. September 2009 00:52
> > I think we should do this in the UI by not allowing the user to make a
> > choice that would result in a loop and fixing the way the UI resolves
> > choices. When creating a new branch we should analyze the selected
> > ref and dereference it if it is a symbolic name like HEAD or if it is a
> > tag,
> > and perhaps show it like "HEAD (refs/heads/master)" in the the dialog.
> > 
> > Using unresolvable refs as the base for a new branch should be
> > disallowed.
> 
> If we would do it in the EGit UI how about catching such cases 
> in other applications using JGit ?

I agree with Matthias here, other applications using JGit will
also want to be able to detect a ref loop at ref creation time,
and also at ref reading time.  We should put the test function into
JGit and allow the UI to call that test function to determine if
creating that symref right now would create a loop.  EGit UI can
then use that function to qualify the user's selection, and prevent
the user from making a choice which would create a loop.

-- 
Shawn.
