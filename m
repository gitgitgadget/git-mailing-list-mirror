From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] [JGit] Fix parsing peeled line in packed-ref
Date: Fri, 6 Mar 2009 07:43:09 -0800
Message-ID: <20090306154309.GF16213@spearce.org>
References: <1236353138-1427-1-git-send-email-j16sdiz+freenet@sdiz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@sdiz.net>
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 16:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfcE5-0003AE-8Z
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbZCFPnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZCFPnM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:43:12 -0500
Received: from george.spearce.org ([209.20.77.23]:50355 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZCFPnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:43:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6D9E638211; Fri,  6 Mar 2009 15:43:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236353138-1427-1-git-send-email-j16sdiz+freenet@sdiz.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112451>

"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com> wrote:
> When doing a WalkTransport with packed-ref, peeled
> line are not handled correctly. This patch fix the
> issue.

Wow.  That old code was really wrong.  :-)

Signed-off-by?  (See SUBMITTING_PATCHES, "(5) Sign your work")

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
> index a4f8961..d8e727b 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
> @@ -436,7 +436,7 @@ private void readPackedRefsImpl(final Map<String, Ref> avail,
>  			if (line.charAt(0) == '^') {
>  				if (last == null)
>  					throw new TransportException("Peeled line before ref.");
> -				final ObjectId id = ObjectId.fromString(line + 1);
> +				final ObjectId id = ObjectId.fromString(line.substring(1));
>  				last = new Ref(Ref.Storage.PACKED, last.getName(), last

If I'm at fault for that preimage, I should just be put out to
pasture now... before I do any more harm... *sigh*

-- 
Shawn.
