Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B813C433DF
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF6B2063A
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a7zZ+5BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgGLSEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:04:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58116 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGLSEW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 14:04:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDA517AB65;
        Sun, 12 Jul 2020 14:04:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DtWTqC9UbMNV
        W9oBTqKUya5KkJY=; b=a7zZ+5BLqOXxZPDH5ro0/RGTEhC1Xby1y42PdbjQ3KX1
        rS4Znz7pJWpwlEyRycpb8La06p/glCXzKP9CwWDb/KqXX0piY8RFytLhjm/iDt7P
        YYCpDim3yh7vlIRrHaxRlQT7v4G+03z2hnsE038+4ECNmhR/YJnZJC1Fa1D7W4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qM7Hdd
        0CntUYSGrXPDx8x50a0PszoZsOa82q8lOcAG/FtoS9BDIMcllzdsi633XpF8y113
        aXfBtzuOBlGkqGnRd2MViMgAeS9QEU9KE46UNEGhckp+KarhGFBJacAvBci5FmBZ
        q+rBkFCqWy0Qu+ECMeIgy7I5k2F1481qRDNT8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D55E57AB64;
        Sun, 12 Jul 2020 14:04:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C0987AB63;
        Sun, 12 Jul 2020 14:04:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v16] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v15.git.git.1594543148959.gitgitgadget@gmail.com>
        <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
Date:   Sun, 12 Jul 2020 11:04:14 -0700
In-Reply-To: <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
        (sunlin via GitGitGadget's message of "Sun, 12 Jul 2020 09:08:23
        +0000")
Message-ID: <xmqqzh84pq3l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 190A8910-C46A-11EA-A1ED-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lin Sun <lin.sun@zoom.us>
>
> Make the mergetool used with "meld" backend behave similarly to "vimdif=
f" by
> telling it to auto-merge non-conflicting parts and highlight the confli=
cting
> parts when `mergetool.meld.useAutoMerge` is configured with `true`, or =
`auto`
> for detecting the `--auto-merge` option automatically.
>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> Helped-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>     Enable auto-merge for meld to follow the vimdiff beharior
>    =20
>     Hi, the mergetool "meld" does NOT merge the no-conflict changes, wh=
ile
>     the mergetool "vimdiff" will merge the no-conflict changes and high=
light
>     the conflict parts. This patch will make the mergetool "meld" simil=
ar to
>     "vimdiff", auto-merge the no-conflict changes, highlight conflict p=
arts.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-7=
81%2Fsunlin7%2Fmaster-v16
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/=
sunlin7/master-v16
> Pull-Request: https://github.com/git/git/pull/781
>
> Range-diff vs v15:
>
>  1:  02d849784f ! 1:  d235a576b4 Support auto-merge for meld to follow =
the vim-diff behavior
>      @@ mergetools/meld: diff_cmd () {
>       -	else
>       -		meld_has_output_option=3Dfalse
>       +		meld_use_auto_merge_option=3D$(
>      -+			git --bool-or-str config mergetool.meld.useAutoMerge)
>      ++			git config --bool-or-str mergetool.meld.useAutoMerge)

It is quite clear in this hunk that that the previous one was not
even proofread before sending X-<.

> +		} else if (type =3D=3D TYPE_BOOL_OR_STR) {
> +			int is_bool, v;
> +			v =3D git_config_bool_or_str(NULL, key_, value_, &is_bool);
> +			if (is_bool)
> +				strbuf_addstr(buf, v ? "true" : "false");
> +			else
> +				strbuf_addstr(buf, value_);
>  		} else if (type =3D=3D TYPE_PATH) {
>  			const char *v;
>  			if (git_config_pathname(&v, key_, value_) < 0)
> @@ -411,6 +422,14 @@ static char *normalize_value(const char *key, cons=
t char *value)
>  		else
>  			return xstrdup(v ? "true" : "false");
>  	}
> +	if (type =3D=3D TYPE_BOOL_OR_STR) {
> +		int is_bool, v;
> +		v =3D git_config_bool_or_str(NULL, key, value, &is_bool);
> +		if (!is_bool)
> +			return xstrdup(value);
> +		else
> +			return xstrdup(v ? "true" : "false");
> +	}

That's unfortunate that we need almost identical code duplicated
here and above.  It probably is a tad larger than what we typcally
call #leftoverbits, so please ignore it for now.

