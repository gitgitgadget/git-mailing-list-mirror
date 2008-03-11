From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Is a given file known to git?
Date: Tue, 11 Mar 2008 03:24:12 -0400
Message-ID: <20080311072412.GP8410@spearce.org>
References: <47D6317D.7030700@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 08:25:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYyrJ-0003TX-2k
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYCKHYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbYCKHYR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:24:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39833 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYCKHYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:24:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYyqK-0003NV-Vu; Tue, 11 Mar 2008 03:24:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2EE8920FBAE; Tue, 11 Mar 2008 03:24:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47D6317D.7030700@melosgmbh.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76804>

Christoph Duelli <duelli@melosgmbh.de> wrote:
> Given a repository and a path p to a file in it:
> Is it possible (how?) to detect (in a bash script) if the file pointed 
> to by p is "known" to git?
> Something along the line:
> if `git knows p?
> then
> ...
> fi

Depends on your definition of "known to git".  You can look at
the current index, which may have files newly added but not yet
committed:

	if test $(git ls-files "$p" | wc -l) -gt 0
	then
	...
	fi

you can look at a specific committed state too:

	if git cat-file -e "$commit:$p" 2>/dev/null
	then
	...
	fi

where $commit can be any tree-ish, so a tag, a branch, a commit,
the symbolic-ref HEAD... etc.

-- 
Shawn.
