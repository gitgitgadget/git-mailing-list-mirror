Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391E3BED35
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926809; cv=none; b=klTSdPB0pjHEdpF8Rv7/brzff7sNU5cVngUW2+GwD4EUpUw4cxURx9+j4aCjc0JwB6oxIYtViEhYPfq5Gkgk80j1qUdVHfngKmvPhPkSU4Bl5SNMJ9sx570pjhfbB/a5UzftlRjJUp76potptjzL4jcHeMjCmJ/IeCQZhUxX0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926809; c=relaxed/simple;
	bh=Y6FZR6GZS1jWX4GudPnaZvSbT9f30Y2VMH+aJU9RZ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE5iPZNYJ9FMbOBBseyGacTRjJLoK0LPj/v0l/TSVr9j8agTZ9Phxo+FdjjjglnXPHlkmRL3Ah0gyXleN2Adghfcz8bLxBIblqN1YOrjUseYuv10TXTX7Sr52u6z/r+gp1UdJKQw+59V4jtoDR1HHaE0xnrdyxNEnGneyGbDMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gm3sZ3QJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQ+Jb+YQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gm3sZ3QJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQ+Jb+YQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 62133EC0263;
	Mon,  8 Jun 2026 09:53:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 09:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780926807; x=1781013207; bh=PyveV3I1Zy
	ZtRHeYvAkh7Tcm314wKNNphmJ7alvPAQo=; b=Gm3sZ3QJZdKi3hRZEgMmAUQuIl
	+NZ9fJJLrVQJHPDOVzTtu84mFFP4gc/TXTKDBeDNEcimR6lw9HFHwHfCM5/u/B8u
	l2awjeEa+ZAXrk123pYjvOJNcYp/p6GzbIjx/JUAXzi1CM1J12mT5sfKtI1a30ks
	9GLWudXby1kG2A5dCfkUFuhCKteKY82oDlbZcOfente8I4JpP5kAkV+2ZkVxL4I0
	JoM1+O7xgVS+OUR8F9jFYm+R0KztZcArUUlgDk0TJ2nNeJiYdAqvT0KhATmUMx/d
	AXekYtwj6YbCkC6U9jmoHuzYw6nzxdMpveaL7NiZh47FS9Wu0NRhJj/a8YIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780926807; x=1781013207; bh=PyveV3I1ZyZtRHeYvAkh7Tcm314wKNNphmJ
	7alvPAQo=; b=lQ+Jb+YQHtJj+k81wzXN0+bhI4qNHOVr5PuG3KDow8oNMtdczlI
	yhBGIAU3aYjpLNk6vi6vYozH7UJs8GRD7KdVQV2VZ8eK1tpM4uYdUIQ7bhG1w+zx
	1wEIKCkJI6PZNtZgqPIrcIN5vechBM/g8ZB1xv7QVBKeFkcW1lNtwofmNleIVWHL
	Mtnq+jwx31b+YwzH9CA3RRMCOLtdtXJjQ8sn0BWr9gto8Xv3lEtfSviZFjpScj69
	+lh7Mmkhaa32ylXpXaWnc/G8/PdW4Y+dprvgO5WKjhzBwvd2333YsQk5W3Og9E6u
	8zHcVkz0H32nogWEed7VtE2+DMB2UHrFTeg==
X-ME-Sender: <xms:V8kmajoxrYC8FuE7g9ZFP6YsHq0REgjM5QgLj3RZdQq-Fc0NycGRtw>
    <xme:V8kmakrSnnTbzB8KVDvMzigpMPCE0pzUg5sQg2B7Li7hf5BOaU6fVbs55C277NyLP
    ubO_fZGQMHcZmqdxpluGbm9WTTjxdqKtQSSyZ-Rlgc7F8LouJJ6Aw>
