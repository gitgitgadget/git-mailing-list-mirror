Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7149252E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285751; cv=none; b=fxcOzH5ahS18ZtxAWeyw/7rGo3bElNilqwhbeRuJ6SN/yJEupr4JipsK90nf7cKNLhrfwKT5yVPqo4nlU9du1uEx8jOBC3rOlrd+6aExqsCxvwsMEAD8nLxZFMthsDk4vUMWZpOeZ1ywdT3vEbzH8QZLbpJmRcGEAluQSTXv7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285751; c=relaxed/simple;
	bh=KfWrVJaUqkbb62ndkdQWE8/l9YzzZ9TJRLxm2OQD5AI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vfjd6ffB5gG68VJ94+N8PgsSwHhv+C9U06lm1wKOp8BbmkIIHYH1qs/pbhqFs8Hm8pLbKcijPrpCpVacbBq/9uW28m87ncgwZRKijUGW9nuNEc6PbsnL9tVltP2GzifDqGg2dM5YqiFuFyaiy1CMusLhrr7JRA0Vlch0u7XB4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GmBqhezu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4HQQvuA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GmBqhezu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4HQQvuA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AF677A00DB;
	Tue,  1 Sep 2026 14:02:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 14:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788285749; x=1788372149; bh=BJ/ow+T1fJ
	OPGFHCfjmDzJ19XJNsdd+IQOPVyHh4LPE=; b=GmBqhezuQ5makEzQt1PdHZzKwA
	Kfx4HI5otLSxiFuLIf4rRwXUAgr80ccAfwMtzbi8X1WWq1T4Lb4YEZzywj8DhInp
	SlzMmZf1915ekX78Wg7J2z24nue6AtcUnkt6yJmzcGT8mRz38H9oKVciSceuYX0s
	S3cyAmhKyYQ2Nw3ANk1FmA37W0/vw6W7bRJ0jWzovPBTnG9EYgRY0+1jB2VFu5f0
	yY+QTy2F+T+cNhoVX3l2IY4i97KAUjigWP+02w1bh4WllW7UYkpRwx08YkMqIU5r
	mh9WMHarmoPNr7hXcZ5qz6cKmPa3kzx9nC45X77nLcUKIQXG0NvwInKqxAtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788285749; x=1788372149; bh=BJ/ow+T1fJOPGFHCfjmDzJ19XJNsdd+IQOP
	VyHh4LPE=; b=f4HQQvuAGwFhUQ2ZMFiQyT7zapa2/PHUspMJ5zB48jSs8ylRaEH
	o6rCUectA49zlLftdVuPdTRLeAyyhfMidDmoeZYy7m0iiW3EUca/RGlOrDUEoYbu
	mVptftvfGiMalwSZsGf+HWpIg1EbZtc5fQmsjNQYsS1Alb+tLdybV33T4xkiVUAf
	5MEK4jlxe814DobhFhudJpYM33GRHwDQDigXp54MKvx8cjK0a5ibYRl0EjLkuClx
	85KVmfmW8Ivc74qKeMraig7mYHxL6qQtcwKTdxiZjbVpTX2syfYBkK9yCnFmF9ZC
	2/2aNICCay051jg+Sab9FP8jschIeX0WeTQ==
X-ME-Sender: <xms:NROXajjswOOCBVIfiyY28C6xVHqn4yFUtnxdAv7W3s92UIB2e9XL0w>
    <xme:NROXanCkLQTh0ZzpI6cbqLtnqYh_7QlUCIs1YH1EDE1DH8gnSBLxDNrbQ5t3pWVjr
    cEd1NKFdnhT4uxxfqAf5NJAJ5TA-as5kmsyGPDPEKeCarV-zPTKXA>
X-ME-Received: <xmr:NROXaoGxVe5u0taI3H6xhe6E5PB5QrpV_739o_8IG4tBWyDFWZVin_x6Uewl2ZdZ1TLTjPkBTwrhE2fJSUUkh5uCuPvfyBmuOg>
X-ME-Proxy-Cause: dmFkZTEZ2Yt8Nf3l3lQjU6Wp8PWS8A9C90b9cDg3vSx7EeSqXCNTIlTfy7AN+SkteOtBui
    PMQbnp8RRCsUERTPfyM9wFcgBWSJ7nRF7YKMbhpIQXheI85h3ZGjqEoTpgPnUCiW2WO5/J
    pB6ETjFMQ3HcbSNnKik3uqSsNL5GcrCTA8s+RZO1+P6e0WHPWhF3MndytSvZbnWD7Zl2Jh
    qD+02wlFYtlCxE4pZnLiTIOWQqVB9PF9mY8n0woVvshvniD0FRIxwpucjA8DZS7sfU2XfC
    GYcFSXNSkzjTUb+AOYPqgCF+7m2sNaIkd01xdZBEEegBIekGT897iCGbILs/hlRTqmJgqy
    LJOT+pJMSHVJpqxWiZxnD5jrt4KmrjP+Vff0mUhP6SAIp0aNf+6m5TFW57E2q1m7yPh/rW
    VRhSvESnBtn+KDnYEXKhgF35NbOa+dXUOON+24e035yKWiy0ESudfzp/CzaGIUiukV/YI3
    6j0vj1uSw+N5XJ352D7wbGBLzxsAs4H5Vi4+6uPIVkWCvlwvI0Omr09nzqPQkFuqMIwb3I
    xceKtEqziX4go5o7+XTBG+AAqPIdTrftIAy3aE3YFNZmU7SIDgBCheYpZxJ1/p0OvGaovk
    8m+MhSIUAO2DBBIEViqd2tl1d0yvFFh41KMMs97+1lXZ/8W4BXz2kcwFP4jw
