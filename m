Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE8274666
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649258; cv=none; b=KRXRDL12MsIgEsLsejrXOah0RuZ+OPYR/bzATgjh58POfyd+LGgfO7gD71krWEf5djGFep+YGJnYOgs4kpTG8GLbSrqTfmNZzkB4mORVorXCi14LM57CIVlEZ2SwwjEA8bch7jv51qvSX0g5lbd8rTKDoLbTVVR1TzC/jkuIyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649258; c=relaxed/simple;
	bh=/a+5W860M8YYbI1WRqnjGLO40pQ4Alz2N+Akt8bZ8wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iagtAvhH9F0nJSSUsj8yejuOxSNrPJYAJao/8HqFgRDNFpJMW/RoIOQ8L1l0I+CksF0UrC1NCeKYMFzSuRxXK2AETiLKqIps1Gh4lWVo3IhX5ZkdiQ8gk//UgLp0hSNkX+sVx5kR600opj2ygRP0uuxcsiogY6HgVxrZYUACdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7ZNWdd7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7ZNWdd7"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso1172337a91.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763649255; x=1764254055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwZNGvhQN9GfB7b8ORttJmH6vDQBfhluaV5CQ8b6bkg=;
        b=K7ZNWdd7+wW3QsjkCA3K2GGdmdZRc05bk717V6D1qsw49vQyBQ+SOM+iu/T0wm3jkn
         5IrtxVjtNXaGx9pOrH+Z8l3eHw83opY/xXtm1/RhjxvmtkCE+o9TAIZN0qSC2LnWLRYc
         c+BFvPMIBfPVsx3HHh3GGWHVIRpjykgdtqPLUIV277Xx6s7dGgw6d7/Er5WNhfAWs+pW
         Bd6K/RTLDn/k+gTpKgm6YoVntIu1TGnYZvyt0Vqbv9gqy7AS+rR9Z7bxzcPG2P5V4Urz
         PlWEKm+geU2rKiQ8LtDzoZ8jPM5GKmlrnV3+d/n8J12f3a84PoKDapD4epenx0Ds5dcE
         3dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763649255; x=1764254055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwZNGvhQN9GfB7b8ORttJmH6vDQBfhluaV5CQ8b6bkg=;
        b=SMaTqJNNeQix2UcYryeP1BIhMMjKF5LJwUWdnqw8MsfgU8eRyyT5ccIh42CFdJ/IHI
         soK6IuMS9sXlI2dJtHBZDNhQS2aB1b23AM4k296G5+lH4QnUBwlne5tcyxKixuFv1pKH
         Fk/nzk9HbtapNwTYUzDSN+XSBVqL9g7M8+ZU9anmjmCHfHwlMvno9wmERUdJTqtN4o2e
         XgVbq5OKj8tlQexXXHgJuwWPwXCuYWZysC6a92wDdr+y/aPfZU3q+7o8y0utOCBzaSzo
         TAHqicVJTYrM5wsXIMooLRFV9+Dc4DFZZ1NGuSXjIkjwk2FDhqr8glv1NMHMVdcIUhvg
         QRUg==
X-Forwarded-Encrypted: i=1; AJvYcCVQH+YG22dZFdt3m3uZ1VH/TQNZ+93aXA0UmVKT+e2ZgHjlqGgVa/8kW+T0rDddM0ItSmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhM5fC7nXhr0Y8K8JsSyb4+CC0Ty7b88Hf5gMVFPUCiUwAbSoZ
	+Fry+LphykJQNOw1YrZVq5aGHZGyH/8sQWT3qiUadPb09+Fd7qjkugoOV6TqzRKQHU0/wca0Ewe
	p3xv5egb73MxarIfBzoBTYEYMdXI/661MSIIS
X-Gm-Gg: ASbGnct30Q3K2uUqyhtR5R9U86LzxLLgqV6IYoiETnR+dC9TbrPcoIHK7L0IJd8xgiE
	gBFYhTp0vlZSisGsXWjcZ1aKX+9iMLCt3jzR8yg4haMC/qQfCdCZojvl34JyWRIDas3KKjhlM+h
	N4X/djWNn8dZF6+47YXFmxKeGpL3ta+/khEvEZhyj8y4qtnIjw+qn02UrRCDEkmKSiCEAD4T9b8
	KyngFviRmlqSZDp6aQ7OXkPV72c6P4NPnKY7jeCYAhoVAW/kqjMelW+OqauqCVI2jxh5hcDbcPf
	ku+f3Ai2eazr9R+8vA==
X-Google-Smtp-Source: AGHT+IEKpfIGbCLaP1OZGjZWqvqKslkUyTox5DX6sDYlg457RrSmNuX6oeBGsxa9PLT3BVj8+ErkwhOforY1BY+UPec=
X-Received: by 2002:a17:90b:2e03:b0:340:f009:ca99 with SMTP id
 98e67ed59e1d1-34729764f75mr3655449a91.0.1763649254887; Thu, 20 Nov 2025
 06:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>
 <20251120075019.GA1283645@coredump.intra.peff.net>
In-Reply-To: <20251120075019.GA1283645@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 09:34:03 -0500
X-Gm-Features: AWmQ_bk4mB6pVb3CxMhXSSq3Mykh9BtWKKoBNhGCltc_qSzcaS4kKcDEhCGLq-s
Message-ID: <CALnO6CDL6iixzWD4PqGvh-K-Z12zyhL0-qwfi+iaNK-n_p19qw@mail.gmail.com>
Subject: Re: `git config get --type=path` results in segmentation fault on
 value starting with `:(optional)`
