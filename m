Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A3207A05
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736495013; cv=none; b=XhorIgCAAF+5RNd5YppYzcyG3ORgKgGBJWZM7iHC/xMTRP+op3fkGEdVm/432fHizZ2jHT3II0L7EqgSxwIm4E798XgdPTOz3hThG6UI6l1WI2v26+dZCfEu/yAo8fIfxLoWb6CYlzWqusCvuTSYhCqiZm+pNgyxfVjHhqgYo2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736495013; c=relaxed/simple;
	bh=yWN9e7h/1sX3p4bpdeu5Pgl6WeNBr5S/8pOwS0ZnkRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlh8fqMeWhv3Ak1ENZH8J3HwK/0DVSOA45YGNXMD1pWMIYpoglELVUULYxy02bGAYKyvQlsPBmRg7XqDJxaYmMYr78LnFboXWrpB8juUum5eNYfQcTh6RniuIuI8+qKiEkcMYCBzu3fZhj/o/uT336hnXsrKEAjdcgICq6kERB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxKNczZ8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxKNczZ8"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-540218726d5so1761813e87.2
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 23:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736495009; x=1737099809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4uQ9Q39Lw8AEQaqoQe7+/zaBcOehMvQhdOzpBwatAs=;
        b=NxKNczZ8T4oyjvD9+mxiEAPdHrRatj08ojfuW5lsifmzKGdxHUtG+Ly3MnHDiUs2Vx
         j/w5yO+d/E5+6lEIpEf5oTzTUEOBNQS8P3zrznK70PnaGha2K7ANN5VLkZsZCrMcWo9r
         SRZGmdzOIVAZiSLk83d72KY2+keh4lKHWE8/WMGBMYkBYZad5Q6so31YcIqjKXtorSAr
         hNgOfqwmNeZxlTraJJ2boiRiprozHKQNV2GrNgKHnSCKJBulbjcBNx+6Wjp+LrB1OlVM
         vFg5t0Y1S5aNtulNb+K/Z4ca2MmdoYLoEtz+kVcnHM8RTfxLAkRLWRxpTZmueFlguY39
         FikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736495009; x=1737099809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4uQ9Q39Lw8AEQaqoQe7+/zaBcOehMvQhdOzpBwatAs=;
        b=gbUb+YcIPwzbHn6xmHHS5DzT+gdpgnYAIJ3numx1soBdCz+7yB/JpQDD8nwPqUrxYN
         fDHiwiQ/4pPamwjFOwHsVLlatebAiet4GwZdYRahhdqfPgyR1PyEmECBcyfMuhAQ+kk9
         YgeGDsNu4OogV54Ew++KXWV0Oki60L0FeGU2Zv0jvC15gLfcnb3IaWhSuCw/BffHGvbq
         7fIFfpZOm/b+YrG26DJcGcd6iYjw98b3iCLkc4BmXbmcI9rKMjgk7IhaVLdLK/p2ePXn
         xN68vi5fNvRT0nkFPNj9WIHYP+Yn6eHLj8hE49xJKZjUOXR5S6C+LwTB+jtLDt1pk754
         Bpdg==
X-Forwarded-Encrypted: i=1; AJvYcCXvQciJCtP/w/92yN8aEy4g8tlwPOPMcsJ/4uCcN+WB99sM3DdQ1J28ImP6cnI+H2QQpdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89oKORSKHQeldB38CgUVOBzAOwlqmqRYL/THZbNfvsvsPY8Yh
	r9DTUkNF291f5nR6JY4IB+YXlj/jGit3OsSXwBdjRsb0r8Twc9wi1nNi/MGeD9+aVfMeZMlfjDY
	H9YuFqQSAnMLteO1gfeEPbsmElVk=
X-Gm-Gg: ASbGnctl+Oph0kHZl7P2YYjN83PEBhl2y726xyfQZrOJODwlsdH67CjbVvZObeaee9W
	YGFKiVFYo80DE2+05srpY5iX5wX96VApMz0t6RUAChU71z/TlDl6P/XR69lS7wPxI9ekXvPs=
