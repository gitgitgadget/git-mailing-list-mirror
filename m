From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 19:10:54 +0100
Message-ID: <4B0AD02E.1040408@syntevo.com>
References: <4B0ABA42.1060103@syntevo.com> <200911231845.04325.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCdNX-0006yT-OJ
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbZKWSKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 13:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbZKWSKj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:10:39 -0500
Received: from syntevo.com ([85.214.39.145]:33308 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbZKWSKi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 13:10:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id E00F437C7B5
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <200911231845.04325.trast@student.ethz.ch>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133517>

Hi Thomas,

Thanks for the feed-back. I know the problem from SVN, too, but I had t=
he
hope, that Git was smarter than SVN for this topic. IIRC, one could get=
 SVN
working "somehow" with umlauts on OS X by setting some environment vari=
able.
Unfortunately, I don't remember the details any more.

Basically, getting it "somehow" to work on OS X is just one minor step.=
 IMHO
Git should standardize on file names in the repository and do the
platform-specific conversion independent of any locale setting, if need=
ed.
Then and only then it would be possible to get the same characters out =
of
the repository, no matter whether the file was added or checked out on =
OS X,
Linux or Windows.

At the moment we've got a problem report regarding our SmartGit GUI cli=
ent:
the user says, on command line it[1] works (German OS X) but not with
SmartGit, for me it doesn't even work on the command line (English OS X=
). As
you may know, Java uses characters for file names, the Java runtime
internally converts from the platform-specific byte-representation on d=
isk
to characters. I can't simply tunnel the file name as byte array to the
invoked Git command - I simply don't know how to transform the characte=
rs of
the file name to a representation the Git command line client will
understand[2].

Tom

[1] e.g. to stage or commit files with umlauts in the file name
[2] executing an external command in Java also "only" works with string=
s
(aka characters), not with byte sequences


Thomas Rast wrote:
> Thomas Singer wrote:
>> I'm on an English OS X 10.6.2 and I created a sample file with umlau=
ts in
>> its name (=DCberl=E4nge.txt). When I try to stage the file in the te=
rminal, I
>> can't complete the file name by typing the =DC and hitting the tab k=
ey, but I
>> can complete it by typing an U and hitting the tab key. Unfortunatel=
y, after
>> executing
>>
>>  git stage =DCberl=E4nge.txt
>=20
> This is because of OS X's unicode normalisation.  Try any of the
> many threads on the topic, e.g.,
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/70688
>=20
> The short version is that this =DC is in fact decomposed into an
> U-umlaut duo.
>=20
> Considering that this leads to endless fun[*] not just with git, and
> that we German speakers have an easy way out (Ueberlaenge), I can onl=
y
> suggest that you avoid umlauts wherever possible to preserve
> the sanity of your users.
>=20
>=20
> [*] I once had an SVN repo with two different directories both called
> =DCbungen.  Took me a while to figure out what was going on.
>=20
