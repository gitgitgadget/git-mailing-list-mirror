Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988440BF5
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646195; cv=none; b=rU3+eX8pKfUhpie8Op0hnhczgojKUyL8uC4qOgcFyzVAaSoOE2UC70SSt8YRZJ0Ie4IkrsNadNXNqC67C+2CAXRV18u90+Gq4xRQObqP8zK/5dUBROaH3r21yL4YY37cg1pIicUAf/4NDmsCV5nhUoC2r5edgjIAwDAxAnsJMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646195; c=relaxed/simple;
	bh=lp1ArBCSS2Ml4Cainnsit6SMb4cm9PTqgG1XEut0ylQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN08dOw7UD8P42qPwIJ17I8URv9kZLcmdoV8zZctmI9G7Mx3K+gIy4MAzIqYGWKuOPKHPzHw1qu1/xyTLGwABciVj2ImglhRQIZVNQ2rzYHeWcUU9bW8pYSf9gScPlPpfHoLqWj8TCcckHf+O7WDS2AZDZU8CLnuWSqBAkvslm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J45IS0DU; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J45IS0DU"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d45875d440so8004185ab.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741646193; x=1742250993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA2gQcidSWuyj2PBuxNlwkuIzelaMZXUbnP7ZSSCH98=;
        b=J45IS0DULv1bgECYw36Kh4RWgacLJopZQ7Ka7ICMsgZl4seqpP83OqkOB9vng/dj3+
         k/a0MEHtY/5VYhjZjz+5nPLhSlV4PpRnpCo12+piLyjeYceWmMX7/iqKrOxDtgVKV/Wi
         vyFZeCIeUImIXjLw34H0HUpJzaZSc0MJJAc+TTdly2xffUfR+wQ3ujYkolI1H+zICkie
         2i5zVtNkDkYzM8WpKPwFzpldCB9t/SnsqgZA0n3nDsgf0FDgHaLxmi+SMam7vF2W+oxW
         5tRPP49+DBahZnbN4RgGy1tCH34lpoMtVHOIcv9ErTfX9zR6P7zX+0YRNpNR7HlaqT5o
         kNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646193; x=1742250993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA2gQcidSWuyj2PBuxNlwkuIzelaMZXUbnP7ZSSCH98=;
        b=lET4i5r8MBVqLDtTtD9dGNh9j1kY7712ogXiQmW9S13kYR5LdnCbu4qf1tvha0752V
         dYWAUY8V8Zq2XTqF2fUXJ2wKJ8kku97Fj1hEkOt4OYHSttGsSjuNXtMjc3Rao4m8ftyv
         0aSqITtxIViSFYgmi1JGnJnnYBYPNRjPIMuNTmd+ZY4gkMFeFWw+l9/NNoyinYCPojdl
         czD8DjDGlHuyeOk9bf8lZjQr3tJD7rZf8rzPePwmLkIgaZyeFQqbDWft5UqTZARpyQw1
         sKxwMX2Q7eCqW+RVbHjxGW9fAGtqf9mXlxRuhndQmAiK8WugTlXfyTbeBQ0AhMUGfYXa
         1Cvg==
X-Gm-Message-State: AOJu0YzxLvUOkypZfO9n/7wtvavyGg5dx1ipHq73SasdSp8LU26Glbp4
	0orXN5fWAc3iirehH5EmEu7NZnzqJHNVvW56M8R6NixGXxfMWuWU9tDHSptAS/oEjlQuMwUgZBT
	IJss6YJ9vXBSClwSaAVHZjjN+6wI=
X-Gm-Gg: ASbGncsBbFzS452Ra5ikhfsG3ODQGSI+LxzFq0wui5D0n9fsnBHWEWNMpC+RHqnEDhG
	8jfl/47Mlp9zklewIJDQFfygmpo/OkojchLmMclSxCh8Nb6ZHeERAEpjKiXm7z0tEXyFL3oaVVe
	D82NQJQKD1JOcscgWx+whTFnY1w0YgzA26JNw/BmcdBgUKspS1KB4QSO3tyWc=
X-Google-Smtp-Source: AGHT+IG96Ltx9Ihj/VGDjbT+Chl5EBRiwG8S1AC2NJhpt9DtWvv9Pmhw4ZaxWwmye6ytu9JueMitzsl3pk7+5/Byc2A=
X-Received: by 2002:a05:6602:3713:b0:85b:435d:2fcd with SMTP id
 ca18e2360f4ac-85b435d45e9mr937879539f.8.1741646192689; Mon, 10 Mar 2025
 15:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224142744.279643-1-christian.couder@gmail.com> <20250310155746.879481-1-christian.couder@gmail.com>
