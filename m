Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F9336ED1
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959480; cv=pass; b=NBXbom4oqNm/BujssEZvMuDzhxyFKxLUfTga6qQzOCwuI30+0yEZy6zK2yV9jCLDFduzshSJF2sf5HVylKycpu7Kuc3jLuiHf5pQy/qIst+/bOlt1muEJotjuinPtiz+gN+TrnvE1JxuL1My1Bm7PxUrd6gc8kmj/M/tzmYI3uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959480; c=relaxed/simple;
	bh=KufPV2JN3ABOcJySw1Q2YBwQkhrD4CtbWKkxeNXRmZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=duA5OtIzkwKQUGqTmSlYtscWWXYfZcwyrjQVy+abCXpWcfxNcxUw2ZoflpFZCb+V5kcKGmsQYkpk0gaEGooSLa+MMxr8hJ60dZkW13f/alHw100iVBM2fBoH2ye2Aj++s6jVYIjBB67PLFwe1F1b0DhyVCOXYG4O/PrP+uJHehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=MRImS2Ga; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="MRImS2Ga"
ARC-Seal: i=1; a=rsa-sha256; t=1765959461; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SY/wTO3ArTHIrR4naxZUu1UyztMyJLwK9vfMQgYFO881tUv1FX6p2aK70rsRhLPA0GDKemUBJrZ4846XrUqoxy8Q/iH1cZ9pSUZoPm53EOQ0oW8P9CoeOSCQ63VsPtJv1d5ZySu7oqPpkllYLH/DVs5vYOwdskjxkre+iMQ3SbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765959461; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=alLpwT5VANFgZiH+ZH4bsw3OZeQm0/wDtqOBvDfWrzU=; 
	b=GPBQVM5G+p/Sc1/XLbUv9kMiS5FRHbhztGEaCbtHCeCy/oKvFPrRIxzexn+p0Ct2nCMePZxeuvL6ua57zKxKbDD2Qx15Gs9Yi7dSr01CcBI0j0Ahm1ZKg7YaE3pkgHXa88wMtd9BVGJFkvXyZ7vQGPGC9lwWFqm7yCDx79OEs1U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765959461;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=alLpwT5VANFgZiH+ZH4bsw3OZeQm0/wDtqOBvDfWrzU=;
	b=MRImS2GaVfKEozejyIJl1/5Y1t7bBd5w87AsEopbnQSbPBrXlYjpv+5aJTanBY6f
	2Y7ykkZ3zg+eL7jRc2/occXNGNVnbXcmSeovA2NhhD3orpGFywGv8o7a7iqGYG8e/Br
	sohbTcRv9f0l1ouj03nYTtZN3LPiwd7vDZcQUqc8=
Received: by mx.zohomail.com with SMTPS id 1765959460064815.4596330954465;
	Wed, 17 Dec 2025 00:17:40 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/10] Add submodulePathConfig extension and gitdir
 encoding
In-Reply-To: <dymehf7vjf6winlsezdzbdiboo7d74wezoopwkyc67ckra7oe2@5ruvpsgjpbea>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <dymehf7vjf6winlsezdzbdiboo7d74wezoopwkyc67ckra7oe2@5ruvpsgjpbea>
Date: Wed, 17 Dec 2025 10:17:33 +0200
Message-ID: <87bjjxed42.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Josh Steadmon <steadmon@google.com> wrote:
> On 2025.12.13 10:08, Adrian Ratiu wrote:
>> Hello everyone,
>> 
>> For those new to the series, we're implementing a submodule gitdir
>> extension which allows us to have a unified way to determine gitdirs
>> and do things like encode submodule paths to avoid FS conflicts.
>
> I'm afraid I've gotten a bit lost with this series. IIUC, we no longer
> try to encode submodule gitdirs by default, instead we do this only if
> we detect a conflict with an existing gitdir. However, in all of my
> local testing, I have been unable to produce a conflict that triggers
> this encoding. Instead, everything hits the error:
>   "fatal: A git directory for 'nested%2fsub' is found locally with remote(s):"
> from `builtin/submodule--helper.c:3389`.
>
> This happens regardless of the setting of
> `extensions.submodulepathconfig` in either the repo's local config, or
> my user config.
>
> My testing setup has been as follows:
> * Using our locally-built Git with our downstream patch of [1] included:
>   * create a repo "sub"
>   * create a repo "super"
>   * In "super":
>     * mkdir nested
>     * git submodule add ../sub nested/sub
>     * Verify that the submodule's gitdir is .git/modules/nested%2fsub
> * Using a build of git from upstream `next` plus this series:
>   * git config set --global extensions.submodulepathconfig true
>   * git clone --recurse-submodules super super2
>   * create a repo "nested%2fsub"
>   * In "super2":
>     * git submodule add ../nested%2fsub
>
> At this point I'd expect the collision detection / encoding to take
> effect, but instead I get the error listed above.

This is a good test case, thanks, I will add something very similar to
t7425-submodule-gitdir-path-extension.sh in v7.

Please wait for v7, where I will fix the global config, then you can
retry the steps above.

Just one important thing to look out for:

Existing submodules will _not_ get their submodule.<name>.gitdir
automatically created when enabling the extension, so you will get
errors like "gitdir does not exist" after enabling the extension.

Those are expected and I assume you already got errors like those.

The gitdirs can be created manually, for example:
git config submodule.<name>.gitdir .git/modules/<name>

Or they can all be created automatically:
git submodule--helper migrate-gitdir-configs

When running the migration command in a repo containing submodules, it
will also enable the extension in the super repo config, in addition to
creating all the submodule gitdirs configs, so running just that single
command should be enough.

Hope this all makes sense and happy to answer any questions,
Adrian