X-ME-Proxy: <xmx:NROXavKHAtJywfBrpwbmZFB1Vg2xvFuViTOXF23zE25dpu8pEBFwpA>
    <xmx:NROXasmDkI1UE1BLF2MaXyWhStnnSp9PFqc61C_g0h7lLBKh7GtoNg>
    <xmx:NROXanQA0Tb-cnlIiRhD62R0GsEco0McGbxZzA-1U3-EZwpwwkBa9g>
    <xmx:NROXauJ8QKjlvxlI81Oqlr1gk7grIRoinvYuHv59OTmhWuL8UjLiXQ>
    <xmx:NROXaiDbtFRSy5nkezQOTEpAclCoKPY1TbWu9AMPhkD9vK3jxAnbAOKX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 14:02:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Nicolas Le Cam <niko.lecam@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/1] revision: simplify mark_argv_for_free() callers
In-Reply-To: <20260901063645.GA2951423@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 1 Sep 2026 02:36:45 -0400")
References: <20260901062815.GC1075462@coredump.intra.peff.net>
	<20260901063645.GA2951423@coredump.intra.peff.net>
Date: Tue, 01 Sep 2026 11:02:27 -0700
Message-ID: <xmqq8q5ksvd8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> BTW, this is a small cleanup that I resisted putting into the earlier
> commit in order to keep it focused. But maybe worth doing on top?

I like it.  It is a tiny simplification but makes the callers easier
to read.

>
> -- >8 --
> Subject: revision: simplify mark_argv_for_free() callers
>
> You do not want to mark an argv element for freeing unless the caller
> has given us the free_removed_argv_elements flag. Originally we just
> called free() in this case, so each caller checked the flag itself. Now
> that we mark them via a helper function, we can push the check down into
> the helper. This saves a little bit of duplicated code, but also
> hopefully makes the result conceptually simpler.
>
> Every caller but one was already checking this flag. The exception is
> setup_revisions_from_strvec(), but it always sets the flag explicitly
> (since its whole purpose is managing argv memory). So even though it was
> not checking the flag, doing so is OK (it will always be set).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  revision.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 7aee96bd8e..59d6372506 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2317,8 +2317,11 @@ static timestamp_t parse_age(const char *arg)
>   * usual const argv array, even when opt->free_removed_argv_elements is set).
>   * We cast away the const on their behalf.
>   */
> -static void mark_argv_for_free(struct rev_info *revs, const char *str)
> +static void mark_argv_for_free(const struct setup_revision_opt *opt,
> +			       struct rev_info *revs, const char *str)
>  {
> +	if (!opt || !opt->free_removed_argv_elements)
> +		return;
>  	if (!str)
>  		return;
>  	strvec_push_nodup(&revs->argv_to_free, (char *)str);
> @@ -2335,8 +2338,7 @@ static void overwrite_argv(int *argc, const char **argv,
>  	 * cases around the free() and NULL operations.
>  	 */
>  	if (*value != argv[*argc]) {
> -		if (opt && opt->free_removed_argv_elements)
> -			mark_argv_for_free(revs, argv[*argc]);
> +		mark_argv_for_free(opt, revs, argv[*argc]);
>  		argv[*argc] = *value;
>  		*value = NULL;
>  	}
> @@ -3055,8 +3057,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			const char *arg = argv[i];
>  			if (strcmp(arg, "--"))
>  				continue;
> -			if (opt && opt->free_removed_argv_elements)
> -				mark_argv_for_free(revs, argv[i]);
> +			mark_argv_for_free(opt, revs, argv[i]);
>  			argv[i] = NULL;
>  			argc = i;
>  			if (argv[i + 1])
> @@ -3260,8 +3261,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	}
>  
>  	if (argv) {
> -		if (opt && opt->free_removed_argv_elements)
> -			mark_argv_for_free(revs, argv[left]);
> +		mark_argv_for_free(opt, revs, argv[left]);
>  		argv[left] = NULL;
>  	}
>  
> @@ -3283,7 +3283,7 @@ void setup_revisions_from_strvec(struct strvec *argv, struct rev_info *revs,
>  	ret = setup_revisions(argv->nr, argv->v, revs, opt);
>  
>  	for (size_t i = ret; i < argv->nr; i++)
> -		mark_argv_for_free(revs, argv->v[i]);
> +		mark_argv_for_free(opt, revs, argv->v[i]);
>  	argv->nr = ret;
>  }
