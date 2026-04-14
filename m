Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C2275AFB
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200211; cv=none; b=p1apUmfXiXYMeBEqZ+yPTereKi74Ww074jgwzJzbl7a+AWF7GBtdWOwrMm5drSbs7xzw2+iUj/0XE5j79J7iYPF9cCB9kKn0UQlhcN+R6p+AFznmFPB/NKodAOe1FLH396u9hG8UOiZlNKVtsNF9aRdMukivX288U8iRIvBz9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200211; c=relaxed/simple;
	bh=4Hj0CfibSYuGlg+GUeM7OW8Ey4UisWnswhQp0xwSuXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tehiKA0XUEF7iHVQJGjqGMbn5GyN0+vitygbfhwfWfOjnj7mDPIN0uBkbP8unC02oe6YVujzco+h8rXsOTYwovBjkRwS2Llasxj6thNk1MkRdt2otlNGXO4OFP8fbLrWlSVzBOSqWt01agcBFtSI1yoWOOdNstIk13WfOmuAWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ycalDr1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlA3sg2P; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ycalDr1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlA3sg2P"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E9EB14000F2;
	Tue, 14 Apr 2026 16:56:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 14 Apr 2026 16:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776200209; x=1776286609; bh=q5nCjUEP5l
	EINZPZMpoBvdU47mzPsbbvEEVJAFk1M0E=; b=ycalDr1DqsyWmq6J0YfRhP64L6
	b1VBwCBZtWKwFVF2OjCP07E+IopI9ffwFqgjae6ctGbKV8IP6n4uZkt6nu1z+8hZ
	oCrR3C03WwK+F4qsAdolQd56InJRgZsE6pyJhV7WssCZpwmKuHnUSzuNw7MpenX+
	HLNDSE7yJ4SFmHY5ynS7GcllXlmWL5i+j0PAKF4HAs8eyxKF7CvlsE938X2rOEPL
	JLGrwNGaenErnATHhcZ+tcOiNteHz5WlUesSY1Llc+CWKFJaXgKtcyJvMCPl8TZi
	+nMY0UBkll0rcjIPUX+KvFooTTOgCJbVEUYOnmx9hKMlIaE8mEDmpvSwjEWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776200209; x=1776286609; bh=q5nCjUEP5lEINZPZMpoBvdU47mzPsbbvEEV
	JAFk1M0E=; b=qlA3sg2PKIqMSPHkFFYdE0RA4SVZSG72eSNQ+0+hHehJE2Whu7u
	3zMm9VvOy+hsgdzb7Hs5WROwhxR15CxawVRfeemo1Euluxp7huN0oLmL/Mw5LTz/
	DJSRas6abmKysqar2L4UzqRmui0MEgAF9sjS54heM+2vMOCFXu0dMirbBDFd8fqU
	i14yeUAl5MY+R2oZHfpGiqyca1HAs6iLyF8FOggGXr02KdPM6mZqHBbUx1JDDbhX
	9CDZDE4zMvdWqRGuewnnxv24Ytrfs6pCKHXPxy8L73P1LTSWtTnyyzkmc03mHZj2
	4HhCCRdAX7JeLM0jSejpLXMlRTtb03Silmg==
X-ME-Sender: <xms:EareaVrBpBu47w9wIK0JOetJH5NSq1IWwE5nTltkMxY8bFghW2BtLw>
    <xme:EareaZ4zoxT29KeYuvEHxa6HgNRmfIx8xWPz-CBY_A38a9ikdFSPXuZEmCnCuTjGd
    c8Gp2Cemhw0368oyqAdP8whWapZVEy3s-3FEjMrhloBV1YHEse2FA>
X-ME-Received: <xmr:EareaUfKyO7O2AeDTNhyJPGRgrBuHUjmHaXu25RyS36wJvPG8C87iBSZ3Y6b2CJiCKn-REETOqMzzu-hFfLhV9tQxvgKcGDeXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EareaW5YXauQ3k2uPFyqQM_zcceIrsyI8-qJ9pmqESBkoBthr_5Nbw>
    <xmx:EareaTtPTgVRmqIwrGyg9kU-GzbbF4Rjf8wya_rtWOXQaR1iaBgdOg>
    <xmx:EareaegdOCRgQFqKegKk4v_MlZOOgkYZgoELHJS42g73o8axevmJkg>
    <xmx:EareaWqHfQze9prkYnm7RwIKYoRboPLTdKGB1AIff_A8irN1CF0xGw>
    <xmx:EareaV-nqQlunYCtwx0zs4VRk3cBR3ulnMapoz3DptzPkwBeA7x1pY3I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 16:56:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com,  git@vger.kernel.org,  gitgitgadget@gmail.com,
  peff@peff.net,  phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <20260414201636.51956-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Tue, 14 Apr 2026 22:16:36 +0200")
References: <xmqqfr4xcz7s.fsf@gitster.g>
	<20260414201636.51956-1-haraldnordgren@gmail.com>
Date: Tue, 14 Apr 2026 13:56:47 -0700
Message-ID: <xmqq1pgh9s6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>>    The description of the Pull Request will be used as cover
>>    letter, ...
>>
>> so perhaps your pull-request comment should have something more than
>> just the list of CC: recipients?
>
> I'll give it a try!

;-)

I find that many topics by Patrick Steinhardt and Jeff King with
multiple iterations often come with good cover letters that outline
updates between iterations.

Thanks.


