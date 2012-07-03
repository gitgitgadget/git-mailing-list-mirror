From: Brian Foster <brian.foster@maxim-ic.com>
Subject: Re: [Q] Branch aliases (synonyms)?
Date: Tue, 3 Jul 2012 15:40:13 +0200
Message-ID: <4261222.bYBuBBxnOa@laclwks004>
References: <1919214.YKUdgul2iY@laclwks004> <93cfd6eb9045585728dfe649359a103c@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Tue Jul 03 15:40:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm3LP-00005r-1D
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 15:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab2GCNkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 09:40:19 -0400
Received: from antispam01.maxim-ic.com ([205.153.101.182]:51915 "EHLO
	antispam01.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab2GCNkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2012 09:40:18 -0400
X-ASG-Debug-ID: 1341322816-02ae98587c260ac0001-QuoKaX
Received: from maxdalex02.maxim-ic.internal (maxdalex02.maxim-ic.internal [10.16.15.104]) by antispam01.maxim-ic.com with ESMTP id sZ3vZYfLy3vtceth; Tue, 03 Jul 2012 08:40:16 -0500 (CDT)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex02.maxim-ic.internal (10.16.15.104) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 3 Jul 2012 08:40:16 -0500
Received: from laclwks004.localnet (10.201.0.45) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 3 Jul 2012 06:40:15 -0700
X-ASG-Orig-Subj: Re: [Q] Branch aliases (synonyms)?
User-Agent: KMail/4.7.3 (Linux/3.0.0-22-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <93cfd6eb9045585728dfe649359a103c@ulrik.uio.no>
X-Barracuda-Connect: maxdalex02.maxim-ic.internal[10.16.15.104]
X-Barracuda-Start-Time: 1341322816
X-Barracuda-URL: http://AntiSpam02.maxim-ic.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.101637
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200913>

On Tuesday 03-July-2012 05:23:29 Hallvard Breien Furuseth wrote:
> Brian Foster wrote:
> > (...)
> >  The catch is a desire(? requirement?) that, when the
> >  transition ends, people used to using B can continue
> >  to use B, people used to using A can continue to use A,
> >  and there is no difference.  That is, after the end of
> >  transition, branch names A and B are the same thing.
> >  Always.  Automatically.
> >
> >  Using a symref seems a working answer.  That is,
> >  after the merge, change B from a true branch head
> >  into a symref pointing to A:
> >
> >       git merge ...
> >       git symbolic-ref refs/heads/B refs/heads/A
> >
> >   =E2=96=B6 What are the gotchas?
>=20
>  Git clone will turn symref B into a regular branch,
>  which will not move in parallel with A.

 Yes, I realize that (and my test script shows it).
 But I'm not concerned about it  =E2=80=94 albeit I've yet
 to check with my colleagues =E2=80=94  because it matters
 only if you _expect_ the two to be identical in
 clones at all times.  That wasn't the requirement.
 The (and I must say I _do_ think this is silly!)
 requirement is =E2=80=9CPeople used to using A can still
 use A.  People used to using B can still use B.=E2=80=9D

 ( Having said that, I now realize my comment
  that =E2=80=9C... and there is no difference=E2=80=9D could be
  misconstrued.  My apologies.  Sorry!  What I _meant_
  was the two classes of user (A users and B users)
  could work in an identical fashion except for
  the name difference. )

>  People may have private scripts which will
>  be surprised when they encounter B.  E.g. when
>  parsing the output from 'git branch'.

 YES.  This is a good point, but in this case
 should not apply:  The only repository with
 the symref is not directly accessible, so,
 with a few expert exceptions, everyone is
 using clones (often cloned from a mirror,
 which doesn't have the symref being a clone).

>[ ... ]
> >   =E2=96=B6 Are there other solutions?
>=20
>  You haven't explained the problem which led you to want "equal"
>  branches.

 People who don't know what they are doing
 making detailed technical requirements and
 not listening-to advice from the experts.
 I myself want to avoid the whole two-branch
 merge business, or, if not possible, then
 do the obvious thing and delete one of the
 branch names (B) after the merge, yadda-yadda.
 ( I do have a vague hope of removing this
  branch alias =E2=80=9Crequirement=E2=80=9D, but not of
  removing the two-branches-then-merge plan. )

>             E.g. if it's hard to teach developers to switch
>  from B to A, a hook which rejects pushes to B might help.

 Whilst we _may_ have problems with some of the
 internal developers (this can be managed so I'm
 not worried about it), the concern is about the
 external users (clients who clone but never push)
 becoming confused.  Hence the requirement about
 continuing to use the same branch name as you are
 used to using.  That's it!  It's that simple.

Thanks,
	-blf-

>  Possibly in addition to them using a private symref.  In this
>  case, [ suggestion deleted as the author confirms it is in error ].
>=20
>  Hallvard

--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
