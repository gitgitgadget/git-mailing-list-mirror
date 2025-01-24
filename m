Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5D1D516A
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740655; cv=none; b=RQKiV3X8Exs+i9fJGRcCts0agU7jlg86Ar17tS2FRes0PmhowduAJ2aVg8GDFevVCqWvbT3gr/f792gTKmlZ6skxSmYIbGXQr/f0x4oZWRqHpozVWZyNP9oTVTM/c41hpxUhoeIAhaLoaXeEOUXLCRDeniHWb8x+Y8o2E9+faAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740655; c=relaxed/simple;
	bh=YEUwFB4c+U/WhUqJXOyj53PscTi/AtyLC/Y69gz+kk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRNV04Lz4r3qpYMw+ekszANNmAOTWrbuvzkYdqcmkvJ55Rb7KSCfOSNdFHXLxLc4cweZusW0tJBD5z/LGnxUWYIV/C9qZPU2hZ8UOqevQ1dzVqnvwCERPGl2l6LqC57upfvVkajyXkPv7ZQ7faux5AHFE/XB7Msp8MYZ5WqLJfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WsFsMXXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF0svAFi; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WsFsMXXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF0svAFi"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E713711400BF;
	Fri, 24 Jan 2025 12:44:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 24 Jan 2025 12:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737740651;
	 x=1737827051; bh=Ndtyp/xfFmZK7MMEGl2i9pUG1GeIWwab/EdlD22Vzqw=; b=
	WsFsMXXaEXZvADmXLM+QjVo+v3x2jjTFMhYZNQZEBn7Un3r4yjbWYRouUhx5rILp
	e4BsK6nnL5T2G+YZLUV1cw19+dQcL3g9tpgCehvxx0mrb9UK8Sgy4Z2lq+cXw6ag
	B3ScCrA0lTrBpgoqAL2i33SD1Y13N4AMAgM6h9JU51E3Co5Xm/F2/S8c4ZAgB9bp
	Neaeegjzg7BvTuQcmV2WG6tGocV2fzx0yeg3gy8KodKBq1ZpL31Pll2OJYarZ426
	FkoFCg8vEooptMC/v7qqnbQMDqu5Hd6yvJAxAu4LxeKKpzbH4fzlQmIwoFtm4V7p
	leWdaUlBEKDc92E/unI4NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737740651; x=
	1737827051; bh=Ndtyp/xfFmZK7MMEGl2i9pUG1GeIWwab/EdlD22Vzqw=; b=E
	F0svAFiv4ei7ft/zVOHY7am5lZw2ag39zF7K9SxNEtkhgGG0w+KBHsjWwZ5iNY2n
	H+9SfTJ9zmIuG9pxlZFhv6TKvwPXu54JLjdL4ns45QAOfDjXZPLkFPJUkGrOvVv0
	gujuJeeLDTUZkl5a7J2wYo3Gw/28NnYqZk27T22Chm7IjmTnBqebO3bmZcYGnsj4
	tdY5Ml3h97h7adtfJchZ+3jWh4XCLcDBf2kshc/V25NP1Kk71K0gbXFZFokcutLG
	zyW443clHAAPidd+dNfTK54SkgULw5eppB8zHkFXbMVLy0rHiQ8wZF9eL+4NzcZd
	hH8oisn5T3OHCo5p0FLJQ==
X-ME-Sender: <xms:a9GTZ8OwIb2H4pgTpr3036fK1CR9upsxCSOBK5VXehOHOoFenqZCjA>
    <xme:a9GTZy-R4SF6tq96u060wu63BgdXiKOQy3F0B6GcIwryRDrKPg1KN4X19gXVhAUh1
    Ibv4SwnnQaaLITWUw>
X-ME-Received: <xmr:a9GTZzRjL6Zy8IxahHqqBhnsbwk57XTgD_4_wuYxLELciA9_WUcLQ83c3tQYlscd9GeNKbFoH5AfnYCbWXy9ynjIhbGq1j-Zmt4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdej
    hffgkefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhulhhirghnsegurhhutghkuggvvhdrgiihiidprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:a9GTZ0thISYbIQ8ve7AvAhewOy2nIK034HUTZIWwwRwwsUPOV5j9Nw>
    <xmx:a9GTZ0eTBzHeDml5KCFQpYy0732rwnsH-kdQhmUeov7-8RS3S_m7Yw>
    <xmx:a9GTZ40b5oZnzQt1RYCEleAmYl1-uQDD8h-qSmVUBAQ9HcFTqmnwzg>
    <xmx:a9GTZ4_6U0trpGTIlQvRKwY5h79gLH98H6bHF2r5NRLjVbHmseGhRg>
    <xmx:a9GTZ5EAcBUsCAe8ZslmBb99IehGk4COFsplmZtMUIsPpaqW9z01yjp0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 12:44:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Julian Prein via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Julian Prein <julian@druckdev.xyz>
Subject: Re: [PATCH] config.txt: add trailer.* variables
In-Reply-To: <CAPig+cTj5Rwp8=KA-r6SkZaf=VpqSieD-p2FgGFoMW2zmnr0Uw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 24 Jan 2025 10:48:52 -0500")
References: <pull.1871.git.git.1736429142334.gitgitgadget@gmail.com>
	<CAPig+cTj5Rwp8=KA-r6SkZaf=VpqSieD-p2FgGFoMW2zmnr0Uw@mail.gmail.com>
Date: Fri, 24 Jan 2025 09:44:09 -0800
Message-ID: <xmqqwmekyumu.fsf@gitster.g>
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

> On Thu, Jan 9, 2025 at 8:25 AM Julian Prein via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The trailer.* configuration variables are currently only described in
>> git-interpret-trailers(1) but affect git-commit and git-tag as well.
>> Move that section into its own config/trailer.txt file and also include
>> it in git-config(1).
>
> Makes sense. git-commit.txt and git-tag.txt do indeed reference these
> variables, and one would expect them to be mentioned by
> Documentation/config.txt, as well.
>
>> Signed-off-by: Julian Prein <julian@druckdev.xyz>
>> ---
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> @@ -540,6 +540,8 @@ include::config/tar.txt[]
>>  include::config/trace2.txt[]
>>
>> +include::config/trailer.txt[]
>> +
>>  include::config/transfer.txt[]
>
> Nice to see that you maintained alphabetical ordering here[*].
>
> [*]: 5f78d52dce (docs: sort configuration variable groupings
> alphabetically, 2024-02-29)

Thanks for reviewing carefully.
