From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: msysGit and SCons: broken?
Date: Thu, 13 Aug 2009 21:32:42 +0200
Message-ID: <4A846A5A.4000000@dirk.my1.cc>
References: <4A772A43.8070503@dirk.my1.cc> <alpine.DEB.1.00.0908040010220.8306@pacific.mpi-cbg.de> <4A7B32EA.2080505@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbg2j-0002zU-JZ
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbZHMTcq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 15:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbZHMTcp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:32:45 -0400
Received: from smtprelay09.ispgateway.de ([80.67.31.43]:47823 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbZHMTcp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:32:45 -0400
Received: from [84.176.97.202] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Mbg4V-00027N-AF; Thu, 13 Aug 2009 21:34:47 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A7B32EA.2080505@dirk.my1.cc>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125856>

Am 06.08.2009 21:45 schrieb Dirk S=FCsserott:
> Am 04.08.2009 00:13 schrieb Johannes Schindelin:
>> On Mon, 3 Aug 2009, Dirk S=FCsserott wrote:
>>
>> How does your SCons call relate to Git?  Do you call it from the Git=
=20
>> Bash?  Do you call it from cmd.exe directly?  Is Git/bash in your PA=
TH?
>=20
> I used to call SCons from Git-bash and it worked. After Git's upgrade=
=20
> (or some other unknown change) I did the same and it didn't work from=
=20
> Git-bash, but it still worked from cmd.exe. Git-bash ist not in my PA=
TH=20
> when I run cmd.exe.

If someone had the same or a similar problem: I tracked it down and
found a solution. The problem was that I tried to run a Windows program
from git-bash. The Windows program then faces the bash's $PATH with a
different separator (':' vs. ';') and a different root directory ('/c/'
vs. 'C:/'). Scons tries to split the PATH apart to figure out which
tools are installed. ActivePython thinks ';' is the right separator and
then fails. Thus, I wrote a wrapper to call Scons after manipulating th=
e
$PATH variable by first exchanging the separator and then exchanging
'/c/' with 'c:/'.

=46unny, though, that my things worked a few weeks ago *without* this
wrapper. Dunno why. At least it hasn't anything to do with my Git
update. I proved that by installing earlier versions of Git.

	Dirk
