Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FA2BD0B
	for <git@vger.kernel.org>; Sat, 30 May 2026 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780179505; cv=none; b=YmJZlNfmAiXEUQdST08o8iTOE3t3chdHXuh7uj8UTuNrs20z/zQmfV2yQB2KA+rHNKHitAGqBghQs6GIgbgNfw1RjQFKLf9eODMe0YWgHgIwFfg5anQWHjFa9fB1LbyCjXgjMIOcUYQB6PECLrXs3yakhBO8vq4rn8YyHTrHgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780179505; c=relaxed/simple;
	bh=8khLUZsEsN4A5jXRNXTzX6C1GCpba9IINK55FDizUTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dukm3/R0+2Ilzb5BsL6dp8N91wCUlZhj0nF7KfMENc+5fDODZVkPsNjJh2JVVHYEjlQ0ui8sXDwnJdfrsKcK572GaAewGyi2Tv+Qhf9ufpwJdj9P21iDQkZyzmCmRVWDnT/wQpVPPJZnUCEg2lNsPo7SvW7pzn8sXI3MisqZEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HJlzkhdy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MrS7Y6Xq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HJlzkhdy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrS7Y6Xq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBAD47A0077;
	Sat, 30 May 2026 18:18:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 30 May 2026 18:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780179502;
	 x=1780265902; bh=8khLUZsEsN4A5jXRNXTzX6C1GCpba9IINK55FDizUTY=; b=
	HJlzkhdy9rStf/kAg7SnqNiqKjL0zjxoBgtEf/tUF2a/pDe1etW64TE6rENvxkqG
	vkG0i9AebUOJVL1MD0vx6vmqPo579OXnlVmjCObAqIkZydBadCGciMgLqmFhn88K
	uXxitKl/4B1tAyJUxQOvJJ9aOgeUxypPDF8vOU2HYVR1ddPc4Yy/d55DCqW7fHu8
	cho6wc3FhphzEENfCiL49bhlgK1BOesAKgZelEKv2RBtnWpOBnDbNPXoU/FP4Tt9
	TjoTOGcH9d218jNxsrMdGhxJBECnrve5WPFpvd0WTek3+gG2+bfafrI2cUfOYBs+
	aXX85EhEsS5xzV0TZ6q2OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780179502; x=
	1780265902; bh=8khLUZsEsN4A5jXRNXTzX6C1GCpba9IINK55FDizUTY=; b=M
	rS7Y6XqB4hNOZ4p0XxTs4rvvp2GgI+sIHHCbCHVa3Rdcic528HDbV764CNoUkaPh
	1Nov08KGKDREXc69+LcPq8HMqAq3ASjPk669cyg2ema7q1hFamt7iH7Si3qxjHFu
	rPWcYjGN/Nhd5HIHoCY0RmZnygp2zlTTHEL5F9CqMVnmsDQb/GvQQ6E7nAHKw1xq
	0huTctzk4jawieWtn4C7Ilkc5jtGLFCXq4R0yuEVHSGHs9eASuI3L6idkk3sll5l
	I3L/RdReofFNDFXbm+Zzz9Sz0fCKLgyGRIxlpD6FUgpuRuhBs5RAamUnxh6jCnK6
	NfyFRxUnQhB7Shvp+MUfA==
X-ME-Sender: <xms:LmIbavD4hTD0-fgUpQT5svs74gMJXY1ZxN3s34TqtHi0UrO9hhiTVw>
    <xme:LmIbasaEH79rnaNbnx5XISZp7ywR9uMoxcBJ9938tbYNrcyz0mdxxeS0W8ZYfsVd6
    oYsbvWRw7QfZDHV8eDXOFj-8TlblPgP3fDhk1AFV9Igm5d_Uk_k_w>
X-ME-Received: <xmr:LmIbai7_T2-CseFbPCrnAw1mE7uOSXsTwWzwTub1Q4979OmXai1uTy_1eVh51ETFicdERMvx-_jNbtcoF7PkoBT_h031UwUiMr8_>
X-ME-Proxy-Cause: dmFkZTEL5NHU/wSgCwOk3GvEaqAchbuqPgu8kdW6rjnPtDu2sgxe+3WgGP+yWuqxpQwvc/
    J6SuouaO0gjKqVupPyE9DCHgPK82zRkv1ZzyjDNIsAfDU8841pXsmfaheJ7+m3J3+8B6Tq
    hK5/rRcr0rrnnsS+j7nG8qQQOJDNkkcEpVFWehicZLdafFGaPXYfV9iJNx33TyJuDuky33
    4Qte7LbzPXGZtPqLab5IzlfpB+BHutDqcBb8/ZDPSxd71TdCKZg5k2QTfqHfdT5AZ2P5wR
    hh4o4/f5Dq4JJmpBfwK/GjaGqW2NqJ3n7cV3RKp5hnJYRL7kM7XmFYtP9J2dlM7Z1422h7
    Jeo5QJ4IleLiAwkmDdTFU/aLkih7UnxAiKyeSnV/nEYymi/clpAGURjBm+iz6vOflViDrd
    KtZXvjKzVHnMFGjssDvBrQQPlnrzJ02eGUuk+Cqf2FrmbzmFAiLEO5XvpU8F3kEDZ/1Cbp
    k/pVSHA3+Mr25j/PLvgKDqTJGGYq8ghHYSnBNYTBtvWypum5aiPMiHSplHOCsPo9h02Eg4
    oBzOBJk4Ffq4nJsfdYn1ixv4ySPbk+TFxVkEMAS89WQeg2ZM7mjvLFvV42gE66aCeEcO2V
    nt/X/0pQiFCTXxMp8HmUAjVUhE/gOpekWf09IWDLd4MPurbQwU4FRcTWhxhw
X-ME-Proxy: <xmx:LmIbatYkXOwyBWTfktyFGNLySMFko39rpcI8nwGPBbnEfifyTVgjjA>
    <xmx:LmIbahiwsSrNMYqLR-Jlq7eC4TC3IzZ_TkJ6jLTS3Mx2JjyeDCcSjQ>
    <xmx:LmIbau_j-ftVp-ILD2sNWocIbBo41I4HclseXPjkoHphjxRGuNlb6A>
    <xmx:LmIbasoOvISF4ng7ayQGYD9nNwwV8bIVX1C0UQ7pT-CCgs2NLMhpwg>
    <xmx:LmIbaoqusg8esQ6o-2mTARHgK6PAD1dlr1aVvwjPO4tK9NbVoPaQ3A8U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 18:18:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 0/4] doc: replay: fix config link
In-Reply-To: <CV_doc_replay_config.709@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 21 May 2026
	20:01:57 +0200")
References: <CV_doc_replay_config.709@msgid.xyz>
Date: Sun, 31 May 2026 07:18:20 +0900
Message-ID: <xmqq1pesh783.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> [1/4] doc: link to config for git-replay(1)
> [2/4] doc: replay: simplify replay.refAction description
> [3/4] doc: replay: use a nested definition list
> [4/4] doc: replay: move “default” to the right-hand-side

It is always nice to see documentation gaps filled.
