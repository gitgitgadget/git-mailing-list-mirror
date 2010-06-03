From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Recovering from commit --amend in rebase --interactive
Date: Thu, 3 Jun 2010 05:54:56 +0000
Message-ID: <AANLkTinint0-KxXr8mIK6b6Yom1oBc0Qed-Jp48wofJf@mail.gmail.com>
References: <alpine.DEB.2.00.1006011022030.2352@ds9.cixit.se>
	<20100601115755.04ff4a0d@jk.gs>
	<AANLkTinNpIjirZQL1lBi3t4i6_utCIUMuXc8q2gSJvmO@mail.gmail.com>
	<7viq619fah.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 07:55:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK3OT-0006dY-AX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 07:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab0FCFy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 01:54:59 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:44537 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab0FCFy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 01:54:58 -0400
Received: by ywh9 with SMTP id 9so6036375ywh.17
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 22:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lbXtz3pGEHKP2aDWoQrBz2hQ1Vh54VkY+5uowr/yFpU=;
        b=DWuEVKj3UhZ7H4uDedTHuLGrfBqFmQxiblMqfNjUpepFCnPoS5QCSVCo1sCrncAwOr
         QTdl03fIga0FokPr2jcAY/iqflX80AzW3SrfpGiNVy/aJA+/m7ZZRoUB4ybaqFBLK6S8
         eHrgb2kau1et2gQaybjS6Zgqdwjh1cifd7ATQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O+VcrDB4eGNiNqvWb79erdjhq9yKbMwSRbmjWy+yZ8rGHGwAqAp9wVso1Arm7WiBhJ
         Xj7jOoq4O57aMJk9nm3VxloRTjPYifjbP1o18YQBbvghPv51Vb7/lj93BEKEOY51NYv/
         fzzpr+/FskvibN3nD2WvWpjg3YcEETHe9cR/I=
Received: by 10.231.185.6 with SMTP id cm6mr11245762ibb.72.1275544496226; Wed, 
	02 Jun 2010 22:54:56 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 2 Jun 2010 22:54:56 -0700 (PDT)
In-Reply-To: <7viq619fah.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148292>

On Wed, Jun 2, 2010 at 23:37, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> In general, it might be helpful to warn very loudly upon doing a co=
mmit
>>> --amend after fixing conflicts, but an implementation would probabl=
y be
>>> ugly and for all I know, there might be people who frequently cause
>>> conflicts while amending; those guys would probably be quite annoye=
d at
>>> such a warning.
>>
>> I've also introduced the error Peter describes into my history becau=
se
>> I wasn't careful. That required some splitting / reflog fixes later.
>>
>> Perhaps the best way to solve this would be to change the content of
>> COMMIT_EDITMSG in cases like these so it gives you an explicit warni=
ng
>> about what you're about to do.
>>
>> We already do this for merges, from builtin/commit.c:
>
> Very good point. =C2=A0"Users are told when the command gives back co=
ntrol, is
> the best "rebase -i" could do, but by definition the users are free t=
o
> shoot themselves in the foot when given control, and "commit --amend"=
 is
> the only sensible place to give further safeguard against this issue.

As it happens I shot myself in the foot with this yesterday, here's a
log of what I did:

    aoeu git (404M) $ git reset HEAD^
    Unstaged changes after reset:
    M       .gitignore
    M       Makefile
    M       config.mak.in
    M       configure.ac
    M       git.c
    M       wt-status.c
    aoeu git (404M) $ git st
     M .gitignore
     M Makefile
     M config.mak.in
     M configure.ac
     M git.c
     M wt-status.c
    ?? gettext.c
    ?? gettext.h
    ?? po/
    aoeu git (404M) $ git diff
    aoeu git (404M) $ git show

        At this point the amend message should warn me that I'm about t=
o
        merge stuff into the previous commit:

    aoeu git (404M) $ git commit --amend
    Waiting for Emacs...
    [detached HEAD f9d39c1379537fb3afdfba244c61a7328dc394f2] Merge
branch 'maint'
     Author: Junio C Hamano <gitster@pobox.com>
    aoeu git (404M) $ git st
     M wt-status.c
    ?? gettext.c
    ?? gettext.h
    ?? po/

Actually, related to that I think this documentation section could use
some work:

    http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html#_sp=
litting_commits

At the time I was:

    * Going back in my history
    * Splitting apart some hunks to an older commit from that commit
    * recommiting the altered commit, leaving its commit info alone
    * Stashing the changes I'd removed into several stashes
    * git rebase --continue and applying all the stashes to one big com=
mit later

I.e.:

    git rebase -i master
    ...
    git reset HEAD^
    git stash save --patch "stash git-pull.sh"
    git add -u
    git commit -c e06ef88fead1510587ff32715beaccf622dec2ce
    git rebase --continue

The "Commit the now-current index with whatever commit message is
appropriate now" part of the docs assumes that you don't want to keep
your old commit info around for the new rewritten commit.


Anyway, </braindump>. This is just one example of how the rebase
process could be friendlier with some minor changes, and how the
documentation could be improved.
