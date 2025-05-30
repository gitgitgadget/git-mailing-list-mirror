Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7717BD3
	for <git@vger.kernel.org>; Fri, 30 May 2025 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639527; cv=none; b=szV6DN2uR6YYZIEXUqWG3/VXyYhbfZksXHUunB4uM8HCg0NCygN4TE70WFX4N4r5i5lvHhzqW9OC//tq0hy48FAx65tih0NgVJMOm3B3blijHBByw4AGZLfy2aSai0kDTSe2WgLgSagzp5xqetpMfQnSHd3jqxuFN4TIkv2OeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639527; c=relaxed/simple;
	bh=5LLKBEBYjgXd+aJ0Cc8uJrjKnc/3ttLnYl+O1xurCrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ejZ+6wo8mIXE5Rhsw0mBwUcDqjppFQ+H7GWGWXUOY/4RVwXt8DT1VZIGbEsXL5XiQ5L7lSw6XlbH5IJylJJRyPuiJjOGexUnKoulLrnDL0yveuvAOokR47UTmNCeJUMhoedV0zF+9iw/EzP00TaNFhkt92Xq5CeXhyRb+Fb00zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hvF2XR4A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxIDqYNZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hvF2XR4A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxIDqYNZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D86B913802A3;
	Fri, 30 May 2025 17:12:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 17:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748639524; x=1748725924; bh=p2B1tHZOSj
	lLRizYr9zjqEuIXslh1c4Ow4I/Xz0L2gU=; b=hvF2XR4A3vAVfpkAWJe0WVm4uX
	odsqDxyjIrUzOHxI4dTdU+inmpCuzSdDvDmqz/fhltmgZWDnwupOIPj2tGfSxhJM
	TTrIFRZ53jIEVmiQSKmbaE74Cu4Jw0NNIKnlZlX5eeBebnl9n5TnFJovtqJvzRJp
	lFMW/3kN6uiI1mfxXGdvpvmG7GBncvaYJMSl7FgwQ3xvqIyW3v5yK8JORGPG92gt
	1flAmgLofzMyII1GQblnlnGyxOYZxKpS6C913z+71JZVPz91kpAwWGa2bj9MwlR/
	nm7d15OjzCQSUBl+pcSz73xp7MlnwdUKrLf+wOD7UbhhT1JALK9+qN6VZPRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748639524; x=1748725924; bh=p2B1tHZOSjlLRizYr9zjqEuIXslh1c4Ow4I
	/Xz0L2gU=; b=JxIDqYNZ4OO22Y4L67PToSLAWCQ1kixbZDhgE8dnLDQRww/GAx2
	oy28zQUsFT7mJcyLVWBXSqm7Ds0ituKb/zyyufAUuV8y5YnPPokmz3Vq1gLN3zFk
	bIxHGuo25EufuMCPFRtAYbiyjARJj/e112E6wWjhY6H3Yy5bEcsbv76hHq394NGI
	lLObJfHFk7jxbIZqndRHvjaUgBgaHogVkYkSkRSts5A+FU59jtQcqI0f64kOzyHE
	liq+cF+Gj/vWUgxvq+gD/oYh3ZWJWBihw6S9lu3X6bVLSQTiZ605PSTLqmFXD+lW
	lZo+78vHz+IYFZNFhQ8mUNsyWnlYaPKf4+w==
X-ME-Sender: <xms:JB86aPipFZ-eWaJJtNGht1OTuSLC8VTvifsGIPvJ6hLRKEsWuuI2SA>
    <xme:JB86aMBKhDs_TJm9aEFWzW29uNtlnhokpWbRQPO8H-qnr5XfSgUIKQSKbmImjv__5
    OKu9XvlEAWGl4GwGQ>
X-ME-Received: <xmr:JB86aPGr3JIDY1AbavbXZQ50xJXLj0FTBkWkdwBQRBselIRl_TrI5Z2RdghRqzz-cNL6jZbqb9wPPqLI0OY8BN6Vlp3GlRQOqQQV8Bs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeftddtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    ghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihihigrohesughishhrohhothdr
    ohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:JB86aMQnf4-siYDqSh2Z-GyYlmWxM0Wj4J0_JXUMytEaLHcS8S9UDQ>
    <xmx:JB86aMzK0TOoYH5Qrh4pKsG6YhSILgjsygs0exDyOOPSDynuqRh-UQ>
    <xmx:JB86aC49fenUA4TJ3uE--sdB0HSxNRL98upfqHaU4xtwbPWKEmFaEA>
    <xmx:JB86aBzyT6xlvlS81_F7sMcnv3_lYDsDEo3H--UXIDzokpe0nSLgvA>
    <xmx:JB86aLDEPmaOz2Nz7Tay12REhtBUWRzsGjg2seQIk0HIgS0YfCvoRQfM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 17:12:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Aditya Garg <gargaditya08@live.com>,  git@vger.kernel.org,  Zi Yao
 <ziyao@disroot.org>,  sandals@crustytoothpaste.net,  Jeff King
 <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 2/9] imap-send: add support for OAuth2.0 authentication
In-Reply-To: <CAPig+cSFLF9de3i7RsG6j4wSGkRRhGgOGOovoFXm9U2+t=qC+g@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 30 May 2025 16:51:21 -0400")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD09F7A450C6CA26B421B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<CAPig+cSFLF9de3i7RsG6j4wSGkRRhGgOGOovoFXm9U2+t=qC+g@mail.gmail.com>
Date: Fri, 30 May 2025 14:12:02 -0700
Message-ID: <xmqqfrglerbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Not a proper review, just something I spotted several versions back
> but assumed that someone else -- providing a proper review -- would
> mention...

I suspect that we weren't ready to prifvide "a proper review" yet on
this series at the coding style level, while the design at a bit
higher level, like "should choice of openssl/curl be runtime?", was
discussed.

> On this project, multi-line comments are formatted like this:
>
>     /*
>      * Line 1
>      * Line 2
>      * ...
>      */
>
> The same observation applies to other parts of this patch, as well.

Thanks.
