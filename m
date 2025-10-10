Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1936B
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760057149; cv=none; b=UsiM2m3sO1/EpRODrX439OVXbcUh5GKSckD5jtO1S2ruHKIShxupRFaCi8gHKSpNX1rL/OoQLrNrsHgNtdOav71TcHjVWo/EZ4QQ+y7FxaBO8HJpjGTnnewdCPK2FXHJiSDU2V0Uz5okBQNRYBYjEUmt05rRqpVVK+iTfkSoTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760057149; c=relaxed/simple;
	bh=dagCqV8FSRl8whrYLmBmPtKZg/mT25hdxH0lO8YoUdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pg1cvAchbXhjdla4Czc7TIhmB10KFhQb8eC9Ml9/j07pCkHYzR0p+fFDwhPlRbrz9ph03PS+mTOYZo1gy/W2sPXcrCwj+JlU6RrcVn6w2cZfgZOS/s0037yxxI9SYv4iJSHMqN0UzhMgNbI2gBGWcNzS5Z/CzJw2sUo1H4u0v0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AiN1M3HE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSVctYj7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AiN1M3HE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSVctYj7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72F0D7A0172;
	Thu,  9 Oct 2025 20:45:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 09 Oct 2025 20:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760057146;
	 x=1760143546; bh=OejcwP3QqUOPZ9QH8Jyzg0pzn37WBEig4xDyu4Q618g=; b=
	AiN1M3HE3ZYpOGxV5LsTC6p/uIChEbmLhrKObNtZ+01oxA04M4oIvo0fHH56ThlL
	hjwHp+2xo6ya+/gd6l35sNj42ZOu9Ch0vQX17WQN8GtzjRziXwEPqnNeTIwXuX9N
	Eci8HTlLkyhXQA58HElTxHoVnOdbIYhL82hwJB8yJKq8RVa6Dm8lQM6cR73M8Ofh
	waV6bOpI7JW8VwDuMHReZ9Yjf7/NoT4eFDaqQoWzdjLbr/WVwduQmb7+eY7yAIN3
	bD9GymWJMuezISv+TLzxvuGMHz8boWBcQSTdq5z+mmHUenx5DX4QRQlmxgzoIvUt
	RthP3t2WO8eEFhBHPAUtug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760057146; x=
	1760143546; bh=OejcwP3QqUOPZ9QH8Jyzg0pzn37WBEig4xDyu4Q618g=; b=d
	SVctYj7xuX4a1FX6F3/hoT6X2aHkZX+32cbFm4Bi85xHzXDIlxI7e+uhGVMkknUD
	6IVskF0+uvfAaLCfZN8dk3MSN2VZBq3eR9/Ige4oMiwyHXAgSAjx3JCnMCyf22ny
	wMKHQ24WfM4biCEySqEF+VlabMi3ZXL+L+jIlzWV5G7qcb0rSNZqOCtE8Vwtc4Ff
	eFX+S3qOxOABibqfotH6fSsTwo7DfA3Qu54mWWvyNxccr7WdvyL5K6R0rrnV/X+r
	uA54FLaxVJ/1rk4OxT8XE6RFFO6g+ztXeOW3jAjkoZIcikD52l+h3yeaAswOHel1
	+omtl6nodnVchq+H61V0w==
X-ME-Sender: <xms:OlfoaOH7Mx0-JxK9ObkXKm-5GqV7f4jzJ3lSLCItoHMZfDPUBZ_D2g>
    <xme:OlfoaGUlCdhobhppd-ZuAkvi0XaJ3bBu09757Gevo6uDeN-C3fgZ-G9UOUHmwbPRU
    uqsNT5C9xODoib4AjvLrmITAWo3p97z3Ib_DrzqYOi3yM38bBSWzg>
X-ME-Received: <xmr:OlfoaNK3g7CZhYizEJNkiw0zb7ZEMGPwnhcbHPq2HNL7wi9unqOGqo5F0o3oYskIoolrknwmOxT24eJ-ddN0GrxlVwA37AdYinCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehokhhhuhhomhhonhgrjhgrhihiheeg
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OlfoaG_-8-lLIL5Kst8xp4acVtPSZtTdQiVsloSNEvi8WSw4VYls1w>
    <xmx:OlfoaAJFEFHMlSMKgmQrpvYla7GTXVIZkE02F18DNJG6vV7K4kx2mQ>
    <xmx:OlfoaLl7W8pp3LEtBuxTg6g0V3P_iXPF2L3whdbPbjtviyT61sPKlQ>
    <xmx:OlfoaEP3kl7OjivfcpI4jLJ3Pznx5Pmz8l9JTS5Z1Zoaavdp8e1ZSg>
    <xmx:OlfoaIoY-nDBrOtv4TEVZOf_OukW44cMP-ZgI_-mFqU4mya0t9KXn866>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 20:45:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Okhuomon Ajayi" <okhuomonajayi54@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
In-Reply-To: <a299c0ea-8eeb-4a21-9924-ebd7c6f6e0bd@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 09 Oct 2025 23:46:48 +0200")
References: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
	<a299c0ea-8eeb-4a21-9924-ebd7c6f6e0bd@app.fastmail.com>
Date: Thu, 09 Oct 2025 17:45:44 -0700
Message-ID: <xmqqwm53bn47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Thu, Oct 9, 2025, at 23:44, Okhuomon Ajayi wrote:
>> Fix const correctness warning in patch_id_neq() in patch-ids.c.
>> ---
>>  patch-ids.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/patch-ids.c b/patch-ids.c
>> index a5683b462c..4a72c2cbe6 100644
>> --- a/patch-ids.c
>> +++ b/patch-ids.c
>> @@ -42,7 +42,7 @@ static int patch_id_neq(const void *cmpfn_data,
>>  			const void *keydata UNUSED)
>>  {
>>  	/* NEEDSWORK: const correctness? */
>> -	struct diff_options *opt = (void *)cmpfn_data;
>> +	const struct diff_options *opt = (void *)cmpfn_data;
>>  	struct patch_id *a, *b;
>> 
>>  	a = container_of(eptr, struct patch_id, ent);
>> -- 
>> 2.43.0
>
> Can’t the comment be removed now, though? If the cmit msg. says “Fix”.

And the proposed commit log message should describe what the problem
is, why it matters, and how the updated code is better than the
current state of the code.
