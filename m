Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF606442B3B
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980281; cv=none; b=csZXa0Zr2lzOP77JVhxE/Umf9ueigEBQ/lcekSJsaKmM5JhdsdYHhYtECSAQfDBN1OLdk0DP0DlmU6nBpIamrcHtZnLM8dnHvOJprQre6+9cy/oTol05ZBNxGyX71SQSrErm5hfc2t0mRxThHEWMaOJaoY6Hfk/HlLm5RQCOk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980281; c=relaxed/simple;
	bh=O0RkHKcTAiB8eZdJTGGqf3PrwLrhvj7DInj6FpK5Z+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rNA2p1LdA7ao8+CTmLXgfkSGZMV1DyM79WTsAh4ftS++s5BLyhPsjSvq5VBKM4dYwGzoxGCFdfrZvUVDPV20p4O/jE5xUjkMv68+SrfgmvFBIHSF8OAD8BwBEw1YYb4R2h9MgiIKUk7z63horTY3e5JMIg+Ih1H9on8KvX8kOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o6FtRgXi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NtFeXeus; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o6FtRgXi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NtFeXeus"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C1C16EC0032;
	Mon, 17 Aug 2026 11:24:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 17 Aug 2026 11:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786980278; x=1787066678; bh=f9jmpX4wJQ
	Okw1BwuE3AotM8qHFvILFRPHWByOH3XM4=; b=o6FtRgXiXBylzrGXkUjdP60u7N
	+q1u5KLyODsp1fbpjyd3LvKKG9+nyN50ZSpdxPL0uoY0knWXYnG/jy9CHBUQmmt7
	6WQFHkRbKy4DKmPNCAdpwotxMarhwfXkSuiTAjE9p7ZU4J/xIVj3zxoAeic8xw4Q
	PgMdx8aN2dFDRhfWz19vTXr+JbdyssPgMuUIhcRgzgoeQ3zPhgBBc5SHQ+H9ovpg
	JlBTGGcS3IPZhgcBTeGxEqL6WX5LjQ+IxALdXxTzoIW2MVWnBg43KJ/hdCGY2UwP
	DHkXyV6JvmReCLC5QYd7fDNoP0N7dmtQx5l7O/i6C2/7AkWen8bSbe0dWD9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786980278; x=1787066678; bh=f9jmpX4wJQOkw1BwuE3AotM8qHFvILFRPHW
	ByOH3XM4=; b=NtFeXeusIzgXP3uXwBTJ/40c5uMYp4w+xVQntMhnxytluYwbG8i
	32bNY2xwre/m/8WCLu05y3i1NYyOjVu9/SR0srnre4EQolTJSXhwuJsmrw1cC+SY
	cy80jiDaj9N24/DUo+aZf7uZ4N0qtPL1d/ztj/i7+R4k6BqEBqwl1k8eKUCMcRND
	Wfb5QhrEX7di/FKkYaBmxtQ0FwnJq8fdf3W1i7IKjM+jIPnuk4Mbqo/FUz7m5VdZ
	+mACQxyL1tZpk1cWz5RmrYXHAmEUS4IPGxnJ1jK6K/LlHkkIAQYmcu2FcnLpQdBc
	SzyWz9ryPpNam1h10yr6F2aehOuvXA0O7QQ==
X-ME-Sender: <xms:tieDagamD6Ae3rFANJ8fCD43y9yi4uKSMdYWWZqniWxkKsvzWujAag>
    <xme:tieDan_7Ju8iIt6tUG_AnuR-rC8MU7oB1I7d5DfiNLj2HLEoDIML8GC0Qvhl8zvsc
    gRSttrCXmvFUvJGBJrUtMnPRTmr4OUmbdUfCM2j3U51uz7ymykTAZE>
