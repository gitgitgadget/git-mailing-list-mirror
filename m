From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git and securing a repository
Date: Thu, 3 Jan 2008 00:19:31 -0500
Message-ID: <20080103051931.GC24004@spearce.org>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar> <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com> <477B69ED.3090107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201> <20080103035838.GA24004@spearce.org> <477C7459.3020402@advancedsl.com.ar> <20080103044552.GB24004@spearce.org> <477C7BF8.2090406@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gonzalo =?utf-8?Q?Garramu=C3=B1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Thu Jan 03 06:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAIUz-00039E-89
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 06:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYACFTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 00:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbYACFTe
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 00:19:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43973 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYACFTe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 00:19:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JAIUP-0003Sh-8o; Thu, 03 Jan 2008 00:19:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 32DD820FBAE; Thu,  3 Jan 2008 00:19:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <477C7BF8.2090406@advancedsl.com.ar>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69512>

Gonzalo Garramuo <ggarra@advancedsl.com.ar> wrote:
> Shawn O. Pearce wrote:
> >
> >Its a distributed version control system.  All peers are equal.
> >Most security in Git is handled by only pulling from sources you
> >trust, and never allowing someone to push stuff into a repository
> >you own.
> >
> 
> Regarding that... is there a way to control the umask of a git clone 
> independent of the actual umask of the user or directories inside the 
> repository?  Ideally, on the server side?
> 
> That is, for sensitive repositories, I would like "git clone" to always 
> clone that repository with 0700 permissions, so that the silly mistake 
> of cloning a sensitive repository into a public directory and forgetting 
> to restrict its permissions can be avoided completely.

No.

For a local clone (same UNIX system) you could probably easily
modify git-clone.sh to consult the config file of the source
repository to obtain recommended initial permissions, or just use
the source repository's directory permissions as the new clone's
initial permissions.  But not everyone would want that behavior.

For a remote clone (different systems) the config file of the source
repository isn't easily available.  So its not easily used to get
that setting.  The git protocol would have to be extended to make
transfer of parts of the config file possible.  We've talked about
this in the past but have never had a compelling application to
cause patches to be submitted for it.

-- 
Shawn.
