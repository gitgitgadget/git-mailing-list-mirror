From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Document the effect of "merge" with no "from" in a commit
Date: Wed, 19 Mar 2008 23:40:31 -0400
Message-ID: <20080320034031.GX8410@spearce.org>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no> <20080318034321.GK8410@spearce.org> <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no> <20080319020625.GA3535@spearce.org> <9A41E5AD-2305-457B-A214-7A11A1B559F6@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Westby <jw+debian@jameswestby.net>, git@vger.kernel.org,
	Ian Clatworthy <ian.clatworthy@internode.on.net>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Thu Mar 20 04:41:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcBf5-0002Rp-KV
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 04:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbYCTDkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 23:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbYCTDkk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 23:40:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47126 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbYCTDkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 23:40:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JcBdc-00077E-DW; Wed, 19 Mar 2008 23:40:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 417A820FBAE; Wed, 19 Mar 2008 23:40:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <9A41E5AD-2305-457B-A214-7A11A1B559F6@orakel.ntnu.no>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77619>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> wrote:
> @@ -385,9 +385,11 @@ new commit.
>  Omitting the `from` command in the first commit of a new branch
>  will cause fast-import to create that commit with no ancestor. This
>  tends to be desired only for the initial commit of a project.
> -Omitting the `from` command on existing branches is usually desired,
> +Including the `from` command on existing branches is usually desired,
>  as the current commit on that branch is automatically assumed to
>  be the first ancestor of the new commit.

I disagree with this.  Omitting is the correct term here as you
usually do not want a 'from' commit, as you usually want it to
automatically use the prior commit made on this branch.

As I understand it, this discussion about leaving out 'from' and
using 'merge' is only relevant on a *new* branch.

> +If the frontend creates all files from scratch when making a new
> +commit, a `merge` command may be used instead.

This is fine.
 
>  As `LF` is not valid in a Git refname or SHA-1 expression, no
>  quoting or escaping syntax is supported within `<committish>`.
> @@ -427,13 +429,15 @@ existing value of the branch.
> 
>  `merge`
>  ^^^^^^^
> -Includes one additional ancestor commit, and makes the current
> -commit a merge commit.  An unlimited number of `merge` commands per
> +Includes one additional ancestor commit.  In the absence of a `from`
> +command, the first `merge` commit will be the first ancestor of the
> +current commit, and the commit will start out with no files.  An
> +unlimited number of `merge` commands per
>  commit are permitted by fast-import, thereby establishing an n-way  
> merge.
>  However Git's other tools never create commits with more than 15
>  additional ancestors (forming a 16-way merge).  For this reason
>  it is suggested that frontends do not use more than 15 `merge`
> -commands per commit.
> +commands per commit; 16, if `from` is not used.

These updates are also fine.

-- 
Shawn.
