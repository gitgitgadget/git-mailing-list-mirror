Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9672630
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031622; cv=none; b=Xx8SbTZ0odpLThIx/kJU5pVY0mDDo4ocTYH3T5DiJq4cHDXrF6Cb4jpTJXVqgvdZp1FYfL4O43xz22Ut0169vExmLVSE36bZrxUgp2x6toAa0Tkf4hSexwp1dlw9QiXQwFwuw+BJzJMXYfEymn30uqP/FO35VLJKoUuVku2evK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031622; c=relaxed/simple;
	bh=QUrFnqaFZD8R8V8ZFJU1nJy/DuCmpRrDgoU5Gk9fBAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6x+co1gWXXLfy3cB4z9LJKrWkR2uZRd2QXt4TfAS+MAYwI5I5Z0TleQ8uswJr0I9tHK5rosmn6czmQUPctzH+DGXUnlo+8E4b4tKmpST2ee5LZ0I5y853Qf5SkRFqnaeTKQnheSna2otAf2qH5H7YF9j5u2CbhA6R9/5WzAJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qu8Um/YQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYqNAUuK; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qu8Um/YQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYqNAUuK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CAB7EC02D9;
	Mon, 21 Sep 2026 19:00:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 21 Sep 2026 19:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790031620; x=1790118020; bh=wYt34JT7cU
	GkfNybtetPOKa82VanPsADHXYCT+R/IPw=; b=Qu8Um/YQvS9mq4/doHUyICJvw0
	6UF3Q7JssJmC8DskqJF/EszyGWjApyo9CM+tOpF7ptDvVdDfGsXwZMspLU8YpZEt
	TyMep2nrd/W5A+yCS00qL7BDkvIlqfy0N2mlqVF1Ikc9MXO1lbvtFIMzFXn5i0Ee
	cwkKU2rLorOn/1H6xT2zDCHCdptGMfQF8wPvrGTkZr2tpRYD09WUE1LNhr3ueFcl
	V7J8ZtXPV7x9JC2GjE5q4FX7Qx8yetxLCpvCAslhrf+OmXhe1zNqrKK5sOWr6POM
	unVy/KqCZ6hhlwDBxL4UT/UGB9Wl7sBiNQAMow6OfBi5jVeRZgey7PV4WmYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790031620; x=1790118020; bh=wYt34JT7cUGkfNybtetPOKa82VanPsADHXY
	CT+R/IPw=; b=YYqNAUuKeWzU18ojJzIyZgxP7M7RapiK3w/OKhDCIpGhHKh9/4w
	NMz2bEvtivQC+x7y3B/K+k3Lw6AJogfmwyPdZqNV+IAlLzNdTl7bCrgz/a3iye+i
	92cCp6U1wchoyqFa+eKyVDewpudU/Z0wJKGSYqCHDSNa9XAHmu3dEDtC7qkcsmgk
	BJyIY3nVZV5jDGpUZ9Ocal9BZX5Rv9+iLtsQVN9d6kW+EeWvzmJYyg9uGbdyiO2t
	cLQgGmUG6cFiArw1YSDfQtDLGuDtxUj7/EI2Yj8R1OjIO1rzK/7il0I42Aw7359+
	dzpTB1DU4dtlnL6QTSdeSbs7EK9omvetq1Q==
X-ME-Sender: <xms:A7exajXpAxBLKovIbsaQDdgGx8ErgWEKt2Icc1oJb8asRp7hXSSaiA>
    <xme:A7exaimqOquAD3zg3uX7ghH8ZbEMGF0_mNdYc8-GU5Nm_ZkVBgdmaO0UNgOfOE1Wi
    7PAmxxCVne5MuO3I8rydN4e8KAE9JWO68FtkPMUXr4oPxp4bR7JzA>
