From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Errors importing Apache Synapse SVN using Git
Date: Fri, 11 Jul 2008 00:02:53 +0200
Message-ID: <20080710220253.GD2325@atjola.homenet>
References: <4875F5D6.9080906@wso2.com> <4875FA23.30603@wso2.com> <g55130$n3i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4F5-00005A-Vb
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYGJWC5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 18:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbYGJWC5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:02:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:33843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753025AbYGJWC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:02:56 -0400
Received: (qmail invoked by alias); 10 Jul 2008 22:02:54 -0000
Received: from i577BB8BD.versanet.de (EHLO atjola.local) [87.123.184.189]
  by mail.gmx.net (mp046) with SMTP; 11 Jul 2008 00:02:54 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/VTxInxezV304FC9q3nWyhCDRsmWxhGzfvPupIQ/
	btapxlsmjpPRNE
Content-Disposition: inline
In-Reply-To: <g55130$n3i$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88015>

On 2008.07.10 14:59:11 +0200, Michael J Gruber wrote:
> Asankha C. Perera venit, vidit, dixit 10.07.2008 14:01:
>> Hi All
>>
>> I am an Apache Synapse developer, and want to import the Synapse SVN=
 =20
>> repo into Git, so that Ohloh can properly get the Synapse history =20
>> (http://www.ohloh.net/topics/1326?page=3D1#post_6287)
>>
>> However, when I try the command: "git svn clone --trunk=3Dtrunk =20
>> --tags=3Dtags --branches=3Dbranches=20
>> http://svn.apache.org/repos/asf/synapse" it seems to take forever, (=
or=20
>> at least until the next network glitch), and keeps filling up a file=
=20
>> with just plain zeros ("0") : =20
>> ./.git/svn/trunk/.rev_db.13f79535-47bb-0310-9956-ffa450edef68
>>
>> Can someone try the above command on the Synapse repo and tell me wh=
at=20
>> I can do to import from the SVN?
>
> "svn log" takes forever on that repo, too. Current rev seems to be =20
> 675546, and the synapse path does not exist in early revisions. Knowi=
ng =20
> the initial revision would help, then you could save "git svn" from =20
> having to comb through (supposedly) tens of thousands of irrelevant r=
evs.
>
> I just checked out trunk using svn 1.4.6, "svn log ." takes forever i=
n =20
> the root dir. So the svn repo seems to be largely unusable, at least =
=20
> when accessed from svn 1.4.6 clients (the server is 1.5.0, I see).
>
> Okay, I bisected it and got r234477 as the beginning of time for =20
> synapse. "svn log -r 234477:HEAD" is still painful.
>
> You may want to fetch 1000 revs each or so from there each time.

Also, upgrading git to 1.5.6.2 might be a good idea. It doesn't use the
=2Erevdb file format anymore, but a more efficient .revmap file. And it
has quite a few performance improvements (although they won't help
against the primary issue with that svn server). Don't use
1.5.6/1.5.6.1, they have a git-svn bug that can lead to corrupted clone=
s
(just in case that your distro has packages for those versions but not
yet got 1.5.6.2).

Bj=F6rn
