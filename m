Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D85301460
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423797; cv=none; b=ZHDc0wa8uKzxGDGlYAN81OTgP4e4e1yW3mOtnJZmHp7fhVg8rUweVB7b66g3IOBilTpJAYj/tt1iMTCFFNveiAkihN++kfESq4WUroTpELgc4YrfYs/+N5z0p66n42zqtP2rfLu24+dI7XWG3hHxSJJofi4wphVArm72t97l/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423797; c=relaxed/simple;
	bh=RnAv6b6Rm81Dw//88XzFusCuZlMG7h4+XFUdjRFNt1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cdLh6IDFC9pl45G29kgxh9eAG7G5gcDXR5gVpOSLJFIzxqZDdlgvM10yH4+pY0B7v2bp5YjAlvqIojrOSofWnwFAJo0e6uAHU0GO41s3X6WxlhPCg27oyEBFFnt5bKm+SU1FymDy6Y1CVwy9bZHwAEunr90kKYLHkeCb4IyX6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fgHWzQc8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yWRKLnMO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fgHWzQc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yWRKLnMO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 924E9EC0610;
	Fri, 13 Mar 2026 13:43:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 13:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773423795; x=1773510195; bh=g5eMzN3l0J
	0xsRrvxMAKnNBtjAVLoGw3eT7hFjxGCRQ=; b=fgHWzQc8T6Engr7sLrpl2Ninib
	hj+P8fulU3jQdW8l77+FAALjCAosVSVt9GwNc+ZIjULEA3yH09y8ml6p2wk4/IyJ
	Z0/MQhf7rKVbKsmNJDcHZ/QpT+CbmAw4YP8wLq9l/4xb/ZLjJRklPixQUEgwzRvr
	qtTxmvdxYDvYuWHU0B7xh0RF31s4qZ6/o0kIg72VL4Mb/JMtcI9WMi3KsBGj0GMk
	vp/dl+rK/QEEEvIPrwatFASy5ONHm4zVJTiCjh2VW+XY8K/r5nnLUgAV8+Psi/tL
	2umLQ+VVlKu7eEwiw0Kxlys4PQUI6s5SeQViKrKiYpv34PCZzfW69GMKJdaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773423795; x=1773510195; bh=g5eMzN3l0J0xsRrvxMAKnNBtjAVLoGw3eT7
	hFjxGCRQ=; b=yWRKLnMOmGp0j/DWz6CYk/Cmt869CdSJQRfgA8ljvuRwl0Y/tIr
	qDvGx+IR9nLdofN7kxqEoBn/79aG7S4HBAts7P2v0sNWiPFVUTnn3BLbSGdCHh3Z
	+Np66msFJ/zcKSRNjTTDO/z7i/j+/B82pzL2L7QXeS9tcXtrKlb4bI+dSWP0mS/y
	+qbMI8IrFPzyqWXHS/DqmBC7orJsj+cLUnUnBVkdeC9eO9x4i9JJ7fJNez3QYGrO
	sYe1mxaa+6fcMHe3FRRGJyu56o+9d740I4vtIRmVviv7sC0Urd1siTIOGBNKeMSR
	NUbWRnsyUVPXMZHSiJ8pzRB7z5VUGZfEskg==
X-ME-Sender: <xms:s0y0aaW9il8kVLNFPFmNWISlraNXx1EyPaw1fTrJpJV7ALISw11S7A>
    <xme:s0y0adm9v6H6rKOXZpVI0P0PRJWrMp92eBE41cze-uN7ufPsWNo2gABYhgUdejnpQ
    Gl0KEJvLbzdP2Qm12htCOKrTgcqL7k8cjt6PNoM95p2yNKESiJGXQ>
X-ME-Received: <xmr:s0y0aTbZKsOI3SpHJytq7Nrovz3l4mZsX2l_MInCLvjGquvWVP52sNIwG91VBNSR4A8U_eyGYfJHR3j5FT_VdOxfmBtbkXd7yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghhrghmsghrrghhmhgrshhmihdvfeehjeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:s0y0aQMOTYPix5o7NV9cw3lFzvGkrsCyx-TmmBsEVjavNsAuq2i1HA>
    <xmx:s0y0aQbfalRFh8VCpbC-gL2uJLLOAZG7LJiPpqayz9XnUBQ6goEtkA>
    <xmx:s0y0aW2n_hEqxEdihHpmfIVthrUWPIzyly8xdLBB6J2UnbchXjYtRg>
    <xmx:s0y0aedKQNqrBkbDr3kSdlxjlOYFYY9xc94rtvAOkLKD7q8uXu86Dw>
    <xmx:s0y0ae5eb2cUWN5URgWNYr4QP1uNHKv8WPqRq5lJGbCX10SUIztKqpxQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 13:43:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: aum2357 <ahambrahmasmi2357@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
In-Reply-To: <m1fr63zt91.fsf@gmail.com> (Collin Funk's message of "Fri, 13 Mar
	2026 07:41:46 -0700")
References: <20260313133937.562603-1-ahambrahmasmi2357@gmail.com>
	<m1fr63zt91.fsf@gmail.com>
Date: Fri, 13 Mar 2026 10:43:13 -0700
Message-ID: <xmqqa4wb62xa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Subject: Re: [PATCH] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>

The commit title is not where sign-off is made.

> aum2357 <ahambrahmasmi2357@gmail.com> writes:
>
>> diff: use conventional comparison order

The first line of the commit body begins with "diff:" but the patch
is about "add".

>> Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
>> to follow the common coding style where variables appear on the
>> left side of comparisons.
>> ---
>>  builtin/add.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index 0ee21692c2..ad0d6047af 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -432,7 +432,7 @@ int cmd_add(int argc,
>>  	argc--;
>>  	argv++;
>>  
>> -	if (0 <= addremove_explicit)
>> +	if ( addremove_explicit >= 0 )
> ... We also generally prefer the previous ordering there.

CodingGuidelines say that "We prefer a space between the function
name and the parentheses, and no space inside the parentheses.".  

It also says that "less stable value on the left hand side" and
"textual order match the actual order of values" are both valid ways
to write comparisons, and concludes "Just do not mix styles in the
same part of the code and mimic existing styles in the
neighbourhood."

And as you point out, I think this file prefers the "textual order
matches actual order" style (there is only one violation of it in
the file, if I counted correctly, in prune_directory()).

Many things in this patch contradicts the coding guidelines X-<.  I
wish if the vger mailing list can use some e-mail lint installed to
bounce a patch e-mail that ignores our guides like CodingGuidelines
and SubmittingPatches before it reaches the list to the author, with
explanation.



