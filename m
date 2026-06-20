Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E2349B0D
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968509; cv=none; b=bVOCoyJv6NdHLWmBWO8+60zZdwBFu5fghKq3fTmIvl29i6bICX0yhLUpYnCS3Q4DfuLv6EraxsprHYM7VOwRNiRiXR2h8c8Ni35Cn5HWVFKMFe6ZsNAmsvpOFPK0YSHPxNx2fy0TJc2AM2GyU1Opz4y1DVT0YDIthX+GUFAs/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968509; c=relaxed/simple;
	bh=NpqXCfHEbOUojad7O6BRQrKyi4/abxjhJvPzUeRhrK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sINnbgCv3BhQaFpar4XKKTvfFhe5MqK/ddVbPfDXQTzvUjrFHXL5cgjaBW8PrqWc3Bmg07W7CDIULZpBhkUnYpojsD3HxjsDUMuDN98R/yfzl1fbIfeHxKOj5emN5UPHLwc3nZNbeb0dvoV4K9jWEipBsVYLzSmOf2ib4+PmfjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UzIg1Vxe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVIcT8BD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UzIg1Vxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVIcT8BD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 26622EC0263;
	Sat, 20 Jun 2026 11:15:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 20 Jun 2026 11:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781968507; x=1782054907; bh=q3L1XTEbo+
	IQHm2OGTlLVkU1nU4KOxCSizkufasZLLo=; b=UzIg1VxeywIK+tO3XHFuOc2USK
	rqVIu+2e2JPYHqkpwv6wGmFKfd5Pv1Gxq16+cbgqxDEX4xz8LSPr/oKGFr3TR4ZT
	yrv3a/ab0CHIAihyVN98/rvNYKvuyjmNfWLeCMfOeUn+iUQ+8DbBye0q54jV/HI8
	cQDZWMcLCpXXjfgMplRSby5+0SgiQ6Cjl5mzcHepDUXd1cv32/3upHyrVR+T60HP
	su0qa8yBlWRogyQMQaBSBaePfK9R1+09OUUuzMkl6O5RyYfNe15r69iHuZ1YHKVY
	xj+ONtJ4JQg0D1uUB/4zdakFqaxkAslZjgMpgLlpCUqzLyIgDuN4ibx7nreQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781968507; x=1782054907; bh=q3L1XTEbo+IQHm2OGTlLVkU1nU4KOxCSizk
	ufasZLLo=; b=cVIcT8BDBrrCDjFjkz9XVvvipDcfTHJ1Fem90HCV8YWxKjwwote
	a7fz66m2dvhgUjzhfc2h+TMulU7llM0MM7DEpuzGtPpWzFkIGGTMe80FPZVr76P0
	8keAvb2A3UBNKsI+7gUdTReaEi55ZNtkzpBVCwemWniPl8vien20lACqTRFCZ7HV
	nM2HxgDIhBHM0+KB7oef0Uc9Bj9Cusr0AkwJOfR/nJJ248/bZHoCPyt5EYlqCPZc
	P/oXwKiKssb/z5hnWpr/j8xtyJ0jRKHjlU1OgNfVcNx0nT8J49AMlzsO94kDiH7+
	wHH/eeqkUq+bEJb77px/J2+gfeK73CzSN1g==
X-ME-Sender: <xms:eq42ag_4HLqw2hXm43cmiEzpNgh--D6Ue8bb5TZD87cw-OwK3Xe8fA>
    <xme:eq42ajEtPHy4zWNWmuPXbAmB7mttTuAaVF_faj_QsEKHfskQDN2fyVANmPMRLdSvX
    elw7UHKjYjC5eneN4hS2n5LtrZsOa5XtJSZPXgkm2fK0b3u-S0-cA>
