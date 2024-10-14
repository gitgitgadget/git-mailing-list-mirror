Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101E2BD19
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939612; cv=none; b=jgKLeKWubN6SpTV6q/WwPAmS9WTgnweoGO1e+utdZsOeFh3LgixbVRDzKXxqbxWlw2FGZ8eZBNypy+3pdIz7pxDTbxhAAueWLjUygblDPBgfjJIFadfnGutg7JUmzlmOJ47IwsGzqzprrzemTgXrLkL+Gr9BXBaVZGpR37pMJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939612; c=relaxed/simple;
	bh=wLUyFR/B527NLniKS0X0C0EYh4HdMYjPa2LTdE8dH34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWspSVP9Y6vVPwDEkVk6TjZR3wSecTyGpDcLTRiBPLivFJuHKl9WwgFr/COR3GVKUoZG7QcyZvNXqLUf42BwmFw734t64xc6o59by40vfHo2wxBYKipsCYHocFIKccBDZ8gAJjIXQnCcLNTHGHqPbwfhVnTVtVME7278hhUyJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmvzD9/V; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmvzD9/V"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so5208253a12.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728939609; x=1729544409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dhzsOfjhuKO8xYsLf4ZDI01yzL/weNR6vtWvU+3qQ8=;
        b=bmvzD9/Vgalw1EMnpM3gNv53bvBbruFBmE4Ex7hoA2eqzIcqz3OWFiNI42rGMJNhgP
         Q2tKtDChRyE4KkqhVae5IeCmSrVnleVYja6+CRsPsvxIP4ac10qvWs16JyY2MP91cUh+
         VtDrBU2mTJHMIO0hR6cgr+rDE7VG8N+7eNzgWg3YTPsH04YeBi8gbMtq4PBx24wAKQAy
         vuehU0vOqGU1435TgM5XFlWvJRBVBS6hAliOqWhVFDscJmVf6dKSrg/AL9TqMk40f31S
         KBqxqOJq7yi9PNvYHhRVVaza59NCLLlQXHHoLonR4QfLemD75KX5EP05EZZnv4HshVME
         NmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939609; x=1729544409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dhzsOfjhuKO8xYsLf4ZDI01yzL/weNR6vtWvU+3qQ8=;
        b=EnZC+dWwyOHBlASqgIbbuLInUCQ3suU2PB6WwzOY3g3LYRrJmVIJ8ZpueCKnSfJhbM
         4q4P3tvUj5Oknj5EqeZuwe6r8ULHCczJisl2trzyejTaPayLVW8uUQ4BuaBMLVJzdVTE
         nFzSeVXbmyo9iHerjcu6Tk45LVWvBLclZ4dvwCC5KLuu35Ywihvj4rixECloqiVdEbo2
         c1jaSGa2SPSBGeGr6QlLQO44+LuLOl3v8YSuKG7h1F16gnf9PbPtUe9gLz5THjxX0foP
         jwZnTCBnhnMIMMQVIZZwakQt3/1StAJtt68sWfewURzv81MKU8aDsyDyABlQZjmsufJG
         GSSA==
X-Gm-Message-State: AOJu0Ywn2QhCx5gxK3O/JfAJThtZfx1sZjVJqbS3lYoby3tHF4QeYnLX
	MT5E8cY754F4B5E8Pd0ynK7lMdQmRXEqbh1aGkaCT8q2LoikZS4oQBpX9kZrYgzAqlEM0sylvdX
	H1Tm6v8Os7dpOR0NTJA1w1Lr9GpVyVFGpCdMv
X-Google-Smtp-Source: AGHT+IHrdn4M7sTjwT21KcNP2Tujd2US9/D0L2nelp74nMHC720MTIIrH+Zq5VMxS3PDdKG9US9TJwUqNG2HPhluSeE=
X-Received: by 2002:a17:906:f590:b0:a99:4780:1af with SMTP id
 a640c23a62f3a-a99b93c8dc4mr981943766b.31.1728939609026; Mon, 14 Oct 2024
 14:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728697428.git.karthik.188@gmail.com> <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
In-Reply-To: <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 14 Oct 2024 13:59:57 -0700
Message-ID: <CAO_smViSU5KohOqVXp2L_cM3G-jrOGQY=J=qf=-GbiGsOYd9TQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) we
> adjusted the line break penalties to really fine tune what we care about
> while doing line breaks. Modify some of those to be more inline with
> what we care about in the Git project now.
>
> We need to understand that the values set to penalties in
> '.clang-format' are relative to each other and do not hold any absolute
> value. The penalty arguments take an 'Unsigned' value, so we have some
> liberty over the values we can set.
>
> First, in that commit, we decided, that under no circumstances do we
> want to exceed 80 characters. This seems a bit too strict. We do
> overshoot this limit from time to time to prioritize readability.

