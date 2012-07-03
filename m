From: Johan Herland <johan@herland.net>
Subject: Re: [Q] Branch aliases (synonyms)?
Date: Tue, 3 Jul 2012 18:22:43 +0200
Message-ID: <CALKQrgeAXLSwsqwTe_FZN0aNHwnoSBHBt+PO9jpCtzRM1Aeyrw@mail.gmail.com>
References: <1919214.YKUdgul2iY@laclwks004>
	<93cfd6eb9045585728dfe649359a103c@ulrik.uio.no>
	<4261222.bYBuBBxnOa@laclwks004>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 18:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm5sW-0002ZH-7L
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 18:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933141Ab2GCQWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 12:22:51 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:63892 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933056Ab2GCQWt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2012 12:22:49 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Sm5sF-000DXh-LR
	for git@vger.kernel.org; Tue, 03 Jul 2012 18:22:47 +0200
Received: from mail-qa0-f53.google.com ([209.85.216.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Sm5sF-000FwM-E4
	for git@vger.kernel.org; Tue, 03 Jul 2012 18:22:47 +0200
Received: by qaas11 with SMTP id s11so2762214qaa.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 09:22:44 -0700 (PDT)
Received: by 10.60.1.40 with SMTP id 8mr18974032oej.70.1341332563918; Tue, 03
 Jul 2012 09:22:43 -0700 (PDT)
Received: by 10.76.138.167 with HTTP; Tue, 3 Jul 2012 09:22:43 -0700 (PDT)
In-Reply-To: <4261222.bYBuBBxnOa@laclwks004>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200915>

On Tue, Jul 3, 2012 at 3:40 PM, Brian Foster <brian.foster@maxim-ic.com=
> wrote:
> On Tuesday 03-July-2012 05:23:29 Hallvard Breien Furuseth wrote:
>> Brian Foster wrote:
>> > (...)
>> >  The catch is a desire(? requirement?) that, when the
>> >  transition ends, people used to using B can continue
>> >  to use B, people used to using A can continue to use A,
>> >  and there is no difference.  That is, after the end of
>> >  transition, branch names A and B are the same thing.
>> >  Always.  Automatically.
>> >
>> >  Using a symref seems a working answer.  That is,
>> >  after the merge, change B from a true branch head
>> >  into a symref pointing to A:
>> >
>> >       git merge ...
>> >       git symbolic-ref refs/heads/B refs/heads/A
>> >
>> >   =E2=96=B6 What are the gotchas?
>>
>>  Git clone will turn symref B into a regular branch,
>>  which will not move in parallel with A.
>
>  Yes, I realize that (and my test script shows it).
>  But I'm not concerned about it  =E2=80=94 albeit I've yet
>  to check with my colleagues =E2=80=94  because it matters
>  only if you _expect_ the two to be identical in
>  clones at all times.  That wasn't the requirement.
>  The (and I must say I _do_ think this is silly!)
>  requirement is =E2=80=9CPeople used to using A can still
>  use A.  People used to using B can still use B.=E2=80=9D

=46WIW, we have done a similar thing at $dayjob: A git repo (originally
converted form Subversion) still used "trunk" as the main development
branch. We wanted to start following Git conventions, so we renamed it
to "master", and set up "trunk" as a symref to "master". We then told
all the other developers that "trunk" is now "master", and that they
should switch at their own leisure. After a grace period, we will
remove the "trunk" symref.

AFAICS, this seems to work very well. People in old clones keep
working on "trunk" for as long as they like. They push their work back
to "trunk" on the server, which follows/preserves the symref, and
updates the "master" branch. People in new clones get the "master"
branch automatically, and push their work directly back to the
server's "master". Obviously, all clones also get the other branch
when they fetch from the server, but so far nobody has gotten confused
by this other branch that "mysteriously" follows their "main" branch.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
