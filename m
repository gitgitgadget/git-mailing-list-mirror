From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Significant performance waste in git-svn and friends
Date: Thu, 06 Sep 2007 23:28:17 -0700
Message-ID: <46E0EF81.6060403@midwinter.com>
References: <20070905184710.GA3632@glandium.org> <20070906070407.GA19624@soma> <20070907045557.GY18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:28:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXKK-0001sZ-7p
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbXIGG2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXIGG2T
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:28:19 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:36979 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S932178AbXIGG2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 02:28:19 -0400
Received: (qmail 11240 invoked from network); 7 Sep 2007 06:28:18 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=r2Rb1fK4ItpwxtP/hBSvPpbPw+5n7tTefGk4bcqu1KwGVZJDl4nkal0pCsWCPceH  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 7 Sep 2007 06:28:18 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20070907045557.GY18160@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57985>

Shawn O. Pearce wrote:
> What will happen is you will get a packfile per git-svn fetch, so
> if you fetch 5 times that day you will get 5 packfiles that day.
> But you could also get 5 packfiles from git-fetch if each of those
> fetches brought in 100 or more new objects.  So it really is not
> that big of a deal.
>
> At some point the number of packfiles gets out of control, but so
> does the number of loose objects.  Repacking is the obvious fix in
> both cases.

This dovetails nicely with the "git gc --auto" work in progress, 
particularly the recent patch to pack small packfiles together when 
there get to be too many of them; run that at the end of every git-svn 
fetch and the problem goes away.

-Steve
