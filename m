From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH] rebase -i -p: document shortcomings
Date: Mon, 31 May 2010 22:22:14 -0400
Message-ID: <AANLkTimjcHpbbpfwNoZGq3_1TjfLAzJL3C8Jcp6LeyW0@mail.gmail.com>
References: <20100601014335.GA21970@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Florian Weimer <fw@deneb.enyo.de>,
	=?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@alea.gnuu.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 04:22:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJH7V-000546-Ka
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 04:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0FACWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 May 2010 22:22:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60077 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab0FACWQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 May 2010 22:22:16 -0400
Received: by wyi11 with SMTP id 11so630574wyi.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 19:22:14 -0700 (PDT)
Received: by 10.216.93.19 with SMTP id k19mr4886300wef.5.1275358934320; Mon, 
	31 May 2010 19:22:14 -0700 (PDT)
Received: by 10.216.22.201 with HTTP; Mon, 31 May 2010 19:22:14 -0700 (PDT)
In-Reply-To: <20100601014335.GA21970@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148060>

Thanks, this is long needed.  I regret that I haven't had time in
several months to continue work on the real fix.

The combination "rebase -i -p" does work correctly in one common use
case: where you only use "edit" and similar commands, and do not
reorder the commits.  I used it regularly for this purpose before I
even noticed that it fails when you do reorder commits.  Not sure if
it's worth trying to make that distinction clear, though.

I suggest s/instruction sheet/todo list/, as the latter terminology
seems more natural to me, and also appears already elsewhere in the
"git rebase" documentation.

Cheers,
Greg



On Mon, May 31, 2010 at 9:43 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> The rebase --preserve-merges facility presents a list of commits
> in its instruction sheet and uses a separate table to keep
> track of their parents. =C2=A0Unfortunately, in practice this means
> that with -p after most attempts to rearrange patches, some
> commits have the "wrong" parent and the resulting history is
> rarely what the caller expected.
>
> Yes, it would be nice to fix that. =C2=A0But first, add a warning to =
the
> manual to help the uninitiated understand what is going on.
>
> Reported-by: Ji=C5=99=C3=AD Pale=C4=8Dek <jpalecek@web.de>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Cc: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Pointers towards a real fix:
>
> =C2=A0. http://thread.gmane.org/gmane.comp.version-control.git/79424/=
focus=3D79504
> =C2=A0. http://thread.gmane.org/gmane.comp.version-control.git/77965/=
focus=3D80835
> =C2=A0. http://thread.gmane.org/gmane.comp.version-control.git/131921=
/focus=3D132679
> =C2=A0. http://repo.or.cz/w/git/price.git
> =C2=A0. http://repo.or.cz/w/git/dscho.git/shortlog/refs/heads/rebase-=
i-p
>
> Thanks to all who have worked on this before.
>
> Thoughts?
>
> =C2=A0Documentation/git-rebase.txt =C2=A0| =C2=A0 26 ++++++++++++++++=
++++++++++
> =C2=A0t/t3404-rebase-interactive.sh | =C2=A0 =C2=A06 ++++++
> =C2=A02 files changed, 32 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 5863dec..330e9ea 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -306,6 +306,11 @@ link:howto/revert-a-faulty-merge.txt[revert-a-fa=
ulty-merge How-To] for details).
> =C2=A0-p::
> =C2=A0--preserve-merges::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Instead of ignoring merges, try to recreat=
e them.
> ++
> +This uses the `--interactive` machinery internally, but combining it
> +with the `--interactive` option explicitly is generally not a good
> +idea (see BUGS below).
> +
>
> =C2=A0--root::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Rebase all commits reachable from <branch>=
, instead of
> @@ -607,6 +612,27 @@ The ripple effect of a "hard case" recovery is e=
specially bad:
> =C2=A0case" recovery too!
>
>
> +BUGS
> +----
> +The instruction sheet presented by `--preserve-merges --interactive`
> +does not represent the topology of the revision graph. =C2=A0Attempt=
s to
> +reorder it tend to produce counterintuitive results.
> +
> +For example, an attempt to rearrange
> +------------
> +1 --- 2 --- 3 --- 4 --- 5
> +------------
> +to
> +------------
> +1 --- 2 --- 4 --- 3 --- 5
> +------------
> +by moving the "pick 4" line will result in the following history:
> +------------
> + =C2=A0 =C2=A0 =C2=A0 =C2=A03
> + =C2=A0 =C2=A0 =C2=A0 /
> +1 --- 2 --- 4 --- 5
> +------------
> +
> =C2=A0Authors
> =C2=A0------
> =C2=A0Written by Junio C Hamano <gitster@pobox.com> and
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interacti=
ve.sh
> index f20ea38..6668907 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -181,6 +181,12 @@ test_expect_success '-p handles "no changes" gra=
cefully' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test $HEAD =3D $(git rev-parse HEAD)
> =C2=A0'
>
> +test_expect_failure 'exchange two commits with -p' '
> + =C2=A0 =C2=A0 =C2=A0 FAKE_LINES=3D"2 1" git rebase -i -p HEAD~2 &&
> + =C2=A0 =C2=A0 =C2=A0 test H =3D $(git cat-file commit HEAD^ | sed -=
ne \$p) &&
> + =C2=A0 =C2=A0 =C2=A0 test G =3D $(git cat-file commit HEAD | sed -n=
e \$p)
> +'
> +
> =C2=A0test_expect_success 'preserve merges with -p' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b to-be-preserved master^ &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: > unrelated-file &&
> --
> 1.7.1
>
>
