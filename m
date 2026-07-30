Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA3314B8C
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400910; cv=none; b=GNld/pTQ+jCXuWUkp8livz9yT42kg9Wqo0mnOTI4pCsAA7ZJHLLtdekiqNMVkO1JFhId45yjatmihUEtcWo1Q9fQfh7L7fAwB45lm4vcvv/cdkQlAO6w8udyk9eW7vDGp68MeOPEd9J0TbjTyGCD+ZCKEnQ8pAlOhxigkqtjhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400910; c=relaxed/simple;
	bh=0/v8SFdZmTNkcMTF+6HTQwj8SIwIAe8XrxS7Gd7+gQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IyIoWiY34yq+6lvITm3XtaVocH7yHKTdZiMxP5w0f8i/Hzkj4q8ARzaTYs0rzCq3tnAdckUrxQjujcrkmDGor1rcRP4XX5Hi4Uk+/kR3+w9ZJUuvyT+wYxrmqAb3fu7sqwEs8Kf7HckYv6yltOMbPIftiaQzaPb0u13pbVkRwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mTG9a0S7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DT6JNse3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mTG9a0S7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DT6JNse3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 19FE01D000FF;
	Thu, 30 Jul 2026 04:41:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 04:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785400907; x=1785487307; bh=YffwJcVd82
	2UtplTpXtWQQ1LxavgV4/JtT9hzx1IBo0=; b=mTG9a0S7URvdfuRnczPBBnkJNb
	g2pDh8teqQn+oKw1na8dr2bbbzatXNuwExe7365o6fJ1pBG9fvejz4U7dGWyw/bj
	8MArOh0up7S2exIjWZHfsoQyDWQX/jzpjXzKo6e7cBpItwaKEK/CKgbha5Y0O2HO
	0u+KKZWMlR+Ikr2cIrVe6xfA/9n/9IFS7ADx0u2FIViMJOh5IGhAeNFIWC9PFmUW
	Prt27fUvghrPz/12nIx14NQvHw4Ywe2lKegejMqQizqMwUZm6un6XMkSLikC0CAt
	GckbDJPfE9RxAAwWeRj5Qv0NM/5euFPf6Z2IXdxssDdEKt40Z6H5n/i3effQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785400907; x=1785487307; bh=YffwJcVd822UtplTpXtWQQ1LxavgV4/JtT9
	hzx1IBo0=; b=DT6JNse3ggAXwJShy7myKd+77pnLREUP2msglPvWJDXlNLwDfTt
	iS7g4Z6Hb/nTXLz2ks6SFPaOjn24YZJjHbJ9AsT2Y+efqYVfwEVEkzkJn0R3CdCH
	MLyGBotXEILWYKFqqbyxUoqIZLrpVpBkhoLtqkPkCTwRi4azUVO6nRe+Fkv2tLYJ
	zrv8GNBosCV3J+u/Viy+O4VFGw75XsHg9RZ1f43196ciraRbEhf4nfjS8n/rFP0O
	366kIKxGBNOUZMRePYCuYrSUCUe+FfVy6TNPjkb0Aui5qDBkQ6CbsSN+Bgon76n1
	qeyi9RzY4Rx7pU848d53tzzW6C4HkqqbzIA==
X-ME-Sender: <xms:Sw5rai5B0vUPFdpaUY64JLtt1fa_LvVdCYPwpm2QSSBMzVTeMu7UAw>
    <xme:Sw5rajUMTz0PFAMG1-qCELtuKv6QslgWZRGZBBQn-8AT5JGkf-U4Ap61waNUtbiSW
    iH_Zxn938tsp8UniFTkOzTLHnjdN7YbPPQOvStSaTJq8WSbgRUYqQ>
