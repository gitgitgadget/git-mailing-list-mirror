Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886742BC58
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061909; cv=none; b=btYjOBbHRf05XmurLqaFVwwVGYrjUn/AM4XYrkE4oMgHZyBB3fCbBKou0E34BK91OhxLM4/s0S6jxMwHt600sWyW/m3Kexg71s2oqtI0gcdE0k7CCWcWGPmdDgIwehkghI5yvRfJEwUKOjwBAJI7GNOUxQWpAcowtXrpOPgzJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061909; c=relaxed/simple;
	bh=nzQ5pZ6E+KylD/HeswZhgvJJJ50tVtZr+ebLEIrt+tE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jB9neWlmLGIbROv6y56PJ6mC+CToWRyasVM6NLsIbh8UzPhZVYQMx1wxzUmyeT05aj9L5drcGh+gzN0O/qZY+z0wP34Ya6DwN/06cyQGkByRn9CnZfbZtgNgtEslB+nXqviupDwnICcbzenrPqA3SV43jhcIub8f08EAr+ZLUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SCOQV6RL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEjDDANS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SCOQV6RL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEjDDANS"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id DC79FEC0116;
	Tue, 14 Jul 2026 16:45:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 14 Jul 2026 16:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784061906;
	 x=1784148306; bh=hpUC+ZkqPL7x+nzf3USNqtFHDGHkSWmQ2ft3GayWp+0=; b=
	SCOQV6RLRsepLArg8lBwMCUeZD6JChcs8o4ypwmSGBEpQIfBYJUyGRGMQH9uxFNe
	V4M74Ro/bsVYF1E/7SqW4eQA6qlVRsrpzbDMAfYYQHk9IXpOELeFff5M96VlWQzF
	nhNlKHcG363Pe+3aNAeYHU5e2+EGA+V7qc/JpsEKF6beJh04qVU5EQlF0IZC2kdV
	8scIuqzQLc6X6R5V43JC5uXbMBIo0jWI8rjBuePsQcCJYlHZXPg6aT1IXAjIv1xZ
	4i6VlbW7zyGJVsaRMxJQcxf8Fhb5OweZXkEJrmJmhfhVl+gR4vjSMCwLTbaAlJAq
	HgHCx33kcechKpPYRA+AYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784061906; x=
	1784148306; bh=hpUC+ZkqPL7x+nzf3USNqtFHDGHkSWmQ2ft3GayWp+0=; b=D
	EjDDANSu/I5z1ZvNPmxtbflcdBTA0cfFgVfRny3NjA3Pq/jGSBNa+IvOCWO1uaWI
	qpgSpFjVee9m2qyHEQ3Dpw/vOXpPR0MLQKPwBaURRo48qNwjAC+P1PNiRvNYPirc
	OxOHTbvO9KdvqcPz/Bn/tA/2v8rJJa8mLzyU9fEE4iOVIMhWMg1ovRr3eZTvdkMK
	9FNbYAgDBHl+GyKMZ8h7M4DIFcNhpjQh9C4N65paOd/v0ofrG1KN/xuYVFJVzMt/
	oBDy+H0iD0OjdWmpg9ruoOEt5DRNm1jNOXlL7MKyVT4ng8fCH4OACxrOE5rlCIXo
	vRwgg+X5r5DscWMjD9pQg==
X-ME-Sender: <xms:0p9Wap55Gr4324cchylmp8SF4Rku5YCamaf2qDgl17KdzMVovsCAow>
    <xme:0p9WauWzA45q0h1ERi8l_PBboCODpE_0B1ad6YPGDOlbEfHnqK5ikWRXGIOmH13NN
    QwOAbFfIP8H_U1uYpDAxfc96nv9czhacA3QOIJw6tPRlgS-n1PRE4M>
