Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379E6EB5B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402717; cv=none; b=Xj7ZqRpVw7zVfRs+3ZcbWwqcjkneEWu4zcdxIYF7gkfM25Fzp7u8nFLYvj7JKFvqpAgTlfGGEMrlso/+pwpr7zEs7bLM1z2LJy804jBG1HUx+A09PeIhsAHd2SuSqUcGVHG/dLnhBdGUdkdl8DLRRiJtyTNEvTZ/cSYS2v+D8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402717; c=relaxed/simple;
	bh=hk56U2p9yYQJR24cGRWWC/hEuI8NOG08BUsIr8VCRGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ePI3Jns/w1alM+9LDLyeLlBDF+DFFVsinOY4x0OxshE8r1IlzStmyNpC5nONwG8a1q461dZV6S2PxbvoeYEzldk6ulW7+HIbhOVmQeVTmI/Kvdh8QWH6OJD59FynBUHfivjuq7W8jYiajTvZ7iSUdDcNTgDqOqKSXF8DiMmPFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HmQodcPr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HmQodcPr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 610B827BB3;
	Mon, 25 Mar 2024 17:38:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hk56U2p9yYQJ
	R24cGRWWC/hEuI8NOG08BUsIr8VCRGY=; b=HmQodcPrXUe0qeLAfNWAOMoVv4DV
	Gt5VKzTVK48oRuMPZl6STgHasXBs/UH+djK6qyfa/GGUCbJs2xdl22GgDmWjIhH0
	Q0nVvj2yzcxuLbK3+tB8gKgclYs953tANg1rWL69BA5e+P1zya5Y8NyPoviL87s2
	dK+ZdVQQZZ0B3Hg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 596A427BB2;
	Mon, 25 Mar 2024 17:38:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B184B27BB1;
	Mon, 25 Mar 2024 17:38:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] add-patch: introduce 'p' in interactive-patch
In-Reply-To: <fa64a975-40e4-40f2-bdcf-fd2da4fc506e@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 25 Mar 2024 22:05:25 +0100")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<fa64a975-40e4-40f2-bdcf-fd2da4fc506e@gmail.com>
Date: Mon, 25 Mar 2024 14:38:30 -0700
Message-ID: <xmqqcyrigfft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 068405AE-EAF0-11EE-8511-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Shortly we're going make interactive-patch stop printing automatically
> the hunk under certain circumstances.
>
> Let's introduce a new option to allow the user to explicitly request
> the printing.

That is good, but ...

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  add-patch.c                |  4 ++++
>  t/t3701-add-interactive.sh | 22 +++++++++++-----------
>  2 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 68f525b35c..52be1ddb15 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undec=
ided hunk\n"
>     "/ - search for a hunk matching the given regex\n"
>     "s - split the current hunk into smaller hunks\n"
>     "e - manually edit the current hunk\n"
> +   "p - print again the current hunk\n"
>     "? - print help\n");
> =20
>  static int patch_update_file(struct add_p_state *s,
> @@ -1480,6 +1481,7 @@ static int patch_update_file(struct add_p_state *=
s,
>  				permitted |=3D ALLOW_EDIT;
>  				strbuf_addstr(&s->buf, ",e");
>  			}
> +			strbuf_addstr(&s->buf, ",p");
>  		}
>  		if (file_diff->deleted)
>  			prompt_mode_type =3D PROMPT_DELETION;
> @@ -1658,6 +1660,8 @@ static int patch_update_file(struct add_p_state *=
s,
>  				hunk->use =3D USE_HUNK;
>  				goto soft_increment;
>  			}
> +		} else if (s->answer.buf[0] =3D=3D 'p') {
> +			/* nothing to do */

This is not good.  If we are taking a new input, why doesn't the
code already respond to it?  "Showing it again" should be a separate
feature even if some other codepaths still do show when [2/2] would
prevent them to show, no?

Also, in addition to the changes to the patch to unbreak it, we'd
need to update the git-add(1) manual page, especially its section on
the interactive mode.  I think a single-line addition should suffice,
but it has to be there, added by the same patch as the one that
starts accepting 'p' and acting on that input.

Thanks.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 0b5339ac6c..bc55255b0a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -325,9 +325,9 @@ test_expect_success 'different prompts for mode cha=
nge/deleted' '
>  	git -c core.filemode=3Dtrue add -p >actual &&
>  	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
>  	cat >expect <<-\EOF &&
> -	(1/1) Stage deletion [y,n,q,a,d,?]?
> -	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,?]?
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]?
> +	(1/1) Stage deletion [y,n,q,a,d,p,?]?
> +	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
> +	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
>  	EOF
>  	test_cmp expect actual.filtered
>  '
> @@ -514,13 +514,13 @@ test_expect_success 'split hunk setup' '
>  test_expect_success 'goto hunk' '
>  	test_when_finished "git reset" &&
>  	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? + 1:  -1,2 +1,3         =
 +15
> +	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3       =
   +15
>  	_ 2:  -2,4 +3,8          +21
>  	go to which hunk? @@ -1,2 +1,3 @@
>  	_10
>  	+15
>  	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
>  	EOF
>  	test_write_lines s y g 1 | git add -p >actual &&
>  	tail -n 7 <actual >actual.trimmed &&
> @@ -530,11 +530,11 @@ test_expect_success 'goto hunk' '
>  test_expect_success 'navigate to hunk via regex' '
>  	test_when_finished "git reset" &&
>  	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? @@ -1,2 +1,3 @@
> +	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
>  	_10
>  	+15
>  	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
>  	EOF
>  	test_write_lines s y /1,2 | git add -p >actual &&
>  	tail -n 5 <actual >actual.trimmed &&
> @@ -715,21 +715,21 @@ test_expect_success 'colors can be overridden' '
>  	<BLUE>+<RESET><BLUE>new<RESET>
>  	<CYAN> more-context<RESET>
>  	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,?]? <RESET><BOLD>Split i=
nto 2 hunks.<RESET>
> +	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET><BOLD>Split=
 into 2 hunks.<RESET>
>  	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
>  	<CYAN> context<RESET>
>  	<BOLD>-old<RESET>
>  	<BLUE>+<RESET><BLUE>new<RESET>
>  	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET><MAGENT=
A>@@ -3 +3,2 @@<RESET>
> +	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGE=
NTA>@@ -3 +3,2 @@<RESET>
>  	<CYAN> more-context<RESET>
>  	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? <RESET><MAGENTA>=
@@ -1,3 +1,3 @@<RESET>
> +	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENT=
A>@@ -1,3 +1,3 @@<RESET>
>  	<CYAN> context<RESET>
>  	<BOLD>-old<RESET>
>  	<BLUE>+new<RESET>
>  	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET>
> +	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
>  	EOF
>  	test_cmp expect actual
>  '
