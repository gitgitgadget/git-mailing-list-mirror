Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E682219EB
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767758023; cv=none; b=SdB4PWJWLwUoYGsq+vVhH1noGxIro0ASGBmZxkyR9daKbPh+oeg449HbNiYC8ajmnTgLYcMZAnubj+oC8/sRCxR8EDt1WYatrGkafZpaj4dLqVAJz1Y0aBVJTbKuUVB0LNIAiXrGR1S+U9zJrGZXIfahK5TwL45l+QjQ1J4yd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767758023; c=relaxed/simple;
	bh=hrG/P3gcfZReJe+jm0ZOii2QVYkD/7fUP6eXWL4+0f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mj50DB0Y6JMye89DQF2/gw9B6rtyG8mmngtaecjnjHNxnnjhYxghWebNLQqfL5Ye5diAi738r5Bi8uiI10rB5weZyeLrjHrIc2XQEs9VmMCIEsbuMNxSLs48hwFP92Nh4Qy/tkFPX118SXNcupn2O3KJR90LxGOZvtVZOg7IixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cVkdTPk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZDQJFF6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVkdTPk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZDQJFF6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6FD021D000A4;
	Tue,  6 Jan 2026 22:53:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 06 Jan 2026 22:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767758020; x=1767844420; bh=WQBxcB1gAx
	hS2CmtMqCTytIVj9UlDw8W+f3wHu0YBJw=; b=cVkdTPk9rkC9IYT8lQeLtwWt0d
	TIkWQ/spfyJwBHPI6l4MSFC3eYSY6xyrKlAdmwTgxJAGIOpuSWbNMcVGt50Gj1+E
	85CHprSYhD0IkqpRaAHoe9ujCTVmy11YEmZU4igkRIXcUrXop6Q7J57HUMeimGi/
	h2EkT8J98CHTJwI9UwNpuZIgfaE075OiUbuBy29sShv4JXJxM1PTRnPxkLVTTSG9
	Ma3toBgt0vrDBo6LTboGX2bJ424vb7VR2bXDe+Qsur21MBcCnlqZkJeoULcUmFXy
	HC+PZAjR/Qf8tPgDTZmqGAObo6OvLIpbtP1iCXY+hs1c0sgC2US+xORC2yOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767758020; x=1767844420; bh=WQBxcB1gAxhS2CmtMqCTytIVj9UlDw8W+f3
	wHu0YBJw=; b=AZDQJFF6X2cYy6od7BvxgYv62r5CwYRRJvCsQj6pDg8bxej4J3S
	AjNwNXAfNGxzEzIRUU9ujanugd0uMv4lR9Q3bWHYA1LncHRuuh28ISYcHsQoruoJ
	jf8FitXt2i4OIsZptyXdd+My5iysEK28bO6rrlpKoAD/2EiVe0mz4MdzQR2Dodic
	YqA4jML+kT7Jc4f6DHQ1kDYZArEE4huQvitGmSlrTx95FhYwAmE5ZNRwzLqPWHWT
	AeoUbngBHNcivaHuOiTYvg8L34P2zEwZJlChiG5W7NnMV94ah/ibfblSw5DGf7mX
	t96NHnaaphc7KFSF3Em8tTNwBI6lC5ytMjA==
X-ME-Sender: <xms:xNhdaQMSje-rrqarc1MqSP7_vpijQ1xtTl2jiIz7UaXuV7w83Yc4hA>
    <xme:xNhdafa3xjq-Ve7At0ekc-ikPrIIltik_1rx8G7Db2Lyb5tZPytoFn0F3JJHHn4An
    BEsNjtB0QiilS6k3Ah4NlDb-_ED9ZXPyk9fS5dYSKMX0FpHLZ7Hrk0>
X-ME-Received: <xmr:xNhdaXvHmF6mpnmtK1L8t_bAIhpy0rRCWWtxiOMRWBEF5auNsC12z1THL_9yrSevtVs3vvO11TcYwru84JnG0okIRNQb6SJ5G-WkCDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:xNhdaZNAH4AlKtpFMkN_c2acoLiq3MzdJB_jcC-QgNXIo7QMZHPsjw>
    <xmx:xNhdaW6vBjLowtM11vavnC5YCjeegTC7sXnt718Yb3_UrSRmbseiKw>
    <xmx:xNhdaXT85XnWZaVHPco4BFxs0FMS4dlz4jDKMqBkX-AkNSKiXBikPA>
    <xmx:xNhdabC5etnZRlLsd3CkVtPy4IBZ7qXlIEd0bUrpFUMlvk7VdcqpVg>
    <xmx:xNhdafr3QrrMsJ6eHn8FXv85HSEQK9gHTWQYB2GPYw6qS6V5p3pIOV17>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 22:53:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/3] Update clar for improved integer handling
In-Reply-To: <aVzvBnwsuPB_zd3_@pks.im> (Patrick Steinhardt's message of "Tue,
	6 Jan 2026 12:16:22 +0100")
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
	<20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
	<CAOLa=ZQrx2T=mPC58oSW=1Y4i1cOCtneN+U7rDUmKAke9ifp7g@mail.gmail.com>
	<aVzvBnwsuPB_zd3_@pks.im>
Date: Wed, 07 Jan 2026 12:53:38 +0900
Message-ID: <xmqqjyxuhyd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > Changes in v2:
>> > - EDITME: describe what is new in this series revision.
>> > - EDITME: use bulletpoints and terse descriptions.
>> > - Link to v1: https://lore.kernel.org/r/20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im
>> >
>> 
>> Easter egg? :)
>
> Oops :) Thanks for your review!

Looking good.  Shall we mark it for 'next'?
