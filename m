Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7F18A6CF
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540794; cv=none; b=laU5QdsAnXOOsOWtPvnRwjCX4CswWdA7PWErz42C4gxVRiqMIjI2y7eAgvyTPgkvaWBmFNnUjRDfoKWsFLpKWMaoY73pGqqqmQpmiIhsZqboLm6XVoZqQh2l/J5E5Bayse1ugxnQD+c48MT66+q7UqGcLqVYyN79MG3LOl9XozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540794; c=relaxed/simple;
	bh=7BeiIruRbMDjOC8wqUNv/FHgQfpbDZKWN4l3wLMYrfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zb5HG2usHTc7+nS+Ip7i9x3RlJ8t7OQhYIj+d4QKnk4KQgaU0bfgWzcfMPCB25modkP8dRxM2/piyaT8xBzfIvBgozt6/6e3lhN9wHS4ubVgnUxRGk/hdTpEuXLrzEmcw+bQvm0s8imCHnWK9uGatgck9GIVYmpLxoiZsTZoPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iy/YiFJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y67ejnrF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iy/YiFJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y67ejnrF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B19401D0004D;
	Tue, 23 Dec 2025 20:46:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 23 Dec 2025 20:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766540791; x=1766627191; bh=ccP41IWuQu
	kzLJT/0+5FbiZ+P6IsIhe9lEo+ft2cN60=; b=Iy/YiFJyGsx+JfeTq/p9RKq79L
	ZaOeZXQAHFFKh2fhH5Wt71QfCGQQgjIg/CLBckXIfgEbTuobUp8kCeu1TuD1/QHV
	qe4GMKV3+iRKt3hmeTxwKyUy93kdS9xBQLsP+ylPWM3RlARFFxHE/pNVQXtGP9BD
	s3HdGxrUZUHjcgjHWUQ0WdozRxEWX1vIP45Flrhxj2QC3oWl35KXfbVPifxysd8G
	vEdNLWNAUDxuMVx3sYkUHIzr8cfu5/4EfFfbRfzv9vGdEx46KRCo3QHKMQWkj9NE
	NZb0CIl1qRw+7HaLt2QUwZBg/F+nCP+R8jDoTpeEHQG+P+lD4oLCV3FHYqtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766540791; x=1766627191; bh=ccP41IWuQukzLJT/0+5FbiZ+P6IsIhe9lEo
	+ft2cN60=; b=Y67ejnrFtwS/Ocn/EEoH7qT9gwswobo10YYUl9L7iizkId+b5pS
	hV5osEHdXft+/nTf0FdZcyGAVkf58fFp0vut87tuJ2Z2PhCKErNeKi/dHBRWu/E5
	HjecWRBkmjMYSQnJDPny3te8OZQOxIjaltDxGh12VGjdhoWsbwVjbTckk8LZFeE2
	HCG+ENhnq9TAeI+e1ew5fxHwn93CLw58w+Fp/38l99afZwmMd/JWQesY624+fLY5
	TCpv3qzpzOvGf4eAvNya4SqwiqJma/cQT22Kpykq5dgygamc8bCyhvl+Oq9OXUuc
	i6RH04Z9Qj3eJXl/C1bRqcr1UsoUIspKG/A==
X-ME-Sender: <xms:90VLaUX9MV8emJWoQTmT71-KaohBKdiDcP5DF5iFKm5-fL1q9_RRaA>
    <xme:90VLafe6nd6km-0Y4vbF4d0aEy1flGON4cpQ88m188ou7v3rXdB0jFeCPBI3gaRwq
    L20dNzi-VFHJe9GmatOx7cQK9aWpltEx1drkXmet48xMPH8tU1q>
X-ME-Received: <xmr:90VLaQsY6a-2w4UIG8DtBGGWh0TEs5umYibTRv2dpPCBgj2mbw1FzOl1oUUNgkqjsBwaTh8_5gMzipZ-DxnrR6kRdeyTEKB6UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    ephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:90VLae9Inou89TYIu0KOMQ6ky3au-gTF7ZNYPIxrw6dpMwYZLR3Bdg>
    <xmx:90VLab2EVVuyYr_3ecmSvnhcfsncLYq3sxhwJl74nlT7eQTUCHWd6A>
    <xmx:90VLaTCs4wBff70YOBwlaA0lrmn5NUM3FBgRf0Ag2Br3DY3PSTt6ww>
    <xmx:90VLaXe4HKADmCWZOHDxJdtFjErAMVAO567BA7Fyc5Xs1_1eufCroA>
    <xmx:90VLactbCRBniGodnuX4W5wgDfyae-KFBOivwM2e-iz6lPz4sv3ePDzL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 20:46:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 1/2] status: show comparison with upstream default
 branch
In-Reply-To: <aUtCP5YvE_v9hmgM@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Wed, 24 Dec 2025 01:30:39 +0000")
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
	<pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
	<a3800aed18e576e42de273c9dae0e25bbe26ac6a.1766530448.git.gitgitgadget@gmail.com>
	<aUtCP5YvE_v9hmgM@fruit.crustytoothpaste.net>
Date: Wed, 24 Dec 2025 10:46:30 +0900
Message-ID: <xmqqms38odmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-12-23 at 22:54:07, Harald Nordgren via GitGitGadget wrote:
>> +static char *get_default_remote_ref(char **full_ref_out)
>> +{
>> +	int flag;
>> +	const char *resolved;
>> +	static const char *remotes[] = { "upstream", "origin", NULL };
>
> This should definitely be configurable, not hard-coded.  For instance, I
> have this in my gitconfig:
>
>     [clone]
>         defaultRemoteName = def
>
> so my default remote name is `def` (short for "default", as in the
> default place to push) and this code will never work.

But there does not need any new configuration.  "git pull" and "git
push" on the branch is equipped to figure out where they pull from
and push to, so the new feature should be able to figure out these
(often the same, but not necessarily) repositories the same way.
