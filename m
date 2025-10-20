Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BD23BCF5
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983719; cv=none; b=aSI0yNdgMYCOTA8V+cerSSWOo6WK204cFyqfwR4PlKKWd27Wld+uE5Nlihw0UWKiK/eeIKQlpZWu3/8taQhkt6aeOC4nWkyKJLEMFdr2zacz0s6EF6tc/cOE59CM+JePV/l5DwU6/Ny7PeKBtv8o2AkEuORcLtQGWhW9/dWvR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983719; c=relaxed/simple;
	bh=tTkYnMOAMMFHacz5pWt3jC5vGzB6ndFPKIG558evmvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T4YeCh3R6L9CuNiaYPKt2tEc/HMqeeJUlFsXqyf60sDlf5uN/A3/3iDeepSojN67sSqWcQC4a6I9icNIWnxxZ6tiNDu3VLhhJqtfc1w00eV4b767ZLvAMCaRkFau+zLaFtFKblTE0fR7h18mESTa6gEF9nfV/gmSYihS3NgLekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CsvM2AIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qo5GKpOS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CsvM2AIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qo5GKpOS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A66557A0070;
	Mon, 20 Oct 2025 14:08:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 20 Oct 2025 14:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760983716;
	 x=1761070116; bh=J0tiuo3SeIw7i6U6jIBLeokoRrjZY7jBcsBRy2pkPRw=; b=
	CsvM2AIBnu+ZC1Uyc9GDhiiSXjiYRsgBShbnU5PhktLhxnfNt1SCJzogK4dRDlPI
	gPY+WZijjqCHtBO7GUp3aaFeSlJF13ILESuqdoOwR5aFDEClJNjMy97kQU9mwW7b
	tviOFqs9V58m2k5eMYyXMJV7lAvgAdeQBYIwsY65NAdZ+eCraokajbY2kwASbIh9
	ATm7n8Ra3PvuyrnRMJAeZNL6nwt6KYJ/gudCcghy/t/w6nRqFpR6BmrUZropha6v
	d6ZMOYrjsE3Yzh0AGSDAwuOCv6hV/ZT5M7q39fabXIrPA2sijSm0PwWbJnvgevIK
	bLmHKbmVkhChz2AedrYC3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760983716; x=
	1761070116; bh=J0tiuo3SeIw7i6U6jIBLeokoRrjZY7jBcsBRy2pkPRw=; b=q
	o5GKpOSZuS0N9oYQ8nar1bx2wnB86Wu2zMabxop6p93EB7Mf/h9a57NdLSBUCVFX
	epyJWTtFRac++4NN8ZZsAUgcIa7W9qk4X75sTnOY+pTMvG1rA/JBlrsPuHMt8g81
	IDJpri4lIQuJhH1tOHYYnLTxeve9SfzhCFbyoZFbP6+0oZG56ZJ6FUYh1ah3+8Fo
	oBL/CMA4MDjnK4mK/TIx6Jgg0d4uVhSSixE0yFOm20Vj1g/ozcBtzQE0O9blgHug
	Ip6i/R+DctfveZifqdeAF4KbV0wlGJJ0AGuuYxbrZvljXKg3rUm/wVlVYlm/CkVi
	Lly5IG8ci7lAqeiZ9ul+w==
X-ME-Sender: <xms:pHr2aObMmujz1qqvfZfe7wU5UJe7a2dsuvCOXQd1dxzNMDyKHY0sRg>
    <xme:pHr2aITINJGGq2JSj8RVI7PzNI8deVUOhs6BGQ_THuoCf7vs_xl0TkpSfY3bwq0_8
    p8xqn3oEOCB91JYoLf1sKZBJbWnyAekVNCHlCjZtf25ujq3zYc11Q>
X-ME-Received: <xmr:pHr2aBSLYjSJ4woojJDuRhhAoceDDp7G7gFgIgCnOFeRR0u-d8h7JPrI-tSEo1lUEOtKK_TBB5Supqc-oJLSBZr_7MdytY_x5mbd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhihihothgrqdhfsegrshgrhhhirdgtohhmpdhrtghpthhtoheprghimhhluhgtkh
    drkhhihihothgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:pHr2aMRZ-uoinDsmMJ5AAkXKAEFMmXa_hlkVVQ8ANZfIQkMVlQf6dQ>
    <xmx:pHr2aG4NBOdyt6OA1lwmKGONmkAQVgL7YS55OgLD_aYh8cfYZyZUHA>
    <xmx:pHr2aI3lLsoRg8DSiTP9TsF0WOIY7AUzIaw200llPCbFJhuw88yTwQ>
    <xmx:pHr2aBCzaXK6UIm_KTgTW54sOaPW59w0JG5YTm1O9aij6AIsQWQWeA>
    <xmx:pHr2aEyFdbS-0Kn5UsYI_2NwFGM1TbRHWS65J-aJvuPdx8h4goyoti6U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 14:08:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "KIYOTA Fumiya via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  KIYOTA Fumiya <kiyota-f@asahi.com>,
  KIYOTA Fumiya <aimluck.kiyota@gmail.com>
Subject: Re: [PATCH v2] completion: complete some 'git log' options
In-Reply-To: <pull.2073.v2.git.git.1760981577441.gitgitgadget@gmail.com>
	(KIYOTA Fumiya via GitGitGadget's message of "Mon, 20 Oct 2025
	17:32:57 +0000")
References: <pull.2073.git.git.1760878666840.gitgitgadget@gmail.com>
	<pull.2073.v2.git.git.1760981577441.gitgitgadget@gmail.com>
Date: Mon, 20 Oct 2025 11:08:34 -0700
Message-ID: <xmqqplahzbrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


[jc: removed these entries from CC list, as my reviews on v1 bounced
  Revi Ewer <revi.ewer@example.com>,
  Ill Takalook <ill.takalook@example.net>,
]

"KIYOTA Fumiya via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Change since v1:
>     
>      * Make the commit message follow the Git project’s style.

Will queue.  Thanks.
