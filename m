From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.txt: document limitations on non-typical repos (and
 hints)
Date: Wed, 06 Oct 2010 09:32:31 -0700
Message-ID: <7vsk0j46zk.fsf@alter.siamese.dyndns.org>
References: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
 <4cac8659.0541730a.0ef0.3ff9@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, weigelt@metux.de, spearce@spearce.org,
	jrnieder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	raa.lkml@gmail.com, judge.packham@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 06 18:33:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3WvR-0000nr-Ay
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 18:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab0JFQcz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 12:32:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab0JFQcx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 12:32:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 099AADC2F2;
	Wed,  6 Oct 2010 12:32:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=moBRz0wRf69A
	MbExzSCrrBNYJRo=; b=L7kyuv/nMfDe25/PvXiFd3AHGGehNbNCasSHG1QHnSyx
	qkMa0wbBn8G+ZR9gHvDJPVT2FREx4GO2g+vmYePSxD/agCyO8Q+kjb3Z5Cnupak8
	kuUQUGR4I1T7CdjHL+hqGKUWvZYQ6WcjXXFMGCfo+T1BOZlP+7ZApbeGX3pvclU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aBsHWW
	jLARUm2v92a1XoAOirPDPX/Zmx2FDHbagU1dtdujTsYkp2J913nnUU1onUN2TWQP
	QVfT/D6fIMen7RZcA+0dssI1vClRvljWtXsppwE0Bbofjb91v5i893vC5pxwOMWG
	VXZ6YmH1woeiLchFmZ2ciVuJ53qEkHAMQT/v4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 650B2DC2E9;
	Wed,  6 Oct 2010 12:32:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFDFFDC2E7; Wed,  6 Oct
 2010 12:32:33 -0400 (EDT)
In-Reply-To: <4cac8659.0541730a.0ef0.3ff9@mx.google.com> (pclouds@gmail.com's
 message of "Wed\,  6 Oct 2010 21\:23\:11 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58121D9A-D167-11DF-BC67-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158295>

pclouds@gmail.com writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> ---
>  Revised version. I dropped shallow clone because it does not really
>  relate to performance.
>
>  Documentation/git.txt |   41 +++++++++++++++++++++++++++++++++++++++=
++
>  1 files changed, 41 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index dd57bdc..129947f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -729,6 +729,47 @@ The index is also capable of storing multiple en=
tries (called "stages")
>  for a given pathname.  These stages are used to hold the various
>  unmerged version of a file when a merge is in progress.
> =20
> +Performance concerns
> +--------------------
> +
> +Git is written with performance in mind and it works extremely well
> +with its typical repositories (i.e. source code repositories, with
> +a moderate number of small text files, possibly with long history).
> +Non-typical repositories (a lot of files, or very large files...)
> +may experience mild performance degradation. This section describes
> +how Git behaves in such repositories and how to reduce impact.
> +

I have seen this "mild" suggested in the discussion, but do we want any
adjective here?  The runtime for, say, "git log" from the tip to the ro=
ot
obviously would grow proportionally to the length of the history, i.e. =
the
number of records you would want to see, and it may not be "mild" if yo=
ur
history is very deep.  Same for the runtime for "git diff" in a wide
project with many changed paths.

More importantly, what is "degradation"?  It is not a degradation if "g=
it
log" took 100x as long for a project with 100k commits compared to a
similar project with 1k commits.

If you do not have enough core to hold the part of the ancestry graph t=
hat
is involved to compute "git log A..B" to show a gazillion commits, it w=
ill
eat into the swap, take a lot more time than it takes "git log B" to sh=
ow
the same number of commits.  That _is_ degradation, and I suspect it wo=
n't
be mild at all.

> +For repositories with a large number of files (~50k files or more),

How did you come up with this 50k number?

> +but you only need a few of them present in working tree, you can use
> +sparse checkout (see linkgit:git-read-tree[1], section 'Sparse
> +checkout').

Is "sparse checkout" a real feature that has been made usable by mere
mortals, battle tested, and shown to be reliable?

It feels funny that we have to refer to the documentation of plumbing
read-tree when the key verb in this paragraph is "checkout".  With the
current documentation set, you can follow read-tree page that mentions
some magic called skip-worktree-bit, get tempted to jump to update-inde=
x
page and get lost in the implementation details of the feature, which i=
s
irrelevant to the end user.  If you resisted the temptation and keep
reading read-tree page, you see the description of info/sparse-checkout=
 to
learn how to control the feature, but it does not come with an
easy-to-follow example.  A few concrete suggestions to "Sparse checkout=
"
section in read-tree:

    - Move the section to a separate file and include it in read-tree
      page, so that we can include it later in checkout page;

    - Drop the first paragraph;

    - Move the second and third paragraph, that still describe the
      machinery more than the usage, much later in the section;

    - Start the section with the description of info/sparse-checkout; t=
he
      first sentence ("while ... is usually used") need to be rewritten=
,
      because (1) it is not a complete sentence and grammatically
      incorrect, and (2) it reads as if you will say an alternative fil=
e
      can be used instead of info/sparse-checkout, which is not what yo=
u
      wanted to do; perhaps "$GIT_DIR/info/sparse-checkout is used to
      specify which paths are to be (and not to be) checked out. It lis=
ts
      glob patterns to match paths to be checked out. Prefix the patter=
n
      with a '!' to specify a pattern to match paths not to be checked
      out.  Note: a bug in the implementation requires you to end a
      pattern with a trailing slash to match a directory".

    - Show examples; not just the samples of how contents of that contr=
ol
      file looks like, but also with a concrete command sequence (e.g. =
(1)
      run "git clone -n", (2) edit info/sparse-checkout to contain this=
,
      (3) run "git checkout", (4) here is how to widen/narrow the spars=
e
      checkout--first edit info/sparse-checkout to look like this and t=
hen
      run "git xxx" to match the updated definition, etc.).

    - Drop BUGS section from read-tree documentation (but see Note: abo=
ve
      in my example); the bug mentioned there is not a bug of read-tree=
,
      but is a bug in the sparse-checkout feature.

I think the suggestion to use Sparse checkout in git(1)---i.e. your pat=
ch
we are discussing here, is a bit premature before the above happens.

> +... If you need all of them present in working tree, but you
> +know in advance only a few of them may be modified, please consider
> +using assume-unchanged bit (see linkgit:git-update-index[1]).
> +... The following commands are
> +however known to do full index refresh in some cases:

It is "need to", not "are known to", isn't it?

> +Some commands need entire file content in memory to process.
> +Files that have size a significant portion of physical RAM may
> +affect performance. You may want to avoid using the following
> +commands if possible on such large files:

"If possible" is not a good excuse.  How would one _avoid_ checkout of =
a
file if one wants to use it?  You can't.  Similarly to "diff".  This
advice is pretty much useless, isn't it?  It's not much better than say=
ing
"if your machine has too little RAM, things will get slow---deal with i=
t".

> +* All checkout commands (linkgit:git-checkout[1],
> +  linkgit:git-checkout-index[1], linkgit:git-read-tree[1],
> +  linkgit:git-clone[1]...)
> +* All diff-related commands (linkgit:git-diff[1],
> +  linkgit:git-log[1] with diff, linkgit:git-show[1] on commits...)
> +* All commands that need file conversion processing (see
> +  linkgit:gitattributes[5])
> +
>  Authors
>  -------
>  * git's founding father is Linus Torvalds <torvalds@osdl.org>.
> --=20
> 1.7.0.2.445.gcbdb3
