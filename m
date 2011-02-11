From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Plans for the vcs-svn-pu branch
Date: Fri, 11 Feb 2011 03:09:31 -0600
Message-ID: <20110211090931.GA27410@elie>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <20101205113717.GH4332@burratino>
 <20110105233915.GB22975@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 10:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnp0g-0000tz-Vy
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 10:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab1BKJJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 04:09:41 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64711 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab1BKJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 04:09:37 -0500
Received: by iwn9 with SMTP id 9so2201960iwn.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OW60ROPBy6pGbvhCqZoiCqwxYxKCcmlbdHAk6j0fcnw=;
        b=I3+tpWzmhCyIFxwiQqusjSauxn4u0gaCGtXYM7L9Nud4ZS5EzaF2ZPJZoZ/jKpeLAb
         d39RkmVNqWPzNkSl3ZRrzmFHRTgK163ju37Yv8gRImjagg1kXnByo+/arn5iQEwid7zg
         byTAtY3+B6Ki0PIZLTNbzn0YDSWNSughxXZHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DVVuRn9fkCC1zYqF2papjbIrT2llj4R+A8ZYR27c87cG3i9VhkqlM9jjKQzA9cVhf/
         Z5J2H+IQI5yota2xluG8EACtixUsxFDHpQi9pyr6SGiykAvRpnHYi3XLQpifYGJdTtEm
         eO22KPteSoaTUAsQ3cdpL27WcfNQ5IigXhhSM=
Received: by 10.231.60.7 with SMTP id n7mr186340ibh.146.1297415377232;
        Fri, 11 Feb 2011 01:09:37 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id u9sm491417ibe.8.2011.02.11.01.09.35
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 01:09:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110105233915.GB22975@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166544>

(culled cc list for a new topic)
Hi,

Jonathan Nieder wrote:

> Here are the topics that are cooking in vcs-svn-pu.

Long time no pushout.  My old plan was to maintain a "vcs-svn" branch
and ask Junio to pull from it periodically.  I still plan to do that
since I think it's the only feasible way to roll out the larger
changes but I might be submitting smaller pieces as patches to the git
list directly.

The purpose of this email is to request help --- if you are
particularly interested in some subtopic then I would love to see a
patch series or pull request on the subject.  If I can forget about
vcs-svn-pu's existence and just review and accept ready-to-apply
patches on the topic as they come, then building a suitable vcs-svn
branch will become very, very simple.

The good news is that it's been a calm time, so most of these topics
are probably in good shape.

> * db/fast-import-blob-access (2011-01-03)
>  - fast-import: add 'ls' command

Needs a feature name.  Last seen at [1].

> * db/optimize-vcs-svn (2011-01-05) 9 commits
>  - vcs-svn: drop obj_pool.h
>  - vcs-svn: drop trp.h
>  - vcs-svn: drop string_pool
[...]

Applying this code removal early would make your local branch juggler
very, very happy.  Might make sense to pair it with some patches to
support cat-blob-fd in transport-helper's "import" support, so the UI
could be

	git fetch svn-dump::/tmp/file.dump

That could (perhaps) partially compensate for the loss of convenience
from requiring the cat-blob-fd to be plumbed correctly.  It's a shame
we weren't louder about svn-fe's command line usage being subject to
change.  Live and learn. :/

>  (this branch uses db/vcs-svn-incremental, db/text-delta, db/prop-delta,
>   jn/svndiff0, jn/sliding-window, jn/line-buffer, jn/line-buffer-error,
>   jn/line-buffer-large-file, and db/fast-import-blob-access.)

That's silly --- this long overdue cleanup does not require anything
except db/fast-import-blob-access.  Building it on top of
db/prop-delta seems okay, since the latter is simple and known to work
well.

> * db/vcs-svn-incremental (2011-01-05) 20 commits
[...]
>  (this branch uses db/text-delta, db/prop-delta, jn/svndiff0,
>   jn/sliding-window, jn/line-buffer, jn/line-buffer-error,
>   jn/line-buffer-large-file, and db/fast-import-blob-access.)
>
> Support for importing different revs in different svn-fe runs.

Killer feature.  After db/optimize-vcs-svn it is easy.  It does not
need to wait for Text-delta and svndiff0 support.

[...]

With those three topics out of the way, the rest of the wishlist
should be easy.  Most of the patches are already written.

 - line-buffer enhancements to support Text-delta (multiple buffers,
   sliding window, temporary files)
 - svndiff0 parser/interpreter
 - Text-delta support
 - Prop-delta support
 - support for large files
 - improved error handling
 - fast-import scalability fixes
