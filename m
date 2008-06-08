From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 0/23] Implementation of a file tree iteration using ignore rules.
Date: Sun, 8 Jun 2008 23:28:49 +0200
Message-ID: <200806082328.49632.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <200806060222.40654.robin.rosenberg.lists@dewire.com> <484C0ACA.8080702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian =?iso-8859-1?q?K=F6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:33:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SVP-00074Z-AG
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbYFHVb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755840AbYFHVb4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:31:56 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3098 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755817AbYFHVbz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 17:31:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 396588006B6;
	Sun,  8 Jun 2008 23:31:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqzKz2JLk8Pw; Sun,  8 Jun 2008 23:31:52 +0200 (CEST)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 913C880287C;
	Sun,  8 Jun 2008 23:31:52 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <484C0ACA.8080702@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84325>

s=F6ndagen den 8 juni 2008 18.37.30 skrev Florian K=F6berle:
(please retatain who said what)
> >> Unsupported are colon expressions like ":alpha:". I didn't expect =
git-add to support it, but as I just noticed git does.
> > Maybe we should anticipate it and throw an exception if one tries t=
he pattern and not treat it as [alph:] .
> >=20
> > Well we noted they were broken in Git so (separate thread) so we ma=
y as well try something sane.=20
> Just did some tests and noted that the shell and git does not support=
=20
> them. I guess I thought that they work because [:alpha:] matched "a".
>=20
> Hi Robin
>=20
> The bash shell doesn't support [:alpha:] too:
> $ mkdir test
> $ cd test
> $ touch a
> $ touch b
> $ touch :
> $ ls [:alpha:]
> :  a
Oh, it does. [:alpha:] is a character class, like a-z. So you use [[:al=
pha:]], which is what git as well as bash
understands.

> The fnmatch function of the python module fnmatch=20
> (http://docs.python.org/lib/module-fnmatch.html) does not support=20
> :alpha: too.
>=20
> example:
> $python
>  >>> from fnmatch import fnmatch
>  >>> fnmatch("a","[:alpha:]")
> False
Hmm. Odd:

$ python
Python 2.5.2 (r252:60911, Apr 12 2008, 01:47:55)
[GCC 4.2.3 (4.2.3-6mnb1)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> from fnmatch import fnmatch
>>> fnmatch("a","[:alpha:]")
True

But then, it's matching the a(s), not the character class.

>>> fnmatch("x","[:alpha:]")
=46alse
>>> fnmatch("x","[[:alpha:]]")
=46alse

-- robin
