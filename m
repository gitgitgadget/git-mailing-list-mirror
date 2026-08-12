Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4633AD85
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514864; cv=none; b=LWSyWgkAT4YWZscOmvWnmH4wr+QuUxxmVj1Xlg1TPQ+CtPFMqlut3laPSv425NNJVN1bAt5qfOyUw2BlM2G9VQBkpET7BZEzDlCPMwzr1ammAphXwtQheUJcHkXJOc7l/P1Wz4uDNL0i14hUarPYa3HrWJnGiut1Zd1PdOdYDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514864; c=relaxed/simple;
	bh=970JdO71tsb0Ea4nzklQ1zG71t7etjy0fvXM9PqF0sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPDJaXuOMBDH5NTDpB/YIFEXI+A2h2h3bfvRHYQzSavDArtegxSRHk/Rdb0sHQCccUEoWUPkkewvcao9sChd2B839ETyUmiYIC4PXb8CU+CqSRu8pQuVz148X0Q+6rQtJwUKnQtesM7sNJoJ8QULUcUGQ/zVrBJAICUE8AXpvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gmM5vjyZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGJ0Zbhw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gmM5vjyZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGJ0Zbhw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0056D14000EE;
	Wed, 12 Aug 2026 02:07:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 02:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786514855; x=1786601255; bh=k9JAAqrdqy
	OhELAHAFjnVib+tyIQTjwIeV9uTSFkHGU=; b=gmM5vjyZ+pkMUdMCarkLqmHR6w
	YFnhfcYTJBDby7wdw1YUsGQvKno6ylU5xTiVUbEN3F3AQ/UCQHx6VDluBs3kvPEe
	Uz9wfzp2fEcV7f1rDxFdH1qgc8Jo8aK7zn5EqKPc6Q2saVnD5hhlifc3BvFSZjdm
	JBmXJpXpNWf9sAKV0jle0MUC3+41iEypHFYbLv9ptolgC9dxSS+9mK/f52m47m+z
	/MK0PmC2LI3uOxiAyedFkyXSxnL+zlGsn7jCB4SOZj75BVjWbcRAPjl4V54Tz1i6
	PFDuoue5KOSPYXvTwmECyGybmYOR5VhdGq5qNaFhviiqfP+ZcHgeZe+qLEoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786514855; x=1786601255; bh=k9JAAqrdqyOhELAHAFjnVib+tyIQTjwIeV9
	uTSFkHGU=; b=iGJ0ZbhwFFra++Nk46pwA9N79wcWS4bFTY0CaJKYZ66yOrA1pif
	rz8cSxz0IaOA/cRASAvpB3FkedB0ic50wak1Gmm91/BnAt16+N/i17BQ8VANN1cc
	GpDAVNMExaG93GPTMas5LOa0r0QS1klnrXL/SA6BLpv0aDTixu/E1UD835JcIsAS
	fvLpzrhYUs92L29sI3D5Dfwxr7t9SG1O5nbtWWw8uIhvVGyYayx48/cSioepRwOz
	E1QvtEqIG/epstQp6IjjOB2onJAjijlqOkiQdAct9uNBDe7IqUpqvtsiVYkU3lCs
	+JtqdNCKrAttNvNpwnRvWfgWRCs7qZhTEZw==
X-ME-Sender: <xms:pw18aneUTcFQc3FM8AIS17QL38OTWo2agkXYKNWsCJjbs7PhHI_zfw>
    <xme:pw18akoY8cJrBD4e9HElt4Pn3xXFBn8gejWf4AsBxaTGMmPQn7ez917nCRJaAEPyW
    2qcpgmu6AdRpFH5xsFDWga9b_BYRbfmpUf8EqdR-ilcbmMRfDUFlA>
X-ME-Received: <xmr:pw18at7bL2EPkxnZCCRnB7PokJo2UN6tJfjnXVUHZAhhUcMyuPojlTKNieid-_wSt85814jO1PyKL_izz7MR6utC69ILCM3qG61KCOJ-KA>
X-ME-Proxy-Cause: dmFkZTEScmcLv460d+mGWNHedLf8KgdEnoKaLTOruDpgoVeHKf9SjxtKXyy6nvAuXdEjV3
    BjZZyWzocOVuFdTxPlYdtjcIyQ+HYF2mL7ywlHJJKk1I9bnlKnjQJR6ZpLaxyLbO1Bev/C
    pmMxGcJtWq3GBVk8282J+7y7hgxnoOTCcaTRJy8ramju0VvwJSFPSwN+1V3qYqrE0V8t6W
    3u2/O2UvzsrVFriAr8GSSZYcl89L+9VV0NQYtFzAehCaDPWEzfJO5Ein365vqCeLli0kNC
    jRX/ka3jyRYX4hgwLxt7DOzsMBYZuJX1TKWecW9VNB59xNvTK+jPtee0oB63acHrHBNJSp
    d1QYN/iLFIXXOu5fe+jHJ++fTcER4gq/MVqccZ7wuGY4vvHo9W5VUkUcDPbnM/i8Ct5L65
    yTT/juTQtAO+TCUPd0MN546QlBxNigQDCH9qmr9V+aUo7Thb6+CsdRWQmkQEXQn1a62uyi
    hZL86go8yNBWPe02MWqYUy+MLUu/dmf4C/EliNM+U1ewtDIUb5neKAz2dlpl62uvvELNHr
    uhw4CbonS/XYbYM+tnxjieRKNfUh8Q512y7bVPDlV/IEq9UKuVT6nISh1CHc1TbZ1Z206X
    FO9N0Mz9fs8PnNFiNPgJoNpI3IfmN+fjqRgPVEcR3UV7b7gssEaVY7oHtdgA
