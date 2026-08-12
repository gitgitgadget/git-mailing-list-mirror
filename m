Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59038E8BA
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555457; cv=none; b=QesT6uNPHz2eygtw/13NOPvWoySf/inSPIO+kWNlu3UcJjfDlklYqkeiSsialvWbm1O2AzUjC/mPsxcQy/k2eOfGg0i9zqLgZ+/pZ5eePy/IJGKuB5lMpdXS12wYXTbQ0pSKDsPGMz152Fh174iEFzg/n4Zd0ORTPJ6i9iAZFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555457; c=relaxed/simple;
	bh=VWHFSnA9UzUQRuZ9QcAlEkxauTvxJxdmqi4uSEIv+1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WN5N/WAoETUgCcIIUhsjJ4q6H1lO5edh15syj77I71ICohyofrvBWYv/u7wAsNJgfEF3Ill3PA+QKQkaciWdmVXyu6Mp8PYKsShmyJU2LHDsOIImZ2+dBFWs3sCK95SMBkVXuRRdBuApYuDT1GCgGyCxepaGzoJPZAM95da1FCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=THq+2ppR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5F8LYLO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="THq+2ppR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5F8LYLO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 24E47EC0248;
	Wed, 12 Aug 2026 13:24:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 13:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786555455; x=1786641855; bh=gq5lVbQZZv
	vMTiIiiGje72QcPwicNlluei/zPAIFZf8=; b=THq+2ppRiEEwGDzddJLCJj4Xa4
	cq9lepyADXKfhqkbR/e+ygeU8YAWSI0S0ImjqB8q7hQB1QHNu5/grNpQTIynQG5b
	qr7wD6QetEqrDI0VPYqSMaANAQWRLEN64TyyCR1fqWobN7n8sfegjatquVmuAto3
	4hKExaOLpgUkvCFlETyfpgusquqUxyo2OHEAOLhmNF5Q0f96fKHxcYFIZiZTUb4w
	E7jxaTkigO79u8qMBJID4I/+mivF9dKq+nkVSuDyhvpYh2adI37DghwxIJxYzJSQ
	Zk1s/NrqG6RaWx2Cj6x7t7bynHNCHxKjeVdteoU4W6vnslwUhCfc2EdP6Fpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786555455; x=1786641855; bh=gq5lVbQZZvvMTiIiiGje72QcPwicNlluei/
	zPAIFZf8=; b=Q5F8LYLOTrchP7mTWIqtD4xWbC71lUs6v+FOyonlyWq7h7Qb1EC
	vDxNIFGntAwR1t8D5yINqW9c6M5Hdvi05YU0gjKAwyxzsGK1nrdbl97se4+rYAHM
	fLtL3kAkiGhjKSLGOIqZOyPnaAxHMoo88u3r4I0oKo8L2TO3Iixn+Mv4wxxP1VEt
	jEEBOzvWEJVN2oLbOhpLGdnp/HzCrt8/54oinxTqYIvSuaPcB7+Qud0rmRqcgDuZ
	gBr2RFYp3zaCofl+H+UGInCk/Ut6VT+5kYZMi4Upczzs+K1Y5Au72YT0Q+RDg96R
	zMKYp9plFDY1/Bohev4wcH8BnEy28SAgtaQ==
X-ME-Sender: <xms:P6x8apl_8SEr7LM7q88toh5OT_jW--ZGdig-W9BWlh2JlXjCtLxDqQ>
    <xme:P6x8ar2KsR6JSpXnS_0gg0Z2JPdIQvk2ZMXTMoYk0BQEIZ1vOkGGTWjkS9RBvLiPv
    xA27rXmvUjtVMKVqvKHPmfvHTf1w_PwT3q3PbrY7ccNSnuTXV4a3E8>
