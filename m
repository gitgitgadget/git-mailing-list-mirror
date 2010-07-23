From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 17:10:33 +0200
Message-ID: <4C49B0E9.1090300@web.de>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= =?ISO-8859-1?Q?_Bjarmason?= 
	<avarab@gmail.com>, Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 17:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcJtk-0001iX-48
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 17:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759835Ab0GWPKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 11:10:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:45247 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab0GWPKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 11:10:36 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id ADBE016CAA327;
	Fri, 23 Jul 2010 17:10:34 +0200 (CEST)
Received: from [80.128.110.50] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OcJtS-0004Zf-00; Fri, 23 Jul 2010 17:10:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX199UcQsOlghKFtSjH80JD4Xo4IaPcyGy6z9EBIJ
	wu4YhnnC3fMfC1ZoKbV3CCbQh7paItYT5aluOSzPTYNZMvAexa
	SzL8frb4HbXT7embSsqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151538>

Am 22.07.2010 21:41, schrieb Avery Pennarun:
> I create an app named myapp on github:
> 
>    git://github.com/apenwarr/myapp
> 
> It uses 17 different ruby gems, which I import as subprojects.  I have
> two choices:
> 
> [1] .gitmodules can use absolute paths to the original gem locations:
> 
>    git://github.com/rubygems/gem[1..n]
> 
> [2] Or else I can fork them all and use relative paths in .gitmodules:
> 
>    ../gem[1..n]
>    translates to --> git://github.com/apenwarr/gem[1..n]

You forgot what we do as best practice at work:

[3] Fork the gem repos on github (or another server reachable by your
    co-workers) and use those, so you don't have to change the URL
    later:

    git://github.com/apenwarrrubygems/gem[1..n]

Your problems go away, setup has to be done only once on project
start and not for every developer, you can use your own branchnames
and you have a staging repo from where you can push patches upstream
if necessary.


> Surely including *repository URLs* inside the *repository content* is
> at least as bad as including branch names.  If we're going to do one,
> we might as well do the other.  But it won't help, because the stored
> branch name will probably be 'master', and my personal hacked-up copy
> of gem13 shouldn't be on a branch named master anyway.

You sure are aware that having a branch name associated with a
submodule checkout is a request repeatedly made?


> The *real* need for submodules - the need you can't fix without
> submodules - has nothing to do with these requirements.  It's about
> each submodule wanting to have its own lifecycle, owner, changelog,
> and release process, and - perhaps this is actually the killer
> requirement - each supermodule wanting to be able to cleanly rewind a
> submodule if they don't like the new version.

That is just one example. Another one is code shared between
different repos (think: libraries) where you want to make sure that
a bugfix in the library made in project A will make it to the shared
code repo and thus doesn't have to be fixed again by projects B to X.
This was one of the reasons we preferred submodules over subtrees
in our evaluation, because there is no incentive to push fixes inside
the subtree back to its own repo like there is when using submodules.


>>> It's very clear that git-submodule's current behaviour totally
>>> mismatches the entire git philosophy.  That's why it's so impossible
>>> to make the git-submodule command usable.
>>
>> That's very strong accusation.
> 
> Agreed... but that doesn't make it wrong :)

But calling a feature "impossible to make ... usable" is an
interesting thing to say about a feature lots of people are
using productively in their daily work, no? ;-)


>> rebase and merge needs separate    | rebase and merge works normally
>> work in submodule currently        |
> 
> True.

Nope, there is a patch in pu doing
that when it is a simple fast forward
and giving you advice when both sides
are already merged inside the submodule
(CCed Heiko, because he is the author
of that feature)

It is the /commits/ that have to be
done twice, once in the submodule and
then in the superproject. (But that is
not necessarily bad, imagine having git
gui as a submodule: you would be
automagically reminded that stuff for
git gui should be sent somewhere else
than to Junio).