X-ME-Proxy: <xmx:pw18aiqVXH5eoPRL9cR2uxzo9AH-zO_kK_FuldO0EdgSDhgRRPa6sw>
    <xmx:pw18ani6iFTzGbWPu4VyOKjSa7xzUrbbq3k-pMH_mie2f7HEcCWArw>
    <xmx:pw18akK28NZ9qp7NrsEhsQ6KR8Om3QownM_jIqBZ-LTk11pDz1fb5Q>
    <xmx:pw18avDv53YmkhfB4UwWF_qsIwTNoIlwR52wth0WLXOLHSecnjw3sg>
    <xmx:pw18agpDyqmcTBgmVhX3_-YG4AIxcVvHiXtuXRRcSeExWyhIw3bihnmH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 02:07:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1764a2b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 06:07:33 +0000 (UTC)
Date: Wed, 12 Aug 2026 08:07:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 1/9] builtin/receive-pack: properly clean up keep files
Message-ID: <anwNonpw5SZuHADv@pks.im>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811175415.2044235-2-jltobler@gmail.com>

On Tue, Aug 11, 2026 at 12:54:07PM -0500, Justin Tobler wrote:
> When git-receive-pack(1) stores an incoming packfile with
> git-index-pack(1), a ".keep" file is written alongside it to hold the
> pack in place until the references have been updated, and is removed
> afterwards. The path used to remove it is derived via
> `index_pack_lockfile()` from the repository's primary object directory.
> 
> In bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
> transactions, 2026-07-10), git-receive-pack(1) started using the ODB
> transaction interfaces instead of managing a temporary directory
> directly. When starting an ODB transaction, the sources list is
> reordered to insert the newly created transaction source first as the
> primary to ensure writes are routed to it accordingly.
> 
> Prior to using ODB transactions, git-receive-pack(1) would only set the
> temporary directory as the primary source for the child
> git-index-pack(1) and git-unpack-objects(1) processes it spawned and the
> parent process would set the temporary directory set as an alternate
> only. By using ODB transactions, the ODB source list is also reordered
> for the parent process which results in `index_pack_lockfile()` deriving
> the ".keep" path relative to the temporary directory instead the actual

Nit: s/instead/& of/

> main ODB source path. Consequently, this prevents the ".keep" file from
> being properly removed after being migrated into the main ODB source
> post-commit.

Hm. Are the temporary packs written into the transaction-managed tempdir
now, or do they still end up in the main object directory?

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 86933d8d7e..d74b787148 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2412,7 +2412,13 @@ static const char *unpack(int err_fd, struct shallow_info *si,
>  		if (status)
>  			return "index-pack fork failed";
>  
> -		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
> +		/*
> +		 * The lockfile filepath is expected to be the final location of
> +		 * the ".keep" file after being migrated to the main ODB source.
> +		 * This ensures the lockfile can be found and removed later
> +		 * after the ODB transaction has been committed.
> +		 */
> +		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
>  		if (lockfile) {
>  			pack_lockfile = register_tempfile(lockfile);
>  			free(lockfile);

Okay. So previously, we wrote the ".keep" file into the main repository,
whereas now we write it into the temporary object directory? Is the
packfile itself also written in there?

What I'm wondering is why we even need a ".keep" file at all anymore if
we're not storing it in the main object directory. It wouldn't help us
to avoid the race, because after committing the transaction the ".keep"
file would remain in the temporary directory, whereas the packfile would
have been migrated to the main object directory. So it doesn't have a
".keep" file at that point, and neither have references been updated to
point to the new objects yet.

So I wonder whether instead, we'd have to:

  1. Start the transaction, creating the temporary object directory.
  
  2. Write the packfile into the temporary object directory, but don't
     create a ".keep" file.

  3. At commit time, first write a ".keep" file in the main object
     directory and then migrate the packfile over.

  4. At finalization time, prune the ".keep" file from the main object
     directory.

That would retain the current properties of the system, but as far as I
can see this is not what we're doing here.

> diff --git a/pack.h b/pack.h
> index 1cde92082b..68dcf08cf3 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -3,6 +3,7 @@
>  
>  #include "object.h"
>  #include "csum-file.h"
> +#include "odb/source.h"
>  
>  struct packed_git;
>  struct pack_window;

Let's add a forward declaration instead of including this header.

> diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> index 0798ddab02..400a597606 100755
> --- a/t/t5547-push-quarantine.sh
> +++ b/t/t5547-push-quarantine.sh
> @@ -70,4 +70,18 @@ test_expect_success 'updating a ref from quarantine is forbidden' '
>  	git -C update.git fsck
>  '
>  
> +test_expect_success '.keep file is removed after push' '
> +	test_when_finished rm -rf keep.git &&
> +	git init --bare keep.git &&
> +
> +	git -C keep.git config set receive.unpackLimit 0 &&
> +	test_commit foo &&
> +	git push keep.git HEAD &&
> +	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
> +	keep="${pack%.pack}.keep" &&
> +
> +	test_path_is_file "$pack" &&
> +	test_path_is_missing "$keep"
> +'

This would feel a bit safer if we had a hook that verifies that we
indeed have the ".keep" file in the right spot before committing
everything.

Thanks!

Patrick