X-Google-Smtp-Source: AGHT+IFEAEk6japN3qkIZoyTLy7goh7pKLEXB+dsUQIopHpu2wIUUnr1Fio/H86Gq2KI1tXCeCwatPJ/WzBQAuV+xgA=
X-Received: by 2002:a05:6512:10cc:b0:53e:3729:eaf6 with SMTP id
 2adb3069b0e04-542845d1cf0mr2939684e87.27.1736495008864; Thu, 09 Jan 2025
 23:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
 <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com> <xmqq5xmoj6cz.fsf@gitster.g>
In-Reply-To: <xmqq5xmoj6cz.fsf@gitster.g>
From: Scott Chacon <schacon@gmail.com>
Date: Fri, 10 Jan 2025 08:43:17 +0100
X-Gm-Features: AbW1kvZgQNTa2FYSq21pQwpcAsN8hnHjw8-n5eAH2c2EUtIbWxMECMHx5dS2kAw
Message-ID: <CAP2yMaJzHM+AyDwjfVNJrDeJt0iip5h_ZxgNJL3V-gVSOjoBWQ@mail.gmail.com>
Subject: Re: [PATCH v2] help: interpret boolean string values for help.autocorrect
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Yongmin <yewon@revi.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jan 9, 2025 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> The flow looks nice, but the pre-context of this hunk starts like
> this:
>
>                 if (!value)
>                         return config_error_nonbool(var);
>                 if (!strcmp(value, "never")) {
>                         cfg->autocorrect =3D AUTOCORRECT_NEVER;
>                 } else if (!strcmp(value, "immediate")) {
>                         cfg->autocorrect =3D AUTOCORRECT_IMMEDIATELY;
>                 } else if (!strcmp(value, "prompt")) {
>
> IOW, the new code added at the end of the if/else if/ cascade is way
> too late.
>
>         "[help] autocorrect"
>
> that specifies "true" has already been rejected as an error, with a
> now-stale error message saying that the variable is not a Boolean.

I'm not super familiar with this codebase, honestly, but ifaict this
is not what this does. That top block makes sure that value isn't
null, which I can't figure out how it would ever be - I've tried a
bunch of different config values, but I'm not sure it's possible to do
- and if so it just prints "missing value for help.autocorrect" (the
nonbool part of that function is something of a misnomer, it appears).
But again, I can't see how those two lines aren't essentially a no-op.

> We may probably want to use git_parse_maybe_bool_text() upfront,
> like
>
>         static int parse_autocorrect(const char *value)
>         {
>                 switch (git_parse_maybe_bool_text(value)) {
>                 case 1:
>                         return AUTOCORRECT_IMMEDIATELY;
>                 case 0:
>                         return AUTOCORRECT_NEVER;
>                 default: /* other random text */
>                         break;
>                 }
>                 if (!strcmp(value, "prompt"))
>                         return AUTOCORRECT_PROMPT;
>                 ...
>                 if (!strcmp(value, "prompt"))
>                         return AUTOCORRECT_PROMPT;
>
>                 return 0;
>         }
>
> and then in git_unknown_cmd_config(), do something like
>
>         if (!strcmp(var, "help.autocorrect")) {
>                 int v =3D parse_autocorrect(value);
>
>                 if (!v) {
>                         v =3D git_config_int(var, value, ctx->kvi);
>                         if (v < 0)
>                                 v =3D AUTOCORRECT_IMMEDIATELY;
>                 }
>                 cfg->autocorrect =3D v;
>         }

I _can_ do this, but it seems somewhat more complicated and I believe
it would have the same end result, no?

Also, in thinking about this a bit more, while I updated the patch
with the suggestion to make it accept all boolean text values rather
than the "1" hack, it should be kept in mind that if someone does do
this, that config setting will be backwards incompatible with previous
Git versions in a way that will have a fatal error if it encounters a
string boolean value when a command is mistyped. Maybe that's not
super horrible, but I'm honestly not sure that accepting more boolean
string values is helpful - it's been 17 years of this feature and I
doubt that many people have tried to set it to 'on' or probably would
in the future.

Anyhow, I'm happy to redo this patch in the manner suggested, but
personally I think the first simple DWIM hack is a realistically
better solution.

Scott
