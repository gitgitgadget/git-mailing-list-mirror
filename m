Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640B27F732
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884830; cv=none; b=P4bCpaW0z5iz4LVAiwnBQXNTI9TIQzq3Jreel83kpMuh8BnD1Yh5CJMU8J8wSka9us7QG9gnM5RfLpOSKbFrTTOoChNSUbAmZ5JcSauBM5iFaWXwGK+5ycq8m3Po1k99dYiN60H9b7d+uaRYMkLkbW19UOxCi1i6Vbhdohtnpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884830; c=relaxed/simple;
	bh=Qh/+VW7MCBmy9sehzYjU8e9J7q9TXNyfWvc5ZakKpoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nTl2PpAPRRqxagQwRq7reyi6JrGb422yUR+OmCGxQPBflDGOs7C6a97QsDTYW5VOa8IbauUL6DGdqmMSZ3VpN7HyiUyoWuGN0+kRntrClfF6jdY1Ink9f9zVmjC6No3GUHH9VDw4Kgfzhl9ANBpWe6E4plu9opKLtIIh43mAOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W7ZZefK8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JcHvlhOc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W7ZZefK8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcHvlhOc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8339BEC0079;
	Fri, 22 Aug 2025 13:47:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 22 Aug 2025 13:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755884826; x=1755971226; bh=OW/A0TMyPp
	Q5dn9BY+KAVhXnnjY3uz0yDMa0HNANJ0Q=; b=W7ZZefK8rwptmz3vyyz2kXnHRo
	jtmoZYya5bmbXK8Z4LBqMXa9LnXlkMg5X7ks6fEAYNdbLxPpIvFAzaD82p+4LZ6I
	TI+YjyhSY3ocdAq8v3tNIRvjiRuwozNbvwcHXR8kSbb5yvNn0RkJqmOUCoAQbH+a
	fg/JZhmX+0pdBRhb0Llczft7k110gUxEUPmLF4inACkuiXwJCVU+o4GuI3OjmeSJ
	IXYP6Dl1pRF6b9OprRLtcGtXj1Bs0F5XhI7iA4ksqBSuMozrds1yzEMkuWXRezfX
	z1dc7vIvsQFz2Tc45qR7fSTaedYFer+rrEqx1fzK7O86ciH2FOyxZISSNccQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755884826; x=1755971226; bh=OW/A0TMyPpQ5dn9BY+KAVhXnnjY3uz0yDMa
	0HNANJ0Q=; b=JcHvlhOccrqfx4VOy/NkT1vTSOhc3M1M0XWR645fQ4LGAXO1QNc
	+qepQcHXJWx5vOfbAA4fJ97fyh63IcKVLD9Sj3JWXIt0f/BTbA8cc0BT2PUiqsVj
	KD+lx48hd+g5qzry+EvXpOr8Tur7vhTJncEYCq5OkDFx/IcASNlJTZmFAyN7ejmV
	3LSLCJiDzHLmqIK4sMTjakCulsKJHw8DYxK4GbQzUUTPXeQV8a3c3kUz7HVNh8Zz
	BWV/r/Z8mR/8sTEuaHTRhPOuFqA3UQiGZyBdDAAnHPm0AP2ehgu2TWtdGC/kw91L
	y63vZpt6U9Kme8RLPpyh9sVjYB1QFzAMLEQ==
X-ME-Sender: <xms:Gq2oaAv561Ajz1FvIvfSBKxJqfS2VgHurKFM99ie_mQYbiwLfVP2fA>
    <xme:Gq2oaF5GIN_mEMOgm6wOcKw0952-FCNyKK25Mc-JYgdFiHpZ4s-QfpietohjEas8i
    pw5Kpr-RT8ipY6E6Q>
X-ME-Received: <xmr:Gq2oaMPZi0auDs352HK7bQLffHjAX9XKFKN7hKjEZOzdOJgJGidmLDv1uV-L-zJvRqd1xbHTmFD3q8_Dji5InJgJOOmgbFF1GgLP1Ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Gq2oaDu5au8DCRp_C4_GlYiu_27mAOMl3kFCv9-boH4Kwg4b8HWH6w>
    <xmx:Gq2oaPb-b05RkBqq7xdUptlSOd0dW4XL1JHBLQyhMWBJKgzDIuwTPg>
    <xmx:Gq2oaFwJkXEBDykeJ2-lGFFGV06BincuNT3JYAmV1ocURsQdCHfT4Q>
    <xmx:Gq2oaHioxxD18S9mPnFsgAy0GCxOCOPzrAllK--7VNa2GYL9Lr4Eyw>
    <xmx:Gq2oaFInadqP_r66IZ3wj1twMQ1bW6iBxjFsbauEXbMVP4X5SzoDoMEs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 13:47:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  Joe Drew
 <joe.drew@indexexchange.com>,  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "lock file exists" when fetching in bare clone of repository
In-Reply-To: <CAOLa=ZS43w74tWjD47h2mnGiyaQWrGEY-UpL8kdXJi_zD0ASmw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 22 Aug 2025 01:01:51 -0700")
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
	<20250820213323.GA1667633@coredump.intra.peff.net>
	<aKbHozlmDIqfgkg4@pks.im>
	<20250821072706.GA2390046@coredump.intra.peff.net>
	<aKbwabLZiWasYoBC@pks.im> <xmqqwm6w3bjp.fsf@gitster.g>
	<aKgKmLvaHAuueJeb@pks.im>
	<CAOLa=ZS43w74tWjD47h2mnGiyaQWrGEY-UpL8kdXJi_zD0ASmw@mail.gmail.com>
Date: Fri, 22 Aug 2025 10:47:04 -0700
Message-ID: <xmqq8qjbxn8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The fix itself isn't too involved:
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 088b52c740..5c31b02e6b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -776,6 +776,8 @@ static enum ref_transaction_error
> lock_raw_ref(struct files_ref_store *refs,
>             goto retry;
>         } else {
>             unable_to_lock_message(ref_file.buf, myerr, err);
> +			if (myerr == EEXIST)
> +				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
>             goto error_return;
>         }
>     }

We assume that the existing lock is what _we_ created to lock the
ref in the other case, not somebody else locked-and-died some time
ago, or somebody else locked-and-about-to-update-competing-with-us? 

Without this change we'd return REF_TRANSACTION_ERROR_GENERIC; does
the caller treat NAME_CONFLICT any specially?  Or is the "fix" you
talk about just about giving a different message and no other
behaviour changes involved?  I guess a more specific message that is
99% of the time more correct is an improvement over an overly
generic "some error happened" message.  But I thought the original
issue was that the user cannot make any progress when the ref
updates are transactional.  Does returning NAME_CONFLICT from here
tell the machinery that we are allowed to break transactional
semantics somehow?

In any case, I wonder if refs_verify_refnames_available() should
notice that we are using files backend on a case challenged
filesystem, and change the behaviour a bit.  This additional check
needs to be implemented as a backend call via refs->be->something()
to tighten the outcome.  It appears to me that the function in the
current form does not even notice a D/F conflict when there is a
branch 'd' and the transaction requests to create a new branch 'D/f'
on a case challenged system if files backend is in use, since the
function is in the generic layer and behaves case sensitively (which
is the right thing to do---we are talking about detecting backend
specific glitches here).

Thanks.


