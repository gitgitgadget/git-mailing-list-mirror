From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH 3/3] gitweb: Fill project details lazily when
	caching
Date: Tue, 18 Mar 2008 04:14:06 +0100
Message-ID: <20080318031406.GH10335@machine.or.cz>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com> <1205766570-13550-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 04:14:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbSHr-00037y-J6
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 04:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbYCRDOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 23:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbYCRDOK
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 23:14:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60832 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYCRDOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 23:14:09 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A43E6393BB0E; Tue, 18 Mar 2008 04:14:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1205766570-13550-4-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77484>

On Mon, Mar 17, 2008 at 04:09:30PM +0100, Jakub Narebski wrote:
> If caching is turned on project details can be filled in already from
> the cache.  When refreshing project info details for all project (when
> cache is stale and has to be refreshed) generate projects info only if
> modification time (as returned by lstat()) of projects repository
> gitdir changed.
> 
> This way we can avoid hitting repository refs, object database and
> repository config at the cost of additional lstat.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is an idea for further improvement of 'projects list caching'.
> Could you please: 
> 
>  1.) comment if it is a good idea, or why it works, or why it
>      couldn't work :),  

The idea is nice, but I'm surely missing something obvious again - why
do you use lstat() as opposed to stat()? And more importantly, the mtime
of projects repository unfortunately does not reflect almost any
changes per se; you would need to check mtime of description file,
config file and the refs instead.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
