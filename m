From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Mon, 15 May 2006 01:58:30 -0400
Message-ID: <20060515055830.GC28068@spearce.org>
References: <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org> <20060513034051.GA21586@spearce.org> <7vody2v7yr.fsf@assigned-by-dhcp.cox.net> <20060513071753.GA21998@spearce.org> <20060513074328.GB21998@spearce.org> <Pine.LNX.4.64.0605130815550.3866@g5.osdl.org> <7vbqu1vps3.fsf@assigned-by-dhcp.cox.net> <20060513181816.GA12475@spearce.org> <7vk68o19n4.fsf@assigned-by-dhcp.cox.net> <20060515031511.GA27505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 15 07:59:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfW6k-0003GM-O4
	for gcvg-git@gmane.org; Mon, 15 May 2006 07:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWEOF6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 01:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWEOF6h
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 01:58:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60038 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932301AbWEOF6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 01:58:36 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FfW6E-0002N3-1R
	for git@vger.kernel.org; Mon, 15 May 2006 01:58:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3CC90212667; Mon, 15 May 2006 01:58:31 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060515031511.GA27505@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20023>

Shawn Pearce <spearce@spearce.org> wrote:
> Log ref updates to logs/refs/<ref>
> 
> If config parameter core.logAllRefUpdates is true or the log
> file already exists then append a line to ".git/logs/refs/<ref>"
> whenever git-update-ref <ref> is executed.  Each log line contains
> the following information:
> 
>   oldsha1 <SP> newsha1 <SP> committer <LF>
> 
> where committer is the current user, date, time and timezone in
> the standard GIT ident format.  If the caller is unable to append
> to the log file then git-update-ref will fail without updating <ref>.
> 
> An optional message may be included in the log line with the -m flag.

This is all well and good but its sort of useless without the diffcore
being able to lookup what SHA1 was valid on a given branch at a given
point in time.  :-)

I'm thinking about extending the 'extended SHA1' syntax to accept
a date (or date expression) as a suffix:

	HEAD@'2 hours ago'
	HEAD@'2006-04-20'
	HEAD@'2006-04-20 14:12'

etc... This would be merged into get_sha1 (sha1_name.c) so its
usable pretty much anywhere.  Does this seem reasonable?  If so
I'll work up a patch for it.

-- 
Shawn.
