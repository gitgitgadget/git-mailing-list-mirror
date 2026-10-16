Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3B31197C
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133907; cv=none; b=slW/g91JH6dXWDsXu4aWjffZIm1KjBEz9G138TXVhqNvbvlJ3sQFKAx2XrU2H6ebNDkXLoyjcV5W+e9V8B198bkNdc/kIuJ9UiQh6jNcNBB0UizxMKJ/4lQdcMeCZnyvjlfzOwzbb5eppcEPXRaigFu1uy1TBRN4uQdrQrVxSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133907; c=relaxed/simple;
	bh=2muWFmNDAr0t1xw+ZR51YzluiGkc50rnUbGY6A8P4zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkACR35RM93cUbIE+vVOY05ElJEVKahAn2hJsrXSQMf+OeBFR7e+r4+jppJRSzxs8CgKBdADH2lBbKrumsEkDymtfHF8BhOiXOKgJvht1GmJv9pXtAlmyBMFq1AvOW2mmMQl5XeUrUh8hH6AEWmMWjA7jI+wIItIedu385wL14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dDJfr3EF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cHEJ6bRg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dDJfr3EF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cHEJ6bRg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 15777EC00BE
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:58:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Oct 2026 02:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792133904; x=1792220304; bh=6jftChUDx5
	eAl5xkgvakUa2UY370wZfQj/MMj5IC4zk=; b=dDJfr3EFRKRliR3RlPEbrusZ9O
	++2+TSV3fjQtL2VfVPuFdP02oEmcSNxUqswcx3PUZKieZll6PxDkswZ1dfHlpgzy
	Vq+Nkdr3vqkWt/Bgn7Q6wDGVMQq3vbY8/lIYOUjORSa/HLJ6VyhW/DoWClIaR/jB
	wZ4Y9xxirRy5Do1BQe87R8KSJ6x9IWdXTT22B5VLJBNz7JPc5xkUM1VceCCd2CNf
	uIjK4b8NxNlqWvkQfvNlHPh3oVrLa1+FEa6AVC+9nRr0ixyZ2n0RXqOr2Wm/vrBv
	PP4ifuNCnApWK6KiiOg0PE1+h6dujjLugI6tLVbAORBvqFyjrXDVnrBD4guQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792133904; x=1792220304; bh=6jftChUDx5eAl5xkgvakUa2UY370wZfQj/M
	Mj5IC4zk=; b=cHEJ6bRge9OanNw97bxtSPoTk5uTcaIrpCESdfAAMqnJWGNyGWd
	ShAedIgb1hiY56J6/l8CMblKC/xBHBxbJZwj5W8HllVni+KXU5GuOnxZCpuduEuq
	GPvkDh7qoYnK28/AihuGjH+sznPmlBS0v8lCY7LXbdgfjufvEqgwgw1NKFwhQE21
	e2WY5JZrwiYRbGI4rtqY6WsL56uzD3rnQv8/rbAGjXvMxM4eizcoHVanVu8fifTR
	hZFngAnUMCP7+f9UwVkfOTdQHqvUBkS2om3FGEoaJEsWTeaE488NPtw6vES+fiXP
	SjFlLP3C591rUeIV+p6W5Fuafy6eJJgFNSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792133904; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lk1EMkT7poTaJ6k4IDf2b0VvjVfp79ET99Y480E9yCCR4IT
	u2wAOCNEV/8Ezu+2HtfV5R0pak4z3PF6TzG5DqdW1nq0RLNVb6f14FIBVuMp9jWB
	AFSTnyYBsoboURyQoNwU/ly1JHEuHahEn4X8At912Z8htxwk8hyHvT073EynKAiD
	Y99wr5rMl5lMdwGRaxVJB8q0LeT2aZfaDCvxamynwxTvscyU6HNEVbKy4GYO/o0j
	zj2/H1/6KLhsh/8a6H/elhMkiaSkvDWRsZfc02y7Z0sz4FHk1/sXMcZ7AV4e/HQ/
	R8ZFIknCwf06AAd17qqokHL76+ilVtlrwyuClvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ebPmoPc2mwpKx4Ho2kk/37vb36iMGFBOiVPg4WRiHWs=:2muWFmNDAr0t1xw+ZR51YzluiGkc50rnUbGY6A8P4zk=;
