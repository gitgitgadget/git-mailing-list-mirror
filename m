Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C038359A66
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781908033; cv=none; b=rZeP8ycyBsRCzO+nk7Tu+RSYURp6wJcr1ug5ZUu65uGun7Vb8YrFbm9M6LOa+G51YdMffZ+3e2wniZspORIDqJ5eK2fTOlfXKUYrkTj9GWMFPSmY2sgnY5Dlu152pK2xt9BygsJpJw+ejnawouK3Ow2uq9n07GrbyNHbtr91YhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781908033; c=relaxed/simple;
	bh=DOK5EfS5quit7u9SvPARhVPbcDhkQN0J76CBT/XbOqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rs64rP5+OPVIrfVqIdM+XTMMYSba3/yZQrHNnMa+YRxvidDB5zwUkgVK8m3zd0iIz3DtRMQelvVU4encsJq3qAZwH6MQWF9LMgmNvFI9T5ZjdqnPV0eiRN42C9zQHg0aB24/9a2PWvjaup17EEtgnJEBW9iLyjSaoWbT3kAeMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f9dOX0uP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTF8VvKP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f9dOX0uP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTF8VvKP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 693567A00C5;
	Fri, 19 Jun 2026 18:27:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 19 Jun 2026 18:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781908030; x=1781994430; bh=b4bY04dWVD
	3oi8ZMZJCFkD6NIWtI0zG1UnGGQ4ZIj1o=; b=f9dOX0uPpKgW9cEYuoOlBX0Br0
	jz5fUBDrgnt9pQ43eGOyiTxjc1IgPHRiFq1ndvzLBRWSGfUQe9o+SYpUNcw5tBW6
	ju9eBUul9/nC/quws1YuRv+Ttb5APxbPM5zm+8ewkxRIUOZN2DekQVlKGQlPwqSt
	Usn/xyWLzRLtHL1tZs81GxLWjD0+vn28h9LagbRYYkV1HvhqJaRjc/B3+8EvQd5g
	dJ7kzqCK/T+uLsZMdkeef2GLKoruHx4WxUfEAWlnRGTCIwimvApxg6neL09NWFDQ
	twEA+Y/kuEYfbSLrVzwATtSldRgUjQ9OcUS9m+2D4XvLaj4J7zXDFRrFL/eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781908030; x=1781994430; bh=b4bY04dWVD3oi8ZMZJCFkD6NIWtI0zG1UnG
	GQ4ZIj1o=; b=MTF8VvKPYQt1k0bno4HB5sEIrxnyQGPsRut31GEFQJZBH81G2Pa
	8WLbKcZsW+4vCgwlV6DcLMe8RT3GNyOx5KrG9MSio6frYNwNvOTFF8i0C3/ADJID
	2FWiNIj5V6kf+UxQKEm/pQ9cHNxaduewgxZJ8/PBJH+YNs+s4HdwklTZExHNhlyR
	wx2oWpdPlArPjBpJreTz4COAVPNKAaVGTDmJpUjAF7JfJiaHZGCw5AuI/vOIhj2L
	Vp3R7jA7HiVhqFVjSulmypWK3NAJoY0oaviB8EGTDEZ3n0b1wSMVCPFweZsrIy0M
	9wadyJHxrAXYmGKFEfXZ4iovyPw6gI0T2fw==
X-ME-Sender: <xms:PsI1ajt4gW48n77jT9DHwWHwajxzyrX1Z4Cy1eSC4jayfFAn4kTTcQ>
    <xme:PsI1arfzt8IwIRXKZ5UJ7sELr_PwbeN3cMCgDBOGPX-TAalaOJjgLVDNzC68atSf2
    9IbYjJQTlxtU4yqRY2Oii6M3jTvg6JnJm9bO6Kf9zKoL_6F8QGJVw>
