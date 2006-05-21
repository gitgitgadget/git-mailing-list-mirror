From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Make '@' not valid in a ref name.
Date: Sat, 20 May 2006 21:58:49 -0400
Message-ID: <20060521015849.GB7605@spearce.org>
References: <20060521013751.GA7516@spearce.org> <7vodxsywzk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:58:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhdDe-0000fm-AK
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWEUB6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWEUB6x
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:58:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:7891 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751347AbWEUB6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:58:53 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FhdDM-0005qs-9p; Sat, 20 May 2006 21:58:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B49E2212691; Sat, 20 May 2006 21:58:49 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodxsywzk.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20424>

Junio C Hamano <junkio@cox.net> wrote:
> I am not a fan of retroactively disallowing what we used to
> allow.  Is this unavoidable?
> 

We're talking about it on #git right now.  Someone actually uses
refs like 'user@host/foo' and thus doesn't like this patch either.

We were talking about disallowing '@{' instead.  Really its just
'@{<some run that smells like a date}' at the end of the ref which
would want to be disallowed; similiar to how ~ and ^ really only
need to be disallowed near the end.

The date parser grabs '@{' not '@' so 'user@host/foo@{yesterday}'
makes sense to it.  But 'user@{host}/foo@{yesterday}' is going
to cause problems as the date parser will attempt to evaluate
'host}/foo@{yesterday'.  :-(

-- 
Shawn.
