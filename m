Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2174400
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406516; cv=none; b=KK9GU1PVwzLCniDrnARApJa2g3+ZW/RBZ7CsQgHxA673qBbJX1F0kxviIsq8swFe0H4nB7MWakz9rS0i1D5k4bV4WLBT39H71GytYmIhSd1/tms6PETYVrZwq/WqUbPpNE4q8L2bHikwhfgDEZ+1l4Y4OMYxEmn/7i2DkYQcYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406516; c=relaxed/simple;
	bh=9HI+ohWGGv/LMvFS4js2xuQ2NZsmrjEVClKCPuA6pyM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1zVLjnTE12/TddriZ3+qi0eZmhYZ9Nep5331tI5DZWD1EOBd+9YkA5kH9sea+sJio2sXwgh+b3EGUapkCEsVIZi/Pcx+ga27w7MvO7ilbjfq1dz4UO4q+Ipq5X78JtJkqjybZPt9GWwlm4XZZtD/P/k/fHp5eT2/ZilgbMdH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtDDDF2F; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtDDDF2F"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c862c613fcso1232050b6e.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406513; x=1715011313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ieBxP1rDfydFcrQrh4IMYzgakV8K+qm8DP6okHA3UBs=;
        b=LtDDDF2FlK8yQNnHqsdVViIFaAuDLBMxF0Mm0B8TtgRQJRafSTncN+2J69I6fewAKC
         ay6b7gLCg38p6t/8epkpOruhLV4+PDpWWOL/k+QEn4OV3pIGTgrbZzwBsxz/IQWYq4RW
         ZoJwdonwhet5yJwRVvKqOLNZDqI2rWHagQuXNwtoBe138+yjrr1r+PTPJb2arZUOTrvk
         oqaCvqnubmoi2SKDs9cVOnk5yxdz76XJ6yTAdJsL7BnnDD3FqdkC2gbX1MFZ0dpbYH/8
         v0w9/Pqav1YtXWCZNmb5d98qoEqIZzP6fon+1LDmJwG8KQ76uhWrZBq63053nq4uOto+
         IR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406513; x=1715011313;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieBxP1rDfydFcrQrh4IMYzgakV8K+qm8DP6okHA3UBs=;
        b=iWEgcFVOnFFTgAGB5SDQRqmlONkrwB5HiLQp48bdrKWPlKfnpdRNqFf1flnLaorKyv
         mk3HH/YS2d3FlVLZa8UK5EofPNNbFWZQBbWXdMUxrDouHmR/OsQNcXlm+2KahxenQ6OL
         0tCzZc9SnT0gychpcrGNUMAmc2wi/rELH92pXh9HDzKxW45byTWTdI6o+nsfFlBMF90G
         26xVOKiqBd4IREthulhmXyBOYyOvLnNeOXFVyzal8A+fBL1qKi5rfP2GmJAmAJ9/oHHo
         tqGY/At4z/ZCaaubcfLC0f3qarOfX72Vp7WKbP9kV4lAslDTEpTlRdQgTey96RLiiEhQ
         HTyg==
X-Forwarded-Encrypted: i=1; AJvYcCXNybDnWDAqSWJTndzI4anGtRmvAQiptQD4kQlVs8oqVms7zKDs2uZlnAr3F9DhtfuTHvlx9i81KdjV8pPE6cA458A1
X-Gm-Message-State: AOJu0Yx6iwxsN9AFa6SMrBo2ScQGbiHpwej3WggGPU0uQGv+m0IYiYpb
	DHWvnqdhRUHh/a7y40XSH0HQCV4hjDSjrJGC8JeXZlVg+Az/A1FMDZV5fdSuuwKGmCmvLwTeIr4
	kU2+/CTB2kRiE8vFxurtRMI8Jv+E=
