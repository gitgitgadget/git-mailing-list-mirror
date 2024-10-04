Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D61DAC94
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063877; cv=none; b=ZVn5/tq7huag891sepNUnowHGlMgCAlV2qfF41A6Z1ZUjOCXq4VSL+45QBAgn1Ec+K3AcDRRwraZgX7ExHvLgMN/AwQ4DTVfaqxLmxsbMrdAItTFQypkcrnl4PQHVzEdz9IqxnFH7jR5SQxORIW8TcYrCo0sNWMYyPgMxy0xqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063877; c=relaxed/simple;
	bh=BMZ8YioR67avLjHgnIj3KBAxrK1tJBOERIWtp8bEd9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lJmBTlKAVrJ8VJWewP2FudxmkypWJHsoZSNnjoZV3dmZlwaa9FxUzubT8v8Xcbe1cVk1nzl8DEfVUM4QHDxJB/ml7ubfHhCRQJ1RykvR5mn9dWRDRrlT/QCsfcfAh6Nnes23txxz4NWZoYtY0RNhKFvDWXcgBroNngV0r4ePxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O7H+/56z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MK+fb08K; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7H+/56z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MK+fb08K"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08208114018C;
	Fri,  4 Oct 2024 13:44:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 04 Oct 2024 13:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728063875; x=1728150275; bh=Vfz0IyXxtd
	7Hni4Casu0Syizr1PyPOPDYTsIRcNvXY4=; b=O7H+/56z3YNGmy+wk0muscFAgX
	Zz+z2XLLMy/7bXkybEhHWroFO1XRpx7x7Fxgh1iqOU8qYkGw6Sbx4Lg/lCAyZA86
	HIx8QTC5vwwDEsD8XDZJ3vPdiIoVH0DDpgSrfwKbPUotRzoss/hCHJuqHP8EOAFE
	CvpMAPmJRWCZYnQdaYrGjwXzKVEa6A85ND74DMDUKFTZUcCNEK02RMO61vPLNzlD
	pzCjtVjstRc+HJokr4gyuUUh8EAMioY+hm7Vr8G/3YrEKz7fhXrQc6FvF+JxQ+Ln
	sGh4mxx3X696/atr1SVtwwmoxhaBSnu22RA11H6isIz1Ccifamvh1sCvtw9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728063875; x=1728150275; bh=Vfz0IyXxtd7Hni4Casu0Syizr1Py
	POPDYTsIRcNvXY4=; b=MK+fb08KsPx9WmUYqtpneT78r2gmWAhdOM+wF7oX8Zoz
	yesvGczPrtc5it7K4BDQrCBYnNdsqH6w+Cj/ej0KEtLRE/gIMZyJn+wgfpWXX/Go
	JgiymdaMC/F2VJBJZeMjd65uKyImw86GIL7zIXkLHCrkp9Wgm/PplpF7cBu9n3zW
	lcfEVv8QcbrochiMY6gpFGj4hWzw+aHRrE7Egv2f0xkFUg4Kihxq2tw2yJYh31AA
	UD856nQ44Gae39NcMU3NdXcJ12tV07ffPSGq11c3Q1CYZ7VeMqOSZH+5ijfCJr2n
	sOWwORsRdcLY+yM3KDeW7+tvvIe039Vi541lL1AUpg==
X-ME-Sender: <xms:gSkAZ7YZ8ZJq585nyuiU9YNdmtEEQ6HIyDHuQ23MMa0yGPcxmOGwjQ>
    <xme:gSkAZ6aSf_25PDXv9VcB3DFaXG2CgwpqUgYy3bb62A3Yv0GH2bHR7bk5J03hvKe9W
    gpXTqJaLcc593tJ5g>
X-ME-Received: <xmr:gSkAZ9_seqk1wFkRosrKiUEd_dpMadjc8-0b4oi2juCoWJdbah4afvyN5fDibuzoHnebncQsZj5mqaYxVY341KTADp1bfi8dT-VXN1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrdhnvg
    htpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gikAZxqhnp60xWQEcNwXB-FnVc31P8VwRH54I7HHKFzllAUa4Ozf8w>
    <xmx:gikAZ2q4g1q3x_EwXskzGYyXWIMGVLlWsactpE3C9qyMQgW69vyTHA>
    <xmx:gikAZ3RdY1AES1iCvdxxSNTcxWXYGjIJ1BmiVNG02FXsJsCe_iD7_Q>
    <xmx:gikAZ-qT0rFxWYvYUvxVEktefrpt8zPuQYSAHKk2G85pz-lkPFMEqA>
    <xmx:gykAZzBniSYY_waYZU1R0Cn3nMueqIUL0KK21RFPkGmDXFiaoqff5U8R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 13:44:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4] fsmonitor OSX: fix hangs for submodules
In-Reply-To: <pull.1802.v4.git.1728000433326.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Fri, 04 Oct 2024 00:07:13
	+0000")
References: <pull.1802.v3.git.1727810964571.gitgitgadget@gmail.com>
	<pull.1802.v4.git.1728000433326.gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 10:44:32 -0700
Message-ID: <xmqqiku7epa7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... The test is
> disabled for MINGW because hangs treated with this patch occur only for
> Darwin and there is no simple way to terminate the win32 fsmonitor
> daemon that hangs.
> ...
>      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "submodule absorbgitdirs impli
>       +	done
>       +}
>       +
>      -+test_expect_success "submodule implicitly starts daemon by pull" '
>      ++test_expect_success !MINGW "submodule implicitly starts daemon by pull" '
>       +	test_atexit "stop_watchdog" &&
>       +	test_when_finished "stop_git; rm -rf cloned super sub" &&
>       +

Let me update !MINGW to !WINDOWS while queuing.
