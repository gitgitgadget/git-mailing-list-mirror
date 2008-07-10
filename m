From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull is slow
Date: Thu, 10 Jul 2008 17:28:46 +0200
Message-ID: <20080710152846.GB32184@machine.or.cz>
References: <g5570s$d5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Hennig <mailing_list@arcor.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyCL-0006Tc-80
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759880AbYGJP2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759879AbYGJP2z
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:28:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39999 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759866AbYGJP2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:28:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 757522C4C02F; Thu, 10 Jul 2008 17:28:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g5570s$d5m$1@ger.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87981>

  Hi,

On Thu, Jul 10, 2008 at 04:40:17PM +0200, Stephan Hennig wrote:
> I am observing very large data transfers when pulling from the
> repository at <URL:http://repo.or.cz/w/wortliste.git>.  This repository
> contains one 13 MB text file that compressed is roughly 3 MB large.
> 
> While I'd expect pulling commits that change only a few lines of the
> large text file to result in a download of less than, say 10kB, git pull
> seems to transfer the complete, compressed file.  I have observed this
> several times for different commits.  On the other hand, pushing my own
> commits to the repository is fast (with git+ssh access method).  Any
> ideas what's going on and how to make pulling faster?

  do you use HTTP or native Git protocol for pulling? If HTTP, you have
to live with this, sorry - the automatic repacks will create a new pack
every time and you will have to redownload the whole history; I tried to
avoid this problem but in the end I had to bow down to the agressive
repacking strategy because the number of packs was getting out of hand.
It is technically possible to implement some alternative more
HTTP-friendly packing strategy, but this has always stayed only in idea
stage. If you want to implement something, repo.or.cz will become a glad
user. :-)

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
