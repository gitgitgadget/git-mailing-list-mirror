Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555B1D8E02
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314630; cv=none; b=Zu3YxRUr8AtT6SAaMs/oXLm/IkTBNYsaqtsTdi31C5I+gc4q69lKhhMTTykTds5ip+amFlYzUhU4Rgvfa44rlV5/jskkMc4Dui+JpWTVq1JFHcU8oRwjIMOR45ye24Q2vf2WayIq7801qaatkzKuQyDkLPawowTb6/AfnZYrmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314630; c=relaxed/simple;
	bh=YMyW/IlMpF7FYTNNdyYwy1GBM+PmJt0AT8jTEtjNYSU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oG5IWpTYjewxVI0fE0K+AVmF1pvek8aSd1527m5gOeggqRuHIHB2xpLNOk3CrU6PESplfF7KmMWd7nm3uYjfNBExmEcCbCsnO0UBA/DI0RIaE7UH1Hxpls6v8qnzFxQ3gQ251jLAXUd8PksS4fmsEbHYvLSVeYTpuduJo9I7oqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bhie9EjB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auI3YKpo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bhie9EjB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auI3YKpo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0B1A11401E9;
	Mon,  7 Oct 2024 11:23:47 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 11:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728314627;
	 x=1728401027; bh=DrBzoAyVPrMSZixXQDn/Xq/EbNJm6RWBWkpl2PqvBGQ=; b=
	Bhie9EjBys4ichtcGeJE+TGaIzWqdJp9Zou6n1EvNDVxT+SZDjH71OpexDzq6Fg1
	VnVdKubiFSuTWqi7UiYQr6ltvLutsWp17fEbBxGNPSL1RfQPSYU6/m58UG/omLbH
	lC+Yl7M2ejRejdBMpxjLJSaax8Rv7PJnaVu2/5Z7B6TV5mkUZtSbNx+BRTTne6dY
	VdUoTnb5nHOih2Afpf+d1AzHWT1fWgoYcCDLkr+oPeHMajLPGXFgJE4biqRfo4MY
	1sG8d5K2JfsbYH5kaDcbo8Le48QNPXwGHkPHrNPYOcWZjrLzAoFRCowq/+1cJss4
	UgVCk51dOCRSXeXghMkktQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728314627; x=
	1728401027; bh=DrBzoAyVPrMSZixXQDn/Xq/EbNJm6RWBWkpl2PqvBGQ=; b=a
	uI3YKpo5brPNvhR9hWuZ+DVjzxss86ht8mRicwBGwaNwwrcxVS3SCpc1/46S5es2
	/Cd9RdrtpLQiffUCJhvKnUJCNzZ7WRevd3hX/9F6RRKjBz31BcLJ0QsEVC0bn2ll
	0YPXtznvRBqaWFEUwRMQau98O0PPYxMr62vLNOJ+G08mwAKGJgQswR26vNxEEkwu
	JIAT+DLiy3xh3lMNeMwaTUdOK/baOGCMd6NWExmZ6fZpB5cf11rtKonDGF9OVq8f
	I4CQU4odBxBeV9jM71vRb6uvDwX1ZoweuoJNI8/ftngrj2j41csYW+lvQjU0iH0n
	ImbJ+zov92+LwyQ1YF63g==
X-ME-Sender: <xms:A_0DZ-EFeBzr7-llyUanKYTVsUoKmp1uxz6vxO70pfSYkShNazC9xns>
    <xme:A_0DZ_XCxMWX5sWg3X25ldkZfFQ68RPB7Atj8RRNj4XTYa0zvAiq9SATSsAMXQhmC
    HuanMaXXTnX6O80dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:A_0DZ4J4KyPSSk9ukKyiXetHDlZtD8wXuenImnxSoPRvIOgaRJnfZw>
    <xmx:A_0DZ4GHgiA9ZRTO1DKM6xWos8-qUHJ2x5xjjqBX-aogq3Gse-6dow>
    <xmx:A_0DZ0VcgSKieMLUlxWVbjqVqnmasws4lHTvSO7DvdgTSRRiTcVVqg>
    <xmx:A_0DZ7PjfFAqemrbv_P4EDD7XipT2JF9gRY30TwZsTUlEbqkBONDWQ>
    <xmx:A_0DZ7TsDO0lKSF6xYatxPx36yPSElpDbhK6-kEmCFAWI_dmSgFBEN2B>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7EEF6780068; Mon,  7 Oct 2024 11:23:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 17:23:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Elijah Newren" <newren@gmail.com>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Message-Id: <2fe12309-7b5b-487b-bcf4-0639a1dc610d@app.fastmail.com>
In-Reply-To: 
 <CABPp-BHoYSmxCDDXhC8MGxGV+wzaNc96Fbv60JAbhgX9O_x7oQ@mail.gmail.com>
References: <cover.1728298931.git.code@khaugsbakk.name>
 <fef203471f4492af1468a0c91088324c394effd5.1728298931.git.code@khaugsbakk.name>
 <CABPp-BHoYSmxCDDXhC8MGxGV+wzaNc96Fbv60JAbhgX9O_x7oQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: merge-tree: provide a commit message
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024, at 17:17, Elijah Newren wrote:
>>         NEWTREE=3D$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
>>         test $? -eq 0 || die "There were conflicts..."
>> -       NEWCOMMIT=3D$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH=
2)
>> +       NEWCOMMIT=3D$(git commit-tree $NEWTREE -mMerge -p $BRANCH1 -p=
 $BRANCH2)
>
> ...perhaps this can be -F ${FILE_WITH_COMMIT_MESSAGE} ?  I personally
> have a problem with writing example code that models horrible commit
> messages; I'd rather give them an example that hangs waiting on stdin
> than do that.

Yes.  I=E2=80=99ll do that in the reroll.

Both this part and the uppercase variables.

Cheers

--=20
Kristoffer Haugsbakk
