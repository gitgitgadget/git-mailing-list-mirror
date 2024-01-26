Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C092030F
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291854; cv=none; b=YUd6w21Y6qJSLfm8ct/u7h6PpEXJ7UAM6U92JYVXaoh7PqIYQXPq0nu1oyMtqBo1yN+fyjUTZTwc9E6dlX7ZBz9Mwv3G5oAh6W40OXgg+/i4O9GGysAjuCm0Dsqv4xTmHeO5OTGicQ6TDn6VFaEuz1frL0kWnoHlmwQgfKmEi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291854; c=relaxed/simple;
	bh=G8+/Lfb6RJT9zlC7rGXvNQ+woNozT3ud9G9caNYn1fY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RywzWjmU5WtH+EKPxGevVAHOPfvs6uYg0ZP3u7iQYQ3xGONQ0u+bOilJKAjHhemIVjnpxG8F1Wl9McnfOmyRtHk7CbzdTDjg+AyFYGWpK1Cw5AiEk0qn0rBl9aRb8Bj09xAC/MfMhCF3V0bnhXhnmLSb5agJS1PzStggc5nrSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JOtv9aH5; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JOtv9aH5"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AB0B12C783;
	Fri, 26 Jan 2024 12:57:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G8+/Lfb6RJT9
	zlC7rGXvNQ+woNozT3ud9G9caNYn1fY=; b=JOtv9aH5Vn999fL6fMCkVjtvL5S+
	XO4gL27CPs0qJ1eLLj/C9wVpn1zmF8me33Te0+YQrJx6TuCO0mmnHXqsyQJfHmrd
	R0dcEWoABlzlBiEGRbQCWYpL0sGjYlPNzszu0H0+yKp3pP1j7Owfi5INo4rK/nLc
	95QJztvoHtgGBZU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 96F632C782;
	Fri, 26 Jan 2024 12:57:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 306B92C781;
	Fri, 26 Jan 2024 12:57:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] completion: reflog with implicit "show"
In-Reply-To: <5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Jan 2024 13:53:01 +0100")
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
	<5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com>
Date: Fri, 26 Jan 2024 09:57:25 -0800
Message-ID: <xmqq8r4cnfju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5DDE307C-BC74-11EE-AE95-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> When no subcommand is specified to "reflog", we assume "show" [1]:
>
>     $ git reflog -h
>     usage: git reflog [show] [<log-options>] [<ref>]
>     ...
>
> We are not completing correctly this implicit uses of "show":
>
> With ...
>
>     $ git checkout -b default
>
> ... we are not completing "default":
>
>     $ git reflog def<TAB><TAB>
>
> And we are incorrectly returning the "subcommands" when:
>
>     $ git reflog default <TAB><TAB>
>     delete expire show
>
> Let's use __gitcomp_subcommand to correctly handle implicit
> subcommands.

As with a good bug report, if you are showing an "incorrect"
behaviour, you should also illustrate what you think is the
"correct" behaviour (see below).

>   1. cf39f54efc (git reflog show, 2007-02-08)
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 9 ++++-----
>  t/t9902-completion.sh                  | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 5f2e904b56..c41f25aa80 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2448,13 +2448,12 @@ _git_rebase ()
>  _git_reflog ()
>  {
>  	local subcommands=3D"show delete expire"
> -	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> =20
> -	if [ -z "$subcommand" ]; then
> -		__gitcomp "$subcommands"
> -	else
> -		__git_complete_refs
> +	if __gitcomp_subcommand "$subcommands"; then
> +		return
>  	fi
> +
> +	__git_complete_refs
>  }

So, when we see something that could be a subcommand we complete it
as a subcommand and return.  In your example, how should

    $ git reflog def<TAB>

work?  We try to see if there is a subcommand that begins with
"def", we see nothing matching, and then run __git_complete_refs?
What if the branch you created earlier were not named "default" but,
say, "delmonte", and you did "git reflog del<TAB>"?  Shouldn't the
user be offered "delete" and "delmonte" as potential completions?

>  __git_send_email_confirm_options=3D"always never auto cc compose"
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index aa9a614de3..231e17f378 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2618,6 +2618,14 @@ test_expect_success 'git clone --config=3D - val=
ue' '
>  	EOF
>  '
> =20
> +test_expect_success 'git reflog show' '
> +	test_when_finished "git checkout -" &&
> +	git checkout -b shown &&
> +	test_completion "git reflog sho" "show " &&

IOW, shouldn't this offer both show and shown?

> +	test_completion "git reflog show sho" "shown " &&
> +	test_completion "git reflog shown sho" "shown "
> +'
> +
>  test_expect_success 'options with value' '
>  	test_completion "git merge -X diff-algorithm=3D" <<-\EOF
