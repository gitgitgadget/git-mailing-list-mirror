Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD0371899
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437890; cv=none; b=TESoW4f6Wr2aIW1boLyHQ111B39vezNhTKzZ2c1MQ6xPiZXQIwtZEuVeVLi4urOdkKXlD5DjnmR0v9fBbmju3PtpXA0S9Q7igPzxKT+vZYK/lzyyhpf2775TA8O//V65hkgixeCHyqaYKnq6xpVpKmIb59ROyMu4TlIRXehGrnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437890; c=relaxed/simple;
	bh=xBnUaleAtVWveqVmeSp7lLGB274f7/5XDLT+tFLp1RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfr48urY/7MakTqFbQUGzyurtN5tmUPOspniiBYYAojL7WFkUgDlSI3evlDHwpBp11IEsOjIS7hdVYrO6usSosA6wDS/RaE+vkOf1eCUJukFKw0yLTUIVAr911/98nqWiZUK3JkwDi7aPVKGnPpsBusFWykDbQc34N2fBM+OfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JBQOOtkE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hW9e46Ni; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JBQOOtkE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hW9e46Ni"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F9CE1400134;
	Tue,  7 Jul 2026 11:24:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 11:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783437888; x=1783524288; bh=MuvH72CPMg
	hh4np1Z9/jXKMwLtVZsQGj53CSmEG3s4s=; b=JBQOOtkE6f1GojI9YimQ+PUbx9
	MusFYoGbxflpk3Jyycy/n9fNiKKxouwLMNHHdO/DUlCDszlzftVdTLYDf0g59Ttp
	5mzUhlRhvCJ8xip4DOHy19dDirHYIUJAhkJry7tlRqN9KIYa5BShPCTYhjky82bt
	raL3PiHIQ5TaQukcNPE78blCBjf2EYwZrlriLntlfM47TnRZKcdXmUHDAs9V/siw
	8+z9SIjewlJcY+BI4sVyLFu4VMor7nAFqSh0pWIu8qwXPqm6X1CdEFURvlCdqOk6
	HXxBJjULqMfe6gyUm+YzQeo69DYpf9VL3Rtk/SEAP+B/+rmtzhuw5JGMJeQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783437888; x=1783524288; bh=MuvH72CPMghh4np1Z9/jXKMwLtVZsQGj53C
	SmEG3s4s=; b=hW9e46NiUKQA4Fnomll3/4TmvD0blWh+dTkxcoEfl01EhpaN9JQ
	+/BPVA6k1XScZ+qp9zmpGJYbQnwcM66aJBcAbAyRTa43XLgVut6BsBNoAZgmhWR9
	huut+s4hNZIChysJ4s8DgQK3sJasbV6FYtzA/FlRDhRXgAxmYDTVKksaQFNopClS
	lhHtJP9sCJX3RoiJogQ2P7wBu3PT3T78jSWWuYl5i6UAGJuD3gidrSUl4LSdy4gu
	cks5f+HNG/XfZjYtgDlm0jXfity/vU9MGm6QAATs5H5PpGWvm+9/VIgSyeBrDz3p
	vymJax7xu66m/2xkCZB2ZZXQfeY5knV/ntw==
X-ME-Sender: <xms:QBpNalp3rI7WNYNyojdXRM5j0X2aF4Dj8Owl9jOMsPZxCDaCyftcEw>
    <xme:QBpNavGkc3fkiMZjx9OR8OpuFJoH1sTB-h6-BEDs8pgcWSL9RgCNPnuL_7Moh48_9
    JLsiTt6nSiVM_HW8serLtJ2O-xWt7RpTZPcZgG49e5ocFJ6WBpI-A>
X-ME-Received: <xmr:QBpNavnIFwPWFWF58sygQ0FmFYVUHOA3XwQZfVwPrr3napLGdjZYLkfYgOgekSOpyFgBmPwmZ93-ngF4my_2gDUyDwTU6z8EfujSOPbscA>
X-ME-Proxy-Cause: dmFkZTGTmrTfx+dntehQBGZQ0ligB7wD9zdTKvSFJj15QaY8MMTd/HmExCjfUu/4sCNyu/
    g6Pkcm3ixLjYnnaWqplFasObNejY9qpsxJ4K0XATMC706LOxmK0NnMnYZmIvHURCP2F+/U
    wntgk8ctjyPTsSBszoJJTekI3wujIUOzf8ULPqe9VHAq8Gm7NQeifG9HAvMdPHxwdxevPV
    vcgcSRQHxDXpShaa5OlVDPokNvvmQWTrgqSUt5+rJcUDIJ+PfSK8dpGtadiwAdva9PJaNj
    so5F83g3gIK/kiM2BuGT5GElcOgOnlIfRn9HuI2mnV7xap1fe7xwnFclbOtk0ppje065Fw
    nMIhGLt4urwN7dbSB4IiX3ovo33+t+xmQ9tj3LdSNsEf5i5SG4hy1klU3wDmPS60fJordw
    KK2lMs9iXH0OdBhK4/IqEStt/dV3LqZ/EqSFPUADm8/9QsFElwvo9+0OLrQMQ6CUg0kxMo
    CWjqbGsiHmW9oHHanLu8jCzl7gabjmr777bghgs6wVNjgj37tmoZsO9A9OhrV81XBnCyj+
    2BFNSV8qUd0tCw2Z78cj8lTKz20F+xle9pRdcXb8iQKcQTENS+wRfq1Yvh0lJFKrmgOwTm
    7P+GVKoOrn4nj9zfNHES/00cdG1EwkXCGxEX2uc7SNUI0Fx0kUmKP34q+G7g
