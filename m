Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276127FB21
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665362; cv=none; b=ah18PWdEqo7MnY2JVzaQ6sVhXls+xTgZLhAf/4V8ybxkR2BMTmf5Bol8//j3bmRj3b+0gxncriFkFcWNsa6A9vfP6qDF43jUnynPXsQgnuqiwY0krcUDe9cYc6sV1DJhf6H1Evky1dpcoNPxJAaXr18fJzZa43Jb1VLQfc2wFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665362; c=relaxed/simple;
	bh=AucKW+2zXuuCNETvpuEHO0XHpMttrMn16SrgYYxmXIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdx7tfSoZgonswJufq3hnDm0t7LN145RVsN/oUVBpFDAFXPrUTGk4XtPlYRd3s35lZ04KB5irYbSwIrhj27kTe8g3BststAUhMKxXZo3WNZ0KP528+GlR1uINGNWlFXhGbuuVAvDIFWuWMM8pq/ITszVcR2hgWjEwHkILeX1VDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H/O0BJbK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/xuVNNc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H/O0BJbK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/xuVNNc"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 688821D000D7;
	Fri,  8 Aug 2025 11:02:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 08 Aug 2025 11:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754665359; x=1754751759; bh=d2TisobGuN
	P8870eSRrCDFu/YEPiwoKjk4hmKMyv/rc=; b=H/O0BJbKCsZtxDKq2nTHB1kr3U
	biIvz12TB8ObXOyetvvM7VcTDgtD3nx7of0Ka2sujRtvKFDvJvBoikI3YOp6Gd3x
	lkzMCDrd/4RaA6Uh5ihqVGuejJfNg2hWuSbYQXf6V2dJfIBS8dR1r70t3fRf7l1T
	41Mgqj9B+gJThW8tXZGcOINl4jcYR1g+0cSrRp9hYlpL56oO7h5LtgoZ6krwstME
	fXL4flaiBCmiQkCYXiYbAQpymhVn8xUgGrt1jbDAS5L2u37WZrkrWeBBnbIqnZwS
	jY/TAOgzIbut+xeGZKOnDHMd/xK5E4loSsPmUvcMmDtdBEPBX40z/oIZFfQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754665359; x=1754751759; bh=d2TisobGuNP8870eSRrCDFu/YEPiwoKjk4h
	mKMyv/rc=; b=U/xuVNNc1WlmF4YH612iYwMiZvBv5qDLQ6QtFNe2oNDHe/enlla
	lfkLwOF1BSW+1wb4VtnffHcFtXT0NIgDUmuiuCfGKSDoH5yI47yLGM1vrSwGh9Yn
	nTbz57CcITBqMcRDszydI+i+JegEMVZt+MG3Fk6xDTEqhY+wTxyX02baDmDCvrSk
	6xe7rz3VkXHHj46ilA4CGB8Zf686JgUXppCmTXqv2e3ofwWMhOvCWyB3ob0OqtWs
	WvWG3ca0HWwVr9huUkBjqBeWXjSaP/1+uba5qytmMdetntFh9bkOLDhAey6gCjTN
	IbOCunuJeCjkU5icjBaO3AMzcP9j9uZ868A==
X-ME-Sender: <xms:jhGWaEf4hPFzE2NhMwZ9Pp9RlUeMnICnDqCGWaqrh6NFtaBMG4jLxQ>
    <xme:jhGWaO3Db7dftGeecBRRg8fMSnuIOSPS1eqSnVNA17D_WsJflwbeJhN6a2magGjtb
    wDT1yN17S6lYSZeqw>
X-ME-Received: <xmr:jhGWaM8s_p94vSM0HyDhi5cse8d9DhL8SzhylzLihvvWvnIjepGj1JPMBImrHR81Gi89i-h6bZynNtBFpIBQCL2Xg5uIF-m7LJdaSpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeguddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplhhutg
    grshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuugguvg
    hnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:jhGWaD4pGhxog3JgJQs2yYyyRodLaSQj0hEy7FAdmlSCeIDFFK6vBA>
    <xmx:jhGWaEuuiv4TCOIPLoUK7_OC7tp24Le_UtQecqJvEc-x8EJo7MnHMQ>
    <xmx:jhGWaF3RGHmZ2dTNOytzRMOIdZOsK3YuU-XKqe4WEPomlfE3JDYy3A>
    <xmx:jhGWaNrvFLYnUL3VxYRVG5klCl4zLonTUouplSfiLIHoTYXOLyUVyA>
    <xmx:jxGWaAo9iM4qxykkveIKd2XWOKBOWsnyyTaBtiGng97S5cgSLQbyJLeF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 11:02:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v9 0/5] repo: add new command for retrieving
 repository info
In-Reply-To: <aJWO78GrsUc7iBFt@pks.im> (Patrick Steinhardt's message of "Fri,
	8 Aug 2025 07:45:19 +0200")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250807150239.6987-1-lucasseikioshiro@gmail.com>
	<aJWO78GrsUc7iBFt@pks.im>
Date: Fri, 08 Aug 2025 08:02:36 -0700
Message-ID: <xmqqh5yhkgab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 07, 2025 at 12:02:34PM -0300, Lucas Seiki Oshiro wrote:
>> Hi!
>> 
>> Thank you all for your time reviewing and helping me with this patchset!
>> 
>> This v9 only solve tiny nitpicks pointed by Karthik and Patrick in v8,
>> just to make clear that everything is ok!
>> 
>> Junio, would you mind to replace v8 by this v9 as lo/repo-info in seen?
>
> Thanks, this version looks good to me!
>
> Patrick

Thanks, both.  Let's mark it for 'next' now.

5753e542 (repo: add the --format flag, 2025-08-07)
