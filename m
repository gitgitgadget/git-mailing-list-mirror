From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Wed, 29 May 2013 14:50:14 -0500
Message-ID: <CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:50:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmOH-0007AQ-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641Ab3E2TuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 15:50:20 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:49775 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966345Ab3E2TuP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 15:50:15 -0400
Received: by mail-we0-f182.google.com with SMTP id q57so6502022wes.13
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DJCEX67Nm99hPO5qymXrYvNr+hGDaAJL0nRnDQTZu7o=;
        b=wLJVAG4sPs8jHQ+ABQ0NQIx1wzyWiRw1qFWIoPFi4kD1FoS2GsxpDK+tR8lw9a5aUA
         AKQpRuEr8hE5I4o0HhuF9U+D1d0YDlIw9XBf63ZpVIv8VAvujv/ji25Lg4IkWZ2ChUbq
         AsWHU28RQ3KEwSVWkxI1Y012+8Vluuvfk32P80HAW/SP/QcU73cRx96lKDqOtsKhE2ou
         D2m9MOE/5XQdXF/O8OeQemEpGEUc2T0SfKXu5oe4Cxrce7Caebv55jozjJAdEO1lPCBj
         +jKArXXYkgTNBi4gCGOc9pru282H118x9PofTW5M1zgmiVxG845c2gMZ59BeUm+VqLnz
         VUyw==
X-Received: by 10.194.216.136 with SMTP id oq8mr2292305wjc.8.1369857014080;
 Wed, 29 May 2013 12:50:14 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 12:50:14 -0700 (PDT)
In-Reply-To: <CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225878>

On Wed, May 29, 2013 at 1:26 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Br=C3=A1ulio Bhavamitra wrote:
>>   root =3D rev-parse --show-toplevel
>
> What is your usecase for this?

Some Git commands expect to be in the top level directory (e.g. git bla=
me).

>>  upstream-remote =3D !git upstream | sed -e 's/\\/.*$//g'
>
> Windows back-slashes?

Maybe git config quoting.

>>  out =3D !git fetch `git upstream-remote` && git l `git upstream`..H=
EAD
>
> I didn't understand this at all.  What are you doing?

=46inding out what changes haven't been pushed out yet?

>>  in =3D pull --dry-run
>
> Why?

Because it's very easy to mess things up with 'git pull'. This
probably wouldn't be needed if we change the default of 'git pull' to
barf when the changes are not a fast-forward, and print a message
suggesting to either merge or rebase, as it has been suggested.

>>  unmerged =3D !git ls-files --unmerged | cut -f2 | uniq
>>  untracked =3D ls-files --other --exclude-standard
>>  staged =3D ls-files --staged
>>  modified =3D ls-files --modified
>>  deleted =3D ls-files --deleted
>
> What is wrong with git status showing a unified output?

It's not easy to be used in "scripts", say, 'gvim -p $(git unmerged)'.

>>   head =3D !git l -1
>
> What is git l again?

'git log', of course.

>>  current =3D rev-parse --abbrev-ref HEAD
>
> Why don't you use a prompt?  Use the one in contrib/completion/git-pr=
ompt.sh.

While this is probably a good idea, not everybody has a prompt
configured. Imagine ssh'ing to a machine you haven't touched before,
or shouldn't configure. Sure, right now you need to configure it
anyway, but the whole proposal is to make these default aliases.

In Mercurial 'hg branch' shows only the current branch, and I think
that's more appropriate.

Before I configured my prompt, 'git branch' was by far the command I
used the most.

--=20
=46elipe Contreras
