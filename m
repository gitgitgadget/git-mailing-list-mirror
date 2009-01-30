From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 14:16:50 +0100
Message-ID: <adf1fd3d0901300516y3d1bf58dmda9c5172586d828@mail.gmail.com>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
	 <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
	 <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:18:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStGF-0006x8-2j
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZA3NQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbZA3NQy
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:16:54 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:37819 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbZA3NQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:16:53 -0500
Received: by fxm13 with SMTP id 13so169509fxm.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 05:16:51 -0800 (PST)
Received: by 10.103.223.2 with SMTP id a2mr580797mur.4.1233321410754; Fri, 30 
	Jan 2009 05:16:50 -0800 (PST)
In-Reply-To: <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107811>

2009/1/30 Pascal Obry <pascal@obry.net>:
> Santi,
>
> Thanks for you reply.
>
>> I think your definition is not well defined. A, B and C are just
>> branches of you project, technically they are equivalent. Maybe you
>
> Right. Yet I want to know from which branch a branch as been started.

You can set it when you create the branch:

git branch --track newbranch startpointbranch

(maybe --track is the default these days for remote branches)

And then the config keys:

branch.newbranch.remote
branch.newbranch.merge

will tell you from which branch a branch was started. And it is used
in "git pull" to merge from the tracking branch.

> You need this to get the proper merge-base for example:
>
>   $ git merge-base C A
>      1
>
>   $ git merge-base B C
>      2
>
>   $ git merge-base B A
>      1

1 and 2 are defined in the graph below...

> I always know on which topic branch I'm but, as shown above, depending on the
> parent branch passed to merge-base you do not get the same branch-point. This
> is fine.
>
> So, when I'm in a topic branch I want to find the name of the parent
> branch. The one given
> when creating the branch:
>
>   $ git branch B C

See above.

>
> A "stupid" solution whould be to iterate over all branches. Looking
> for the merge-base and
> at the end output the branch having the youngest merge-base. I'm
> looking for something
> more efficient...
>

Maybe if you explain why you want it (a use case) instead of just this
specific problem...

>> are thinking that the common commits of, say A and B, really belongs
>> to A, but this is not the case they belong to both branches. In git a
>> branch is really just a pointer to a commit and by extension the
>> history, it is not a series of commits.
>>
>> Just a counterexample, just rearranging you graph:
>>
>>                        o---B
>>                        /
>>                   o---2---o---o---o---C
>>                  /
>>          ---o---1---o---o---o---A
>>
>> From you description: For B I would get C and for C I would get A.

Please, if you quote text do not edit it (the 1 and the 2 in this case).

> Don't see this as a counter-example as it is exactly my example.
>
> Did I missed something?

Yes. Compare your sentence and mine:

For B I want to get A and for C I want to get B.
For B I would get C and for C I would get A.

So for B you get A while I get C, and the equivalent for C.

Santi
