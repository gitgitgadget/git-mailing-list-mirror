From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: How to find all the commits that comprise a branch?
Date: Wed, 30 May 2012 22:23:03 +0200
Message-ID: <CAMP44s0ZJG1aqe8z-fPfwU+oMNwSh=YjNA6mPiZ+Tdj2eBgpKQ@mail.gmail.com>
References: <CAMP44s2kEMK8ik2NTiP4uiN4FPWFNYNJfY5qh5QE_hRH2AiNYA@mail.gmail.com>
	<7vaa0pzcvp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 22:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZpQF-0001Bf-7i
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 22:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab2E3UXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 16:23:06 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43225 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903Ab2E3UXF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 16:23:05 -0400
Received: by lahd3 with SMTP id d3so181713lah.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oxcmZbIJknaXgxzPKdBqQ/9Jvg8e2zldVnJZCqYPtZg=;
        b=MxFAJm0yTr7T0XclQMcuGbyTk3fiF22kXFDV2LPLL4p/QmGse3/yIoNbXV0oW9nQmx
         AO4KIyTflWlqKRoPYd0VRpkDTcoVEKChN0AnUgEXN2PA+3i39HylKO82YRdKJtnz3DAE
         Wgtix9iuOOwk7MV4+yR05vgkJ9orfu/r5GiBfo3q7VOPcgm/QuJTA5ranj77ni9sLpRx
         zK2zkXofMOf1CmuXyXwO+aodbU0+SAwUowOsd5AJ4GjgeJ1trSdVZfZ0d5c1+VpUqFmO
         Y1t5CPmPlGD1ZU+smw8rC66Jo77gXqZMxZYQIdjQcpPGD4w9tBh9QY4tQw79qJPmThZJ
         7AVQ==
Received: by 10.152.109.166 with SMTP id ht6mr17133060lab.46.1338409383112;
 Wed, 30 May 2012 13:23:03 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 30 May 2012 13:23:03 -0700 (PDT)
In-Reply-To: <7vaa0pzcvp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198833>

On Wed, May 30, 2012 at 9:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Hi,
>>
>> Basically what I want to do is:
>>
>> =C2=A0% git log branch ^<any-other-branch>
>>
>> IOW; all the commits were 'git branch --contains' would show 'branch=
'
>> and nothing else.
>>
>> Is there any easy way to do that?
>
> There was "log blah --not --all --exclude-ref=3Drefs/heads/blah"
> discussion a few months ago, but I do not think anything came out of
> it.
>
> This is a tangent, but it would be a good way to find out set of
> commits that you would lose and need to go to reflog to find if you
> were to delete the branch.
>
> It however is a poor definition for "commits that comprise a branch";
> I actually am not sure if the concept has a sensible definition.
>
> Let's think aloud with a few examples.
>
> You may be done with your "work" branch and merge it to "master".
> At that point, do you think you no longer have any commit that
> comprises your "work" branch?

That's right... no commits.

> You could argue that "work" branch is no longer relevant because it
> is part of "master", and it is an understandable viewpoint.
>
> But imagine what happens when you find a bug in your "work" and want
> to fix it up by queuing a correction on your "work" branch (not
> directly on "master", because your "work" branch was forked from
> "maint" and you eventually want to merge it there as well). =C2=A0Now=
, is
> the single fix-up commit the only commit that comprises your "work"?

Yes. On that branch.

> Suppose you have 5-patch series in your "work" branch, two commits
> at the bottom of which are useful refactoring of existing code. =C2=A0=
I
> fork from the second commit to take advantage of your refactoring to
> work on something entirely different. =C2=A0These two branches now sh=
are
> the bottom two commits. =C2=A0At this point, do you have only three
> remaining commits on your "work" branch? =C2=A0Wouldn't we rather wan=
t to
> say that I am merely borrowing two commits from you and you still
> have 5 commits that is what your "work" branch consists of?

It depends; if your branch gets merged to master, then my work branch
is comprised of 3 commits.

Of course it's debatable how to consider the commits that are
contained in multiple branches, but it's clear that the commits that
are only in one branch comprise that branch.

Either way, call them 'independent' or whatever you want, but the
concept of "commits that are only in one branch" is clear, and it's
useful to find this information.

Cheers.

--=20
=46elipe Contreras
