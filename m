Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA023E229
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701324; cv=none; b=TzNOVa3k5DzRh+Jh6GMXsPaPPOhcPvWV2H+5jgAcM9x02IQIqPNBcS9y1NhcEhRgRMA1i1X1B/ZMiNcaxKyE/eTG4AFrPc7QuGaCr5O8jvGLSnT06iK5xaM8oNBGriOtKZPPx80mpVZv6G54wKFanoB3OVpYvuF2I5FErB/Ht8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701324; c=relaxed/simple;
	bh=tegTU5faRGFSMDt7YPPmjWEC5+HG73B6aYtpDBPgH8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw58Dzuffm0PpwCUfpPnnyjbgy5GSCy8JOtikZOLW1st8wNgUGe6C0Fh8r2a5qDU1xaSilmM5IlPcx0Ys9Cin1UHeyLUsDlbtMFl+2BJYBgP34tohzAnBLGSltjo0pUjeXmz839NCnO74fwQLUXZa4JhfU4fwsOpZQH0g4ruRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cQSdpeBz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxp+yCnl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cQSdpeBz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxp+yCnl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC8B314001E6;
	Tue,  2 Dec 2025 13:48:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 02 Dec 2025 13:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764701321; x=1764787721; bh=dONROHiBCO
	onuBnwjyLOEGNXXpOwsdw0mjw94B1NB8E=; b=cQSdpeBzk6FyKmRyyRFnKrAWYC
	ZCEBPrajHGWDum321Wd5hyGa8M/UdYrcm66iga8FWDGRxefcbydKRqnfSRakxUKe
	YX60ddh6Wpqt3q3vORYP34tUlcjzeJ93rCTndjsmXj6pbV45b565oF686fn3C0uV
	JKhBM8wZtbOOtSqGYFKUv7AwJUxZAguWvnsjN+FFOPqzhf7qaeac1VZKFgs5LZgP
	O/uP0+acOb9DGAwpe5dK+I7Uhil5szPK75J/LKCvxjmyDOIAAiwjmPOj0s3q0yfC
	CdzbQ5G4tMyUWHnfLSBndZ1BFjMQqs754zQQVFYfIhxO+qQzDKRbLkqxjhiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764701321; x=1764787721; bh=dONROHiBCOonuBnwjyLOEGNXXpOwsdw0mjw
	94B1NB8E=; b=mxp+yCnlmqz6c1vC6Hrt527k+FgmjFEkssSguR0+SGf4jhSsheX
	eMOhbbqHpe8qnO+slQpbUSuSt+BZL9EmlPNRPZZglT8JVE4Pi1Uey0JDo6lVcK1m
	dD4Ij/3FBw4cES868TqMWjuCWlvpK0Q3mJzfDokWl3QlHIG2BbYp+esM/CqI4YS1
	4BHT+XLVDKzCjvgrQaYXSFtmMpuNvidUTpZgWHAdO0+4KKBflTlOliQtWEht2597
	F5a5EoBhIknYcRDBwd1DwPtEiYU2HPcz5BWF+40b4i+ncTkMThxJY9uVWjoQ05+B
	VbY+MvSd5qcv0JS0Ltyp9KvA9BaYWMr6tvg==
X-ME-Sender: <xms:iTQvaTRf6FCajUlgCjlXoGNAJvexMafmVCRrOHoziqdjyShF3DexkQ>
    <xme:iTQvaX1C3kSnezKkPfsrhetuqU9l2SroWuQYb9hk1DjVjNTmMdp6fORaV2Vey-pwb
    rhSSx5iNjhGD6DSkI00aPM147_8h0n7E6fq76ttDUHXawB07Ij-gw>
X-ME-Received: <xmr:iTQvaTd1uA8MCotdG67knSMQrqiugLdaxJYg0pmYyvg_es0133NTJ9WiUy6tr8lfcAr0dZGsb2FxifgMfIrMmXRXrKsoac0Wf70PA71OyNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhrghgrnhhovh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohep
    jhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonhiise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iTQvafPJjwQyT6cUyuQTOwQv42TLsD2cKtMLF3i1KDCsaNnV2kdBiA>
    <xmx:iTQvaXW3bZpqUmkEupEY1JlInD4IqkG0dasRp6JFQCWwggOdD8nCWQ>
    <xmx:iTQvaXxL2Ks-S0GtEeN3gwws_bZSOFSCWX0HXXQYn8k34shB-PF7yw>
    <xmx:iTQvae9NtCa6vzPNXUYW6rJm17MKi-AlCURB5vm-Gh3Gjkr8wFLRhQ>
    <xmx:iTQvaeZABc6CxWn8zFICWVLlYCo0dNc-QFCD3s0Xz3hHR26LHJJEEHNB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:48:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b33b5241 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:48:38 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:48:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 07/11] add-patch: split out `struct
 interactive_options`
Message-ID: <aS80gHQOfKWtSy5n@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-7-407dd3f57ad3@pks.im>
 <3872545c-6738-4852-ab2c-8c08525ff795@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3872545c-6738-4852-ab2c-8c08525ff795@gmail.com>

On Thu, Nov 20, 2025 at 03:05:17PM +0000, Phillip Wood wrote:
> On 27/10/2025 11:33, Patrick Steinhardt wrote:
> > Refactor the code and split out a new `struct interactive_options` that
> > hosts common options used by both. These options are then applied to a
> > `struct interactive_config` that hosts common configuration.
> 
> I'm a little skeptical about renaming "sturct add_p_opt" as it only holds
> members that are relavent to run_add_p(). Also if we're trying to draw clear
> boundaries between the two subsystems hosting "struct interactive_options"
> and "struct interactive_config" in add-patch.c rather than add-interactive.c
> is potentially confusing.

I didn't want to add it to "add-interactive.c" though because of the
direction of the dependency: "add-interactive.c" will depend on
"add-patch.c", not the other way round.

We could of course split out the new options into a separate file
altogether. But that felt a bit heavy-handed to me.

> > This refactoring doesn't yet fully detangle the two subsystems from one
> > another, as we still end up calling `init_add_i_state()` in the "git add
> > -p" subsystem. This will be fixed in a subsequent commit.
> 
> I think the ultimate aim of not having to initalize a "struct add_i_state"
> in run_add_p() is a good idea. I'm not sure though that having to pass a
> "struct interactive_options" to run_add_p() is any less confusing than
> having to pass a "struct add_p_opt" to run_add_i().

I agree that the end result is still a bit confusing. But what I wanted
to achieve is that at least the two subsystems are clearly separated
from so that one doesn't have to wonder anymore which parts interact
with one another. It was extremely puzzling to me at first, and the end
result here is significantly easier to understand from my point of view.

Patrick
