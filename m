From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] describe: add option --dirty
Date: Mon, 23 Jul 2007 03:08:18 -0400
Message-ID: <20070723070818.GI32566@spearce.org>
References: <87odi3mxtl.wl@mail2.atmark-techno.com> <7vsl7fmwud.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:08:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICs1u-0000Hc-69
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbXGWHIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXGWHIY
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:08:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44656 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXGWHIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:08:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICs1j-0004k2-Mt; Mon, 23 Jul 2007 03:08:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 01CBE20FBAE; Mon, 23 Jul 2007 03:08:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vsl7fmwud.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53401>

Junio C Hamano <gitster@pobox.com> wrote:
> Yasushi SHOJI <yashi@atmark-techno.com> writes:
> 
> > when --dirty is given, git describe will check the working tree and
> > append "-dirty" to describe string if the tree is dirty.
> > ---
> > I'm not sure this is good idea or the current way (using diff-index in
> > shell script) is more prefered.
> 
> Hmph, this makes sense _ONLY_ for HEAD, doesn't it?
> 
> IOW, what should this output?
> 
> 	$ git checkout v1.5.0 ;# detached HEAD
>         $ git reset --hard  ;# clean slate
>         $ echo >>Makefile ;# not anymore
>         $ git describe --dirty v1.4.0^1
> 
> Should it say "v1.4.0-rc2-156-g0a8f4f0-dirty"?  The dirtiness
> does not have anything to do with commit v1.4.0^1, so...

Good catch.  I had that in my mind when I was reading the patch,
but failed to mention it.  I blame metze on #git, he interrupted
my train of thought.  ;-)


I think the answer is the user passes either --dirty OR one or
more commit-ish.  But not --dirty and a commit-ish.  In other words
you can either describe the working directory state, or a commit,
but not both at once.  Which also neatly solves my issue with
diff-index running more than once.

-- 
Shawn.
