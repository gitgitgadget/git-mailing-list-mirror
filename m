Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305742E006
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142864; cv=none; b=Qrb7JZtfksJBmo43lBCX/95A76lBH1Cns0gp1S2JGDBiNFJxdTOM+snT/9So0KZzdjc2pP9ANgytna/vfFyK8xWMN6/Gm29JMfO3euur8xp8FmHdr9Q6DBVe7pjCDOMjv8sH+v3zaaqnBe4bcdPjbramzbKIxq21xA/9WNKz0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142864; c=relaxed/simple;
	bh=2z5QqihA0URc7vxhnQgQ+77lINt6UTjlkqojpYAMcoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4uuNYTz4Q0sA7dqxGNi9JXIUCg2I0YidqVrOf+xdtAGAoqe81w1sTe0ac9u9XxBIKEtmBPV7HxdsGC/HMAUQFoIn6MEXVRMhRDeLaSMnV2O5hy5EjqcDOYZg9tnGniO4jkvbqS8X1nMhV0a1/fE5chlg71RjMwFtyCkkZ6tBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X9xCm5Nw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pbfmehup; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X9xCm5Nw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pbfmehup"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A5A461D001BE;
	Thu, 26 Feb 2026 16:54:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 16:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772142862; x=1772229262; bh=2z5QqihA0U
	Rc7vxhnQgQ+77lINt6UTjlkqojpYAMcoU=; b=X9xCm5Nwxeh8+w4LH6SvFnN357
	E3J1gkBiD5ZYafqP1ie+OFBLJBiJs/FmfMR/awnDlNS3kvVXC8V/mueDBWD6D205
	EwTU+8QF5K3Rm/PtxeCORE+09hAN880qbKX1Cbq/7a8YIKNiubhkS1AXYm+nYTU8
	vyP+TkhepHSbxvnMU1slZVOa6NMV8FWMLYq75oy4c6rZzb1S64Zl0ObfjaQBJC3k
	LlqDKafZPwpLWj2T2d+xv2rObp5hqpRWBku22tSQG9Ary4z3yt3RuwksOBod0TXG
	BntCFpnf6AqYlKD3BsYF4nHbj9FUdoiWD/A9zbU0M4XxIX4bwGmY3JYm8Zkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772142862; x=1772229262; bh=2z5QqihA0URc7vxhnQgQ+77lINt6UTjlkqo
	jpYAMcoU=; b=PbfmehupS/UHu1vW5Gj2DK2/QWGXwWVJzKK5bWkzMJ/oJ/6Th6r
	wJk+00mJljm7zudDChLeHwAfRitsoxjTTLM71tWJ6KK2YSVXmBUf4OkqF7GGDOgk
	zI7ngxG0h3UtLxntX+bdADjHddx8tMTOpN75h6Nvb9jPHecgBl6SehICflo6aTzp
	u/3fwt4/tdNdD4Y2coYskymjyk34uSe4YloIXZMAAlB60UhOqrC7tSOawnTfoyFn
	IpqIQyKAxuxErlCaE/osj6Y7+nkRHDbKDb7JhpUAlB4FVd1c2U+Zd41xnLf7/ChG
	KTNusSrzW64HLuS+mH6cVHZRqnl3FffOJYA==
X-ME-Sender: <xms:DsGgaXmRkr-vN64yZz46ztImEwdAxGJaS7b5cCuepD4Vf9xHR8-fWg>
    <xme:DsGgaSSeePvtOcBIqMQGT8aY0mK5l25gVLJlNtVqwXDhoXKA8RM7PO1uC01MVq4mr
    F0k1XoMck6ijUTXBxgk1QFADPx-4bPcoB0c_QBe4dIsjX9SOW1FrA>
X-ME-Received: <xmr:DsGgabC1HaaRJdyrL0KbB21vqn0-y_PDbHqgKBkZNX7k9_ltUakhQg1wPwIntS2KB1Dyi22Hyz56eLcaHfTj04GByK4OmJhmjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DsGgaZT_7HLEBMcZ3wD4qKh91oUU7Z8IF_KSlNbzfmDJtamRuWlyxw>
    <xmx:DsGgaZpFWTto-g0BLg7qF5jxy6u9om6m5pBf7zHCD59hkQHL3aDryg>
    <xmx:DsGgabx_FDo6qf5pHluywx5iSfzu68kT2_9YC9_BvVz5sGqbbplGLw>
    <xmx:DsGgaeJUoFxmOIhhkDYZ1dsH8gTJ20bo9nFVzfIX-9SZ2orW8OtkVw>
    <xmx:DsGgaWTdp2LgJRzfOJTKbv-u7SUt8LN9IbineS0RAvpevp4lrtyKn6AQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 16:54:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Bug] With "[remotes] group = a b c", "git push group" does not
 work
In-Reply-To: <20251226185725.51201-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Sat, 27 Dec 2025 00:27:25 +0530")
References: <xmqqiki0ivgy.fsf@gitster.g>
	<20251226185725.51201-1-usmanakinyemi202@gmail.com>
Date: Thu, 26 Feb 2026 13:54:21 -0800
Message-ID: <xmqq7brzw4qa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Hi Junio,
>
> I will be working on this.
>
> Best,
> Usman Akinyemi

Did anything happen after this?
