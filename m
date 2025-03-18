Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C22135D1
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318251; cv=none; b=bC2C9GtrmkkC+/+5gyq4DOeCZ/ZxReINDkwgK5WUNF2oT55HvWvj6KqjJ3c0SeIpUp1Yv0uOiKA02qEcKgPPK1Fha8dRxmSiEb8R5unCt5ERZDEYW0DSg50cViTfYUzvUhQaJ8DAy/91BpknzOIJGuP4kqXSPDwkfyN34T9aJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318251; c=relaxed/simple;
	bh=YYEPy74QvCrHyCmp5jqMKkEAjSgo08rXNlUAWr7nRQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bz/Cdf1w8KjerZcx9Ed1j5CvV/2BfPrh3KhTbGdLr+h/SGXWowwFQS8Q8FbZK30dlXzrTNhhePuWYE3xr5rPPQz/5YkKeT635Aie+fk7EZ6qFyaPqTONIWAD9noN/dj3P6lzg4V963TV9aIit2yQaov3HgfyguUnEVc6zYeTCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ymi1jMVl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xgH014aZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ymi1jMVl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xgH014aZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 46FAA25400C8;
	Tue, 18 Mar 2025 13:17:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 18 Mar 2025 13:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742318248; x=1742404648; bh=/PHCjiCbE+
	zmZjFycusEaMk71MtOWJsiFRLyxrIEwuo=; b=Ymi1jMVlFi6teT3BrSvzFXd5Mq
	Ueo/lMAQkoEzXuw6xGE0IGsIVFimJghZmTP/Ul2P+YvVDipJP2DQ8CAC530wLtVq
	ut24S64ln6u9BGjM0UVdJOcCAoZvH/itL0dVc7Z1rxaEmi1ALrRr4VIScQK8jk6A
	dJG7e6F43pi2gPZ/R7M3eS7p7+G54LlaCWEMh5Led3jj/FEfUHbm3B0wXFoPkTpj
	DcKprufk6H0VheLoIkzY2/UKu6aXEHvLvn0AzPaJ3bUBq1wYH31ykYugpX4/eQ0y
	0/Ryyem1GS0zHbE+oGJIGPv0rt4bCBuBlHOFoUmPQkKFcE5kp6pJ7RM0Bfcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742318248; x=1742404648; bh=/PHCjiCbE+zmZjFycusEaMk71MtOWJsiFRL
	yxrIEwuo=; b=xgH014aZqOVee1yEcuccGaNyAearwnqan5UN/WcNCfzd8ivPeUg
	9uAswYYUFuF/yTaJ6CK73tdTnhK7IIkMub6vhjKlWlHNbdLGKoqK9VT88gwGxi3Q
	nhjOrefVXZZqOjUDJ0fTCMph7U3wQRbLoWZyyF3jFYPYVtduGqZBlUp4TxcyvAqU
	9RFm5dLJh3Gnyd0nPuJobV+41ViTi/9KvoUAwB4D39UGSSyau2ffifRxeE6w3r/H
	i1cbSsENUNB1gH16BwJmziXdEkxzSBEYJ3hbaVaq+haycEpCnUJqxrXQm9HIHUNF
	LJLOhAu4yhhREP7JYiqvd1bCiO0foDXmjsg==
X-ME-Sender: <xms:p6rZZ4mvJLQ0oXkl-NtJjK87iIhdKNPUOJtBEs8dXdC1oA7BhDYbSw>
    <xme:p6rZZ33vlZE4i3vT2K8bwHGTDsYtv05cC7b8O25OlhwuWhmQFItMHlnPesn-ccVa3
    4VqC1GWyVQBtyLCPg>
X-ME-Received: <xmr:p6rZZ2qendatvAjpN9SfDqHxyorrjNPIYID1rGlNiaLEXzkmkYipeaNHoxXJaaTFq1WWlf5ALOoOZl6cLDC-qChVHptZ1J5OEVYTtIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeftdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qKrZZ0kbCzglLacInR9MgRC_Dpqs_dnb_ggrISYBF4AckXGd3pfhtA>
    <xmx:qKrZZ234zYjRxSEVEq64u99G32o_ZyOaYTvIV65k-bCoyWNf8VyyeQ>
    <xmx:qKrZZ7tQR1gguW6yfyqIYhK1xD4bEhjdJxZulbDiVFH_CxG-9V9DAg>
    <xmx:qKrZZyXz5rHF7e3OacSag1nyWpuG3uwvepu1wbVuERD6T8loEe-Exg>
    <xmx:qKrZZ7zyBGL0OcISQEbSD8IuTO1sBB-6_9X4QTf11WSWBuvYs0ZLlyFk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 13:17:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #03; Wed, 12)
In-Reply-To: <CAOLa=ZRpDHkqWc=-pnERM-4E3OTzQk7XBy+J07Ek4TKdyATTJw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 18 Mar 2025 03:13:19 -0700")
References: <xmqqh63xx23f.fsf@gitster.g>
	<CAOLa=ZRpDHkqWc=-pnERM-4E3OTzQk7XBy+J07Ek4TKdyATTJw@mail.gmail.com>
Date: Tue, 18 Mar 2025 10:17:26 -0700
Message-ID: <xmqq5xk645sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
>> * kn/reflog-drop (2025-03-10) 1 commit
>>  - reflog: implement subcommand to drop reflogs
>>
>>  "git reflog" learns "drop" subcommand, that discards the entire
>>  reflog data for a ref.
>>
>>  Will merge to 'next'?
>>  source: <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>
>>
>
> I did a re-roll here, with some fixes based on Patrick's review. I will
> try and get another review before we move this forward. Thanks!

I have the v3 queued; haven't caught up with the reviews with
today's timestamp yet, though.

Thanks.
