Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3EC449B0C
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537457; cv=none; b=gbSwSbKD1xC5HQhgZjBtLmf7h/4d33iTNiI7yT+k/Gio7MZEOQGNPe+6QxgIXg2vcsDYs6iCqvLnl/xqtwuhZLyd4NRjBQCXDtrlYVDPIaPp0QrN0cuQJONOZYnK8uDj/Wy0bqvpkcsR8xGr3cUe6YNjB6Hx7wXfJYbyzbeULd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537457; c=relaxed/simple;
	bh=W6V4LK2Zt2Vxj0Bz+C2krbv0Bao5iat6TZuuCcckG3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IbCwUrxS8ZtayhpBYgIKwKSfkWJ6GGEL+X758fv3F1FBppVvykW0pw2X7S6raythbRmW3ig61ty+/lgVCKtCnbFRg98ENiAr5agQzXorwq/jl5E+vkdEskTNaY7590rDHvfZVat5IPOk9uRwJTu26AXh0sWYSzSBRTcoqRke39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EperSlIK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+54TN+Z; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EperSlIK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+54TN+Z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 164DB14000F1;
	Fri,  4 Sep 2026 11:57:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 11:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788537455; x=1788623855; bh=/ezAyK6vVn
	jH843Uu4VLiPLSSfj8frD6kCPS6FxBqoQ=; b=EperSlIK0gBEmrt5Od7ooOO4Ht
	Vl6X3+oSTrqFnlwJhM4X/g6xQ0T32ykzY634Td2c9CjOnq42cyq6+8GM6gFjlepm
	+Pxk4cUQcVqRk1mezQ1nsdn1GSeJ9A1VS88o9YwY44to6fCAvcMpGg7thwSRLI4d
	Ykk/yJ0S65yDsAq/kYZcRjFGAkElnKdUe3+trVzP6HXr6jmTrD3fN2TusCb4ZTSD
	K3WbuBDK90OQzmTDj2mki68O6Jvqw/WcjJ9ssaH+VJ+rhvxJ4XCTI9FewvqFLBXN
	MpqfYHJf/jCw/9fkfYEOcQw4GrbroYyt9KOC4CgyCov69NwxmZVA75iVynjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788537455; x=1788623855; bh=/ezAyK6vVnjH843Uu4VLiPLSSfj8frD6kCP
	S6FxBqoQ=; b=X+54TN+Z3b3GIq3bLgB4xtIxV3rxDgur05x/gmVx6YGyLP7P1g+
	T+4qi612SmJ4EssX2XVZWpGdNtJ+JyLS8dWIZRFISPS4O48TjJQDWXKzfan5/7W+
	i5u8bd+ILjLbslKep0ruKcNMojmWWHwBh/nylYZPMDbLTN+uZeypOQrHytsfxT1x
	FsPSCIBdqf4D9fs8OTOHsetLL+j8pg0bEnUUowm2VpMyjZcIn4g3fM1FZj9RfRGB
	j/e5k301dXJ/oja5rok6dLSKB5W3v2/z+JeBYR2+J5bjml84DAWyOo4S/AFOrJsF
	ux1GZXf8+pDZwiFIgeSkHtcpOpbGsdLbmHQ==
X-ME-Sender: <xms:buqaanGGZsobPG2OwNHl2xgACEnqMEbIHiaN-xtLTU1L2ZU-sV_u0Q>
    <xme:buqaamnIajfE-K85-7m4Y9-KQi6uNJf5rOmEaV8b9p33pOJOiv87K-1cJiy-lZU4F
    XJCbsNvWQk36HboXfLjRTc4KJbmWsFU4XbqtO6NbXYPXasWxMTvgpA>
X-ME-Received: <xmr:buqaaraGlUJJHvCoAMjqB-mGkjPb_FN0KnXb7Ctwm7YiA7HsGRJHUpUQ8MC9oq59woWFk9hTksxTNjvkAEXXSUNFwcE2jajNeQ>
X-ME-Proxy-Cause: dmFkZTFnhltei96otmoUd8Y0o+gCNRWA6/5LA+l66Jrp4zOIZ9JMLkKQRO0qugJTpjO25+
    iFRM1fjZ7YhGfUO4v//SmL4Qv8LoN+BQuD8WGGxciiYJdOzumjEUvNBGAEtpPQwfUCDeeG
    vl/J5d+3ZWgK9V3qc5E+SJc1BbwFDQ4K4xUoSi8Au0qpobcryraR1nBoxH651Azbl9yd2Z
    ZfiUKR0qRSv2RkjXXg6lsVhnjYVjh7AwzxFRKBAvVPi58BIidMj0Xrg1pNGbAAeLMujl+c
    pFgAcKalW9mWycFIxN1CYrfduf74Ri+29gKKqwFtSHq+VjUkdTLDpGwnEEzo7O+oEjGmZC
    wFqvVDCsQn/Qqvf3pgSDEoGKt3CfAoAQMHN7rfK7edyHu3tullY7Sep4QMZHA1yVovEzz+
    dgZaAvSYrdzb07wNwGqQCoV7tTeFbi+RiJOMyBYyMRj0T2qku18t9eIOsrclFTi5SK5X3l
    Z4388J3dmQjZwFo6woBfLdJ5YYLaBO5ypDi0yu+jMiJdueXEUfjPR/bU6qq7wgMfsVuSc0
    7dyZkbk5MzYnQW9EkCX+3AC4DRXJYm2a42a2OvzpmRh9ynla1XR7xuwbMPcCq4GAKWNaoQ
    K3JscFfPJjQgxSiyn9jyT2xXEHWZfL+B/V1J//VeysAbhFlT0gQkVxeeaCVQ
