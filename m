From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: filter-branch env-filter example
Date: Thu, 14 Feb 2013 12:29:36 -0800
Message-ID: <7vy5eqy6z3.fsf@alter.siamese.dyndns.org>
References: <511D3C33.6070902@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Tadeusz Andrzej =?utf-8?Q?Kad=C5=82ubowski?= <yess@hell.org.pl>
X-From: git-owner@vger.kernel.org Thu Feb 14 21:30:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U65RU-0003QE-5I
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 21:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761624Ab3BNU3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2013 15:29:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758834Ab3BNU3j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 15:29:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5011B4B0;
	Thu, 14 Feb 2013 15:29:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mq2h5HFmV9HT
	HK5DLAemqS+XRu0=; b=fXJn0cA0c246ACcjDzHZ0tYCfvqqno4H4vZExZFyISa1
	9JAcajQna+cTuSfz0t+T2Amtvbp8LN58hsRCNAC1GUmnzmK2nqiAVWkS49yyn1xM
	5H1f1ccVMsUoETqh/irHdV2qSBLNJ2RTSoDDTZASr+DkLMwlGFKb1f/inmhcEpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Fy034T
	fp2kr0ugpKYZjFjnq3HM0X65+BwdGGhSzg5ViwDDJMLHvQcOi7RKPXlOo8ka8nsI
	sE/WYUIXqxll7jxqu95nJ6zc3Fm5lymsJdYNWVcfqHme9ChSwUBfP40TyP0ZmOtY
	p8trcvuT9rurV7qZkKVWU7UaTGFkoy9GMWfOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B79F1B4AF;
	Thu, 14 Feb 2013 15:29:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC141B4AA; Thu, 14 Feb 2013
 15:29:37 -0500 (EST)
In-Reply-To: <511D3C33.6070902@hell.org.pl> ("Tadeusz Andrzej =?utf-8?Q?Ka?=
 =?utf-8?Q?d=C5=82ubowski=22's?= message of "Thu, 14 Feb 2013 20:34:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40B56488-76E5-11E2-BAEE-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216332>

Tadeusz Andrzej Kad=C5=82ubowski  <yess@hell.org.pl> writes:

> filter-branch --env-filter example that shows how to change the email=
 address
> in all commits by a certain developer.
> ---

Thanks.  Sign-off?

>  Documentation/git-filter-branch.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-=
filter-branch.txt
> index dfd12c9..2664cec 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -329,6 +329,19 @@ git filter-branch --msg-filter '
>  ' HEAD~10..HEAD
>  --------------------------------------------------------
>
> +You can modify committer/author personal information using `--env-fi=
lter`.
> +For example, to update some developer's email address use this comma=
nd:
> +
> +--------------------------------------------------------
> +git filter-branch --env-filter '
> +	if [ $GIT_AUTHOR_EMAIL =3D john@old.example.com ]

Quote the variable in double-quotes, like this:

	if [ "$GIT_AUTHOR_EMAIL" =3D john@old.example.com ]

Otherwise the comparison will break, if the e-mail part had a
whitespace in it, or if it were empty, which is an example of a more
likely situation where you would want to fix commits using a
procedure like this, no?

But more on the example later...

> +	then
> +		GIT_AUTHOR_EMAIL=3Djohn@new.example.com
> +	fi
> +	export GIT_AUTHOR_EMAIL
> +' -- --all
> +--------------------------------------------------------
> +

I do not think an illustration of env-filter is a bad addition
per-se, but the sample scenario is not a realistic one.  No sane
project should be encouraged to rewrite their entire history every
time one of the contributors change his e-mail address.  That is
what the mailmap mechanism is for.

The only scenario that justifies use of the given sample I can think
of is to rewrite the author and committer in an unpublished project
because you noticed that you forgot to set user.name and user.email
up before you created these commits correctly.

Taking all of the above, the added text may look more like this, I
think:

	The `--env-filter` can be used to modify committer and/or
	author identity.  For example, if you found out that your
	commits have wrong identity of yours due to misconfigured
	user.email, you can make correction, before publishing the
	project, like this:

	--------------------------------------------------------
        git filter-branch --env-filter '
        	if test "$GIT_AUTHOR_EMAIL" =3D "root@localhost"
                then
			GIT_AUTHOR_EMAIL=3Dyess@example.com
			export GIT_AUTHOR_EMAIL
		fi
        	if test "$GIT_COMMITTER_EMAIL" =3D "root@localhost"
                then
			GIT_COMMITTER_EMAIL=3Dyess@example.com
			export GIT_COMMITTER_EMAIL
		fi
	' -- --all
	--------------------------------------------------------

By the way, I left the "export" in; "git filter-branch --help"
explicitly says that you need to re-export it.  But I am not sure if
they are necessary, especially after 3c730fab2cae (filter-branch:
use git-sh-setup's ident parsing functions, 2012-10-18) by Peff,
which added extra "export" to make sure all six identity variables
are exported.  After applying the above rewrite, we may want to do
the following as a separate, follow-up patch.

 Documentation/git-filter-branch.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index 8ebe999..066548e 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -83,8 +83,7 @@ OPTIONS
 	This filter may be used if you only need to modify the environment
 	in which the commit will be performed.  Specifically, you might
 	want to rewrite the author/committer name/email/time environment
-	variables (see linkgit:git-commit-tree[1] for details).  Do not forge=
t
-	to re-export the variables.
+	variables (see linkgit:git-commit-tree[1] for details).
=20
 --tree-filter <command>::
 	This is the filter for rewriting the tree and its contents.
@@ -340,12 +339,10 @@ git filter-branch --env-filter '
 	if test "$GIT_AUTHOR_EMAIL" =3D "root@localhost"
 	then
 		GIT_AUTHOR_EMAIL=3Dyess@example.com
-		export GIT_AUTHOR_EMAIL
 	fi
 	if test "$GIT_COMMITTER_EMAIL" =3D "root@localhost"
 	then
 		GIT_COMMITTER_EMAIL=3Dyess@example.com
-		export GIT_COMMITTER_EMAIL
 	fi
 ' -- --all
 --------------------------------------------------------
