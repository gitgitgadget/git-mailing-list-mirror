From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 17:25:08 -0400
Message-ID: <20070904212507.GA24434@thunk.org>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com> <7vtzqany0z.fsf@gitster.siamese.dyndns.org> <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:25:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISftn-0006sI-1v
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbXIDVZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 17:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbXIDVZW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:25:22 -0400
Received: from THUNK.ORG ([69.25.196.29]:58623 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbXIDVZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 17:25:21 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1ISg2c-0007bT-As; Tue, 04 Sep 2007 17:34:34 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1ISftU-0000iU-F5; Tue, 04 Sep 2007 17:25:08 -0400
Content-Disposition: inline
In-Reply-To: <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57648>

On Tue, Sep 04, 2007 at 01:44:47PM -0400, Jon Smirl wrote:
> The current data store design is not very flexible. Databases solved
> the flexibility problem long ago. I'm just wondering if we should
> steal some good ideas out of the database world and apply them to git.
> Ten years from now we may have 100GB git databases and really wish we
> had more flexible ways of querying them.

Databases solved the flexibility problem, at the cost of performance.
And if you use full normalized form in your database scheme, it costs
you even more in performance, because of all of the joins that you
need in order get the information you need to do, you know, useful
work as opposed to database wanking.

If you take a look at the really big databases with super high
performance requirements, say like those used to managed airline
tickets/reservation/fares, you will find that they are not normalized,
and they are not relational; they can't afford to be.  And if you take
a look at some of git competition that use relational databases to
store their SCM data, and take a look at how loooooong they they take
to do even basic operations, I would say that the onus is on you to
prove that normalization is actually a win in terms of real (not
theoretical) advantages, and that it doesn't cause performance to go
into the toilet.

I think the fundamental disconnect here is that no one is buying your
claim that just because the data design is "more flexible" that this
is automatically a good thing in and of itself, and we should even for
a moment, "put performance aside".  

I also don't think that attempting to force git's data structures into
database terms makes sense; it is much closer to an filesystem using
an object based store --- and very few people except for folks like
Hans Resiers believes that Filesystems and Database should be
unified....

						- Ted