X-ME-Received: <xmr:P6x8akruY84pPvoB6aig9uJcDPlx1CloxaDg7DRWcISTn3UiWT_kl14artcshs0q6D47RiwF1hxCgxJRsjiqi2pqOWERXQGCvg>
X-ME-Proxy-Cause: dmFkZTEPp56guMwFBSl2w7r8BQQhED+BMOp1sFGJsbTNp713tNC1aCCKRYFU6ncUeuEdri
    2fFOgmU/t0kf0PRjZ674X438Bn0cjLvuvOQbHOu7W/o9Re1EpBH1ZQkkSdVJW2LQr6Ys5o
    eIXajv3gEL6ETIX6Wl4YcdK1Mvy6heLcHtyZwDqnnp2IS63ogWwJTkVviOt/V9Fo0Ms5t9
    nMAEJ5wgVPvFmRc0beK2i6W++tb0K/Z5q2n6927yQD/SoaboPb8rCXs6D0BnL/0AUUJaJh
    VXr8nhdYVHAzrGfXI2E/Ru9EkfHD4Jt9f/QocqxgqgaQ1KpsRrm6zir9hDAf226k71jhav
    74mjSlQb+F1kKrGRHOKoMuaDlhU7a1GqICVKhs9Q20tZSuKPzClOs3pybySOd721YX73Bg
    kSlKakfcHL1VAobMoiiNP1h+H0Hp9K7KurSY7E5bdMGt5dH2TnLrmxqGbrL8HEIz3pOdx7
    5XZkUyn29GAHOq2RP5diYmpA5Xo8IaXF5i95IfzkZUPPUg6AtTAVYbWj+BDKSVVLnuVV5u
    FS1SzRwkyoTv9UBkQ9X/lnyOk4RaeJhnNu6BAyAJG37TtOO0SYiR/jZJ3my+iXjToiW0Ps
    hrcFMKa33KHVTUGQeVbSs0ArXt6s9wHEXFgV6Jsm6BND+1+wBp/M4RK9b7mw
X-ME-Proxy: <xmx:P6x8aof_-lmXmQCsKyH1wWC62CKgaBtio4SJ5arcJwaOgxUkzr35LQ>
    <xmx:P6x8ajpMJyEQsDPNT1gFEYRpXGEjK_Wk885amSDuaKekPyWNp4IXgg>
    <xmx:P6x8apHeRUyzxEmWcVij1OEsGALM9YHyOZy7pDc9WLDlCKv6ljUUZQ>
    <xmx:P6x8ajsdTbM6guefkqCDL-fb4tgoNXIiZoo16iRYoZ6zQu6Wo_tkPQ>
    <xmx:P6x8ahE8S5IlSzNCI8AC_xMtiFeI59jDFB8TfYEw7XbyPPUfwlDkUPAR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:24:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: remove unnecessary variable setting
In-Reply-To: <pull.1922.git.1786516959130.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 12 Aug 2026 06:42:38
	+0000")
References: <pull.1922.git.1786516959130.gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 10:24:13 -0700
Message-ID: <xmqqa4qrxneq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> revs.pretty_given is only ever read in builtin/log.c, and nothing from
> builtin/log.c is ever called from sequencer.c.  So setting this variable
> cannot do anything.

Thanks.  I'll mark the topic for 'next'.

> This was introduced in commit 62db524779 ("rebase -i: generate the
> script via rebase--helper", 2017-07-14), which used `git rev-list` even
> though its commit message describes the logic as having been based on
> `git log`.  Because of this, I am guessing this line was copied or
> ported from part of builtin/log.c without recognizing that this line was
> not doing anything and could be removed.
>
> It's certainly not doing anything now, though, so remove it.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     sequencer: remove unnecessary variable setting
>     
>     Random thing I noticed a few years ago, I believe while investigating
>     our tangled web of revision fields and parsing. Either way, it's still
>     valid and I'm finally sending it upstream.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1922%2Fnewren%2Fsequencer-remove-unnecessary-setting-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1922/newren/sequencer-remove-unnecessary-setting-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1922
>
>  sequencer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 83c3849205..a0abcc69ce 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6277,7 +6277,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
>  	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
>  	revs.topo_order = 1;
>  
> -	revs.pretty_given = 1;
>  	repo_config_get_string(the_repository, "rebase.instructionFormat", &format);
>  	if (!format || !*format) {
>  		free(format);
>
> base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
