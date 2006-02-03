From: Junio C Hamano <junkio@cox.net>
Subject: Re: The merge from hell...
Date: Thu, 02 Feb 2006 22:28:43 -0800
Message-ID: <7vbqxpj6qs.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE7FF@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0602022139190.3462@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 07:28:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4uR9-0002jA-7L
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 07:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWBCG2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 01:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWBCG2q
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 01:28:46 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:37106 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWBCG2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 01:28:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203062615.KMIZ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 01:26:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602022139190.3462@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 2 Feb 2006 21:45:57 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15530>

Linus Torvalds <torvalds@osdl.org> writes:

> The 12-way merge was a bit over the top, but it worked. I'd suggest not 
> beign quite _that_ aggressive in the future, though, but it's not a big 
> deal.

Heh, I was quietly planning to raise the limit, or lift it
altogether ;-).

I find Len's explanation that those topics cooked independently
and happened to mature at about the same time an excellent
excuse to record this as an Octopus, and with that usage there
is no inherent reason, other than making the diff completely
unreadable, to limit the number of parents.  But I tend to agree
that the current 16 is a sane limit in practice.

That reminds me of another practical limit I've known but did
nothing about for quite some time (you may not even remember
doing that parser anymore).  This does not work for Len's merge:

	$ git rev-parse --verify funmerge^10

You could do a 16-way merge but 12-way is already hitting
usability limit, depending on what you would want to do with
them.  For example, you cannot easily decompose the topic
branches out of that merge, like this:

	$ git checkout -b redo-3549 funmerge^2     ;# works
        $ git checkout -b redo-pnpacpi funmerge^12 ;# doesn't

> One thing I'd ask for: would it be possible to have more descriptive 
> branch names than just numbers? Even if you want to track it by bugzilla 
> entry number, how about calling it "bugzilla-12345" instead? 

When kernel people (not just Len) talk about a "bugzilla ID",
does that ID always come from the same namespace, or do some
subsystems have their own bugzilla?
