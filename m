From: jeffpc@josefsipek.net
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Sun, 4 Jul 2010 23:01:08 -0400
Message-ID: <20100705030107.GR22659@josefsipek.net>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025117.GC6384@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 05 05:10:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVc4k-0006o5-5W
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 05:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0GEDKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 23:10:12 -0400
Received: from josefsipek.net ([141.212.112.63]:52990 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab0GEDKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 23:10:10 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 152747EDB; Sun,  4 Jul 2010 23:01:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100705025117.GC6384@thunk.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150239>

On Sun, Jul 04, 2010 at 10:51:17PM -0400, tytso@mit.edu wrote:
> On Sun, Jul 04, 2010 at 10:23:59PM -0400, Theodore Ts'o wrote:
> > +		ct=$(git log -1 --pretty=%ct)
> > +		if [ $ct -gt $(stat -c %Y "$p") ]; then
> > +		    echo "Warning time went backwards, adjusting mod time of" \
> > +			$(basename "$p")
> > +		    touch -d @$(expr $ct + 60) "$p" || touch "$p"
>                                                     ^^^^^^^^^^^^^
> 
> hmm, I just realized, this is strictly speaking not necessary.
> 
> "stat -c %Y" means that guilt only works if GNU coreutils is
> installed, which means that "touch -d @secs-since-epoch" should also
> work.
> 
> This will be a problem on legacy systems such as Solaris (unless their
> path puts the GNU utilities head of their System V-style utilities),
> but that's going to be true of guilt in general, it looks like.

I've been meaning to make guilt less GNU-dependant, but I just don't use
non-Linux systems enough (read: almost never) to do it myself.

Jeff.

-- 
The box said "Windows XP or better required". So I installed Linux.