> diff --git a/config.c b/config.c
> index 8db9c77098..4c6c06d10b 100644
> --- a/config.c
> +++ b/config.c
> @@ -1100,6 +1100,20 @@ int git_config_bool_or_int(const char *name, con=
st char *value, int *is_bool)
>  	return git_config_int(name, value);
>  }
> =20
> +int git_config_bool_or_str(const char **dest, const char *name, const =
char *value, int *is_bool)
> +{
> +	int v =3D git_parse_maybe_bool_text(value);
> +	if (0 <=3D v) {
> +		*is_bool =3D 1;
> +		return v;
> +	}
> +	*is_bool =3D 0;
> +	if (dest !=3D NULL)
> +	  return git_config_string(dest, name, value);
> +	else
> +	  return 0;
> +}

Wrong indentation.

I do not think this is a good interface at all, from at least three
points.

 - What happens when the value is set to "2"?  git_config_bool()
   would say, because it calls git_config_bool_or_int() and learns
   that the value is an integer 2 and uses !! operator on it to
   normalize it to 1, we judge it as "true".  Your implementation
   says it is not a bool and instead it is a string "2".  When
   telling a boolean and an integer apart, saying 2 is not a bool
   makes sense, but given that "interpret this value as boolean"
   logic in git_config_bool() says "2" is a true, the logic to tell
   a boolean and a string apart probably should say that the user
   who wrote "2" there meant true, i.e. boolean.

 - What's the returned value from this function and how can the
   caller sensibly use it?  If it happened to be (narrowly defined)
   bool, the returned value is 0 for false and 1 for true.
   Otherwise, the caller gets 0 if it forgets to pass dest, or 0 if
   value successfully gets returned as a string, or -1 upon an
   error.  Hence it is impossible for the caller to use

	if (git_config_bool_or_str(...)) {
		... do one thing ...
	} else {
		... do something else ...
	}

 - There is no point to pass dest to this function.  If it is not
   bool, then the caller can do strdup() the value.

> diff --git a/config.h b/config.h
> index 060874488f..175b88d9c5 100644
> --- a/config.h
> +++ b/config.h
> @@ -217,6 +217,13 @@ ssize_t git_config_ssize_t(const char *, const cha=
r *);
>   */
>  int git_config_bool_or_int(const char *, const char *, int *);
> =20
> +/**
> + * Same as `git_config_bool`, except that `is_bool` flag is unset, the=
n if
> + * `dest` parameter is non-NULL, it allocates and copies the value str=
ing
> + * into the `dest`, if `dest` is NULL and `is_bool` flag is unset it r=
eturn 0.
> + */

is_bool is not an "in-parameter" flag but a pointer to point at
where the result is stored, so the above description does not make
much sense.  I suspect, from the actual implementation, that you
wanted to say

    Parse "value" to see if it is a boolean, and if so set *is_bool
    to true and leave *dest untouched.  If it is not a boolean, set
    *is_bool to false and assign a copy of value to *dest.

But again, I do not think this function is designed right, so let's
not spend any more time polishing what you wrote for now.

I would expect something like this in builtin/config.c would be
sufficient:

	if (type =3D=3D TYPE_BOOL_OR_STRING) {
		int v =3D git_parse_maybe_bool(value);
		if (v < 0)
			return xstrdup(value);
		else
			return xstrdup(v ? "true" : "false");
	}

i.e. we do not need a new helper in the lower level of the API stack.

> +		meld_use_auto_merge_option=3D$(
> +			git config --bool-or-str mergetool.meld.useAutoMerge)

If the body is made on a separate line for readability, doing it more
like so would be even more readable:

		meld_use_auto_merge_option=3D$(
			git config --bool-or-str mergetool.meld.useAutoMerge
		)

> +		case "$meld_use_auto_merge_option" in
> +		true|false)
> +			: use well formatted boolean value
> +			;;
> +		auto)
> +			# testing the "--auto-merge" option only if config is "auto"
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--auto-merge"*|*'[OPTION...]'*)
> +				meld_use_auto_merge_option=3Dtrue
> +				;;
> +			*)
> +				meld_use_auto_merge_option=3Dfalse
> +				;;
> +			esac
> +			;;
> +		*)
> +			meld_use_auto_merge_option=3Dfalse

Now that the --bool-or-string would be silent, you have to give an
error message yourself here, no?  Have you hand-tested the result of
applying your patch to see if all the cases we care about (i.e.
various scenarios we raised and thought together how the code should
react to the situation during the review discussion so far)?

We are not in a hurry, and we will not be paying too much attention
on topics that are not yet in 'next' until the upcoming release is
done anyway, so take your time to try polishing before sending
anything out.

Thanks.
