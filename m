Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED213B58D
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708579; cv=none; b=i3h8KLXABzQeODMK2AL7OanHMUC4/btQBIwkXeMbmMk4MJ6c3SyCCV2GJ5MjcD/yy1RcexhUaNosmmxJB8bZziJjBWfb8f3cwYGd7KTqRK56mxK/4v3kpopv3w3XJZnX2npOedRzjQ8m1Nq5QuZPOCQQoStojDdX67uXOnvjlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708579; c=relaxed/simple;
	bh=/e0t7k5JUNJloVcaF1J0CIEfXQKeprymhH+wxIpIiq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbstawIcrcr4vv5SbdCurCt2HGQgqDdmySqmTVkChVBBeGg8QyKT5FHNqtr+P7lJmVm+5bjYz5hX5FLvF2yiCzOG05J9qMyMZtfP8f0RmWf3vSVRjHXOdAJWFogC35+b1s3vqOulMoxeHwTBHDOiXcJ+SZVILMEXD0Zl8sYM8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C4zIPQI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iBLQ3VhH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C4zIPQI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iBLQ3VhH"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36C557A01A7;
	Wed, 20 Aug 2025 12:49:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 20 Aug 2025 12:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755708574;
	 x=1755794974; bh=R0gTkyZ0ClaqVsbUc9Bcs7MZjT/PoTSR5flvcZz4lHU=; b=
	C4zIPQI9Bco/3lLoj5+NQ3DU8AF0f52rmCNlgrmAAO0uo2jcn8RmT8caHoeRdOeB
	g2QWp8QAi+SL4G9x7hKjXbBkiDBsBAMzqdY+hsSixVdnHAc/kiA2z4z6+IhHpog1
	Vf3FY8B4HHS/zd2OICPaVFJ6f9s/wNkrvZ+sJoNxwcZkUXF4p/U1I0U39B3cxHVw
	azwAAbedSM7n3CG3vWumTbgNRt0KUr/I4Fkqb9bDjsy2SyWaWuiZI6ot9EVxWp9k
	4CMenWjfkspDWBoVHJC5pZBLrZOncqhWbsGoohBOnV+VKiuX3MJ/jk4wLH0D9CoY
	mVu9/fyH0vt+jrKjK+Nj0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755708574; x=
	1755794974; bh=R0gTkyZ0ClaqVsbUc9Bcs7MZjT/PoTSR5flvcZz4lHU=; b=i
	BLQ3VhHSGfxmMEBi0VFOGrfroM7yfO+6DV5J50BwrKRynFbI65TbY2rZTiktzdCT
	U9XMSHQyJ83Yspl1jBt8JE8svuD0iCuQUIZzVbSKNYyPpsG7BPzzt4nuAFeyQxPr
	wEWOh52pXkuvR975G6RavBC7qRHk4PW1K/9fmYhmJfRLfy0IT7Jlub1B+W9eusfu
	Qre+GJJkC6Lff5OkOLcu6BXoY+JDM8CPcKERuZZ+U8Z2CRXcYIAPqPk4IHsXAp7M
	O/CavmIbntiHCg67PrdMTyFXextyy25sWAP6rq9MuregKbdNmfX6sbDkAx5mESDf
	2cG7kkqJ+FTfHWOshjZsA==
X-ME-Sender: <xms:nfylaD4v2RKrIYQ7xsgYZHcAUN1LTjkp5j_1QweZKvI7UOSO6tlAfw>
    <xme:nfylaEZkJRvkg1qMcyCZxwGDm-mCiLEeQgYj-GPfiwodwYgnZ2fqB4eDmT2eJLd1M
    JOdMSBEAqF5vg2WkQ>
X-ME-Received: <xmr:nfylaA7AK9EXk0sx71Ah_T3Tw4HNkxD8Azaa62_vc1Xefezcy4S56DctSTubBb2flIG6H3Q5hjkEFBZQGCDrhh8eQZyK08Y7kJ0UMzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhi
    ughgvgdrtghomhdprhgtphhtthhopegthhhrihhsrdhjuhgukhhinhhsqdhfihhshhgvrh
    esughonhhorhhstghhohhoshgvrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nfylaPAWK8SO-ixIr3sPmC7_52yOUi-lReDsPg9Zpda42A0OOnT_yg>
    <xmx:nfylaOe9MIaFYm0xr9cDzKZrvSmGOKASxWiYlpWioPfIzeMWfmxyvA>
    <xmx:nfylaGKti6bgZ7Mn0STkK6mRWdvy4d8f76jsheilnoq1MfjSj0yagQ>
    <xmx:nfylaB0gCDEhhz40h_q9XJREYrSYMlPDPm4rP1j__7PSwcv7Z1iedg>
    <xmx:nvylaFupu7OLAbGHargcEHqrmy0EgkguAGF2qOaDPCYuIB_LWwmJI9v0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 12:49:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: rsbecker <rsbecker@nexbridge.com>,  "'Chris Judkins-Fisher'"
 <chris.judkins-fisher@donorschoose.org>,  git@vger.kernel.org
Subject: Re: git whatchanged
In-Reply-To: <37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 20 Aug 2025 09:52:35 +0200")
References: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
	<011801dc114b$f38bb130$daa31390$@nexbridge.com>
	<37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
Date: Wed, 20 Aug 2025 09:49:31 -0700
Message-ID: <xmqqfrdmaqg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Aug 19, 2025, at 22:57, rsbecker@nexbridge.com wrote:
>> On August 19, 2025 1:51 PM, Chris Judkins-Fisher wrote:
>>>I still use git whatchanged
>>
>> I did too. However, now that git log --since has basically the same
>> functionality,
>> Perhaps setting up a git alias might do the trick for you:
>>
>> git config --global alias.whatchanged 'log'
>>
>> so
>>
>> git whatchanged --since="2 week"
>>
>> or something like that should continue to work after the command is
>> removed.
>
> You can’t alias core commands.  So this will fail in the reported way
> before Git 3.0.  Then from that point out it will work as an alias.

Not quite.

  $ git -c alias.whatchanged='!echo bar' \
	whatchanged --i-still-use-this -2 --oneline
  7c10e48e81 describe: pass commit to describe_commit()
  :100644 100644 72b2e1162c 04df89d56b M	builtin/describe.c
  8cfd4ac215 describe: handle blob traversal with no commits
  :100644 100644 f7bea3c8c5 72b2e1162c M	builtin/describe.c
  :100755 100755 feec57bcbc 2c70cc561a M	t/t6120-describe.sh

Your alias with the same name as a real command is silently ignored,
and when the real command disappears, it will start working.

Having said that, as "log --raw" is even shorter to type than
"whatchanged", these people are really better off without such an
alias.
