From: "Joshua J. Kugler" <joshua@eeinternet.com>
Subject: Re: Problem signing a tag
Date: Mon, 09 Nov 2009 11:15:43 -0900
Organization: EE Internet
Message-ID: <200911091115.44098.joshua@eeinternet.com>
References: <200911021558.17550.joshua@eeinternet.com>
 <7vy6mk91ig.fsf@alter.siamese.dyndns.org>
 <4AF3F23B.8080203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 21:15:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7aeX-00028v-Lj
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbZKIUPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 15:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZKIUPm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:15:42 -0500
Received: from msgmmp-2.gci.net ([209.165.130.12]:50421 "EHLO msgmmp-2.gci.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbZKIUPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:15:41 -0500
Received: from hyperion.eeinternet.com ([206.174.62.163])
 by msgmmp-1.gci.net (Sun Java System Messaging Server 6.2-3.03 (built Jun 27
 2005)) with ESMTP id <0KSU00MNEYY97670@msgmmp-1.gci.net> for
 git@vger.kernel.org; Mon, 09 Nov 2009 11:15:46 -0900 (AKST)
Received: from hosanna.eeinternet.com (unknown [192.168.100.194])
	by hyperion.eeinternet.com (Postfix) with ESMTP id D6E883F21D; Mon,
 09 Nov 2009 11:15:45 -0900 (AKST)
X-Face: %RQZkR-ZZZ/},^dzp$qPotQ8:EI[dl6TX^9<K):};#rjcB`apZ95_e*NbqV8Db$,=?utf-8?q?r=7C7x=5FK=0A=09TOpQkS5A?=>=R9nGN)Qva<p+^;@rEbe*bA5XUd<=?utf-8?q?csl=3BT0d=5FP=3AdH21=2EuJAZ=24iao=26H!K=3A9u=7E=7B9=0A=09WV4=5BX4?=
 =?utf-8?q?*=7B=60=5Evlz=5FIVZ?=)R^X5{:l6#=%fLpM^!}~B"CN.R%wwU-Ni-L2TgD](24jBa=_G@
 =?utf-8?q?Zga=0A=09KNcSq4/Lv=3AJm!z=5D=2Ee5=25IgMb=5Cl-xGs=2EN5M4=5D=3A?=
 =?utf-8?q?vz2?="XrHM]j$h/aNM2J_1}}i@"
 =?utf-8?q?l=26Phy5=3FU1=0A=09mfdxMpo=7D?=)/ixNj03,scN>w*od72RYo9i+XAj
In-reply-to: <4AF3F23B.8080203@drmicha.warpmail.net>
Content-disposition: inline
User-Agent: KMail/1.9.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132519>

On Friday 06 November 2009, Michael J Gruber said something like:
> Junio C Hamano venit, vidit, dixit 05.11.2009 21:09:
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> >> Dig dig dig... gpg exits with 2 in a lot of cases, one would need
> >> to parse fd-error to find out more. But it also looks as if gpg
> >> exits normally with a good passphrase. So I tried, and at least
> >> with gpg 1.4.9 and git 1.6.5.2 I can sign tags with "use-agent"
> >> and without a running agent: I get asked for the passphrase (after
> >> reporting the agent MIA), and everything's fine.
> >>
> >> My gpg returns 0 in this case; it returns 2 only if I don't enter
> >> the passphrase. So, this seems to depend on the version of gpg. Or
> >> on entering the correct passphrase ;)
> >
> > If the problematic gpg that gives 2 is older than yours, the
> > situation looks to me that "exiting 2 when failed to contact agent
> > but got a good passphrase some other way and successfully signed"
> > was diagnosed as a bug and then fixed in gpg.  If that is the case
> > can we find out which version that fix is in, and add an entry to
> > FAQ to help next person who will be hit by this when using "tag
> > -s"?
>
> Both of us seem to be using gpg 1.4.9, which is weird. I even checked
> Fedora's srpm, they don't apply any patches for this. For the record,
> I'm doing
>
> unset GPG_AGENT_INFO
> echo a |gpg -bsa
>
> with "use-agent" and a default key signing specified in my gpg conf.
> This returns "0" if I enter the correct passphrase (after being
> warned about the missing agent) and "2" if I enter a wrong one
> repeatedly. Joshua, your reports seem to confirm that you get 2 in
> both cases from your gpg 1.4.9, right?

I discovered that there must have been something locked up or wedged.  =
I=20
rebooted (kernel update), and it worked. I looked at the warning again,=
=20
and realized that the warning I got when the exit value was 2 was:

gpg: problem with the agent - disabling agent use

while the warning I got when the exit value was 0 was:=20

gpg: gpg-agent is not available in this session

So, two different warnings.

Thanks again for all the troubleshooting help!

j

--=20
Joshua Kugler
Part-Time System Admin/Programmer
http://www.eeinternet.com
PGP Key: http://pgp.mit.edu/ =A0ID 0x14EA086E
