From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation clarification on git-checkout regarding ours/theirs
Date: Fri, 10 Jul 2015 13:07:11 -0700
Message-ID: <xmqqy4inkc9c.fsf@gitster.dls.corp.google.com>
References: <1436516877-21064-1-git-send-email-simon.eu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Simon A. Eugster" <simon.eugster@eps.ch>
To: "Simon A. Eugster" <simon.eu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 22:07:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDeZt-000319-2B
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 22:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbbGJUHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2015 16:07:16 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33656 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650AbbGJUHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 16:07:14 -0400
Received: by iggp10 with SMTP id p10so42532638igg.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=vwv14E3m7dYCyYWBwIICg5Y3rbKRYgI15TZu+vthAxk=;
        b=ajKSTVXkPtQ33NuvWvj4ZrL7MvxEAyM51WQ+ZncSEEMREkwhc6eEYeWgwFsVsMbus6
         FTIzXcgdvELWGCOsa/4iZZnIGG2klm8VWy/CoFge/oxyd+NcUujH8OFffAk5vKlRniTt
         FAf+gv6WW9CmiCbThnMUYItVm4yTzbiOsTE3ozaJumIPKagTRsgR3WD5gHM/E/S27/ss
         7XyubmrX6hwycKohhpbS1pBZQ+jS5I0UxReNnySswgCI/erpWlTpXoy8B9IfNSOAxt3e
         W4YoCIG/hNzMPJCanmdspURsqI25THqsrLmm6BJQ+BNf0VxSPyibYVNPUKZApyKoaTPz
         cGDQ==
X-Received: by 10.107.11.166 with SMTP id 38mr35796115iol.8.1436558834044;
        Fri, 10 Jul 2015 13:07:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id kl8sm247110igb.15.2015.07.10.13.07.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 13:07:13 -0700 (PDT)
In-Reply-To: <1436516877-21064-1-git-send-email-simon.eu@gmail.com> (Simon
	A. Eugster's message of "Fri, 10 Jul 2015 10:27:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273831>

"Simon A. Eugster" <simon.eu@gmail.com> writes:

> From: "Simon A. Eugster" <simon.eugster@eps.ch>
>
> Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
> ---

=46or those who are looking from the sideline, this is a reroll from a
month-old thread $gmane/271680.

>  Documentation/git-checkout.txt | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index d263a56..d69306f 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -115,7 +115,21 @@ entries; instead, unmerged entries are ignored.
>  --ours::
>  --theirs::
>  	When checking out paths from the index, check out stage #2
> -	('ours') or #3 ('theirs') for unmerged paths.
> +	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.

I'd drop the change on this line.  Your conflict may or may not be
from these two places when you are using "checkout".  Even if it
came from "git merge", when you are doing "merge", the roles 'ours'
and 'theirs' are very clear and mentioning HEAD/MERGE_HEAD does not
add more clarity than it clutters the description, I would think.

> +	See linkgit:git-merge[1] for details about stages #2 and #3.
> ++
> +Note that during `git rebase` and `git pull --rebase`, 'theirs' chec=
ks out
> +the local version, and 'ours' the remote version or the history that=
 is rebased
> +against.
> ++
> +The reason ours/theirs appear to be swapped during a rebase is that =
we
> +define the remote history as the canonical history, on top of which =
our
> +private commits are applied on, as opposed to normal merging where t=
he
> +local history is the canonical one.

It appears to me that this patch text predates my comment in
$gmane/271720 and your response to it?

> +During merging, we assume the role of the canonical history=E2=80=99=
s keeper,
> +which, in case of a rebase, is the remote history, and our private c=
ommits
> +look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need to =
be integrated on top
> +of =E2=80=9Cour=E2=80=9D work.
> =20
>  -b <new_branch>::
>  	Create a new branch named <new_branch> and start it at

Thanks for reminding of the discussion that did not conclude with a
patch.

How about this?

-- >8 --
=46rom: "Simon A. Eugster" <simon.eugster@eps.ch>
Subject: checkout: document subtlety around --ours/--theirs

During a 'rebase' (hence 'pull --rebase'), --ours/--theirs may
appear to be swapped to those who are not aware of the fact that
they are temporarily playing the role of the keeper of the more
authoritative history.

Add a note to clarify.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Simon A. Eugster <simon.eugster@eps.ch>
---
 Documentation/git-checkout.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index d263a565..8c921e7 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -116,6 +116,21 @@ entries; instead, unmerged entries are ignored.
 --theirs::
 	When checking out paths from the index, check out stage #2
 	('ours') or #3 ('theirs') for unmerged paths.
++
+Note that during `git rebase` and `git pull --rebase`, 'ours' and
+'theirs' may appear swapped; `--ours` gives the version from the
+branch the changes are rebased onto, while `--theirs` gives the
+version from the branch that holds your work that is being rebased.
++
+This is because `rebase` is used in a workflow that treats the
+history at the remote as the shared canonical one, and treat the
+work done on the branch you are rebasing as the third-party work to
+be integrated, and you are temporarily assuming the role of the
+keeper of the canonical history during the rebase.  As the keeper of
+the canonical history, you need to view the history from the remote
+as `ours` (i.e. "our shared canonical history"), while what you did
+on your side branch as `theirs` (i.e. "one contributor's work on top
+of it").
=20
 -b <new_branch>::
 	Create a new branch named <new_branch> and start it at