X-ME-Received: <xmr:eq42asLjK8oJ2WR-ZELTFoZl9G54kKCtIBTo8crNweUTgz0_-nqXG9K6KH-hqULRn0YroXCEr2SvRVLuNukECdTTeR85qNqNBssOAQs>
X-ME-Proxy-Cause: dmFkZTEmBKkCHV6sqR9HSHozVwwweYtFbC2oQqOGR56tZaA7tBdJ8PUcMgvF/WXHPmcEqd
    lhYOsUUaObPUjKg+O45r9twAdygFUlB/ZqvT0W5qJgxG4FF8ilYr+VUQbpui6v9iwkemSW
    gbhnMbGXSo5Vi7IUL5XhNtQQBmvjNhjL9otBN6si5w8CRsxQbKDjmdYcGzMUaDcfL2OZ+N
    qLgq6DE6vrpAEKUofsIvSc0iIBU8KW3srIsE4X0kr0QqqoMFLVMIgW50X99yoWk7xcz8sk
    NA7BaK33/VHSfZnpzdyVEgTDnw5m7snMMREdBiMnGRt/RKPBQmkAS8L2joZCtJHk7qqkJq
    Ng7WHFPbsykmgE18eySb5JqUqYWKyuY+vLAIf+9EAbrdEfDgraDWkA05Y69uLY8rQR4KSs
    OTY3cy712FMblhgUB6CR70Xc+TAlSzeEcQtqgelg7Vc0Q/riN/jDqBvngWGu4TE2qeNcg7
    aL7gN4394L+HsN41SD5caQphpKGv2cMCC8sup67JIBOuuDkBh/pIO2xrY4QfYViEcT8cuT
    /twkZEZrV8KCIubE6q/x3nVYkyaNudd2E62u5a58Ra3UGfpdfAhZd+snWm6smKiJL1PM3k
    4jvViEzL27Zf7VrZWygvewVq/HJsctvMRK86XlQRXtbQzMhvYSLMFQVjuK3g
X-ME-Proxy: <xmx:eq42arlpj9Gw8jLYH2nZ6fV02v5bNBbrIMHD2ERIkEbis6WxiYNvnQ>
    <xmx:eq42atw-w4u7m2w1X5lrcdcQyUkdmuHTfhT8DqdFAR6UAjmJd7kXwg>
    <xmx:eq42atveFdu7YqrwbULdNGqsqfKi_dx3KRb9OT00CDklEDvM9B9SAQ>
    <xmx:eq42anEVUKtthyjkifyYyX9vFcLq5mDaohxpplFcczVgBMx3cWEPEw>
    <xmx:e642aqWeN3UFdmJLs5ZgjKYlp8z3UFrzTgQQkUpBis2LzW8H66tK-0pF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 11:15:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,
 SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
 Michael Montalbo <mmontalbo@gmail.com>,
  krka@spotify.com,
  ayu.chandekar@gmail.com,
  chandrapratap3519@gmail.com,
  christian.couder@gmail.com,
  jltobler@gmail.com,
  karthik.188@gmail.com,
  peff@peff.net,
  phillip.wood@dunelm.org.uk,
  siddharthasthana31@gmail.com,
  Kristofer Karlsson <stoansen@gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
In-Reply-To: <xmqqzf0pfefp.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	20 Jun 2026 07:56:42 -0700")
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
	<20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
	<xmqqzf0pfefp.fsf@gitster.g>
Date: Sat, 20 Jun 2026 08:15:03 -0700
Message-ID: <xmqqtsqxfdl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I _think_ this is OK, as "--graph" sets .rewrite_parents bit (as
> well as .topo_order bit) on, which makes want_ancestry() to return
> true.  Which in turn means even if -L is in effect, we will not call
> line_log_process_ranges_arbitrary_commit() that is the only source
> of side effect in this function.  Somebody needs to sanity check
> this, but we may want to leave an in-code comment to warn future
> developers not to call get_commit_action() on random commits outside
> of the normal history traversal under what condition (namely, -L
> without rewrite_parents).
>
> Even better, perhaps add
>
> 	if (revs->line_level_traverse && !want_ancestry(revs))
> 		BUG("do not call this");
>
> at the beginning of revision_has_commits_after() function, and
> describe why in the header file comment for this function below?

Having said all that, in the longer term we might be better off if
we fix the line-log code so that get_commit_action() becomes a pure
function again.

It might be a very simple change to move the "if we are doing -L and
!want_ancestry(), call the line_log_process_ranges_arbitrary_commit()"
to simplify_commit() before it calls get_commit_action(), but I
haven't thought things through.

[jc: Michael Cc'ed as there are a few topics on line-log recently
from him; SZEDER Cc'ed as his 3cb9d2b6 (line-log: more responsive,
incremental 'git log -L', 2020-05-11) introduced this side effect
there.]

In any case, this is a remote tangent that does not affect how we
want to proceed with this series ;-).
