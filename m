Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D21C36
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856014; cv=none; b=g1nHlcsdYNz1Nni7E8GMvciVr2FFdsFYCWRizqpkmRrQ6MKGMuh3cQUjBjQXByNYnYQN1N1oTT9Zi9wtuq7LXe7FZYQl3RwQ2ydCX9JBE+MxGtl+jI8KWkWsyfDNXVrs/XKZv6NGIbTdwNmrM+wEBzou6vmZDsngRWpESC7T5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856014; c=relaxed/simple;
	bh=jIepiLAGcOZhNiab+c3L1HetX7RZBNs9vEzEjx3BcJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6JA6KLYf/z1vjoN0HLqm6wn4MFw+90/L1rdrp3wRBoZwCxvcjMWvYEdTA0WXodifjpv6Dkb8V4G1LBY7Y1MJ+3rCa+Pq0jY9soKu7IyGHeV1RgOgBHCsgkyV6TraPju0UGG5OMKSS/fsBGsCVTVZMUwH6cDY4boM7jaO9FrfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NJShXg2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvzMcApd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NJShXg2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvzMcApd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3F9B7A0051;
	Fri, 18 Jul 2025 12:26:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 18 Jul 2025 12:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752856010;
	 x=1752942410; bh=WrZOkqcPkkWFuQfxmHliB3/uWsWVMTFjLXQ2i4y9oPQ=; b=
	NJShXg2sSBJXmTUpeUjaURKceD1eCMN2WRWxKlPEpW7/IGEEEIvG3DgF0YlXD1hy
	ON2U47SjoNLMnT5bbCVf/OI8Z6xXu/GAhDodK0K0zrL9ohN0ePivIInkjM+z/S2G
	d/T/VHZfUdwhUWqxLIGXnWqAqmnfTdpKLUh3fafIKc85URUy2Wynsqqn+zCLhIof
	WZpzQXdZwjFXTi+4VaNIRZDDmCAE2ySgBmTOireA4DGsywaHwyQsdlmKJx3z0fdt
	QvfWPqxTkOd9skuuqJSGuRijNyXuN5Cc2TQtt/xsrc9jSg4zRWE0ZQtB0toNHEQE
	fM++TZkXPSve4are8qgcMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752856010; x=
	1752942410; bh=WrZOkqcPkkWFuQfxmHliB3/uWsWVMTFjLXQ2i4y9oPQ=; b=c
	vzMcApdufz7/rzD10QDDDA1HkSiKseGpfYozQNf/PLXGHTEQD6UMSzjMPB69Shpq
	wIY9FwkJ8jprq0GxPF0BASoBmtMWBpq7zlfD+zOEYSNZiKVVgnh3sJ0Rx7xRqUr6
	bYfUjREQ5uZfqnNWGm1DOjjDBP1SPJw5j8N6pbB2YeFIvHwkvP8DQ36dd+41IpQ1
	F5bZgbRAH2TOVrfa47WZx3wgSwmbetbXDVkvRqMjhYn7BmclRVfp2KPvoUk1UPsv
	lnmz1vPwswFk15ren9KgA+prm6orRcJw85goIzJVM48H9JjvavHKBPb1GarxrlZU
	bmarWu23Wv+i+lfUVw30w==
X-ME-Sender: <xms:yXV6aCMF5qIsZKwcd7n8Nx1Sdb2_SM5kXV_K7g-v5eTyIqzcCAPBeg>
    <xme:yXV6aJb8lGMq9Ud66lRYftvzpjmPJNCG1gWfHK9YI1LkCJVsD9Cor-Efwf3Bm8lpQ
    VWJNB5K5zPglxitPA>
X-ME-Received: <xmr:yXV6aJu_kxNN1i0AlaBqTx6j3Q0HstJ-MedQ_YQiV2Nz8TkHffoyok-OGVg2-BtbTNlQZdMDY_rFrbSR553iXifo6JnRmy1tr4lO46E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yXV6aDOmZ4c2oPydBSX3Fn1gFzyfeW5W0DK7ePL-RoiTh84wSEdqmQ>
    <xmx:yXV6aI60p8YoqFzrVneGXXcBt5mPIZSl6ntE2nWzLLzQ5wLC72ciPg>
    <xmx:yXV6aBTrj-brElfP01TNJcmut7DR7ihU7tcx9PTru3SW0tmFxGKhkA>
    <xmx:yXV6aNATuYX0ZIs9JalAiGwM8g5Y8oVS6-NIldZcIWbCp0KnUuXIBA>
    <xmx:ynV6aGtXSgjoP8JqmuMGbIsQE4htG_53EKL_xsvStDGCFwdQj2o1p-ME>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 12:26:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Brabandt <cb@256bit.org>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <aHoSjbV2nMZkBn5l@256bit.org> (Christian Brabandt's message of
	"Fri, 18 Jul 2025 11:23:25 +0200")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<aHoSjbV2nMZkBn5l@256bit.org>
Date: Fri, 18 Jul 2025 09:26:48 -0700
Message-ID: <xmqqcy9x4g8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Brabandt <cb@256bit.org> writes:

> On Do, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:
>
>> This series accelerates xdiff by 5-19%.
>> 
>> It also introduces Rust as a hard dependency.
>> 
>> …and it doesn’t yet pass a couple of the github workflows; hints from
>> Windows experts, and opinions on ambiguous primitives would be appreciated
>> (see below).
>> 
>> This is just the beginning of many patches that I have to convert portions
>> of, maybe eventually all of, xdiff to Rust. While working on that
>> conversion, I found several ways to clarify the code, along with some
>> optimizations.
>
> Just a quick heads-up: We (as in Vim/Neovim) have been using gits xdiff 
> library for use in Vim and Neovim.
>
> Is the plan to get rid of xdiffs C source completely and replace it by a 
> Rust implementation?

As far as I know, there is no such plan that is widely agreed upon
(yet).

The discussion starter thread you are looking at only introduces a
new code path that uses a different line hash function written in
Rust when whitespace munging search is not enabled, and everything
else still is written in C, but since it is just a discussion
starter so far.

I would personally have liked the effort to start with xmerge code,
not xdiff machinery, for various reasons, but that may be just me
;-)
