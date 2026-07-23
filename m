Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B94378D7D
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831468; cv=none; b=JN2Vv3Unj8VqX9tf+HZamCjS4qAtoa02d9AnoQ5KxRmZTpGmTLQHqV5G54wjpFv8gDH9ilhrp7VeFJyL+jPVuzEe/Xnkg4K9AWmnLxCTG3PnIEFyV34J+ZZMjEk5/Kpystd4tWHQQoyPcIHgbRXeiUpH6EF8BUK4QPFQ+kJFhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831468; c=relaxed/simple;
	bh=quUqUfI0D1ZpOHEI4dtBw872uFl6HbDI+fuhQjCmgiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OlCAd5wvbqvX4AEWKVKtIC6HSO5D/lnQaSMXt7Ypn4017HCsSBbuN9/F7pmRn4IhVlwIWZsYWAIx83dXOK8gVamFKqJqP0Uav1G0BoiYAUHF3E1fNuqx9/8z1QaRZ8eiZVPgLr9jW4HuL5ZnaEQpmvtED94+jN7L8jruhl+IhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JlY7HI2o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhT0DeFZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JlY7HI2o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BhT0DeFZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8D4E7A0177;
	Thu, 23 Jul 2026 14:30:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 23 Jul 2026 14:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784831459; x=1784917859; bh=RDAVycOjkC
	v5LrhMdlcRhxmSoi1f82B8J2E/ahk3gYk=; b=JlY7HI2osam2KNctKeI4l4cIRe
	knxxAvinmd9zpg17MKmUlOMvFidEwhNkZHa43jUjnzY+wde4B/MZXKEeRR9KUJgQ
	2uS/aw+kPOSIvdLYSBygvoTtBBrCP+SlTrHYmnH3LCguBvnCi9PYmcnEHkJ08BN9
	v81NHkJ8n4q6NxD/dgf3OuTLxna9tod0ttcMvptGmv5uGMwjr7rYBHWdCrnakGii
	bSB7TU3AkhmL2sM6sQ5RxPvwK3o4madz+H+7Q2CvAr/rf00JewW8dpwNPIy8gZBs
	e6j1C3wZlAiGiADzsop8o40fr1Rd1MADHq+lT2HkJ2MwjHc1gK9hZGzwk6mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784831459; x=1784917859; bh=RDAVycOjkCv5LrhMdlcRhxmSoi1f82B8J2E
	/ahk3gYk=; b=BhT0DeFZEap/9DJZk138ckcRf3Xsy8aIUZUK/1MPffTlYWuYr3J
	13x+gKNZI48lrCQyLm89EzW5Wpx+alfRflMnXIdLY2/a169cx/hbvPZCaJWM+jrK
	4KnT10z007BtXRfyCFrL3vd6TCCYB9MJDJ1FvDJYPImQaMl4cWKYkB8Kyd5ycP4P
	UXCzrqDBeWmC0MfJkWLGz/OEoe7BlZ0cc0dQpyubvgeTmcmB7GgJf08xzs7/ZXdw
	pciakF17qPqXiC7i7DTox3HURlISdDUmsUi+Aur49u3tKAMW+brOCx9CqwTfyaS/
	AuDuS2m2gveKN7V8q7pljKM59jzs6bONX0A==
X-ME-Sender: <xms:411iamtny2DirDpyF5M6e_htvTMVbkQW5hZRZbyuXcakXUXSofmZuQ>
    <xme:411iaiURVjFxJqRALBH36KDMitc6pWgOwcb2BMOy28S1Vg_KUpxB3kgALfuBktp3m
    0QLv24LImOcXYS9MFHHyykx648nZpqojPxuWuczkd1zYc0hUNRygDc>