X-ME-Received: <xmr:Sw5rau3Y-YoBc5bjythkUGAv2FwIn5fghIskRhnqVCpWMjZPoTWOzzbVm6nWL-BxTjDl8Wjsovb6cjsnbglf1ZlnMy_JnJNIKQ>
X-ME-Proxy-Cause: dmFkZTE2nXk4KdhOSWhiOd556aWtFRZ/w1N6aSJ9Tce0AaCNSXnHTg5vtcE0X6c0lilbRM
    YZgYN1Tc776jpEVfM+E4o2TgnZlipEwmkw5P6sf1pJfScGMCvNHFZyfSi2l1P6D7tt+T3A
    EfXMtXsFI7JmG8wzXiqjJrszdsP6Ad4yTO/yuU31Z5lKZK81JL/hxqpXoaoocp8nTHLUTL
    RUyBmfgNBjsaBo1/ueLflAJML0HB6jX8eVsqrlypqPSTc3N/MbSuA57JLdFmuWYtHonxNZ
    KPcEcTt/H/OaQSQAeEPKZ5gCLoZPV8BjfjqkqP4Du2TO2NQtmCf5p9MKLAyZvI2Y40C3Yv
    KCSypACscSDJEA8A5BUSnkAkb/9+tYuIseQBk+VVeAquUrUytNPhp7nKVwfxp+lZX6+zOW
    iCIklOMYjXAKAlllfi6iZMioGbcxyP/MYrRSe683zNvZOcmKdXhCiTK2Vxr8ZtGJ2Xafz2
    VxIdatHVKuObDjwwvVf9wNZ3TC6THCDSUF4bhuX06Xw39k2dOpXaxuh+qW1bcfmmNKwxEn
    2PyB5X6vsiQPAoc6OgU1w9j28cbbx8zlEsUdG9tCl01WZy3w0cAWe026wCfsQX10DIWiq8
    Y3FaJLNz/A0OFCIjzknjhqP3RCWtiYYasx0uL9KGlnU51f9xV7BC7OAN7eVw
X-ME-Proxy: <xmx:Sw5rao3OjA5ZLrr7d6Oh-ECTX2X6xFiGMMbm0uuRZbuBzvFYbCbitQ>
    <xmx:Sw5rap8b5M1QExBFwr51BCTmTkultn-ntpgYqaCzuEenO5-M1Sve6w>
    <xmx:Sw5rat0dFv7q73cS0bya6UG6fr0KNRi8NPRHZhyzYk3sIvLjXcEwYQ>
    <xmx:Sw5rau9Ozqk0pZ-8oXedxoRCwTUPuibUTXG-ct9qLFJr0XdUzWct5Q>
    <xmx:Sw5rarUq3SyEcASEDOVxrSkRkRmrB_vveH3NmmSHQvJrYY7zTmSzhVd1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 04:41:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] git add --resolved
In-Reply-To: <CAC2QwmKD1d=-mz4WrkA7CHwi-ko75MP2LDFPWx+1FGLQtf4QtA@mail.gmail.com>
	(Michael Montalbo's message of "Wed, 29 Jul 2026 16:41:15 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260729172524.4022621-1-gitster@pobox.com>
	<CAC2QwmKD1d=-mz4WrkA7CHwi-ko75MP2LDFPWx+1FGLQtf4QtA@mail.gmail.com>
Date: Thu, 30 Jul 2026 01:41:46 -0700
Message-ID: <xmqqfr10lvhx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> For example, could the user-facing option be something like:
>
>     git add --unmerged
>
> with the same default behavior being proposed: select only unmerged
> index entries, and refuse the operation if any selected regular file
> contains standard Git conflict markers.
>
> That would also potentially leave room for explicit policy escape
> hatches later, such as:
>
>     git add --unmerged --allow-conflict-markers
>
> for cases where marker-looking content is intentional; or

Sure, but I do not think of a reason why the posted patches cannot
later be extended in that direction if somebody wanted to (but
because the option is called "--resolved", the command line would
need to become "add --resolved --allow-conflict-markers").  I just
did not feel the need for it myself, and because --allow would be a
rare case, I would likely do "git add --resolved", see it fail due
to conflict marker looking strings that are deliberately left in,
and then do "git add $path" to cover these small exceptions, i.e., I
do not think anybody would need "--allow-conflict-markers" option.

> something like:
>
>     git add --unmerged --skip-conflict-markers
>
> for a mode that stages marker-free unmerged paths while leaving
> marker-containing paths unmerged and returning non-zero.

Have no idea how the user recovers after performing an operation
like that.

The naming is very much deliberate.  "git am --resolved" tells the
command "I am done with them, so please continue".  It is not like I
want to add anything that are unmerged.  I dealt with unmerged stuff
and turned them into the resolved state, and the command is a request
to record that fact.  It is a regression to call it "--unmerged".


