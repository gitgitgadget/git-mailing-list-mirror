From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 05/10] Do not write to the reflog unless the
	refupdate logmessage is set
Date: Wed, 3 Jun 2009 08:41:29 -0700
Message-ID: <20090603154129.GG3355@spearce.org>
References: <20090520221651.GR30527@spearce.org> <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 17:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBscU-00063N-DN
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 17:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359AbZFCPl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 11:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757856AbZFCPl3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 11:41:29 -0400
Received: from george.spearce.org ([209.20.77.23]:46394 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392AbZFCPl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 11:41:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A00C8381D1; Wed,  3 Jun 2009 15:41:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120615>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Do not write to the reflog unless the refupdate logmessage is set

Why not?  What is the justification for this?  Isn't a reflog record
still useful, at least to point out that something happened at this
point in time, and here's the old/new values?

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
> index a9ab73b..79d9f2d 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
> @@ -479,7 +479,8 @@ else if (status == Result.FAST_FORWARD)
>  			else if (status == Result.NEW)
>  				msg += ": created";
>  		}
> -		RefLogWriter.append(this, msg);
> +		if (msg != null)
> +			RefLogWriter.append(this, msg);
>  		if (!lock.commit())
>  			return Result.LOCK_FAILURE;
>  		db.stored(this.ref.getOrigName(),  ref.getName(), newValue, lock.getCommitLastModified());

-- 
Shawn.
