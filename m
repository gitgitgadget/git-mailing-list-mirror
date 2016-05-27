From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: new git-splice subcommand for non-interactive branch
 splicing
Date: Fri, 27 May 2016 17:27:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605271701500.4449@virtualbox>
References: <20160527140811.GB11256@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri May 27 17:27:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6JfX-0006cA-EM
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 17:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbcE0P1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 11:27:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:57916 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755904AbcE0P1T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 11:27:19 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lg5kl-1brSrR1h8d-00pg8p; Fri, 27 May 2016 17:27:14
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160527140811.GB11256@pacific.linksys.moosehall>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LLs1ldrPuAc9uVpFh2TgnoHurEaThCeQ2PflnMCkZH0QRQKT5M6
 sT5jYxxdhjajKE7T3hAy2Mbw6+JUh9YhSzo1SE/B6/zhKGyGKMqIOjCAW5HnFks/lFPrAeh
 8obXll8j2FHxVcuj/AaL+gn1Hf4U97B7RLHRC8juUd4pR4lRbchgZiuqnz0i+dcBG5eEIm4
 rGU9ixXRi/qBiobW69gcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/fh3Hl2Gf5I=:r99pYYQg0qLddmI3wQiHwO
 Ifzkq0007HHvPX0bW3ageopDr4VnrwUCNY2DX0wn/kHkXCnO1ODMYt/+Fhp6vwTXXwYLsxiqb
 yiJ9nv9qMOSPYHXNPprB196GA60X34TUdSHiFs2XNq654ggxbHbYtYNA0y2aJwn7tBqpzDhQl
 CaRios0iiCZcaLcaoEDxm1iw/ZFGzJJugozCMA2E/cJQkOQQSqstzroflanMX5WDTehiiNazM
 6y1WxpsasvCN7Z9SMQMKWXkSMSFq61vzW2bhM0tMJTiuEPN2uTXNPIrDwXI3lVzz0CkP0vcNp
 EMjA44DyHD3pw/JKnnHuWm6ofjBG9vxymK8aXu70IT12KJ0h7H2JWAeVeUYbGh9l1hMaH6ggK
 dzuCIgCm6BUXtmTSQBZ35IfeUTKnR5x+7yi8rbpCePE/UUBgrsQOOCvhPE8qNVovgR+SGL8Kj
 ELXExQfcIUAQrCxS/bZSb0DcWRIn+6iDDkYuRXzOhsXqdhNghz8RcfFzviFV5Nmlgc3fgpkXZ
 tLIT/ehc/vMhRz6y6yu23hCGyxE+wSHuF31pmiRr7bhL6zO/zrYmgFQKp+4LULLqHcPlD+Eou
 8njjTKYCJ+pRkORb2wAiZV6o0yTWEZzkG7HRQRv777G1cFp1GihgN+AU7vsqn0uJYAFszO2pD
 Wn9AOqvh7JUb8y5mK4hnXAUwv6NVFb5L+3wR1WlfjddLoW9FzAEs9LKHaLsU+of6iHPCZESLw
 ySgTFCV3dN/ogT0HnbqB/mnn2tJCk5Frjl+E5gzeLUVShe9U7aH8lxHOEdsrfoEt4a7li2lo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295761>

Hi Adam,

On Fri, 27 May 2016, Adam Spiers wrote:

> Description
> -----------
> 
> git-splice(1) non-interactively splices the current branch by removing
> a range of commits from within it and/or cherry-picking a range of
> commits into it.  It's essentially just a glorified wrapper around
> cherry-pick and rebase -i.

It sounds as if you could accomplish the same with

	git checkout -b former-commits <split>
	git checkout -b latter-commits <base>
	git cherry-pick <split>..HEAD@{2}

> Next steps, and the future
> --------------------------
> 
> Obviously, I'd welcome thoughts on whether it would make sense to
> include this in the git distribution.

Far be I from discouraging you to work on these scripts, but I think that
a really good place for such subcommands is a separate repository, as you
have it already. There are already some rarely used subcommands in
libexec/git-core/ cluttering up the space and I would be reluctant to add
even more subcommands to the default Git installation delivered to every
user.

You can *always* just extend the PATH so that git-splice can be found;
Then `git splice ...` will do exactly what you want. That is e.g. how
git-flow works. (Of course I hope that you will maintain your scripts
much, much better than git-flow, i.e. not abandon all users).

> In the longer term however, I'd like to write two more subcommands:
> 
>   - git-transplant(1) which wraps around git-splice(1) and enables
>     easy non-interactive transplanting of a range of commits from
>     one branch to another.  This should be pretty straightforward
>     to implement.

This is just cherry-pick with a range...

>   - git-explode(1) which wraps around git-transplant(1) and
>     git-deps(1), and automatically breaks a linear sequence of commits
>     into multiple smaller sequences, forming a commit graph where
>     ancestry mirrors commit dependency, as mentioned above.  I expect
>     this to be more difficult, and would probably write it in Python.

You mean something like Darcs on top of Git. Essentially, you want to end
up with an octopus merge of branches whose commits would conflict if
exchanged.

I implemented the logic for this in a shell script somewhere, so it is not
*all* that hard (Python not required). But I ended up never quite using it
because it turns out that in practice, the commit "dependency" (as defined
by the commit diffs) does not really reflect the true dependency.

For example, in my work to move large parts of rebase -i into a builtin, I
have an entire series of commits that do nothing else but prepare the
sequencer for rebase -i's functionality. Most of these commits touch
completely separate parts of the code, so they would make independent
branches in your git-explode command. Yet, that would destroy the story
that the patch series tells, as the natural flow would get lost.

Another major complication is that sometimes the "dependency as per the
diff" is totally bogus. Take for example Git for Windows' patches on top
of Git: there are a couple "sub branches" that add global variables to
environment.c. By the logic of the overlapping (or touching) hunks, these
sub branches should build on top of each other, right? But they are
logically completely independent.

So I think that this is a nice exercise, but in practice it will require a
human to determine which commits really depend on each other.

> Eventually, the utopia I'm dreaming about would become a reality and
> look something like this:
> 
>     git checkout -b new-feature
> 
>     while in_long_frenzied_period_of_hacking; do
>         # don't worry too much about branch maintenance here, just hack
>         git add ...
>         git commit ...
>     done
> 
>     # Break lots of commits from new-feature into new topic branches:
>     git explode
> 
>     # List topic branches
>     git work list

You would render me *really* impressed if you could come up with an
automated way to determine logical dependencies between patches.

Ciao,
Johannes