X-ME-Received: <xmr:A7exakZXkXbQKI2oJDXVkKhIpHuS424JehbBoMFyPdBSAtoAY3w0YiCJrG5hCPiwkVDnco0PFI0nzoDFg5hN7tFP4Jhp2KG76h2W>
X-ME-Proxy-Cause: dmFkZTFThjfBYRPu3yAPCOph969Kgo9KFgOY8CNZsAQatGgbNwrSRpOaWd8D22CpCquCoI
    X91dmz9mwiF0mJEbUx8kilNeyKVFpDTkm1PKCBvlZ1UJhSh/9SleBvbFQ+L+UnU0U7DOz8
    YY2oYTlgqxAC7nzhEoKgyIplULWvS3i05+OjAT7wz+eK64P0NEH5kk4QyAPuKkKYOwL+kw
    qfwi+HNL8OEupKrowx2uxQsmXMpdmlehvBDjq5r8zeCcl2vrpKWvEhJfi87EXwVE686tCQ
    YBGPmCseai2RJFagT3a+SARXFQDxgLRMzRyLNV4s5M6bV4YITaVApPs3faqdXtzTFqUyZ6
    NYbXXWpvIpCgMemlnqkKRlbiRaqNuI2Nqpdy2QZUQl/n7ePgpZD9Eg2RYQ6HDWtX7dNw+M
    Hwh8sF12bsltd5JaDu2MVb1bakdsfStmQNVurJ2u4kWUxXJZO3NSrVNRUz2HWrPRoMBiRK
    ggOr2iSx9yTR9Y2PIZWxHLdSX+/rGL7yiinnoa0Le+fpfkIi0h96lcqRtmGvroYYRrkGJj
    eA1WGyUH7MOq0ldLAeWvZq+WkGlzdbf8s1ST8DliySIUaINgnCVN2AmIChMKzLopyQxE5r
    ZbYItgGgVnFCcjUznmYXBD8WBtVw91pMtM6HgEbUko9uhhXg+a3XAEDzKayA
X-ME-Proxy: <xmx:A7exatMa8xHNsAz_OYI_Gwxbft9vRmJL2n4i6jUP7320c9k1s2NZjQ>
    <xmx:A7exapYzYXA4dd3ugoQKm5hwLOYunBGIJIrIlzqtdIHCzdw3Y8KEuA>
    <xmx:A7exar0Imh5fRh1e5l84VH2_lQe9T09Edcn2zMa2gea0A-Y40tB60A>
    <xmx:A7exaveZlucTQcUsfxlDJ8Grvua4hwjMxzHjwm_n6wFefnk_zK5CKA>
    <xmx:BLexav4QioQo720ncDKDPlluArYrRmQdAfR7X84E1Orr_CsI_TYPtIcF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 19:00:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] object-name: explain why <ref>~N fails in a shallow clone
In-Reply-To: <CAHwyqnX77+qsstUmvvLw5Jvfdoi4V3YVagMddYxnWodHR9oq-g@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 22 Sep 2026 00:17:46 +0200")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
	<xmqq8q4uo8fx.fsf@gitster.g>
	<CAHwyqnX77+qsstUmvvLw5Jvfdoi4V3YVagMddYxnWodHR9oq-g@mail.gmail.com>
Date: Mon, 21 Sep 2026 16:00:18 -0700
Message-ID: <xmqqqzimjjlp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> It is obvious that users would see such a message when they say
>>
>>     $ git show HEAD~20
>>     $ git log HEAD~20..HEAD
>>
>> but would they see the same when
>>
>>     $ git log -20 HEAD
>>     $ git log --since=2.months HEAD
>>
>> and internally HEAD~20 fails to resolve?  Should they see the same
>> hint?
>
> But I think the 'log -20' doesn't even give an error, so where would
> we show that message?

Where?  To their terminal ;-)?

To end users, "git log -20 HEAD" that stops only after showing 2
commits is just as puzzling as, if not more puzzling than, "git show
HEAD~20" that complains "What commit are you talking about?"

At least the latter has an error message that says the commit the
user thought they gave (i.e., HEAD~20) was not interpreted as a
commit, and that might give them enough clue to remind them that
they are the responsible ones for the unexpected beahviour by
initially cloning the repository with a "--depth" option.  On the
other hand, "git log -20" that stops way before they expect it would
does not even give them such a hint.

I thought that helping that case would have much more benefit, hence
my question.


