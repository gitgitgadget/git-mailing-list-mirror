Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A652F88
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383105; cv=none; b=DkdvaxXtrt1u7WsdEAeHSf3YAbik8DQQpZXFJ7q+0/lOH3iMazbCHMoYFIt0bSvmaUtcbhaCsaT8l4fh1xpXD4VN82+3TcHZtiA3K/3RR4MRBQasdr6Ih61zLcKYnAGA0Ekq8Ard0Mbkuh/gWCie7+fCc3TRwn6+SaeTOzrONBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383105; c=relaxed/simple;
	bh=2K6E2I4L3XUoRsxM4aa16QgQaAuuXa6hQyjkgx50SRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSoOOiDr8iYf/YeIpgLOvMTCqmUmw6u4Qvh1ZoJfm3rkiA0x7VC0uHOITk6ti2pOISH6xZfAO3lSy1PxUf4OKMzcd74SWIwi8ehyz9G+egGDGWdpxIPgipU74x6YwuSzkrUqLL6CHo+JC0QSgarjrjGkZ0Ex6hiuuXICXcsyhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBW5EgOR; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBW5EgOR"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d4496a34cdso1803405ab.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 13:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741383102; x=1741987902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Da88ei4Gk8D88/zIbUHY/i+9jdUaVCtTipiSAnDZCT4=;
        b=nBW5EgOR2LVMY4G+gb3NtaQ8PD2MWwTBfsZpldoRoswHxxrNY4E5SXaHEgOEDzP/7T
         24ZuXyXRRSVRSdrQ3SDdTkJQVjwoFt02knbJ1M7atXbqA+BoLj/ZVN2KxBaPKovcpJrv
         SepZr3Wkm3CUR1V/4CqITnd/0h3KpWAEP9953F+xshIDVjCyJENR0g9jvdoRAqji/oE1
         aDV2/0WLdPnmF4S86u+ylcnpDPmE6+hDHc1oxtrVSIs+8Drm+Youxo0tlZTPteTvNIEG
         mCm0jKWmouMyRQH/jvSOZrb5K6q57t7GodRfMDV3bWQ/Fxnhd0vQQxv7cD4caK/NwmGV
         WaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741383102; x=1741987902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Da88ei4Gk8D88/zIbUHY/i+9jdUaVCtTipiSAnDZCT4=;
        b=UrA11M+i1A9j4W0Mirrl55spNNyBSVOEBsv6swhAUR3aGMrImxnwr+WRXS61PTEcus
         NS/pNIvvoj0PFZbakITtqynkIKnBwvZYiEwjR4G8jBDNA0omRIej06ths8tadUw852ao
         VMimWceXqNxQL0dj1/CJHYM4zW0LEkFyCKwQcF+xrUgukIpZRs4bz6YdLTp5oXLijtZP
         1LlOygnE/yQC/7DtWF8iQArEwlOJNRDXUAigS4ohljpOpvXwzneaMc1hIsu9x/cjqz9Q
         YGtldijOlL96ofYol1HUJIiQHvL18tjqt2Xvm1LPEgHeyWaODQ4MtqB0eyP2th9cUqIH
         K5/g==
X-Gm-Message-State: AOJu0YxuRz+SOWB/CbcAkvqi4zKnQb63bu76btR+gn4t8kKoQbO9j8Ii
	crJjg0lBO7uohvu+UWKNeQzrNrWcDSwTH0C6o6i8/vb6kQmxvLfT88KnBfcWNto8HEQYonOvv4o
	f1zT0NUQ1ut6mi65mUrn1DTfoOqY=
X-Gm-Gg: ASbGncvmZ/47Od9YfM+O6z7E1pScUKyQ5Hn50IqK2mfCc6vqClD/A1ZF24kF7NRuVhP
	vt3hTa6m8nGzdcGNKQW4nlBeFGQ+pRH6Da4HRhXlVlnzTMb/ytISA5u5SIeCJnJ9QEgvJQpO8ma
	I/4iJtzdKMPF8RgM9HcvTJrbR/ZGUVSEpLcAGMUTNVyuPtvIoTuDnPjZCRSzY=