X-ME-Received: <xmr:411iaqEdO9xrBL26OJ7xA_m79mKdSDCXXAOe1-EMjHkKi8xFOMZc--vyz5OPBy8QNiP81bQPKH4tkCWLgipBLzgXfEqmVhPUew>
X-ME-Proxy-Cause: dmFkZTFPN7clxjYxFi0Z3ehiVRJp6ODxco0WnfE2Ub6/viUb7K+xdbA9qZY3eY1DSgNdlT
    APnUqpNjqzHSaT2DmWsEDYS+sMNMcemab0DLT4OmzX6x1RQLND4fdwv6MYItL0bFDmUGFw
    WZ78WSUxmC+0cyHwgOJqF/OkBSAyU8MEUvx5DF9l8MSAuiho7grumjWGUOGsCS2Xn9IAxm
    VVERa/z0cP5Jmz46TWfKXP40htQjp3vGzOyiEwF+OJV3CUAdpt/BEnn/ZnAjGNLLDad5Fi
    zzCWBCfWin+ogrDCmhP8iv3xJDVuzdh4Ee407iv3jLoMunlRdWb8zjVrm4lr+6hyQhbLTY
    8fwIgXzF6eDvY048ANWpNH0aWqSs+N2tlogcr1h+IqkdU1eGjBwU8EryRReX/oa24PI945
    qK+RNbtdR9Bg4pz8e/AtF6HM4TTxLU8FU1Qttwkd3SmUC1hqnaBVh7iyfB50VgCEp5rxTj
    p/c03Sat7uY4flwYg1YkUgPyFWp72fDOxOjhYENwci967B6Eg/pnhiP4azEEHqXAF72LW7
    jqHTq/qtHikihMfJsm0eZob35A6eMADkK1UKUIDMaArQKIr9br9nKb5n5g+bgN48zWbROl
    waAqvT643SswaMj3AOzNRSejevlN9mFzpeqsumkF77d1PldXtRdq6VBFzSgQ
X-ME-Proxy: <xmx:411ias1t11U_BkUxxk6wK4FUzDXvE8QNJIeTx-R_fi3312U7alj_6Q>
    <xmx:411iakOrcU1a05qcg7AhpHnfrYKUSVPMPh1CbIm2uBm9iV0VkeFhdQ>
    <xmx:411iaj53BBk1YRslQvrC9uhwZoZGf26G1YqnFXUIsNpdSxsKqzx-4g>
    <xmx:411iam3BabGXM2v1vXmoIV7tTzQQiUlN5p774a5UF0A38J-vt9KR1g>
    <xmx:411iakEyb3fLWHa8Nh7YTPSA7nRfX53pKJSx6fQhVxht77us8-izgog2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 14:30:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Lucas Zamboni
 Orioli <lucaszam0@gmail.com>
Subject: Re: [PATCH v2 2/2] mv: check for missing destination directory
 before renaming
In-Reply-To: <1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
	(Lucas Zamboni Orioli via GitGitGadget's message of "Thu, 23 Jul 2026
	13:13:10 +0000")
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 11:30:57 -0700
Message-ID: <xmqqo6fximn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +		/*
> +		* If we are going to move SRC to DST on disk, DST's leading
> +		* directories must already exist.
> +		*/

	/*
	 * Our multi-line comment is formatted like this.  The
	 * asterisks align vertically.
	 */

> +		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
> +			char *dst_dir = xstrdup(dst);
> +			char *slash = strrchr(dst_dir, '/');
> +
> +			if (slash) {
> +				struct stat dir_st;
> +				*slash = '\0';
> +				if (lstat(dst_dir, &dir_st) < 0 && errno == ENOENT) {
> +					free(dst_dir);
> +					bad = _("destination directory does not exist");
> +					goto act_on_entry;
> +				}
> +			}
> +			free(dst_dir);
> +		}

lstat() can succeed and 'dir_st' may indicate something other than a
directory (for example, a symbolic link or a regular file).
Alternatively, it can fail with ENOTDIR when, for example, 'dst_dir'
is 'a/b/c' and 'a/b' is a file rather than a directory.

Both cases will cause 'git mv' into a path assumed to be a directory
to fail.  Shouldn't we handle these conditions as well?
