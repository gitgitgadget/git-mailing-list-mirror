Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368D1DFE2B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406602; cv=none; b=qks4WHrMLjFCM3Fr6otk8d9SJFXk9M5xi8E672dj72RNdFoaeRczB18a223b2HLO7cfgjLkpkWxv9v7d/ELLfKTUVkFCXXU424uJV0+0IipXF9VxOUkJwVv87kGoHJm9fic9MuDupu51ZVgqXqKf23orsGOtrZYI09x7W7sd5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406602; c=relaxed/simple;
	bh=rqmXe8GrYRA/nPDm+hihFy+HRcQ7zTWrqRLvkWdIoUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nN8UDVvryoVUXSBtO2HSwuNzBvX1dDe6l1OeIKWTtkQMoWPQJrDyJ/ItFHpEaqj4iPlDrQfNhkwSgiv3ct0H+ZKoA2NVaWQit6D3BtTws3jBdSUIM1I31ljjLjvLupTvwav2XSmWJc8bmU/t/Zp1a56ewY1HZ4eLZ2FPcAtHJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pvwiehWA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nu7t+NJR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pvwiehWA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nu7t+NJR"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D228E13801C5;
	Tue,  8 Oct 2024 12:56:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 08 Oct 2024 12:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728406598; x=1728492998; bh=q50/0jC/bn
	+nQ7yIkDDgElKbl3UHxama54wCCHevwxE=; b=pvwiehWA2oiEtVyvp+AibPLn3p
	gH9LeMKIekX0VYCciCtLmf8gKku37RY9CkHx7jxCV04f9bE6xnHDr39yGawDz6uM
	ZfcTih+1cgIr6EEAw3JtJa27RAdS+7jxtTUXZDi6DZG4filYkUd+lOnlNLMWxCB6
	sFrAWB5sMZ7VgnNTj5ZKtkdtlhLPDlvFqxuh20hXik7k2PDHJ8Y5ahNXWybrJss5
	I1vZKUjejk0JAqdm0D0C3VKE/Z9f1Tr/cT8e3y1HCWqg7WxOl8pebocE7kG5Etdv
	nonyLb5Vz7bgqschIZ3N6VK9sxiRu2h7DAjr0mM01qNz19A9zR0pp0KjB1Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728406598; x=1728492998; bh=q50/0jC/bn+nQ7yIkDDgElKbl3UH
	xama54wCCHevwxE=; b=nu7t+NJRfUjL+gUhyU+gbPDxfOUkYQzdtmnN9kk/ma8Z
	WtmXaiO9XuzKIMyCLXMe//YqKFO8S2CbN57POzeKq7ZBVdDLIMglxo4Eg0cp2TMy
	njgBgfYoZiNaE22/M4r4gEZd8505c86ulOmFg2QleZYsYGstOXajRx0af2v1+qAG
	oPlQ6gtcpPYew/o6D/ouDqmqRy+ruHreFjwGESRJi7syE6bVcphQkSYfCi6US7Do
	vUjCMchlPX92BcvcNVULwA0yiblmTDk0p2V2Zk2SQa3wOyRbjZAt8chQkW4siMK2
	mVLGi5gx46jatJzGLFbNctta431J69UdAUf8frl5Jw==
X-ME-Sender: <xms:RmQFZ2Ysto_wY4ayZCjkH6Xi1XWFO_kH5-9W5wSwV_FfdRNaZD4R6A>
    <xme:RmQFZ5ancoaeST6K-gip-aSMhdKoSJxiz0KpDdFFII6Gg3OQBuX8iWsBGr0YXGPO3
    on3OpvtS9Y0S5lOAg>
X-ME-Received: <xmr:RmQFZw93Csuhui215XkEZ41GxDId0TdsMxRVVD4ipUXa3F9c4tAqeIadD34s05gOauamwyjoNOy_aMx6wYlEKdDASuNIvbzoqW6BMw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:RmQFZ4qXI-MjbvmxiYulvCpM0a6a1gPn2XZMGWwoBauPrbycRjXptg>
    <xmx:RmQFZxpGyUvPHeliVxv432-ADAP1-B7pAD6IyapkcbP1wKi1-rsTyg>
    <xmx:RmQFZ2TRjMaLSAP5GPbd258DDLlIMpcv9YLGEJwyJw4ifKRNuFTH3A>
    <xmx:RmQFZxqR4kCouZVPWgW-QnXYARDL96FiqIjz4jCU4yE-FL8ZUS3qEg>
    <xmx:RmQFZylpB4lubvJk5RlR1yLdnk8tjii392-fq-V5C52KZ_qHfvLEGviI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 12:56:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
In-Reply-To: <ZwBwcOK2/sazF17B@nand.local> (Taylor Blau's message of "Fri, 4
	Oct 2024 18:47:12 -0400")
References: <xmqqh69thzd0.fsf@gitster.g> <Zv7aLRXwt9cfqW58@nand.local>
	<ZwAIM6GO3VtoG3ZM@pks.im> <ZwBwcOK2/sazF17B@nand.local>
Date: Tue, 08 Oct 2024 09:56:36 -0700
Message-ID: <xmqqv7y2354r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Oct 04, 2024 at 05:22:27PM +0200, Patrick Steinhardt wrote:
>> There are two maintainership models I can think of: either a single
>> individual or a group of people would take over.
>> ...
> I do think there is a need to have a single individual who is ultimately
> responsible for ensuring that the patches are reviewed and merged in a
> timely fashion, that releases are cut on time and are high-quality, etc.
>
> But I also think that the project benefits from having trusted
> individuals who are knowledgeable about specific areas of the codebase.
> The maintainer can lean and rely on those individuals to get a sanity
> check of whether or not some patches are good or not. For instance, I
> would imagine that Junio relies on you to help review patches in the
> reftable implementation.
>
> I think that's more or less the status-quo, and IMHO it works well from
> a contributor's perspective. I would be curious if the maintainer feels
> the same or not ;-).

This turned my "explore how you folks want to manage yourselves
while I am away" into "how would we want to run the project after
Gitster retires (or moves on)".  While I find that the rumor of my
retirement is greatly exaggerated, I think that is a discussion
worth having.

It is a tricky topic how we want open source funding to work.

The "benevolent dictator" model, even if the day-to-day operation is
delegated to various area experts (aka lieutenants), cannot work if
such a dictator simply does not exist (due to various reasons,
ranging from "nobody wants to become one" to "community cannot agree
on whom to make one").  The community has to go with some other
model that does not require a dedicated full-time maintainer, even
if it prefers to have one (and the community can choose to follow a
different model even if it can afford one, of course).

I think the status-quo, which was nurtured over the years, is the
best this community can have, *if* we want to keep the "benevolent
dictator" model.  I would not claim that we perfected the model, but
I would say we are close enough.

What I hoped to see happen here was that the community is prepared
when the community has to (or wants to)choose another model.  And I
am happy to see the recent trend to document and codify how we make
decisions and move the project forward, because these efforts help
us whether we have the "benevolent dictator" or not.

