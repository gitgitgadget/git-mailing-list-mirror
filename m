Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC752F88
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383183; cv=none; b=YhBhcKkWVOESutY0CKhW+1dDnM+sP8Ew6dtmrEdbeKJKtFAaVTGskw9N+fUnmRkmJ04ik3obBadCxfkCHR9UCZ9SXoA2O3S12B5UtmNGnAJSPYWaP889Fq5bVsYKFP2tOM3j9n9DSqQklhiG6Ieb+L4yLbu1XUW/xUdUbPyyZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383183; c=relaxed/simple;
	bh=Cixwxt8irrFsdhBQ+t5eEdXGdRxptDjkkfbOUeKkjAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmsWYI8LTez2tCNMuY5AfHpFgd4vEI84Z2FSo5GjrLp0oQgEr6xrjqDZdhXpgwg6maWiqnxl5yCsdzMfN9Be10W+zozc0SQA8CMHErYPyH9+P4mkLiRTA8xrHp92FFqh/pq89Mf64prkCnYbw+OgYfnKbbLCKf/QHeT4y8bT22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy0BgU7S; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy0BgU7S"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so6815335ab.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 13:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741383181; x=1741987981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luGEaD29i2clkVFlupQttlD4RG5VzQyZYaxhE5ubF5g=;
        b=Fy0BgU7Sykk6XBTuaMVkeAbeaOQg5TRrnyVTqw4nTY2JC89iDIhH4faBvdKypjRhk9
         KvS8+kC1pds2EPz7vmsNeNj30wyNtSgkYz7SiqWhQM7LUj+lz3OofyGYgD72WIxAsfMi
         zdnJKvmbp6Vd1t4hxuTipmVaDPJPrHSImp9zCZNRSENgoHAgJrldDaowckEbBikbXSnw
         TKr/sTBnZCIsXvnEwuITvPzT+93SlS1hp6U9Ob2A1Bx8CwwkX2zGz8iR1YMo+7P6S3dY
         YQdxOIKFyFiYusyfBdYGtiQcXguuYs0MCIewuOBA3Vo0Ixf6QFF0EZH8mJyvprriPkop
         qeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741383181; x=1741987981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luGEaD29i2clkVFlupQttlD4RG5VzQyZYaxhE5ubF5g=;
        b=Xngt+lMpm0u2QsquW1dFeS620eaJWuucp4oH0Y4QFhkv2CWYC/EqBBlioQza71axQT
         bdXFNELE3H+8Z2Ly2zFFAEjqwknan+KoCkDO7cthAheN8zX3F/sA7Qh4Vu+i3fpgD75b
         BkJmta6cfv1qbcW4yPnWpJGAZhf4PQo13Hj7C6KqA6O2Fr8rT8sIFSnuXy+4OH00fPlK
         tKp5Wfb1zvncPNPEp4meGsq3H3ZKMm61HzCNdYCIwxVyyFbUpltMuKUy9hFfa+urdV6n
         qVdlPlRxx1tTuzVAJh29TMOzzb1q2kAjmQb1918moRZ4pgOMdIzk/UHw9btlypTd7bJP
         iBQw==
X-Gm-Message-State: AOJu0YwJzuj3yKbDo19GQwVaST1mIPFwo3bjlDfpmeHnlrbf7XOPoUHO
	ysagdLOrh2IiU0MQoEDY+fhmB18u12EmDHIZhmSKbGgYF3Y6Q1o/ABQuh/sxl6psbBfeWYqwYBo
	xgG55Tzm8L7RpEzOkEvBojEq5MaA=
X-Gm-Gg: ASbGnctlSemuWbT2JPp35mpMXWCOw/erik3yi7uOqfjfgn53SQwTiNmiuMXbCZRQTPY
	QiXbN4D8ownwpBmN9EAZ16USaGGmbk40lvXDIQUxCgeApiKp1X08qI6qsJrUaAy02pRwtfj1Je1
	hgxIKFB7y15T7tPb7LUSvO02BBepgCiy431Sna3iiHEANhhOcoQkfKW0KyxRI=
X-Google-Smtp-Source: AGHT+IGNTqxhT/5LNAH5g1UMrXNjLFDxJGBVSCG0Aj5wdfFpmbdyXHAxtIZp2ovS7SuJAau8SoUaTcFT0XxlbSSXvxg=
X-Received: by 2002:a05:6e02:198a:b0:3d3:dcb8:1bf1 with SMTP id
 e9e14a558f8ab-3d4419713a8mr58845705ab.3.1741383180913; Fri, 07 Mar 2025
 13:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741223981.git.me@ttaylorr.com> <cover.1741275245.git.me@ttaylorr.com>
 <c3b5ca597330275391704a0653398ee28f911fc1.1741275245.git.me@ttaylorr.com>