To: Jeff King <peff@peff.net>
Cc: Han Jiang <jhcarl0814@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:52=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Thu, Nov 20, 2025 at 07:46:42PM +1300, Han Jiang wrote:
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > git -c 'section.key-path=3D/nonexistent' config get --show-origin
> > --show-scope --all --type=3Dpath 'section.key-path'
> > git -c 'section.key-path=3D:(optional)/nonexistent' config get
> > --show-origin --show-scope --all --type=3Dpath 'section.key-path'
> >
> > What did you expect to happen? (Expected behavior)
> >
> > 1st command outputs "command command line:   C:/Program Files/Git/nonex=
istent";
> > 2nd command outputs nothing, $?=3D1;
> >
> > What happened instead? (Actual behavior)
> >
> > 1st command outputs "command command line:   C:/Program Files/Git/nonex=
istent";
> > 2nd command outputs "Segmentation fault", $?=3D139;
>
> The issue is that git_config_pathname(), when it sees the ":(optional)"
> marker, may return success (0) to the caller without actually setting
> the "dest" parameter. So if we are lucky, we get a NULL and segfault,
> but we may get any random data from the uninitialized pointer. Here's
> another caller which exhibits similar problems:
>
>   $ git -c blame.ignorerevsfile=3D':(optional)foo' blame
>   double free or corruption (out)
>   Aborted                    git -c blame.ignorerevsfile=3D':(optional)fo=
o' blame
>
> This is all due to 749d6d166d (config: values of pathname type can be
> prefixed with :(optional), 2025-09-28), which changed the contract for
> git_config_pathname(). Before that patch, if the function returned 0,
> then "dest" was guaranteed to point to a string. Now the caller must:
>
>   - set the dest parameter to some known value like NULL before the call
>
>   - after seeing success, check whether dest points to a string (if they
>     want to know whether we actually got a path).
>
> This more or less[*] does the right thing when the dest points to a
> static global, and we call it from a config callback. In that case the
> destination is initialized to NULL, and anybody who looks at the
> variables assumes that NULL means "it was never set at all". And that's
> the case for commit.template, which is what the test from 749d6d166d
> covers.
>
> But many other callers are broken. E.g., blame.ignorerevsfile does this:
>
>           if (!strcmp(var, "blame.ignorerevsfile")) {
>                   char *str;
>                   int ret;
>
>                   ret =3D git_config_pathname(&str, var, value);
>                   if (ret)
>                           return ret;
>                   string_list_insert(&ignore_revs_file_list, str);
>                   free(str);
>                   return 0;
>           }
>
> which tries to insert (and then free!) uninitialized bytes from "str".
> Likewise git-config does:
>
>                   } else if (opts->type =3D=3D TYPE_PATH) {
>                           char *v;
>                           if (git_config_pathname(&v, key_, value_) < 0)
>                                   return -1;
>                           strbuf_addstr(buf, v);
>                           free((char *)v);
>                   }[...]
>

Thanks for the diagnosis; just hit this myself and tracked down the same co=
de.

> Those (and some others) all need to be updated to the new semantics.
> Something like this would fix the blame one:
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 2703820258..15d719aec3 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -733,13 +733,14 @@ static int git_blame_config(const char *var, const =
char *value,
>                 return 0;
>         }
>         if (!strcmp(var, "blame.ignorerevsfile")) {
> -               char *str;
> +               char *str =3D NULL;
>                 int ret;
>
>                 ret =3D git_config_pathname(&str, var, value);
>                 if (ret)
>                         return ret;
> -               string_list_insert(&ignore_revs_file_list, str);
> +               if (str)
> +                       string_list_insert(&ignore_revs_file_list, str);
>                 free(str);
>                 return 0;
>         }
>
> I am tempted to say that git_config_pathname() should set the dest to
> NULL itself in this case, but it is really only half the battle (callers
> still need to check for NULL before looking at the value).

Yeah, unfortunately it doesn't look like string_list_insert considers
NULL a no-op. Similarly I don't think strbuff_add can handle NULL
because it calls strlen on the argument.

> I am not sure about the git-config one, though. What should it print for
> an optional path that is not there? The empty string? Is it an error?
>
> I put a [*] above on "more or less does the right thing" because there's
> another corner case, even for callers like commit.template. What should
> this:
>
>   [commit]
>   template =3D :(optional)does-exist
>   template =3D :(optional)does-not-exist
>
> With the current code, we will ignore the second config entry entirely,
> and the result will point to "does-exist". But that feels surprising to
> me. I'd expect the "optional" marker to set the value unconditionally,
> but with an annotation that the entry does not need to exist. And that's
> something only the caller can interpret (for commit.template, it means
> setting it back to NULL, but for blame.ignorerevsfile, it means skipping
> the string list insertion when it's not there).
>
> I kind of wonder if git_config_pathname() ought to be returning more
> data to the caller, like:
>
>   struct config_pathname {
>         char *path; /* never NULL */
>         unsigned missing : 1;
>   };
>
> That would change the interface of git_config_pathname(), but that would
> also force us to make the appropriate changes in each caller.
>
> -Peff

--=20
D. Ben Knoble
