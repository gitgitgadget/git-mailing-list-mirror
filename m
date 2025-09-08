Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510831CA50
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357274; cv=none; b=bAE5Z5nNBc5Q+O7jIG0g46+fv0F2hJdC7gZ52hqDKlR6pjNT0YfXrSHsZWe+n/wa2lcdsxhvPctIqVGUvgBf9PYF/ritpwEE6YeLXX6jvDZBqt1e25Qf2e0cn/tKAuonwWSjWMoRQUgyofxIWaPyFSY3lazuEHcIHorAytmu0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357274; c=relaxed/simple;
	bh=A5G6lqhqfivXprTsHLDwtpSw78k7CnRYsRM3nRd1Kgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rblifwHRjXbULIIeZgs+ZQnwqR4srMd4iEz3MXkfAd30E19dJ/RsmhJOz7fenE6FsrN5v7cA5Y0avNsQ3jqF7hAS4qC0BkHexJJFvVizm6t8v4OA6ga6s7SeaJCOa7PA3ZrJHwvGWKgJQcX86ZFnyr0DoVF/ywIuV4f6Av5rMaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oCVClnkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEN8IiXu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oCVClnkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEN8IiXu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7358C7A007D;
	Mon,  8 Sep 2025 14:47:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 14:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757357270; x=1757443670; bh=9VtWA9KXIs
	5+WYwnif0qEhRcIk9fgHTE49LevVsJf64=; b=oCVClnkZSOgBBSi3Hy9dFOB4h8
	EXfEQPMf6HPdpSJ+Z+IiaUDK5gkQGmr8dxKhF8Uq0Xa4gOB0ggkqgKX0gYxKf5TA
	f/bquHS3fF5iwxte9TxkkiSPGZCD0Bat/Q7SYBjzopI5WBcDTcGj63NbAQRkupXs
	yXZCFm91A0FhY0E+2Q7wC7tnDtoXGD4NjsHv5eRQ4hcsuN6f3F4pVSqYoZ36LfZZ
	KpkqZoAU5S84dVBnIhNNlEvTfbW5jjyHrGjO/5BVMkXQsGNolZ6HSL8cpA2nI/2u
	O2Yd46YVVWrsZbZNTEpQdMXfmLkf1iD6S5/CWWfHQND8uccUzMy/gg0sDsnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757357270; x=1757443670; bh=9VtWA9KXIs5+WYwnif0qEhRcIk9fgHTE49L
	evVsJf64=; b=YEN8IiXu57GuC1fh8tDJjUPLjMzu9J3SiJA7s4zZlBBaxK2rYrb
	SHQH9ttWrv9sV17PC5HWtiEZLzo0B8t2/1AjJC/21QIp3b/mToPoSGDf9EeaFqpb
	H7Wr6/nz7BQfMfy6xn8SGdznu7Lg41v/HOAjSUpZHGhDwylZ2mDeqdHE4dccQmg6
	7mcuYftF1EcCre5bOxmZB19njO1DwUOh8cx5rlJ6wzhnND165beUUqaVt83NxfW8
	kwg3GQFGk0vAk43mTYO46shasrjg+b5EOiXcLSdkAy6E8TFi7U3y8x56tH4ZMmfd
	54T/lDkZnCzQFX+fhD2Xr9I2JJ6GNuymgwg==
X-ME-Sender: <xms:1iS_aNH50Ifoh68rOG9E61yOL1qXiNNE01Z2FNX7Jy-9KwCdmxlorg>
    <xme:1iS_aFksllOx5CjlNN-afxmiV9Agd9hL0f2kKvi6nrwaSMgApW0i0zdzTQivmOC9k
    WkwCSNHXYMrydIHKA>
X-ME-Received: <xmr:1iS_aIlbn3tG4By_sKjJ1Vs0sAu_L3S1i4-wfblfp0EMKInl5u8eFvIEOjnEWUWuc6yoYNTpJ07Z1V3fEYQ2n1KexsHQSNbfACw9Nnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepjeehveegfeefteektdevffehgfevhf
    ekgfeikeehkedvffeivefhieekkeeujeejnecuffhomhgrihhnpehhthhtphhsuhhpphho
    rhhtihhsjhhushhtthhhrghtrdhithenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhlrghhuhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1iS_aOuKxGnScGuTKbgA-q0_qaNRRk3xg77yJOUTeVHBVodXjncD3A>
    <xmx:1iS_aDnJs4Jtiy6_qI-25MIjQI-nYEEbh_RNLjhI2kubGisRkpSQag>
    <xmx:1iS_aBvttImmfndkSgo8v9KorwVjEoOJg6hq380wv3Z0YH5CNq_2aw>
    <xmx:1iS_aBf3IZGjldADzPRj9nB9GyKMPsnwA5RU_1G0yAu7swYW8WIJrA>
    <xmx:1iS_aCMqI3clPB0VlNh62SRRnumPwKvR-3-QOW2cmNkn2y2BRPS8c8wK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 14:47:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Milan Hauth <milahu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should use WebDAV PROPFIND method
In-Reply-To: <CAGiEHCv7kXSB5v8Pi6gDYaC2O3m5qEM8dYW3vKvNm6sXQ_Vuhw@mail.gmail.com>
	(Milan Hauth's message of "Mon, 8 Sep 2025 14:10:34 +0200")
References: <CAGiEHCv7kXSB5v8Pi6gDYaC2O3m5qEM8dYW3vKvNm6sXQ_Vuhw@mail.gmail.com>
Date: Mon, 08 Sep 2025 11:47:48 -0700
Message-ID: <xmqqikhswzl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Milan Hauth <milahu@gmail.com> writes:

> workaround:
>
> pushd /path/to/repo/.git/
> git --bare update-server-info
> mv hooks/post-update.sample hooks/post-update
> popd
> git ls-remote http://localhost/src/somerepo/.git/

That is not a workaround, but the proper way the system was designed
to be used.

After all, the "dumb HTTP" support is just that.  It is known to be
ultra inefficient relative to other transport methods like "git
protocol over ssh connection", and "smart HTTP stateless
connection", and the WHOLE point of supporting "dumb HTTP" transport
is to allow a truly dumb HTTP serving infrastructure.  Letting the
clients assume that WebDAV exists on the server side defeats its
reason to exist.
