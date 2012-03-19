From: Will Deacon <will.deacon@arm.com>
Subject: Strange git merge behaviour with empty branches
Date: Mon, 19 Mar 2012 18:53:49 +0000
Message-ID: <20120319185349.GH12789@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 19:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9hiQ-0002RD-JX
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 19:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032455Ab2CSSxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 14:53:53 -0400
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:52421 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030981Ab2CSSxx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 14:53:53 -0400
Received: from mudshark.cambridge.arm.com (mudshark.cambridge.arm.com [10.1.79.58])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id q2JIrpWq026664
	for <git@vger.kernel.org>; Mon, 19 Mar 2012 18:53:51 GMT
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193447>

Hello git people,

I'm seeing some strange behaviour with git merge and wondered if you could
help me to understand what's going on.

Say I have a master branch tracking upstream and a few local branches based
off that:

$ git branch
  master
  foo
  bar
  baz

Furthermore, let's say that both foo and bar are currently at master (that
is, they have no additional commits) but baz does have changes committed on
top of master.

Now, if I make an integration branch:

$ git checkout master -b integration

I can then merge foo, bar and baz into this:

$ git merge foo bar baz

which works fine. However, specifying the non-empty branch first does:

$ git merge baz foo bar
Already up-to-date.

and the changes from baz are not merged in. For extra weirdness, if you
have another non-empty branch (qux) and do:

$ git merge baz foo bar qux

Then you end up with a branch that *doesn't* contain baz, *does* contain
qux and has a weird looking merge-commit message that just reads "baz"!

Now, I appreciate that merging in empty branches might seem weird but it's
sometimes useful if you have scripts that take a set of known branches, merge
them and then do a build.

Any thoughts?

Cheers,

Will
