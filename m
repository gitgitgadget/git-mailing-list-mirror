Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C3198831
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722643; cv=none; b=tAbY3cG/I3ikzzZKYtYgDHAM2qkgDYWAKHGIjG+P47n2jqmRsgFh03heUnaRGZH60LcB9tRI/LIqUcdq5OW+qfl17+q5OuLFFoERba0CqX4h0B71mxQJbhnMSQjRahYHt05TB+U6L5/AXfn3obS85guMW5WZvx5lX5VcHmHuR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722643; c=relaxed/simple;
	bh=f+VI/fmr8Ahf1KHV9b3St0QyFsXxQIBUJNEsxcGsvtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IZtXBAdkEKLtStI6elxOm6jfqel7oUsitkK8uDGUqOVf+kvpeKgsJpc0avOaZ4+cclO5GBZtjyse/3RKeSaRwHulO67P7bCDTImZQ4adSiQGzZQIjxvBsPsMuX1qhySTMEIShKhRzylyUUMzPmGGCk+OEWfFSAPkrW7zo6g1CXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H4RsKmbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iLMHqlsX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H4RsKmbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iLMHqlsX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CF1E11403F6;
	Mon, 30 Sep 2024 14:57:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 30 Sep 2024 14:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727722641; x=1727809041; bh=PINSufw12V
	jlNoKyM3FFRZv72nXtj36EcYrGy6JswdU=; b=H4RsKmbLQM5PD/QDtpPDW7FQaR
	Ub3iSJYhpppYz2fxgU3FVCJwEwhCmGgU0Lujp55WmpIX5mhN8PBNWv2XRXD1jkHy
	zcFkW0GINXh5vL+8Sa3fs9CVhw8zKmBcRkblaEJzDHpuq3taM5HohzdVUHlbLVMT
	semvwMpsJXffmHNS0OH1v76YAfKozq3Vh5FAc8oKql+6e2uICfhWB1JjW8yEzsD1
	PumL+VshiOWg27EytIJuWAKPCM/QWopjPVSpkMk3oY5MoYTOdyK1xiUgnB5fLppA
	0YNb4viDRkj+GqhPbaDmkI5lGedioBVCrZLn1ZrznPwcBav0/mKu/UAEkTmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727722641; x=1727809041; bh=PINSufw12VjlNoKyM3FFRZv72nXt
	j36EcYrGy6JswdU=; b=iLMHqlsXUUErsKk3cZs1pUDwf8MfAcYz6HW29u+uHD2s
	RTfy6iFI578X0A7dU2IISkkSuYCuWOkF932FgaP4dyM5PuO9kYvBnvgl4iN12d89
	8Q1+uEg45oS1h+9AfrLmBJCD2jj3TH2EcQPnVDU3pmH/CuWqoamFoyZ32YH7fsXA
	/G5PH4pul2d24TsX4U0FTfZ5Mh4JLWWveoTieJ4qIshY7ttv+WrTOWle3YcqUoq/
	G69nAWjz+oY2wIguJ2yi8PIx2ZRo9FTyVoTN6h55aF/YrgXE/uOXoHPvG2tkhjwI
	Yrq9ugLoY7FY74J6EZnv+MJD1QtXJqpG4yBL/TV7ng==
X-ME-Sender: <xms:kfT6ZjamdxRo7_Hj1SKRvZTxmeIsH7lhZxrV_hXOZY5u9pNKW0eVrQ>
    <xme:kfT6ZiZlBIxa2Yue0wOdVfOKATUXKnYqUa45S385zwK7ApjzoZoNk_rU6UtXggekH
    kMOS9olRTLPw0DFvQ>
X-ME-Received: <xmr:kfT6Zl-NJ7vwirpvONdJPblnliicdkt42zGLF-d3RrwPtrEk6780PyG8nCrN0Kby0jlZijk_HbQfjIvtmCo-QX9IacHzpOZ5prvjcGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:kfT6Zpr3UTNml_E7NjZYmdl9naxnb6YNG2a_7z5lWLvcCXO7R9X6eg>
    <xmx:kfT6ZuqMlohTrWQdLD70xDe_LauOJ3x2AARyqeYCybjzyQIFHOkTWA>
    <xmx:kfT6ZvTXUr8rzojWa67hxxYpNS4K--dz0ql9_gvtAvP5KvKeJWBIEg>
    <xmx:kfT6Zmq82AOplUW1_yeM-A_n-K6hoJGy9KpBkKq7Gu8DD5RgtEjNHg>
    <xmx:kfT6ZrD1JD8NSeVtZW58SzjeQGKN4cAKeUFax5nS9ZVhYxSlE0OTYqUV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 14:57:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v5 0/9] add ref content check for files backend
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux> (shejialuo@gmail.com's message of
	"Sun, 29 Sep 2024 15:13:18 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <Zvj-DgHqtC30KjJe@ArchLinux>
Date: Mon, 30 Sep 2024 11:57:19 -0700
Message-ID: <xmqqikud6kc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> Because I do not sync the upstream for a long time. For this series, I
> sync the latest upstream and generate the patch, it is based on
>
>   3857aae53f (Git 2.47-rc0, 2024-09-25)

Does this help to reduce conflicts when merging the topic to say
'next' or 'seen'?  If so, such a rebase and noting it in the cover
letter message, like you just did, is very much appreciated.

If not, please don't ;-).

> And I don't think range-diff is useful, it is messy for the reviewers.
> Actually, there are not so many logic changes in this new version.

OK, so this needs a fresh full review.  Thanks.
