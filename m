From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Need some help with git rebase
Date: Wed, 30 Dec 2009 23:46:24 +0100
Message-ID: <CB5B49CA-0C66-4384-9B47-3675E517E203@wincent.com>
References: <4B38B3A7.6010900@steek.com> <1262211866.7068.1.camel@kheops>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: sylvain@abstraction.fr
X-From: git-owner@vger.kernel.org Wed Dec 30 23:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ7LR-0001nA-8S
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 23:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbZL3Wqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 17:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbZL3Wqh
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 17:46:37 -0500
Received: from outmail128067.authsmtp.com ([62.13.128.67]:59957 "EHLO
	outmail128067.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbZL3Wqg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 17:46:36 -0500
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nBUMkWar079062;
	Wed, 30 Dec 2009 22:46:32 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nBUMkS4E076335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Dec 2009 22:46:29 GMT
Received: from [192.168.1.2] (231.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.231])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id nBUMkOOx003247
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 30 Dec 2009 17:46:27 -0500
In-Reply-To: <1262211866.7068.1.camel@kheops>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 2bcb366b-f595-11de-97bb-002264978518
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH aR4dAldYdwdEHQAR AWQBX1JeU10/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSncNfEdi AmseVR9xdAAIcH55 YQhgDCMJX0J8J1sr R0dRCGwHMTJ9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcRtSMy5w BAg2MngxMDFHYDtU XgFFIlMOCVwGFDcn SngA
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135927>

El 30/12/2009, a las 23:24, Sylvain Rabot escribi=F3:

> So,
>
> I tried again "git rebase --onto 12.72.1 master feature".
>
> Situation :
>
>                         a--a--a--a--a--a--a--a--a feature
>                        /
> --x--x--x--x--x--x--x--x--x--x--x--x master
>   \
>    o--o--o--o--o--o--o 12.72.1
>
>
> Work flow :
>
> $ git checkout 12.72.1
> $ git rebase --onto 12.72.1 master feature
>
> a lot of conflicts, resolving and git rebase --continue
>
> And then, at the end of the rebase, without me doing anything, featur=
e
> branch is checked out and it seems that its HEAD has been reset to th=
e
> new 12.72.1 HEAD.
>
> --x--x--x--x--x--x--x--x--x--x--x--x master
>   \
>    o--o--o--o--o--o--o--a--a--a--a--a--a--a--a--a 12.72.1 feature
>
> Is that normal ? If it is, how do I do to avoid my feature branch to =
=20
> be
> reset at 12.72.1's HEAD ?
>
> Any enlightenment is very welcome.

Look at the "git-rebase" man page, particularly the order of the =20
arguments, what they mean, and the usage examples of "--onto":

   $ git rebase --onto 12.72.1 master feature

Means, "replay these changes on top of 12.72.1", where "these changes" =
=20
refers to commits on branch "feature" with upstream "master", which is =
=20
what "git rebase" did for you.

If you actually want the "feature" branch to continue pointing at the =20
old feature branch rather than your newly rebased one, you could just =20
look up the old SHA1 for it and update it with:

   $ git branch -f feature abcd1234

Where "abcd1234" is the hash of the old "feature" HEAD.

But I don't really know why you'd want to do that. The purpose of "git =
=20
rebase" isn't to copy or cherry-pick commits from one branch onto =20
another, but to actually _move_ (or transplant, or replay, if you =20
prefer) those commits.

Maybe I misunderstood your intentions though.

Cheers,
Wincent
