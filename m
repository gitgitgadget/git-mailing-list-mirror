From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [jgit] index v2 pull request
Date: Wed, 12 Mar 2008 03:52:05 -0400
Message-ID: <20080312075205.GT8410@spearce.org>
References: <20080308025027.GZ8410@spearce.org> <200803102253.28469.robin.rosenberg@dewire.com> <7bfdc29a0803111952h3cd37b78jd884cec94afe1bc4@mail.gmail.com> <200803120807.01715.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imran M Yousuf <imyousuf@gmail.com>, git@vger.kernel.org,
	Dave Watson <dwatson@mimvista.com>,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 08:53:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZLln-0007fj-FL
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 08:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbYCLHwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 03:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYCLHwP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 03:52:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40461 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbYCLHwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 03:52:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JZLkr-0007a8-Af; Wed, 12 Mar 2008 03:52:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CB52620FBAE; Wed, 12 Mar 2008 03:52:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200803120807.01715.robin.rosenberg@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76937>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Den Wednesday 12 March 2008 03.52.05 skrev Imran M Yousuf:
> 
> > I am currently looking into .git/config format as Shawn suggested.
> 
> That's a good one too. I have code for parsing the remotes specs, though
> e.g. "+refs/heads/master/*:refs/remotes/origin/*", but nothing for the "branch" config. I haven't used it yet, so it's a rip-out.	

Your RemoteSpec is missing the fact that some people have more than
one URL, fetch, and/or push lines in the same remote.  :-)
 
> + * <pre>
> + *  [remote &quot;name&quot;]
> + *     url = URL:ish
> + *     fetch = [+]remoteref:localref
> + * </pre>
> + *
> + * There are more variants but we do not support them here yet.

Or is that what you mean by the above statement?

In any case the remote spec needs a list of URLs a list of the
fetch/push Info objects.  That changes the public API of the
RemoteSpec class rather significantly.

> +public class RemoteSpec {
> +
> +	static class Info {
> +		boolean overwriteAlways;
> +
> +		boolean matchAny;
> +
> +		String remoteRef;
> +
> +		String localRef;
> +	}
> +
> +	Info fetch = new Info();
> +
> +	Info push = null;
> +
> +	private final String name;
> +
> +	private final String url;

-- 
Shawn.
