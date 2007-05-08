From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --no-reuse-delta, --window, and --depth options to git-gc
Date: Mon, 07 May 2007 21:43:15 -0700
Message-ID: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
References: <E1HlFqU-0002ir-GK@candygram.thunk.org>
	<alpine.LFD.0.99.0705072305270.24220@xanadu.home>
	<20070508032122.GA10940@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 06:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHXo-0001IQ-0k
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966795AbXEHEnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967718AbXEHEnR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:43:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63085 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966795AbXEHEnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 00:43:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508044316.TXDO26353.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 00:43:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wUjE1W00H1kojtg0000000; Tue, 08 May 2007 00:43:15 -0400
In-Reply-To: <20070508032122.GA10940@thunk.org> (Theodore Tso's message of
	"Mon, 7 May 2007 23:21:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46535>

Theodore Tso <tytso@mit.edu> writes:

> On Mon, May 07, 2007 at 11:13:58PM -0400, Nicolas Pitre wrote:
>> ... 
>> Especially if you're aware and interested in those options, you won't be 
>> afraid of 'git repack -a -f -d --window=...".
>> 
>> In the context of "gc", having an option that reads "window" looks a bit 
>> strange too.
>
> I suppose, but you either need to then know all of the other commands
> which git-gc runs, and do them manually, skipping git-gc altogether,
> or use git-gc, and end up rewriting the pack twice,...

If the user really wants to tweak the parameters that much and
that often, I think what Nico says, plus your pack.depth/window
configuration variables, make more sense.  git-gc is meant to be
a shorthand with reasonable "one size fits all" default, and
there is something wrong if a user has to give customization
option every time it is run.  It could be that the default
parameters are grossly off for _everybody_, in which case we
should fix the default.

With the recent introduction of delta base caching code, we
might want to tweak the default pack depth to larger value for
everybody, by the way.
