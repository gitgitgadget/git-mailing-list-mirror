From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: merge time
Date: Tue, 31 Jul 2007 00:11:09 +0200
Message-ID: <200707310011.10935.robin.rosenberg.lists@dewire.com>
References: <104942.93033.qm@web51008.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 00:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFdZ9-00011U-SY
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967657AbXG3WSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 18:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967474AbXG3WSL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 18:18:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29507 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S967451AbXG3WSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 18:18:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 507CF802840;
	Tue, 31 Jul 2007 00:10:47 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10175-06; Tue, 31 Jul 2007 00:10:46 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id D78EB8026FD;
	Tue, 31 Jul 2007 00:10:46 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <104942.93033.qm@web51008.mail.re2.yahoo.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54285>

m=E5ndag 30 juli 2007 skrev Matthew L Foster:
>=20
> --- david@lang.hm wrote:
>=20
> > On Mon, 30 Jul 2007, Matthew L Foster wrote:
> > > Local commit order is stored locally right?
> >=20
> > not normally. you could enable reflogs and then mine through the re=
flogs=20
> > to find the info, but it's not stored in any easy to access fashion=
=2E
>=20
> Local merge order can be extracted from git?=20

Well.. depending on what your definition of merge. Yes, probably.

I dislike the term "merge" here, since no merges has to be involved, un=
less you
include any pulled commit into the terms. Normally a merge is a commit =
with
two or more parents. Fast forward merges are indistinguishable from nor=
mal=20
commits.

That aside, you *can* (usually) figure the time when a commit entered t=
he repository by examining the
reflog if the set of branches are reasonably stable The reflog gives th=
e local time when a head
was modified (old and new commit) so from there you can usually go back=
wards. *But* that road is
full of pot holes. The reflog cannot per se tell when a commit entered =
the local repo, it can
tell when it came into view as seen from a particular head. Looking fro=
m different heads may
(will) give you different times. If the head that was used to pull the =
commit into the repo is
deleted you will not be able to tell when the commit entered the repo, =
nor will you be able to
tell whether you can tell that or not, since the reflog for that head i=
s gone.=20

The reflog doesn't list all commits, just changes to the head and it is=
n't necessarily linear either, ie.
it may change backward in "time" forward or even to a completely separa=
te set of commits.

The reflog is text-only: .git/logs/<ref-name>, e.g. .git/logs/refs/head=
s/master so you can see for
yourself.

-- robin
