Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F04EB5E
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726342587; cv=none; b=MRFUCtS3NTwdrYbLtjveSRWh8k8wvDwQ1cjflrfgAmjk5tpkMUAqbA0C1ANuVYphDw6cHZdmksp2vvDVs3+juanchTye1PJ65O7V5GvHSB21DcY5sTiNKFOpzujaBu5eAOp8hMkXcZ6mopFYaHhwjpi8NiAnAYCrdx6tmj6ntdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726342587; c=relaxed/simple;
	bh=4IlGaZGbKdyI6GfXniLl4oP2CTWNKs4ngrhTdnpRv6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JW9QJdiZg1J3IpoOfpSPPPGKcOyr3B+zSoeTtuPVdmNUeoA5mrXDaXZPF2uzX3n7Ac/ti5VY5WDm1u3NKhWpUJ6U/69X5Er10UlGwmSjQL3hYA+pqeEIY9NaBdNeUGwAosQX/Wv1MNxGf1NevTMBlTMLIQQqVdwlMGttlfzB+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyqWMdb9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyqWMdb9"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so2651476a91.3
        for <git@vger.kernel.org>; Sat, 14 Sep 2024 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726342585; x=1726947385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FZ4dVpELD/35RAPlX3bzn9kDrb9jh7BkB7k1S3G1PY=;
        b=HyqWMdb9J9A8dwdafw0pnNw5ZPtK9tigrCQpt7do+6jzoUSbt0wmcMqZA1gbkJfi48
         EutUBd+phUsq0RO/OOoeOoQLQ+rAAdwNYAHcvzYFrJ3EdjKG9zB/QstVZa7z8kjET8B2
         YlXnppINOT2OLl90BUfKdbCLtHEAfNXvIzXBYH9Z9vnVsgXj3cutb66iMZF7Qr4MJBTg
         G6S/4YcmSZHMK54XOdCxMOkJq8Uwhq3rTGbU1MWDVxCKiscnTPBKvicYqYUC9Q4yd3mu
         9QbdLXzCCTIEPwo7r6JPu+PnVGbN5fTNRsmNFK4TRQTfSdrWifhH+Qu6zmCjoqXRyWfx
         siKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726342585; x=1726947385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FZ4dVpELD/35RAPlX3bzn9kDrb9jh7BkB7k1S3G1PY=;
        b=ss/Nt/cpDbWGqJX380O/JA4YbOrXlhc+0yX56ebY0dHDZdJZTGtE1p6pl4xsflAHOf
         4wPZaA429kSWG59m9nqKxH4dDZ2m3sA8hCznAesCYZ3vd4YiWnK4HlGjzkU2YRpIaPaj
         jQoMUbYqbFJlP9+pnPoRFR27uF80/yxrUbfzWH6t+QB76lwNR4WlGX8ZF33fmw7z/AfO
         DKR5cYhf9q/zNNWmX30OoWQ9JkfC5GoS1yHRSlqwU75PgRX9dGNy4pC9T11y1nvgkL8t
         gxtOfu4JChoBVkne/JBsVePk7Dn7J16XIdwVn9JsNQkznWwKe0pkO8bo8M18BcGCOsOI
         /dxA==
X-Forwarded-Encrypted: i=1; AJvYcCVAdKNc7ytvF5ivamPE8atUHOuZBOLMNrZ+ow8grCdH5isrVSrfuMcAjKnMhIqIN62eibM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41BsuSG2wWVFekAo4XpDWwhZQsygjQLhplCdjPv6D/+8u4RYr
	3sl3kxNWJgDnGr5ioAbiMaoSThowXHYyTdeSTffIDcZceL2+xg/NtEuYB3U7mXdUsSn2NCWeJi/
	mWRL1r0flTSKQRydm3etQWHb8TgI=
X-Google-Smtp-Source: AGHT+IHhP74MQqXKkDJjR6RpeO7xVGh9MhFnYkFDKQ+4hc5iGQ+pncy9433XVLQMUH9mopCJgTMI7+7msYCr13qn0bc=
X-Received: by 2002:a17:90a:2dc6:b0:2c9:9f50:3f9d with SMTP id
 98e67ed59e1d1-2db9ffa11abmr12411797a91.5.1726342585086; Sat, 14 Sep 2024
 12:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
 <xmqqzfogsrqo.fsf@gitster.g> <CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
 <xmqq5xr4r818.fsf@gitster.g> <CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
 <xmqqplp7ze0h.fsf@gitster.g>