X-ME-Sender: <xms:D8vRaonnTZlmBYb9OP0NeAt7rJ0AsMNAAUYJYTy2pcTJRJr8G-RtJQ>
    <xme:D8vRat1KEF3bQIXPtl6h9okEK8c1LH4OxQFVq6auX21rWMJg60EdRmdxiuHQNFA84
    TyVGROqBFXjRQ-jYxkJe79yK5YSsX3YxBJC74IUl1q97hXjwj3zh20>
X-ME-Received: <xmr:D8vRakRkNyF4pgbR0FO2uMAYtR21wHz093Rrf7TfZsKUIufykorHew>
X-ME-Proxy-Cause: dmFkZTGHvgxDFnImlGop40KwU3bRUSEKLoiD9eWJihBrXakBN0JANQyDupg8Xzey+84UHk
    h883Q17uBUpUMnn9Bbs/1azxo0H1cSpzf78CQLuS//jnYD/0zXqeiHQ/Wpwyu5fHrGvP68
    OucZEj6H02rkDN4++14y1zlW4m/DmQutB2EXmK5GxDIdCeNN3Wtse+lxFWOz0/Xidf71IX
    xb5KYj+XTph1yy1yx3tlt5DMrM3eSUAqnMVmR0aEHUnXsTM0ZVdcQ5gYoT4eMEB2JfG+mF
    77IKjdc/1pSDxuIJuL+uwSa6RHMx4cIlOVxzvMzY04qx8TugEcIYa4s9bhbpZGvCqYtpQB
    mwnubmKev9oKI5XJzEAnFHIAfDZzbjOv3t34X/WOY6pEUujSM3A3/FZ8Qes39f3030mac4
    SgfSaW91HQ8TY8T10HVm9OvuSKF6AnOF3AcO7y/Jjqm+ka1X0jOzWo+nQ4DYNA7cdl2Snj
    W09uCPPMUmmRNQqyEErg37qFNxYMCbvAnfLarunoPvzeECaU3/dxoRyNfzG7QvAz7+GfoM
    FRBovE01Ha+O54JC24q9INqGPvzZv3A0wOhdNJzpVaYipwaR0wmFswbF51AR3v896TMmie
    xa+ZW4yCZIjYHsA4e0gLAclEI6PuwYjGmpr9BgnpePImLdQKhu9ONoVKvmZA
X-ME-Proxy: <xmx:D8vRavsRNXcXyO6L11sP68vH6-ND3YqRfUfDu0MvJOIPedZlw1aBpw>
    <xmx:D8vRapan6pY7onOKZSdpOeK8h_gYCIsGEeRe0SKCn7eoWRHa7JpS6Q>
    <xmx:D8vRaksKWkTTNYO6tMkCvK_XZU_VwgUHsuEklnrj7LY7AD5gufJ9Uw>
    <xmx:D8vRarF2TmLeIIkS3LrHf_AZCnLySyw_iXbh3FoBeIsIMKb_UCQmfg>
    <xmx:EMvRahVzosFSH1RVYe-fUhdxl8Eebw8ORn849U_OEGF6jyqZ3URfD8VM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 02:58:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b339c6c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 06:58:21 +0000 (UTC)
Date: Fri, 16 Oct 2026 08:58:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] pack-write: lift and expose index-pack report parsing
Message-ID: <atHLBS0GGxf_cPmT@pks.im>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016022901.3838402-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016022901.3838402-2-jltobler@gmail.com>

On Thu, Oct 15, 2026 at 09:28:59PM -0500, Justin Tobler wrote:
> Once git-index-pack(1) finishes writing a packfile, it reports the
> hexadecimal name of that packfile on stdout prefixed with either "pack"
> or "keep" depending on whether a ".keep" file was also created alongside
> it. Callers that are required to manage the lifecycle of ".keep" files
> parse this report via `index_pack_lockfile()`, which provides the path
> to the temporary ".keep" file.
> 
> In a subsequent commit, the "files" ODB transaction begins staging
> packfiles in a transaction without eagerly creating a ".keep" file and
> must instead read git-index-pack(1) "pack" output to get the packfile
> name. Extract the generic parsing logic for the git-index-pack(1) output
> into `read_index_pack_report()` in preparation accordingly.

So if I understand correctly, the intent is to eventually stop creating
the ".keep" file in the quarantine directory? I assume that instead,
you'll then manually create that file in the final location before
moving around the pack itself.

If so that makes sense -- it's kind of pointless to create ".keep" files
in quarantines anyway, nobody but the current process should be touching
it anyway.

