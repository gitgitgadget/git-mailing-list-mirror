Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6334B1A7
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396173; cv=none; b=B6pp3H3bCFQJUP+xASLaRjufDks3HOpm0Za+/tg/badHIIfhJBSTmGhCoKKT/XkoMwJh+YJCvADpIRwY9AzephwhlI5b4+PbjaoWeTlNy9qIYvysCU7uvvvaWur0m8mt/JzaEJCWdjGnxGkAsUtnPdk2YeEOn+teDCSQKlnttjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396173; c=relaxed/simple;
	bh=1XcOcOSuGZeYvIrF2dGb10Bj79VWMFia1e0sB/4CCrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aev6skfAn1W2l58QW/JecL0hLtIdNUNIUuq2A4G+h+w3fWcaEmEbRm/m59kSUP7zl58/ut7EoTy251Y4IUVOv8vT1LWULT3KkVIvaMPNR7/gfVdVMxel+DJd3av6lpr702KiSRmPmbUZOGLB8CknsMeI3BqzV66rMW92cPTSCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZtDZUGwo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZXZPX5y; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZtDZUGwo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZXZPX5y"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36226140015D;
	Mon, 10 Aug 2026 17:09:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 17:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786396170; x=1786482570; bh=5uuN4C4ZOj
	C/XZtP46DDikQcFGd7k7DWbz0tbxWosLc=; b=ZtDZUGwosYGHQMF5bKWyGWhVUw
	KNgAnkpySn7+6RMNr1YoOQgpPMWLI48HqxQChsDSa/EQSK0dWg47PnbjtwwX4kxY
	jeYLQhhLzT97KAq+5Jw+BIulkty6pakkPOHoXcHRwmgFwjEVVY55rcJiLk157Kfl
	sdqx5YyNjbNd6CbX3I2Cc6joKXP//fxBYG1Ki4Dt4qTkN9gZcc2vhAL3Rc+RjYPW
	KMzNZ6lR75vY2j3jEwpuXaFarEYW1/tiKMEq2aphQJxfsdOSAcjsgKcHaaYN1jTH
	4IjgOZURd8vDNqd2nwCKTM8dw1m0+fJySlIBMYVNQToM66AhmURb8ISuSrsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786396170; x=1786482570; bh=5uuN4C4ZOjC/XZtP46DDikQcFGd7k7DWbz0
	tbxWosLc=; b=mZXZPX5ypWJ+lS397U5w0k9MCkf+HWdnBNKA+LgEPqXEJmHY37l
	R9+rzcb6OrDrN2vZh2It8XvtSdrqFYW52hjcYKp4mqRmBuXh//sBoqTAq9u/I/SG
	xhNoL2pkWEulkwngGXd6J+mHfrSLPMnmD5WMHYLKhtXKVm6wSDUWBsdIGr2KlB+P
	9+q0GCISLow4HSxbyMmIZDlFaVJNkYe1gpaK1mU3TRWOwMucz+pSuTTAOnGigbG3
	mz4KBy3djXpaYem5ZSYBiey66LW3s7tUrHNwfWxwFgW7gStIIUiniHVCFyb4swG5
	3fNwWVnmN2zP7kB1jgy33C6SjSU2wppFABA==
X-ME-Sender: <xms:Cj56atoJ8cX-bkjfWeGVqltWNZlRw4KNBjTrEVtyebkTuTEfiIXjQA>
    <xme:Cj56amrOoVpEJgnhbUzBJyCGVjh8AWimMePWIEJtSh3gR9aLnSAal9vtEch90q_1J
    W_kncKbuCDhqxMRrJQ1p1XMNlN2zO7kZjiuY0deetDpWpdjqa7C5A>
X-ME-Received: <xmr:Cj56avMs-pkSq_De8jwLm_MnngCD7XS4E8BA5TMXKtbeG7EwsCv9F4E-4ePcIq7P0_4fKUz_4qhABzFnNnzlfq6CJIAaTO6NFA>
X-ME-Proxy-Cause: dmFkZTEx5LhtjbndhgFw+bB1iJbXxv/mR/nFJkjz7e5o7JX0LraoAmmA1bq2umju14Nj5R
    71vVSzqtah5L8P4kyJ3w+sOVQo966H5wFIcFnzS6yDeAhy9a7xliPVpGS5eZeLQST8SFFf
    syc7bMVsCWwOz/QWeNTCe6JUv+A2fkcq661O7lLLDonYUh4q/cnzG7WXyvTX6wiOs6yrQj
    njzsQR2S3fBlkh/MWczzy1NJHCvpyJquCUU71HPku2xoikT5H3rW8i5LjzkFZb8VKohTWN
    +FpQ0l3LRa0vGY4rzvqVmUToXZxe95Vy7OAmbWJIl85vtFVYw+T8MJ+dwezjut+BV7RVa9
    mb62rEV/2ud17h9MKRdUvRF+tI+lzjIDggQKGyWuujfLaMGuaWf0YQJwpq6HQ01Q/p576L
    3GbLlNrpQRSwr/YqOU33mERRbIx4iPAVlcVwShrdfXpCxdbVsKaW27CpYt2KkSiy/8np3r
    WB5cxlF11gdS3rmU57E7ppUmaYhB4Ag6vsaSV04g6nTbg6fN5lDyidii9Ka+rfSLlYgKSa
    /dH85B4oRK32eLJWvQgszeiBBTIiSDPwI0Yyz+8B8A8Rg/PD9RIgKcMK5Xnc1Mz0UMdMk0
    D+o1x6O7BF1xAHWakRz0bAvDMt6hw5yQqmVq+nb9zzA90FxVGSIgoVGKYKPQ
X-ME-Proxy: <xmx:Cj56anyDC1cBQgMjF6gapLxuAeyPvZ5GovhrgW7A5rDfAdySHjI9ow>
    <xmx:Cj56aouZmdNKD-pgI0uZXDPo1pkWuC9xi6iVrEgJs4E_ZBAdSuPBVw>
    <xmx:Cj56ag6QE33waTkPA7Ay4OqomUaBB8Ae2sRnRoJ35yjSj4p5ayapnQ>
    <xmx:Cj56anT9k00Dd03XkCf7lK0ZzAR5H8dd7ScsEczXCXbzXSZqRc0YTw>
    <xmx:Cj56auvgaBdanr7AJZNPtjfNPEyRFHloJhHlLqDDGcqzdvJzudhs4qSZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 17:09:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] send-email: clarify missing subject error
In-Reply-To: <pull.2375.v2.git.git.1786384412423.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 10 Aug 2026
	17:53:32 +0000")
References: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com>
	<pull.2375.v2.git.git.1786384412423.gitgitgadget@gmail.com>
Date: Mon, 10 Aug 2026 14:09:28 -0700
Message-ID: <xmqqtsp165tj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success $PREREQ 'missing subject omits Perl location' '
> +	cat >no-subject.patch <<-\EOF &&
> +	This is the body.
> +	EOF
> +	test_must_fail git send-email \
> +		--dry-run \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		no-subject.patch 2>actual &&
> +	cat >expect <<-\EOF &&
> +	No '\''Subject:'\'' line in '\''no-subject.patch'\''
> +	EOF

OK.  We require the message to exactly be this one (not starting
with this substring), which makes sure we are not getting the line
numbers from die.  Good.

Will queue.  This round looks perfect.  Let's mark it for 'next'.

Thanks.
