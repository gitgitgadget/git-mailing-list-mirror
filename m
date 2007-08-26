From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Branch naming -- allowed characters?
Date: Sun, 26 Aug 2007 12:17:35 +0200
Message-ID: <20070826101735.GI1219@pasky.or.cz>
References: <bqcuhe0c.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 12:17:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPFBk-0007OW-3C
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 12:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbXHZKRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 06:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXHZKRh
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 06:17:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49427 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbXHZKRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 06:17:37 -0400
Received: (qmail 26714 invoked by uid 2001); 26 Aug 2007 12:17:35 +0200
Content-Disposition: inline
In-Reply-To: <bqcuhe0c.fsf@cante.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56684>

On Sun, Aug 26, 2007 at 10:54:43AM CEST, Jari Aalto wrote:
> I just noticed this while trying to track quilt project and making a
> local branch with name '.pc':
> 
>     'fatal: '.pc' is not a valid branch name.'
> 
> Would it be possible to allow using arbitrary names with branches in
> future git, even UTF-8?
> 
> If that is not possible, would it be possible to at least broaden the
> charcter set with regular typeable US ascii letters, excluding the
> control ones. Something found in filenames/URLs. Like regexp:
> 
>     [][{}()_=+%!&@#~*.:;,/A-Za-z-]

I think UTF-8 might be possible, though I'd be careful because of legacy
systems (my main home system could be still considered "legacy", for
example; BTW, does Linux fbcon already support reasonable utf8 _and_
16*16 colors?). If legacy system cannot display commit message properly,
it's not that big deal and besides the message is usually still mostly
legible. If you cannot properly refer a branch because you live on a
legacy system, that makes for a showstopper.

About extending the allowed characters, one issue is caring whether we
and all the procelain make sure to quote branch name properly
everywhere. Hopefully so, but is anybode sure?

Bigger issue is that some of these characters have special meaning in
revids. For example ':' is special for Git, meaning "blob of given
filename in given tree". We want to keep some room for further grow and
possible added semantics. (For example, I still haven't completely given
up the idea of using dot-starting names for "autoprivate" refs. ;-)

Compared to this, the benefit of _allowing_ the special characters
doesn't seem to be very large and I can't really imagine many people
wanting to use = or + in their refnames.

> [*] Emacs even saves with names like: *Messages*

I'm sure vim can too. ;-)

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
