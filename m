Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728F3264D7
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099547; cv=none; b=WNl7DyC7tuXl8VLPw0mFCrvsC67exEbIVkmB8t9bbnzm2JuzoEwxifpJasjOwrO7iEzT6F6Gs0Lqwohe+SclV4xdcMhMPRoD53CwnF68KsOB33cenQJPNo0pk945e4lzazbMTXQBh85eGqGYdNDJutZ8p1OWCGnv69Y8DroWU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099547; c=relaxed/simple;
	bh=ecCr0F2+S5+Ruw0RFc9W0PF6GsjRgRdXHHByu603Kq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aCCY5Qz3bOR9deH+p2VfvMH9w8SXgLMjxIKdfma+JZqkacPNVm4LsKekh2XVirf/DpMHm2sm1SukiSR1bi74099/L69fkXNkt6LMpC1LUyElLR163knd6EKfF1a1LEivkeqV1ffClFQVwMgz32tq8E6W09FQvn5Tbv8Zqd3gRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iuYR4ikj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmGpp6ex; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iuYR4ikj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmGpp6ex"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDF297A0249;
	Mon, 13 Apr 2026 12:59:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 12:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776099545; x=1776185945; bh=c5UZLHzLrf
	nJSldyqqd2FBq5+IrA7hbLIxU7os9+MRA=; b=iuYR4ikj2bHsbcosMGT+gTFddt
	4Av+pdEDlqku12Vr0yJmZmDVVo7M/g4AT9JyCiEUtHgVGwvhZdyCTOFTHdc0F0EN
	hFeUh4KBpHt+6M4jTh25VfDmHl4CTA2r3b1pi0sX9KKaS7/kEgc6rmFjvmFHAJvT
	c/Ki5zuC7lubwxFr+ecSvedBP6/6EKVbf8YBfSinG34m/coeb9HP3mTREw4nPWE5
	H3BNqF09GisMmYw3P0nexydRglhAlZcM3AzGk0Uu3cYu8vjmbEQFxl7/6HOjbZJt
	LAvz2r2QuByT0wTANxVXXip68eBJ5fAUQ34j/bQ6JUtqNexu2LWr5NzA1mgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776099545; x=1776185945; bh=c5UZLHzLrfnJSldyqqd2FBq5+IrA7hbLIxU
	7os9+MRA=; b=bmGpp6exmVoRXHuHkuehDpPvmcu6AKrWoNRBmwbGHgB1dq5LTH0
	VpxFhT0yWt0hDZg8i5ZwXNauF6fu5ZPdpOQzSM0l9vzlEgGdShvLlkNj/hWt736u
	dZ7W2ZpxjQrJJIeSG0BMY3X8T8208AOc/yuRiOwmud7W0nyGwyVp8E3oTFZ6CwSX
	f4InNZvkX+Ls+gNdITAfvYXSOChr4WzRIFNDYX1LGzVnf9pWYVekG06BiphqKeGu
	VARi4bD1yeIRPRdH221ZhQW1a+ehCXGSfiCAfOwJIYi18vo8g88NS2TTImtEa8Wf
	7or6TdacAG2Uz0ltAkZ3rQ9LA88acHS8apA==
X-ME-Sender: <xms:2SDdaZQ_JYyD-57mLFE0CyNCeAl5RbeCLNeX9jXcXhkashmwSGp0iQ>
    <xme:2SDdaaMBPckjAG4o3Wx-bP2sZHlCa-gRsAQm6Ig-C8kPSvxZ2K7KCXi_O36fncp4C
    M-JPjsn_hAvt1gDqROQ4aekOKTfXdIOBD1PQ28qksOspUbtNKtl4Q>
X-ME-Received: <xmr:2SDdacMsNI_5t0-H5GvR30MXBdppo2QeR3SxZPY-OWoG4Ct5OADEfRHT_j8vqHWVK26zrBF7RLmNkfLkfK09ZhfUHHBTT5fScw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:2SDdaavE_B8smLRshZscqli489dX4qcrV6zXbqZ5a6ayvP9L1z66vA>
    <xmx:2SDdaWXaVrkN2XokAEBIk2OWDpnlrPYA4bJmhffALbYSTRI1LrZk0A>
    <xmx:2SDdaSs83-e6zSCNY-KEk2m4wSJQis32J_5GFxUqJBKCOrEvryFYSg>
    <xmx:2SDdaSVKknnbbMuimQ9s7e_XOvDUQ8Bz7pukWMh63MO4-aP1YZbhaw>
    <xmx:2SDdaSX9APKZs7oKc3Y2qBUusjWfjajv98d-XNpAAqo0pTglDTpVy7nn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 12:59:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] t: prepare `git config --unset` calls for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-4-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:25 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-4-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 09:59:04 -0700
Message-ID: <xmqq4ilekd9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have a couple of calls to `git config --unset` that ultimately end up
> as no-ops as the configuration variables aren't set (anymore) in the
> first place. These calls are mostly intended to recover unconditionally
> from tests that may have executed only partially, but they'll ultimately
> fail during a normal test run.
>
> This hasn't been a problem until now as we aren't running tests with
> `set -e`. This is about to change though, so let's silence the case
> where we cannot unset the config keys.

They all look good.  A bare "unset" in the shell also can fail, and
that is where our sane_unset comes from.  It is where the "it is an
error to try unsetting a config" comes from, but given that only
small number of places we need these changes to, it wouldn't not be
worth adding "git config --sane-unset" that does not fail ;-)

Looking good.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t4032-diff-inter-hunk-context.sh | 2 +-
>  t/t7508-status.sh                  | 4 ++--
>  t/t9138-git-svn-authors-prog.sh    | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
> index bada0cbd32..c98eb6abb2 100755
> --- a/t/t4032-diff-inter-hunk-context.sh
> +++ b/t/t4032-diff-inter-hunk-context.sh
> @@ -17,7 +17,7 @@ f() {
>  
>  t() {
>  	use_config=
> -	git config --unset diff.interHunkContext
> +	git config --unset diff.interHunkContext || :
>  
>  	case $# in
>  	4) hunks=$4; cmd="diff -U$3";;
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index a5e21bf8bf..1167b835a4 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -773,8 +773,8 @@ test_expect_success TTY 'status --porcelain ignores color.status' '
>  '
>  
>  # recover unconditionally from color tests
> -git config --unset color.status
> -git config --unset color.ui
> +git config --unset color.status || :
> +git config --unset color.ui || :
>  
>  test_expect_success 'status --porcelain respects -b' '
>  
> diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
> index 784ec7fc2d..5bb38cb23a 100755
> --- a/t/t9138-git-svn-authors-prog.sh
> +++ b/t/t9138-git-svn-authors-prog.sh
> @@ -68,8 +68,8 @@ test_expect_success 'authors-file overrode authors-prog' '
>  	)
>  '
>  
> -git --git-dir=x/.git config --unset svn.authorsfile
> -git --git-dir=x/.git config --unset svn.authorsprog
> +git --git-dir=x/.git config --unset svn.authorsfile || :
> +git --git-dir=x/.git config --unset svn.authorsprog || :
>  
>  test_expect_success 'authors-prog imported user without email' '
>  	svn mkdir -m gg --username gg-hermit "$svnrepo"/gg &&
