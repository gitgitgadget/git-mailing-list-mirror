Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4A1DE4F8
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049961; cv=none; b=lrvVVeTOjeX5w9jK0RD5pxjSG/htiioJYBaZyq5CWZQVeRpIYuP5qSlKKg5qkUV9OEdihCssXo4KhF72E7j//HzixWh3+mdzE/EZDqWwTD06iM9pVwvisQb6/B0VAYBY+9ONTIW0ZqZabOoaseTB7VAtyz90gHixuNkLbHzOP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049961; c=relaxed/simple;
	bh=pfB0Qkb2lt8dE58+SDzhMAE07ACH7PBbM17dCcT/Oys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTzMeqllfs0tDSTMrpiQIAvWFbjFMBdcj1ENQv+mV5RG+h75tuo9S6/fLu9evK13BKWAJoTq4qOhJpyKt7lsnmvVqqPneEsCpX4gmWwuZ4cju2V4IY9tfaESu8EzQrugXLla2NODaSCoR4tH7ZPWaEvJNPOWzzFgF/MEMwtxV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FiLxlfSj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vuml2EzU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FiLxlfSj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vuml2EzU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B613B1140191;
	Thu, 16 Jan 2025 12:52:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jan 2025 12:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737049958; x=1737136358; bh=pfB0Qkb2lt
	8dE58+SDzhMAE07ACH7PBbM17dCcT/Oys=; b=FiLxlfSj+dlCMUYpf6oIyuxdAv
	FjMvMTBCV7DYi+kgbVtrn/kIkR4g6o4eL4yb4WHg+fzY/Sje000TnJBVFNaw6+hz
	8BpR8cR9phiCFgYb06VCQWzWthXkkzOUc4HLyJBBiD6npW6JkHEE7PRSWM2JzpiC
	7VlDr9ySJcqh9FQIIGxE4v3QqGjDkCVYiHYTYRSjkUCh9HZbGBvkqOfkeiSEMfyz
	y/fkDmQae9WeMZQ1f5Y3PF7jppTOAfNppY47+wnvkiGrftx5Db1DzalVMcKq2n6y
	nrdq2csynXJWYMzCMZjmjeDYcljvTwMVmTl4uZvQASUry/7m7KwgoAiRnBRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737049958; x=1737136358; bh=pfB0Qkb2lt8dE58+SDzhMAE07ACH7PBbM17
	dCcT/Oys=; b=Vuml2EzUIeRYrnT5WD87FRND9CyUaur0jbNFwa3yPAxQQF6tM7Z
	gZXrMRq6CYo1Ugmi5Tw3VYZrOtf9fhWqNjKTMTo2vkxQcyF8iSPwycFRLv3A4AUK
	Yd3B6iooBdK4HPVYdzYbeKe49RWRs+pUlTA8dOFfNiGihUdQdHl2GdYGKbdE7QdF
	KklekDCWCr96WKlAiWKGhs9dFn0jvR5JMFSf8dKkKylY61RcEpzElGgSdKykWs/W
	0WF1qTYcpMupLFw/5tpu44P/ZhrT22avajeY1QFE4s6Fuf1lNg2lYglI+kixOoMH
	oubVh+7R3S90L2VSz+4qKRp8ubU0LdgOOTw==
X-ME-Sender: <xms:ZkeJZx7dfWSB_ef4c44j7gh1VF4jgY2VlpZ_ox8xB2wTSU54ZW8KgQ>
    <xme:ZkeJZ-413gGA1siMcuEX4S99Th1Cu3zNIiHABhNAbL8_tHK1UM9yFkp3QIk4b-CTG
    AbAIOPDtyh7R13irg>
X-ME-Received: <xmr:ZkeJZ4ci2YJXG8lwc6NOlIIv7Wksv2m7RyIiOUHITCDGkAzSzYwe8z92Rm56pJSVDQLRREEUMvLg1rVKh6Qz9kW3y5BsXqgeOJms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZkeJZ6Jp0PaI71NmmBMZ2wy-f4UKtMHyrwl_xoh9dSrtI835P0lFZQ>
    <xmx:ZkeJZ1JKQG-gc1u-_xLAeT2l-VPlmhHIChAF75kQKZRLlxr2r_5BqQ>
    <xmx:ZkeJZzzto0EWaGaw3ZndKFsYI6aw4j1qgBv_LOJCRfjdvXN1AHGJ1Q>
    <xmx:ZkeJZxJ83Wex3c2VKQiDY_GoGlSYOtJZY7_8t209zt-0InLKhDLA6w>
    <xmx:ZkeJZ-6uXnpcDyqqcOfSntfGexjWVCNX6VY6AhwTII3mkZXlzJmPQBlp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 12:52:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  christian.couder@gmail.com,  kristofferhaugsbakk@fastmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,  Derrick Stolee
 <stolee@gmail.com>,  Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/5] backfill: add builtin boilerplate
In-Reply-To: <Z4jbW7UtaC7hQU1Z@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Jan 2025 11:11:39 +0100")
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
	<0300aa1b8c37dcd0d529cc24588ae77960fdfbff.1733515638.git.gitgitgadget@gmail.com>
	<Z4jbW7UtaC7hQU1Z@pks.im>
Date: Thu, 16 Jan 2025 09:52:36 -0800
Message-ID: <xmqqfrlisl23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 06, 2024 at 08:07:14PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
>> new file mode 100644
>> index 00000000000..640144187d3
>> --- /dev/null
>> +++ b/Documentation/git-backfill.txt
>> @@ -0,0 +1,23 @@
>> +git-backfill(1)
>> +===============
>> +
>> +NAME
>> +----
>> +git-backfill - Download missing objects in a partial clone
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git backfill' [<options>]
>
> Ah, one thing I forgot about: this could use the new `[synopsis]` style,
> which removes some need for formatting directives.

Yeah, I thought it was more or less simultaneous development and it
was OK to convert after the dust settles, but it seems to predate
the series by 3 months.

$ git show -s --format=reference 029eff9e34f 375852e20
029eff9e34 (doc: update the guidelines to reflect the current formatting rules, 2024-09-24)
375852e20f (backfill: add builtin boilerplate, 2024-12-20)

ds/backfill:Documentation/CodingGuidelines does tell us '[synopsis]'
is available, even ;-)

Thanks for noticing.