X-Google-Smtp-Source: AGHT+IEYoTUN3x1mRTXF385KVeL5GLGfytuqi19FxLLAxWHaYkKubaT4y5mBKKOvCJaRN+gtQc7PZebnmQV8gYIUBrg=
X-Received: by 2002:a05:6871:7402:b0:22a:508a:66e6 with SMTP id
 nw2-20020a056871740200b0022a508a66e6mr13820311oac.17.1714406513483; Mon, 29
 Apr 2024 09:01:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 09:01:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240429083325.GE233423@coredump.intra.peff.net>
References: <20240429083325.GE233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Apr 2024 09:01:52 -0700
Message-ID: <CAOLa=ZR+nunNg8_LMTzwoHzbBU2EboMSsZRodswLP9bMLhtCpg@mail.gmail.com>
Subject: Re: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000003cd11406173e5f4b"

--0000000000003cd11406173e5f4b
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> Before operating on a refname we get from a user, we usually check that
> it's syntactically valid. As a general rule, refs should be in the
> "refs/" namespace, the exception being HEAD and pseudorefs like
> FETCH_HEAD, etc. Those pseudorefs should consist only of all-caps and
> dash. But the syntactic rules are not enforced by check_refname_format().

Nit: s/dash/underscore

Also FETCH_HEAD is a special_ref, this confusion should however be
resolved with Patrick's patches [1].