X-ME-Received: <xmr:V8kmalMTsM5lA496LtncePQiX2m9H9GXwAMYbpcWw-o6Z1gzjj8Ug5hlpI_DtDTuCz01BGdWVyxKYiFXZOOY6EZARUh9G91EFyrNdTa3qw>
X-ME-Proxy-Cause: dmFkZTEGNy6bVM09haIyqX2KIYn/ergfrMZA2n/ttSf9FJ8t6Qlu0XEMZqRnf0UkauDWNb
    kV5MFqeyA8BnyPx4AOKlpz8Y8eIpyCpmcnUa7/1TyJ1Ixb2kHotdY7k9AhGOzBLmWudNH/
    Q8HnzyNK9OaSEJsaBt72oqAV24+e09kd9sHDdkn9CKb48m+tNtvAevZ+75p7c2SnYMkfoa
    C4X8N98/KsKhLLix+k9BuGmr1a3zsZ2uZE+wKT4MGM4780tYIEqtZaPXTAb3oe2PwVn3s3
    FdyIi1olLDbzdYRViV6istwz/PrMTPgmLX3e1o24pTO4MHN+ArWHUd4iC07bIqKSiz/gsz
    xoZYxS43QoJH3X3inF9ZZ8T0uePmpmgNyzBWHDNoTi2w4o53ioguAfJgrLnCeQbZMQb48s
    DO5jvPDylqvZ+9lWLYNsZL4cv1ccI8gpuIr8V4RRrMjclRESV6qmOVaSlulK7HJARLj8Gu
    iTwIMVpUS/3rpXy2kv0Y0xJteCQwBYKmj1ZFhuR58ANMmA8aTR/1N9DLn3DDeURzg4RroI
    XFfVGIGv9yB7QxZ6g1qIl8wrQmRzPYMi/93Y2pbCXG/z2DobnZXXrC0s2v31WXsrSCD9Zw
    TBPvMlsLAkrPdaAg6UmMICbGTb8qt562oGnZ6dRIxxwxOylRC/apGXmtnVPA
X-ME-Proxy: <xmx:V8kmalza-NUQIdw8zcv7IPhgrnxpfjgChhH3NZtn0zRY_fti_5jC4A>
    <xmx:V8kmauvWNHH-tPygbmV924-9h0XJld3IaFPb5994OHMyAgSwBT_KbA>
    <xmx:V8kmau7x0OX2htCV1nbf_8ZXsckR3vPoAg0V8y9X0OUNRxeF5wmMWw>
    <xmx:V8kmatTppYZ4kkukglWqaWp3Pxe_KyPjZjujss3KChCR9km_I9gSrQ>
    <xmx:V8kmam9FlnUgkcIzLSFToipN8R46aqqa96W3FGO9yoha1ew3th8JKmiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 09:53:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2188cfc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 13:53:23 +0000 (UTC)
Date: Mon, 8 Jun 2026 15:53:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/7] patch-delta: use size_t for sizes
Message-ID: <aibJTHKsmqe_EJHc@pks.im>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
 <1fd7646ca14f7ec392c85fab10255f08d0d79368.1780570273.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd7646ca14f7ec392c85fab10255f08d0d79368.1780570273.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 10:51:07AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> `patch_delta()` takes the source and delta sizes by value and writes
> back the reconstructed target size through an `unsigned long *`.  That
> datatype cannot represent a value that exceeds 4 GiB on systems where
> `unsigned long` is 32-bit (notably 64-bit Windows builds), though, even
> though the delta encoding itself, the on-disk layout, and the in-memory
> buffers happily carry such sizes. A `size_t` companion to
> `get_delta_hdr_size()`, `get_delta_hdr_size_sz()`, was introduced in
> 17fa077596 (delta, packfile: use size_t for delta header sizes,
> 2026-05-08) precisely so that `patch_delta()` could be widened without
> changing the on-the-wire decoding helper's signature.
> 
> Widen `patch_delta()`'s three size parameters to `size_t` and switch
> its internal use of `get_delta_hdr_size()` to the `_sz` variant.
> Then propagate the wider type through the callers.

Does `get_delta_hdr_size()` have any remaining callers after this patch
series? I currently only spot two such callers, and you convert both of
them in this patch.

And can we reasonably add a test case that exercises this change?

> diff --git a/packfile.c b/packfile.c
> index 89366abfe3..e202f48837 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1964,10 +1964,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>  			      (uintmax_t)curpos, p->pack_name);
>  			data = NULL;
>  		} else {
> -			unsigned long sz;
>  			data = patch_delta(base, base_size, delta_data,
> -					   delta_size, &sz);
> -			size = sz;
> +					   delta_size, &size);

Nice that we get rid of this awkward construct.

Patrick
