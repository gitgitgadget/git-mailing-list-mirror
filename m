Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CB1E98F8
	for <git@vger.kernel.org>; Mon, 19 May 2025 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690093; cv=none; b=Z3bfqXZ9J4NYs99vTH1I6llN6M5aWJlh9k8YoruyzSlGv9IK44M2KMU7fXiB4zicBgBigpss/JS7zDl35niUFim4SHjnbSPLmUThv0btnvDHLq4eBGxjErZ8YScd4ohPzlnKJyhxNITrHIeP736pXIAUNwNVtlL8XbsT6yx1zoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690093; c=relaxed/simple;
	bh=XxiPNnnLqTSUdEuebpGQ6fyA/jkHdmeMpo9urrjUg08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPfbw6DTiJSrFSbqAQYisWSDHTkZWYR8Fof0rn+3+6gx/oRtdi7DUwd84VS57xkRf4nu0KSXPWNjuuay9c5LCWGXUkXhXLaL5TVvJakSHp5+bx7SjNAKHoWbKE3nhskGbE/UaQ4z6VZUJGCnXfcg0lZXwOoGDEe52mq82Ptzass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZMfwZ0Wb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wajw5WXk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZMfwZ0Wb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wajw5WXk"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFC5711400B8;
	Mon, 19 May 2025 17:28:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 17:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747690089; x=1747776489; bh=9ejlHI1Qqe
	Dm6+seLS10ItTIvsp27+B26qxYbKGldmc=; b=ZMfwZ0Wbi4oYhlO2yRAFoEzWpc
	HK8gLhpODSgTtHqte2y5cfheIgKo3W4WW3co2MWrlaCMxiAPKP7ch/ffXMQOo+GO
	HSo81+kKlhPPbGelG0Nj+gHNXuF846pYLR3Ic88MPVutDFR6Pm5fJTNyHsyaz09V
	SIqnWP4Os+7tmUp9UjKhPkik7HxOVfLS7K664FQqi8jEVYYWP6hXTSMLU2B0fSb3
	iY97lAS8CGHTGXkpSFuHiNR+WCnCnn4uwG9ZZEMHtahwqxdHzykC+XHzDfuZrsSs
	UP/u0YkVCtRckt9QKY5C6oEIZaa6lQdPM5BfdIZUSxAv36wPHgxiHIb0rB6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747690089; x=1747776489; bh=9ejlHI1QqeDm6+seLS10ItTIvsp27+B26qx
	YbKGldmc=; b=Wajw5WXkg5Th+eY8sWlL8QVkHPXi0QDxyKWGPaIjZ2xjEcxjVx5
	+o8QKUq4hLC9VL0G3mJ8HYYq9dnyaBhEwkAl1r8HZ6w/A91ZocshuiFcf420nGWL
	busJmZx75uHRExGJF8uWtAk/2GZOWcLW+WG12lCsmBcupfVioHN+H7exNsFB7nlQ
	JTkdt48/uJLGgsrjxV2LwjuSn1leyJZB9yFcr8wy8DNzDGMqb/L8pploabxpNwXt
	EZgVGLhLIv9ltdZ+nDz/ubVh/uDXm0or1kNkWJm9G+aIX1AEhmDa6XK3IXZQo5w5
	wdNXzicBp0zAQkB5yY7nHFcmMHTxRjDqi5g==
X-ME-Sender: <xms:aaIraOoZPliW28KFlrcOSxREfziEt16W1z23bqHW2xfehEFc203cXA>
    <xme:aaIraMpgZ3XYXsU0g6jmMf761qynzLEcVynXJ182J0KtQftKhgP2V_lxGfjiWsV5t
    iYcNSHmSBwaWnrnJw>
X-ME-Received: <xmr:aaIraDMKkjvlpA9q7d_8h6bUuQqEytTdAXdFFKk9OlHhghSrIYeESiPBr8dIxnPdiqeU5-PdI1w_KODd_L-jivXz6Ixq-gWJv9TUJHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehjohhshhgrrhhirghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aaIraN6VP3ghF7l8otBMl4wS_4OLIuCF8D23xI0ppMSVSn7AJDeEmw>
    <xmx:aaIraN4HpDxiA35Yfb83VDzkhgQ8EtFHFRkb5MqNaSWg5PTCMPHceQ>
    <xmx:aaIraNhpd3b-nN0t6b2m6xlG47HMyNN_Uqmpz0lPaBVZkBmHW9IJ3A>
    <xmx:aaIraH6yrQ__zMXp836ZQ0Fy5PC2VFh7FtV6TKSP13wH95SiIkmkiw>
    <xmx:aaIraLMgHJ80fiqEsWViSLDFSFWY6RRzgimKFH2yOywGM9smnVOrqknv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 17:28:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Josh Bleecher Snyder <josharian@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Feature request: make reset --hard add something to the reflog
In-Reply-To: <aCuMshOaqcuwMCpG@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 19 May 2025 19:55:30 +0000")
References: <CAFAcib_PV4EB-i4PUmTxCx_6LX=8aWDNT_ZPrN0-EDsRwRfi4g@mail.gmail.com>
	<aCuMshOaqcuwMCpG@tapette.crustytoothpaste.net>
Date: Mon, 19 May 2025 14:28:07 -0700
Message-ID: <xmqqjz6cmgt4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't know if we want this by default (although I could be convinced
> that we do), but I think this would actually be a great feature to add
> via a config option.  You are not the only person who has accidentally
> destroyed data with `git reset --hard` by any stretch of the
> imagination[0] and this would make that much less painful.

I do not offhand have a strong objection for the _feature_, but if
the implementation uses the default "stash", that is a bit
worrysome, as anybody, even a script, using "reset --hard" would add
a new stash entry, shifting the end-user's expectation of what the
Nth stash entry records behind user's back.

Doesn't "reset --hard" add record to the reflog already, by the way?
I agree that a way to recover the local modifications that "reset
--hard" is designed to get rid of is a good addition.  I just do not
know what the best vehicle to store the local modifications is.

