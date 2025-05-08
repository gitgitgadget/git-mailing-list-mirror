Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF622C321
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710929; cv=none; b=nMmwP5ree2Ic9iZ/+cekF+WvmoAh3uUagNzm1Fzbhu8cPV+XPExE29BxdqW2bZrwTF1rSjrBdfv/V2ZmprPnL2JqdYylRQwuyE0rCv9qjayWDV5jT5tPKqQVX3Hz7jVQtdv7q6UhVtBjpU9NB/F+wZ6Pyqpf8VuKqnlzbthU7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710929; c=relaxed/simple;
	bh=22RX6v2ylassa4gZMRSIeihvAtMkyXAhmz7y2mnmU6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LUAo8GWx6O/ZzeH49wSZOh1in3hpUvmZvCQ0MTuOtgVwcP48c3tc1P4kFXryu4zeGk29Rm1kZNAf/0FqqZV+gVm0sPDpqkL+zm6/Xh4xkxOPLIlKRDutS/cs/+LBNjoE97PDr649iyPreVC0IKLK9lDUCeYQCm+jmiks2TWMY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DJHWaVr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMg0HK9d; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DJHWaVr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMg0HK9d"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E46F25401D2;
	Thu,  8 May 2025 09:28:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 09:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746710925; x=1746797325; bh=9I4PewhWdp
	qs+Zh7iowx9Mi+2sWhTaGpIvX96dQ/KFM=; b=DJHWaVr+Zh1ze1MEcT/EK/f/J3
	tZfUrJImmkIgSxebdvFadw9eC9sY7Y4xrC2isP8K4J0ryk8niwjDxwYDs2O41IQN
	TG2yFTUbQg4DKwWw/MuvqsvmukYQ53G2PLo7Cg39DG8B8ZzK8zp7DlRW/2Ky/vho
	HJzz57ggrMpEVYiouy8HkQXUebIazP8SrXEZaWriD4cDdcljB5deY4lSOFhmgxay
	HKkJrK8oo+XPTUg3V5Iglajy3oo4F0o/qYLDSZHZS3P81TC9Sl5hyEijFRD4mipQ
	gIh5iWNg3IT4M394wF6MN/NZv2Ja9gAUiDsn27uCtZiUugwSDUJQ7cIizW8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746710925; x=1746797325; bh=9I4PewhWdpqs+Zh7iowx9Mi+2sWhTaGpIvX
	96dQ/KFM=; b=hMg0HK9dfNxKcvDrMeCDBHYyoNyjKqgN4fzhnHm2I3YJWb00t+z
	ZGAbgh9XjUrXxnqied6YjMnKKHEBs+rIYQrdiMF7Q5t/SKQ4FmJ5hZGcaXB9ldt/
	A8dnebPelwGZ8cCGsETEarJWE+XXdzp3WzTtzxCozB1fCf7v8G2t5hetDnW1refI
	SwxNNlujihVlqWkk07eWCdIInAvSR53ywKQ07QCKjOlGS7RkzDF0fsqdCOtTuOsK
	l6Ak1oQ6D10t6UnDrC6EreQjH90R1F161L/RxWv58Xdhc67ka/YIDoRHmPa0EiTb
	CYzQ12k14Eml3UtdtoDm+to7AAjWvcoMNag==
X-ME-Sender: <xms:jLEcaAMeup76OwaDgxpdV8lv5tYGJwFVrIQ7uVAsTIxc4YiNbriRrQ>
    <xme:jLEcaG-V71iXTDOwuCDTSCrUWIn6um--bCGA8C0ePX-r7US7FY483bhnElFHwutii
    VX5jwaF9w9AE4GXpg>
X-ME-Received: <xmr:jLEcaHSy-BncJvzBOsI-_FdwjkvecbvdOnPsKbk6jtY57uoHPI8dEusGAQ91EJIi8Uf_lFJRvFk2-nQffqMRtrvxdt80oI9a-k5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeelkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    ettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeeludenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeguhhgrrheiudehleehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jLEcaIufC98IL8swOUi3o0CBmA4EEJY9xJVNWkYFrbPeF80LF43JUA>
    <xmx:jLEcaIeUsUP8V-nJGKhRXC03XJhi7pVixeEME_GfHLQBGg7L6tsHKw>
    <xmx:jLEcaM0jaN2QAKclUO3n_MKMp4yhrsGla9NnJDO-l0_gmHpYW9Ny-Q>
    <xmx:jLEcaM_9Gg8FpgZziOY0p5PBi1ld78xhv6eKExvTAY8IFS9MtZX_ZQ>
    <xmx:jbEcaCzQ8pEuzaCFsxwDEKLydh5jrBwRyvKF4ES01gysuDv2IOPiXzzv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 09:28:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,  Moumita <dhar61595@gmail.com>
Subject: Re: What's cooking in git.git (May 2025, #03; Wed, 7)
In-Reply-To: <d80dd1db-de81-4e5e-9d82-70794783780c@kdbg.org> (Johannes Sixt's
	message of "Thu, 8 May 2025 08:27:30 +0200")
References: <xmqq5xibao5s.fsf@gitster.g>
	<d80dd1db-de81-4e5e-9d82-70794783780c@kdbg.org>
Date: Thu, 08 May 2025 06:28:43 -0700
Message-ID: <xmqq1psz9qpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 08.05.25 um 03:26 schrieb Junio C Hamano:
>> * md/userdiff-bash-shell-function (2025-04-01) 1 commit
>>  - userdiff: extend Bash pattern to cover more shell function forms
>> 
>>  The userdiff pattern for shell scripts has been updated to cope
>>  with more bash-isms.
>> 
>>  Comments?
>>  source: <20250330134018.9662-2-dhar61595@gmail.com>
>
> This round has room for improvement. I posted a review yesterday:
> https://lore.kernel.org/git/9d548d94-eed8-434a-a9ef-67df694c5c79@kdbg.org/

Yeah, I indeed saw your thoughtful review.  Thanks for pointing this out.

