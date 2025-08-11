Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488F2EA494
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926884; cv=none; b=iXFOCpnp8uTs9i0mCsVyfTHkZLK+03q1DzKNGpuXbJ3j23GrWLDKL7b6YI+5qXIf13WUOSo8ZBPX2cOGNVxZTKFXhEdVm137RWLMIa0BMzI/pS50CmFt+7dVthEkoucFQeTa1TABsuyROPzruyAT5THEAhHJubRYMEb8sdLuIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926884; c=relaxed/simple;
	bh=0WCv+UnybgRv/TXSUJmhyneqsyKHf6WPc1Zc7T+jomM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IZOISFNuWxTNzw5wzRrn6lvuQdWQmkKSbsNmnNCAVR3AkkC3M1QclGWkAhd86VGnDdlg6ISGPBrx7vjKoSDtGi+ok2AMt+bhDjQ1aGbManIIecR1o+08l6YuIT+d4j7y8NhwIjYXe3Sixn/KYIVE4K4IWxKMIGB8ttqFaZrnttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AidlRU6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P20KRUs+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AidlRU6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P20KRUs+"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17B057A0068;
	Mon, 11 Aug 2025 11:41:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 11 Aug 2025 11:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754926881;
	 x=1755013281; bh=lmT35a/aFJTTze3FASj2ogt5ko3jM1n7Z3I7sRDUDTo=; b=
	AidlRU6n7MJ8LOXjSPa9E+ZI1EMynXg+TVtJyr5kdURKDr/AhZkAlayOx1sgg55Q
	CIU4zQg183dwydOzGfIFxN/faLdJM/PRWOnEliio7MKTK8ZNjdo1FpR8QFOKjqX1
	NlqBj0T9iEqrCbZEGIkmGr8mKTWyXAGQou9B7e8zF2W9C76rPDhJPVdrMyiq3468
	xjSyjL6PdKmaT8elHBMIH70GiSUKQ5hEVc3L9MAykT53hEvcHCyyISE5Jwzfaqw2
	aGWuoga26KZ9OInrVUtAJcXErRxcNWyU3RWDrCXDQdMnsVwetdy6qlK5XTZ6e1GO
	rgWMzZKKiRgh3Iqo74/Vjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754926881; x=
	1755013281; bh=lmT35a/aFJTTze3FASj2ogt5ko3jM1n7Z3I7sRDUDTo=; b=P
	20KRUs+2bxs7QHH2d3uEedBIHCQ/rsFFWDogmIcTEN8LkpDnBpAXpIbO79Wjpoqw
	IFYRJ2Us+8+Ru+5ULMgWrBnukQfacrksaUr41rmBl7mpPitr0qcxNajDpSZGc8ne
	NbsPbz/LegGoarhewLbx919ntlVg0ck0ssb75Kplu5Ab/zMg0mTHG8Zv4t+F6K9M
	P57aDCD0OVVD7CNsHsgGS9TchpL83Zw8yyE+iRwGqnpQRecXyDn3QnHyy1Y3JwNN
	UwNs7VnQPokjTlGy10lBtqyPD+9SI/dlGfG1wFgueiHZ10P38oEKbQbR6rzek1kE
	WGoOKNdbr8yMT1sJVQJ5A==
X-ME-Sender: <xms:IQ-aaG730QfZ79hONRCdIOPB9CUhStLXZelyb5VPzXiVyG5mqdbeIw>
    <xme:IQ-aaDI2map5Gh7s3JtNwqyur2Itg6pz3qDkXG2r-NAMdqm92EJkeK1WTAJCVmr89
    q9kl8Q4gHmolh7apQ>
X-ME-Received: <xmr:IQ-aaO6Cz4RVp5hnku57coZCQ0IndkHK4ix2qDZAw7sBugoUpXHbLLv_jYGzMlRdo0dQo_xWdDiwJ5lIbJVe8BPyutGfNT632gXv-Vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IQ-aaOwOxn3ADnv6rW62D8Q61QbiLnQ_AqD74pRSbEE3BXyjKbRYDw>
    <xmx:IQ-aaKbj3fL3iqsuHWklXafMsDj9cDLrrafHCWCmoQbUPZqQlqH9nQ>
    <xmx:IQ-aaIQb3AHsNx4Z6ke9FLSRq4gZvt6E9TFD1PmVhd_udQV-BZyzYA>
    <xmx:IQ-aaMwPT8Tm59ePgicklxtwuRNMaCFJ5QBj-MZfV7Vdph8okaIslg>
    <xmx:IQ-aaMbqFX-yCpMPZX0UrCCpFSiMKjfwST5wA3MmY9ciHELTI3Xhr-JL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 11:41:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #03; Fri, 8)
In-Reply-To: <CAPig+cSbMeQ9yxXLFco8uH2kD84mDCu57sMZs5LtfMRnoKaYjw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 11 Aug 2025 01:50:40 -0400")
References: <xmqqectl6unf.fsf@gitster.g>
	<CAPig+cSbMeQ9yxXLFco8uH2kD84mDCu57sMZs5LtfMRnoKaYjw@mail.gmail.com>
Date: Mon, 11 Aug 2025 08:41:19 -0700
Message-ID: <xmqqbjol50io.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 8, 2025 at 11:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * lo/repo-info (2025-08-07) 5 commits
>>  - repo: add the --format flag
>>  - repo: add the field layout.shallow
>>  - repo: add the field layout.bare
>>  - repo: add the field references.format
>>  - repo: declare the repo command
>>
>>  A new subcommand "git repo" gives users a way to grab various
>>  repository characteristics.
>>
>>  Will merge to 'next'.
>>  source: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
>
> I think this topic may deserve one more reroll before being merged to
> 'next' since two or three comments from my previous review were not
> fully addressed[*]. (I also identified several nits in the latest
> version but they need not hold up the topic.)

Thanks for stopping me.
