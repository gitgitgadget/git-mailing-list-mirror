Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C16211A3C
	for <git@vger.kernel.org>; Wed, 28 May 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462816; cv=none; b=aJgRt7itaWuip6ZWOJ1iPsFTl76IZR82fWKsVHgr7pkvRlEgF9CvwdLtnExsP+r86BgqyYBNzMxUbCrkp2/8LhTBfxdaSY1jiUFzcyYaWCSVbTuliWfwIskD0ImkyoWAMzPE7BfP26M1j9ypwZzf0c7u37zXfCNuiskdD8XRqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462816; c=relaxed/simple;
	bh=RkDG3cGoPdR5TqC1KNwBaajo4rptX41u9C2bhP01Ewg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Og+hdO0FtYXbaeDxirN7tL/SU2EsXzYA9U3JUzwf2Hr7JxO4cA197p5ZzdkdEh2hRB1SecunEvQK7AA8D4udXIUbXQC5lxVYX3tekCpycxO3po2CFVPqB4XMCAei1v3hdgsqto5peRhEijECOkuVPJq6WMXLxGphD2bTlSpkpjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfFiyY+R; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfFiyY+R"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85df99da233so6751139f.3
        for <git@vger.kernel.org>; Wed, 28 May 2025 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748462814; x=1749067614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOX2oKalPHjqZM33D/IzISdhEWl/GHImaXi/iorLMSg=;
        b=HfFiyY+RRy5lGaIMtU7pi05tw/xQ0QOpabmFzn1SczS981ZMJ/kbQIHjiIyHTc3n30
         r2P3E6OFoWc6yVGGDJTkFc/7uZ4lZSTBcLXmXFV26kHLYp/eJAI6cY5s1AC5sM7CKZJj
         zI3rvqLRp41MB9PwVRZtfdzML0OiAYqZ6lYXcbF1WiOfjHBxYYr6xQd5+46i+mXIh9+d
         Ra96TQGjeoaIGDoSHEwM4XMrad8R4yq3vbQl137RhJdLO98ypMlFArmgcyZkJDqfVfjj
         rzjbsRx3ZP0/zCcUWu9P4yWFbyff2riwUSuXA4/k04vQ5Dl5HOSKomPE6xBmjaaFQm9Q
         EZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748462814; x=1749067614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOX2oKalPHjqZM33D/IzISdhEWl/GHImaXi/iorLMSg=;
        b=Y0Nt1EL7+Elk1ZG3EHQ9g7Ansts7S2Gjl0xrgTdrPIUztpzAfKPb86CsBrD8p9+/V4
         8fg8rtKuOXtJlzXwt4OJr4p+2E69b+p0A30XVMtm/DDMtkMl6pDv4oBNwsoYxWEelVmF
         w7Se0RtFetFKuyYzViLdwJ3QqT0+lTGHPioJpsm6fT3AhUmXuKPmSGrLsMwvaSyTofDJ
         l7vWE9WKyY+c7g80v/tQg23NQgU9CkyHg/1BglgljmFxX6ShZSQ2tawe0DiH6B5vdwZS
         9sQSeQG3tMPIbvQREYTv1Yf/4WoSRc+kKpWPpZhoILJrZVjclmq35klQh+FHdM2lCtZd
         KUWw==
X-Forwarded-Encrypted: i=1; AJvYcCXARY8iRrvITVYJlgYtlayQt3oawFeAy4c7RYvbP0LBBMGoqyedfWlTdoEU2ED8p1CGzYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAcroUrPg3XqYcohSogQLWxXOppjWFHUezqMFN2qHNukoxPgJ
	+orl2e6aUo8t8HvUgky4+WJ68BXcuoKPebtj4PU921jqmbpI/0FdoV3/etfTB+0SVfS+2Yu0Auu
	XQFlfFo+p4YKFMSZfOOLzliJNKfJVemk=
X-Gm-Gg: ASbGnctnBIzW/F2CFR6+OacIITzTcj60Ja70MfFyjlAS9h07I9QNaJ7D+Akg1ND69PJ
	U64UsBEoR5iwr8R59CcNFatAQD60Ol4SoSWd+8aVPYp9N6UTWU2Sj92EknfPthVpiSv+fhXxhFE
	4XjdSZBAY+HmN4gJRzHmZnwzEAQikwwB815yWkEpsNfnvAVCq0DKGOm2PQ6rS/Igj0vQ==
