Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AF1E3784
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340772; cv=none; b=eSrhohbkqmevmXQSAizvSRZ1hzQGfxSUn5QmcufWUL3gcs0FSyzY8qJhnxfr3s6SyrU6zbCyT8IFUcHTIttQKogWbFYpLpCPhzqovo8vpuebTd3oR3n4rMU5EYVdlzQKrlwk+H5dNP5mK1NjlfkCN/21knTmdd1WwQ+ISkmY4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340772; c=relaxed/simple;
	bh=ErBViTOaopZjHec/u9paYzFrQIGxCSEEs91yaOKpo68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CvTaZOL7Wfqdmy0jmb0W97Tqqg0+rsx1M/V4JtqC97tJtE+4B1H4ps2XfPD0losjx72e46miTmi/KsMyllfNoKj+3atd72YtipF/gRebqDiVNqJgu6JDzQn6kGQ5zgm4T8AdYoLUHJxzu4SKI94KPc2cGTKu8e8LELm0M3T4SFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J8zDJsoD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkMdlNAq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J8zDJsoD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkMdlNAq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BA851140149;
	Fri, 31 Jan 2025 11:26:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jan 2025 11:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738340769; x=1738427169; bh=BVtZQDfzh3
	2ZBPcoEb2bk3wlbN65QoiGDzWoxJkvr3U=; b=J8zDJsoDwJYLJebVbUMUqKb1T9
	N9nKgNIGKTT7QFcJCu0cbyPV5LLEAZonCafV93p7ddO3BX8CUJPLW4a+6/kmuqm0
	gkQH8U+5RnsqJe80iy+xH/GxK1/FOg8sjDciw+fT+8Ru5tUliJhA3Qqfj/yO9sWq
	75iJ8VVGxwvjTosjQiNWh6wmCWl9Vb4K76IbVnPVYszdBabSgrisryIEYTeoOACn
	pYfiYBcUe8KiATmXF7PdkVdlhh/bjx8Up/ZwggzsmXz+GSHzqcPxAdU+pVUoBUrC
	TQliRue9zCRbLf/dC8nQ5qAwPyukYmoQddbp/wWimxeGfBh9hXvO55DkdZgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738340769; x=1738427169; bh=BVtZQDfzh32ZBPcoEb2bk3wlbN65QoiGDzW
	oxJkvr3U=; b=XkMdlNAqD8VS1dj9/imcWWgdBxNqpahhJoNbt32oZ20ClaJ1LzU
	aAATnWgtln2P3RxqGIhq4UkvzeoZlygXMJTguOib5QRwyyNv9rdqMPk45JiDhMRa
	wZtzRtnWfdI5r3t1++9y+kgRm+faKrf2pB8o4COy/xVO86DUs8cqIg5S4ZMp0Z/D
	BzGj5YRTOIcDdu1JwXDpbgMUmP4RhWaRAh5WakRJTpxjMjuQflFd5viLaMQ/6k5y
	Q2pz2ckDua59G/iTLCtz3rRMhfBSO/DgU+cRkMZo2sJmdBP8uRNX9cCVNQ/QQgNL
	oHrfXEGhsEaTz5kbIpTrNCF611Bjk2TdZig==
X-ME-Sender: <xms:oPmcZxxo32kvQtK5ymfNlO7kjZddz0YH9hAEUtLrAuePSMO-WA1e3A>
    <xme:oPmcZxSYblVAb1x22oQmP92ns91yK75FTvszuVO4-pseiJjxEG0TmIQq9GQhi3F81
    O0cj2P3bOMExrl0MQ>
X-ME-Received: <xmr:oPmcZ7UQiT7GPhcKR8AGWuDcBOoLqmkGlhZafS7huyoAB0iYVnNKgw5TNL1_lZfdr6D4Z1OZBAKYyA_blVO7KO6P5HOkbmrpa4kp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhhihi
    houhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oPmcZzgnHmd1daA6gIuZ9QJ-m3K8XCVGJ1kiQVfZjnXX_s7GRBqT6w>
    <xmx:oPmcZzDH9vL7jL9WnFCIj-N6rz07I7HPLEKMEKQnMvF9ju4hHbwu7Q>
    <xmx:oPmcZ8KLLuu1nOU7CoiKm8sbu0y5FbuTcqb7iP97_Fjlxi4RuVzzPA>
    <xmx:oPmcZyBf13k8grbXtZemNYbO_tliJvxGI1sH3DOUSenM118K3c9gEA>
    <xmx:ofmcZ-5yegrNMZxUySZSiXlbeDpSxmRUu-nay8xQeMvC0gAmKN-9iR6h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 11:26:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jiang Xin
 <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/8] t5504: modernize test by moving heredocs into
 test bodies
In-Reply-To: <CAPig+cRnm9z06YsCRyTJGqTCF_208BuD+3QoEKqwO7eWTfesAw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 31 Jan 2025 09:28:01 -0500")
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
	<20250131-pks-push-atomic-respect-exit-code-v4-1-a8b41f01a676@pks.im>
	<CAPig+cRnm9z06YsCRyTJGqTCF_208BuD+3QoEKqwO7eWTfesAw@mail.gmail.com>
Date: Fri, 31 Jan 2025 08:26:06 -0800
Message-ID: <xmqqa5b79cgx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -78,6 +72,11 @@ test_expect_success 'push without strict' '
>> +       cat >exp <<-EOF &&
>> +       To dst
>> +       !       refs/heads/main:refs/heads/test [remote rejected] (missing necessary objects)
>> +       Done
>> +       EOF
>
> It's minor, but to make this conform to modern style even more, it
> would use `\EOF` rather than `EOF`.
>
> (Probably not worth a reroll on its own.)

Yup.  The rule of thumb is to quote the end-of-heredoc marker when
the here-doc does not need interpolation, to serve as a hint to tell
the readers that the here-doc is a literal text.
