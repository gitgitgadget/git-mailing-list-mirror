Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8B2BB1D
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534937; cv=none; b=CWWqChJXtS3PbjXunHccWWyDani6ABHOYywsUxZZGLJ4hugWXzoZb4mB+bxLPOCss4Mu0BiowUBN+GNH9KHIG7cTRTp268sCoeJ623VOuKVw6RFb2t92djd8aMAHmx0Nu06SsVUNiCJg11wQBgDwkA7DlU+hzHMpSkYlan03PLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534937; c=relaxed/simple;
	bh=suSpwGWZv7+L6P9sSPdxv25p2V3uDlzPV+MXt7Cuf1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7qr6UeL7NqVDTiNP7izSoAdQSseAKIhzq8KHP+di2jrKKpX7v01ENRSRcRSNhd8iARlKkUtx9n9X5gdrdmOPKut9HyEJLUrL4kE813XJLv6ABpJ1Y6NEn1jp/AosfxqRrCCaDcCxrhU7/2JrLT+Y3podJJmkyvEpngnipNs8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qlEjxMNc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k463OHgP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qlEjxMNc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k463OHgP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C7C56EC0378;
	Wed, 10 Sep 2025 16:08:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 10 Sep 2025 16:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757534933; x=1757621333; bh=pqpEyYmMGI
	s3Hb1zQHrn7hwL3fiVbA+Kb0oUP48Wtcw=; b=qlEjxMNc4aaC32bo8FPpPAYTbn
	BFmIAmAEr9WKKQsINUSbCW+PWASoAJt75zi+4d0EkFJE64ZVwdRqX1hcnF1CDqIs
	AVzQ2EFdspUkt7zpTB/+3UWyUFH/6d/dB014XyjQts71hkomaU/DJ3OwmFGnQNXK
	pupNUDEl1Sb/N97yrG0Un0Ln4PFX9RWxbVqwwNbbMKJSD6XuuY603m1TgHHRoFg3
	6pSydzLHRqrejFQiwp8LppdbUUUimv2QQQ9EJLgdtLSdfRbLB/a5YYABuN/EM4nb
	ixdQW0ECxIS4uDux9HI77S2Wsf7nePTVMXPcsVKYGfMmTAjycWKg6UjbyNFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757534933; x=1757621333; bh=pqpEyYmMGIs3Hb1zQHrn7hwL3fiVbA+Kb0o
	UP48Wtcw=; b=k463OHgPWVYYeCaFmomLGCa+/aDzZDBgckdXS5mgAjI84GR+yZa
	HwK+FgcYp+PJmqZBNX32sATBH4xVS61K6Fz54Kj/aLhbO/2//zp+F2Yg56vSK2VC
	cehpnOlpcRfxISIDQ9joiY0Uz5y0e8wX8tNPp32NGKw/w9nF5AMUetpD/Z5PwmP6
	mWVGgAqBXyOmx4ZPBBmbujAQubVBNMSOHuKRlCrUhgP3xF29z0dDsYL8c0HvLKvT
	Hvs364ypS8L8qxbfDYenJX0UwK/PKbCGbc2moLH08V/MdzqfkN5JraxmyKAxWC3A
	hNp9jlvykQ/uH9TORnnBXs0qi3wa2cjASXQ==
X-ME-Sender: <xms:1drBaHGZ-HUs7XCfW3cSX0y66EB1rdJtGY7IOQjpuHamiTlnnpZVpw>
    <xme:1drBaHnjXjsLyOgRLjVZct7G8oh2yHtYKJdFsntXZwWLD3mEcQzQMUWqJ2AUNTOyk
    WcOhTB6kHyy6_Jtig>
X-ME-Received: <xmr:1drBaCkUHBJcwdcAnpu8Dw-iALMpiWgL_zzVBbxLBDf-7e-bwi327CJaA_paGeO5HqLsytPxTNz4OKFkObyGEEfcQ0bk7mp8p_G9Ga8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithestggu
    vghsrghirdhinhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1drBaAvnPn4v_YohxIQeUT59HDf9w2w70Ln5Hclcngi6Am0_SyhIGQ>
    <xmx:1drBaNnCEdcbuz5CphEefZyLJ_jJGs3ynZ-zesApPqzjVPqWHzV_Yg>
    <xmx:1drBaDv2fcMRIJwJtoepXGm9fWz4ZsAiHyct2uS0btAPEJ88JPFQXg>
    <xmx:1drBaLeZbfNXnZxrZUgfXC7TH3BSJ4BnuMiXjGZfN8an8sTsrcPJ5Q>
    <xmx:1drBaPLef2QopDL7wnURvVmhG-qTMODdEddml5qTwbV0XJPziFXPvut9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 16:08:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Chirayu Desai" <git@cdesai.in>
Cc: git@vger.kernel.org
Subject: Re: Using command nominated for removal: whatchanged
In-Reply-To: <b32a369f-87c9-41f6-b1cb-81273945dc17@app.fastmail.com> (Chirayu
	Desai's message of "Wed, 10 Sep 2025 19:08:24 +0530")
References: <b32a369f-87c9-41f6-b1cb-81273945dc17@app.fastmail.com>
Date: Wed, 10 Sep 2025 13:08:51 -0700
Message-ID: <xmqq8qimrrxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Chirayu Desai" <git@cdesai.in> writes:

> Hello,
>
> Hope this email finds you well!
>
> 'git whatchanged' is nominated for removal.
>
> I still use this command. I usually run 'git whatchanged -1' and 'git whatchanged <commit>' to quickly see what files have changed in a particular commit.
>
> I guess there might be some alias I could setup to achieve the same - it's more that this command has become a muscle memory at this point so I kept hitting the removal message, and here I am.

Thanks for letting us know.  If you still use it, you can retrain
your fingers to use "git log" with some options instead.  The most
literal translation would be "git log --raw --no-merges", but there
are MUCH BETTER options invented since "whatchanged" was written.

If the reason you are interested in is to learn the names of the
files, then "git log --names-only" gives a lot cleaner output
without hexadecimal gibberish that has not much use for human
readers, for examplle.
