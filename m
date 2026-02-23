Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA53EBF3C
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828656; cv=none; b=pg9jGwm8t0I8j8xB16WqoitUjIIUwvMw00L2Ds3Ey5WlXnaZW1vMR/gwUjR2/j1xfZNS8Rj5UJlOwpmFwHIRwlCnrWcpWRyRy3+thzuL26n1Av18j+Pt/oxS9FrQtswkP3cc9FALdYBjcx98tOl40lxuackc5Mi8qwcEOxZOgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828656; c=relaxed/simple;
	bh=nH0y2pHSV3OrONTnGpfy2DVlrEGjYthIzshGUjwClv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqwggWl9QirahbhaF0U79W61vOwZsSHevnq66v6zcs7cAzPYxtlaqESlSoDBUarocF56JuDEYxhzhr/fBxbjaIkj2zOgpK04tZX6ZOqjVZT5UenTIQTxfJJh7IEQzPSXUsnjMImczAksfjtQv5rJnS4tQvhsV/xNYFT71+FhsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HFSrb3z3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EypcF6Vt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HFSrb3z3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EypcF6Vt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8BEED14000F7;
	Mon, 23 Feb 2026 01:37:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 01:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771828654;
	 x=1771915054; bh=Hvp0P1aUjf8+wN4RsWDtqPIoEdbkfARtVBzGS1HIX08=; b=
	HFSrb3z3/wCe53y2CU6j9TcAzMmyWyFWRfdNS9cK+CAvus+6XAUm6NZnAm7FYpVj
	RwPXG1O6Hi/TvIz/XJeXDZDvoXjxgAsQo3mcnP1nb7iuxnjac24kFHR3BgrP/8vu
	vKYEDEovsJazRbWqWyioAqhcJRjefSoeYrqfDLEUT3Uc7Oz0jLO8kz/B9Rs7WSRs
	N7kRuG+QYOaNu6bMFPg8idnPprrTuSIqkfDiyxnFAPu/DswdAI+NCqm7z9dGDUW0
	ggWlRy/qoa6tQtDD7uiJMiPoT2HdO55WKEaVhB8ikM2CozHxv44orcwH4indb0gf
	AQ6VyhqDcvP5pZczqnFs2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771828654; x=
	1771915054; bh=Hvp0P1aUjf8+wN4RsWDtqPIoEdbkfARtVBzGS1HIX08=; b=E
	ypcF6VtnMFUR7jPLLWWlfjtequc90GJhwy023osCz1R4ZcTFCZnBr8adzMNeQ33m
	WgTCaHsDL7I98PAkn/gmfcT4CLKpeuPk4H7waM+9N7Jqmy0IHek4oP4WPqo5T91S
	n+D8rX6Q/5EZcxq9SX9N0DQAj3jw2XtAAWaHqOYQChqhASNHBItG4j4I/a0uM/E2
	Uk4Z/lS6ZD0J0o2pvqGgJvFjReKkOCW3gsM6J41rHdjchPB7v3wz6oZsUBbjc396
	3HjXqdmbrkR/JMfGi52qQuUNqkcoUch+rEwNvuTQ5vNa2LdhspLqKOz/WmUebL3E
	B/+37HiXN1LYIZ3QqP4+Q==
X-ME-Sender: <xms:rfWbaYpgSbxFgZkGi-eOfkQMECs-FgbF7VdqE4HHycZpbXrPz58rrA>
    <xme:rfWbafWE4VFb9CqzWk1DMLpX-zKg7L7-n5zOQx8-AoRgsjL6ohNhFLGKw4bpX8dzQ
    6O9Cx50-iwnz26SIN2e5r9tPZq5WD2j2vYEXcstAEvJaI-dfBaI>
X-ME-Received: <xmr:rfWbabaOCsqf6xRyJLDIpXvGJAQRP8QPyGvj_0ABS7Oybx4k41CQeNxO3xnOHAntEuf788L-FNyy0q7Inp7Jr4qI2iLXRnbRwqHfNnRRDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehmrghrtghnrghrtgesgihiphhlihhnkhdrtghomh
X-ME-Proxy: <xmx:rfWbaUenyzjEDNKmntk3HeomrK6VyNHag0XPAxvJiWiA7nCcuvVeig>
    <xmx:rfWbad1eTmIPuv-ApFsW_4DN8g8YzCeVq1nDrbqMhRfOIudxDTzQPA>
    <xmx:rfWbaTLtvezUvRbX1zQKagEsthmrrh2he7zcc3VPvst_KE20TE8pog>
    <xmx:rfWbaUGonQnv557rgoEaYby7t7JpMMO38dpXRmbjIFZerif-EBolCQ>
    <xmx:rvWbaVngZ4STTmgPmxPttMXjiMg-9H2Xm4JCWQLMJdL6Dk3-V_N5A3F2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 01:37:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffc48d0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 06:37:31 +0000 (UTC)
Date: Mon, 23 Feb 2026 07:37:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Evan Martin <evan.martin@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] build: regenerate config-list.h when Documentation
 changes
Message-ID: <aZv1qIBz9khlxSGC@pks.im>
References: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
 <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.git.ben.knoble+github@gmail.com>

On Sat, Feb 21, 2026 at 09:07:17AM -0500, D. Ben Knoble wrote:
> Notes (benknoble/commits):
>     Changes from v5 (<611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>):
>     
>     • Reword a confusing sentence in the commit message

Thanks, this version looks ready to me.

Patrick