In-Reply-To: <xmqqplp7ze0h.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Sun, 15 Sep 2024 01:05:48 +0530
Message-ID: <CAG=Um+2e7kSL8wGFJcJtFAJt8AxyNwpemJNnxDNfsrm1SVVw1Q@mail.gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, "Derrick Stolee [ ]" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 10:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>
> > Ideally, a repository should be able to specify (say):
> >
> > remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
> > remote.origin.prefetchref=3Drefs/heads/main
> >
> > This configuration would maintain the normal behavior for fetches, but
> > only prefetch the main branch.
> > The rationale for this is that the main branch typically serves as the
> > HEAD from which future branches will be forked in an active
> > repository.
>
> Oh, that is 100% agreeable.  All I wanted to caution you about was
> what should happen when remote.origin.prefetchref in the above is
> replaced to something like:
>
>     [remote "origin"]
>         fetch =3D +refs/heads/*:refs/remotes/origin/*
>         prefetchref =3D refs/notes/*
>
> That is, if your refspec used for your real fetch (i.e. "git fetch"
> without the "--prefetch" option) does not fetch anything from
> "refs/notes/" hierarchy, prefetching from the hierarchy does not
> help the real fetch.  I do not have a strong preference between
> marking it as an error and silently ignoring the prefetch but
> leaning towards the latter, and that is why my suggestion to
> implement this new "prefetchref" as something that extends the
> existing filter_prefetch_refspec(), which already filters out
> refspec that fetches from the refs/tags/ namespace (and the ones
> that do not store by having NULL in the .dst side).
>
> > Regarding:
> >
> >> If prefetch_refs contains only positive patterns, then a refspec whose=
 source
> >> doesn't match any of these patterns is rejected.
> >
> > Simply rejecting a source refspec pattern in `remote.<remote>.fetch`
> > wouldn't achieve our goal here.
>
> I used the verb "reject" to mean "filter out", just like a refspec
> with left-hand-side that begins with "refs/tags/" is filtered out
> in the current filter_prefetch_refspec().  And that is exactly what
> we want to achieve our goal here.
>
> IOW, you would
>
>  * read their ref advertisement, and pick only the ones that have a
>    matching pattern in the left-hand-side of a remote.$name.fetch
>    element.  With a more recent protocol, remote.$name.fetch may
>    have already participated in narrowing what they advertise to
>    begin with, but the end result is the same.
>
>  * give it to filter_prefetch_refspec().
>
>  * filter_prefetch_refspec() inspects the refspec elements, and
>    rejects ones with no right-hand-side, and ones with
>    left-hand-side that begin with refs/tags/.  The current code
>    without your patch already works this way up to this point.
>
>  * We extend the above filtering so that in addition to the two
>    kinds we currently reject, reject the ones that do not match the
>    prefetchref criteria.  This is what is needed to implement
>    "prefetchref configuration limits the set of refs that get
>    prefetched".
>
> And what you quoted is a beginning of how "prefetchref configuration
> limits".  It cannot be "add to what filter_prefetch_refspec() did",
> like done by the implementation in the patch we are discussing.
>
> If your configuration were this:
>
>     [remote "origin"]
>         fetch =3D +refs/heads/*:refs/remotes/origin/*
>
> you would want a way to say things like
>
>  (1) I want to prefetch everything I usually fetch
>
>  (2) Among the ones I usually fetch, I only want to prefetch master
>      and next branches.
>
>  (3) I want to prefetch only refs/heads/jk/* branches, but not
>      refs/heads/jk/wip/* branches.
>
>  (4) I want to prefetch everything I usually fetch, except for
>      refs/heads/wip/* branches.
>
> The case (1) is the simplest.  You will leave .prefetchref empty.
>
> For the case (2), you would write something like
>
>     [remote "origin"]
>         prefetchref =3D refs/heads/master
>         prefetchref =3D refs/heads/next
>
> So, when your prefetchref has all positive patterns, after the
> existing conditional in filter_prefetch_refspec() passes a refspec
> whose right-hand-side (i.e., .dst) is not NULL and whose
> left-hand-side (i.e., .src) does not begin with "refs/tags/", you
> further inspect and make sure it matches one of these prefetchref
> patterns.  In example (2), if they advertised master, next, and seen
> branches, refs/heads/seen would be filtered out because it matches
> neither of the two patterns, so we would end up prefetching master
> and next branches.
>
> For the case (3), you would want to say something like
>
>     [remote "origin"]
>         prefetchref =3D refs/heads/jk/*
>         prefetchref =3D !refs/heads/jk/wip/*
>
> Now your prefetchref has some negative pattern.  When filtering what
> the existing conditional in filter_prefetch_refspec() passed, you'd
> inspect the refspec element and see if it matches any of the
> positive patterns, and also if it does not match any of the negative
> ones.  refs/heads/next does not match any positive ones and gets
> rejected.  refs/heads/jk/main does match the positive pattern
> 'refs/heads/jk/*', and it does not match the negative pattern
> 'refs/heads/jk/wip/*', so it passes and will get prefetched.
>
> For the case (4), you would write something like
>
>     [remote "origin"]
>         prefetchref =3D !refs/heads/wip/*
>
> There is no positive pattern, so if you blindly apply the rule you
> used for (3) above, everything will get rejected, which is not what
> you want.  refs/heads/main does not match any positive patterns
> (because there are no positive patterns given), but it does not
> match any negative ones, so it passes and will get prefetched.
>
> The condition to implement the above four cases (which I think
> covers all the cases we care about, but I won't guarantee it is
> exhaustive---you'd need to sanity check) would be
>
>  - If there is 1 or more positive prefetchref patterns, the refspec
>    element must match one of them to be considered for the next
>    rule.  Otherwise, it will not be prefetched.
>
>  - If the refspec element matches any of negative prefetchref
>    patterns, it will not be prefetched.
>

If we're trying to determine if a pattern
(remote.<remote>.prefetchref) is a subset of another or not
(remote.<remote>.fetch) (to not accidentally expand the scope beyond
`fetch`),
we'd need a function that does that pattern-to-pattern. Are you aware
of any existing functions that do so?

I see `wildmatch`, but that is only used for pattern to full-text compariso=
ns.
