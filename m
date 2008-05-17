From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add a -z option to 'git status' to safely feed shell programs with path names
Date: Fri, 16 May 2008 22:51:33 -0400
Message-ID: <20080517025133.GQ29038@spearce.org>
References: <20080517023340.GG10006@kali.thurne.chezwam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastien Gross <seb-git@chezwam.org>
X-From: git-owner@vger.kernel.org Sat May 17 04:52:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxCXW-00062d-4j
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 04:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYEQCvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 22:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbYEQCvj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 22:51:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55367 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYEQCvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 22:51:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JxCW4-0007nL-DY; Fri, 16 May 2008 22:51:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4DFC720FBAE; Fri, 16 May 2008 22:51:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080517023340.GG10006@kali.thurne.chezwam.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82331>

Sebastien Gross <seb-git@chezwam.org> wrote:
> Add a -z option to 'git status' to get a list of all files
> but ignored, starting with modification type or 'untracked'
> as prefix and ending with '\0'.

Hmm.  Is the plumbing really that broken that you need to add -z
support to porcelain rather than using the -z support already built
into the plumbing?
 
>  * Remove all untracked files:
> 
>    git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^untracked/ \
> 	{sub("^.+:", "");print}' | xargs -0 -r rm

That I take it is just the long handed way to write `git clean -f` ?
 
>  * List all updated file regardless the modification:
> 
>    git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^updated/ \
> 	{sub("^.+:", "");print}' | xargs -0 -n 1

And this is just the long handed way to write `git diff --name-only` ?


A very large and intrusive looking patch for what can already be
obtained easier through existing, stable porcelain.  Not something
I am in favor of seeing added at this time.

-- 
Shawn.
