From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: git-cvsserver commit trouble (unexpected end of file in client)
Date: Wed, 3 Oct 2007 16:57:08 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710031657.08622.wielemak@science.uva.nl>
References: <200710031348.50800.wielemak@science.uva.nl> <200710031513.44446.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 17:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id5kc-0007xM-Ng
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 17:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbXJCPCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbXJCPCw
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 11:02:52 -0400
Received: from imap.science.uva.nl ([146.50.4.51]:47389 "EHLO
	imap.science.uva.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbXJCPCv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 11:02:51 -0400
Received: from gollem.science.uva.nl [146.50.26.20]
          by imap.science.uva.nl with ESMTP (sendmail 8.13.8/config 11.38).
          id l93F2na8001146; Wed, 3 Oct 2007 17:02:49 +0200
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
User-Agent: KMail/1.9.5
In-Reply-To: <200710031513.44446.wielemak@science.uva.nl>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59843>

On Wednesday 03 October 2007 15:13, Jan Wielemaker wrote:
> $ mkdir /pub/my-repo.git
> $ cd /pub/my-repo.git
> $ git --bare init --shared
> $ git --bare fetch /home/alice/myproject master:master
>
> Checked out freshly using CVS. No problem. But committing a change,
> nothing changed :-( The log output is exactly the same, showing only
> refs/heads/master. I'm starting to suspect git-cvsserver afterall, but
> the docs suggests it is operational for quite a while. Could someone
> give me a clue on what am I missed?

More tests ...  As it didn't like the HEAD, and insisted it only knows
about master, I though what happens on

	cvs -d :ext:user@host:/git-repos.git co master

<works fine>
<edit>
	cvs commit
Commit failed (unknown reason)

:-(  Logfile says:

================================================================
2007-10-03 16:43:37 : INFO  - req_ci : [NULL]
2007-10-03 16:43:37 : INFO  - Lockless commit start, basing commit 
on '/tmp/VP2P
VNHPs0/6t4xncbMoN', index file is '/tmp/VP2PVNHPs0/SO4A6pzpau'
2007-10-03 16:43:37 : INFO  - Start git show-ref -s refs/heads/master
2007-10-03 16:43:37 : INFO  - Heads: 0b7b372d525a4fe7f662996fec9cd11b1038a6be 
re
fs/heads/master

2007-10-03 16:43:37 : INFO  - parenthash = 
0b7b372d525a4fe7f662996fec9cd11b1038a
6be

2007-10-03 16:43:37 : INFO  - Created index '/tmp/VP2PVNHPs0/SO4A6pzpau' with 
fo
r head master - exit status 0
2007-10-03 16:43:37 : INFO  - Committing collections-representation.txt
2007-10-03 16:43:37 : DEBUG - rename /tmp/VP2PVNHPs0/0SfbkMq6AN 
collections-repr
esentation.txt
2007-10-03 16:43:37 : DEBUG - chmod u+rw-x collections-representation.txt
2007-10-03 16:43:37 : INFO  - Updating file 'collections-representation.txt'
2007-10-03 16:43:37 : DEBUG - Treehash : 
aba0f583177b3b7fca05935452de22612164a7f
3, Parenthash : 0b7b372d525a4fe7f662996fec9cd11b1038a6be
2007-10-03 16:43:37 : INFO  - Commit hash :
2007-10-03 16:43:37 : WARN  - Commit failed (Invalid commit hash)
================================================================

!? What happens?  Is git-cvsserver completely broken and should I thus
forget about GIT for now (saying we cannot deal with cvs commit is
politically unacceptable in this project)?  Any clue?

	Please help

		--- Jan