X-ME-Proxy: <xmx:QBpNaqnLBsx0Go6BwfbLJsX5kuGDSuQxrG7e47rPKyi5QrWJYMJoMw>
    <xmx:QBpNaosIDLKvArAAUsdN6AIXb66ki0-FqSB-v9v4pHXSc-OcuFpl-A>
    <xmx:QBpNalkGghNOboZUmSBoq4lYGIIUh-mi66LExG6Fln9js6X-9Ck1oA>
    <xmx:QBpNaruz75U8YIegkWjGVdNdMq-qMIRm5i3LAUIi8K7mNSklp2UbLQ>
    <xmx:QBpNaqXShb9TWJ567oKOaTrg05ayTSOxGmm4vv7J4ZY4uoP6nTuGONjz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 11:24:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed3f0e63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 15:24:45 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:24:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/2] t: add tests for ref tombstone scenarios
Message-ID: <ak0aNrBpuo7ZwZ2k@pks.im>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <d8ffdcb4f8c1988c109761ddb9daff8c07caa2b1.1783344957.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ffdcb4f8c1988c109761ddb9daff8c07caa2b1.1783344957.git.gitgitgadget@gmail.com>

On Mon, Jul 06, 2026 at 01:35:55PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/t/perf/p1401-ref-store-tombstones.sh b/t/perf/p1401-ref-store-tombstones.sh
> new file mode 100755
> index 0000000000..e40a6dcbf4
> --- /dev/null
> +++ b/t/perf/p1401-ref-store-tombstones.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +
> +test_description="Tests performance of ref operations with many tombstones"
> +
> +. ./perf-lib.sh
> +
> +test_expect_success "setup" '
> +	git init --ref-format=reftable repo &&
> +	blob=$(echo foo | git -C repo hash-object -w --stdin) &&
> +	for i in $(test_seq 8000)
> +	do
> +		printf "create refs/tags/tag-%d %s\n" "$i" "$blob" ||
> +		return 1
> +	done >repo/input &&
> +	git -C repo update-ref --stdin <repo/input &&
> +	git -C repo for-each-ref --format="delete %(refname)" |
> +	git -C repo update-ref --stdin
> +'
> +
> +test_perf "recreate refs after mass delete" '
> +	git -C repo update-ref --stdin <repo/input &&
> +	git -C repo for-each-ref --format="delete %(refname)" |
> +	git -C repo update-ref --stdin
> +'

You're not only benchmarking the reference recreation, but also their
deletion. If I'm not misreading things, then you can queue cleanups via
`test_when_finished`, and these calls will not be measured.

> +test_expect_success "setup asymmetric" '
> +	for i in $(test_seq 8000)
> +	do
> +		printf "create refs/tags/old-%d %s\n" "$i" "$blob" ||
> +		return 1
> +	done >repo/input-old &&
> +	sed "s/old-/new-/" <repo/input-old >repo/input-new &&
> +	git -C repo update-ref --stdin <repo/input-old &&
> +	git -C repo for-each-ref --format="delete %(refname)" |
> +	git -C repo update-ref --stdin
> +'

Would it make sense to use separate repositories? Otherwise, state from
the preceding benchmark(s) will impact subsequent ones.

> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index e19e036898..4b7cfe38e4 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -1163,4 +1163,26 @@ test_expect_success 'writes do not persist peeled value for invalid tags' '
>  	)
>  '
>  
> +test_expect_success 'delete and re-create refs with tombstones' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_commit -C repo A &&
> +	A=$(git -C repo rev-parse HEAD) &&
> +	cat >input <<-EOF &&
> +	create refs/tags/a $A
> +	create refs/tags/b $A
> +	create refs/tags/c $A
> +	EOF
> +	git -C repo update-ref --stdin <input &&
> +
> +	# delete all tags, leaving tombstones
> +	git -C repo for-each-ref --format="delete %(refname)" refs/tags/ |
> +	git -C repo update-ref --stdin &&
> +
> +	# re-create the same refs and verify they are visible
> +	git -C repo update-ref --stdin <input &&
> +	git -C repo tag -l >actual &&
> +	test_line_count = 3 actual
> +'

I wonder whether this test really adds any value. We probably have lots
of tests already that test creation/deletion of references.

Patrick
