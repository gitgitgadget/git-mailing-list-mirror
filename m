Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11740DFBA
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258422; cv=none; b=b+mAtwMBKc1OtR/yZgMHmOqdwd3z2RQPdU1NzFToPwJ1Juc87n7pNRE+l2gmKnDHcyO/p5fwgz0qdnSJiSOwaU/kryF6Oo0NQ8b6yLecoqRTS3FXYWKMXTPRqL1rtWK9D3R2IxTY4utq/sOAlSNeI4Tsw4NdhD6gEb9wG+1Kkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258422; c=relaxed/simple;
	bh=ELjpyVMjVl1w1DiAJBmzFgHte7k2zMBBB1OnvRJUWME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4Ilre/Ua3c4PJFAkEOOh4AbO+gVklZIeGSM2+ipvo3RJ/IyTCdRc8bXkZPK7l5Rux/YYlVhBF70sblbMW/BD+IZVJCktqE6oEzKEvr9gPw1zRDIPo0RM09mwxF+OmydnrNu9KL3iptQ4uIvJhy5RPk+EO7bynTIy6FV9A2ugHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kdxtyAhn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4BumBwV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kdxtyAhn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4BumBwV"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB0877A01ED;
	Wed, 11 Mar 2026 15:46:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 11 Mar 2026 15:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773258419; x=1773344819; bh=Jbz47ZIWyI
	KNeAuIPpaJY96RAsyeZ80oPwjaeLyWKCQ=; b=kdxtyAhnQLiZDIUO8C51QbnDLD
	4krO6idzkiK00NgCfqmP1CerdeuY1VRRGnPErPib64jkc3R6egQ9j7dbNWdxskMN
	SK1Zc9+RSHkl40tCeXnNlNFcIa27BNCXteKFheyyVCBMrT3REmdljNtTfK9HszJu
	DeoBhvHAGqoSiTKrrLN3afVRjzTlZ/+yBgnlgX1QyIGYVjdptR7VGmFE4JfXELSv
	H/9oUhLzyWAQhHPA7MyjT1ouBVOPa9gzcb42o0BDcdqF9EU2zwiEldLkzmJz2nYt
	6Tgw0zCojDXUEbWWljhixyQfMf02idv3yV81BdddRkUR6hxoFPkHK/HFNO3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773258419; x=1773344819; bh=Jbz47ZIWyIKNeAuIPpaJY96RAsyeZ80oPwj
	aeLyWKCQ=; b=E4BumBwVSon2QKieEuZ3f+HwL80Qlm/Svja0Aedj/kp6BZJKhRb
	Gbj71B7F2xPhWtiy6RNV9+ofB4In6lWNgAxflU2/AkhXiULRrFqUMzboIrFZLj/H
	2Eafim2pyCmL0tx4W9+lceVQRK+ZgEH+YKdSdlqc37RxB99UK/ZW4tfbIkfKGgql
	RCQRz5ZITPEGeHRoKEUxwe8dtJN0oc+G8d9acYWpDZtia1OsS5rUPpoMbALVnvu5
	/yrwlJ5u2PssZChyPaiKp+IDMF954OyIIBGRMUPFM8rWiIHEm+o70yW/XdRnWdVL
	H3yXdKLWEHX6WJbE1ViuhYVmM949LkGQIBg==
X-ME-Sender: <xms:s8axabHjytawuLPk737CB4ZFyx4VUFqZzpiLGjmA_qgKsgu6uLolRQ>
    <xme:s8axafPeTD0WBNLbzm2wv53kPnlB3zT3L00dqh5xcuVAQ6YqKne22O9FkqyiIYIK3
    JhUA1TNL3mqaUTMNF4sNkuP3JwZZY9TTVVZxElm-GLZi2y8l4wCBg>
X-ME-Received: <xmr:s8axaVfSHw-6bJ_CesTGOPw0z8Out7L4knlfl4n_me-YWILxzbvman43dKo1NYzPjmsi8eOP1PoH56CCkFu2fdx0LhOFtnhmxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprhdr
    shhiugguhhgrrhhthhdrshhhrhhimhgrlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s8axaUvjW-fNlPOIlBea-44AiCOyYdFAPQDsKb_GaqgVicpw9_RlGg>
    <xmx:s8axaenljtjDpsdIfsxTFYHqaW42RF6nI20DAHM8nPBLhA1GYauQDA>
    <xmx:s8axaeyTL5yN9vQmIyWXPUP0A-M9k7DpOHHyRji58V9Y_Cz0NlQc8A>
    <xmx:s8axaYNL8Zp7zi-UehN8mwAJroB9C1Q5lkV-R9M4avaQ1OKva8dEAw>
    <xmx:s8axaT8x0E72CRSl7EVDOQ7zBlu1uZkhcGqQn0W7i2wP4xuMqMx9ORUa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:46:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  r.siddharth.shrimali@gmail.com
Subject: Re: [PATCH v5] help: cleanup the contruction of keys_uniq
In-Reply-To: <20260311192453.62213-1-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Thu, 12 Mar 2026 00:54:53 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260311192453.62213-1-amishhhaaaa@gmail.com>
Date: Wed, 11 Mar 2026 12:46:58 -0700
Message-ID: <xmqq7brino7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> @@ -162,14 +165,16 @@ test_expect_success 'git help --config-for-completion' '
> ...
> +	sed -E -e "
> +		/^[^.]+\.[^.]+$/b out
> +		/^[^.]+\.[^.]+\.[^.]+$/b out
> +		d
> +		: out
> +		s/\..*//
> +	" human | sort -u >expect &&
> +	
> +	git help --config-sections-for-completion >actual &&
> +	test_cmp expect actual
>  '

The blank has a HT, which is a trailing whitespace.  No need to
resend only to correct this, as "git am" on my end cleaned it up
already while queuing.
