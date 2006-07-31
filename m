From: Shawn Pearce <spearce@spearce.org>
Subject: Re: File version at a specific date?
Date: Mon, 31 Jul 2006 18:20:35 -0400
Message-ID: <20060731222035.GA24888@spearce.org>
References: <200607311956.00679.Alexander.Zvyagin@cern.ch> <ealhrj$pdo$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 00:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7g7v-0006vD-P0
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 00:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWGaWUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 18:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWGaWUk
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 18:20:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8085 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751383AbWGaWUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 18:20:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G7g7f-0000hV-T6; Mon, 31 Jul 2006 18:20:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5A87820E456; Mon, 31 Jul 2006 18:20:35 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ealhrj$pdo$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24550>

Jakub Narebski <jnareb@gmail.com> wrote:
> Alexander ZVYAGIN wrote:
> 
> > I failed to find in the documentation how to look to a file content
> > at some moment in a past.
> > 
> > Something like this:
> > $ git checkout master~2 Makefile
> > when I specify not the revisions numbers ago the file was (~2),
> > but the time, for example "2005-12-12 00:00:00" or something like this.
> > 
> > Where should I look at?
> 
> Either use git rev-list with --since=datestring, --after=datestring,
> --until=datestring, --before=datestring to find a commit, or if you have
> reflog enabled (you have .git/logs/refs/) you can use @{date} syntax,
> see 'man git-rev-parse'
> 
> "A suffix @ followed by a date specification enclosed in a brace pair  (e.g.
>  {yesterday},  {1  month  2 weeks 3 days 1 hour 1 second ago} or {1979-02-26
>  18:30:00}) to specify the value of the ref at a prior point in  time.  This
>  suffix  may  only be used immediately following a ref name and the ref must
>  have an existing log ($GIT_DIR/logs/<ref>)."

I'd like to add something to the discussion, at least for the
benefit of the archives:

There's a semantic difference between the two date specification/query
styles suggested above:

	git rev-list with --since, --after, --until, --before will
	look at the date of the commit;

	@{date} after a ref name will look at the commit that was
	stored under that ref name at that point in time.

These are two entirely different timelines.  For example someone
could make a commit on Tuesday which you pull into your repository
on Thursday.  The commit will say (and thus git rev-list with
--since will say) that the file version existed on Tuesday, but the
reflog would say that the file version existed only as of Thursday,
as that was when it became available to your repository.

-- 
Shawn.
