Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3834CB5B
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472536; cv=none; b=ajyn2daHuXgAhpXMhfcuus7gg5Hufp0gDU3nL/SBtWWGo5TVMssYAt+nWfuGXiC2MgYTqugt81LCMRkSU8XcS0IoxFl/ZHDCdaDXSUy5cnI4ad9GBFzogCwqxDATmx5kZfFRnaaQsxJ4h6D75vn+r2hewxtqmA9aNz6/AhnrUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472536; c=relaxed/simple;
	bh=Iq8uAzzvU/GAYXj7xHbfrYrQ11kcCkl5tD7U/EaITu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oUJQWJMkGM3Y/r+gWH9V3PQJTK+zVQ/kzn6ldJ+W0f0lfQeeZUPom9VWARlck8MxqXQJDJtO64wgp5x0jTnOGa7fhCbZH4AM2PiyvPutwMVoXxUZS70TpIfrxxQioHw6qQ65ZMlUtl77Q/QddArWgagmshtZfbXG9O5UwlzQj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PLSaBaE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0EWqq9c; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PLSaBaE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0EWqq9c"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A41C140006C;
	Tue,  7 Jul 2026 21:02:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 07 Jul 2026 21:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783472534; x=1783558934; bh=u2bsGxom/I
	3GWteusCY1i9kvIgSxCrOZyMCYtC8ZB1M=; b=PLSaBaE3lrmszVn28M3nORNdGA
	uOrfsYSfA0Cy+7i8DGKqUT8kjbFB+KogaUTHS0PI8TvDmwKHrAc6+52WEpqPcGCm
	bmCvnZcA0f1TsQSq7sFrb5Q67D/ZjGj4xVXmha4KvmvoEuMIkesJn+CKadGif+36
	IzIBbk4v+9a5nKrQYjWERCJ98Ijkn2Kq5m81REVW9IWoBpLBXlDAhSQrMbyfVYNx
	flNLMeYetM1VXDFamqFHHlviPg2UAqRtPBNX9rq4rcqJUcZQi2pv0OdIrfdYayp/
	3JS5KOkE+BlMOj0kCVkpJ1h2ez7L/wZVXxhUY6aNxObw8G8Za6G/OpA3cohQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783472534; x=1783558934; bh=u2bsGxom/I3GWteusCY1i9kvIgSxCrOZyMC
	YtC8ZB1M=; b=b0EWqq9cZGBJYnX3owkx2+WzkxhJ6HyXCZCZRnqWBK3nJXiEd+Q
	PRu+RR+/Ws9oWomsB6CK3PakVg0unfY8hgJiMz987DwevSOR2QrArvtnVOtQKzR8
	vWC33pTHUALFToi9GjJ5mNygOaPjzxDRyfZHg1b4K/15Ad7oVXFvCDNDCJPafaGS
	owfIilONlN/hp4gyjDnWD/RxwmIrRn/vuiTAOsODnHLvr+xDzAnNlrzgPPs6p+4L
	BtGYrzdhTjLMRy2WyD4LfhhwBRE0r53NWMhndCZxrLFe49Eb/n4i2qYiT9uYI8fk
	FtQaycnu7L3f+bOwvQ5elPh0+Vw7HX4QUWA==
X-ME-Sender: <xms:laFNalPFiwB4X-4x0AjPfeJ5Lr_8M_t6HRptzcImJ7a72MblYvcrtg>
    <xme:laFNau18fMz1mZ1LMBiV3E4hrijHYdZ2dROhmb4Hioay_L8VRISYzoT5SuV784nWc
    CMbGlDPHWRtCJwVkyiMj2qz_aTnOl3I8ntPiien4wEJsgA-hnzzNw>
