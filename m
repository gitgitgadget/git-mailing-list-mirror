Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD5375ADF
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705120; cv=none; b=J6iwfjU6hxnjKYrox8ahgohrPufW/L9aeY5cWjxDy+MjCsu+2GDJFFFrBvWCrz/iyqZsXPMQESIOp5nBCQsG2HxLUjU6boOITCH2tRej2Te0iX/Ns9g/yBLGa6vuYao8QEyAnnNIXP566jsCACYNSyfljMroq8GJXiMozFuUZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705120; c=relaxed/simple;
	bh=zfj7UndRMN2Fht23UPXgQR49CVQZBD18EWqaoUj91t4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l8rX/V3XGUQkv5PxbbHKLIyiwMeokEB+ejI0WwwZ1llvwxml61FuUpa/FsEurSUhZ0wY7ySzxYNGobS6XmH5ZrciRXlnU/WbXUruEX2M8/xe7AxQawAd56vr60KHOAaIJbL+Ea+bHyrv/Yfwo7POp3sELhNxQAZgCat4p/wdlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FNZe2G6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/iv2Wqt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FNZe2G6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/iv2Wqt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 22A101D00394;
	Tue, 29 Sep 2026 14:05:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 14:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790705117; x=1790791517; bh=/ofqdRm+gE
	cReYhSIxTU6mCRn36wE49slBFJAvhOMoM=; b=FNZe2G6ovHZxrBpzujNMprfSZi
	ZO5d3Qrkftpuzpd+ajmBEZWvmrhIMkoQeusWK+k+eTIzRV7YiBJQnBJTJ+SnPKBC
	+pSossYm0n74Ka8hIjTFuk07Wx+CCZkK7Un/iKIWSQy6CuZJS1aeWVQEUqCz8yX+
	RMVqPKoBhCYpjauWSM3oTTuGTtP0o5T0WqWYPz4Uc1+eSPULz1HPINXfRLe7goF1
	WGFlBQCVkAROtaxtt55FWGBPvCH00bVwW8DtZSDz1SDWEt4WxlBrV5kuJmusLCnu
	pvhLhJ5jZ60XOBtgUCUt6Gq9h0rWeAdKNBKA259uY5pbDSxMD0eTx43J5Smw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790705117; x=1790791517; bh=/ofqdRm+gEcReYhSIxTU6mCRn36wE49slBF
	JAvhOMoM=; b=G/iv2Wqtq1YWQgEa1XFc2L23hydcT91bjP//NdqZ8KPURvYDeYz
	N3mHFV3plkUd8q9cSlPI6YXvVtkmYUxSjjja8HAQ2lxc8DOgxO6/NatsxUv6i2Dl
	EmHMWxOw85UbtcJXV2SoLdfPglDkZwdEtPYB+Y91U9/ScDaC5mSOfIN6O4aVWF7c
	ndZqbh5KXIezaNlGMW3KQQM5QtYonUSQ3MYPN1mYwZFLaTLqwCf+rf76dlJKbzJI
	kLwiM846bMpIieVqylB9vxIGYB+WxOVIQoNQzkRAFA/pwI5QMKEfE02yHtmXxkyr
	EpKKjHX09+Scf02jQl3x1EvQAZ5OzXBVnJA==
X-ME-Sender: <xms:3f27atJaYbCmG6JOZ1v1cndzbrvYGGPgN75-lUiDONTYY3CQDEtTBw>
    <xme:3f27agIY08mcI_iQr05ntjmkKrxp1fun5F3YqkmJ6DtsS6mLco5mC9D3F2p7kafWR
    XWx1EXj8wrxSs4FwyTm80Ns75U4HeczH3UrRsDGDM8APmUyjLUa5TU>
X-ME-Received: <xmr:3f27aqsSNeIpMBDbCzYe8Qt26MW6LKv5L2JiEUBoC-F0gMNdFc6FT0FXWJDVZ9CXl497RorBsDYML3unybdp4tlcv4iraKuwaJ5l>
X-ME-Proxy-Cause: dmFkZTGKM5N8tErj9lbyN16oPFJEHXnLiEa99osmvvZhnGUgHjd4+XL5beB7w5AeR8hbal
    8eMFf0+kh7oLIIa/cBVQaSIsG3jf5MPMYRwZLEJPj4Iw8JiyTSQEtVmmM+GPT5bgrUhWnq
    wkG2DBzU7u6o73LMraneMh7QUKNjap7t9bCRwuPuonIjIVyygVyVGTDjl/Rbm+8Ko7T5nG
    0uTdj6lza5zImrBXeXLL7zx/tk3l/bIpZT2p7BesQvwZfFfQv7SOYmdr/ZHIolxjp541Z1
    jrWOQZ9pwYy3c1uX8TapeHxT89iomEp0UMH6PEW6EgK4DlSX6NTj4IZJWGTCRQnbI3xxFZ
    iRQnPg8UBEgktFA1X0iWnwNPECJ7ZBn4trHYtmfW89nyMRYdXBcGIViOkFSdd2m7XqkqKF
    kuRvR53XAhYOQqamRzPMtnwLThryMWUiiPRQDN/rHOlPXDcQu7tAFiteILs6FssctUN6jd
    p3rY3ZnNamU7FtnVhlwzwD1xSclIoqLqKovzbrH6Ut7xW5ZXuz23IxABz4RyHiITcxgcPo
    GYNwKKkCflLgTv6ffAi2LTCQSw/p96x+L4LSLxr5LSdTe+igLjkS9XIdn2du7fxp0h/1Lh
    WQfogBQj4csO2vc1CWwRFL1948w8QVeTvrJMS/Qo0YwXWvqa9JqrGDwuE+QQ
X-ME-Proxy: <xmx:3f27atSiIljY0gGE1t3CFk_RlB3CBFal7TQ8J0OfzkQ93x5m4Ct6-w>
    <xmx:3f27agMCu0V09Gpz7m-6Dw2frp7vBnePvolCHMWu_fQJ6HfIAFgMgw>
    <xmx:3f27aibbyHcT_3MAai23BTNVpWWxLIbVrfSlRQMuWNu85NJRGxmqTg>
    <xmx:3f27aqyGXPgGYqFHTfNvliaUlGItQaMWoaQCA70EuQajUdO3YeMhFQ>
    <xmx:3f27ajvBcNTNRfLrlMvGjWRipDYCRyC2PNrS7wnGV97B-p29RHmW7DCj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 14:05:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: Aleksei Sviridkin <f@lex.la>,  git@vger.kernel.org
Subject: Re: [PATCH v3] push: fix --force-if-includes when remote-tracking
 ref has no reflog
In-Reply-To: <arsP8IE6LuAKzYE6@localhost.localdomain> (Tyler Cipriani's
	message of "Mon, 28 Sep 2026 19:10:08 -0600")
References: <20260903010547.85469-1-f@lex.la>
	<20260905171330.34646-1-f@lex.la>
	<arsP8IE6LuAKzYE6@localhost.localdomain>
Date: Tue, 29 Sep 2026 11:05:15 -0700
Message-ID: <xmqqo6dggch0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tyler Cipriani <tyler@tylercipriani.com> writes:

> Minor nit: surrounding tests in t/t5533-push-cas.sh use
> setup_src_dup_dst, which would simplify the test setup.
>
> I'd be happy to give a Reviewed-by once the log message is clearer.

Thanks.  Just FYI, the patch has textual conflicts in t5533 with
your tc/push-force-if-includes-fixes topic, but the resolution was
trivial.
