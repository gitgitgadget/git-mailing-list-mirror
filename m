From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Joining a fixed archive with its continuation
Date: Fri, 01 Sep 2006 16:12:04 +0200
Organization: At home
Message-ID: <ed9f3e$cvm$1@sea.gmane.org>
References: <44F81FE5.1040509@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 01 16:13:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJ9lC-0004CA-VV
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 16:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWIAOMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Sep 2006 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIAOMb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 10:12:31 -0400
Received: from main.gmane.org ([80.91.229.2]:46497 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750812AbWIAOMa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 10:12:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJ9kb-000439-OA
	for git@vger.kernel.org; Fri, 01 Sep 2006 16:12:05 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 16:12:05 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 16:12:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26301>

Sergio Callegari wrote:

>> If you want to be able to distribute it (or synchronize it between y=
our=20
>> laptop and PC _with git!_), you can rewrite the history by either=20
>> git-rebase, or by using cg-admin-rewritehist if you are using cogito=
=2E
>>
>> =A0=20
> I have tried using git-rebase (I do not have cg, at least not yet).
> However I am encountering some problems...
>=20
> Everything is fine with the master branch of my continuation archive =
doing
>=20
> git rebase fixed-master master
>=20
> (where fixed-master is the master head of the recovered archive)
> This does the trick nicely. I.e. I start with
>=20
> A---B---C---D =A0 =A0E---F---G---H---I
>=20
>=20
> where D is fixed-master and I is master, and I end up with
>=20
> A---B---C---D---E'---F'---G'---H'---I'
>=20
> plus the older tree E---...---I
>=20
> However I am then in trouble with the other branches of the continuat=
ion
> archive, which I simply cannot get right...
> In fact, E...I has actually a branch, say at G, like in
>=20
> E---F---G---H---I
> =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 --M---N
>=20
>=20
> And I cannot make an M'---N' based at G'... the best that I am
> succeeding in is building an
>=20
> E''--F''--G''--M'--N'=20
>=20
> based on D.

It is where --onto parameter of git-rebase is used. It means you use
<upstream> parameter to identify main branch in the continuation archiv=
e,
<branch> parameter being the branch you want to transplant into main
archive (i.e. <upstream>..<branch> being the part you want to
transplant/rebase), and '--onto <newbase>' with <newbase> being the new
fork point.

So in the abovementioned case, try

        git rebase --onto G' I N=20

and tell us if it works.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
