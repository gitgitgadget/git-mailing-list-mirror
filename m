Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F5401A05
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342714; cv=none; b=lMCkmAbuB+PJu2gMzRCpEzpeMCP4CtA4VVIishCmKMILWYNBu3FEzggqHodRcOyow6aTQGYNrgQD52E2dnCt/FRNK+AEv+Yd8Y77PZjPRHLvvMYC/JVq31liUJeRxxV2RAJOohOY5YxuOja8r6PKzTDoDphH8hbdb9ttigI0NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342714; c=relaxed/simple;
	bh=8SHOnf6o27vy3cJ3/adfWilC5PqPj1600vxXQK94QNw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OeNNfEnYKhrpbONQUQ9br4qpZMritm1E8Ic7tgTn9xOlSfIEnWknzF8c0/Ba9/wLNWpsDr1edL1M8Oq/wuDP94hWyEY57/53dyb7B7g4XVcipiVTgh49y56kfGQ1Zr6nxtijtyWmTCgHov0dAvwYc/Lht3WNpqhSebGDanWhPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VPYW+6Wd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaQk9/kx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VPYW+6Wd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaQk9/kx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 622FF1D00049;
	Thu, 12 Mar 2026 15:11:51 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 15:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773342711;
	 x=1773429111; bh=LbC2PSz/dctfjKlh0f3xua4kzoQqNRYQt4cnpuCy+H0=; b=
	VPYW+6Wdp9YDRwzjZpZhaqWVgTU8Mk9uBacv990AgUr+R+QPe1itqyuDwb3QNits
	t4QhjSDHRvvYJc9YTtdxrdXljbT95qHjENhA1IElEI7JfkYT+snmyis/42TWIJQi
	suWRw3HsgV6NlRhsnAud8zavGI6vhvx0GI2z4Au1i1w3SDINrp/3fLi7nTlcdDzN
	8yzKJ1qLx10qI73JYhdtW+0kb64HjreONU2Db76MrjGgIzF0qtMhQyJZ6qiI/dFe
	rfdRjTP9hfNCZiML0Z8mBZjIzdpdlcSGrm/BcnjkUXPozM4mJ4KT2iYwnodcNEur
	f8pze6jwzjqg+Ha8WclW3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773342711; x=1773429111; bh=L
	bC2PSz/dctfjKlh0f3xua4kzoQqNRYQt4cnpuCy+H0=; b=HaQk9/kxTSm5Uo7Tx
	/4pWoNHLTgLwm1kLDrV6/ztWGBL4k2yiZ5U39p7raVyV407GvPPq4cN3ky8lJxgA
	XeLtfnJwxugFeCmpARHobDzElacKBGbBVX9h8t+mireAoF1vBxqpD3StF20EWSPA
	eXTXSnEVSNoqJtVOzTu6pNDmtlYlTlFvV5Io0X2rnb5b0YEta4grJn7LvUtZscSX
	Tb5g/1xaHGdolzMLN7I6u6whaQEH9VIk51l3NJmDHs6XA8jrTqUTOB44jZQGl9QB
	0DUlhguFeouztmE6o2l8AmVRAgrxTnVRhLMxLiY0FvGsZejGF1hEVdU+UBZdP0dW
	eXE0g==
X-ME-Sender: <xms:9w-zaRR0Tm_UsxOPN4equXD-Ml5nEkllvfaTaWZSWVGkecIHXbhago0>
    <xme:9w-zaVk4sBYYB2k_gGEv84fFdnqK_txf8XjQr_0JnSj9vaUG0RzSSE59bseBOCZnN
    tgd5TtSotTzfGZGE0H9YpaoLutnUlMMhzfga6NOustAs2S_lkzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9w-zaT8ILvSDx3tVvoywehFLACyIRfgM-8ofi3DwHMYnj2gUi_LmHQ>
    <xmx:9w-zadpl8LYx9CrDcAAbRZCguKYn6sx7ogl0S5hqBFWFqr_08toZTg>
    <xmx:9w-zaYm3m7r8GHoJ-CD5-IYdixKp9jLZ8Nrz1WnJUNPh4Hvl89shnA>
    <xmx:9w-zacImFvnbFgBn__TG_UCOHJDc2AlhOr-RZN2_zB185-4m8i92nA>
    <xmx:9w-zaeVTU9WOSDjicXNJbusBJScduJNrc1QdaD4zT4RMieymhadWREHI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 103201EA006B; Thu, 12 Mar 2026 15:11:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhQ9kH8f3u8V
Date: Thu, 12 Mar 2026 20:11:29 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, git@vger.kernel.org
Message-Id: <faa89e88-42b0-4d52-993a-e4bf2937d711@app.fastmail.com>
In-Reply-To: <1953989.tdWV9SEqCh@piment-oiseau>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
 <doc_interpret-tr_synopsis.48b@msgid.xyz> <1953989.tdWV9SEqCh@piment-oiseau>
Subject: Re: [PATCH 1/3] doc: interpret-trailers: convert to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for the review.

On Thu, Mar 12, 2026, at 18:34, Jean-No=C3=ABl AVILA wrote:
>>[snip]
>> @@ -359,8 +359,8 @@ See-also: fe3187489d69c4 (subject of related comm=
it)
>>  * Configure a commit template with some trailers with empty values
>>    (using sed to show and keep the trailing spaces at the end of the
>>    trailers), then configure a commit-msg hook that uses
>> -  'git interpret-trailers' to remove trailers with empty values and
>> -  to add a 'git-version' trailer:
>> +  linkgit:git-interpret-trailers[1] to remove trailers with empty va=
lues
>
> We are already in the manual page of git-interpret-trailer. It is usel=
ess to
> provide a link to the current manpage.
>

What should be written here? The existing `git interpret-trailers` or
git-interpret-trailers(1)?

>> and
>> +  to add a `git-version` trailer:
>>  +
>>  ------------
>>  $ cat temp.txt

I=E2=80=99ll incorporate all of these in the next round.
