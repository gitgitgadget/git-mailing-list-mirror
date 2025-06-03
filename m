Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09206173
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748909877; cv=none; b=jMnwV4PoAndmwjM9/WnHA226pwvtJPlwTj4tO5v9B/J3H4/XZyzA60X1cXPDaKkbqKzKllPYqev0aMZ4/+KwykGxW+2tGbGp9WJO6GF4ErZ86pYGu93BX1GKl4SeqRNspiXy3gA51W3+Df82ysYev4YIjen2DC3lrOpuN3SN2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748909877; c=relaxed/simple;
	bh=tsgjfR84MhI5ZVqLsywcarzCqvI/9gtlm+ArmoH1t6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rsRU9+w2xaHSCfzT3ePgjRpbni4H8m7+9M0XR5z53AsjrQKJa3nUodcYYUpNJUmEu3D1MgetIabYwhmafCbvm5FYh2XIfKEnpSf5Llzp8NNFQllVwgxU82aP6fkE28M5NCKnrNdpzbUkbtm3NzdzdEcNJB5m0+YG6+4OxhGFBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ekDPidvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LTxEcny7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ekDPidvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LTxEcny7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDF0C114010A;
	Mon,  2 Jun 2025 20:17:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 20:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748909873; x=1748996273; bh=4rCJzAl3t6
	JZr+sPTL7Ct4eiEr6O140drAlBZoPDQo4=; b=ekDPidvG/A20SfLJeeWUUGnYyE
	TvTCHtYYLloqeL5ug1hL6l9b2dH7U9dD17P9GAMMji8oMrqLeQaUHHQd4sQT5e3L
	FWTpXYu6pBFW8xZllGe0bDhjqIDfJRYdgEwgCyFc6dd83nP4HA8s3QgbQ1Hgny7+
	n/qtDyUxID8gdfgqKqrsLIfCB0FQ5wfRuQ0JRxqBgckFXyhxQco8EjW9pCcliVlY
	M4sXpiCo3/Xj29Ofc6+dHHTUnN4LIgSAOkowTCHdvRpbNfXqG4MHEmfaAK2uBEAi
	q0W6thEXXialMex6axMfOH1q3Gp10KjJJLANMOnXdx65ofP7rnTc27wfW02A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748909873; x=1748996273; bh=4rCJzAl3t6JZr+sPTL7Ct4eiEr6O140drAl
	BZoPDQo4=; b=LTxEcny7+7RrsiiUrGu+67VnjbNifKttz8hLxSd41wuKExMloqe
	wZjTgNTGAmH5ToTqLUHkdy9WEOCdr+KU1ROw3Se+VVv0k5RS8Vo7rIJ5Jf/9c3+6
	97ldv6cCw1a9eyls5gg1pyXbqnBl6pWw/vzncAvWtNCzKbAGLcbGjGXwc5/2Cnle
	/7IgSrlS5KzDfpfXy1ue2hWU12T9g4Kw8Wpu8NpGL+Ucpyu/xRdofi9QPHFoQyab
	7E4pJViO5GSHBDCwHjVMoSeSBIUHQMf0zPit3etCK9VCDqlEi5ee+crF3gUyNqI1
	dE9xXFvrw8yIGzz308ZxDW1zcS4xvtXuAEQ==
X-ME-Sender: <xms:MT8-aHd3P2A6wizMjvMQWudGyOK-qB6H8jusr4HesyF0vP98gaORyA>
    <xme:MT8-aNPjBJxeecidk7jCwzaGpUBXJhOn0cNvl4e1q1AYaNX7MP-lMZowqj6J4BbmG
    cHSnWH7QHzjYYbZQA>
X-ME-Received: <xmr:MT8-aAjrqMpeTYZwdi9eZOIy8O8Irm9imE-qOJVw6W4k3HPYIkMSE0vnjt4ZOp_8QFed3OaQE3-0nhL4Bi35zHwrWdoCpLSCivn1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefledtkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthho
    pegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtoheptghorhgvnhhtihhnghesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MT8-aI-uWO3DffUxvrCVKuNAcNMQo1vyPOzMjlIWaSA53y4Ckfin-g>
    <xmx:MT8-aDuRruU3qEIhO33XV_U9q_Pi16DrCTaQAh16-ZrGENIPoMs8DQ>
    <xmx:MT8-aHF0GS_ttGSutk02RdHZH-J7vjE2HM0PEE_sI90tmVNUgwy5Xw>
    <xmx:MT8-aKOrPbVEcKXDYo7axkV2BF92lGqK1Qfibw7rIPIUcSucpUi3RQ>
    <xmx:MT8-aLOr56vhAK_ZFzCXQ4k_O0SZaEKsRhvHOopKoBAQswoJ1XivWZ2L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 20:17:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Collin Funk <collin.funk1@gmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "jn.avila@free.fr" <jn.avila@free.fr>,  Corentin
 Garcia <corenting@gmail.com>
Subject: Re: [PATCH v3] completion: make sed command that generates
 config-list.h portable.
In-Reply-To: <CO1PR11MB508935F77DB5D7CA29BF8D79D662A@CO1PR11MB5089.namprd11.prod.outlook.com>
	(Jacob E. Keller's message of "Mon, 2 Jun 2025 23:05:20 +0000")
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
	<59b2a12a3f43cf078fbeaf0271b5a7cfffc9eb8f.1748903426.git.collin.funk1@gmail.com>
	<CO1PR11MB508935F77DB5D7CA29BF8D79D662A@CO1PR11MB5089.namprd11.prod.outlook.com>
Date: Mon, 02 Jun 2025 17:17:52 -0700
Message-ID: <xmqqtt4xsmof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

>> -----Original Message-----
>> From: Collin Funk <collin.funk1@gmail.com>
>> Sent: Monday, June 2, 2025 3:32 PM
>> To: git@vger.kernel.org
>> Cc: jn.avila@free.fr; Keller, Jacob E <jacob.e.keller@intel.com>; Collin Funk
>> <collin.funk1@gmail.com>; Corentin Garcia <corenting@gmail.com>; Junio C
>> Hamano <gitster@pobox.com>
>> Subject: [PATCH v3] completion: make sed command that generates config-list.h
>> portable.
>> 
>> The OpenBSD 'sed' command does not support '\n' to represent newlines in
>> sed expressions. This leads to the follow compiler error:
>> 
>>     In file included from builtin/help.c:15:
>>     ./config-list.h:282:18: error: use of undeclared identifier 'n'
>>             "gitcvs.dbUser",n       "gitcvs.dbPass",
>>                             ^
>>     1 error generated.
>>     gmake: *** [Makefile:2821: builtin/help.o] Error 1
>> 
>> We can fix this by documenting related configuration variables
>> one-per-line instead of listing them separated by commas. This allows us
>> to remove the unportable part of the sed expression in
>> generate-configlist.sh.
>> 
>> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
>> ---
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks, all.
