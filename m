Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BD25BEF8
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408097; cv=none; b=Sg3Vq34I4bWblu0g8Oiaw2EnDCG7hzIyrCgc8UsTm/XTjTekrasVNCEvVfK1NN3SFGzLbnxbBZC8yJ0Z28Q7AkHwPj/PK2uZjTRYsQnL3/3AuXOnx/mUB2+tzn0ThLUkotdHNrV1IMkIdLKQZOCzFD78ZmIX3MELOX/VorbUWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408097; c=relaxed/simple;
	bh=RI3VBJYhegn7VdILnWE+J7NGMOxF9e2ltuAftq+iCws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6qUCl+4erYzbj6ZabB84G+Mh8oMofRIz+ISlm+RZa2bqShs1GKBFZTR0+JsegMCQV6P6ErRjIorQ1o3GSpZbDAXp8zjI2GnmvJuFf8yxAIzIyvPVE9YnLdjXMf1zNKCiXNLbpi4iVBHpzekGwjRaJb4ZHlKJPp6a4W8N91hIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAAptgBL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAAptgBL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso128767166b.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756408094; x=1757012894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVVoM4r0MTO13D/vC1wZY44k50/hDuOzoc5bsEQ8Gvk=;
        b=VAAptgBLOtuqSsQXbeqvqMW5QWTjS7z1Tt7tdCQwu14ps35wxQFqvOzCHq9iw70t2N
         +igkeol+VDqurm/dOLI5lytK2n3aVurp9BdNobh9Vge0Te+GYz8TiWd4QF+JUJOOaS3a
         EOcKvdknnP5055x427H6Y5QABvAKJx7GwoFhE2zbzML0qh3dnm+cB2nakSvU1SSY4SLA
         DgwcB9ZBucYlPsxtvJqA8KM1ZO4T0n0RHxiPZ/peRcsvBcHwyVt3fJoBGuJaG9NcjRRC
         azHkEjBE84wSAB9uydrZChb2WnmiD8ujfM41og2fugXpJBW1voqU/a3rOpyN9xhnWRbn
         Pfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756408094; x=1757012894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVVoM4r0MTO13D/vC1wZY44k50/hDuOzoc5bsEQ8Gvk=;
        b=khchFP4xL+kfWCQl0gwWueaN0g20WypmlgqxSdX8kubGo6WuMKczPQT3SJtmCrXKw4
         /isq+aF0jXov9Oa4c8shtgzpb6t5JgVMdQow2PYDN8ZZyJr55k9VxbvC393jEeFwOl9p
         bGTtxG0iSVp8cteqVfdLe8Wf3XfJs149EMc+wfxyefOI98cMA6g5ftB/TW9Lt/xm3Gqc
         sK4RGc0mfpwnsWm9xJGSedbSEVBmJ8XDKCxWMaZ4erWQruSeQ8EVdM8cA1UiC6VnG6PL
         tOAzhF5r69IaUHHeN4pMD3mmit/V4505qjKxZAOtUhBbJ0QySnF1yy/Guv6MBgD7BAKg
         Rmsg==
X-Gm-Message-State: AOJu0YzYF8nCT019gwsXjdeSqBpZ0EDjM8M+XsIzEraPxAqKKYWRFI8+
	4Im1tD/14TWVhYck64XCtL21TYbW/XoZHW0TfzM+1emkKYQS9gboxa/HIun3sLTMI7sNhdYIi0Z
	moisX2vBqwhB0JibDDeu2hyEdIe6nbTI=
X-Gm-Gg: ASbGnctqWz1tpvxz3jgYZ7HgCQV72c3XUk4kZEXskiC2/nCX0HIm+BsXC7WyXzWc/Gz
	iPv1BozUUudckHhkwHMK9i+hNEZrUZSEQ0fGPRCL9DguyaYxTb5EQy032A6eG36SluejDRL7RZa
	AzHVkrMJxzEl+Bxb3WHGmG34oENZMrbNahmX/yY0KxU4G7WWeLb/ptY4cFQmlpAQD+tmo388FDS
	K0lpoE62b3vGUtFEYTRdf5AyT2VEZOZpUIyDRn/8A==
X-Google-Smtp-Source: AGHT+IEcBfBe4hl3jVChVFedH/AbUika5x8uNUvFVd+y3goCWqThQqwPVP8+d13Zd4RExmbM8nG8D6pUbaE/y/uNKMg=
X-Received: by 2002:a17:907:9281:b0:afe:a83a:87ce with SMTP id
 a640c23a62f3a-afea83a8c21mr1044991766b.2.1756408094062; Thu, 28 Aug 2025
 12:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com> <b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
In-Reply-To: <b641874627b3898831c3965616e936bd4ee310df.1756148933.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 28 Aug 2025 15:08:02 -0400
X-Gm-Features: Ac12FXwsxE3DjM9D8_jU1bUxgpBqn5p_fkKxLo8Kd0ZDga_dGr774QsP28CCPK0
Message-ID: <CALnO6CDpsgTnC95CzjOL5MuhFNAnYYSQCR-jC_n5JYLEu0BTow@mail.gmail.com>
Subject: Re: [PATCH 5/5] doc: git-checkout: clarify restoring files section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:31=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> - Use the term "Restore" to mirror `git restore`
> - Many Git users do not know what a "tree-ish" is. Clarify by using an
>   example of each case, and by saying "commit or tree" in the text
>   instead of "<tree-ish>"

Wishful thinking (see glossary comments): I wish we could teach them
about "tree-ish"s here rather than stop using useful shorthands
altogether. Of course, then we have to wonder where we can use the
shorthand and where we must do the "spell it out (give an
abbreviation)" dance. Hm.

> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout=
.adoc
> index b343d292b30b..9f2b86ac5368 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -82,20 +82,21 @@ Omitting _<branch>_ detaches `HEAD` at the tip of the=
 current branch.
> -The index may contain unmerged entries because of a previous failed merg=
e.
> -By default, if you try to check out such an entry from the index, the
> -checkout operation will fail and nothing will be checked out.
> -Using `-f` will ignore these unmerged entries.  The contents from a
> +If you specify a commit or tree to restore from (for example `git
> +checkout main file.txt`), this will restore the version of the file(s)
> +from that commit or tree. This overwrites the file in the working
> +directory and stages the file's contents.
> ++
> +If you do not specify where to restore from (for example `git checkout
> +file.txt`), this will replace the file(s) with the version from the inde=
x.
> +If you check out a file with an unresolved merge

Possibly a missing paragraph break here?

> +conflict, the checkout operation will fail and no changes will be made.
> +Using `-f` will ignore the merge conflict.  The contents from a
>  specific side of the merge can be checked out of the index by
>  using `--ours` or `--theirs`.  With `-m`, changes made to the working tr=
ee
>  file can be discarded to re-create the original conflicted merge result.
> -
>  `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::

I think I would expect to keep this break, but I might be misreading someth=
ing.

--=20
D. Ben Knoble
