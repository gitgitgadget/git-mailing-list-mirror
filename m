Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35127A90A
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204988; cv=none; b=nML48C/OyjRcXPuPx6967f+fbbf2+2BfycrNpM5Qpcs54RRMA36klmNtnCCTwpDIe70CtRtoFQSc0oQSqXu1UkkU0SgXkp7RzvhENkGUcap4RfmVEZUrcP3b0ORPMTHynHtJ77ZcjKeWYgI+8y+QLnllpN/uxIdNXSSLMQu+C88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204988; c=relaxed/simple;
	bh=vVUL9VREF5fgMLBuOHHGM55cE5l0SveZEiCtoguhsg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOQp1A8gL9eUuFeHMbAWGcLemKSwhl/UPjG+gIk2Z34aXuS4Ed+T2p58KK4NZ32wKG0MBEGBtkWjMjwI6WXVXl8AG0vRdg/VV7aJjF24Q/Hd5QfBufV2b7JQ4wSEY+RYzLnE/nAsUcYK1Yk1KNVwDc+Km5f3BNEzXf0TStPkwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ux6/b19a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZehK7HW; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ux6/b19a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZehK7HW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D53DEC0446;
	Tue, 22 Jul 2025 13:23:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 22 Jul 2025 13:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753204986; x=1753291386; bh=eQZeJ4SWbS
	rbvKuNoFsAtf4tWIRMpOWJ1XlMLkGxC/0=; b=Ux6/b19aFPu7Hr8FjrzSX7J6/5
	4fzm3fEpAAbz0VM97oLFuRzTrn6kgxSrlzKIiZBc9Qz1b3NjBrGTm39bbXuS+xCe
	6F3NKPfQDKj8KZxI/+porC+ECZQI/ZUi7bDwjDtzNyTJdpgcvmacx4jLmiiMNkBX
	Qzu/QbE9ZQcLaTKr094hh8dPcmqfkODXTPdRt+usXgbpR5EW2o3HnixZxnl/nmcO
	mIBhaeWafnuEtS8A+1K28WBYcgLuO5iMHivPA+9Kgm8y/kyrkZui2JWB6CekoF1q
	9IYLVcpMtSYL3Q4uVZ0cGgZjIOSRBs4tawzvdOS0RgDgKZHs5ExCH81gWIbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753204986; x=1753291386; bh=eQZeJ4SWbSrbvKuNoFsAtf4tWIRMpOWJ1Xl
	MLkGxC/0=; b=bZehK7HWU0MNNSpreCAKDP4iUZQlpQQl401w4L7XGnWxIjC/rPh
	3hS1mLIuXQcuyw134L7X3tAnf4pesUQ/TYR9uBKjAeXVlNquVUhvXAntgJBDT69Y
	jfHLc9LDuutPgOqJBu3tJe9qirxSguCXJKETwL6NscB3FSRmSMaGF9wjt7P133uc
	MERVfdyg4wu5eEDXuU9S/MhARezecWqDaxLoi0x4i/TmNSIVXTdVwEfgnubUyqXm
	AXfTvaGStjaAp5RIJ+uHXSfK0ekVvgS03eWCT9itTvXbZINiqtCAzdYmRdvCsl6a
	WQ1AnOqvRxTs427QTbWoeMwDrL6zERoWZDA==
X-ME-Sender: <xms:-ch_aEc4w9qyV8CG9IRe8Z5U-FslIamt4uwb0fF5rc2Et_Mv1amBkA>
    <xme:-ch_aDycZuhDcGWafbt8bHoBn0W56guSKkdSwklLUQm1jBxAIRFNp1YONLX1FiM2j
    tgaDq23T9DPmESfeQ>
X-ME-Received: <xmr:-ch_aL_bDcIlZaZB0KLUtXmap_sc2sYNJy_xDR0yioUsHo3bvCbSKOCklkec_dug_E5A4N0o0FZ8eiqr08K08nPymy3OPNBVvC7wV7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-ch_aLj-HJHgHcftOQtxyeYEtq3B5MMBSMaQg0zjRa18tcp4qUr4pw>
    <xmx:-ch_aCEkH4oHRug7mv7V7QySh3YOltqLrfpWcdsfZAPxlp8YfWAn-g>
    <xmx:-ch_aK9j_iklWNV4SK6sqe9pmfIsGJVrRIctkhW1PMopggBPwRSeKw>
    <xmx:-ch_aJymnKSL-FX27U6me17JEiypUr5YtRgglFxW8OSOGcU8J6lozA>
    <xmx:-sh_aApZ-WaFF74id_Hj56Z8uRGKEtX7FTAd-bnxFEmS5BE8Ugno6Ueu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 13:23:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent
 emails to an IMAP folder
In-Reply-To: <8596251B-7A3F-4220-8759-B75FF63964C0@live.com> (Aditya Garg's
	message of "Tue, 22 Jul 2025 16:31:59 +0000")
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
	<xmqqpldtxsp7.fsf@gitster.g>
	<PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq4iv4x15e.fsf@gitster.g>
	<PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95973B291F0A52A19DA8BD49B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqo6tctez2.fsf@gitster.g>
	<8596251B-7A3F-4220-8759-B75FF63964C0@live.com>
Date: Tue, 22 Jul 2025 10:23:04 -0700
Message-ID: <xmqqqzy8rvgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Hmm, yes it does, but is this functionality in the scope of this patch?

No, it is not.

But it is your responsibility to make sure that you leave the door
open for somebody who will want to do so later.  And you do so by
not squatting on a way more generic option and configuration
variable name than what the feature you are adding, which is more
specific than its name.

