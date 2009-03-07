From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Evaluate short refnames into full names during
	push
Date: Sat, 7 Mar 2009 14:48:31 -0800
Message-ID: <20090307224831.GS16213@spearce.org>
References: <20090307211008.GP16213@spearce.org> <1236464299-11491-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Cheng <j16sdiz+freenet@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 23:50:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg5LG-0008T6-2b
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 23:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbZCGWsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 17:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbZCGWsd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 17:48:33 -0500
Received: from george.spearce.org ([209.20.77.23]:59730 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZCGWsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 17:48:32 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4BFBD38211; Sat,  7 Mar 2009 22:48:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236464299-11491-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112593>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> @@ -243,10 +244,24 @@ else if (TransportLocal.canHandle(remote))
>  		final Collection<RefSpec> procRefs = expandPushWildcardsFor(db, specs);
>  
>  		for (final RefSpec spec : procRefs) {
> -			final String srcRef = spec.getSource();
> +			String srcRef = spec.getSource();
> +			final Ref src = db.getRef(srcRef);
> +			if (src != null)
> +				srcRef = src.getName();
> +			String remoteName = spec.getDestination();
>  			// null destination (no-colon in ref-spec) is a special case
> -			final String remoteName = (spec.getDestination() == null ? spec
> -					.getSource() : spec.getDestination());

Oh, right.  I forgot about the fact that Marek put the code here, as
then "push = master" in a config file works...

OK.  I'll apply.

-- 
Shawn.
