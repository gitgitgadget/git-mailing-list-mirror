Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8242F6E3
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222544; cv=none; b=cGiVbG7jzEe8gV6zo6Z+eLpRA073Tx3w5ylIX9iK4u13LRzguVVJNgKsVMmnWIPAOhk8j7iRGjP+yNBsKKbojsq/tcHysYgkMAjiu5nxbgBoSgJg2FtIJZSXf1cVi2OflRXUKtG2S6QCa2QWssn3egZcl8m4ArkWOKbEBTabQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222544; c=relaxed/simple;
	bh=XobiEQFbwkxMeunJLVUFOkSFeDHFeMgGNpMuj35EYIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=igG6u5z32e/sBXZaNcIX2iSFZgD0DiTMYdxVN06FXC1eQ/Lu4+M4Zj0KV6iZLQeFhXz2qvVvhMfm/rPAJhkZxxTjLIq+ZvrinmcjGeQM/7oxgUQtNUDzeDGMsIoqwqUzKz5CzZhJoTVJspX5j5uc/drzKYJ6bqtn0ohqYH7hdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iRZZX98f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDZ3VeXQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iRZZX98f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDZ3VeXQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2965714000E3;
	Thu, 16 Jul 2026 13:22:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 13:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784222542; x=1784308942; bh=hMzH+f2V6d
	lNiUHjliKZmKXSlWhVG758n1Rq1Um3kgM=; b=iRZZX98ft/VVYtmW7SPIQ9am0d
	f017SetK+uhZzaSm9jJKhT2Zc04EfurnHX75jf+UMNq8ustGA8wxjkXezVFk1h4P
	rfjraF6Qm37f3M054YnzqpRO81PENDFrlW49tZrxEPOXrNnLvWK0pHRndvjwzMOi
	Z+1jxBX8oVFano84iaT9MBus5rdf+8Ek1ouacq3IQOJzwgxrHvQLyNyvLkYdCAtH
	xzH0FLDuo2I3ldlbSliRPyOLjB/X54LZXlrg9pt3b2C9yUQXGwVsnkmfY3WPs/Sj
	nM7kcQkIOUju2t9DfJyP7cwmPuhDYTvmf26kDs1EUXzxnHOdjYveyBsS+pqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784222542; x=1784308942; bh=hMzH+f2V6dlNiUHjliKZmKXSlWhVG758n1R
	q1Um3kgM=; b=cDZ3VeXQuHSy2fbQVByis1qjicYxxeoin6Seax6PnNKCn7JVH0V
	VpXAWn1GgL1dzbhWzQm2oxKPmVSxEMr4rRPl0xaVj78QIQvblLinx0PoRTiW6VLg
	L6KZPGCmrGbnJzBKFG0iu/zHgsCpT+mMtR4OTBW/4m0Fe1jWu3ToA+WmVsnn3TwT
	a5yOa9h/TLoX0w8mqlteQLaOz9SOvTDzi6mxNK9wVKGzyW3GM+I62SyTCExHimnd
	8P9CaWDARwWxojUCWTX7WN5zYkvVpT+9GDCr8oVNEDQHt3QucZwR0n6hr2GPrXeP
	CKulmT5YV+xLuMP7XHfg4vRr0J6pMAnjueA==
X-ME-Sender: <xms:ThNZatNmmRqURuQ0XlVxjLa_DWrPK53eYf9Fq8ysx3C76NKo3xvOEg>
    <xme:ThNZam8aZU2bFxZ0jlSeutH0gurBr8JNpmQqDAW81cH6iSKplervST47V6bBlsGsS
    zax2V9RonoyfZDkEoqxu4ccMiwchKExxjlPnBB7umv-JUFaQ0WREQ>
X-ME-Received: <xmr:ThNZahQJCtjPJU9-UyFeUGfHFEi5VxcZEYqahz8moz2LM1nRL7EpWm0bUSMjMnAoROSNpADFLAR_k4E5X9CSD_Aw6MjbUPkanHb3QMQ>
X-ME-Proxy-Cause: dmFkZTGT79yhFgBAIumeD5LHtrUL8hDk6Jk6PhRI9FKOSklI3EMUWJrEK6MrII3PtII0J2
    gcmQXjgECwDTf5omJWJHfwBVHUkm2uvTcR/El2mQdwoCzrB9iIv6q1z46dZDV5EMlZa+EK
    ZJoYspCCFWpjV3BdOeq6NSzUQ8mkTdDASKGt8xRLF1v7YExJ2ytnz9GUFD412EosqUthe8
    cog44ny1KfkBllTfoho4frnINOv+y9bWu8AEsZsUi+BPDMGJ90+Ns4lx91+4TV+vZB7thN
    vKlN4EmdEw6RklIl7uf4ZU0fYeT6tergT/zhUVLybn9OC1/pNwfidwoIH7g8r0EwjEFQLd
    iyoqvc8FGWTxVyHPliaFSiCjnpNhz2gOQd68UWmd5+04fic9S+VLLgssbfvDr8Kn7/Nk3M
    4qLLVv/8MbRrZGBEuO0oYOnmoYjwB/WEunmGIK3LLk67UYJWhE3BsQEMKNQxwCZVRTAj4q
    2T2hblqrjmMWo7ygc09tVCuXPsdI+J0QoqzZDHJZqHAqHPbZJqXP/kHbZniRYrxJpj3H8h
    pq0yHnwQqKAWQ8XYOuQ6lQv07tmM6RmvYST21BbwX4us/foh8jf3/JFBMKkX5fd7V0uaTW
    XTha3T2I/2pVU5wt7c+rZgotsBgnZ9G/BfPbyP24aoJSQ/LmtnaRvmf8mJQA
X-ME-Proxy: <xmx:ThNZaonj_Y-yfRJGwzIzgrK2BjnUjRK9ct56GRdOUyteHre5wGAXog>
    <xmx:ThNZahQtFKfmx3HGK6gBsS3fXJkQV40oQl4Y5eHhBsWX9lLWyhiVFA>
    <xmx:ThNZamN3HXk34tL-36RPA2_OOnTZ-rUguQBUgTUPiAezvl0Sa_xRBg>
    <xmx:ThNZaqXa_Xt6IkcnOzO222OybtojAMB2uqEGrKjsbWm0ZhCQn3ahcw>
    <xmx:ThNZakzQl4JoCwMXLKFxD3wcU4B0_iH7hAIUBBUL62Z-I6TW_qBdh3VU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 13:22:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 3/3] bisect: add --auto-reset to leave when done
In-Reply-To: <a9194b1d00b260a7a7852eccec54c872618b5fdf.1784180159.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 16 Jul 2026
	05:35:59 +0000")
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<a9194b1d00b260a7a7852eccec54c872618b5fdf.1784180159.git.gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 10:22:20 -0700
Message-ID: <xmqqse5ihmsz.fsf@gitster.g>
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
> When a bisection finished, "git bisect" reported the first bad commit
> but left the session active until "git bisect reset" was run by hand.

If this gives an observation of the behavior of the current code,
please write it in the present tense.

> Add an "--auto-reset" option, accepted by both "git bisect start" and
> "git bisect run", that resets as soon as the first bad commit is found,
> returning to the commit checked out before "git bisect start". The flag
> is persisted in a BISECT_AUTO_RESET state file and the restoring
> checkout is done quietly.

I often find myself, after the culprit is found, running 'git
reset --hard' or 'git bisect reset' to jump to the problematic
commit to investigate further.  If '--auto-reset' leaves me
checked out on that bad commit, that would be a very welcome
change.  If it only returns me to where I started before the
bisection, well, 'Meh'.
