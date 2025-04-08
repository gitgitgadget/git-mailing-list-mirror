Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561CB664
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744072354; cv=none; b=JEvY4kPTvaW+dYST2GfgUcjMVUuWiGIlQ+Ypzse3WHBswAiRL6bjhTX1fjPTb6p8RdO+58f6ghG2X0uahPUkPj+TEU/eg+BCUo48R7y58QRCqiSqqcY61WQ6XOeOBDjnWlzvi6hJ720N4fDjjmAVo6H8UDkbtNbJhXGHctkExw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744072354; c=relaxed/simple;
	bh=kgsGlwEH6wJXBktW9DgDxfytO+AHPQflycpiMfsnlEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nm7tLcZ7xwKcMb9AGg2m53WXaQTHcr1VEIfWIua+cdA79cg7DgObn0iGrVXqiVbPujMYgyENJDAFkR2KxzxvjjWwGC4at1lYYSPs3jHTgumMl1/hwkeONtp0wejpWw0PPNL2Fnek2cn660gTzmlP//1qbOEk3q6EC0ulGbc1PTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=taos27F6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PzeErGlM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="taos27F6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PzeErGlM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D57CE1140197;
	Mon,  7 Apr 2025 20:32:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 07 Apr 2025 20:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744072351; x=1744158751; bh=xzxYz0MWi9
	5GMwMfO4Nk/Gm2D+7VA9IUKanSSGZbWTY=; b=taos27F6a1FFVlbBIltcc+kPsu
	jw4uzlUObi2gHrQEyRwoWmoCxQ4qqE4V78Ks2vEmw4210Il1AfnwVtAkP14m73qh
	ef2Lq4Bn7H4Qv836nJHv/re6lbWQS0QrGYCWvqaNvXTN7ETCKCEtrnixdq4QbAgm
	0AeRPYNZw6mvmZKxYd1rtu1k95Q2uQFVluvbkUREVaHInN7T+lfj7nVO7T3TwV8L
	kuYVRmyXcA5eRi4CAg8bP6bKli9mGy24g8ibSExSM7f6ERfJt6qdL3InAfPotjF1
	4g/e7QuSihse3gteMC4w1Imp6iXp6yQMJyyCPpvPgxsxiuNcIgwprQkv15dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744072351; x=1744158751; bh=xzxYz0MWi95GMwMfO4Nk/Gm2D+7VA9IUKan
	SSGZbWTY=; b=PzeErGlMiLrWmezR51GJ7qH3easVrj5RAfWfftA2/hijZvyYtUe
	pLxAJFWJvpUBdUD02G33laNUCGFvbBhpXxZorKI6xFUuqxkUw0KrmB4xLEAlv1lV
	OwWiND2IkL7UDE4e/tmNOKe5eocd+SGAuzG+R3VVGFRstfRNa26VHTdoWvIctDdf
	yODbyI9ktYJH5NIpNV9hCOqdE4wwpOzLXSXE2yoSHZv6HiUiatne7V/yiq5sLw7x
	tHGAINwVkvNJGhRtjTRZzvVUkR9QcMlp4VirJ70In9B1iUDFpUZZo0QhnFalaPmw
	WiZWRlgnhuYVTgl8ACcq48hn8J/ldOdaBAQ==
X-ME-Sender: <xms:n270ZwhxDv3efvYCzyhao1epwj1FiAsIhcijgHStJTFByFoYqBhCfw>
    <xme:n270Z5BsCSSm1_SRjgHfd_cLhZDh4jd0zfkA-ENM4uOdocD861jDYHddNkdGf4KF2
    OwYoF7iuojvOn--FQ>
X-ME-Received: <xmr:n270Z4HxrLuDy5uqDdY_IGO1fQmkEscBpdm1aDEGGvm3lBch_iHjy5eyBmsjcqmyVa_SB3UZckBB6FbRqo4Rz3V_Wj8i097iwOW9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n270ZxQmbA8MewZWoH2yDTSyw_aRPKQ4EfL-s24nslEoc_jktfL_Xg>
    <xmx:n270Z9zy9WmFHupoTLZXtozx9z5cfB686y51VXy5k-DUZdLy6DO3_w>
    <xmx:n270Z_6roEH-0DB7v84Z34OaE_pTpEVHC0anXjNzFxilbI_zje-8mA>
    <xmx:n270Z6wAtZCyc6uaF0xPfcjSIHVl80HoBy3iljy49qIPncqHf6u3VQ>
    <xmx:n270Zw1AQvJ2vSe1J7AHUROcS_02K7xaiKqhG_Km_T6_V3p2aa1OcbmT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 20:32:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 00/20] t: drop Perl as a mandatory prerequisite
In-Reply-To: <5e00e50f-e2c5-a633-28ee-684e5026e92e@gmx.de> (Johannes
	Schindelin's message of "Thu, 3 Apr 2025 14:12:48 +0200 (CEST)")
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
	<20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
	<5e00e50f-e2c5-a633-28ee-684e5026e92e@gmx.de>
X-Gnus-Delayed: Tue, 08 Apr 2025 00:56:19 +0000
Date: Mon, 07 Apr 2025 17:32:30 -0700
Message-ID: <xmqq5xjf1oip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Patrick,
>
> On Thu, 3 Apr 2025, Patrick Steinhardt wrote:
>
>> Changes in v4:
>>   - Improve a couple of commit messages to better explain the changes.
>>   - Link to v3: https://lore.kernel.org/r/20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im
>
> Looks good to me, as well as the range-diff.

Thanks, both of you.  Will replace and queue.
Let me mark the topic for 'next'.
