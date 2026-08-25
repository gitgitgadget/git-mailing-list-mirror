Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6C3A718D
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690098; cv=none; b=dN5BzXMNTUENbSRe/Pwl0yAfYncjJrtWnjvgb1fWh/Ts55F92xsNNjLhFO0yumTwYR18k8CndDWmnkx6wK3C1DzU5xEy5bMT85/0MtyU2taN5zrc6/vPJF1UMCMs9NEuoHYcKAgys5NablpteUyKVsq8jLq0Nq+sMlFhtKtOTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690098; c=relaxed/simple;
	bh=dgh7tQwbKSkSul5leU8NUf5gQL2QEUhuGUEv4sufyd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=esxoF8AZLIktZ3rLFrE9/1Oh2BlRjQifLtuBdYVnhof7VhR8wQgaFlMKxmM2G34J8khCwJlUOIImbLijqfii23lcMau+zL37Zl+YDPYe4YkA/zp3wb04OEMW26YkJzwuJQ5Go66GqhndwK0sDZCd9TaKSMWdBhPUn1/gbzGSg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pUv5S7nv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Psgvk/i9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pUv5S7nv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Psgvk/i9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C5155EC006E;
	Tue, 25 Aug 2026 16:34:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 25 Aug 2026 16:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787690095; x=1787776495; bh=2KR/eXrVYo
	e/A/+np2bwurOtaZGytCftO3WVux2zLUk=; b=pUv5S7nvlHkTVbDqzwH1PrseEm
	tHA/gq3RrptQ0CAEiNahXu0Lyibcx+T1ZBEnTH/nf7PMUu9sNhIEoPLf0V8XLU6P
	urmQjhWZcMlvhwwfZq4qZEFAnsR8OFGJPKulP/mIjfO6EsOI4P67fBVAPZOvV4us
	rRAxLQgRyENC4gkFUP0/S/7e0qJ4pCBOZIepgdLtQwfEln4s/H2bljS60EIg3JK1
	mlROZDrc6vRMNCjlXfqxsBsgNXR3HbBzTd/+ddWwcdsvDXGIcCr5TqZCDNc//pq0
	VMOiJ99Fw6GziVdjiPjTaPHW+42eJfQtyATkO6/Va5FylThtoK8zYNMI63IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787690095; x=1787776495; bh=2KR/eXrVYoe/A/+np2bwurOtaZGytCftO3W
	Vux2zLUk=; b=Psgvk/i9BaTocT1xYjjabLw2j9OEnDmEXrIN1/GA9aFlg+iQSC1
	Dk7RWs8kesbAqUz/qQauaDV/xoBU4ACEFG5nDF0PEwMats4NnZktOIVk8Kx2zvAm
	16vDuZea7DzIzTiM1eN05Hpry+5reEGf6DSDtproApjTHJX7VB5czH0Wcyg03Gjd
	LV7LkAlzBXwgBjbn5fGnoppnU7JYNBg/9j79tu39osuvCtgFXx0Uu2K6T4EwhzQV
	pFgpe6Wd6J988Rk88x76zzcprdGUlzuFs3DlrfHGC9mlbYtBbY3AT/oQZi3sWAbU
	dwJq4eBuzJpg/APv2hEiCm1vrQtivMp8Uog==
X-ME-Sender: <xms:b_yNakWdCScyAsOirNby0J5NHF3VjyqnRHoDhlUGtZ7JnH7gvKSOSA>
    <xme:b_yNavfaLC9g9TANK7BID43OqzeOzv9kFDGTOtKyxZbrhhlEDxUYkwsvat_z_ggV2
    P2LYhlEqluRMryUWwBbgYMNTD1ra9EAxHxB05z1Bz3XK68u-DkwWw>
