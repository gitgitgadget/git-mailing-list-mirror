From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Using Git with windows
Date: Mon, 09 Mar 2009 18:29:25 +0000
Message-ID: <49B56005.5010802@ramsay1.demon.co.uk>
References: <e878dbad0903052321l6c0d310bk2ba568138b409d36@mail.gmail.com> <c115fd3c0903060638lfc52073nd40e0d7379d7f593@mail.gmail.com> <49B2B638.2090506@obry.net> <200903072002.38698.robin.rosenberg.lists@dewire.com> <49B2C529.6010002@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Tim Visher <tim.visher@gmail.com>,
	Tariq Hassanen <tariq.hassanen@gmail.com>, git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Mon Mar 09 19:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgkJM-000493-2Q
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 19:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbZCISdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 14:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZCISdT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 14:33:19 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:40425 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751394AbZCISdS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 14:33:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1LgkHr-0002kL-dn; Mon, 09 Mar 2009 18:33:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <49B2C529.6010002@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112730>

Pascal Obry wrote:
> Robin Rosenberg a =C3=A9crit :
>> I think that worked fine when I tried using cygwin's apache. Mixing =
a cygwin
>> git with a win32 apache did not work well.
>=20
> Well, I tried with lighttpd IIRC. I do not want Apache just for brows=
ing
> a Git repo.
>=20
Pascal, I also installed lighttpd on cygwin, just so that I could test =
gitweb
and cgit (I have Apache installed on Linux).  I had a few problems gett=
ing it
to work at first. Only later did I notice that "git-instaweb" didn't wo=
rk.
Having fixed the installation problems earlier, I fixed git-instaweb an=
d then
forgot to send in the patch. Oops... Patch on the way... ;-)

[I had intended to make several other changes and submit it later...]

You may also notice that "git-instaweb" does not provide the git-logo.p=
ng
and git-favicon.png; so if that bothers you, just copy those files from
your git repo into the target repo's .git/gitweb directory. (That was o=
ne
of the things I was going to look at fixing)

<off-topic>
Note: if you decide to try cgit, then be aware that lighttpd has a bug =
which
causes problems with mixed-case pathnames in the pathinfo. lighttpd dow=
n-cases
the filename part of the pathinfo when on a case insensitive filesystem=
, so
cgit can't find the corresponding blob. (This is not a problem with git=
web).

I sent a fix for this bug to (who I thought was) the lighttpd maintaine=
r, but
didn't get any response; so don't count on a fix for this.

An amusing, but impractical, workaround for this is to name your docume=
nt root
something like /123 ie the path is numeric (and so does not differ in c=
ase ;-)
[lighttpd uses a runtime test of the case-sensitive-ness of the documen=
t root
pathname to control this behaviour]

Also, I could not get lighttpd to execute a cgi program with an ".exe" =
extension
so I had to create a simple script, viz:

$ cat /var/www/cgit/cgit.cgi
#!/bin/sh
exec /var/www/cgit/cgit.cgi.exe
$
<off-topic>

ATB,
Ramsay Jones
