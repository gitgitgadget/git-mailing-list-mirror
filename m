Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DA1A9FAB
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972963; cv=none; b=u1O45i9yxsmZkFL8+E3PfZsh6n5hlAJHx3ZeiyyaCUYVNfJNMF9PZ8YP4OO7dMaCwYWXDV6A6l2V6BkvAm9b8ipz+TnEESesksX6QL9mgMv1tZahAz0wJmzRsHBXPwpDSUcW1T1S1tgzSASJaN8aAJg9pdeFV4fIHq9WxVa6LYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972963; c=relaxed/simple;
	bh=OLWIVFfETpurkqClXdhQJaox3kuhuHELMSYl3KXO9RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGXttY6uLrPoCBh6/QRS0FEW7rIM3M2x/DZ62xlFNuC+F6K5cIPCzm9osOo3JCB4twhs2YE6ArxHH2nDVnrGqUBHz6IRwCivttef5LUnsR3TkJ6uDsPO9PlxNhku4Db6GCCz9RnUl36qqNJ8MClx2459u51OlJipNI4m7gO7ol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WRS1FEI/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WrzxazHO; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WRS1FEI/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrzxazHO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 73CED1D00133;
	Mon, 20 Oct 2025 11:09:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 20 Oct 2025 11:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760972958; x=1761059358; bh=w2wvWkBiTg
	KVdbFEygsaipe/KUH1ww81GJQ7sfUTMz0=; b=WRS1FEI/PVRMLf6gTcnj8K8joV
	fJNtOQhj6l5ZUiKqiG7lBekz0u0h+nQvGmyCrYbEEnbsDG/J1B0PC6MlWmDsLwHE
	UjTeVMss8Wtr/mNrnQI46vqw8htv2q79NFyE3Q1wyKOE3RygP3H5hJnkakYthQLu
	x7r+GpVfs0TFhx2d3JzG3w/mbK9HUN+Hn1lUpY4P/0omko3bUFzMq+OC5VHnyU2k
	nIFlslb1fy/d7NN0jtl8POlBDauQ5sc3aHnx5Tn6jS4dt5z1+rORWanugzjvlDpK
	t6nxWpm2eUcEnBV1uMiwmZlBpIMUBGCKvKIHeLMCg9ZPFnE01MBVpAkI7MQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760972958; x=1761059358; bh=w2wvWkBiTgKVdbFEygsaipe/KUH1ww81GJQ
	7sfUTMz0=; b=WrzxazHOe+GlFkEB2oceO8gxk0y28dF1OS1U/fcc2LXGIZkPoDb
	nS2kuQ2FHQ75YmZ/gr3fjphGnoTqDYF4v2zHOcrFsnXaLrBA5OSz9DYIQZt9WjG6
	zq+etopoPWCDXxsJhoEAnpJ5FuVXYTlVI5qqqqh3KlLwMC0T9t8EXgXfEWq4PAv+
	9Xv1HLOFjYSFugF8Q2E2k3eRRM11COWPnqABAv9oageEcAHSnDUhjAyfrg3vVjlU
	s9L36fGtJOys7eFO2DM1VtxVtT7xANkbUtYj8j/yjv1ArT7nwV6cy0BwmgHE0Dnp
	utcdXOLTPRKTiA8kBQn9OIOR9ODVNFlVRgg==
X-ME-Sender: <xms:nlD2aDW1LC7D2TG-3qeIgdhW9KBp-mmvecUa_YnS8hlHVuamm-5TGw>
    <xme:nlD2aCes3_GKoOpHw0lKTZzxYXOXTkg9chb2HnZjS7mw-jSQqNj0Xmtz_iJ-qq2v4
    notNF0bRk-E6DyPtmiJqA80ib3Wtj8Z2sBt6NT-d9FKjJoL8ct2>
X-ME-Received: <xmr:nlD2aHvp7Rmqn25R8Anf0lUvU7Uaegxa1lIB24GF6DJcn-bXjLwx3lugRluMKttrhIFvKtKEdmxzOFuq4k9Wdwlvjz5DF3xSoJL7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nlD2aJ8VFjelWqNsbmq_SgoGrRjmwkdhI3VxRaPOoUZUUfbQ5zKaOA>
    <xmx:nlD2aK3LfVG07HlB9EG_nuh9ZmkYbL5ysyqFbtUPSUxD_jrtd17FHg>
    <xmx:nlD2aGCABYUKnChIax8Vx07kmbv9VVxaEtVfNVrL1wAU7GDgyhhjJQ>
    <xmx:nlD2aOcwZ4NCJqnLG2BgumeKHD8v2vliLVQeCm6rPdxpbzcEpJQdRw>
    <xmx:nlD2aJMUjeugETN30vON1oI2kXLLP4UAkCtlnduUvO6hK6PrHIE2GP16>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 11:09:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
In-Reply-To: <CAD=f0L8Zc=rRwCo0QHWnf8OCXidubJrQYpeQg=gLXV=npO-T1g@mail.gmail.com>
	(Bello Olamide's message of "Mon, 20 Oct 2025 07:32:18 +0100")
References: <cover.1760869186.git.belkid98@gmail.com>
	<7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
	<xmqqqzuy3n3k.fsf@gitster.g>
	<CAD=f0L8Zc=rRwCo0QHWnf8OCXidubJrQYpeQg=gLXV=npO-T1g@mail.gmail.com>
Date: Mon, 20 Oct 2025 08:09:16 -0700
Message-ID: <xmqq5xc9390j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bello Olamide <belkid98@gmail.com> writes:

>> > -     fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
>> > -     strbuf_list_free(fingerprint);
>> > +     fingerprint_ret = xstrdup(split.items[1].string);
>> > +     string_list_clear(&split, 0);
>>
>> OK.  This is a straight-forward rewrite that is fairly faithful to
>> the original.
>>
>> But I wonder why the original was written in such a convoluted way
>> to just extract the first part of a string that is space delimited
>> tokens.  It is obviously not your fault that the original is written
>> that way, bit I would have expected it to be done more like this:
>>
>>     char *begin = fingerprint_stdout.buf;
>>     char *delim = strchr(begin, ' ');
>>     if (!delim)
>>         die_errno("Barf!");
>>     fingerprint_ret = xmemdupz(begin, end - begin);
>>
>> Am I missing something?

What I was missing was that we use fingerprint[1], not
fingerprint[0].  So we need to do the strchr() twice, i.e.

     char *begin = fingerprint_stdout.buf;
     char *delim = strchr(begin, ' ');
     if (!delim)
         die_errno("Barf!");
     begin = delim + 1
     delim = strchr(begin, ' ');
     if (!delim)
         die_errno("Barf!");
     fingerprint_ret = xmemdupz(begin, end - begin);

> Okay something like this which just finds the desired token and
> returns a copy?

>     char *begin = fingerprint_stdout.buf;
>     char *end = begin + fingerprint_stdout.len;
>     char *space, *start, *endtok;
>
>    space = memchr(begin, ' ', end-begin);
>     if (!space)
>         die_errno(_("failed to get the ssh fingerprint for key '%s'"),
>             signing_key);
>     start = space + 1;
>      while (start < end && (*start = ' ' || *start == '\t'))
>             start++;

The original does not seem to care and uses the whole
fingerprint[1].buf; do we really care about tabs?  The same for
looking at CR or LF.

Even if we cared, we shouldn't have to open code strcspn() like this
;-)

