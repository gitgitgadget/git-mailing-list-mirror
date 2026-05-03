Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D219AD5C
	for <git@vger.kernel.org>; Sun,  3 May 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780146; cv=none; b=Qpr6BBppGy4/kOJUCgGvFxNwinBVD2IJcQS5+be2iPyZki81FzHZ+zWUeA5YOmVvIgG8PYjiTKOn9XiVxHSSZG9idBInMSyZZy/Ew8Hy0Kz+UEs9klsEpd7sc33MWBCBvuaC500++ehGUOU1Pz15mOCRlUFefmfCPgZTQy9MvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780146; c=relaxed/simple;
	bh=6VfrymVZos3ad5RAx0Cq0yIkLj3bzAM9oez9MU8ksUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mWU/nBG5duvojifTK5GEbFith86J49Y+z2nHDgrgAKxsn2dHKNi/V/hOTTIRHgeA5pYyMFgQqEw2OV4HFAMZp+tCazhgzs2MRznbxOXR3vPoMZu3gI3Vd/Le+hMy+t+Ww0xXnIk3e7zQ9KJ8/CBuCphAmD4OyrQ9vNxRKIzIC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rCV0OT5K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vf7WBgMb; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rCV0OT5K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vf7WBgMb"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B6797A007F;
	Sat,  2 May 2026 23:49:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 02 May 2026 23:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777780144; x=1777866544; bh=8Jyx56+MQm
	a5uCGkBj5kn/5zT5Ck0+Zb5CsMCQ814Uw=; b=rCV0OT5K3LkWWYzO+1Eg4coN8t
	k7Dlw37wGnS5TEMX4YdbTNbDf6VibaiXKibyEKy5qK1Z84kcjGUjF91ciXPrDDzD
	56PHRV5wln8SdJL53Ups88bCiEoy+DW4di4vrvyZNiy/nsvKgwCP4T7Xh/ExEwKu
	QuQlcT8Gs0Eg/967IKivsk273Ani9RfV98+yl4pjRTToLVTeok3BqRr8ku2MgBLv
	KXWg4LIuyh2Qjyuqo0F83ILClQvZkrF4UCbxMKTFHzkpA/Df60htqfAUCzd6SZYU
	lxP5pNdk1g+tOfRq6kvy9JR6eLnXyGDZSwas4QPjiScs3DsQArsNlLFytWGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777780144; x=1777866544; bh=8Jyx56+MQma5uCGkBj5kn/5zT5Ck0+Zb5Cs
	MCQ814Uw=; b=vf7WBgMbvx3svqJULBJXZE9LulAByu/62LDkpWhlo3C7unGTsOn
	kuAa/4Sp3tOr38/HTK/3qJ/f3pUE7ixwesk2+fkd9sJi+qX5zXR9er/XZ7PeRuRW
	yAa030ebn5BvqKsrfdmxDqYi5dlLW16DquWIbI60D/1hZPZsloC4UXJqJKF4eW+Y
	WE4ObCJXdHJVOK7gtXtrVn/WjjdOtrphDFBxHdCthvWJatLoSFc80wuGRycUZ+Pr
	a8q4fO6jAXM0Sw++iP1oY5xw2K5j9gQocyM7Uw5Xc6AuYI9n3Y7p90T3Lcul05Fa
	EN6TkWa6EeW6fBFo2eI4Dxgo/UGejdWBUCg==
X-ME-Sender: <xms:sMX2aYhmnBEpctRlo0muZER4Rl-7ic0W_2ANE8mtkB7_hTMRNzDUZg>
    <xme:sMX2aUsZh3DiqJNJsaFwzX81WyzUYyE1BSKHXxitBk0aOcpdOv5i7IqxajhLxjhNH
    ct3l4QY96qZcjjc6ZCfV0k4X4Kf2oXPWMpZbWFHdhqphb9oC5itcoc>
X-ME-Received: <xmr:sMX2aZ6BJu4W9dEs8iOzqmwyi_bFNH2Nwd9QzBQjEAJzU6GodBlpIn6cT9vHz913Ikmrfc95fE2ptFTf6rzByOZ3yQRNPF5KUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelgeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttd
    dusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhhvghushesmhgrthhhvghushhm
    ohhrvghirhgrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sMX2aQOUbmSEOcioGRG47XFP5W-CKJcVCJujuqXqa5tzSb3LTxrliA>
    <xmx:sMX2aXuGSY-f7cKq1f-Y-WXCQ2fNa-9gIY8tSWZKOoG5E5G_z7jxMg>
    <xmx:sMX2aTbjtEN3IShPQpEx6GNm6yDUnvLVaviW61jtqfUMf_xDDzud5Q>
    <xmx:sMX2aZy4969mfp4C0HAXOl98poHmc1tLSLBZNvzCh5Blfq-N9JEKgA>
    <xmx:sMX2aYqFVRCAeJ4hMqbnuQWGphYZpu7qImYzpTegNDixVr5iGsrqy3O0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 May 2026 23:49:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matheus Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Ghanshyam
 Thakkar <shyamthakkar001@gmail.com>,  Matheus Moreira
 <matheus@matheusmoreira.com>
Subject: Re: [PATCH v3 0/8] builtin: implement, document and test url-parse
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com> (Matheus
	Moreira via GitGitGadget's message of "Sat, 02 May 2026 05:28:34
	+0000")
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
Date: Sun, 03 May 2026 12:49:02 +0900
Message-ID: <xmqqik95taoh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matheus Moreira via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... Tools wanting to reason
> about them have historically had to reimplement git's parsing or shell out
> indirectly. With git url-parse, scripts can ask git directly: validate a
> URL, extract a component (scheme, user, host, port, path, password), or
> both.

Nitpick.  With "git url-parse", these scripts has to do what they
traditionally have always done, i.e., shell out to the command, no?

