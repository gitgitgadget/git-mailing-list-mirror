Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E61E9B1C
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963577; cv=none; b=tVpwkrK5kpxW/htYOstdTrO/H9kY8I0qJS8OIAaSXgC6vwkTLZ3MTAmrOIlIU7+kxnDqA4k1slUQdB9SZhiFe1KRargBUXl/9ZOxmfFKO/IXIJYKj7uxwYcq+dWRS1i5XVJmb55tLFG3j3b8VO91D6GfvxWDZHhijR1hivRqNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963577; c=relaxed/simple;
	bh=6XQda96tSJpeA8vRLfxPdecNaZagm6/rBIR1c1SRGB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sf+HJz6/ETA+AmAjXPQ07lXcbWIrtlCgBwy2AFfxV271wMe6U4W96co+Faz7QXgFfjOOzRKR4yh/E8eFTE/o4dAbMlx0wNycFuJh4o1T5s6hs1lVG1k9OoMsTWuR9cF+SQN6HqbpMRqEXDVLBdjHZaZqOs2Unwo2nKFEvuUPDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GuoExnsu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hNDavZzw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GuoExnsu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNDavZzw"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 923961D000DA;
	Mon, 15 Sep 2025 15:12:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 15 Sep 2025 15:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757963574; x=1758049974; bh=aPsg1mK/m+
	GYLpUd9a1/rrUsyRWrdR7Mp5eB2em5meI=; b=GuoExnsuhJ03qyTEmhQBDkbxHn
	6ZxChno35RipoaFbev0NvOmZ8vTWXPbV5N0hMhUBh4bYejZ+FHm8yckSPvAXHp0R
	Fp3Bnnu8jmRoca/N6WIVEfQdI4r7CrhKFXmeIBKcDTJG7BhXTDz4mW9uBqbZxlzt
	Zl2a65J6NmNbqIy95B3ud9pqSN+lsMYiiUqw4MovSKxIvMq8mwZ/VQIj/7NMx9qs
	H9LYlELxhJVaj6XdG5u77h+e0L1REDU6X63JQMpezaJBm+qVtdT/k1loLGunlMcx
	0bwFximaxmNA/bds9jqU47s+xxc/FClkWJy5n5hTKNq3D0U5NCykgenNS+tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757963574; x=1758049974; bh=aPsg1mK/m+GYLpUd9a1/rrUsyRWrdR7Mp5e
	B2em5meI=; b=hNDavZzwtSVfA7CVDZ8HOiaOAaCAlHf92VXDa22OqVLcNIKNHj4
	ygjgaNqw1DcVwkHnAcPa0ssmZq6x7DOxh3jgBN3Q9BADLKe6jNhaSzoiUWInRQEs
	VF/+D8jJjMy+zhTYoboYVrONMN9tZO4ExCZAXXnS4Ayr/j5nzUZiglQWbWKG2hgC
	OVGMc0o96Bh7eT1PCcCR41NKZD8S1plXFRiyrlhh15agb6F6km+1JeD870Shz/RD
	ZPfcfM45UdfkcU49f8vt2psvVkXGAF3XWg/IrRbO69jM+X3FYTkOFMZ70ZPgvFqo
	hQRpIJmHFtu22gtZ6/sOu7CgrAD1ieuGEfw==
X-ME-Sender: <xms:NmXIaDMIN6D2hTH_1Pv8735eE10ftFsyF9pxqhqAC6VPweg-xDzobQ>
    <xme:NmXIaGaqk7r4PhsPBnh-72Ey0jo7OWIQ4bo0Rt0reN6fP7mKY8hesAlihnKFk6Scc
    JsV0lMv8haWMaUQhg>
X-ME-Received: <xmr:NmXIaCuh7InJ3fSOJXLYXZyGzY05o61TpU37laRVHfZ7RffmnR-VaCOxAdL66p2DNLpUFL0EM5NaE1Uew-gCva6k321FPCTi9fkbORs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NmXIaIMQp5YAas0J2hPHlK0zOdV2XaNIEoKRK0VqcqT9dQGE2FVHXQ>
    <xmx:NmXIaJ7Y659kgI-JIVF0CTvrMVIFvRzXuvYinJpZUPg3yGoSuX_AYw>
    <xmx:NmXIaOSlub_P64Vqi7CGp87JqzTFwO2gsvycBhARrj3n-G5JzRjs9Q>
    <xmx:NmXIaGB-FBLVs4zWET2llCok4zuINgXTAtUT_IlPLLPVJKa7EZFAVA>
    <xmx:NmXIaEx-FGbV5RWBGeaVIWNEk2xoZqrhFMIwW8gdqlNuK8NpI-CtPz_b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 15:12:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  newren@gmail.com,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 5/7] sparse-checkout: add --verbose option to 'clean'
In-Reply-To: <373d3441-6489-4b46-bd80-bc1ad68f0e9a@gmail.com> (Derrick
	Stolee's message of "Mon, 15 Sep 2025 14:09:14 -0400")
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
	<2cde464fd4c225144489c222537e5d7549f81849.1757673011.git.gitgitgadget@gmail.com>
	<373d3441-6489-4b46-bd80-bc1ad68f0e9a@gmail.com>
Date: Mon, 15 Sep 2025 12:12:52 -0700
Message-ID: <xmqq348nh6mj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 9/12/2025 6:30 AM, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>
>> +static void list_every_file_in_dir(const char *msg,
>> +				   const char *directory)
>> +{
>> +	struct strbuf path = STRBUF_INIT;
>> +
>> +	strbuf_addstr(&path, directory);
>> +	fprintf(stderr, "list every file in %s\n", directory);
>
> I don't know how I missed that this debugging output line snuck
> in and stayed through my testing. This line should be removed.
>
>> +	for_each_file_in_dir(&path, list_file_iterator, msg);
>> +	strbuf_release(&path);
>> +}

;-)  Don't feel bad.  Nobody among other people caught it either.

Locally amended so no need to resubmit only to fix this.

Thanks.
