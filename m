Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E8250F8
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342114; cv=none; b=QB/CPX5jGlvZu43jiLcMvtMTkYu4UH2RhThEaKY6xMDhoNhH/VLyYa/kncbjUdRAQ3CgNyxvgt5sWXVCELPSPLjlii7Ej5GcNGt8uEmfeExzPFG5dqcl2+eOxQirib9WfKa2o53ZU5QXpYVu5mcoLyhvLW0C9iPcW3ZdI/PrQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342114; c=relaxed/simple;
	bh=FlRGB+km52vmVpoxkvAoG3S6fTfMxMYopynhZydYX4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pa5uecbc+1QTMBQH+RpVWrfymTXcgTJPrmkOU6F7FwHCmbOe6rwedtz5DwJO+TmX2MAI320NorlyqiU2m3jfWG382fAhONpCCGWD3BZBHrp8d+HHX14i3UxfncyxSneQECKjhJ0yeMvcAZVctU7+qbAa7qL7Dk+zhmlZPMV4wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p4fUFcZq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u+BLOnsU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p4fUFcZq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+BLOnsU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 33A1513833D7;
	Tue, 18 Mar 2025 19:55:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 18 Mar 2025 19:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742342110;
	 x=1742428510; bh=OTsBAzASAwisOb9ll1qGelm7RsEFgvsDDY+k/TL4w5I=; b=
	p4fUFcZq71SCm72Ksz3udFbtQ8GNd4IUtl1ugmLaVRO6uu6bkWrkk91+mlEZ/skK
	iNcor/evUavZXleqdryglvE0Ogmice1s5pXDRSUza4xRAVkbJ+NIwpiZqPI2s8Pd
	TiPt+gOqifM7Vtf90KipWLNrSBMA6vmApLGEfrR5K4slq/ZrSgPFEw2Nvk3uJWOv
	8otqZhVLxYG3161Cc2l8r82UKTG/bJHjuWmXBy3lRDuohMMLwtsJuXioZdEC+v74
	Csahf2aTDo4oPWFiBClNbwswdulMPzm7rqPRbOxLkK31idrzdPWUIhVpLf939GFw
	6ItyK0e6H8CuEZGFvyidvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742342110; x=
	1742428510; bh=OTsBAzASAwisOb9ll1qGelm7RsEFgvsDDY+k/TL4w5I=; b=u
	+BLOnsUB0jiKcoB/n4LRsIkI0Lr9PUgPla98aQu14PCIcwvlHCRnAf/Btbb4Niar
	/z+hoKM8AH6zbeQGqrPBgpk6SOTH6TW7/hvOlKXCZ7+6SDt9EiDy+Fa851l9nuST
	IkuMcaW3oyyel5ucMQVk/iqjT5uWCYonwJPssAskrXLrwhDGzLlT9PHizTfVUYqT
	13gbmMoZ/Ntucm4A6frXNRhXZXzvcKgEsSGsju6jvbz7FSI7R23XblyQUw+5p7Fg
	BGGeiUzqEM623nXLR3cBxkZVz7NLhJgNHXC48KdWAKECBRvrHHsgrqTRGai7lXEi
	dJINRrJ209bq53rHn3GCg==
X-ME-Sender: <xms:3QfaZ3Ww7lyQyn9N9zqKD9PEZi_9f-sMXaNs-9RR1uZfvaXqSyinyQ>
    <xme:3QfaZ_lb_G0VEF7NrJSTvK-uXUWpqXpojKJLnnsOjPINV75s6OrtfkDUnXY1NyaOC
    rgmrEN0PXWg6bWWwA>
X-ME-Received: <xmr:3QfaZzY3AT5bjh4OXxU6G-mux8i6aGdRfA3JgGbb97q79QkuaKvOLuzbrveDkQ2hd0BlrRfi0BAhRAYXg6JdzpGl8ZH8e0xjpeJUTVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvhhinh
    ifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3gfaZyVyynxxtnufwn2cXvUR98U4zHlb89lWfzye8X5DwOtr5qwfRg>
    <xmx:3gfaZxmcH5FYeLv8R5uXGRbpHx1WwOMY1NVFH0M1OLGkNTuoIAteVA>
    <xmx:3gfaZ_eIpkZyReWQi4twHAC7Ur2jYry1xwj49kCXp2Ky1xP2ohu43A>
    <xmx:3gfaZ7HMR5z_JwxDrUjqPRVBb2d9tuW2kzCjxQ1Ov3Cn4OkDKW-4Uw>
    <xmx:3gfaZ3h25KT1gncq3CgtsPf_ggSO0Ma356EOzmdEyORpUwHUfh2JuzHL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 19:55:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] git-compat-util: add NOT_CONSTANT macro and use
 it in atfork_prepare()
In-Reply-To: <CAFySSZC=qxs43ahZSRUeFxFTXDq905OdZ8-4beGUoaScaj=ugg@mail.gmail.com>
	(Calvin Wan's message of "Tue, 18 Mar 2025 15:26:30 -0700")
References: <20250317235329.809302-3-gitster@pobox.com>
	<20250318220453.1937685-1-calvinwan@google.com>
	<CAFySSZC=qxs43ahZSRUeFxFTXDq905OdZ8-4beGUoaScaj=ugg@mail.gmail.com>
Date: Tue, 18 Mar 2025 16:55:08 -0700
Message-ID: <xmqqh63pzyg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Calvin Wan <calvinwan@google.com> writes:

> On Tue, Mar 18, 2025 at 3:05 PM Calvin Wan <calvinwan@google.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>> > Our hope is that the number of code paths that falsely trigger
>> > @@ -985,6 +985,7 @@ LIB_OBJS += compat/nonblock.o
>> >  LIB_OBJS += compat/obstack.o
>> >  LIB_OBJS += compat/terminal.o
>> >  LIB_OBJS += compat/zlib-uncompress2.o
>> > +LIB_OBJS += compiler-tricks/not-a-constant.o
>>
>> The name is correctly added here, but in `next,` this name is set to
>> `compiler-tricks/not-constant.o`.
>
> Apologies you can ignore this -- we needed to add a reference to the new folder
> internally so this was a red herring for our broken build.

Sorry, I may not have sent a reroll to the list for the version that
went into 'next'.  It should have lost "a" from not-constant
consistently everywhere.

Thanks for being eagle-eyed.
