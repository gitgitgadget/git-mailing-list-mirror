From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: Replace use of "echo -n" with printf(3) to be more portable
Date: Thu, 29 Mar 2007 13:09:14 -0400
Message-ID: <20070329170914.GA9435@thunk.org>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <20070329155741.GA18413@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWy8B-0001Po-7z
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 19:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbXC2RJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 13:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbXC2RJ3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 13:09:29 -0400
Received: from thunk.org ([69.25.196.29]:43521 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030360AbXC2RJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 13:09:17 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWyDg-0007Vh-Bc; Thu, 29 Mar 2007 13:15:28 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWy7e-0006HC-23; Thu, 29 Mar 2007 13:09:14 -0400
Content-Disposition: inline
In-Reply-To: <20070329155741.GA18413@moooo.ath.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43458>

On Thu, Mar 29, 2007 at 05:57:41PM +0200, Matthias Lederhofer wrote:
> The subject should probably refer to printf(1) instead of printf(3).

Yep.

> Theodore Ts'o <tytso@mit.edu> wrote:
> > +	printf  "'$path' was deleted"
> Here is one space too much after printf.

This was fixed in a later patch.

> > +	printf "'$path' is a symlink containing '"
> You should use printf "'%s' [..]" "$path" as you do in some other
> places (in case $path contains conversion specifiers).

This was also obsoleted in a later patch, but you're right.

> > +    printf "Hit return to start merge resolution tool ($merge_tool): "
> Here it is much more unlikely that $merge_tool contains a conversion
> specifier but anyway I'd prefer to use %s.

Yep, agreed.

Junio, I've prepared an alterate patch series.  If you haven't pulled
from repo.or.cz, I'd appreciate it if you could pull from the
mergetool branch (instead of master) instead:

	http://repo.or.cz/w/git/mergetool.git

The differences between the patch series in the master and mergetool
branch are:

	* Change the description of the printf patch to say: 
		printf(3)->printf(1)
	* Fix the double space after printf and symlink %s conversion
		earlier in the patch series (only to have it disappear
		in the last patch, so this is a no-op at the end of
		the day, but more of an excuse to go play with stgit
		and in the name of anal-rententive correctness)
	* Use a %s printf conversion for the "Hit return to start merge..."
		statement as noted above in the last patch.

Thanks!!

(Apparently there's no way to forcibly reset the pointer of the master
head on repo.or.cz, probably for security/sanity reasons, without
going through an administrator.)

						- Ted
