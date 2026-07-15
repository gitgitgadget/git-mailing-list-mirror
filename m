Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1C2BE65F
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784135901; cv=none; b=mGO1+29mBj2orkppEImyI+4DJambCu+xkUGSBK+PhUjyHoZ3joGcHpooY8xe3DPWyu4hv9RUOEOfx1WKY3LeuKjbLSo95ryZMLRTqjoxZJQo+V/hDsaJQHanIqqeYo7ZiR8F+74LLz5M0v/0QF1gzLh4N014uW+qEPpIgdKSUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784135901; c=relaxed/simple;
	bh=p5By2Z0rR/1gHOnTn7HYJurd3O1eXp+lXPY6ek8F7B4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CNg017BJqHKSUTDx1S5BO7uXhE2otsf28FWJmh/REK08tYPVA1Yb8kELTSMazvCAmXbhKnf+MY5/OWV3/yJXeYn7TKCF/qlwYVSW94c7OgFdwUdBOYbNVAFU+SDG4i4K360whA9aVY5dECSIIqWeLNNmFWdEdSfaZ7qQU18WRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QusDRjgd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3u2AgtC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QusDRjgd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3u2AgtC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C27BEC01AA;
	Wed, 15 Jul 2026 13:18:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 13:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784135897;
	 x=1784222297; bh=p5By2Z0rR/1gHOnTn7HYJurd3O1eXp+lXPY6ek8F7B4=; b=
	QusDRjgdb+O3nRko/Q/4UlOnDfR6Y0jK+VCmz3aJ4HhZVfBOZ1POrotg5q8EnFxK
	l472DAqwG7HefhLbQ2gLXxNYrEjEbF7ZALhfeNG4HTUVwZRG6lvILXZugfdUtdBn
	KXhVVcTq1jTydPbTTI/my4gRfUXXjYF9pZwQ8rSaQ1a8GmHXY0ZTP7V3x1kZN1vj
	hsXM0w0zxHVaqvqjWJ0fv5jCJ3ImZxRgbG/anBf6Px01mKYqC6Y6RHfsn5Nq1NPr
	brd/ZL8AEoTwmspwvUXoclXrkd+obPPcKmF0Bl5cDgjvnxvByZd7/AEynf06ewMR
	JpBT2XlDqPl2p8reattgvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784135897; x=
	1784222297; bh=p5By2Z0rR/1gHOnTn7HYJurd3O1eXp+lXPY6ek8F7B4=; b=m
	3u2AgtCQjVZm97LMixjbDil7WC7mdOWm7cTyQnklD3j/lzgFth1QxMTaEeg4TVCH
	6MuW/GnDl1rPFuoemZkIabE3/Avv66rP+b746Vwa1i186W9h5YVkK8m6/yRefq4y
	I/3QyBCyq0bxTIqjTTqNz8HVJ+/lKrk/EaSA208I1sf1qVEuAKrX01/VS4Bo3CGN
	RNMoZQl+TpP70/4hp/5ojdC/2IM9n/cJVG9a0NR17Do429t1hQakNGCIN0duKY6x
	iU2fPnxC9przbvHxx+SafLBAXcpeeHqrCaarrdy7rPz/q4Xilw9Gm0HQc5WwzYd8
	sFq/z15ixtfOadJokm9ug==
X-ME-Sender: <xms:2MBXatVS0LR4xZ4-isdBpmSsDJI8EDO8plj2zvcA9RtLP5Fg0dshgQ>
    <xme:2MBXasqd48fXoXAgGK8Cw5_e309kRYEG7NL9lrr5X61MpRY1lQP5dcRSqUt5wZTDp
    QnpV-ei_OtOSL9ccRRedq7Bdp--UGgj59VudUzIyHBt-aAQChqXUA>
