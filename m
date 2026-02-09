Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9A12B94
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674516; cv=none; b=gGhzFCjMM1RmbURc/opn7MQz/LTFnRDbQzt9yA31bVY6okdup8YQ6/yx86JSXC3b5Z97q5XSAXtfn64SYGbfAxV+13hnE3xqZyVGy7r+qtpDtRaFnsd9TsnNHJ+7U6J6grnVMUtuEQzg0Ojld5njktX71In4uVBSOegl79p7oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674516; c=relaxed/simple;
	bh=NZwDQBHWfzIVanDJ3uFOyCxtgQBWimFuh7OQ9ED1gmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BDD5mwST6brORk4X2ZXLsZu0qVrrbTKzibKmdfqEht6MVFEScs5UeAioH8h7xuzCmnzE2nriph4wSUXQkDzOuiVCfOaWlH6dKWGXf+nHTS/Tq9fsZY+PR7Pj1kFqNkMlYuJ7On0xwh66efKLx8yFlAGf4C1x/32f7kHvU/NdDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kzRzht0k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PY/eTaK9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kzRzht0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PY/eTaK9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 521F61400103;
	Mon,  9 Feb 2026 17:01:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 17:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770674514; x=1770760914; bh=kaTYJhputi
	pvqylK5Mnogzaqt4M+g6M5Iy3kUvLAYkY=; b=kzRzht0kSfPbnbcCUIwMAnHIX6
	hH7l0d4kJ1XkIBY6uwRBtdANLKHIM9Dgx25aWhJ8nJBawSGgiTb+KPIP+EKaLbO2
	AWBr7Hggz6OLHqsUnRQ6+0LLV0Qniqqg4z16XHvSQOfpsR+WI8bf41Kuf7aDMg+j
	hCQRfTU3hHfRgJeuSUzB3b04pZOtypIdiSqW8ykaRPY3iqZcyAxxpW5gYE9xQdVN
	js/SUxXzb6DqbKzo/a6Hb8S+upvE17cU1OEr9AuEZvIjLZI8G4sqjyXkPiwz+tOS
	iZvnEBeCjG/zJXS89yZb79muNZbNC7iU4heLs4KhC/UcKbCuO3ru2Fh117ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770674514; x=1770760914; bh=kaTYJhputipvqylK5Mnogzaqt4M+g6M5Iy3
	kUvLAYkY=; b=PY/eTaK95A1cxWKv04XX8kZIpiSksehcXcJHHE97PumerID0eyS
	F6fjiGtf3v8535nagUHMVAtnim6mDejoAPyXcdKxE9Jja9Pkw5oH/Qxj3orVqNDZ
	xg+J9lQoiSAXCHF7xNOP88Ny9hUfjBK9KwRG2RaiHoEtS4TXYLuTW1GA5t4RPSG4
	IP8ayuBFs/FxbxLbXo8Ya8woI76UtqQeDJNfwXsZ/CwARz6FZ1nyZYX9vr8gcLms
	Y9G41aoWU55EU3k5NuY2wpoOwSAyhq3dpGQRegg+Nz1oX0snsM5YsdTUfSziwmET
	5n2yGNVf1/jDWpQUKPCCDcK2lebxs9RwBww==
X-ME-Sender: <xms:UlmKaUDndzAXwwJRLzt5KNcuIV7r5Kc6f-g2cSs8G_YMIZKrLGLlWQ>
    <xme:UlmKad_tor2_EH4vzi9_dzcBk7vVa7BxABYMrCH6ti-ObwK8EYCFXfXu3fzXIOc3J
    GZzkksFYUR5-mVHn9i11CEd3iw8gs5hrabCZegwwa_B5FQFgxrKVQ>
X-ME-Received: <xmr:UlmKaU-qJwBs-Fl2l9zQGEItT2kjbM-g3LxliBCfrvxngN9S2QrwYrW3STZGZCAfnOMhos7suqKsV-wAf_aM138xnyrnxz4QCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhhu
    shguudduvdesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UlmKaUcBhR8XVdgkVXqnq4yskCWzYFKsnlk_f4izTWp37KHYm8BCAQ>
    <xmx:UlmKadHQnBTsSmHIT6DKy0S-BOzeoAW5CKn8-VEkssPycefZsvyeGA>
    <xmx:UlmKaScwnnPt-aVvM8-84mtNtboNOTPInhOFacdOxVSZUJs7JUfl-w>
    <xmx:UlmKaXGUZP18bukB1piS_J51IqJWZPzvoH_mb0g1MjoiRpO3limc3Q>
    <xmx:UlmKaQmhAlt8YcuLxSpRLgfaLgtgSXh9cvdt71mTZqKC90yPsVHyefCq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 17:01:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: markusd112@web.de
Cc: git@vger.kernel.org
Subject: Re: missing git documentation for "git clone --recursive"
In-Reply-To: <ae4cb197-1edc-44c4-afbb-bbb24df509e8@web.de> (markusd's message
	of "Mon, 9 Feb 2026 21:34:48 +0100")
References: <ae4cb197-1edc-44c4-afbb-bbb24df509e8@web.de>
Date: Mon, 09 Feb 2026 14:01:52 -0800
Message-ID: <xmqq4inp4lv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

markusd112@web.de writes:

> In the git documentation only "--recurse-submodules" is mentioned as 
> allowed argument, but not "--recursive".

Correct.  Do not use it.

In the early days, we mistakenly used "--recursive" to mean
"--recurse-submodules".  

After we realized the mistake, we would have preferred if we could
remove it right away, but in order to avoid breaking existing users,
the command is taught to still notice "--recursive" and behave the
same as "--recurse-submodules", but stopped advertising the former
in "git clone -h" and "git clone --help".

This reminds me.  Perhaps we would want to perform an audit for
such OPT_HIDDEN aliases and remove them at the Git 3.0 boundary
(this needs a separate thread to discuss)?

