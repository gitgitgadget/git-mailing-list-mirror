Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CD35BDBC
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230845; cv=none; b=NVF7DYo46SuXAiN6ZXhhHmKNzKo4szZWVk9I5fQxwjYD5Pn0muxrBAXQUEsfI/S2+BgqXMkMjGXEruuAzvSxdC1VjJuL8utK4VNCxG6SoLdbiYWvXFM94q3PzDP+0tNprGOjVj/nlRpyeJVMSiX7EACJ6jK/8fsBs5rJYcHSJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230845; c=relaxed/simple;
	bh=TWN0Np6//AW3OePYX+onZgPHO2m7WE5mzXlIkMcfDpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4YYR7XzKUF8wvMzHJ4cHBYOcni1BxXN0ckUgRWBXRFRidO5BMDMziP00dvcZdMxWpsF5GNTSDl7NBEqgTlxYrojZnLfeL6OHKlUcmSvHORu5at0gqeST/YkzZC3ao0M9wV6xEQvJ47WY8e8U2XReTQvzfeYkajEtikYB5UZzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tQkR32Ew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ISRKkL1d; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tQkR32Ew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ISRKkL1d"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CFAF7A0206;
	Fri, 27 Feb 2026 17:20:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Feb 2026 17:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772230843; x=1772317243; bh=fVhdSjr6HR
	dyRn/grihidCDFU2+Q/s3Iqq68c1n+bVk=; b=tQkR32EwofKZG6fF3wCkyuLCKT
	gyFZOHGvKyLDgt3bIyCY3UT/F6zXPp+aJndis3AyB3s/jaqYuL9+grvNG415nss0
	ysj8rUKitS0j2YpN9t1mLpSU1JuKji+z5F8KCPkHKiK6ZG8KV/gZCNxXtPlxDzjc
	oHXg4rK6YAfl4gw+8FpuOgfoKRESKtIG+wNTQZD1hraKl7ERi3EuXbSdlZybxP0E
	o8GoqsqZEziu5qUTygHutBkW//03EWUFdCp7Rihil6Oe+8K/+HSz8z9J+jweHWp4
	cR6vuXQu5Qks02gJqIKLjDR+OkEqQ0QBvb5EvKpR4l3OiPqjBR5pd050Rvxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772230843; x=1772317243; bh=fVhdSjr6HRdyRn/grihidCDFU2+Q/s3Iqq6
	8c1n+bVk=; b=ISRKkL1dRIzUmm85xaEkVqu5dlYvL8E28ptRv9rxCPdNFYi4ZTd
	ongul7psm190KbN3+T858QZ5gmoH5c2HCCmYlBobsL3oclsQ5/1H3Ieu4TLdcwaq
	ammysV5OB+l5jWIr0W2Uu0COgSvARkzppuafYB22o2TAiXnhItXJ0M7sKaJ+OoY0
	vfJM7wxy4fxyNCv4PL93rUtzeEHG3L0VrVurEt+cH+FIKdP8gwUUEX8gAUfYLDss
	5fp9cmGQe5oASAVFXTDNEwcVPFTBM/Gfzsa2ZiDHX3zVwU7L+4p0aUl3liNevQbM
	0zXVbuE4ZnEed4dNUJVeS6Xycmb8RzKRLoQ==
X-ME-Sender: <xms:uxiiaR6UMkuxtTt6rleivvMATf3ui_MWjqMzc12j8S4C-XjSD6u0Iw>
    <xme:uxiiaV7FcmgChS326Mdg02g_W_cE05jsdrrbl4n1Jcv0gK64dh11yjl8Vd82b5nUn
    MD8KCC39TZhsXgs1LeR32F8j9ZBqHROxwo2z_HWGQceMaHhfqqgbQ>
X-ME-Received: <xmr:uxiiadeKwnr_2mNyooW1A8lNIaXVh6JmIXvGm6xTraZjlhL7ZaLYEH8bBA8DOmkYS79_F_gTOQKcC8ukRGxuBb4uVBkikodQdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uxiiaZBV5lZ3zN5LqV9IRNlSrhVFfUVFVniPkvQKtRlhFD9nes7iLg>
    <xmx:uxiiaQ8E816yD4CE3Zhe4Z6E-6zya7FsV-VjNb3solV8n-2T_nlYog>
    <xmx:uxiiaUKCiNFETq9lP8EHZ2lX59nEQS7d5bSqRHqMu_UHiWd1wnJpfQ>
    <xmx:uxiiaZjV6bTryz_QDiX604EG1tkBCvjTqrHlWBgKXh4KoB_BUSR0Zg>
    <xmx:uxiiac8DuE7m9kRC0o7_w8wyzIeWUcitr7OkFkwDFv6-YWLs6DdbkUIu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 17:20:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <bcf64540-fe84-4fcc-a969-6927f348608e@gmail.com> (Tian Yuchen's
	message of "Fri, 27 Feb 2026 13:26:51 +0800")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
	<xmqqpl5rumy0.fsf@gitster.g>
	<bcf64540-fe84-4fcc-a969-6927f348608e@gmail.com>
Date: Fri, 27 Feb 2026 14:20:41 -0800
Message-ID: <xmqq4in1q152.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> It seems that failure "fatal: error reading 'nul'" matches the 
> 'die(_("error reading %s"), path)', if my understanding is correct?

The message is likely to be with its own pair of single quotes,
i.e., "error reading '%s'".

> So during 'git diff --no-index', the test passes 'GIT_DIR=/dev/null'. I 
> highly suspect that 'stat("nul")' on Windows fails with an 'errno' other 
> than 'ENOENT', so it falls into the 'STAT_FAILED' branch...

In the expected case, how would

    $ GIT_DIR=/dev/null git diff --no-index . .

start up?  setup_git_directory_gently() is called with a non-NULL
&nongit in turn it calls setup_git_directory_gently_1() that gives
us GIT_DIR_EXPLICIT, which makes us call setup_explicit_git_dir().

It would make us call is_git_diretory() on "/dev/null", and a
non-NULL nongit_ok pointer causes us to return NULL from there.

I am not sure how the result of calling stat() gets in the picture.

> ...which can be simply fixed by reverting 'READ_GITFILE_ERR_STAT_FAILED' 
> (and probably 'READ_GITFILE_ERR_NOT_A_FILE') back to being non-fatal 
> inside 'read_gitfile_error_die()', if I'm correct? In that case, the 
> logic of the test script should also be changed, shouldn't it?
>
> However, I'm sure that this change runs counter to our previous 
> discussions. I can't think of any good ideas since I'm no windows expert 
> either. So you can pretend I never said anything :P

It sounds like saying "oh, this is too hard, let's punt and roll all
failures from stat() into 'nothing there, move on'", which is how
the code used to work before this patch X-<.


