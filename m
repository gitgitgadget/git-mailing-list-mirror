Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFE347B4
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534481; cv=none; b=bvOqdpEPAJsmzaCUXiSEXUjyLAgeomjeOwJs0ZJUAhEVuESzmjvOvOGHYyvDYQzHT0k35T5py1/jYZXBYap3vahdNRkKh6tWxUCtj2E+FRiAOB9QlIKfjUGcdTdUEDUDKagC+HAlQFGibQ11xSpWHXP9ChsGcvSfmVM1M5OVLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534481; c=relaxed/simple;
	bh=O9sPilZiLts1/4fishG5Q1slT+oVVlEZWe+Qr1+qepU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMaWB67ca+4fvlM1O/1P/ejGOppPA+uMdIxw/fpxAFJIVFvLQO57LYtBezkukv+Jdo+XQDi5aM/jRnzlpOVN3VNSRp+QqeeRDO/a0fi+cTAXH+x714Hi/b2tNu4HgsonW4MSSSJZU2YXbuXmsFT8iEDfq5kNCNz7ZmPLXrcjXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0FkekWnQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qjmWxAQM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0FkekWnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qjmWxAQM"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70EDB1140103;
	Thu, 29 May 2025 12:01:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 May 2025 12:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748534478; x=1748620878; bh=S1uYBHy2vj
	iGnbVajzhfmLg+q+TTtESamVp1jp2RT0g=; b=0FkekWnQ5ulPvAAvGXTrPV6c8i
	ItsTeJDT4rWQA14taHssxzr9EXgNrFpUcKeob0FhH9So38Z8832en1xtcO6ekiCZ
	2/JJntwDw0BVTs8UMEmvfHoJjpSTWKKOgYQObQ6Qr3sbhoeDLYmqqGhAqgtcwxfN
	BdttC4su8YUAepQb0JfoOTsdo8DoB/+ckNXebE+fSb2KIHOkqNVjV2v4KuClgiUr
	kaylwzEtZxDJetPT2ZLuI4QTYJIKSaJ6VcqtAhp6WMDhVVsQWVcUO+x3Em2lJwVV
	mEcO7PKWnBwivuU5q8K/7x34lHkM/pNgX/FKo85snT7MSEn8w3zQoKryL3fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748534478; x=1748620878; bh=S1uYBHy2vjiGnbVajzhfmLg+q+TTtESamVp
	1jp2RT0g=; b=qjmWxAQMIIz0iqf1+WOM2aMiIdWk+kaAYYpNCNF6CNHm82TgNrO
	wdwqWVncucAXxKAWd2YumnUCS0QevKWwmRLkiXJcOSCQDa364wsgzl/Bq+qUS3gu
	5JD7CMoBosO7+fl1oDLV2w7jnUPMbXrSvOb86umCbbGD2DTopPdnj+adBR8uWE7I
	v6r8SyOzULblFVAJ+4aygqvK4MQcvhnmrTmpUZBuag6r60ohc2fFU2ZwkPaLqsu1
	bXW0oFNe910i4qDlWyzBbvUvy1lYjgtOQx95eUaEdPHPtkTLntLNGS0s/D6JYE5Z
	Q0sKQW3taoTiT10wacjFmImlkn35b2bPzIw==
X-ME-Sender: <xms:zYQ4aIol80Z1GlSCx-1Vu9bcx51to6hLLrswW0U7wweBMvVgu1z_4A>
    <xme:zYQ4aOoTbziUYatiSbCns67cl5QbUgP203cQL6jONrbGmZ9oZGglJygTrxU8ZsVzW
    fimLubZM0GK-Ru1HQ>
X-ME-Received: <xmr:zYQ4aNMOSBJxS_WmJdxhoj0mA7cYQKkPopaX-WE6MraHmU4CkO9nnsR-zdKiTgSBTPZhC0EKHx6YBaORVWN5-wELdfeF0XSkmEFsKn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjuhhlihgrnhesshifrghgvg
    hmrghkvghrshdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:zYQ4aP5NZ2_1z6j0ztJUi2NZ1-JXo59DuPZWs6wjEqEotxlyGQYmBA>
    <xmx:zYQ4aH4teqXnuE9Rhmw1rfS2j4qLke9XuKvU6lxD2xMswm_ZFLMesQ>
    <xmx:zYQ4aPgu8-6OH0L4d5iDtspWzPHH7kXhGMqFLp5_WgmQge64yXZSgw>
    <xmx:zYQ4aB5h-wiMwCf2q1QAeKpfoSQAYSgUIlqHA8PqjdNYrAw5kLND5A>
    <xmx:zoQ4aIxc91gRIr1lcEf51LGQUEBHa5G2FAuSv-4T_Sma2Kp5hJDOIYKu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 12:01:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Jeff King <peff@peff.net>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Zi Yao <ziyao@disroot.org>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 2/2] send-email: show the new message id assigned by
 outlook in the logs
In-Reply-To: <caf46596a709df7205495b75da569baef2c7c9a2.1748529954.git.gargaditya08@live.com>
	(Aditya Garg's message of "Thu, 29 May 2025 14:57:04 +0000")
References: <cover.1748529954.git.gargaditya08@live.com>
	<caf46596a709df7205495b75da569baef2c7c9a2.1748529954.git.gargaditya08@live.com>
Date: Thu, 29 May 2025 09:01:15 -0700
Message-ID: <xmqq5xhjmmno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> This patch fixes this by modifying the $header variable, which is
> responsible for showing the logs at the end. Also, the log which states
> that the Message-ID has been changed will now be shown only when
> smtp-debug is enabled, since the main log having all of the headers is
> anyways displaying the new Message-ID. It should look like this after
> this patch:

We do not say "This patch does X" or "I do Y" when describing a
change.  Rather, you give an order to somebody who is modifying the
codebase to "make it so".  Something like ...

    Fix this by updating the $header variable, which has the message
    ID we internally assigned on the "Message-ID:" header, with the
    message ID the Outlook server assigned.

The change itself looks good, but ...

> +				# Replace the original Message-ID in $header with the new one
> +				$header =~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;

... is the comment adding any useful information over what the code
already says?

Will queue, with a typofix to "incrmented" in [1/2].

Thanks.
