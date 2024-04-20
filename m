Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB12AEEC
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713635639; cv=none; b=q21klSsS3olH4zz5l/EZNAAwebWxAIXzXD3QmJEA92YUkj3UR8LMLvikCFYSMlulJpic+B7fDRYpgNOtcW/zkkqfUgamd4xA5/4UsHcUWryTCkq3dh2MQS3e40cGyodfIAn9tYZn9TDM2/OhWEs8H4CQVIpmV7HP6WsCaEeoX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713635639; c=relaxed/simple;
	bh=1W40D3zDb3GRMkuFG4dgsLyMw9tVDxcp0z1OUiskmvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jtajL7GsFTqAbg8Rn2UpESRIp1+svIDgVTeS5lqcInR3ncroYf3W1p07XHoxqcsCE4sfx2FMP912mQndIo7zpMTYhk+0AGxe4GBQDXkVUSf0pS/Kd3GTYDu489yog339RN+UJ4UWPYOhm8QbuXxz4gF/DnwTRa9k7Lg+35l3CTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MooQMBID; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MooQMBID"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 18C6C1B196;
	Sat, 20 Apr 2024 13:53:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1W40D3zDb3GR
	MkuFG4dgsLyMw9tVDxcp0z1OUiskmvg=; b=MooQMBIDc75fcGLwVgADc02Q7oVd
	qVJcGuT3oeOoPpdkj28ardxuKoh3A4v3LtqT5he9ZZ2oiwo5D2tiPckdOjnqzWq0
	cJiW71vEByYQRYnmG/KnFediSmJazQktk9Poe9ey+ORqsJiOA+QNffEufLaSqkz4
	XLVP45kqz4oJyZ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 111211B195;
	Sat, 20 Apr 2024 13:53:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B7081B193;
	Sat, 20 Apr 2024 13:53:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] add-patch: response to invalid command
In-Reply-To: <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sat, 20 Apr 2024 13:08:14 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
Date: Sat, 20 Apr 2024 10:53:45 -0700
Message-ID: <xmqqr0ez3opi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F0088F12-FF3E-11EE-8AF5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> When the user enters an invalid command, we respond with a list of
> accepted commands; the response we give to the command '?'.

I am guessing that you want to say with the part of the sentence
after the semicolon that the list of accepted commands and the
explanation for them is the same as what we give when the user asks
'?', but that is after reading the above twice.  I wonder

    When the user gives an unknown command to the "add -p" prompt,
    the list of accepted commands with their explanation is given.
    This is the same output they get when they say `?`.

is easier to understand?

> However, the invalid command may be due to either a user input error or
> a malfunctioning interface component, rather than the user not knowing
> the valid command.

I am not sure readers would understand what you are trying to refer
to with "or a malfunctioning interface component".  I don't, at
least.  Either rewrite it to be understandable, or drop it.  I think
dropping it is sufficient in this case.

> Our response is unlikely to provide help in such situations.
>
> To reduce the likelihood of user confusion and error repetition, if an
> unrecognized command is received, stop displaying the help text and
> display a short error message with the invalid command received, as
> feedback to the user.

"stop ... text and" -> "instead of ... text,"

It would give a better contrast between the current UI and the
proposed new one.

> Include a reminder about the current command '?' in the new message, to
> guide the user if they want help.

OK.

> diff --git a/add-patch.c b/add-patch.c
> index a06dd18985..7be142d448 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1667,7 +1667,7 @@ static int patch_update_file(struct add_p_state *=
s,
>  			}
>  		} else if (s->answer.buf[0] =3D=3D 'p') {
>  			rendered_hunk_index =3D -1;
> -		} else {
> +		} else if (s->answer.buf[0] =3D=3D '?') {
>  			const char *p =3D _(help_patch_remainder), *eol =3D p;
> =20
>  			color_fprintf(stdout, s->s.help_color, "%s",
> @@ -1691,6 +1691,9 @@ static int patch_update_file(struct add_p_state *=
s,
>  				color_fprintf_ln(stdout, s->s.help_color,
>  						 "%.*s", (int)(eol - p), p);
>  			}
> +		} else {
> +			err(s, _("Unknown command '%s' (use '?' for help)"),
> +			    s->answer.buf);
>  		}
>  	}

Looking good.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index bc55255b0a..4c3901de17 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -7,6 +7,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
> =20
> +SP=3D" "

Good to see what is already used in the existing tests reused.

>  diff_cmp () {
>  	for x
>  	do
> @@ -61,6 +63,26 @@ test_expect_success 'setup (initial)' '
>  	echo more >>file &&
>  	echo lines >>file
>  '
> +
> +test_expect_success 'unknown command' '
> +	test_when_finished "git reset command && rm command" &&

Generally, use of && in test_when_finished is a contradiction.  Even
if other things fail, you want "command" to be gone befor ethe next
step, and that is why you use test_when_finished to arrange it to be
cleaned.  Similarly, even if "git reset command" fails here, you
would want command to be cleaned.

What is the expected state of the test repository before we start
this test?  If it is that "git status -uno" would be silent (i.e.,
no paths known to the index and the HEAD are modified in the index
or in the working tree, but there may be random untracked cruft left
in the working tree, like "expect" and stuff), then it makes more
sense to make it easier to read that expectation by doing

	test_when_finished "git reset --hard; rm -f command"

here.  Instead of pretending that we care about making the minimum
damage by selectively resetting the index, we make it clear that we
are giving the _next_ test a pristine state of the index and the
working tree as we inherited from the previous test.

> +	echo W >command &&
> +	git add -N command &&
> +	cat >expect <<-EOF &&
> +	diff --git a/command b/command
> +	new file mode 100644
> +	index 0000000..a42d8ff
> +	--- /dev/null
> +	+++ b/command
> +	@@ -0,0 +1 @@
> +	+W
> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (=
use ${SQ}?${SQ} for help)
> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
> +	EOF
> +	git add -p -- command <command >actual 2>&1 &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'status works (initial)' '
>  	git add -i </dev/null >output &&
>  	grep "+1/-0 *+2/-0 file" output
> @@ -231,7 +253,6 @@ test_expect_success 'setup file' '
>  '
> =20
>  test_expect_success 'setup patch' '
> -	SP=3D" " &&
>  	NULL=3D"" &&
>  	cat >patch <<-EOF
>  	@@ -1,4 +1,4 @@

Otherwise, looking very good.
Will queue.

Thanks.
