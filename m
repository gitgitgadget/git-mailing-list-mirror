From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: "commit"s without "from" in fast-import
Date: Tue, 18 Mar 2008 22:06:25 -0400
Message-ID: <20080319020625.GA3535@spearce.org>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no> <20080318034321.GK8410@spearce.org> <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Westby <jw+debian@jameswestby.net>, git@vger.kernel.org,
	Ian Clatworthy <ian.clatworthy@internode.on.net>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:13:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5ay-0007aG-9G
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965588AbYCSVIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764146AbYCSVIE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:08:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51811 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764123AbYCSVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:07:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jbnh2-0007km-TV; Tue, 18 Mar 2008 22:06:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3D67020FBAE; Tue, 18 Mar 2008 22:06:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77548>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> wrote:
> On 18. mars. 2008, at 04.43, Shawn O. Pearce wrote:
> [...]
> >Maybe we should make this more formalized in the documentation as
> >allowable, so if it does break for an importer the importer author
> >has to fix git-fast-import, bzr-fast-import, *-fast-import instead.
> 
> In the interests of language strictness, I think it should be  
> explicitly either allowed or forbidden, and if it is forbidden I think  
> fast-import should barf on it.

Agreed.
 
> From a git perspective it seems ok to allow it, since a commit is  
> only really a tree and a set of parent commits.  "from" adds a parent  
> and initialises the tree, "merge" adds a parent without touching the  
> tree.  But maybe I'm thinking too git-centrically.
> 
> I can try to make a documentation patch that allows it and see if  
> having it "on paper" makes it more or less reasonable.

I'm leaning towards leaving it in the language as allowed, and thus
documenting that this is not only possible, but actively used by
importers as it can be an easy way to setup a subsequent change
with no initial files.

But I have to wonder what the bzr-fast-import folks would say.
I've CC'd in James and Ian, as they have been working on the bzr
side for a little.

James, Ian -- to give you the short backstory we are talking about
creating a new branch _without_ a "from", but instead using a single
"merge" to specify the sole ancestor revision of a new commit to
be placed on the new branch.  This allows the frontend to supply
all files for the tree as none were inherited from the sole ancestor.

The other (more obvious?) approach to accomplish the same result
is to use "from" followed by a "filedeleteall" to clear the files,
then supply the new files.  Both approaches have the exact same
result in git-fast-import.

-- 
Shawn.