X-ME-Proxy: <xmx:buqaarFNKUNNvLEUiVTw2CJ60GHmXhNCgokWk2C-LvsixfZUb3jckg>
    <xmx:buqaasLuQxk_CpLlROhM-9ciPtSiPm7uko4eQOlaOszFyicVpr8s6w>
    <xmx:buqaamNUlHNY_4fE230XKBu63ZjnIjVQWSRFM1snH3t5-0d1m5GerA>
    <xmx:buqaask7F5NCAa2G9jPPjxIUCTpIuPcaP37IMSb6oRs7bQS9AbFkeQ>
    <xmx:b-qaav8BxLX-31FTsQk4hrb9cY6fmrkuyN_OsJ0GjvZ-6Yppugk5IaDe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 11:57:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Andrew Pleeter <andrewpleeter@gmail.com>
Subject: Re: [PATCH v3] var: support broken-down idents, default key,
 multiple args, and -z
In-Reply-To: <5634fdc4-d0f8-493d-b401-3c9753524034@gmail.com> (Phillip Wood's
	message of "Fri, 4 Sep 2026 10:11:30 +0100")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
	<pull.2388.v3.git.git.1788403792962.gitgitgadget@gmail.com>
	<5634fdc4-d0f8-493d-b401-3c9753524034@gmail.com>
Date: Fri, 04 Sep 2026 08:57:33 -0700
Message-ID: <xmqqqzj957rm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   	if (value)
>> -		printf("%s=%s\n", var, value);
>> +		printf("%s=%s%c", var, value, eol);
>
> A key can contain "=" so this format is ambiguous. When the user passes 
> "-z" we should use the same format as "git config list -z" which avoids 
> that ambiguity
>
> 	printf("%s%c%s%c", var, eol == '\n' ? '=' : '\n', value, eol);
>
>>   	else
>> -		printf("%s\n", var);
>> +		printf("%s%c", var, eol);
>
> It would be worth checking what "git config list -z" does when there is 
> no value and matching that. Does it print "key\n\0", or "key\0"?

By "key" do you mean "var"?  The namespace of "var" for "git var"
proper (like GIT_COMMITTER_IDENT) are very much under our control,
but it also gives all the configuration variables, whose names can
indeed have '=' in a three-level varlable name.  This is an
excellent suggestion.

> I think we should break out of the loop when arg is "--", or does not 
> begin with '-', and treat the rest as variable names to print. There is 
> not need to support "git var GIT_AUTHOR_NAME -z GIT_AUTHOR_EMAIL" in a 
> plumbing command.

Not limited to plumbing, but anywhere in Git.  Let's stick to and
force users adopt the simple rule that "git help cli" gives them.
Options first and then args, among which revs coe first and then
paths after disambiguating "--".  I know as historical wart some
commands may take dashed options after args, but I am fine if we
tightened the rule at Git 3.0 boundary to more strictly enforced
the option/argument ordering rule.

>> [...]
>> -	printf("%s\n", val);
>> -	free(val);
>> +		printf("%s%c", val, null_term ? '\0' : '\n');
>
> Multi-valued variables are a bit of a problem here, they're built on the 
> assumption that the individual values do not contain a newline, but as 
> they are paths I'm not sure that is necessarily true. With -z it would 
> be better to print '\0' after each value as we do in list_vars(). 
> Ideally we wouldn't use a single string to pass multiple values around, 
> but a simple fix would be to use '\0' to separate the individual values 
> instead of '\n' so that we can split them unambiguously when we print them.

Hmph, what does "git config -l" do for multi-valued keys?  We should
mimick it, I would think.

Another thing that might be worth doing is to see if we can separate
out "git config -l" handling out of "git var" with a breaking change
at big version boundary.

> Thanks for working on this, being able to specify multiple variables 
> that are printed unambiguously is a really useful improvement.

Indeed.  Thanks, both.
