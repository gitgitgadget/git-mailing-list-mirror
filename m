Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157D107A8
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712478867; cv=none; b=PuhRevSXV6nWQ/2+cbXu6E4y7t9oi3KBVz/kITXKtT7AX8LFpqGRyb8nZ1xx3I0mOBLgsBL5ai6weBlHAwIRHefDkT12Hn9PC4DE0/3wpEemHaSbgNZOW7c/N5xAxWxu7bU/zD9Bzz/PseDf8xo24+Rd8+2EcqBZlyks7GspXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712478867; c=relaxed/simple;
	bh=KGNoPnkJLMNH3ZaF3C/6swNpf7jtklq2QnkHZJUtR8Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=icnLtNfkJ5ccpuvbRPsE49hde0gSGo3D+cBugmn6c0UpN0csT3H5xwb9W8zMG9KMfYotmI2mhBt/uvRZZqNt4+zwk7tTUwAf64lO5iPmmrKeGWQ8gtnKZ2Nxajl+sd6h5RO7s/ANWEIIBbmUBO221zLP9NAegk94EY0GmszcWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=omVwDqF8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="omVwDqF8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712478861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQS+vR0qJqNQPqoH3AVYGr5V85FuNlWcrDeLKI7aEx0=;
	b=omVwDqF81eNVA9ABESKDCmxE8SDEglJic7O1nNxD2IqCR2agVcSR5+2+YJw70hgFbBv8J7
	jvSKvtUYFJ6meIsx7x1pzWQqgmcIF0EXtzayl/XTAT01S00PqIxehu+QtdyYS38k5iAcdX
	w4k34oTK+uL4QqFh5PcBdrHNMQ5M4wxrD77uxYumqvbUuA4Jrxky/UK4ofc3D+qPaB7z9r
	jfmgM7cNAvgMu97PSKkko/RJ4jDYIIZL791i8wPrvGUfJGDmQzObShvGt+sUJp/GkOnmAc
	HkN3O9SPm2JuD6DhclEvnSZFyKNXtn4dsuQSayJCmlGz0rw0EblzJO7BbjpDkg==
Date: Sun, 07 Apr 2024 10:34:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Add lines to `git log --graph` to separate
 connected regions
In-Reply-To: <CACXAH50KHrnmc1At_DHX5O=BGuGT_pe9n5nGLSJYt7fXTbe_Yg@mail.gmail.com>
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com>
 <xmqq4jcdivgw.fsf@gitster.g>
 <CACXAH50KHrnmc1At_DHX5O=BGuGT_pe9n5nGLSJYt7fXTbe_Yg@mail.gmail.com>
Message-ID: <1e5dfc946c38809f159776f41e23c7c6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quang,

On 2024-04-07 08:40, Quang Lê Duy wrote:
> On Sun, Apr 7, 2024 at 12:37 PM Junio C Hamano <gitster@pobox.com> 
> wrote:
>> True.  But because we are doing graph, shouldn't we be able to do
>> better?  For example, you can draw the two lineage of histories
>> on different columns and ...
>> 
>>        * a2
>>        * a1
>>      * b2
>>      * b1
>> 
>> ... that way, you do not need to lose one line of precious vertical
>> screen real estate.
> 
> I think horizontal screen real estate is even more precious than the 
> vertical
> one, since one usually doesn't scroll their terminal horizontally. And 
> then it
> would probably be a way more complicated implementation.

These days, very few computer screens aren't in widescreen format,
so there's inevitably less vertical screen space available than the
horizontal space.
