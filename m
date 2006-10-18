From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 23:10:34 -0400
Message-ID: <45359B2A.1070102@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>	<45357411.20500@utoronto.ca>	<200610180246.18758.jnareb@gmail.com>	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 05:11:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga1qA-0000oq-E5
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 05:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWJRDL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 23:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWJRDL2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 23:11:28 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:42440 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751214AbWJRDL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 23:11:27 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Ga1pu-0007ez-00; Tue, 17 Oct 2006 23:11:22 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <871wp6e7o9.wl%cworth@cworth.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29181>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Carl Worth wrote:
> Aaron, thanks for carrying this thread along and helping to bridge
> some communication gaps. For example, when I saw your original two two
> diagrams I was totally mystified how you were claiming that appending
> a couple of nodes and edges to a DAG could change the "order" of the
> DAG.
> 
> I think I understand what you're describing with the leftmost-parent
> ordering now. But it's definitely an ordering that I would describe as
> local-only. That is, the ordering has meaning only with respect to a
> particular linearization of the DAG and that linearization is
> different from one repository to the next.

Well, the linarization for any particular head is well-defined, but
since different branches have different heads...

> If in practice, nobody does the mirroring "pull" operation then how
> are the numbers useful? For example, given your examples above, if
> I'm understanding the concepts and terminology correctly, then if A
> and B both "merge" from each other (and don't "pull") then they will
> each end up with identical DAGs for the revision history but totally
> distinct numbers. Correct?

The DAGs will be different.  If A merges B, we get:

a
|
b
|\
c d
|\|
| e
|/
f

If B merges A before this, nothing happens, because B is already a
superset of A.

If B merges afterward, we get this:
a
|
b
|\
d c
|/|
e |
|\|
| f
|/
g

> So in that situation the numbers will not help A and B determine that
> they have identical history or even identical working trees.

They don't really have identical history.

> So what good are the numbers?

They are good for naming mainline revisions that introduced particular
changes.

> I can see that the numbers would have applicability with reference to
> a single repository, (or equivalently a mirror of that repository),
> but no utility as soon as there is any distributed development
> happening.

Well, there's distributed, and then there's *DISTRIBUTED*.  We don't
quasi-randomly merge each others' branches.  We have a star topology
around bzr.dev.  So when we refer to revnos, they're usually in bzr.dev.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNZsp0F+nu1YWqI0RAkmWAJ9PkrkubIHVgAn5Wbdkg9IBAHCviACdFx2x
6ClmK4GmC1pRuRQACcSijNM=
=SM1Y
-----END PGP SIGNATURE-----
