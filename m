X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 03 Dec 2006 12:00:20 +0100
Organization: At home
Message-ID: <ekuaka$6km$1@sea.gmane.org>
References: <20061120215116.GA20736@admingilde.org> <eksmrf$c33$1@sea.gmane.org> <200612030224.50592.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 10:58:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33104>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqp3W-0005Gn-0x for gcvg-git@gmane.org; Sun, 03 Dec
 2006 11:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935793AbWLCK6n convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 05:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935794AbWLCK6n
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 05:58:43 -0500
Received: from main.gmane.org ([80.91.229.2]:57734 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935793AbWLCK6m (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 05:58:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gqp3G-00017n-54 for git@vger.kernel.org; Sun, 03 Dec 2006 11:58:30 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 11:58:30 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 11:58:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Robin Rosenberg wrote:

> l=F6rdag 02 december 2006 21:16 skrev Jakub Narebski:
>>
>> The problem with submodule as separate git repository is that if you
>> move submodule (subproject) somewhere else in the repository (or jus=
t
>> rename it), you have to update alternates file... and this happens n=
ot
>> only on move itself, but also on checkout and reset. But that can be
>> managed by having in alternates all possible places the submodule en=
ds
>> into. I don't know if it is truly a problem.
>=20
> A nasty problem with separate repositories for submodules is that whe=
n you=20
> screw up and git complains about everything you try do do, you previo=
usly=20
> could do rm -rf *; git reset --hard and retry whatever you were tryin=
g to do.=20
> With separate repositories your submodules will be resting in /dev/nu=
ll,=20
> unless you're very, very careful.=20

The solution to this concern could be having GIT_DIR for submodule
outside it's working area, for example somewhere in GIT_DIR of
the supermodule, and use either symlink or (to be coded) .gitlink
symbolic reference to GIT_DIR file. Disadvantage of that is that it
moves troubles with moving subproject (although there are no troubles
with simple subproject directory renaming) from alternates file to
GIT_DIR link representation in submodule.

As Linus said, there are advantages to having submodule repository use
separate object database (clone and other operation scaling, index size=
),
and I think they outweight the troubles with moving/renaming the direct=
ory
submodule resides in.

P.S. I think that the problem with bad performance of too large index
is similar to the problems filesystems have with directories with large
number of files; some filesystems solved this problem.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