X-Google-Smtp-Source: AGHT+IF8MGU9oYgsiWXD1WDx6/UoncZlMzl1fPUamuFetiVti4B1ubOeYm7fSRxHlX3/6f8bDnGwq8I4hw8pQd7gVO0=
X-Received: by 2002:a05:6602:7211:b0:864:a1e9:f07 with SMTP id
 ca18e2360f4ac-86cbb80a7ecmr2522234739f.8.1748462813781; Wed, 28 May 2025
 13:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <xmqqselxtfyf.fsf@gitster.g> <CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
 <xmqq1pthtbdg.fsf@gitster.g> <CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
 <xmqqzfeyqdye.fsf@gitster.g> <xmqq8qmgsky8.fsf@gitster.g>
In-Reply-To: <xmqq8qmgsky8.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 28 May 2025 13:06:42 -0700
X-Gm-Features: AX0GCFv1EPPknbgj9k4wokq0DV8GGTrmUzP0va-o9HoILLTLpc0QqobtueiaVGg
Message-ID: <CABPp-BGe6r-X7NOiBFEvLGZH+GQvLkOYWn+qf3ZzzgT4sGAyOg@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, Luke Shumaker <lukeshu@datawire.io>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 10:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> I agree that we should have at least said in big letters that the
> >> improved support for signed commits in fast-export/import is very
> >> experimental and very likely to change in the future.
> >>
> >> We could still do so. This could give us a bit of time and flexibility
> >> until we agree on and implement something better and backward
> >> compatible. (Hopefully the v2 will help us move forward.)
> >
> > OK, as the next release is approaching, perhaps we do a bit of
> > documentation update to address that "we are experimenting" and
> > nothing else, and leave the v2 updates for the next cycle?
>
> ---- >8 ----
> Subject: [PATCH] fast-export: --signed-commits is experimental
>
> As the design of signature handling is still being discussed, it is
> likely that the data stream produced by the code in Git 2.50 would
> have to be changed in such a way that is not backward compatible.
>
> Mark the feature as experimental and discourge its use for now.

I think this is a very good thing to do.

minor nit: discourge -> discourage

> Also flip the default on the generation side to "strip"; users of
> existing versions would not have passed --signed-commits=3Dstrip and
> will be broken by this change if the default is made to abort, and
> will be encouraged by the error message to produce data stream with
> future breakage guarantees by passing --signed-commits option.

So...git-filter-repo runs fast-export and has limited flexibility
about which options it passes to fast-export under the hood, so this
change would save me from the patch I was planning to add to
filter-repo.  So that's evidence in support of your statement, but the
"will be broken" statement appears to me to be incongruent with past
deprecations and changes of default that we have gone through.  Often
when we have deprecated or changed an option our process was to first
produce an error and update documentation and wait a while, then go
and change the default after a sufficiently long time.  Here, we had
kind of stopped at just producing the error with no plans to take
another step.  If that was the route we took in the past, what makes
this considered a breakage and not the other changes we made?

