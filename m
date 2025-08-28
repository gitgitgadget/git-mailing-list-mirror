Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A2189F3B
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389640; cv=none; b=tvabwDA4ELJ8jkQz+jDZnG2qg+NfuHsy0Auc4XxYcLv01tcm4XrGAb+LKPfh1V5j7zJdkgig2e1+ny1vfBEDK2LPMsyJb0h9w6mu/OQvaFUxbutW/3CPom6STln2Thq3AnCYdWjHqPDaJTzaiNoVB4R/vrubTxvUJW2f9QtPLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389640; c=relaxed/simple;
	bh=qrUdT4KxvTBKbBQKHMjkmrEuboOrdZj8dRjzKnC2epg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeAaAShhC1GZDKE/na/tILSthlSDDzTWRg9334vn2X6+xgh2t4XYP1hkOqZtFvMXOBnTcQ9Z66Mfh8fbxlYRIpA9VEd5gUbYCqUyNBRr9+PgAGqvWK8QPZwfVQEvvfK81PTGdHhcoc60rtQdfI6JIATXXmleENVdP5NBJ9vX25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiWu/ebG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiWu/ebG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cd1046d42so1241267a12.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756389637; x=1756994437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWla199TyYN/GSQq4ASC7G1EtcOJFSGWKsYbfKxfqFQ=;
        b=UiWu/ebGsTaVHmOWzI8UBud9NATEwucZOABg9akidkccr7K5t/2d1penVvJrtwxy3c
         nu3qEtn8SVJbiDBYCtnmg3Bs34QfAhgEBpojWvy5ZTpiAqlkSASCo3J+3I3GJfS59Rm3
         q2EBsxrNxXj1iSeo13WGirG3mggCghV6BDUq7FQI56rD2WYegJkKAo5/nQHlEUqctZgH
         AemRDL8t108DUEq5Me+MOAQPjOTn5gCCgpJiIU3CeT+sE+FOPTN+kXjdhgfGgzt5c38X
         RlYEFJA9bYglDYGAZqs+xZZno/wgEfd/C/LymWXHMO0CM9/fMz6DvTBnwEXMFbpzXJzW
         LIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756389637; x=1756994437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWla199TyYN/GSQq4ASC7G1EtcOJFSGWKsYbfKxfqFQ=;
        b=fL8uQ2GUvcdUP6jabVeUZHWy5EID0lmfBrxuig+w0i4WUXB2yyNRFS8/9/CHbLSvUb
         4ibO9XFp50d5X8SY4Z6CSV/olZwjTzM0z5HzgPst8E2CDwBf1Z6WouftCpgCWF6PibUy
         FamDJpYcK9GnX29YlulzjQMeg2sIZ8H7MXmsjHLvapYCSz1pvXF7Oxp3ESh0Y/1MToWq
         1iEl3uaLBFVCOVqUUixWZ1MTMYGhDDdGPoTqbYFMB3lmGJXBK/0F4topO3Yjtx1bmbR6
         1XnxQeCg2OSbeQKSUQmeGi9wlK6Q000Xh6RNVC4S/hRLdYwzcMVrOBVrw30xjSukY+HV
         Gl6Q==
X-Gm-Message-State: AOJu0YzdbOdhWiHkn4+X9a1hDhOiLy62jh1BF4XHhmNFT6zXvyKJr+q5
	+g77T+UhHOSLYs6IoN4P+SthL5iW91DjJ/UyVPyWD1uGznFEXZD2VpaHB27IfOJYxT7n53vmRzZ
	sDZZZSLJd59J9Ixvl1FBL+IC0OC6X3xkWhYVKm8Q=
X-Gm-Gg: ASbGncvGB1f3SC62Cpixpu25+X3Fo4tZU6VdPVDMBZDBfoFBRZxDzyHOt6jRRCu90Qb
	esqS6yIqu/+M6/Aa+wnnWemoLM42hob284+h/EZ1Pb1VAUZRA45261ACf0V+fEi8O2j3W1Tv/HZ
	L9Qfd30ZgFA+S9WtY2OIesPKt+1Aqc60D2KvvsTSlTtjIk1vF0oqffsGXs7b1832mR8aWWr5Xus
	8oBjefmWNAgFshmE9q0i8+t3kpBx7Fu5FaVkIYCOg==