In-Reply-To: <20250310155746.879481-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 10 Mar 2025 15:36:21 -0700
X-Gm-Features: AQ5f1Jr8W5MQ24eL0-JgLMqdH4JJsFIOIF7gqd6aNv9if2_HqT66mGAI65qrpyM
Message-ID: <CABPp-BGyA8iBA0BFO8FcpZAMca94aVu2vHHRi4Oz=nCWxJSDPg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] fast-export, fast-import: add support for signed-commits
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, Mar 10, 2025 at 8:58=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Luke Shumaker sent the first 4 versions of this series in April 2021,
> but it looks like he stopped before it got merged. Let's finish
> polishing it.
>
> Goal of this series
> ~~~~~~~~~~~~~~~~~~~
>
> fast-export has an existing --signed-tags=3D option that controls how to
> handle tag signatures.  However, there is no equivalent for commit
> signatures; it just silently strips the signature out of the commit
> (analogously to --signed-tags=3Dstrip).
>
> So implement a --signed-commits=3D flag in fast-export, and implement
> the receiving side of it in fast-import.
>
> Big picture goal
> ~~~~~~~~~~~~~~~~
>
> Independent from these --signed-tags/--signed-commits options
> addressed in this series, we want to have an option, that allows the
> person who performed the import to attest to the result by adding
> their own signature on tags and commits, whether these tags and
> commits were originally signed or not.
>
> This series lays the groundwork for that future option by upstreaming
> the earlier effort started by Luke Shumaker and stops there. Future
> follow-up work will build on it towards the big picture goal.
>
> Overview of the changes since v5
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> There is no real code change since v5, only a commit message, the
> documentation and some code comments are improved.
>
> Details of the changes since v5
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   - Rebased on top of current 'master' branch at a36e024e98 (Merge
>     branch 'js/win-2.49-build-fixes', 2025-03-06). This is to get a
>     base as close as possible to v2.49.0 final.
>
>   - In patch 4/6 the commit message subject started with
>     "git-fast-export.txt:" instead of "git-fast-export.adoc" which has
>     been fixed.
>
>   - In patch 4/6 the documentation for `--signed-tags` in
>     "Documentation/git-fast-export.adoc" is improved to better explain
>     when it makes sense to use 'verbatim' and 'warn-verbatim', thanks
>     to Elijah.
>
>   - In patch 6/6 the documentation for `--signed-commits` in
>     "Documentation/git-fast-export.adoc" now spells out that its
>     default is 'abort', thanks to Elijah.
>
>   - In patch 6/6 a code comment in front of
>     find_commit_multiline_header() in "builtin/fast-export.c" has been
>     improved:
>
>       - a "rathar" vs "rather" typo has been fixed, thanks to Elijah,
>
>       - what should be done to the memory returned by the function has
>         been corrected, thanks to Phillip Wood.
>
> CI tests
> ~~~~~~~~
>
> All the CI tests passed, except perhaps the osx-gcc one which isn't
> finished yet, see:
>
> https://github.com/chriscool/git/actions/runs/13767984505
>
> Range diff compared to version 5
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> 1:  f97247e17d =3D 1:  395dc9b1d9 git-fast-import.adoc: add missing LF in=
 the BNF
> 2:  b71588563d =3D 2:  6265fd51aa fast-export: fix missing whitespace aft=
er switch
> 3:  947bc267e6 =3D 3:  9e290bab22 fast-export: rename --signed-tags=3D'wa=
rn' to 'warn-verbatim'
> 4:  45087db345 ! 4:  923885134f git-fast-export.txt: clarify why 'verbati=
m' may not be a good idea
>     @@ Metadata
>      Author: Luke Shumaker <lukeshu@datawire.io>
>
>       ## Commit message ##
>     -    git-fast-export.txt: clarify why 'verbatim' may not be a good id=
ea
>     +    git-fast-export.adoc: clarify why 'verbatim' may not be a good i=
dea
>
>          Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
>          Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>     @@ Documentation/git-fast-export.adoc: OPTIONS
>       exported and with 'warn-verbatim' (or 'warn', a deprecated synonym)=
,
>      -they will be exported, but you will see a warning.
>      +they will be exported, but you will see a warning.  'verbatim' and
>     -+'warn-verbatim' should only be used if you know that no
>     -+transformation affecting tags will be performed, or if you do not
>     -+care that the resulting tag will have an invalid signature.
>     ++'warn-verbatim' should only be used if you know that no transformat=
ion
>     ++affecting tags or any commit in their history will be performed by =
you
>     ++or by fast-export or fast-import, or if you do not care that the
>     ++resulting tag will have an invalid signature.
>
>       --tag-of-filtered-object=3D(abort|drop|rewrite)::
>         Specify how to handle tags whose tagged object is filtered out.
> 5:  20f085a790 =3D 5:  49f73ee6ef fast-export: do not modify memory from =
get_commit_buffer
> 6:  48e0d4203c ! 6:  542c692e67 fast-export, fast-import: add support for=
 signed-commits
>     @@ Commit message
>          Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
>       ## Documentation/git-fast-export.adoc ##
>     -@@ Documentation/git-fast-export.adoc: they will be exported, but yo=
u will see a warning.  'verbatim' and
>     - transformation affecting tags will be performed, or if you do not
>     - care that the resulting tag will have an invalid signature.
>     +@@ Documentation/git-fast-export.adoc: affecting tags or any commit =
in their history will be performed by you
>     + or by fast-export or fast-import, or if you do not care that the
>     + resulting tag will have an invalid signature.
>
>      +--signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort):=
:
>      +  Specify how to handle signed commits.  Behaves exactly as
>     -+  '--signed-tags', but for commits.
>     ++  '--signed-tags', but for commits.  Default is 'abort'.
>      ++
>      +Earlier versions this command that did not have '--signed-commits'
>      +behaved as if '--signed-commits=3Dstrip'.  As an escape hatch for u=
sers
>     @@ builtin/fast-export.c: static void anonymize_ident_line(const char=
 **beg, const
>
>      +/*
>      + * find_commit_multiline_header is similar to find_commit_header,
>     -+ * except that it handles multi-line headers, rathar than simply
>     ++ * except that it handles multi-line headers, rather than simply
>      + * returning the first line of the header.
>      + *
>      + * The returned string has had the ' ' line continuation markers
>     -+ * removed, and points to statically allocated memory (not to memor=
y
>     -+ * within 'msg'), so it is only valid until the next call to
>     -+ * find_commit_multiline_header.
>     ++ * removed, and points to allocated memory that must be free()d (no=
t
>     ++ * to memory within 'msg').
>      + *
>      + * If the header is found, then *end is set to point at the '\n' in
>      + * msg that immediately follows the header value.

I didn't look closely at Phillip's comments or your changes related to
those, but the other changes in the range-diff address my comments
from v5, so this version looks good to me.

Thanks!
