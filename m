Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C07A920
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065855; cv=none; b=GV2wgaX0qxJe0XbgaukYcCfR5vVC4ruOcWoCcq1YBLv56cUiGYJu29jr45vyc4/Sh0SIrFqxVPCmcTwogNEJ67xsKTb/JsluQLk1geKXNZNIXle36RO4qkXvgWCv/EDIIHAKTG+Aj5OgnfULP4EiH98soerFUtsb84AyA7Pwv9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065855; c=relaxed/simple;
	bh=mmMhV/NoY8LUmltmCH/wphqQ4udjybGtq3QkYPu8PB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8AIRwbGbgHihxh0W0JdWnlggVHtuVQd6217laK8LycPcvm0a8S2VONVD4BDx7KZlcyqc23ycMRRlOm7NOCOwvZx9QdEXqJJUlX86unmV26y2oFuC+GxQ8nEgXW6Dc9h5B13fGJGzsTnXmvuozqZ9WOWgPcVdmf5fq7LMKIpl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwlQhsXy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwlQhsXy"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 128A011401CD;
	Tue, 19 Nov 2024 20:24:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 19 Nov 2024 20:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732065852; x=1732152252; bh=+44q4wIYBWYTg2JLAosJw6YCOlzpvc7VNlY
	M6lzWYaE=; b=MwlQhsXy6hYeyl+09th6BORJbWH9IwFAy8yTefyOtj66L55L9Jc
	9U0+ezGnvZ2PuzqKIaMv47D6CmNslf5SlumCsKK1NqPzejbeYuSzygbvBU7D8cmw
	ewst7zFBlSuujQOnppJHtogqQd6J0h0cCkVjv/tZ2FWMMEbutUcWMsxs2Ibakp00
	7UG4S19mqTQrB65YJXNq1+OMg+YZ+3TGpUS/Z6BR6A+68gdISQltUz5mmxkoe+EH
	KY14DKE7M9ip3wRw6cS82nm2x9ZZx24SG/Tu7MDQpqx58gjP0hCnIWYx9jaA4y9x
	4BXDPwfSgix3O8JE2uqNqD/SrMt5r731idA==
X-ME-Sender: <xms:PDo9ZyLGzWEci_SK6TDHE8DboZeWGVO2EEXD4pz4cOIEzefReM8wXA>
    <xme:PDo9Z6IE7u9ZyYR3csPQCG2UnH-zBHpsmhNusBJNqBvuDub0EVJf8EgP54Ebd3X_O
    mWNey0J_KI7AwqiHQ>
X-ME-Received: <xmr:PDo9ZyvdObkNDd7yevHrnVhF6RqOhJrDjcRDJBGqqEiWMJRfLBedcRGT_TdGL-pE81GpXm7STmI_pix9zPsSpctIXDfOMzhYJTy7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PDo9Z3Y530xG6Gqo0DkUPjjKv4jlnzo78GbUqzYg1DH5piC7ZrmV7g>
    <xmx:PDo9Z5Y_t9GwJU2Aq6CieIgmX9-WjDaBlb1P3JJe8EE_RW5VUOpNVg>
    <xmx:PDo9ZzBzVSFDwxEcYNnGjZZ8OirEZkNYcgCw21HsCXVTLF3_ESWkvg>
    <xmx:PDo9Z_a8vDlcnKCQNfX6_4Q55vB01UDr821nwThgfGrlqBuzYCurVg>
    <xmx:PDo9Z-P3oKMHSI61sHf08XHJriBoYn15S_UU2cPlOAwU6At70tDgegu7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:24:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/4] Build improvements for clar
In-Reply-To: <7jdpmcwlxtyzqrqmcftcdmrw3tqopawtuuzqf3uaff2gklaxba@covcdisniubk>
	(Justin Tobler's message of "Tue, 19 Nov 2024 10:51:03 -0600")
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
	<20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
	<7jdpmcwlxtyzqrqmcftcdmrw3tqopawtuuzqf3uaff2gklaxba@covcdisniubk>
Date: Wed, 20 Nov 2024 10:24:11 +0900
Message-ID: <xmqqiksiae9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 24/11/15 08:32AM, Patrick Steinhardt wrote:
>> Hi,
>> 
>> Dscho has reported in [1] that the CMake build instructions for clar do
>> not work well on Windows/MSVC because we execute the shell scripts
>> directly instead of using the discovered `SH_EXE`. This small patch
>> series fixes the issue.
>> 
>> Changes in v2:
>> 
>>     - Wrap overly long lines in the CMake build instructions.
>>     - Add the VERBATIM option.
>> 
>> Changes in v3:
>> 
>>     - Fix missing word.
>> 
>> Link to v1: https://lore.kernel.org/r/20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im
>> Link to v2: https://lore.kernel.org/r/20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im
>> 
>> Thanks!
>> 
>> Patrick
>
> I've reviewed this series and overall this version looks good to me.
> Embedding the awk script in the shell script and changing how the
> scripts get executed to address platform related build issues seems
> sensable to me.

Thanks, both.  Let's merge it down to 'next'.