X-ME-Received: <xmr:PsI1arw85_nzqFx7cRzTpk8sDQOuzxcGzOF0l1rJ4LWTe9uxYc91xF46UDX_0EoBNzJDuN0wSNkD4oTLo2-_BkWpiFksRr3DJcMz>
X-ME-Proxy-Cause: dmFkZTEzvzWKELHeV6stpPkACWQn7pGHy3dmD5R9i8Bnw2CjmgbVsb0EVTF3QmJ+hzBiB4
    xFq5yAUAXOo13viImSQWJfzwaSPUOQVYTCJ0P7klosivWKRQmR2yXTyV1g8jINIeMRgKpG
    kDFp1pFa+DS6WN1RsQbtvRybr1ICl2jbqo5DMX4SoXI6iKk6+4cKdOecIr5oyHFiIZA1AV
    0ZYEMg0dr3KyEDih26qwPCtyT/3xV3USaKSqeGUoQ+NVbekc7m1p+oDK+fl/ivyRL2+kiQ
    omRBhtwwpoNHIRj+qs6R9phtLqWwQ2CPIPM064Z7C/hZ2/eW7o6jOBYeLh5zwl4JTaZhQ7
    P7NLprrTJfW5fSQV0ht2MKwNnktED8A2OasBRcsYRU+Mc6tw4sozHYQ1WsHaKFbFFV3Qb3
    wN2Ls+kDQlYoDuhVJwtL/14d/h3tTl4J25gTVOoe01MgUSK4uC7xS37fm9puNhNTxLYIoJ
    i+SrXNhP1VJEko5E8q4iJOzQM9LKODudCm07N5wz1JN9WwcsT3BWv86AR1HQpVdmOhcju+
    eMi9E3PEytSoa/CP6FPofmqaZLAllD0Zv1FifHm9awU1gDH/9S0bfq3psf60RiGn/jGGq8
    e2dlq/sPqsDnXFhskN25geQ1NKDjq1QMcH7Ue0SYn4P7/WM4Xfus8AijXZrw
X-ME-Proxy: <xmx:PsI1ahHSdQZHWV3-pl1Tx01elg0HOuzeLGv3sFdBTfNZxHuOIpVBvw>
    <xmx:PsI1avzs0q3jdLXMoCuwuTKiQfUqvuWH1_dpnbIrJkNRgWPx55zQWA>
    <xmx:PsI1aiudn9JW1yHKoEcsQ-DrMfogqS7fN3hQam1-PaR_12EXy1zLdg>
    <xmx:PsI1as2gucpffaIz5PbznBRIKgzfOD-CL1NV79DzAQgy_tIF3wI65A>
    <xmx:PsI1avQl89wQl6BTfizqc_kXFtZpTcSOh03HlSoVydPSEg-q8pXQnXJb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 18:27:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] config.mak.uname: avoid macOS dup-library warning
In-Reply-To: <pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 19 Jun 2026
	20:32:07 +0000")
References: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
	<pull.2314.v3.git.git.1781901127385.gitgitgadget@gmail.com>
Date: Fri, 19 Jun 2026 15:27:08 -0700
Message-ID: <xmqqv7bei2tf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Building on macOS with Xcode 15 or newer emits:
>
>     ld: warning: ignoring duplicate libraries: 'libgit.a',
>     'target/release/libgitcore.a'
>
> Some link recipes list the same archive twice, which is harmless.
> Quiet the warning instead.
>
> Pass -Wl,-no_warn_duplicate_libraries on Xcode 15 and newer, whose
> linkers added both the warning and the suppression flag (ld64-907
> and dyld-1009). Earlier linkers reject the flag, so gate on the
> linker version. Broaden the existing -fno-common version probe to
> also match the "ld64-NNN" and "dyld-NNN" forms Xcode 15 reports.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

Yeah, this looks like what I expected.

A few things to note.

 * Can folks with different versions of Xcode (or is 15 sufficiently
   old that practically nobody is expected to have anything older?)
   test this patch?

 * We only patch Makefile here; can folks who use meson report how
   well your build goes?

Thanks.

>  config.mak.uname | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 8719e09f66..9ebd240378 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -173,8 +173,15 @@ ifeq ($(uname_S),Darwin)
>  		NEEDS_GOOD_LIBICONV = UnfortunatelyYes
>          endif
>  
> -	# Silence Xcode 16.3+ linker warning about __DATA,__common alignment.
> -	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:ld-\([0-9]*\).*/\1/p')
> +	# ld reports "PROJECT:{ld,ld64,dyld}-NNN", match any of the three.
> +	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:[^ ]*-\([0-9][0-9]*\).*/\1/p')
> +
> +	# Silence the Xcode 15+ warning about archives listed more than once.
> +        ifeq ($(shell test -n "$(LD_MAJOR_VERSION)" && test "$(LD_MAJOR_VERSION)" -ge 907 && echo 1),1)
> +		BASIC_LDFLAGS += -Wl,-no_warn_duplicate_libraries
> +        endif
> +
> +	# Silence the Xcode 16.3+ warning about __DATA,__common alignment.
>          ifeq ($(shell test -n "$(LD_MAJOR_VERSION)" && test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
>  		BASIC_CFLAGS += -fno-common
>          endif
>
> base-commit: 95e20213faefeb95df29277c58ac1980ab68f701