X-ME-Received: <xmr:tieDavZnR0jH9oKBjzYIfpGBEZzYVwYMx6eTTC75WuRIni5Zab9L2pZWHzICp9XIO05EATr-8rUbvnrSiFFAPvYMWHaU_pd0aQ>
X-ME-Proxy-Cause: dmFkZTEysG+oZE4gz6hZvpqa4duZG8BWD/PZF6ynaiL1Uu49/tGnoKXAI+cTN73LRFlZ6m
    8FOcNe9BF2DOfOW9JIZHVjXqDtl2P9zbndQ3XJVkLFRyGSsgxVZ0xLxPXIttn+p0PqBUeD
    q1A7a5wPmKYxVLomQqtmDO8UpxdPAJlileKeuJW2cGySCNNlGwPakIzNm072YfDK36zoZQ
    QObD1YQn9heMvEE+ooVUevrrTH+biYI0sVbNAw10UoJCbE578c3fxlWVaYblMTVNmNLOtu
    lmmYCjx6T8zzgqg/6MNm44ugLm6/aOFPiFFa/3yJSMVlnuMVso5g4KMOYN9DWdmjyLV3U3
    yngcOUh8on2h7gqBpK+DWIe+rjQ/168oSsSYFdhRGSYTrFR/dLfEyTcIfyL8WXBsbag2b7
    4VF1+UHW9ZuPUjbqGp3iOFgo+KbymPiV4DnwThOqJt7hfEQN47CYYMQZ7gXvzNYMW4v22B
    87rQHV2z3P0w1lxK+65JQrUIeoNQdAuoWnWWwNvCebwLIsR2bbifd/01o0sBcy9E9/RduV
    K55UcwzfTsTzTe+uOGsExKsLj3tblki2lnn5xjKhYRXNxS8HR50tOgqobnnybOyVjjfZTp
    5ZH8UDP6I26yOk6+XSpJGJ/SHgq769ghxYfMKw48Z6HK5njGsJ4KgVFJCRQQ
X-ME-Proxy: <xmx:tieDahdJC0mlGorAg8HpbexfSzJrPd4obYxKysdQEikfmeg33GpieA>
    <xmx:tieDasmgyux2m2nKmuHkl9AxGhUX-OOWe-dJ9BjdytwdssCJVMCRVg>
    <xmx:tieDah2DCT9IDSjR78HHeyvspvsVBmCGcXclnDtAbe2QQKpSr48n_w>
    <xmx:tieDaldKVfsCHy5wX4ljRfqpRnvll3QEQQ9MWymn4S9khxLfnCRGNg>
    <xmx:tieDauqy47yHWhEHpSxoV4Y1tozXiKyYMP2SwGd795JMq3rdf1DowQkv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 11:24:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Matt Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
In-Reply-To: <f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com> (Phillip Wood's
	message of "Mon, 17 Aug 2026 09:26:43 +0100")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
	<8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
	<xmqq4igyszeb.fsf@gitster.g>
	<f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
Date: Mon, 17 Aug 2026 08:24:36 -0700
Message-ID: <xmqqbjb07osr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> It's piped into "tr" to check that
>
> 	target = lookup_commit_reference_by_name(s);
> 	if (target && istarts_with(oid_to_hex(&target->object.oid), s))
>
> uses istarts_with() so that we accept uppercase object ids.

You should check in with brian about istarts_with() that is used
here, as I suspect he missed it in his effort to declare uppercase
hexadecimal literals invalid.  In the meantime, '| tr' must be
removed if this topic wants to play nicely with the
'bc/restrict-hex-to-lowercase' topic.  In my fixup patch, I changed
it to use 'rev-parse --short' to test at least the "starts with"
aspect of this code.

> I've just had a quick look at that other thread, it would be more 
> convincing to me if there was some explanation of the security issues 
> that accepting uppercase object ids causes. While I appreciate brian may 
> not be able to talk about specific vulnerabilities in particular 
> products, it would help to outline the security issues in general terms.

True.


Thanks.
