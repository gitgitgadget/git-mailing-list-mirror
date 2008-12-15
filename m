From: Theodore Tso <tytso@mit.edu>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 14:38:37 -0500
Message-ID: <20081215193837.GB11502@mit.edu>
References: <808wqhzjl9.fsf@tiny.isode.net> <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com> <20081215140834.GA3684@atjola.homenet> <20081215155610.GA11502@mit.edu> <m3vdtlcqp6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 20:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCJIU-0005Jo-AY
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 20:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYLOTim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbYLOTim
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:38:42 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:44306 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752078AbYLOTil (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:38:41 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LCJH4-0004S5-5d; Mon, 15 Dec 2008 14:38:38 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LCJH3-0005IU-BA; Mon, 15 Dec 2008 14:38:37 -0500
Content-Disposition: inline
In-Reply-To: <m3vdtlcqp6.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103201>

On Mon, Dec 15, 2008 at 09:07:39AM -0800, Jakub Narebski wrote:
> 
> There was an idea to have "git gc --prune" run "git prune"
> unconditionally, i.e. without grace period for dangling loose objects.
> 

That doesn't help that much, since (temporarily) you still need all of
the disk space for the exploded, unpacked objects.  As Brandon Casey
pointed out, the key is "git repack -a -d -l" vs "git repack -A -d
-l".  If there is going to be a git-gc option, it would need to change
the options sent to git-repack.  Or, I suppose the answer is to tell
people who run into this problem use a plumbing command, manually.
The question is how common is the use case of needing to gc a
repository like linux-next, I suppose.

							- Ted
