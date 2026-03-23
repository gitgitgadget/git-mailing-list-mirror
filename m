Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CD3DF00E
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296394; cv=none; b=K9PN44/OWZqnx7lgwqitenBO0VNwvSlKXRUGfbCbWISSq6CsBu+xMKFvvODUd58uYJtoiy3bFWUieAc4i4wP12uXqRSvIgJWV/FyoesbZ0FnBGh6meDB7lhJRbHBYSYAg/nboQML0SIlV+yZlRREADzqo5FY+B9mlShLDkp6tPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296394; c=relaxed/simple;
	bh=oH60xiWekspo1rSgb+2Cfj490lHP3kVg2tw/coM+z2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0jFWAbnIiu+H34aCQkC3+RKTFdkcABJTr7Y4+hkh9CwrquUpUNyvxwA8/jbIEETyHU0x1lN+kowICP7WSXOyYYrxvtv/CzVWPW6ac8CaeE0xZ1jzjF5Qr/WYk5jFV+GU0kCjzW+L0HlRzF2iGqFXW5sOTvfyuSI1WU6C6v8YWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lkoR3ouS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFsL/eYY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lkoR3ouS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFsL/eYY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F19914001ED;
	Mon, 23 Mar 2026 16:06:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 23 Mar 2026 16:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774296390;
	 x=1774382790; bh=fI7sVY66YYcUjsLe9IJvWiGV2NRm8H/ZyF/ZqFEJ6Fc=; b=
	lkoR3ouSaUTBMp8zjRbPEoPlweb+X6yak3XBI1wKYNpmcWd1rRFtOEGQWfB5UzyI
	evO5Gilo4ZW0PURSxlBo4uhmgnE0mXbAIO5/+X258XZqwxn/EdEPIcNGzv+J3ORn
	jSyKz199xRq6SE62YLFNH0XdQmE46lZfN93/lTi/1Hte/Tu+vYbd5uWBYHMhpeIJ
	OyKcyDkVvFvsNVnqw+cnfKou5BSFx7PkW4YfF0sZZdwk0XkPdrsfGMNasECWPY90
	Ww5hnR7r+/Y2R3jDOqwtM9CdCfEsQ73m5W+IYaEQoPiFSXDJkyKXN3YMWqs2C/ak
	pTx4zCkODztC25cRd13Xcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774296390; x=
	1774382790; bh=fI7sVY66YYcUjsLe9IJvWiGV2NRm8H/ZyF/ZqFEJ6Fc=; b=V
	FsL/eYYOl+w7i4QbXQyzKI8aCZgqDYcQupUMcg22UbicaA2Fs+md9Qphj4Ipj2xq
	oqNewl6EBcJzjGpTzZxslLHCaDH1kqQ/uDySrwULqERpSHZVdHxEB2CAkA0ndXc6
	TGQEvaVXSHFkESyuHD8F2dw07Rn5eD3QSxJC1m84X8xOZi9y3MquYbBnPgV6OrmB
	q7d0Zksy7Eo08u3eXJGFLbyWK6pPGtlQUkGGxRvIs5/sGmCYUK1mgwy8z7W/Z8Ax
	FjR4QbjhNWLJ9ZK9qZG5PXFT/zD6qQNmggHd8YoYO9Rd4uIN/f7q9BRdKPTCwvRN
	r52o+PCW/7N++czLymj6A==
X-ME-Sender: <xms:RZ3BaZEJ3ZUqXiDxopwM1GqkGYATj9luqgC95VBCe9Kgp5UgnrwydA>
    <xme:RZ3BaQldL_TmxZO-J9PRGBf21ZOXNbkiqT3YNJHCAkxt018j3llQZDEWEEqzOD45m
    3YMQwUVf3MhtztD1COQNhx94T9Dk51yJ1xNC5BwmMkJ7ajCWUetQA>
X-ME-Received: <xmr:RZ3BadaOUANNiVcCSsDZO1hUAsxNlqhwN6yFEpt_mx8-o-DoHQK-yIWr5Do4-G4IVkn8NqFdU8h-_0wcRcEQrSAw8XxbjlVgbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgr
    shhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohephigvvggthhgvnhhgrd
    gthhhinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:RZ3BaVGDmJmg_-s8ns34M3ZJkXNF5Uhp2twBiBBYheKK_mqDcXDqWQ>
    <xmx:RZ3BaeKDSwCgYYtboOAbnWiLvPwKxUsl8P2oDFAtbSjbvGBuI_XT_g>
    <xmx:RZ3BaQOTSdtr1xOnAS1DU7o4H7WglToZoPCclFtxP0dXi0tND72A4g>
    <xmx:RZ3BaemlBg0GlN-XhucGxk0DlQvd1i8vg_Xu28SiKb0P6zjqZjpwOw>
    <xmx:Rp3BaWNxoZ3iGHyv3_kI9PfFQXrT54RsbNI4Msp-WBSGGOQl4wIZtYN2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 16:06:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Toon Claes" <toon@iotcl.com>,  git@vger.kernel.org,  "Justin Tobler"
 <jltobler@gmail.com>,  "Siddharth Asthana" <siddharthasthana31@gmail.com>,
  "Yee Cheng Chin" <yeecheng.chin@gmail.com>
Subject: Re: [PATCH 1/3] t3650: use option with value consistenly with equal
 sign
In-Reply-To: <ccc995f1-4da2-468a-97d6-f20993ca4b4c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 23 Mar 2026 20:17:56 +0100")
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
	<20260323-toon-replay-arbitrary-ref-v1-1-5c7172f675ec@iotcl.com>
	<ccc995f1-4da2-468a-97d6-f20993ca4b4c@app.fastmail.com>
Date: Mon, 23 Mar 2026 13:06:27 -0700
Message-ID: <xmqqv7em48fw.fsf@gitster.g>
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

> On Mon, Mar 23, 2026, at 17:09, Toon Claes wrote:
>> The tests in t3650-replay-basics have mixed use of option arguments
>> with value with and without equal sign. Bring in consistency and use
>> equal sign for all options that expect a value.
>
> If it is about consistency, could you pick one or the other either way
> or go with whatever happened to be most used right now?
>
> Consistency by itself is a weaker argument than arguing that stuck form
> is better for invoking git(1) commands, which is what gitcli(7) argues.
>
> Which is to say: arguing for stuck form in the commit message based on
> it being better is a stronger argument than wanting consistency. :)
>
> Then once one form has been argued for or referenced it follows that you
> should be consistent and use the best approach throughout.
>
>> This makes it easier to distinguish them from positional arguments.
>
> Maybe it’s just me, but sticking with the stuck form makes it harder to
> mess up writing unintended options and positional arguments. Once
> written it might be slightly more readable, but the main benefit is
> using a style that makes messing up harder to pull off.

I am not sure if a patch whose purpose is only to make the CLI
invocation "consistent" is a welcome change, though.  If we support
two forms, exercising both forms and making sure they mean the same
thing may even be better, but short of that, a random mixture of
styles as if end-user human may have picked one form on this day and
the other form on another day may be better than a complete
monoculture.

