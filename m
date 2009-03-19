From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Push tag from shallow clone?
Date: Thu, 19 Mar 2009 11:02:16 -0700
Message-ID: <20090319180216.GT23521@spearce.org>
References: <2729632a0903191056w4efdbec6hd1656d7b47d0d8a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 19 19:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkMay-0002gb-Iz
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 19:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbZCSSCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbZCSSCS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 14:02:18 -0400
Received: from george.spearce.org ([209.20.77.23]:52441 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZCSSCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 14:02:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7279538221; Thu, 19 Mar 2009 18:02:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2729632a0903191056w4efdbec6hd1656d7b47d0d8a3@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113804>

skillzero@gmail.com wrote:
> The documentation for git clone says that if you use --depth=1 to make
> a shallow clone that you can't push it. But I made a shallow clone,
> created a tag, then tried to push that tag and it worked. Am I just
> getting lucky or is it safe to push a tag with a shallow clone?

Yea, you are getting lucky.  The tag is easily identified as one
object head of the current branch on the remote, and the client is
able to produce the pack and send it.

If the remote branch gets modified in the interm, the builder may
not be able to deduce what it needs to send, and will attempt to
pack a lot more data, potentially finding the missing parents from
where it is shallow.

Why not just have a central area on the build server that keeps
full clones of everything, and use "git clone -s" or "git clone
--reference" in order to create the new work area for the builder?

-- 
Shawn.
