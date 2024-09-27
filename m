Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C6136663
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727462866; cv=none; b=MLCbTc2n0kcnpffqu5YrOIjNc1blIozhxqqsZkbx1M628HREpNoq+itE/JxhTNF1o3red6UGZWEi0LqVSEPbuCoOiVyUldJm0CJYkopn32TRhals/83ZPHyv262qqmL6ygmL+cgIyVyxHjfpKGaDzsNM8/uYeNoQMcUHQ+XwRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727462866; c=relaxed/simple;
	bh=2ZLOsXpfXT93h/Csp7XsMUHvqkraWLyXlsNiJgfAtiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkRZOrNNqFXIF7Zzcya2iN9WKsBrfavuWEaTa6yuwQEjRvlTlkQNZn9fzhUpvSuLbaPHeECyHcAXFIoVCBK6WM3slSoKCAIw7a9gT+lHa+zWCvyTWmaHC5o9/B6v25+SM6ihTmRbQSS8BshyahjTz6lpj0ljgYDzPR/G4wX2G64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L0h7Aond; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCRoezmF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L0h7Aond";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCRoezmF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF79E11400A7;
	Fri, 27 Sep 2024 14:47:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 27 Sep 2024 14:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727462862;
	 x=1727549262; bh=OYwX5xbpK05R268/J5m3fZJzcDIAYuWNC+VNl/gZP2U=; b=
	L0h7AondjMIX82hLNd/h3EtAaoH2KjLBqQk4yeKSFhQQQjpBHgYrhMoshnhqzZTj
	qlwTK0iPoZJ0958Ol5OmbSQIObK/03GBwI4Iy2DZX9T3zMfjoJipIhnQn0u5Hwfb
	uPiIquvQ8EnDoPNBfy1G4NvYOyFJGG9570rQTZvwfn3KKzARww8S8wlHT+lo9a2d
	/5qwJnYqf1xtfso8Jv6T/paOWmHipwuGiDQJTymTzNoRul0yObuM7GJnfJ9kDwLf
	URrPYKTvGVZ1LKIrAJBE6GqhIRcKzuTpRggquVVpaqRDzkRG3gt7Du5XSR0q+jqP
	3Pej6SWEpdLUDBihT2fzGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727462862; x=
	1727549262; bh=OYwX5xbpK05R268/J5m3fZJzcDIAYuWNC+VNl/gZP2U=; b=q
	CRoezmFx+W/nAnmzQ0QWXwgatiEnqH2neix7sQBVvDJOh1r4z0EQkjJvvNHUmboh
	Rcp5sXHsYbcBc0BZy2W0aQ/8G/7M2P+HMZFmy5IDjfam+zSeTzfSyh9je2LFDy8w
	htgJcZQ1GTeezwxthx1WmzCCWJvoRWNHCcB2OFnvySOJDJMgCoKYcMBpec1UUYIT
	QdewWdmqzDavof1PYD+A5wfSXNFL/QIPv3+BJNG4fKG8P1FyjbZctuhBhRlQNTG/
	X8uAUsH7yH31H5voTaKvdXReRpNuHqFmv3KAX9kArPAznZjDsYgAzrgQRq0gkNls
	OkPjXQg9uLoICyxCTWzpA==
X-ME-Sender: <xms:zv32Zg4IcDl6Zc8th2PUA5MfX6kWZeWGs6PnWOn9lLtnVYL-HdYZFg>
    <xme:zv32Zh4ezvTqtU0RBA4qEknlcmZux3d5qx6qQZMbtJmOhHxr5C_HqAzmrQU3DVsvA
    qundE0tDTmy5cOtmg>
X-ME-Received: <xmr:zv32Zvce2ineojt2rVNIWogiKp2QzeXu2FouvbjtA9DZgG-eTgi84hdtn-F-3CjtIqjTxQxqJ3Q7FmepZ7ihbooZI1-JZ0bF0dPCIzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdej
    hffgkefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgr
    khhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhl
    hidrohhrghdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zv32ZlKFSMwJWDzT2vAdnPNwIzVBslXRMAP6RzeAVc3qc79IKhsurA>
    <xmx:zv32ZkI0hGJ94f8syc2FjWWBaRehc1lRaqd68eFNjyh3a4v7lIVh-w>
    <xmx:zv32Zmwo_KLwjCqAgfmRy_M5w8iSwC3zL2LnwXafjOGq4eUDcGk2IQ>
    <xmx:zv32ZoLP20-CjrS-zX8-KYw6ebO0fzI-KRNcD7qisUdlnhmogOi6OQ>
    <xmx:zv32Zj-zOjRYyn09D62M0jFP14gBUbVWX9W9nG18MnlbucnwlqsHcE2V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 14:47:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
In-Reply-To: <CAP8UFD3JzYCJf4+JLvfW_8m6kp=O0NMKi1dF1Fof9=DmvZ4u2w@mail.gmail.com>
	(Christian Couder's message of "Fri, 27 Sep 2024 10:57:36 +0200")
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
	<CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
	<xmqqy13ei819.fsf@gitster.g>
	<CAP8UFD3JzYCJf4+JLvfW_8m6kp=O0NMKi1dF1Fof9=DmvZ4u2w@mail.gmail.com>
Date: Fri, 27 Sep 2024 11:47:40 -0700
Message-ID: <xmqqcykpgchf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Sep 26, 2024 at 8:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> I'll discard this one by the end of this week unless the topic sees
>> any activity.  It looks to me that the project decided that a longer
>> term direction to adopt "clar" as the unit-tests framework, so this
>> patch would need to be written even if it were perfect in the old
>> world order anyway.
>
> Yeah, unless Ghanshyam or someone else wants to continue working on
> it, I think finishing this work should be part of the "Convert unit
> tests to use the clar testing framework" Outreachy project that
> Patrick and Phillip agreed to co-mentor. This project will only start
> next December though (supposing a good Outreachy intern is selected),
> so it's fine to discard it in the meantime.

And of course it does not have to wait until December.

If anybody wants to work on adding a unit test for oidset, they can
do so immediately.  A new unit-test, including the oidset one,
should be written using clar framework.

Thanks.
