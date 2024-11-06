Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF3523A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730862318; cv=none; b=UKmFcdW0u0YcsvROLhPQKkxC10ezDqee9wimbuiizmW7JM5et2Plv7IJBJi1Dcs2Xz5MipLNQUN6T/BoAH2gti+mugbdSLzvsKOvRmOHsXIY8bzQLWBThbnIu7cs2q4USqHC93aRTzfMEbEhCNpT6pERrxr4qtLkhjSxBX2FXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730862318; c=relaxed/simple;
	bh=hB2XvXa00fEYWd+OXaMUW659uzBJ3ujfXsGdygi2edc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtgNILDfJkvr0xAw0DxgCJqzaFiVjpZCBj6R+C1uxXl2+xe8SOq5IwlpArxixYsQDs3yUt3PWpGm11U3HQ6Rhv7v3b88AoyrAH3G2JnK2qaIJSdmt1vDY0OCTeJKyh7YSTbemt0sYDoaRvT5UBRW7kkN8PbrXxD/C0SNwgbouEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LlZxGwcS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FeBCVhOj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LlZxGwcS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FeBCVhOj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DF5D254014F;
	Tue,  5 Nov 2024 22:05:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 22:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730862314; x=1730948714; bh=/NTFBhRcmN
	KPpDx0bCay1yxru5Qg7JzV/8HPg4pRNBw=; b=LlZxGwcS9i8h0UdoLnmgww1LqM
	XUBUB7Lzo7NmvB0o1WePRWgyR67t3bP8pmhHR9gGhhqzEGqMlJAikAVcK5D9lD0E
	3Z6jgO1pvqazELUhg84bSvP5fw1A4eIzGxoyZ5v/RYvSV4EML4nhuN9KyL2Qnxsb
	LeK5vngmn/FnV42vNYhVeLKjMGvQaLH3GuMW0Jk4Mghpa0xhTznauthDgFE+xBRy
	STKLBVsDxNOpEmW6K0nvFndwHc1sWPfzM+WS23RQG7q5xw7OVyneV48y+jW43tIm
	spNw1lkqMfCwYC8G71N7mxiB1gqXcoWMGjXb8RVC5xeZSsSBkWhRMj8laEsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730862314; x=1730948714; bh=/NTFBhRcmNKPpDx0bCay1yxru5Qg7JzV/8H
	Pg4pRNBw=; b=FeBCVhOjnYIOwJGgqUn3S9fatuIOtvU+pOg/y5ZYeVZx/AP+uqZ
	hTBxQb1TSnVovmdjS+HnTGEmH/fm2Y4hjxOCeOpxx74IKv1uGz5qrM7TOxuKpKdg
	fEh3fXF41UHxMRbtQHJyPLYs6ZCWadidd2LMwcorqvS0wlMKOLyxcEQQYJS3PW7U
	78gef5PsdcaqtKkZWYRzUvW3+QaIemH81j9E9XFMzo5Qv5Zz71TUeVF59F3nbejy
	e6mEoGU7Tupbg3WwaU/t492axC08qrDtpQHuRqn2cVudGhxEN4cEe4BwLaD9uidi
	YevGwQXRNjTHI7OM5hGxJTB1eLPsGn5UoaA==
X-ME-Sender: <xms:6twqZwIQZZgb8ayL4SEzBHMCB_7It0pFqnur5tnuQZTWGnGen-A7QA>
    <xme:6twqZwK5N3XIx3EHKdnqaHzazWQA-VYyjlZlY70DL7HfPDEpzJwHTouF302k18nNE
    vfgcP01AIrg_88k5Q>
X-ME-Received: <xmr:6twqZwvqKTrArfVYCwXQWhk2EOsFTufCyiBU3ZB64xXI69MqhjBJ2epO9lNr04w8F2Wi-CrILgdcCzpV29uzR-frQBbVQKvTV5mL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepfhhivhgvvdefuddttdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6twqZ9b0Jf1Ey6YJ83WguzLLHh1B7bF7ayyxOmMF7-4UXXu2foIqTA>
    <xmx:6twqZ3ZHrWgB7Z4NGd602BrnAr6iTHg_Ns1ebz2RVjke0U1eiJrWMA>
    <xmx:6twqZ5ANqvWuzfBd9amY8BfXmFgWo8RrSccHkGK3XEIcnLhbKL_K3g>
    <xmx:6twqZ9a39DTK1Cug-RmfGL0salQHIVCiMlrd4xdmr7vwDO3avK0l3g>
    <xmx:6twqZywumaOxmBSog05H0RPqqO-vvUuV8vsatjKCChy72tuWOGm4XOhv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 22:05:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  git@vger.kernel.org,
  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
In-Reply-To: <20241106022552.GA816908@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 5 Nov 2024 21:25:52 -0500")
References: <20241105190235.13502-1-five231003@gmail.com>
	<xmqqikt1qhwt.fsf@gitster.g>
	<20241106022552.GA816908@coredump.intra.peff.net>
Date: Tue, 05 Nov 2024 19:05:13 -0800
Message-ID: <xmqq8qtxqcye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I am tempted to say the solution is to expand that "equals" value, and
> possibly add some less-arcane version of the character (maybe "%)"?).
> But it be a break in backwards compatibility if somebody is trying to
> match literal %-chars in their "if" block.

If they were trying to write a literal %, wouldn't they be writing
%% already, not because % followed by a byte without any special
meaning happens to be passed intact by the implementation, but
because that is _the_ right thing to do, when % is used as an
introducer for escape sequences?  So I do agree it would be a change
that breaks backward compatibility but I do not think we want to
stay bug to bug compatible with the current behaviour here.  I am
not sure with the wisdom of %) though.  Wouldn't "%(foo %)" look as
if %( opens and %) closes a group in our language?

So I am very much in favor of this "if condition should be expanded
before comparison" solution.