X-ME-Received: <xmr:2MBXavloctG6J5uesP26GXuy4LE2uLCSYKbtCRVXy7TyZUZNH-NLfAXY2_aiwpS9yGCeu7Hb3dZSuW-uN8y6SPEs56nQXNWgrelfw-I>
X-ME-Proxy-Cause: dmFkZTFEZb+6t4G8sGrAFOWFp0sb3/e7xeLOu0HlsNZylQL8ez89VKFxwVnJt1xJDcyZC9
    nqubDTt12Vbp/WNRE2GktHUvecMP6h08xPF3S6HBO7sjFzjapQJ3FDeI9psjXv6qYHcLCe
    9Elr0bLcpcRSLJG2vlZhe2lKhNJnREnoJOkXbUo/0AOK4Exd5s8manap583rdKI0RvVGFw
    VI8l2Bv0p7KhTyVDS4MWPCT6GSUeRNCF+MtuKU0otnXwJEz8Tp8rzcviUohY1UYatVl7Cc
    NG4lgkH6XREMV6H66h2IKP94YwsIGKq9NpG+3ChTvHDX+yqq62RCTOsa3vc6ZhEHRFt0Bn
    s9cm4RMIuNwacwUTb2sYXsa8nBBEp6fkoqXXK81LhvMkAEch1SynZS3wsr6xdV87K9uB2A
    aSyih10k7M1bWBx0laKTiMSfXL+Z95pm3YZmHCdh+Y6ItQqW2XK8jLmtcVTAHaXNw0P+jX
    LTdzLy9eRvXSb724p3UAOlMhqtmf3roSryC1zi+JdN40IiYs2cxq8zgULjIviHT97v2h9x
    v+vawt6fm4ey9ek4GNFAcjxtuOnuyo3YA8yd4AaamSPBzUpyLaDMiQdwRWqukA7oohDUSQ
    9049X3HryA8nQ0bOn1PK9OG12NF6o0SsWQqmFwXdJQ5b7RKz8yvRiodiDuSw
X-ME-Proxy: <xmx:2MBXas2FeyA3wNsi5ywu_VMNSw4f3ErZv8NepKxbRhU9dFUdXc5SCw>
    <xmx:2MBXasS0CBaaWMf1eDrnfE5WHOTluCwmKaC-0Z0xbxg6q1oW2EDT_g>
    <xmx:2MBXalwNhbHlsd1qrhs71_G-DQ-09ZrzmuWaZVfMl93gIo1GGOidCQ>
    <xmx:2MBXasCoOruuY_LGjql-ewH-0AeyXrbg3C24FdKWFdmybXFklS0XvQ>
    <xmx:2cBXauAEBxr9ZfAAD3TfL5_ZBCXUfiJglLGAEtc6qNe3twtxILrEBC6S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 13:18:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  ps@pks.im,
  cirnovskyv@gmail.com,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v5 4/4] environment: move has_symlinks into
 repo_config_values
In-Reply-To: <CAP8UFD2=FbbnCqWkTLEGBpz=90sh=j_70h2UJR=p4uj6u3tqMQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 15 Jul 2026 08:21:40 +0200")
References: <20260619162105.648495-1-cat@malon.dev>
	<20260715035501.48271-1-cat@malon.dev>
	<20260715035501.48271-5-cat@malon.dev>
	<CAP8UFD2=FbbnCqWkTLEGBpz=90sh=j_70h2UJR=p4uj6u3tqMQ@mail.gmail.com>
Date: Wed, 15 Jul 2026 10:18:15 -0700
Message-ID: <xmqqtsq0npd4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Jul 15, 2026 at 5:55 AM Tian Yuchen <cat@malon.dev> wrote:
>>
>> Move the global 'has_symlinks' configuration into the
>> repository-specific 'repo_config_values' struct.
>>
>> To ensure code readability, the getter function
>> 'repo_has_symlinks()' has been introduced. Callers access
>> this configuration by passing in 'repo' when possible,
>> and explicitly fall back to 'the_repository' the rest
>> of the time.
>>
>> Note:
>> To support early platform-specific (MinGW) overrides
>> before repository initialization, a global variable
>> 'default_has_symlinks' fallback is introduced as a fallback
>
> It seems a bit redundant to use "fallback" twice in the above sentence.
>
>> in environment.h. The *writer* in compat/mingw.c can only
>> access this variable.
>
> Otherwise this series looks good to me.

Thanks for helping, Christian, and thanks, Tian, for working on this
topic.

