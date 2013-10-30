From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Limiting disk usage
Date: Wed, 30 Oct 2013 16:39:02 +0100
Message-ID: <52712816.9010600@gmail.com>
References: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com> <vpqob68ebcu.fsf@anie.imag.fr> <CAA01Cso+yTzatiAaQahx5h2N0nnOON7FsnWNSYrN-pV=8qzn7g@mail.gmail.com> <526FCA13.4090902@gmail.com> <CAA01Cso8J+BBgskoRtxkPRrtM4KJ1O2FhcB4uh+QB2Dr=DZGyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 16:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbXrY-0004Ep-4b
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 16:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab3J3PjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 11:39:10 -0400
Received: from dovecot.mat.uni.torun.pl ([158.75.2.81]:26079 "EHLO
	dovecot.mat.uni.torun.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab3J3PjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 11:39:09 -0400
Received: from dovecot.mat.uni.torun.pl (localhost.localdomain [127.0.0.1])
	by dovecot.mat.uni.torun.pl (Postfix) with ESMTP id 42450B71799;
	Wed, 30 Oct 2013 16:39:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mat.uni.torun.pl
Received: from dovecot.mat.uni.torun.pl ([127.0.0.1])
	by dovecot.mat.uni.torun.pl (dovecot2.mat.uni.torun.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zxQmbOn7td2T; Wed, 30 Oct 2013 16:39:05 +0100 (CET)
Received: from [158.75.2.83] (unknown [158.75.2.83])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jnareb)
	by dovecot.mat.uni.torun.pl (Postfix) with ESMTPSA id C41EEB71793;
	Wed, 30 Oct 2013 16:39:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAA01Cso8J+BBgskoRtxkPRrtM4KJ1O2FhcB4uh+QB2Dr=DZGyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237024>

On 2013-10-30 08:44, Piotr Krukowiecki wrote:
> On Tue, Oct 29, 2013 at 3:45 PM, Jakub Nar=C4=99bski<jnareb@gmail.com=
>  wrote:
>> On 2013-10-29 14:50, Piotr Krukowiecki wrote:

>> If they are independent projects, they should get independent reposi=
tories;
>> you can stitch them back together using git-submodule (or git-subtre=
e).
>> reposurgeon can hel you with that.
>
> They are not totally independent projects (nor totally dependent).
> Normally you want them all, you want to create a branch/tag on all of
> them, if new directory is created you want to automatically have it
> too etc. But there are use cases when you need only some of them and
> then they can be seen as independent .
>
> git-submodule have several disadvantages for my use:
> - does not track branches (you have to specify hardcoded SHA1 instead
> of a branch name)
> - additional complexity / command layer (you have to do things like
> "submodule init", "submodule update")
> - you can't simply work on all submodules (you can't simply branch,
> merge, commit, log, diff, etc in all submodules using one command in
> top-level project)

git-submodule was created (I think) to manage loosely coupled fairly
independent projects, where you need nevertheless to ensure that
both work together (so you use specific version of subproject for
a given version of superproject).  It looks like this is not what
you have.

 From time to time you can find there ideas about adding "floating"
mode to git-submodule, but as far as I know up till now without
effect...

> git-subtree looks much better in that regard, but for example it need=
s
> an explicit prefix (name of "subproject") on which it operates. So yo=
u
> can't say "update everything" or "commit everything" etc. With
> hundreds of subprojects you need another layer to automate this...

git-subtree is about helping merging / embedding (or re-embedding)
of subproject history in superproject history, and extracting subprojec=
t=20
history from superproject history.  But embedded subproject is just=20
subdirectory to git.  It looks like it isn't what you want.

There are many projects[1] that try to solve problem of managing=20
interdependent repositories, e.g.: gitslave, repo, fgit.  Maybe one
of them would be good fit for your problem.

[1]: https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

--=20
Jakub Nar=C4=99bski