X-ME-Received: <xmr:b_yNagu4mRO9T8_Yd-6ReKPwozmbRoiH9JZA_9A38XbQzcn6zg2sZ0qTMT2-GJ19h5QvXbgQAZNBgEwLeKL_3ymWiyQUNm6K8g>
X-ME-Proxy-Cause: dmFkZTGM6+df23KpaoRmvA29+TT7xAHByWF2CKp9N44xaGtV9s4z9MprFCEv64LWjC6gxH
    HgOH5ZB9NLMowhg99CZZ7Zjl2PpUaneUPdfGcl6yGWO+vwiG+IjCQDVkCglGToWO+uTk6+
    hYC4KbReU0XJARGALOlR/EDFKfU4tIDQZLMVtDbFY9wwUeuUJrcBLQZoaXtho1MK24ELbv
    zY8nnSjKCwAFyDq7p6cJ/Fe/1JdHVX/WjDnvMXuBIbCCc+MS4TAAnp++siGGjeyfJmhDQ/
    4VghzUZU3qNJx3+pQTD19QNskKOXUEMb+XatzZ0O7hbxqpMa7t9o5a/hGP2Z3eW8Yw4XkU
    NEChaI2nSVtut3eH+0J+LD8eDOZDmHyXcglqhUqw5nWE2BnGrwqy0aMwJ/Qogm9Xqevw7W
    IhH4GaekamQO9a4I8c4iTwyW2rsihiWZhd00DsN/bN8Dzjx/oSItIRNVlPs8LhNDlBuCaw
    KLrVy9htdJYCOGs1M1N+FNb4Qn+YgWPn7hGOW5bAv18/Tw/qhpJvZsGTpo5fgk9MTAjj4r
    HkyXyv7/9ShFMwvddJlqoDvKPesW2oQme+U2fRHrz7J5NSfynd+UfB0PsUi+qy9vA1E6Jt
    CG50maHGGJnS06RFzDR6ac930XCnKpe4mNpliKqe8dZzPclUvZ0GIlHIxNbg
X-ME-Proxy: <xmx:b_yNau9oki1f2nSCN1wfjC6O3atvDogGw2-DzseURQW7kOxqDeUyfA>
    <xmx:b_yNar0kByWcA34SYXHY_rQFD9ePJfVGmO1baQZxuM4KV3GAAUjNQA>
    <xmx:b_yNajDMRPf5i0Ri8l85cz4-c54cTf0Yd9IW1WH8YRDDyPZrZCecng>
    <xmx:b_yNandYN0r78iWYsMUFfIvzqeQlx8D34QRZnR9zxrr6Ch3RGsYpNw>
    <xmx:b_yNarfM4RHQ2xyKaBu2yN--1ipCQdpbj0T2c7r9lJ0LZv3K3oTDH_cU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 16:34:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <ttaylorr@openai.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 1/7] banned-die: create header for banning of functions
In-Reply-To: <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 25 Aug 2026
	18:56:15 +0000")
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
	<84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 13:34:53 -0700
Message-ID: <xmqqh5kikkgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> We have universally-banned functions listed in banned.h since
> c8af66ab8ad (automatically ban strcpy(), 2018-07-26), but some layers of
> the code should be more strict than others.
>
> One such example is the trace2 API which runs during atexit() and can
> prove to cause die()-handler recursion problems if it calls die().
>
> Create a new banned-die.h header file that will ban some Git methods
> that call die(). Include that in all trace2 API implementation files.
> This currently only bans die() itself, and that was already not used.
>
> It would be reasonable to name this file trace2/tr2_banned.h to be
> specific to the trace2 API, but it seems like such a restriction would
> be valuable to put in some other areas of the code, so adding it at the
> root of the tree seems like a good long-term approach.

In other words, the functions banned by including this file are not
listed because they are banned from being used in trace2 API, but
because they may lead to die().  There may be some other traits that
we might want to avoid in certain subset of our code, and we may
have similar banned-frotz.h header to prevent direct or indirect use
of frotz.  Which makes sense to me.

Would the same approach work for the_hash_algo and the_repository, I
wonder?

