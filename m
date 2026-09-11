Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87217489891
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141362; cv=none; b=aEvkjOBRdMuvvazhbhL9Eu4grScKWfyHrEr4j5Zc58sFFbtK0QlVKa8OmIgr0KjhyVDa0B9RK6rd5aUtbY9I6AnsaKeZdgYYgrBKK6y/RwBePgVt5UHjBM0Gf1VYd5Im9KieDBNmaHZCGVwld33heISkB+isWk2TEA1TTRlHXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141362; c=relaxed/simple;
	bh=dxtcRckjxMLndfTZQtWFzt3xIG0n3/ENuyj1jr9/B30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M0i0jTInnkX8ircXmy/wqjfSDxIvc0BaO/f9hYuGJAwHIE29ai4rYuE1MG390A6pEloyLqjjERlVWimGUZNk9pkpcseZUUuZ+z1TuweeCH5EikemL25XKIw4+gbSlq9L5iyo6I5AfDkkhuNTrXA4wjH/iaVAQ2jnzFIYlQv56F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qrZk3ai2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OCQANVR1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qrZk3ai2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OCQANVR1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EF2D14001A6;
	Fri, 11 Sep 2026 11:42:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 11:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789141359; x=1789227759; bh=q3eTL21Qhk
	PBWjtNFGvMCxcB+1RtXHPN7r+s3s0QWw0=; b=qrZk3ai2IK7R4cPzDucZkiA5Tp
	RF4iwEq6jQ0mAAZBbezc8T1xKRqM92oieHBMs7H/J86Q3FzBzfYDbnT8Z1bwkHpe
	myaUJQjMom+WKCrI0qRADAqRFFLQmRNdjAjNVnvAAAO+Gpqh6EmZmS3YcMrhXIHP
	ccie1/29fXLXb+LalMoCPd9UPMcAFrpC2BAl0BiyJR12Seqs1pO0cW3jfoMgiV0+
	sZfSj+yWIODO7B+JQleM/LUOipa2qBz+KpD8/756MME6W9CzYFw3R6tSl3KjIpXI
	S7EJvko4rJBX2Yy+s91Zh5KiAQjHPWQx6P5ryR2yM6x5n9RI8RpVf+m1c89w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789141359; x=1789227759; bh=q3eTL21QhkPBWjtNFGvMCxcB+1RtXHPN7r+
	s3s0QWw0=; b=OCQANVR1cvP8uhR0xGxTEZCxhyMtaUju7gfQcQIBAyEvT2/uBAJ
	SYPewbjNpuoraU+OzarjTYi15jECZQj79JNyB6sgZibuczkQZqlbrPblp2qM8ah7
	4VWQZLLlw+4lpCB+ATk2cstjA3FQz72cOaNPwoCDkSEtdsuelTVODWWjtuo/Avba
	A2pRTuL5i6FxyTAaSpuDcmZYs06Nr7W7gCweFvl7hddvM8lIt+dW+XCvj2sVUy3K
	vNyklv1ZVOcMD9a6uCYWVBno5vAS9KSkF2OrxetS2xExBcUm2W3N63U6x4a3aL0I
	6m4HxeWLoEUCmTwpARXfeluLf14UgT1Aa+Q==
X-ME-Sender: <xms:biGkarBdelvx5Y4ehS3_BUI42LJfhru1JcvmDtXKIPHFBCBNsVM6xw>
    <xme:biGkaobqsvz_dFIMwEINraZXLx2mlNMSBZ8sc4xfhtwWMdfWLo0c-qPztQBC-rTUl
    quf8kWYysLiLcOrMOEQVCBz0Yc3f8YfXaVxOlBEo-8oEzcWJyoyDg>
X-ME-Received: <xmr:biGkau7RfGGWd70_NQNyb7X-r3cXH9YiugLcB5IYgkJdn0J29wNCxBGBWSQl4bzbcHqmJtPuu4nfBs5jRz59hYVdm50kRKzjjxOH>
X-ME-Proxy-Cause: dmFkZTF6K4Lys4+V0dCQ78GSjyWfHXCpHkb5pYP00+/Tg5f3vAvbIVscx8K1acOLj/Ri3V
    oqyskXkrEeIwWgyhoQi/lrLR+mIQZRv+Vun44ag+lgmEMaubb2hfcEpBU+pUWQuAY2j0WZ
    DHdlF1do1FcBFgdLm/v+VkG9oAnEVkezJRnaoMvDQSicmeCkLkQAagy13MZWc3sD4Hfm34
    p55Cdxk67mECLBCEk260wnBv+oOlBo9x09soVlfnC/JWzVP3tdVyUQgG01/ZUcpSBfuI/W
    XPxzcNarnXoKoQaPRL/SaeJJMSDMRqTp5U4kLUJYw4Vet01WoiAuKiJLCX1A4mTfwGSXe8
    tWbBGrqoOexcxVkV8YkCwBcwHJTaVgEISQ2O779aTqh+Xk0FxB6tdnw7bAyivI/DVHphJ4
    gdpOJt7MAKp3MqdLbvt0yrHa64XX1bCZ8+VeTPH/5zSZnM9zkMcLFLGj+bnXAIokKvwJVV
    pd4FC/kzY/QFXO559yTkWNeic+GzHe4YESI9NggCZZPfbxB/3oasF8UFUrVUIbssWCyIJ6
    C7yTtuoL9YipOJSo1jdmYw28b9znRJ0VLliB2mkYeYLHbFHtEWhAv1aQ+8vhWEVzb5f0bp
    GrIParU9T3NhwFKetIPSCohiP8tOCZ36MuOgROQZKrNsMcFTYAy7EalvFz7A
X-ME-Proxy: <xmx:biGkapZgyhd4jqoNX_LoCj4ITPopgPod1seLLP3QN8xgF0GA9BLmEw>
    <xmx:biGkatigT0cqoQ-9F17FzEm9NSgAY4SNakiBosElNAHbzKI9araPTw>
    <xmx:biGkaq_lhYIcfg-CPTa--hvzus_yT6FwZJpSHPGs-a-CZpuSywUcbQ>
    <xmx:biGkaopN67TsXyxDf030U2NPvfA15DlurDlwdFycgBOZpwlF5AdP3Q>
    <xmx:byGkahKJeDzmjcf4_p1n1xWglHP8oqmCVvhQxiJ5OExTgyn0oQwVDjYl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 11:42:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
In-Reply-To: <20260911021933.GA948291@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Sep 2026 22:19:33 -0400")
References: <20260905135822.GA3914811@coredump.intra.peff.net>
	<ap5Ttt-2NmM5dRZl@pks.im>
	<20260911021933.GA948291@coredump.intra.peff.net>
Date: Fri, 11 Sep 2026 08:42:37 -0700
Message-ID: <xmqqpkyjdcb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> If we track oldstable, then every other year we're not using the oldest
> supported release (because the prior release is still in LTS). Or we
> track oldoldstable, which means every other year we're using a release
> that's no longer supported. Or we flip-flop between them once a year,
> when oldoldstable goes out of support.
>
> Which makes me inclined to just keep the current scheme: use the numeric
> codes and just bump them every 2 years or so when they go out of
> support. And we can even put it off until the out-of-support release
> starts causing problems like it did here.

Sounds sensible to me.  Thanks for thinking this through.
