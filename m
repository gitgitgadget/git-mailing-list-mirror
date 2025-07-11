Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA432F3C13
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258845; cv=none; b=cxXh7v39KTGpdL5dyyorLoXEDjxtfDvbQIdCpZuPBiQwp3strhUCux8uXvqJ2YUs0cM0IB5GcJGtNBykjakfru1jPcNwt5uBZ4BFBye+lquLBy37WwjPzx//s180LlzhgixxT4sGRfbDMXlSIEkodQz/agidjwZ64PRlJMYBnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258845; c=relaxed/simple;
	bh=86SwBhEtpIajFiqCyob07lJiuwKD0VM9wynw1nUWeIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wmko1gcjS58Zs5LDOcJEcCwhu35yZBKOoxt/JEIOl3Kkr/+U0IziQEriKJGy+WIC3t8yPZ6GaRYjvgF6y3swizBs6qhi8XBfArKqRx0AewG2VzMgHyLMFpAqs0zt8i3gu1L8VLNg1lrOQLPW9GcrQ/d8/gsMZo5BpX0xHFQoeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ilhHb1q0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rvh63fMK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ilhHb1q0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rvh63fMK"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61BB27A007B;
	Fri, 11 Jul 2025 14:34:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 11 Jul 2025 14:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752258842; x=1752345242; bh=J8HLQeRUak
	xiFxhGyz9eBQZ5Rbdwbc/GeM7K7WNPDU0=; b=ilhHb1q0RZZDm4EEIeGHtuCLSH
	xlbaHeCecJsTkH7cxvfRRxKku63RQQCttL7dtSRF6jdvFxH07aOUpJpQVnh1OcfK
	UcUJGpDSu88mYV8Nson1ii2/0t4DkzozsEcCrbDProyz5+q6xrbinX+cu3XSbtpl
	2hoPQeTf3nryllISQXjLpMeG06cJDP2OnmJyfCicCwRfjvrgAmAIc9EkFbjsi/Db
	VjfBDqenLUaAbFIcJnxBrXDoA4BTy6pPOEpFDj/3QE4mrnIjRS72euMlUMCNkUFC
	pG4RTR7h1+HCbDrsgVE07ba9RfPRyyyCJoBPPJAzSPdb6ZbovgICbVNoBuNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752258842; x=1752345242; bh=J8HLQeRUakxiFxhGyz9eBQZ5Rbdwbc/GeM7
	K7WNPDU0=; b=Rvh63fMKQ300OZwaxMoOfZTwHrY/erhcS1BAIbuEsU7XT1/ULXp
	mGN0NiWZ+Ls0I+K1U35p+JFc/4cOvGA6pEMOC1uWLFAwqRpmJ4jQp9mXwGcXVDiF
	KzXgEB4R9eW0giti/OF4/D5XT3oRKhiUuVUx2mlgDa5iEt+N01HnkqosWW/Y6Vfa
	hlvDg2OKxXJmxO04+VJsODpVDNtEufiE8DgJ92KYpNnfe9Nv47kgDNijD+SB5qOE
	FOtvvUtyUmfPLn1M6lSCDmrH6PJN0R/DU8B0OAgrvPo0Xzy2e3UTRkVpOZdiq7Rz
	cxOgYltkPuZx2ZGuyGzuQf1J1kybeUqTMew==
X-ME-Sender: <xms:GllxaGnQdhbQK_BiknhqBZOUwb2sQhMwFu1Tttv2DkWfJ7OgawMvfw>
    <xme:GllxaBEbH7NUxpIfM7z__LyOWFZu8uEX7LKWHSDStoqx-kqj8dcPOvOOkkDbU5pHP
    ef2EU0_OGCA7WSaNQ>
X-ME-Received: <xmr:GllxaOFPBtF1-H_hE-JQsoBWeAZKqOoEMHiPpLVd8nybWPTB8eR-sEhnVdn-ogTma9xYHIRnfKHMgBol5J4EhcEADDKfv8BOOp4CCRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GllxaGOkQdeLguHO1Wi32qtlgKJKMTIdoHIuITDBEeQE48wukEnFzg>
    <xmx:GllxaFFxeRAc3ePcIoHhvNkRfEnrLYNJvEZ57pLT4t4Qegs0dhTGJw>
    <xmx:GllxaFMPA0I5Aq65YsxJQY5GQkCC4dFQ3Aq1583_ncJTLpGvE3Di0w>
    <xmx:GllxaO_YxFh_LMZAlfr4dC0S0VzFlYeve9e1BA4Fytr7UtMTvBkvaA>
    <xmx:GllxaNuu7K9z9f0zj7VhreJ5QkqQV-RznudfpVoV2Af4S80_GiIFqtJb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 14:34:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #03; Wed, 9)
In-Reply-To: <CAE7as+a_q4YxPQNdD_fROZTT032_J+E1u9yi94v6XfqM7szVhQ@mail.gmail.com>
	(Ayush Chandekar's message of "Fri, 11 Jul 2025 23:45:17 +0530")
References: <xmqqv7o08ocn.fsf@gitster.g>
	<CAE7as+Ze8EHda0wMfRKC4z9jE0OLsxxSgckBLisJuoxasgzTaQ@mail.gmail.com>
	<xmqqple63eeh.fsf@gitster.g>
	<CAE7as+a_q4YxPQNdD_fROZTT032_J+E1u9yi94v6XfqM7szVhQ@mail.gmail.com>
Date: Fri, 11 Jul 2025 11:34:00 -0700
Message-ID: <xmqqh5zi1srr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

>> >>  Expecting a response.
>> >>  cf. <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
>> >>  cf. <xmqqbjpuqkrj.fsf@gitster.g>
>> >>  source: <cover.1751309770.git.ayu.chandekar@gmail.com>
>> >>
>> >>
>> >
>> > I have responded to your message about keeping the topic in 'seen' or not: [1]
>>
>> It is not an issue for which a response is being expected, though.
>> Has the issue Phillip pointed out been resolved in the discussion?
>
> Really sorry about that, I will address to his issue.

Heh, don't be sorry.  Miscommunication happens.

And thanks for working on this topic.