I think that attempting to get the weights right so as to avoid cases
where there was an intentional affordance for readability is going to
be essentially impossible. Areas where there's an intentional
disregard for the clang-format-generated formatting should disable the
formatter for that line/region, instead of trying to find a way to
adjust the rules to produce something that's going to end up being
context dependent.

Example: In ref-filter.c, there's 13 lines when initializing the
`valid_atom` array that are >80 characters, and 20 lines that are >80
columns (when using 8-space tabs). Line breaking in that block of code
may be undesirable, so just disable clang-format there. I don't think
there's a consistent set of penalties you could establish that would
handle that well without mishandling some other section of code.

It's also not clear what the reason for the overshoot is in many cases.
- difference between "80 characters" and "80 columns"?
    - (1394 >80char lines in *.{h,c}, 4849 >80col lines in the same files)
- intentional for readability?
- refactorings pushed originally compliant lines out of compliance?
- no one caught it and it was just added without any intentional decision?

> So
> let's reduce the value for 'PenaltyExcessCharacter' to 10. This means we
> that we add a penalty of 10 for each character that exceeds the column
> limit. By itself this is enough to restrict to column limit. Tuning
> other penalties in relation to this is what is important.
>
> The penalty `PenaltyBreakAssignment` talks about the penalty for
> breaking an assignment operator on to the next line. In our project, we
> are okay with this, so giving a value of 5, which is below the value for
> 'PenaltyExcessCharacter' ensures that in the end, even 1 character over
> the column limit is not worth keeping an assignment on the same line.
>
> Similarly set the penalty for breaking before the first call parameter
> 'PenaltyBreakBeforeFirstCallParameter' and the penalty for breaking
> comments 'PenaltyBreakComment' and the penalty for breaking string
> literals 'PenaltyBreakString' also to 5.
>
> Finally, we really care about not breaking the return type into its own
> line and we really care about not breaking before an open parenthesis.
> This avoids weird formatting like:
>
>    static const struct strbuf *
>           a_really_really_large_function_name(struct strbuf resolved,
>           const char *path, int flags)

Is this how it'd be indented without the penalties, or would it do
this, with the function name indented the same amount as the return
type (which is, in C, probably going to be the 0th column most times):

static const struct strbuf *
a_really_really_large_function_name(struct strbuf resolved,
        const char *path, int flags)

>
> or
>
>    static const struct strbuf *a_really_really_large_function_name(
>             struct strbuf resolved, const char *path, int flags)

Personal opinion: I prefer this over the version that has a single
argument on the first line. My preference for reading functions is:

return_type func_name(arg1, arg2,
                      arg3, arg4,
                      arg5, arg6, ...);

Or

return_type func_name(
        arg1, arg2, arg3, arg4,
        arg5, arg6, ...);

or, in some cases, putting every argument on their own line (typically
when the majority of the arguments are already on their own line, not
having one "hiding" somewhere is preferable, but at this point if
that's not what my formatter does, I don't fight it).

For functions that accept an obvious first parameter, such as
`strbuf_add`, maybe having the first parameter on the first line is
acceptable/desirable, since it's "obvious" what it is/does. But for
many functions that's not the case, and needing to read the end of the
first line, potentially beyond the 80th column, feels weird.

>
> to instead have something more readable like:
>
>    static const struct strbuf *a_really_really_large_function_name(struct=
 strbuf resolved,
>           const char *path, int flags)
>
> This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
> and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
> few characters above the 80 column limit to make code more readable.

A few examples, such as by formatting the code using the current rules
(since much of the codebase does not currently comply), and then
changing the penalties and seeing what changes, might be nice?


>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .clang-format | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/.clang-format b/.clang-format
> index 41969eca4b..66a2360ae5 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -209,13 +209,14 @@ KeepEmptyLinesAtTheStartOfBlocks: false
>
>  # Penalties
>  # This decides what order things should be done if a line is too long
> -PenaltyBreakAssignment: 10
> -PenaltyBreakBeforeFirstCallParameter: 30
> -PenaltyBreakComment: 10
> +PenaltyBreakAssignment: 5
> +PenaltyBreakBeforeFirstCallParameter: 5
> +PenaltyBreakComment: 5
>  PenaltyBreakFirstLessLess: 0
> -PenaltyBreakString: 10
> -PenaltyExcessCharacter: 100
> -PenaltyReturnTypeOnItsOwnLine: 60
> +PenaltyBreakOpenParenthesis: 300

How does this interact with PenaltyBreakBeforeFirstCallParameter? Does
one override the other?

> +PenaltyBreakString: 5
> +PenaltyExcessCharacter: 10
> +PenaltyReturnTypeOnItsOwnLine: 300
>
>  # Don't sort #include's
>  SortIncludes: false
> --
> 2.47.0
>
