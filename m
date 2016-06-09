From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv4] Documentation: triangular workflow
Date: Thu, 9 Jun 2016 19:19:20 +0100
Organization: OPDS
Message-ID: <E41AB752AE614E189BC5BE289A8AEB2A@PhilipOakley>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org> <1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <mhagger@alum.mit.edu>, <git@vger.kernel.org>,
	<erwan.mathoniere@grenoble-inp.org>,
	<samuel.groot@grenoble-inp.org>, <tom.russello@grenoble-inp.org>,
	<Matthieu.Moy@grenoble-inp.fr>, <peff@peff.net>,
	<artagnon@gmail.com>,
	"Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
To: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	<gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:22:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB5XO-0004uW-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbcFITWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2016 15:22:39 -0400
Received: from a2i861.smtp2go.com ([103.47.207.93]:36056 "EHLO
	a2i861.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcFITWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a0-2; h=Feedback-ID:X-Smtpcorp-Track:Date:Subject:To:From:
	Reply-To:Message-ID; bh=hSW5S/wovkVC1UOTHx/fAgi9dbM/eEvIsQr/vnG7aQ0=; b=ZTZi5
	PZQvkhUjBUOvn9Gc5V9zeL5gx0dNSpPmmNLiAQ2CcwR2tLKnvBqvJp6w9M2Oa7OvUFbk/QmUtW1XT
	l4SAivGKKvFiNW9sxS6sdxVCMUwIwi2X6T5lnuk8zDxU78CPizmBiI7eh2KB5rdaYTUxIkQGfuw1l
	wgBATfktu3xAoR7VIRUYUxp/zD3ZlXrdMTOurKlydn7uJoSfnVhOnPeo+8flPb9A1gj/NOzvvJaR0
	LM89HBuHuPdEmt0i0bTCZZM7pdJRC51lrtnDCoeTDxtiqfqJ7t+NW8hR68YDa4kcJYtnlyZ/uHzrK
	axAi2bw/8Wi8dqxE805GdkNzGPzEA==;
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1PU5b5kaljTh3P.W-HrKuTcQ
Feedback-ID: 66524m:66524aMf6O2Y:66524s4PrImBeZA:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296919>

=46rom: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>
> Currently, triangular workflow can be configured, but there is no
> documentation about it. A documentation is useful to keep
> configuration possibilities up-to-date.
>
> A new subsection is created in gitworkflow.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
> ---
> Changes since v3:
> * Text reorganized to follow:
>   - Introduction
>   - Preparation
>   - Staying up-to-date
>   - Alternatively
> * Texts added to explain why we use commands in:
>   - Preparation
>   - Alternatively
>
> Documentation/gitworkflows.txt | 177=20
> ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 176 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/gitworkflows.txt=20
> b/Documentation/gitworkflows.txt
> index f16c414..1ec1f63 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -463,6 +463,178 @@ if you get conflicts: `git am -3` will use inde=
x=20
> information contained
> in patches to figure out the merge base.  See linkgit:git-am[1] for
> other options.
>
> +TRIANGULAR WORKFLOW
> +-------------------
> +
> +In some projects, you cannot push directly to the project but have t=
o
> +suggest your commits to the maintainer (e.g. pull requests).
> +For these projects, it's common to use what's called a *triangular
> +workflow*:
> +
> +- Taking the last version of the project by fetching from **UPSTREAM=
**
> +- Writing modifications and push them to a fork (e.g. **PUBLISH**)

s/a fork/an accessible fork/
Isn't one of the key points of the triangle that the user can't push to=
 the=20
upstream? (and the maintainer can't see the users local repo)

> +- Opening a pull request
s/request/request (formally or informally)/

> +- If the maintainer accepts the changes, he merges them into the
a Catch 22 here. The maintainer needs first to fetch, or othewise read,=
 the=20
mods before she could accept the changes. Perhaps

- The maintainer fetches, and reviews, the proposed changes; And if=20
acceptable, merges them into the upstream.

the exact timing of the fetch will depend on the review system (see bel=
ow).

> +  **UPSTREAM** repository.
> +
> +
> +........................................
> +------------------               -----------------
> +| UPSTREAM       |  maintainer   | PUBLISH       |
> +|  git/git       |- - - - - - - -|  me/remote    |
> +------------------       =E2=86=90       -----------------
> +              \                     /
> +               \                   /
> +          fetch=E2=86=93\                 /=E2=86=91push
> +                 \               /
> +                  \             /
> +                   -------------
> +                   |   LOCAL   |
> +                   -------------
> +........................................
> +
> +Motivations
> +~~~~~~~~~~~
> +
> +* Allows contributors to work with Git even though they do not have
> +write access to **UPSTREAM**.
> +
> +* Allows maintainers to receive code from contributors they may not
> +trust.
s/trust/trust with psuh access/
It is the push/pull access issues that create the triangular workflow!

> +
> +* Code review is more efficient

more efficient than ??? in environment ??? (e.g. a review process of we=
b=20
viewing/commenting on GitHub, driven by a limited patch/mail server=20
capability)


> +
> +* Encourages clean history by using `rebase -i` and `push --force` t=
o
> +your public fork before the code is merged
> +
> +Preparation
> +~~~~~~~~~~~
> +
> +Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empt=
y
> +repository.

I agree here. To clone the upstream, to which you have no push access (=
by=20
definition), would leave the config badly mis-set for the basic user. I=
t's=20
better for the user to clone their publish fork (to which they have bot=
h=20
read and write access).

One issue may be the different expectations of how the fork is created =
(it's=20
only one click on the GitHub..)

It may be worth covering the remote rename option to set that origin to=
 the=20
short and sweet 'me', or 'my', as per the ascii diagram.

> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git clone <PUBLISH_url>`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Setting the behavior of push for the triangular workflow:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +`git config push.default current`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Adding **UPSTREAM** remote:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git remote add upstream <UPSTREAM_url>`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +With the `remote add` above, using `git pull upstream` pulls there,
> +instead of saying its URL. In addition, `git pull` can pull from
> +**UPSTREAM** without argument.
> +
> +For each branch requiring a triangular workflow, set
> +`branch.<branch>.remote` and `branch.<branch>.pushRemote`.
> +
> +Example with master as <branch>:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +* `git config branch.master.remote upstream`
> +* `git config branch.master.pushRemote origin`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Stay up-to-date
> +~~~~~~~~~~~~~~~
> +
> +Retrieve updates from **UPSTREAM** with `git pull` and send them to
> +**PUBLISH** with `git push`.
> +
> +Checks
> +~~~~~~
> +
> +.Display the push remote's name:
> +[caption=3D"Recipe: "]
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git rev-parse --abbrev-ref @{push}`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The shorthand `<branch>@{push}` denotes the remote-tracking branch
> +where the <branch> would be pushed to. If no <branch> is specified
> +(`@{push}`), <branch> takes the value of the current branch.
> +
> +
> +.Display the fetch remote's name:
> +[caption=3D"Recipe: "]
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git rev-parse --abbrev-ref @{upstream}`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The shorthand `<branch>@{upstream}` substitutes the upstream name of
> +the branch. If no <branch> is specified (`@{upstream}`), <branch>
> +takes the value of the current branch.
> +
> +.Display commits added to the current branch since last push:
> +[caption=3D"Recipe: "]
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git log @{push}..`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.Display commits added to a specific branch since last push:
> +[caption=3D"Recipe: "]
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +`git log <branch_name>@{push}..`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +Alternative configuration
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.Cloning from **UPSTREAM**
> +[caption=3D"Recipe: "]
> +
> +In the preparation above, a clone from **PUBLISH** was used. Startin=
g
> +with a clone of **UPSTREAM** is possible too.
> +
> +Cloning from **UPSTREAM**
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git clone <UPSTREAM_url>`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Setting the behavior of push for the triangular workflow:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +`git config push.default current`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Because modifications will be often pushed into the **PUBLISH**=20
> repository,
> +instead of having to type its URL every time, a short name can be us=
ed
> +to call it.
> +
> +Adding **PUBLISH** remote:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git remote add publish <PUBLISH_url>`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +With the `remote add` above, using `git push publish` pushes there,
> +instead of saying its URL. In addition, `git push` can push to
> +**PUBLISH** without argument.
> +
> +'Method 1: One option for all branches'
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git config remote.pushDefault publish`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +'Method 2: Each branch its option'
> +
> +Example with master as <branch>:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git config branch.master.pushRemote publish`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> SEE ALSO
> --------
> @@ -473,7 +645,10 @@ linkgit:git-merge[1],
> linkgit:git-rebase[1],
> linkgit:git-format-patch[1],
> linkgit:git-send-email[1],
> -linkgit:git-am[1]
> +linkgit:git-am[1],
> +linkgit:git-config[1],
> +linkgit:git-log[1],
> +linkgit:git-rev-parse[1]
>
> GIT
> ---
