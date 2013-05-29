From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 01:30:17 +0530
Message-ID: <CALkWK0=Sn2myT3QPCWJnoxKH4hm4s7MaB=UrPixP87MFSwKoug@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com> <CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmYV-0007To-0e
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 22:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966353Ab3E2UBC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 16:01:02 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:38245 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934987Ab3E2UBA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 16:01:00 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so866286ief.26
        for <git@vger.kernel.org>; Wed, 29 May 2013 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/Y4IrW6BnaN1meTYdC7oVuQf7hiNq+NzdnLK9SK/HQw=;
        b=QHZbFWO2siX5peNI0gz/vTSEDwJbvpc7hNWpvGViy88Kj1xFNxb6MUm6cOlj3Ro+l5
         ofq4HMvK+xa1liJ2oSiGE0UA7NnsMRnDgYVOclYoiqvjNVjJjgYdF+O3imkt5ZB2ppLh
         PBlC5YlW/eFlu1+CX5zYHuEs9o5jTL1/uAQBYoHbWhbMdMz5cu81z0ualb6dFxOHkpC6
         /SFhm8xLVeI17Pki0whMQKfMbZQWGB1E5cVVRpwmsmhhIjWslnBCg5ggh3csKbmI2G8v
         cdbM1fUHEapdieSWhndcPqf9imExGxiZvqE7WIuXa6nvFkVB1gefhOFuiUEA6Wx+/QK8
         wW5g==
X-Received: by 10.50.153.6 with SMTP id vc6mr10051754igb.57.1369857660011;
 Wed, 29 May 2013 13:01:00 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 13:00:17 -0700 (PDT)
In-Reply-To: <CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225882>

=46elipe Contreras wrote:
> On Wed, May 29, 2013 at 1:26 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Br=C3=A1ulio Bhavamitra wrote:
>>>   root =3D rev-parse --show-toplevel
>>
>> What is your usecase for this?
>
> Some Git commands expect to be in the top level directory (e.g. git b=
lame).

Um, git blame revert.c when in builtin/ works for me: what am I missing=
?

>>>  out =3D !git fetch `git upstream-remote` && git l `git upstream`..=
HEAD
>>
>> I didn't understand this at all.  What are you doing?
>
> Finding out what changes haven't been pushed out yet?

=2E.. but why would I want to club a slow network operation with
something like log?  Yeah, I use git log @{u}.. all the time.

>>>  in =3D pull --dry-run
>>
>> Why?
>
> Because it's very easy to mess things up with 'git pull'. This
> probably wouldn't be needed if we change the default of 'git pull' to
> barf when the changes are not a fast-forward, and print a message
> suggesting to either merge or rebase, as it has been suggested.

Yeah, I saw that thread and I think shipping "sane" defaults is a lost
cause.  I really want to make pull more useable, but by making it more
configurable.

>>>  unmerged =3D !git ls-files --unmerged | cut -f2 | uniq
>>>  untracked =3D ls-files --other --exclude-standard
>>>  staged =3D ls-files --staged
>>>  modified =3D ls-files --modified
>>>  deleted =3D ls-files --deleted
>>
>> What is wrong with git status showing a unified output?
>
> It's not easy to be used in "scripts", say, 'gvim -p $(git unmerged)'=
=2E

RIght, but we shouldn't ship anything "pretty" for scripts, otherwise
it'll become hard to understand them.

>>>   head =3D !git l -1
>>
>> What is git l again?
>
> 'git log', of course.

I use 'git show' all the time.

>>>  current =3D rev-parse --abbrev-ref HEAD
>>
>> Why don't you use a prompt?  Use the one in contrib/completion/git-p=
rompt.sh.
>
> While this is probably a good idea, not everybody has a prompt
> configured. Imagine ssh'ing to a machine you haven't touched before,
> or shouldn't configure. Sure, right now you need to configure it
> anyway, but the whole proposal is to make these default aliases.

Like I said earlier, I'm really not interested in sane defaults: I
don't think all of us can agree on one thing.

> In Mercurial 'hg branch' shows only the current branch, and I think
> that's more appropriate.
>
> Before I configured my prompt, 'git branch' was by far the command I
> used the most.

Yeah, we're fixing 'git branch' (by making it more configurable): the
topic is in progress.
