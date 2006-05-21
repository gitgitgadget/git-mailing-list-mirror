From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Make '@' not valid in a ref name.
Date: Sat, 20 May 2006 22:19:20 -0400
Message-ID: <20060521021919.GA7700@spearce.org>
References: <20060521013751.GA7516@spearce.org> <20060521020038.GA22926@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 21 04:19:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhdXZ-0002Xi-74
	for gcvg-git@gmane.org; Sun, 21 May 2006 04:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWEUCT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 22:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWEUCT1
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 22:19:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8149 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751008AbWEUCT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 22:19:27 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FhdXD-0006V1-94; Sat, 20 May 2006 22:19:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AFAB1212691; Sat, 20 May 2006 22:19:20 -0400 (EDT)
To: Eric Wong <normalperson@hand.yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060521020038.GA22926@hand.yhbt.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20427>

Eric Wong <normalperson@hand.yhbt.net> wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
> > Now that the sha1 expression syntax supports looking up a ref's
> > value at a prior point in time through the '@' operator the '@'
> > operator should not be permitted in a ref name.
> 
> This would break git-archimport (where email addresses are the first
> part of the branch/tag names).

OK, so this patch is quite unpopular and should never make it
into GIT.  I'm glad we have many eyes on this mailing list!


There was just a short conversation on #git about converting
the sha1 expression evaluator into a split parser/interpreter
model.  The idea here would be to convert an expression such as

  HEAD@{yesterday}~3^{tree}

into a an expression tree such as (in LISP style):

  (peel-onion (walk-back 3 (date-spec yesterday (ref HEAD))))

with such a tree it is relatively easy to evaluate the expression,
but its also easy to determine if a ref name is valid.  Just pass
it through the parser and see if you get back anything more complex
then '(ref <input>)'.

Comments?

-- 
Shawn.