(Just curious, I'm not against this change.)

> As we tone down the default behaviour, we no longer need the
> FAST_EXPORT_SIGNED_COMMITS_NOABORT environment variable, which was
> not discoverable enough.

Makes sense.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/RelNotes/2.50.0.adoc |  4 +++-
>  Documentation/git-fast-export.adoc | 12 +++++-------
>  Documentation/git-fast-import.adoc |  3 +++
>  builtin/fast-export.c              |  7 +------
>  t/t9350-fast-export.sh             | 20 ++++----------------
>  5 files changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/=
2.50.0.adoc
> index c6c34d1a1d..9a1cdf0dc0 100644
> --- a/Documentation/RelNotes/2.50.0.adoc
> +++ b/Documentation/RelNotes/2.50.0.adoc
> @@ -100,7 +100,9 @@ Performance, Internal Implementation, Development Sup=
port etc.
>   * "git fsck" becomes more careful when checking the refs.
>
>   * "git fast-export | git fast-import" learns to deal with commit and
> -   tag objects with embedded signatures a bit better.
> +   tag objects with embedded signatures a bit better.  This is highly
> +   experimental and the format of the data stream may change in the
> +   future without compatibility guarantees.
>
>   * The code paths to check whether a refname X is available (by seeing
>     if another ref X/Y exists, etc.) have been optimized.
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-=
export.adoc
> index 413a527496..43bbb4f63c 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -46,14 +46,12 @@ resulting tag will have an invalid signature.
>
>  --signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
>         Specify how to handle signed commits.  Behaves exactly as
> -       '--signed-tags', but for commits.  Default is 'abort'.
> +       '--signed-tags', but for commits.  Default is 'strip', which
> +       is the same as how earlier versions of this command without
> +       this option behaved.
>  +
> -Earlier versions this command that did not have '--signed-commits'
> -behaved as if '--signed-commits=3Dstrip'.  As an escape hatch for users
> -of tools that call 'git fast-export' but do not yet support
> -'--signed-commits', you may set the environment variable
> -'FAST_EXPORT_SIGNED_COMMITS_NOABORT=3D1' in order to change the default
> -from 'abort' to 'warn-strip'.
> +NOTE: This is highly experimental and the format of the data stream may
> +change in the future without compatibility guarantees.
>
>  --tag-of-filtered-object=3D(abort|drop|rewrite)::
>         Specify how to handle tags whose tagged object is filtered out.
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-=
import.adoc
> index 7b107f5e8e..250d866652 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -523,6 +523,9 @@ that signs the commit data.
>  Here <alg> specifies which hashing algorithm is used for this
>  signature, either `sha1` or `sha256`.
>
> +NOTE: This is highly experimental and the format of the data stream may
> +change in the future without compatibility guarantees.
> +
>  `encoding`
>  ^^^^^^^^^^
>  The optional `encoding` command indicates the encoding of the commit
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 37c01d6c6f..fcf6b00d5f 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -39,7 +39,7 @@ enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP,=
 SIGN_WARN_VERBATIM, SIGN
>
>  static int progress;
>  static enum sign_mode signed_tag_mode =3D SIGN_ABORT;
> -static enum sign_mode signed_commit_mode =3D SIGN_ABORT;
> +static enum sign_mode signed_commit_mode =3D SIGN_STRIP;
>  static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } =
tag_of_filtered_mode =3D TAG_FILTERING_ABORT;
>  static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } =
reencode_mode =3D REENCODE_ABORT;
>  static int fake_missing_tagger;
> @@ -1269,7 +1269,6 @@ int cmd_fast_export(int argc,
>                     const char *prefix,
>                     struct repository *repo UNUSED)
>  {
> -       const char *env_signed_commits_noabort;
>         struct rev_info revs;
>         struct commit *commit;
>         char *export_filename =3D NULL,
> @@ -1327,10 +1326,6 @@ int cmd_fast_export(int argc,
>         if (argc =3D=3D 1)
>                 usage_with_options (fast_export_usage, options);
>
> -       env_signed_commits_noabort =3D getenv("FAST_EXPORT_SIGNED_COMMITS=
_NOABORT");
> -       if (env_signed_commits_noabort && *env_signed_commits_noabort)
> -               signed_commit_mode =3D SIGN_WARN_STRIP;
> -
>         /* we handle encodings */
>         git_config(git_default_config, NULL);
>
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index dda9e7c3e7..76619765fc 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -299,22 +299,10 @@ test_expect_success GPG 'set up signed commit' '
>
>  '
>
> -test_expect_success GPG 'signed-commits default' '
> -
> -       sane_unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
> -       test_must_fail git fast-export --reencode=3Dno commit-signing &&
> -
> -       FAST_EXPORT_SIGNED_COMMITS_NOABORT=3D1 git fast-export --reencode=
=3Dno commit-signing >output 2>err &&
> -       ! grep ^gpgsig output &&
> -       grep "^encoding ISO-8859-1" output &&
> -       test -s err &&
> -       sed "s/commit-signing/commit-strip-signing/" output | (
> -               cd new &&
> -               git fast-import &&
> -               STRIPPED=3D$(git rev-parse --verify refs/heads/commit-str=
ip-signing) &&
> -               test $COMMIT_SIGNING !=3D $STRIPPED
> -       )
> -
> +test_expect_success GPG 'signed-commits default is same as strip' '
> +       git fast-export --reencode=3Dno commit-signing >out1 2>err &&
> +       git fast-export --reencode=3Dno --signed-commits=3Dstrip commit-s=
igning >out2 &&
> +       test_cmp out1 out2
>  '
>
>  test_expect_success GPG 'signed-commits=3Dabort' '
> --
> 2.50.0-rc0-134-gb29a910c2a

Looks good to me.