In-Reply-To: <c3b5ca597330275391704a0653398ee28f911fc1.1741275245.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 7 Mar 2025 13:32:49 -0800
X-Gm-Features: AQ5f1JqB6BopaQWpxuWRzNYT9GHdeRWTD1DdJA-pSzrya64cVU9s1k6dbOilzNg
Message-ID: <CABPp-BE3u=YVCU20Bz4jZc90DkmArE=v02WjOzr-uO6kV6Zfng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs.c: remove empty '--exclude' patterns
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, SURA <surak8806@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:34=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote:
>
> In 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
> excluded pattern(s), 2023-07-10), the packed-refs backend learned how to
> construct "jump lists" to avoid enumerating sections of the packed-refs
> file that we know the caller is going to throw out anyway.
>
> This process works by finding the start- and end-points (that is, where
> in the packed-refs file corresponds to the range we're going to ignore)
> for each exclude pattern, then constructing a jump list based on that.
> At enumeration time we'll consult the jump list to skip past everything
> in the range(s) found in the previous step, saving time when excluding a
> large portion of references.
>
> But when there is a --exclude pattern which is just the empty string,
> the behavior is a little funky. When we try and exclude the empty
> string, the matched range covers the entire packed-refs file, meaning
> that we won't output any packed references. But the empty pattern
> doesn't actually match any references to begin with! For example, on my
> copy of git.git I can do:
>
>     $ git for-each-ref '' | wc -l
>     0
>
> So "git for-each-ref --exclude=3D''" shouldn't actually remove anything
> from the output, and ought to be equivalent to "git for-each-ref". But
> it's not, and in fact:
>
>     $ git for-each-ref | wc -l
>     2229
>     $ git for-each-ref --exclude=3D'' | wc -l
>     480
>
> But why does the '--exclude' version output only some of the references
> in the repository? Here's a hint:
>
>     $ find .git/refs -type f | wc -l
>     480
>
> Indeed, because the files backend doesn't implement[^1] the same jump
> list concept as the packed backend we get the correct result for the
> loose references, but none of the packed references.
>
> Since the empty string exclude pattern doesn't match anything, we can
> discard them before the packed-refs backend has a chance to even see it
> (and likewise for reftable, which also implements a similar concept
> since 1869525066 (refs/reftable: wire up support for exclude patterns,
> 2024-09-16)).
>
> This approach (copying only some of the patterns into a strvec at the
> refs.c layer) may seem heavy-handed, but it's setting us up to fix
> another bug in the following commit where the fix will involve modifying
> the incoming patterns.
>
> [^1]: As noted in 59c35fac54. We technically could avoid opening and
>   enumerating the contents of, for e.g., "$GIT_DIR/refs/heads/foo/" if
>   we knew that we were excluding anything under the 'refs/heads/foo'
>   hierarchy. But the --exclude stuff is all best-effort anyway, since
>   the caller is expected to cull out any results that they don't want.
>
> Noticed-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  refs.c                  | 16 ++++++++++++++++
>  t/t1419-exclude-refs.sh | 10 ++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 91da5325d7..17d3840aff 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1699,6 +1699,20 @@ struct ref_iterator *refs_ref_iterator_begin(
>                 enum do_for_each_ref_flags flags)
>  {
>         struct ref_iterator *iter;
> +       struct strvec normalized_exclude_patterns =3D STRVEC_INIT;
> +
> +       if (exclude_patterns) {
> +               for (size_t i =3D 0; exclude_patterns[i]; i++) {
> +                       const char *pattern =3D exclude_patterns[i];
> +                       size_t len =3D strlen(pattern);
> +                       if (!len)
> +                               continue;
> +
> +                       strvec_push(&normalized_exclude_patterns, pattern=
);
> +               }
> +
> +               exclude_patterns =3D normalized_exclude_patterns.v;
> +       }
>
>         if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
>                 static int ref_paranoia =3D -1;
> @@ -1719,6 +1733,8 @@ struct ref_iterator *refs_ref_iterator_begin(
>         if (trim)
>                 iter =3D prefix_ref_iterator_begin(iter, "", trim);
>
> +       strvec_clear(&normalized_exclude_patterns);
> +
>         return iter;
>  }
>
> diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
> index c04eeb7211..fd58260a24 100755
> --- a/t/t1419-exclude-refs.sh
> +++ b/t/t1419-exclude-refs.sh
> @@ -155,4 +155,14 @@ test_expect_success 'meta-characters are discarded' =
'
>         assert_no_jumps perf
>  '
>
> +test_expect_success 'empty string exclude pattern is ignored' '
> +       git update-ref refs/heads/loose $(git rev-parse refs/heads/foo/1)=
 &&
> +
> +       for_each_ref__exclude refs/heads "" >actual 2>perf &&
> +       for_each_ref >expect &&
> +
> +       test_cmp expect actual &&
> +       assert_no_jumps perf
> +'
> +
>  test_done
> --
> 2.49.0.rc1.2.g67c8c5f7978

Makes sense...but doesn't the second patch also fix this issue without
the first patch being needed?
