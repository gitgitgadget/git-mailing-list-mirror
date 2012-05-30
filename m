From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Finding a branch point in git
Date: Wed, 30 May 2012 19:07:39 +0200
Message-ID: <CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
	<20120528062026.GB11174@sigill.intra.peff.net>
	<CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
	<20120528190639.GA2478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 30 19:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZmN7-00079e-LP
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 19:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab2E3RHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 13:07:42 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41616 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab2E3RHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 13:07:41 -0400
Received: by lbbgm6 with SMTP id gm6so163288lbb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bbtt4ULBTPOUzsmmLywcJa2cHC0TNN6MiErMb0vjgeU=;
        b=xgbIt4peOrWRv/dxBQqlAaVZtVwxPsVghI6gM1+88DlDelBSNlneZ7rE58qWtBZKXN
         UJj4wJ5FD9p05dq8tJAM0S/Sy1bV1KR3Pr1vW/DBoVpoP9zOeg6HSt5p1GjY/CCEGtVV
         PEqkPeljxb5DYSgxZtVuD7FQ5FbuNX+04WPS1ENdzb3a5VfruV/M8hvcjR0qfWSIqokZ
         qM5+K+y0temgE/fRYn6+bJKF45U0Y9Eub+lpdJzPG4YHpqWz5FxY/J0DuZaDMx3pQLjy
         momrsp3NBBf2Qu0EKCxGo6zrtMa1ceIkD8TYexw3wUePHlMNGwKy6p7gcR4uQVZmL52M
         VvRg==
Received: by 10.152.103.109 with SMTP id fv13mr16431765lab.33.1338397659843;
 Wed, 30 May 2012 10:07:39 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 30 May 2012 10:07:39 -0700 (PDT)
In-Reply-To: <20120528190639.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198822>

On Mon, May 28, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 28, 2012 at 02:36:04PM +0200, Felipe Contreras wrote:
>
>> > What about a history with multiple branches?
>> >
>> > --X--A--B--C--D----E =C2=A0(master)
>> > =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
>> > =C2=A0 =C2=A0 =C2=A0 G--H--I---J =C2=A0 (branch X)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0/
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L =C2=A0 =C2=A0(branch=
 Y)
>> [...]
>>
>> Yes, but then you would need to specify a second branch. I would avo=
id
>> that if possible.
>
> I agree that is less nice. But I don't think the operation is
> well-defined with a single branch. If you ask for "when did branch X
> split", then in the above graph it is unclear if you meant "split fro=
m
> master", or "split from Y".

If you look from the context that I explained in the first mail; it
would be from *any* branch; IOW; find the first commit from branch X
(G), and then find the parent. That would be the first commit where
branch X started.

> Maybe you could assume "master", or assume "git symbolic-ref HEAD" as
> the second branch?

No.

I think it would be easy to support this case if somehow there was a
way to find all the commits that comprise a branch;

 % git log branch ^<any-other-branch>

I could swear I saw such an option, but I've been looking for days and
I can't find it.

IOW; all the commits were 'git branch --contains' would show 'branch'
and nothing else.

>> There's also another case that doesn't work:
>>
>> -- X -- A -- B (master)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C (branch A)
>>
>> Shouldn't be hard to add checks for those cases I think.
>
> Actually, I think that one extends naturally. They are never merged, =
so
> your rev-list never finds a merge commit, and you can just take the
> merge base of the branch tips.

Sure, I can _just_ do that, but I need to do it :)

So, here it is... I hope people can find ways to simplify it:

find_merge ()
{
	local selection extra
	test "$2" && extra=3D" into $2"
	git rev-list --min-parents=3D2 --grep=3D"Merge branch '$1'$extra"
--topo-order ${3:---all} | tail -1
}

branch_point ()
{
	local first_merge second_merge merge
	first_merge=3D$(find_merge $1 "" "$1 $2")
	second_merge=3D$(find_merge $2 $1 $first_merge)
	merge=3D${second_merge:-$first_merge}

	if [ "$merge" ]; then
		git merge-base $merge^1 $merge^2
	else
		git merge-base $1 $2
	fi
}

And I've added tests:
https://raw.github.com/gist/2837595/0734e7f17a4597f81c5129e3cbfee09a183=
e93cd/branch-point

Seems to work :)

Cheers.

--=20
=46elipe Contreras
