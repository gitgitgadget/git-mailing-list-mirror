Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929A41DFFC
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834010; cv=none; b=Q4MpW0cwyas3RC8DjjoBDqYgByXpK3uWfyhch4n4rTd5q3PAsFL4vAO9R+fBdBGR8uvCd7EUHFLtk7c9lGAI9XfImm1w+6ogDkBOgZ422vZiCsmsbyMql2PvJlVWuMyO/snMkq05a6xpjphsPeKrbTPNCfNOLEFeFKn6S+KP508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834010; c=relaxed/simple;
	bh=FddRj28kb7N9shysTZXbIYpimzSmapUJsYUCfJKsiVA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ly5tsWYNz49gcAAhF51AJ0DHTmMdiimOM2lfrwupkGM8GyRBSlr4BKwCBAJEedazsX/WWmF93wVgxEby9mdR+2k1FkoF/v9ilk5Xq6SOKWkmhccZglzqk6p+QnlxyGZbVNOIKjG4IYeZVJN+bSs/pyQGoIRb+NU/9GVdLjrpqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ce4mBpcP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQiO2hm2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ce4mBpcP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQiO2hm2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B3AF813801C5;
	Sun, 13 Oct 2024 11:40:05 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 13 Oct 2024 11:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728834005;
	 x=1728920405; bh=2RmjZg/HgZsDNJsXnlxnrwQ1a/yPqR+0WBN8JsG5pgk=; b=
	ce4mBpcPaYaPQSLCsfCHBi6ByGp3h/xdiPfpM/2NjH2CHgNbDWT/zJX5iPg/LBPV
	0PUgZR/saTIWjPqdLAHW5isfjzu92h9HfGiMVsMc6KKsOq6kSgeWhqFVYjMv23rU
	QaaEHmLjEKYgSfHzBf+XgsHDjeyv9sZTqDJwwD5h5Lk1+3KcXufkk9ID163nqsw4
	/X28CGfZcd7eRjQO0VOAr7QH60ApCc27n/g9toAPc8TaijaCfw4ReWLXysAkBfMZ
	8F97SWJkxxYT437JB5QYe6zv6Le8sVy0VW+yWOh28d+uCOh0MV/j13rdEU72CiCN
	lZ3I2uEs8jCnlCIVo1Swww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728834005; x=
	1728920405; bh=2RmjZg/HgZsDNJsXnlxnrwQ1a/yPqR+0WBN8JsG5pgk=; b=I
	QiO2hm2E9bJtvMxUFHAqKrljWcYUPonu7OrFyREsR6Og+YqexZ01vdn0/uS2nGrw
	o+K45LWH1KlTO0MJ3DQTKOAZQfoq9/+PzuZ2ekN89++ldnUflDu4hD4+IIe2aYvB
	Z3vHCgOgEt7Ua8TyRvXGgLTegYi7XFH7woiFxG3VCz8OyVd7pmGycoI40uzHcoW6
	o0ORU9COQeWazJgpG3oEtkgHhh+4IujAaZ+N3dyOiqWr1g//CsbPYcwqhV4B9ELZ
	BM7pmb3bb0xg/nWFpsHVgJ+BQskXVpOyucUKMHi64Smw2l2bLWkc+blW1xCfdHBu
	/3xVWd/IxZAySCVFZBIkw==
X-ME-Sender: <xms:1ekLZ--xuu1UO9OK8JZH9t_zVC39pRWhj9BvDqF7G_iM_PBG8USsXcU>
    <xme:1ekLZ-uYpIaOPFFWTeCwOubzUvzydZQAyVrK7mk7ZhNgmxnofxaCyreS4l94nHnZK
    LogFryqfxv1uoJL8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghntggvse
    hfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1ekLZ0CWfO-iNQKDMWXPkoKzwsa-81z4jF-Z1DSzz8h2HhUoaDRRUA>
    <xmx:1ekLZ2fl7C4rlaY5w6kLLaA_RfFwkt-v7pMjnoHhfVkxJPKoa3rdNQ>
    <xmx:1ekLZzP7L9q6uDllNl2aeHTAIH_fJuyyon4uPxVooiiErTDEBMiBXw>
    <xmx:1ekLZwljCFClqd7y_h9RJ9VxEkuO8kBD90tfTA5rypjYDBOv-7DLQg>
    <xmx:1ekLZ4ox78buBZP1i7z_bh2IAhjBPiuSK3u1qJQPc5RKQVwnIvaJUWls>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 38195780068; Sun, 13 Oct 2024 11:40:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 13 Oct 2024 17:39:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: git@vger.kernel.org
Message-Id: <ef5a38af-e2bf-49f3-8611-6134970f829b@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
 <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
 <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com> <xmqqa5facosb.fsf@gitster.g>
 <f7a7046c-020a-4365-baf4-49184bd2c60b@gmail.com>
 <16d2d47c-5887-4658-b6db-996dac075828@app.fastmail.com>
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
Subject: Re: with git update-ref?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Sun, Oct 13, 2024, at 14:09, karthik nayak wrote:
>
> I agree, the documentation here could use some cleanup. The confusion
> here lies around
>
>     It also allows a "ref" file to be a symbolic pointer to another ref
>     file by starting with the four-byte header sequence of "ref:".
>
> This is added to talk about how the command de-references symbolic refs,
> but it can be misinterpreted to mean that it does support symbolic refs
> on the top level.
>
> Do either of you want to take a stab at updating the documentation here?
>
>> That seems in line with a plumbing command.
>>
>> --
>> Kristoffer Haugsbakk
>
> Attachments:
> * signature.asc

I wonder if the third (It also) and the fourth
(about FS symlinks) could be removed. The
third is confusing like Bernard said and the
fourth doesn't seem relevant enough any more. Not relevant enough to be part of Description.

And the "safety" paragraphs could be moved
to its own section. Because it looks like it's meant as an advice to unlearn the habits of a Git user from, I don't know, 2005 maybe.