X-ME-Received: <xmr:laFNasmxzDznBz2OBMFSA7KWWHyQCoyKz_f4dnej6nmYmE28hszkPUSXuKbM6iRU4UmC1SU8ghyjQde0AlHdh5M_HRglQ-NY13c7Q6w>
X-ME-Proxy-Cause: dmFkZTFnt5GHLsuo2jnNAwzRF/Er4zKhJWPA0w5FN5SVgk2Aix8GS9hEYWd7Fza4gNn5o6
    hiRILJiooNq7b2PzdfG0Kh5TLuO4oTN/7jWkFztWRRE3fyR+IlcZKaBw22f+C6tPLlWMzP
    zkfjG/BHJfdI/+YHP2IwYLHGCRMu7JqJGnSQFGaZ86K9C2OnCkZkU2F4lnHhw/YwY6A+gU
    lTCTBM6TM1GLOBb8Sk0NLZXqD52eQh1yyLayR+X9pZerqL8gdJzHesGz0+HfGonZOdgY+u
    1i9V2R+8shPNxWXXK7YSOg0TcAZ7pcAA1hYWS8N1TVCNEcu9XKfgktq2TB/RNKd6rDmvmF
    gj7ijamBBR8pVTZAF+oOu6exp9bPtALGv95kT0ovA3Bj1qTLCEIJxz48Gls3TOcZm/j4VU
    q/gM0BMDu7z416GO/fNdCj+IZFWUHKYtq05uVzkkViM7rA9AmipIKboEtwrnMInV1uQcvn
    iS0VFR82BnHnxBhorqatxlXC21zhuS78twNAaknXeKKNrfsQwiWCog1D03kqIb4oqMapJm
    6QYFC2sKIX4UW6IOEaxnfOVMwqch+eC6/D6etcyuujnXGCry3KuUcxrhX+qoumLgphspWy
    /duYRGWTCGmXGVCHQW7k0zIDDLSDhaUg6z0zjpBX6MYUutmWDJJaTK1XuoWQ
X-ME-Proxy: <xmx:laFNatVyz4MW-y2jvfMijKlXrnjMzFAhq_tVOGzrnm1sK0uekZHOmQ>
    <xmx:laFNaqv_8Ecdp84HZeXQWbJ7V8TGV72ZigKP5ce66dJpVY13rZB4-g>
    <xmx:laFNaobX8CaiUr226HVHI03T-jrJjfMZp_TjU5ZpQjuofQ_Bne8QSg>
    <xmx:laFNahVw7y9tVnFnHWTmOcvKXZuW1f7Dz6U9P2orRYlmk7FjK-YnXA>
    <xmx:lqFNao-1lWPFyZIk5kFgQg8LnXQAEqOkS8yQORxyzCtyaD4FBCTkjnqz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 21:02:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 0/3] Teach git-replay(1) to linearize merge commits
In-Reply-To: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
	(Toon Claes's message of "Tue, 07 Jul 2026 21:07:24 +0200")
References: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
	<20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
Date: Tue, 07 Jul 2026 18:02:12 -0700
Message-ID: <xmqq5x2qz42z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> This series might conflict with Kristoffer's series to make
> documentation changes[2], but should be trivial to resolve. And I don't
> think there's a conflict with Patrick's series on adding "drop" to
> git-history(1)[3].
>
> dscho's series to replay merges[1] needs a bit of rework to fit on top
> of this, but I'm happy to help figuring that out. We've been discussing
> to either name the option --flatten or --linearize, but I've decided on
> "linearize" because the documentation of git-rebase(1) also mentions
> "linearize".
>
> [1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
> [2]: <V3_CV_doc_replay_config.780@msgid.xyz>
> [3]: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
>
> ---
> Changes in v7:
> - Allow --revert and --linearize to be used together.
> - Because quite a lot of changes have been made since the original
>   patch, change author from Johannes to Toon for the last commit.
>   Johannes already told me he doesn't really care about authorship when
>   he initially shared the patch with me.

Looks like all the previous review comments have been answered and
the topic is in a good shape to be merged to 'next' (and allow us to
polish incrementally as needed)?

Thanks for working on the topic.  Let me mark it for 'next'.
