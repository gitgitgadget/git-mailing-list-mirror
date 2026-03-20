Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED31EB9E1
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026413; cv=none; b=PT8aOmiaukp/1tiWeiuTQ7cuOcXTSfUB4AOt5qP3JZpYfg4Lgdvpu0iirupABmEPhhsyCSK9i40K5/eU4351FCM7wMt2rKh2TbWATgnvjKLxS0hy4dR9qw2b1tS1MforGef39WYRJeqhrkHDJSbU40BuZbnUOV6uU3pimi7KS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026413; c=relaxed/simple;
	bh=X0o5B7ojFFbs75MOxqG0Iql4iY1Zx1O7BeUotFTycTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8buYPu3YPHuCP7XOIv0U9vHfe1AQQrLbNB3Zzgj/VJP1MSDPFXFubDSeqaufWOcnlCkFk3Ats5HW+kI8VDtRSNB0BcpVoanhGkLfkkIyjgpIpeSdtehkI863GXLLZohXJa+QFDBxAP424LEncSnMTrKtnv8xuWN7R5/kRl0yrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ih+nD+W4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3EQooJkQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ih+nD+W4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3EQooJkQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A22DE7A0064;
	Fri, 20 Mar 2026 13:06:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 13:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774026411;
	 x=1774112811; bh=X0o5B7ojFFbs75MOxqG0Iql4iY1Zx1O7BeUotFTycTI=; b=
	Ih+nD+W4hoBspa0VilPOuCVX1pp6hX4usS9YyerrKGhswHbB1JqC4vFyLIwyjFXR
	S5D7P62LElzZkN86wkn+PPfDVODuInHBGpIq558S5zdM4Sc0nIKlSM024AS8CFoD
	cWqV3NLfl7yckleBDXDTa3U8k2vX7uBRswsprlFcD2MESPOfkrMPsxEM24Wp+eWJ
	rUcQ7hHtUiN/AXZ7bISyy/yisQAvirLHlOxzh1S7ODsfUYx312G4pRTice4UALun
	0iSGOvbLS49+IDoBkbFsg/45PIplQGURczkFbxoKY8Z9A/PGfDXFwFW+dnXAFceL
	wERzkAGfcIuE9KPvmE8y9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774026411; x=
	1774112811; bh=X0o5B7ojFFbs75MOxqG0Iql4iY1Zx1O7BeUotFTycTI=; b=3
	EQooJkQG1x3Ad+zNHDQPHjboh2TGauv0FCF6A1XWICjQAGKGQJSOHG7Ti2u4dgIX
	gHhgs0eL80AGzlaEHS0jaY0phDJnI7CPlkzqVau6g8g8LVUWScUXpxfMFh0qGaxU
	gCmPzcsTHYSKB8rLaGQW1biL/pU+gieldHm9/WA1TJrJk+BOJqBjNcmPxv+PCvky
	ULNCTjlhEXq0Ncs9LJUbfBvaNGLpoYn6P+kGaad1c5FbXqJtuFFvRZom0Ujp2mLV
	Um2oemB9MSRJLPLFb4hJjh39G34RfELN9bZG2Y/AMwsJJegSuM7qQSGPYIBx3Olz
	+rVA1wftq2l51Mqkxwd5Q==
X-ME-Sender: <xms:q369aeV2EMuEe_8lo9dKqg6z3PW4E7KNMPg8bWvEihU-2MDeaDPcrw>
    <xme:q369aSBVwiMDU_jcDtdGbvCZQOPXG-9JCT5s9N2RBRdEwg3tvaPEEgrq-37YmYr_1
    ULdnuR_ExY1QJuuxlI12h306C_npnc5BA7sdjXXAXU6l0ij9KBmZw>
X-ME-Received: <xmr:q369afwGN0CLHOVJTd7Jm9s4wS8BggiwMkZOEu1AIW1kWvNB1QPGUqH6o-YiXv-XVDn9Yf0g1n_c-PqxWcO__oMD45sb9rYAtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdrkhhl
    vghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:q369afDkzqhJTpu6K6e7DXlWzx131Qy6OxgiXmXn_h9-3dMIhAd3_A>
    <xmx:q369acaVaFmkQ450b-jNUQ4EnsBBInPJgFj2IOfAcJDlOJkoZtO4WA>
    <xmx:q369aXgqMdlniqCX0OWfHRMg6lJMm34c-v9BvxJeuu2FciiZZieMCA>
    <xmx:q369ae7uiUoElRFn8ca5SjzsDMlGwA6GovXQRvRT_W9noxGvWpKVIw>
    <xmx:q369absdXY2TPuDS2N3pDcyxtOKM9X4DIiaZ4FJkDISTFU-Z9-2EpqFe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 13:06:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Add a config option to add a comment to S-o-b lines
In-Reply-To: <20260320102844.2714876-2-u.kleine-koenig@baylibre.com> ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Fri, 20 Mar 2026 11:28:39
 +0100")
References: <20260320102844.2714876-2-u.kleine-koenig@baylibre.com>
Date: Fri, 20 Mar 2026 10:06:49 -0700
Message-ID: <xmqq341ufn12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Uwe Kleine-König <u.kleine-koenig@baylibre.com> writes:

> As an employee of a consultant company I'm often requested to mention
> the customer name in the Signed-off-by line. Add a config knob
> "user.signoffcomment" to configure this and use it in automatically
> generated S-o-b lines.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---

I know it is not the thrust of this patch, but I think you should
think about this question at the same time, eh, rather, I do not
think we want to add a feature like this without thinking things
like the following through:

How should this practice interact with commands like "git log
--author=", "git shortlog", and friends?

Would projects accepting contributions signed like so want to have a
feature to easily strip the comments without having to add new
entries to their .mailmap every time a known contributor works for a
new client?

And then there is a question of "what shape of comment do we want?
is it OK for us to dictate that it comes after the author's human
readable name identity enclosed in parentheses?".

Shouldn't interpret-trailers be a good place to do this, instead of
a configuration option?

Thanks.