X-Google-Smtp-Source: AGHT+IEUkPdjrJZCUwcPo5HShA8M0XWoRX+Q4mU6n1PQ0oN8tUWqMg3W+6duvNkeNgkDBRKbbD0t76jMEa9SBI42ark=
X-Received: by 2002:a05:6402:2745:b0:618:1835:24ad with SMTP id
 4fb4d7f45d1cf-61c1b449c05mr19617558a12.3.1756389636305; Thu, 28 Aug 2025
 07:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com> <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
In-Reply-To: <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 28 Aug 2025 10:00:22 -0400
X-Gm-Features: Ac12FXxs7uYsSAwE4HVWzbGZRKR8bXJSgPupqJVR_afQ9gfQInENHYarisIPuJQ
Message-ID: <CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:09=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> - Many users do not understand the terms "index" or "pathspec". Clarify
>   in the intro by using an example, so that users can understand the
>   basic idea without learning the full definition of "pathspec".
> - Use the terminology "Switch" and "Restore" to mirror `git switch`
>   and `git restore`
> - Reference (and clarify) the ARGUMENT DISAMBIGUATION section
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-checkout.adoc | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout=
.adoc
> index 40e02cfd6562..ddda891c0ff7 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -20,10 +20,14 @@ git checkout (-p|--patch) [<tree-ish>] [--] [<pathspe=
c>...]
>
>  DESCRIPTION
>  -----------
> -Updates files in the working tree to match the version in the index
> -or the specified tree.  If no pathspec was given, `git checkout` will
> -also update `HEAD` to set the specified branch as the current
> -branch.
> +`git checkout` has two main modes:
> +
> +1. **Switch branches**, with `git checkout <branch>`
> +2. **Restore a different version of a file**, for example with `git
> +   checkout <commit> <filename>` or `git checkout <filename>`
> +
> +See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
> +Here's a description of all of the modes:

This looks good=E2=80=94I initially scratched my head thinking there were 3
modes, but unifying "update files to match index" and "update files to
match specified tree" is easier to digest in this presentation.

>
>  `git checkout [<branch>]`::
>         To prepare for working on _<branch>_, switch to it by updating
> @@ -511,14 +515,17 @@ $ git log -g -2 HEAD
>  ARGUMENT DISAMBIGUATION
>  -----------------------
>
> -When there is only one argument given and it is not `--` (e.g. `git
> -checkout abc`), and when the argument is both a valid _<tree-ish>_
> -(e.g. a branch `abc` exists) and a valid _<pathspec>_ (e.g. a file
> -or a directory whose name is "abc" exists), Git would usually ask
> -you to disambiguate.  Because checking out a branch is so common an
> -operation, however, `git checkout abc` takes "abc" as a _<tree-ish>_
> -in such a situation.  Use `git checkout -- <pathspec>` if you want
> -to checkout these paths out of the index.
> +When you run `git checkout <something>`, Git tries to guess whether
> +`<something>` is intended to be a branch, a commit, or a set of file(s),
> +and then switches branches, switches commits, or restores the files.
> +
> +If there's a conflict, you can use the double dash `--` to distinguish
> +between branches and files:
> +
> +* `git checkout <branch> --` will force Git to treat the parameter as a
> +  branch name or commit
> +* `git checkout -- <pathspec>` will force Git to treat the parameter as
> +  a set of file(s)

I think we've dropped the bit about the default interpretation of "git
checkout <something>". Maybe

    When you run `git checkout <something>`, Git tries to guess whether
    `<something>` is intended to be a branch, a commit, or a set of file(s)=
,
    and then switches branches, switches commits, or restores the files.

    By default, Git interprets `<something>` as a _<tree-ish>_.
    [explain what choosing a tree-ish means for the user?]

    [Your notes on disambiguation as before]

?

>
>  EXAMPLES
>  --------
> --
> gitgitgadget
>
>


--=20
D. Ben Knoble