X-Google-Smtp-Source: AGHT+IHIwe9flXmNGheMCx/qYRK5i0Ws3CU4NRBmAkoWVq+bSHIBi6aO+YnfiT51yNr/BXYlNL1cwQm3dBrMyb68qQE=
X-Received: by 2002:a92:ca07:0:b0:3d1:9236:ca52 with SMTP id
 e9e14a558f8ab-3d44186fe89mr61576615ab.0.1741383102498; Fri, 07 Mar 2025
 13:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741223981.git.me@ttaylorr.com> <cover.1741275245.git.me@ttaylorr.com>
 <67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
In-Reply-To: <67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Mar 2025 13:31:31 -0800
X-Gm-Features: AQ5f1Jp_GdMmE3iv_ep6J1xbODXE1_Kpmvg2t14KMRqqjNAe9mjSEQyVc6G-t88
Message-ID: <CABPp-BFn0wht71rM1bE1ABpa6Rn6QRrcVrbN0fhcwprbm+T39Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] refs.c: stop matching non-directory prefixes in
 exclude patterns
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, SURA <surak8806@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:34=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote:
>
> In the packed-refs backend, our implementation of '--exclude' (dating
> back to 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
> excluded pattern(s), 2023-07-10)) considers, for example:
>
>     $ git for-each-ref --exclude=3Drefs/heads/ba
>
> to exclude "refs/heads/bar", "refs/heads/baz", and so on.
>
> The files backend, which does not implement '--exclude' (and relies on
> the caller to cull out results that don't match) naturally will
> enumerate "refs/heads/bar" and so on.
>
> So in the above example, 'for-each-ref' will try and see if
> "refs/heads/ba" matches "refs/heads/bar" (since the files backend simply
> enumerated every loose reference), and, realizing that it does not
> match, output the reference as expected. (A caller that did want to
> exclude "refs/heads/bar" and "refs/heads/baz" might instead run "git
> for-each-ref --exclude=3D'refs/heads/ba*'").
>
> This can lead to strange behavior, like seeing a different set of
> references advertised via 'upload-pack' depending on what set of
> references were loose versus packed.
>
> So there is a subtle bug with '--exclude' which is that in the
> packed-refs backend we will consider "refs/heads/bar" to be a pattern
> match against "refs/heads/ba" when we shouldn't. Likewise, the reftable
> backend (which in this case is bug-compatible with the packed backend)
> exhibits the same broken behavior.

Yuck; nice to see this being addressed.

> There are a few ways to fix this. One is to tighten the rules in
> cmp_record_to_refname(), which is used to determine the start/end-points
> of the jump list used by the packed backend. In this new "strict" mode,
> the comparison function would handle the case where we've reached the
> end of the pattern by introducing a new check like so:
>
>     while (1) {
>         if (*r1 =3D=3D '\n')
>             return *r2 ? -1 : 0;
>         if (!*r2)
>             if (strict && *r1 !=3D '/')        /* <- here */
>                 return 1;
>             return start ? 1 : -1;
>         if (*r1 !=3D *r2)
>             return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
>         r1++;
>         r2++;
>     }
>
> (eliding out the rest of cmp_record_to_refname()). Equivalently, we
> could teach refs/packed-backend::populate_excluded_jump_list() to append
> a trailing '/' if one does not already exist, forcing an exclude pattern
> like "refs/heads/ba" to only match "refs/heads/ba/abc" and so forth.
>
> But since the same problem exists in reftable, we can fix both at once
> by performing this pre-processing step one layer up in refs.c at the
> common entrypoint for the two, which is 'refs_ref_iterator_begin()'.
>
> Since that solution is both the simplest and only requires modification
> in one spot, let's normalize exclude patterns so that they end with a
> trailing slash. This causes us to unify the behavior between all three
> backends.

:-)

> There is some minor test fallout in the "overlapping excluded regions"
> test, which happens to use 'refs/ba' as an exclude pattern, and expects
> references under the "refs/heads/bar/*" and "refs/heads/baz/*"
> hierarchies to be excluded from the results.
>
> But that test fallout is expected, because the test was codifying the
> buggy behavior to begin with, and should have never been written that
> way. Split that into its own test (since the range is no longer
> overlapping under the stricter interpretation of --exclude patterns
> presented here). Create a new test which does have overlapping
> regions by using a refs/heads/bar/4/... hierarchy and excluding both
> "refs/heads/bar" and "refs/heads/bar/4".

Always nice to see tests corrected.

> Reported-by: SURA <surak8806@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  refs.c                  |  6 +++++-
>  t/t1419-exclude-refs.sh | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 17d3840aff..2d9a1b51f4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1708,7 +1708,11 @@ struct ref_iterator *refs_ref_iterator_begin(
>                         if (!len)
>                                 continue;
>
> -                       strvec_push(&normalized_exclude_patterns, pattern=
);
> +                       if (pattern[len - 1] =3D=3D '/')
> +                               strvec_push(&normalized_exclude_patterns,=
 pattern);
> +                       else
> +                               strvec_pushf(&normalized_exclude_patterns=
, "%s/",
> +                                            pattern);

Doesn't this mean that if the user requested to exclude
"refs/heads/bar" and "refs/heads/bar" exists, that we won't exclude it
because it doesn't have a trailing slash?

From reading other comments in this thread, I guess that ends up being
okay, because we only promise to filter out what we can cheaply
filter, and we rely on our caller to double-check everything and do
the real filtering.

...but it gives me some ugly dir.c vibes, reminding me of 95c11ecc73f2
(Fix error-prone fill_directory() API; make it only return matches,
2020-04-01) and a slew of related bugs preceding it.  Granted, dir.c
had this tri-state to deal with (tracked, untracked-but-ignored,
untracked-and-not-ignored) and simplifying of whole directories, which
don't apply here, so maybe the similarity of
"fast-filtering-only-and-rely-on-caller" won't be a problem since the
upper level filtering is so much more straightforward.

Should this at least be called out in the commit message, though?

>                 }
>
>                 exclude_patterns =3D normalized_exclude_patterns.v;
> diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
> index fd58260a24..04797aee59 100755
> --- a/t/t1419-exclude-refs.sh
> +++ b/t/t1419-exclude-refs.sh
> @@ -46,6 +46,10 @@ test_expect_success 'setup' '
>                         echo "create refs/heads/$name/$i $base" || return=
 1
>                 done || return 1
>         done >in &&
> +       for i in 5 6 7
> +       do
> +               echo "create refs/heads/bar/4/$i $base" || return 1
> +       done >>in &&
>         echo "delete refs/heads/main" >>in &&
>
>         git update-ref --stdin <in &&
> @@ -99,9 +103,17 @@ test_expect_success 'adjacent, non-overlapping exclud=
ed regions' '
>         esac
>  '
>
> -test_expect_success 'overlapping excluded regions' '
> +test_expect_success 'non-directory excluded regions' '
>         for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >ac=
tual 2>perf &&
> -       for_each_ref refs/heads/foo refs/heads/quux >expect &&
> +       for_each_ref refs/heads/bar refs/heads/foo refs/heads/quux >expec=
t &&
> +
> +       test_cmp expect actual &&
> +       assert_jumps 1 perf
> +'
> +
> +test_expect_success 'overlapping excluded regions' '
> +       for_each_ref__exclude refs/heads refs/heads/bar refs/heads/bar/4 =
>actual 2>perf &&
> +       for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expec=
t &&
>
>         test_cmp expect actual &&
>         assert_jumps 1 perf
> --
> 2.49.0.rc1.2.g67c8c5f7978

Other than the one surprise noted above, looks good to me.
