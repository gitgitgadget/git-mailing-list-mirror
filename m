From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 15:38:48 -0700
Message-ID: <7v64sc9abr.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<4342F9A4.1090600@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 00:38:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMvR0-0007bQ-Iy
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 00:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVJDWiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVJDWiu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 18:38:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52218 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965025AbVJDWit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 18:38:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004223844.XBKX4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 18:38:44 -0400
To: cel@citi.umich.edu
In-Reply-To: <4342F9A4.1090600@citi.umich.edu> (Chuck Lever's message of "Tue,
	04 Oct 2005 17:52:36 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9692>

Chuck Lever <cel@citi.umich.edu> writes:

> two quick notes:
>
> 1.  git-update-ref has no documentation (i don't have time to sit down 
> and construct it, otherwise i'd post a patch).

Thanks; neither git-symbolic-ref.  I'll write them up.

> 2.  what is your thinking about including the cache abstraction layer 
> after 1.0 ?  i think it would help the libification effort.

I haven't had a chance to look at the code Smurf is working on,
but I suspect that your cache abstraction work would interact
badly with it if done independently and made into mainline
first, and would end up requiring some parts of libification to
be redone.

    From: Matthias Urlichs <smurf@smurf.noris.de>
    Date: Mon, 03 Oct 2005 22:48:54 +0200
    Message-ID: <pan.2005.10.03.20.48.52.132570@smurf.noris.de>

    I have started work on doing this "the right way"
    (as per earlier discussion).

    Current status: There's a toplevel "struct git_env", an associated "struct
    git_objdb", and (thread-safe and globals-free) library code to read
    sha1-identified object (meta)data, including packs and all.

    http://netz.smurf.noris.de/git/git.git#libize

    Next on my TODO list: introduce a "struct git_obj" which represents
    exactly one sha1 and the metadata associated with it, rename the
    accessor functions to be more consistent, add SWIG interface code and
    Python testcases, submit to everybody's scrutinity.

    After that, the task can hopefully be parallelized.

    Definitely a post-1.0 job; the job is too big, and shipping 1.0 with a
    partial library that doesn't do much that's useful does not make sense.

So if you have energy and inclination, I'd like to see you take
a look at the smurf tree, and if you can work with him and add
cache abstraction as part of the libification that would be the
ideal approach.  Then hopefully nobody has to do work twice.