> diff --git a/pack-write.c b/pack-write.c
> index 85674e4b72..5f5bb894a5 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -469,33 +469,68 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
>  	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
>  }
>  
> -char *index_pack_lockfile(struct odb_source *source, int ip_out,
> -			  int *is_well_formed)
> +int read_index_pack_report(struct repository *repo, int ip_out,
> +			   struct strbuf *pack_name, int *is_keep)
>  {
> +	const int len = repo->hash_algo->hexsz + 6;
>  	char packname[GIT_MAX_HEXSZ + 6];
> -	const int len = source->odb->repo->hash_algo->hexsz + 6;
> +	const char *name;
> +	int keep;

Suggestion, please feel free to ignore:

    int is_keep_ignored;

    if (!is_keep)
        is_keep = &is_keep_ignored;

Then you can unconditionally use `is_keep` further down, which I think
is a bit less awkward.

>  	/*
> -	 * The first thing we expect from index-pack's output
> -	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
> -	 * %40s is the newly created pack SHA1 name.  In the "keep"
> -	 * case, we need it to remove the corresponding .keep file
> -	 * later on.  If we don't get that then tough luck with it.
> +	 * The first thing we expect from index-pack's output is
> +	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
> +	 * name of the packfile it has just written. The line is therefore five
> +	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
> +	 * "keep" prefix tells us that index-pack has also created the
> +	 * corresponding ".keep" file.
>  	 */

Okay. I originally thought you only reflow this comment, but you fix it
to no longer assume that packfile hashes use SHA1. I would have either
pointed this out in the commit message or done this as a preparatory
commit.

> -	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
> -		const char *name;
> +	if (read_in_full(ip_out, packname, len) != len || packname[len-1] != '\n')
> +		return -1;
> +
> +	packname[len-1] = 0;

Missing spaces around `-`.

> +	if (skip_prefix(packname, "pack\t", &name))
> +		keep = 0;
> +	else if (skip_prefix(packname, "keep\t", &name))
> +		keep = 1;
> +	else
> +		return -1;
> +
> +	strbuf_addstr(pack_name, name);
> +	if (is_keep)
> +		*is_keep = keep;
> +
> +	return 0;
> +}
> +
> +char *index_pack_lockfile(struct odb_source *source, int ip_out,
> +			  int *is_well_formed)
> +{
> +	struct strbuf pack_name = STRBUF_INIT;
> +	char *lockfile = NULL;
> +	int is_keep = 0;
>  
> +	if (read_index_pack_report(source->odb->repo, ip_out, &pack_name, &is_keep)) {
>  		if (is_well_formed)
> -			*is_well_formed = 1;
> -		packname[len-1] = 0;
> -		if (skip_prefix(packname, "keep\t", &name))
> -			return xstrfmt("%s/pack/pack-%s.keep",
> -				       source->path, name);
> +			*is_well_formed = 0;
>  		return NULL;
>  	}
> +
>  	if (is_well_formed)
> -		*is_well_formed = 0;
> -	return NULL;
> +		*is_well_formed = 1;
> +
> +	/*
> +	 * If there is no ".keep" file, then there is no lockfile to return.
> +	 */
> +	if (!is_keep) {
> +		strbuf_release(&pack_name);
> +		return NULL;
> +	}

Can we maybe have a single exit path responsible for releasing
`pack_name`?

    /* If there is no ".keep" file, then there is no lockfile to return. */
    if (is_keep)
        lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);

    strbuf_release(&pack_name);
    return lockfile;

> diff --git a/pack.h b/pack.h
> index ada506b5c5..ddf2d52934 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -106,6 +106,16 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
>  void fixup_pack_header_footer(const struct git_hash_algo *, int,
>  			      unsigned char *, const char *, uint32_t,
>  			      unsigned char *, off_t);
> +
> +/*
> + * Read the report that git-index-pack(1) writes to its standard output after
> + * the packfile is written. The hexadecimal name of the packfile is appended to
> + * `pack_name` and, if `is_keep` is non-NULL, set it to indicate whether a

s/set it to/it is set to/

> + * ".keep" file was written. Return 0 on success and a negative error code on
> + * failure.
> + */
> +int read_index_pack_report(struct repository *repo, int ip_out,
> +			   struct strbuf *pack_name, int *is_keep);
>  char *index_pack_lockfile(struct odb_source *source, int fd,
>  			  int *is_well_formed);

Patrick