X-ME-Received: <xmr:0p9Wat1ezWwa9w5QBdXsSrET-4QqrSeSPQFtT3Ki0VA8J-2AbKN39asJVFgGpv3Vl0tJb_f5xhjVtty6df00_E9kJ1rE8ItljadBgaM>
X-ME-Proxy-Cause: dmFkZTEg16wEBidHMT+fcLYdX4CdYqOcqmvtnMhJif4wwrN+vfy2gjnBCMJa2okd6vrdUe
    qQhVWn+rnkLkArae1a19WLpmvfNk1zwdXXKaDBpMGqIC0Y349EoY6zpken/c8XPPZ868bD
    jozZYkeqS2StkBuDwF0AMPKzQrKgwl4BTxb5j6QAuqfSEOI51VALtuw6k19QrU7X4i2R/8
    bt0WJwLdowXPzinb9VpOes6NYhJHGvEhp1RPoOZ2qB2v4WIyL2b4+oVLKS+XztU92dubHL
    V6P9a0HBj9JhUgegbuJnAACyoNE6yxJf98109Uha2MbmIQUML3RPS/G15iNRb7UyXdnzRW
    myGPGuoHlc6r6u2Zis8QfWJ8WSBu3bZZBXxuJtz2EoN2knVUSsfUfR+xm3hySDy4tg2DbB
    MAvzgUVPCbu8aQXyNtx/oZWBhkcxdniypE2ra82V8FkewW5dn/TsEFpHpkqQfaOySdfnkt
    I2+EhxUPB2irfSyFfDYvlmljw1hTKsR66Nz2XAZxRtgKD215S5ZqelCmHW7pOzvGftXf/f
    kkq/EjjKgkI6qo2SEos8RNkXpkQu8IZvsoDb569vUjkzLoKjZjrJfxn0ycz3Lna8AFV4fD
    +H76zvo+Qw6cEIil/2ZjcU0wWtDBMMfQjHTa+kB3x65gRlpNnZE9huH+o3aQ
X-ME-Proxy: <xmx:0p9War11MtlIsR2v65CHWZbvvShpB1_CLQ_MU_AFqp7rweBXl-vylw>
    <xmx:0p9Wag9r4aqFHDSaVRozCjO6oQPNtJKr0mDIUj_QNXU54sRS5gRm5g>
    <xmx:0p9Wao2QjwYkS4VreBAmHdez4dzwUaP2zrSznp6UneYowmxpjTY44g>
    <xmx:0p9Wat9Dzrzn3GMA5uh-rFtsUQIKnqKtQsmPP0ZomAF0j8b3v4sgBA>
    <xmx:0p9Wai_z3c4UdHLGzu6XCdgeAkCZzh2bVEQ5OkDwjxLPPidyjQ8-rK7z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 16:45:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] tempfile: stop using the_repository
In-Reply-To: <20260714175956.54601-1-l.s.r@web.de> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message
	of "Tue, 14 Jul 2026 19:59:51 +0200")
References: <20260714175956.54601-1-l.s.r@web.de>
Date: Tue, 14 Jul 2026 13:45:02 -0700
Message-ID: <xmqq8q7ds3ld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> create_tempfile_mode() and create_tempfile() use the_repository
> internally to call adjust_shared_perm().  Expose that dependency and
> push it out to their callers.
>
> Patch 5 is a bonus; it converts lockfile users that already work with
> other repositories.
>
>   tempfile: add repo_create_tempfile{,_mode}()
>   refs/packed: use repo_create_tempfile()
>   lockfile: add repo_hold_lock_file_for_update{,_timeout}{,_mode}()
>   tempfile: stop using the_repository
>   use repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos



Will queue.  If I have a chance I may revisit the topic a bit
deeper, but nothing stood out as glaringly wrong to my cursory
reading so far.

Thanks.

>
>  apply.c                   | 10 ++++++----
>  builtin/difftool.c        |  2 +-
>  builtin/gc.c              |  2 +-
>  builtin/history.c         |  2 +-
>  builtin/sparse-checkout.c |  3 ++-
>  bundle.c                  |  4 ++--
>  commit-graph.c            |  9 +++++----
>  config.c                  |  4 ++--
>  lockfile.c                | 30 ++++++++++++++++++++++--------
>  lockfile.h                | 31 +++++++++++++++++++++++++++++++
>  loose.c                   |  6 ++++--
>  midx-write.c              |  7 ++++---
>  odb/source-files.c        |  3 ++-
>  refs/files-backend.c      | 10 ++++++----
>  refs/packed-backend.c     |  9 ++++-----
>  refs/packed-backend.h     |  2 +-
>  repack-midx.c             |  3 ++-
>  repository.c              |  2 +-
>  rerere.c                  |  6 +++---
>  tempfile.c                |  7 +++----
>  tempfile.h                | 10 +++++++---
>  21 files changed, 110 insertions(+), 52 deletions(-)
