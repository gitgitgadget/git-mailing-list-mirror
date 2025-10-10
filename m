Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF729266595
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112681; cv=none; b=cXqvFjk+ECglUyggVwxyNVVQkPVH13T7QM59NNfeRRlWQG/DXF17q5idImpLe1F8xYj078jTJP1Izld+J2VlTvNO1QuxQG0bLwSjz3L8TMERdY8zbR3USrEhkbCH6IgFOlquDYM8U1V2kEhNcQ7Ql/WcQS21dFq+V50skHHa5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112681; c=relaxed/simple;
	bh=nbCtNjoWQtm//iE+GqoiucANK5ob3MxszqbORonl83E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JOpQelY9ViknloXDlJt5ydAxb/nPSfZJgyd28tlvy0+P4SAoEC5y9GRM3wtp8XvYFo967tvJKKoPonaZwkIDF5nBRd/IikE8EheyBIVNprVRlSfDifX2Clu4fp321WI+QuDJ/JH82xZHcSXRJQFwzbZfPaysliDNjIP0JM3jyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M8wfffl0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xh3bUSYD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8wfffl0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xh3bUSYD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F396D140012B;
	Fri, 10 Oct 2025 12:11:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 10 Oct 2025 12:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760112678;
	 x=1760199078; bh=DkJNtLKYe1gj5unCMYujCWucL5vjIWepGChLcoIYO3k=; b=
	M8wfffl0S+/ws+LnJLuZxeWLB0+onIYQNSN/M6eqqpBngNLrC8gbbY+i4zGL2oqQ
	hlXiYTInE4e4dPNaIgvaRXwSTabto+FF5VZDsAE9JJ/QojffWGXLney2DHvYZXFx
	Y3uI6/ll1dPyf2Vl8iHZ2TvmCiQ4TtSibr0+HFCzNSlbkGogysrcJMZ8gKD3hApt
	Bqrd0G8TM1t+89cVCveIwvlKkAFbXGV7DVDHXVzRc4UlQLa1BYO0pp+1rKV0BXYH
	95VdGp2+dhlzRkVnqilMN5fi4kutsgqCILfl2kUNNK47pSFMClMSlgb7SH7t0yGg
	ygfK7QzsKr94QZ8lXujopg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760112678; x=
	1760199078; bh=DkJNtLKYe1gj5unCMYujCWucL5vjIWepGChLcoIYO3k=; b=x
	h3bUSYDGmvhDDZUsm8RJYAD0PuHs1ZN2Cm55aUN1pjMdZmP54KVK5GM74Z87WJMV
	LRn7oeSmb4/Yo5xmGzpJNA5uld4RArCrJHzYQeG36S5jch9+WBpF1oezeix1j/U5
	oRdiAVpEj/HMtikpXYA0yvuXsPbLWKsjjicGhgN+5RD8fg3x+LbzhB5A69pWm3W6
	wUb1UvCPBkBqmz9knZwy2hux8CUfqmmjIoJwsz58WgTw232QASPS5AaaUlfS7aRR
	04ZtW9yMoW4mRFVj3P+niIyq13uX3IK2X6I9ZwwaDHtdDk7+GRt6AplP7EDzfX5e
	qA7NQ6ZwAEDS2lZFsWtHw==
X-ME-Sender: <xms:JjDpaAa04LoOH3KBVvfN8HDBYQN7MtodZ9qQcHPQms82o3pfmqDgzA>
    <xme:JjDpaCTxHrhy0OikSfb6Vqfv48MbfMGTAh7HFDxbhpMtvBTvRC6yktalva1TTQua1
    SwHaibB_vr6BrNsyR2zhRhVqm7TlPGKAip9JLqtnx8t1vNXtj42KA>
X-ME-Received: <xmr:JjDpaDSXFVrT55WCxDCrtHOHiKyDfnOp4-OCI429MhliMCv8TAI8QC_B1jdy1L3UIpWpD5zPgqzAd_hrJcawJzEjoYX2vksgX1qD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JjDpaGRDm8IrLCBtnp8J4OsGEyZdMy4S4w5btgYz684Le1ApVioKsA>
    <xmx:JjDpaI5G7WevvvsDzn8KQWUk-UpwoVb7gjxZeyIdXQlWbtvI8YsCQA>
    <xmx:JjDpaC34TqDbGHLtzp_ocTMZ9QxBXx3tLlpC837nghuQbQxHzDyCgA>
    <xmx:JjDpaDBhTVpzrYGAZRwk2ayVhdAJv8x7RRnvDnooJMkZYxLrFNnDZw>
    <xmx:JjDpaJaR2xHjL2Ks13z5t9FuMQ0htUUIc7W6mwyVViiafgdTHhcgutmi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 12:11:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: change the markup of paragraphs following a
 nested list item
In-Reply-To: <2239952.irdbgypaU6@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Sat, 04 Oct 2025 19:31:29 +0200")
References: <xmqq5xd5aqa5.fsf@gitster.g>
	<20251003031113.GA6381@coredump.intra.peff.net>
	<20251003034134.GA625140@coredump.intra.peff.net>
	<2239952.irdbgypaU6@cayenne>
Date: Fri, 10 Oct 2025 09:11:16 -0700
Message-ID: <xmqqo6qeag9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> On Friday, 3 October 2025 05:41:34 CEST Jeff King wrote:
>> On Thu, Oct 02, 2025 at 11:11:14PM -0400, Jeff King wrote:
>> ...
>> I think to appease both systems we need to put the inner bulleted list
>> inside a block. I think that is OK in this case because there is no
>> inner block marker to worry about. So:
>> 
>> diff --git a/Documentation/config/extensions.adoc
>> b/Documentation/config/extensions.adoc index 49a7598ca5..aaea8c107f 100644
>> --- a/Documentation/config/extensions.adoc
>> +++ b/Documentation/config/extensions.adoc
>> @@ -55,8 +55,9 @@ For historical reasons, this extension is respected 
> regardless of
>> the refStorage:::
>>  	Specify the ref storage format to use. The acceptable values are:
>>  +
>> +--
>>  include::../ref-storage-format.adoc[]
>> -
>> +--
>>  +
>>  Note that this setting should only be set by linkgit:git-init[1] or
>>  linkgit:git-clone[1]. Trying to change it after initialization will not
>> 
>> on top of your patch seems to do the right thing (no change in asciidoc,
>> and eliminating the regression from your patch). It's a little gross
>> because we are reaching across the include to realize that
>> ref-storage-format.adoc contains a list that needs to go into its own
>> block. I wonder if asciidoc implicitly opens a new block for an include
>> but asciidoctor doesn't. But at any rate, this is the only way I could
>> come up with for both to render correctly.
>
> Thank you for cross-checking. This is indeed almost impossible to mechanize 
> such testing at the moment.

Thanks, both.  

So we'd see an update to this (I think this is already in 'next')?


