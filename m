Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA4220F59
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500076; cv=none; b=AspHcYYjo+4yAeGXezMjxUstP8xFpgSPV+BT+P0dVU4Dy5qYRkG6WdMOO6fle/kMeisL8gVR0qUzEK2XssJv9MDgWc08XWzjFRmWsTeQVoK2FDHd6KVgzczJ512SZLKzpoK6OjyCEBXTByeMeHTSQq1UTxi/O0/yYO7MQ/CelyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500076; c=relaxed/simple;
	bh=cs88TWvgKmR3NCUa3gxE5O8IWE/r7ycjdiC0YlX4BcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZnnZqJum+2sdoLwaYMTVVhuIbFT7shQNSsmFfy0JZo8jo13TnU4p1oaxne0r0inH8TLAfwrwn1iXmXUHsgUHsCEoF9WEElyXvz0J3JgIsGmilXLFiLYtrMTmmvcvWq65uaIIfiWSu2Bdm5xS2beLNcPfWizsKKGp9AQnYxDChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wMIBzjnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnECxO23; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wMIBzjnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnECxO23"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBE8425402C5;
	Mon,  9 Jun 2025 16:14:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 09 Jun 2025 16:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749500072;
	 x=1749586472; bh=03GlhKOfvdldaCWlcXkB7rGXXWFyCqfrDJufAy9CstQ=; b=
	wMIBzjnUMs62jg8n+tXgWXksqX8ijNHQp2bjQM1CrocBYHfWlAqRiK6E9v9fC98S
	DQVem15H3RRgskstvbhdvUCncQ/rrGXJ9v5nKOVR9LnbHRSNXQWsDXoWabUsNRbU
	LuEsh67vS/465C6XD8+/IX6DZX/JDgQdFju+B0QwT+EQ/aQV+Ph5mROFMoDOg2w9
	QAQ3bE4Yuq5jReK0XCadNhgZwgH2MJeq0p8YOOaNdZ634XNgXkY9TWs3b/9OteX3
	Q36jCZSc12MRgLitd9wO5sLMabSbMvLCWm1Xwt/2BwoIXeUbst3RD+G3mAPpf+nh
	XHQsJWSjN2IpmHgpZlLiXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749500072; x=
	1749586472; bh=03GlhKOfvdldaCWlcXkB7rGXXWFyCqfrDJufAy9CstQ=; b=A
	nECxO23EIGttTG+S6jCfaoCfiMFZqi2J2i+to1zQPFPfudoh5BeSa7HT/320S4Cd
	zVfRgZVMVYMpRJD70AI+4Hrtn3luP7csKT19JbuOgKbU3Cj6JKlgRz2RIlJmczkl
	XDe7U/+vlkvMymhMLCn2/EqSQk3sJcLZp6yq5dAoPnnc06DNsU1FMkZI+JSpfjAL
	7qwSmL4x+Vo0tojhq1B/ATdTZzm4uCCOgzih1TGLSOKOiYYXD8XdJMQo4SccrR80
	nsCsuAuTqFkxC8HUsK4ov1d13ea/cQZEP0Stk5M12U+ih5zviCKoRgGh12TcCv9z
	vKb9DVqdAOoBIYQhoI6Pg==
X-ME-Sender: <xms:qEBHaO8pzXHnV2fXlpWUXtCNoHdp6xYvwf3EtlxlkHUbrPnXTk0wlQ>
    <xme:qEBHaOuwUfq1fmzjqCrWwK0DCesEJkLvR615vShUxzYbPS8uHnArj569jusJMm7l1
    BxmO_23D4RdwH3t_A>
X-ME-Received: <xmr:qEBHaEDOv9NtDSNMBLCA66et39wC-1vlMs8cMKToxB4vjDLuI9UPMWzF42O_hVruYHSZl5rxMxsMoLUM3kSiNAwEiHt3JLNW2_M4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeljeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughith
    ihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qEBHaGe922MAi9KLa_5gSsA0oLCT9X0PnhYrcaz1N74KiS5P7fc5rw>
    <xmx:qEBHaDPz8Rkqlsfa_ITt-3lFCmo3wufVYtoz_i29XCdcafn9b_iAqQ>
    <xmx:qEBHaAn7blreqIYMdUlIn6EVDX5q5WVV6JEgP8FFQzkPnRzt0UgpqA>
    <xmx:qEBHaFuKtOPRnWDwKvTIdN684gt2abwGbTDJZkJDGBf-DJlS9es2Jw>
    <xmx:qEBHaFrdaw-9kmejdKUS-w5L8kVkrS8Ae8Txqvm4AdFwjAc3FDpi--Sb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 16:14:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  brian m carlson
 <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 08/10] imap-send: display port alongwith host when
 git credential is invoked
In-Reply-To: <PN3PR01MB959765D8A6621F155F7C756FB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 9 Jun 2025 19:02:43 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AF90BA3D4B3295ECC278B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq8qm0rbgo.fsf@gitster.g>
	<PN3PR01MB959765D8A6621F155F7C756FB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 09 Jun 2025 13:14:30 -0700
Message-ID: <xmqqv7p4pt95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 10 Jun 2025, at 12:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>> 
>>> FWIW, if no port is specified by the user, the default port, 993 for
>>> IMAPS and 143 for IMAP is used by the code. So, the case of no port
>>> defined for the helper is not possible, and therefore is not added.
>> 
>> Shouldn't we do a bit better than being so pessimistic?
>> 
>> If the user left the port unspecified, or if the more knowledgeable
>> user redundantly specified the default port explicitly, showing to
>> such a user :993 for imaps at the end adds no useful information.
>
> Maybe you misunderstood me? I want to show the port explicitly
> just like send-email. I think the FWIW line could be excluded, since
> it's more confusing the useful.

Yeah, I read your FWIW line to be saying "even if we wanted to tell
cases where the user left it unspecified and the user set it to a
value that happens to be the same as the default, we have no way to
tell (unless we add some code to record one more bit, that is), so
we punt and show port regardless."

>> Perhaps something like
>> 
>>    if ((srvc->use_ssl ? 993 : 143) == srvc->port)
>>            cred->host = xstrdup(srvc->host);
>>    else
>> 
>> here?
>
> That will not show the port if we specify the port as 993 as well then.

Yes, that is exactly what I was saying---if the user set it to the
port that is the default anyway, or more importantly, if the user
did not set, it is unnecessary and/or confusing to start showing the
port number.

If the ISP uses something non-standard and the user explicitly sets
it to that port, it may make sense to show it that the user is using
something non-standard.

Having said that, I do not care too much either way---if we prefer
to always show port, that's fine, but then the FWIW part definitely
needs to be rephrased to explain why it makes sense to show even the
default port.

Thanks.

