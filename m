From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Add 'find-rev' command
Date: Sun, 29 Apr 2007 15:25:44 -0700
Message-ID: <20070429222544.GB1800@untitled>
References: <1177835727239-git-send-email-aroben@apple.com> <20070429183515.GF12375@untitled> <31790C65-1FE6-4BD4-B8D3-B285F0F0422A@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 00:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiHq8-0005Kc-MY
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 00:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161519AbXD2WZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161521AbXD2WZx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 18:25:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35444 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161519AbXD2WZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 18:25:52 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DCB4B7DC0A0;
	Sun, 29 Apr 2007 15:25:50 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 29 Apr 2007 15:25:44 -0700
Content-Disposition: inline
In-Reply-To: <31790C65-1FE6-4BD4-B8D3-B285F0F0422A@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45846>

Adam Roben <aroben@apple.com> wrote:
> On Apr 29, 2007, at 11:35 AM, Eric Wong wrote:
> 
> >Also, if you have time, can you get this (and 'log') to understand
> >revision numbers even if they're not from the working HEAD?  Thanks.
> 
>    Won't the following code accomplish that for find-rev? Perhaps I  
> misunderstand you.

working_head_info() only calls rev-list for a given head.

You should probably iterate through (like fetch_all does)
each remote and do rev_db_get via the Git::SVN object.

> >>+sub cmd_find_rev {
> >>+	my $revision_or_hash = shift;
> >>+	my $result;
> >>+	if ($revision_or_hash =~ /^r\d+$/) {
> >>+		my $head = shift;
> >>+		$head ||= 'HEAD';
> >>+		my @refs;
> >>+		my (undef, undef, undef, $gs) = working_head_info($head, 
> >>\@refs);

-- 
Eric Wong
