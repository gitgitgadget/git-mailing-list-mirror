From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Two bugs with renaming
Date: Thu, 20 Mar 2008 02:24:54 +0100
Message-ID: <20080320012454.GA16843@atjola.homenet>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 02:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc9XI-0003tC-1v
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 02:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbYCTBY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 21:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755679AbYCTBY6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 21:24:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:57406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752650AbYCTBY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 21:24:57 -0400
Received: (qmail invoked by alias); 20 Mar 2008 01:24:55 -0000
Received: from i577AC8B9.versanet.de (EHLO atjola.local) [87.122.200.185]
  by mail.gmx.net (mp036) with SMTP; 20 Mar 2008 02:24:55 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18jDW1FMlsj/QB9A/wd0DAodcQVIPUKLHLU3WA7yE
	NSge4YvXxErGu5
Content-Disposition: inline
In-Reply-To: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77611>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2008.03.19 18:21:27 -0500, John Goerzen wrote:
> Hi folks,
> 
> I have a transcript of a Git session that illustrates two odd bugs
> with Git renaming.  Command output is truncated except where
> interesting.

I have another one. Well, not necessarily a bug, but at least something
that looks like it could be improved. I found that while trying to
reproduce bug #1 (which doesn't show up here, as I'm using
1.5.5-something).

It seems to boil down to the fact that even when git detected a rename
during a merge, it still uses the original file name to check for
conflicts, causing somewhat bogus conflicts.

Test script is attached, when I run that, git correctly applies the
changes from foo/file in master to foo2/file in "other", but
nevertheless it complains that "foo" conflicts, although the directory
is effectively empty and should therefore not be of any interest to git.

Björn

--u3/rZRmxL6MmkK24
Content-Type: application/x-sh
Content-Disposition: attachment; filename="t.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0Amkdir t=0Acd t=0A=0Agit init=0A=0Amkdir foo=0Atouch foo/file=0A=
git add foo/file=0Agit commit -m init=0A=0Aecho 123 > foo/file=0Agit commit=
 -a -m 123=0A=0Agit checkout -b other HEAD^=0Agit mv foo foo2=0Agit commit =
-m rename=0A=0Aln -s /tmp/nothinghere foo=0Agit add foo=0Agit commit -m sym=
link=0A=0Agit merge master=0A
--u3/rZRmxL6MmkK24--
