Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568D173
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748910096; cv=none; b=srQMFcEq59kXJzxndio6E3NUwyV+68sYrg1hU6W0SJWAjlNj+9Ow2DBl4XoH93heRRhCArAIGqcfZ9fK5xNVV4B/Ll/XtL2ymHDqnL5HVsZ6J8LK9lgpMWPgov5G5NAeU0rsQyMQ+r5Jsf74r5k5zJ46uW6SWhur4kgSOb+dKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748910096; c=relaxed/simple;
	bh=z+zjnKnPSLqBB7Y0YzwzQAr+SOYTygQIfrRD4nFKqPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UIECXzFRgiLr4nwR0mMepMBVk1JqCBzZX2pyK2uaDCJSrisRm7ZchS+sWWOo0leN51k7RZ2oyUlHzcHrph7xOFWNyqKG028VNFrQgpYsa0YQpXNTIzrehXpvlJ0VDlsGXmAN8C0whyZm6W/BByVP3F4Hj7frU/wyEnrjYSy7kY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c5fpDyda; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMx7KpFU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c5fpDyda";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMx7KpFU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 054711380349;
	Mon,  2 Jun 2025 20:21:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 20:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748910094; x=1748996494; bh=c4spF8sZXx
	6O+3rYfI9WF5iRVbrMw7JUH30D6CD4TRw=; b=c5fpDydakzh7+fOjppAEaYz31S
	VTjwfYetszPrvApIlnlLlbAstvunDC/AVylyzWMiCd+qb+zQk4iS+W/gmJU6lnQV
	ZEU/0FhLrtyVxg6iDMEgtuK55xTF9LBPxaFXiaBZPFZ9E542N7S3wbi9a5hu9Cl2
	tzTBTHWln7G6NJlF368g5CK+IpmnpS4UDTDFChehCt8B73Ofsff6AxdwQnE6Ekta
	OgvlQ4GIOm8T95KtJKATE+iU/zNO6mxYLJmt5FysQtCVwZ//v7sdQCSkVgueagli
	W4w09+w5VdbqiBmmS/mYTXtzW5lA60nHfqfdH4JVDT1uastRFtvQyGEm2TZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748910094; x=1748996494; bh=c4spF8sZXx6O+3rYfI9WF5iRVbrMw7JUH30
	D6CD4TRw=; b=nMx7KpFUtI7XnRWmZBDrRt138oXUfEZg/ljlZbFQIIOXvNoX5bl
	agfXo2gEoVxqoQiUPhF1p4vOvm1qBpClqrSc3V2TM8Kl1X7WBvRd+rJF5gsGfZtz
	l6wtOPedgBrwlyghnIGBX5AVSMs7W1yjS8xHQ1DgGfxXrZQh8cX+YIey4SVr77K+
	IKBu61QPm7f8f8Ns3NbKc9SRTEW0lpdJ7MEt4YK77AtE/O8DTo8LgrMQeeN/e1au
	TyywSu/gscdq0Ep11lcpNrHygDudaR55n3X8pMX85pG4XSsMZ83cpmFz6jeyKOMC
	6Stl85tpev5Gg6frFMTfiaxECwZ61oI0uMw==
X-ME-Sender: <xms:DUA-aCYwtT6qnA6HOPI7sfY1lLIkJnOIXGh-TeYLis6l4KP0LbJHBg>
    <xme:DUA-aFbAZRsulI0gmH3Y2glRPh0BMIhRERETNc91dSEAiphm9oRMb18z81ukCB9Qc
    yxKOIGnOCPzPK62UA>
X-ME-Received: <xmr:DUA-aM-AyO_Thr01kQJNUwMTHMHsF9397NJHnY0w5I8bIARZvOly8XwkCpgbv7dTE3qiKlSdOY1pfEheL63KwmBoxgQrJ4ZFLJx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefledtleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthho
    pegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DUA-aEo-0MEgWEHBf9gIIu8Y2KcyvRE7U-ZzQ7sMpCSW9-jfOB2o3A>
    <xmx:DUA-aNrFHHKBib2ZIaoURHIFVc0yd7x2Ez-1H3CvrWUiFLi_zLN68w>
    <xmx:DUA-aCS24GFAmA7LSz0HsgP5C7xHY4TwI_Oe7F_3WglPCn5uKCHc-Q>
    <xmx:DUA-aNp2HyROnWv1B4tgDB_NHZ0IoYLkiskx_3C1a09wzZijxqmIFg>
    <xmx:DkA-aPAbMkuPcc0FSzILra0IGX19pzvQENX9l8o16LmsobmVremUGKeV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 20:21:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Collin Funk <collin.funk1@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  <git@vger.kernel.org>
Subject: Re: [PATCH v2] completion: Make sed command that generates
 config-list.h portable.
In-Reply-To: <e6a4b604-c5b7-450a-b4f5-3863441e0c6e@intel.com> (Jacob Keller's
	message of "Mon, 2 Jun 2025 14:42:27 -0700")
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
	<1ff542bb1090cc5185644d6032addac5cd0df402.1748892261.git.collin.funk1@gmail.com>
	<3631972.iIbC2pHGDl@cayenne> <875xhducs7.fsf@gmail.com>
	<e6a4b604-c5b7-450a-b4f5-3863441e0c6e@intel.com>
Date: Mon, 02 Jun 2025 17:21:31 -0700
Message-ID: <xmqqplflsmic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

>> But we could put configurations on seperate lines like so:
>> 
>> ... 
>> -gitcvs.dbUser, gitcvs.dbPass::
>> +gitcvs.dbUser::
>> +gitcvs.dbPass::
>> ...
>> Then go back to the simpler sed expression before your most recent
>> commit. I will wait for others thoughts before posting v3.
>
> I like this approach.

As long as we warn our documenters that comma separated entries are
forbidden in our documentation (even though AsciiDoc and Asciidoctor
may allow them), it would be the simplest.  The question is where.

Perhaps the tail end of the CodingGuidelines document where we
already have write-up for markups?

Thanks.