> So for example we will happily operate on a ref "foo/bar" that will use
> the file ".git/foo/bar" under the hood (when using the files backend, of
> course).
>
> Making things even more complicated, refname_is_safe() does enforce
> these syntax restrictions! When that function was added in 2014, we
> would have refused to work with such refs entirely. But we stopped being
> so picky in 03afcbee9b (read_packed_refs: avoid double-checking sane
> refs, 2015-04-16). That rationale there is that check_refname_format()
> is supposed to contain a superset of the checks of refname_is_safe().
> The idea being that we usually would rely on the more-strict
> check_refname_format(), but for certain operations (e.g., deleting a
> ref) we want to allow invalid names as long as they are not unsafe
> (e.g., not escaping the on-disk "refs/" hierarchy).
>
> But the pseudoref handling flips this logic; check_refname_format() is
> more lenient than refname_is_safe(). So you can create "foo/bar" and
> read it, but you cannot delete it:
>
>   $ git update-ref foo/bar HEAD
>   $ git rev-parse foo/bar
>   747a29934757b7e695781e13e2511c43b951da2
>   $ git update-ref -d foo/bar
>   error: refusing to update ref with bad name 'foo/bar'
>
> So we probably want check_ref_format() to learn the same syntactic
> restrictions that refname_is_safe() uses (namely insisting that anything
> outside of "refs/" matches the pseudoref syntax). The most obvious way
> to do that is simply to call refname_is_safe(). But the point of
> 03afcbee9b is that doing so is expensive. Without the syntactic
> restrictions of check_refname_format(), refname_is_safe() has to
> actually normalize the pathname to make sure it does not escape "refs/".
> That's redundant for us in check_refname_format(); we just need to make
> sure it either starts with "refs/" or is a pseudoref.
>
> But wait, it gets more complicated! We also allow "worktrees/foo/$X"
> and "main-worktree/$X". In that case we should only be checking "$X"
> (which should be either a pseudoref or start with "refs/"). We can
> use parse_worktree_ref(), which fairly efficiently gives us the "bare"
> refname (even for a non-worktree ref, where it returns the original
> name).
>
> And now when should this new logic kick in? Unfortunately we can't just
> do it all the time, because many callers pass in partial ref components.
> E.g., if they are thinking about making "refs/heads/foo", they'll pass
> us "foo". This is usually accompanied by the ALLOW_ONELEVEL flag. But we
> likewise can't take the absence of ALLOW_ONELEVEL as a hint that the
> name is fully qualified, because that flag is also used to indicate that
> pseudorefs should be allowed!
>
> We need a new flag to tell these two situations apart. So let's add a
> FULLY_QUALIFIED flag that callers can use to ask us to enforce these
> syntactic rules. There are no callers yet, but we should be able to
> examine users of ALLOW_ONELEVEL, figure out which semantics they
> wanted, and convert as needed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The whole ALLOW_ONELEVEL thing is a long-standing confusion, and
> unfortunately has made it into the hands of users via "git
> check-ref-format --allow-onelevel". So I think it is there to stay.
> Possibly we should expose this new feature as --fully-qualified or
> similar.
>
>  refs.c | 14 +++++++++++++-
>  refs.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 8cac7e7e59..44b4419050 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -288,6 +288,15 @@ static int check_or_sanitize_refname(const char *refname, int flags,
>  {
>  	int component_len, component_count = 0;
>
> +	if ((flags & REFNAME_FULLY_QUALIFIED)) {
> +		const char *bare_ref;
> +
> +		parse_worktree_ref(refname, NULL, NULL, &bare_ref);
> +		if (!starts_with(bare_ref, "refs/") &&
> +		    !is_pseudoref_syntax(bare_ref))
> +			return -1;
> +	}
> +
>  	if (!strcmp(refname, "@")) {
>  		/* Refname is a single character '@'. */
>  		if (sanitized)
> @@ -322,8 +331,11 @@ static int check_or_sanitize_refname(const char *refname, int flags,
>  		else
>  			return -1;
>  	}
> -	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
> +
> +	if (!(flags & (REFNAME_ALLOW_ONELEVEL | REFNAME_FULLY_QUALIFIED)) &&
> +	    component_count < 2)
>  		return -1; /* Refname has only one component. */
> +
>  	return 0;
>  }
>
> diff --git a/refs.h b/refs.h
> index d278775e08..cdd859c8b7 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -571,6 +571,7 @@ int for_each_reflog(each_reflog_fn fn, void *cb_data);
>
>  #define REFNAME_ALLOW_ONELEVEL 1
>  #define REFNAME_REFSPEC_PATTERN 2
> +#define REFNAME_FULLY_QUALIFIED 4
>
>  /*
>   * Return 0 iff refname has the correct format for a refname according
> --
> 2.45.0.rc1.416.gbe2a76c799

[1]: https://lore.kernel.org/r/cover.1714398019.git.ps@pks.im

--0000000000003cd11406173e5f4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: eed75f27a23b160a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdnhHOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNk5kREFDY2wzMUt6dDFGbTNxUEFPemlmc1p1SlI5awpBN1Ixb1ZENkgy
U0JSb0M4WmNmTlFaK21QSXl3UHJ4d1pJV2k0QU1BeUZxeW1TOUNVYUdFMEdYWFlNbnpjcnUxCmZa
SnQ3THVlMWFuemMycDVyN2F4ZGkzVUE2NlhYWkVxRUgrQUVHbGp3UkxNQ3NCZVF0RUc5TTlOS21z
d01xaUQKS0xmTDFWR1BkNzFUZG41WTBXVWdmbnVKU08zQTFEZVk2Tk9xR05HQ2tMUHcxVnF4SCtP
c1R6QklKbFYxalNWYgp3QmJtR013THlDTE9ZUjVVbG1ERWlwL3cxcXFLMDdwZ1BZL0tTcGJickxj
emcxZDhzL1J4SGkzZTZFWHZyVy9BCjUzZkJYTGJ4ODZ5M0Q4N0h0Q3NhUjBYcVYwYy9INUNJK3Rh
OHRtVVk4ZW02aWVMZVFvcjhLRS8vbCtmeEtRUTkKTkJBZ04xOW01MmVHSjdia0t1ZTlhTHRPRnJu
N0RJdFVWWGRONFE1aGN5LzIySFdQK3h6dUp6Q0dFZzFibUIzVApsb1VmZnRobXArVk1tSzI4Q1FZ
Z0VHWStIeVBKTnlhMUtaVm82RGdBSUFUSUc4ZnljekFqZVR0OHlNZ01PLzBxCnNtUnpyTHIyWHYx
VkYxTHJ5dW1rdUtYMDk4cmNjeTlubHpSWVNhYz0KPVpZK0sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003cd11406173e5f4b--
