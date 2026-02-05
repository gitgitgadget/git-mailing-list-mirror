Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54243D4E0
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312409; cv=none; b=dYdFbceZHQX7g++F2il0gHaylktq2FNQUpCIX/rP3hwQl/RZnFEUSYoE20XN8ABTVKkjpLntZ9WuQlDTl0DXDZxDkYV594nOXhWENfmZJEendicaDJIlOQZx3mFWqTQcXR1nfGW/JN1MUSDdsX36trm2Cy1So0LCKDLBU8NLdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312409; c=relaxed/simple;
	bh=IDjdUPITn946MkpzE+0uo6BNdz2uZ1/8jOdbpoQbQ0c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IxpkDTluVb+05Oc+gTCkOaRTFdqPLq+zGyLadK/5XfCCPBsfiINa2fJbcjBeXuYdGTQWRu32etJrODG2n8lWmxdsZP6cHxGLceZxlHMN9dbbCUzsDq+9ab5sBxvjBhWAuc345D0k/PwFT06bk4L++/dEiFq2uHFcCTD3kI9XoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qW2Ky/Q7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pEg7/RUv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qW2Ky/Q7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pEg7/RUv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7998C1400107;
	Thu,  5 Feb 2026 12:26:48 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770312408;
	 x=1770398808; bh=IDjdUPITn946MkpzE+0uo6BNdz2uZ1/8jOdbpoQbQ0c=; b=
	qW2Ky/Q7v+ehLsNGhyjiNcU17yGOqXWQarP1uViif0H6jj055jaM9r7NHA2gzUWZ
	ICSyNPTE8juUztnRSih6Kb3yTrrDWF+lFv7+4KnS+OUy78vZ8a0WSjF/kMTyyrKx
	ccatjS3JbMGRUGEkpy8JpLbrBCbyVxgHFlyYrR04bnTdBua2JcXqhZ1Zk9rpgMHG
	6RCCyHCX6FapVTtdnhMUQ7EPO2qEAVGlf4pONuZAsxB1tx1jvJT2nn6YqfZwCGXb
	PDqah3Zphxyh48PQUDw7sD1B++Our2Sw7o3p6IX2M1xbRcBnMc1j/o0vAJWS/0EO
	esllgiTXpQjwFi6GSo+nxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770312408; x=
	1770398808; bh=IDjdUPITn946MkpzE+0uo6BNdz2uZ1/8jOdbpoQbQ0c=; b=p
	Eg7/RUvhiZcKhD6CqEWyS7m+RM3AHJiLdJMk6eeqY6IcH3DHBweg7+94pfK8B50L
	RSfr1Li8nlyl3ZDJ9omblqsB9Y160tTyfS8f5WoFNOO5G3ChiZN+jEJu8vWyfgow
	MWz3l87h5QnrqG/io7NU6qwYnTcMRclXco7qPehPkom1zUXsrvL0GLRjW7Ow6RnW
	HhkjuugNxtu44sGlmIX/K7P3QYYTS9waqGlnZX7p6NQDohN87tShzqh2KH3tyhR6
	N6bMvvbTNwmQjcJ+/I1/S9JmWkgw7lwYHFPJdVXidA8aujC79mHck3u1X6yp/zw4
	vOJ8ry2EPT2ZBHOsuqaWg==
X-ME-Sender: <xms:2NKEadMKB19b0b1X4I9AD2uSWgyJIyM4Qo4C5ETLabO_7G90elYuMLM>
    <xme:2NKEaawBzJkbQQVIA3l8VRgMAe6tK6dU23ZpBOh89RjSxu8OABPsycjbOl0QkVapS
    N-NiVL9yvG4CpTqlSat1ShtYsOIEms15fpeVbQCrX6ZDOUhtb7xbyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2NKEac22UQVQ5l3jqOjK95GMIfpUlEaAER5elXdJWUjWXIqD_fA4Qg>
    <xmx:2NKEaU4RI9JE_GVxp_JPaPFkasyVU9AX_RVfrSpLpUkb_mjsqxjBSQ>
    <xmx:2NKEafWnoz9GpLUw14_5kYysbf5VE7jrTawxyUgb6QJW8VjMGaBIhw>
    <xmx:2NKEaTDvBrxhOMFyUfb_PBbkydmZK1Z8xZgMcAmltrrmVcHiRy6Iag>
    <xmx:2NKEadKsVmCuGlYPN5-R3NXHu6eSBQKvci-W4n5svUBAYnLgmogI65hQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B9EF1EA006B; Thu,  5 Feb 2026 12:26:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhnYvctSBUNN
Date: Thu, 05 Feb 2026 18:26:28 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Derrick Stolee" <stolee@gmail.com>, "Junio C Hamano" <gitster@pobox.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <a1144600-1c94-447f-beaf-8972cd9bdf0f@app.fastmail.com>
In-Reply-To: <6c8b984e-feda-48c6-b67d-80a41343bfc0@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
 <xmqq1pj0nleg.fsf@gitster.g> <6c8b984e-feda-48c6-b67d-80a41343bfc0@gmail.com>
Subject: Re: [PATCH 01/11] config-batch: basic boilerplate of new builtin
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 5, 2026, at 15:17, Derrick Stolee wrote:
>>>[snip]
>>
>> We have had a bad reputation for having too many commands; would it
>> be better to present it as a new mode of existing "git config"
>> command at the end-user level, I wonder?
>
> Interesting thought. I think we also have a bad reputation of commands
> that are overloaded with too many purposes.

I had a response to that in my head...

> In this case, though, I do think that the modern 'git config <subcommand>'
> model presents some clear boundaries for how the command should behave
> with the 'batch' (or 'server') subcommand. Grouping all config-related
> operations in the same builtin may be ideal.

Which turned out to be exactly about a subcommand. :)

I find the modern subcommand model very easy to navigate. And with much
less downsides compared to having dozens of options for one command (or: one
particular subcommand to git(1)).

>
>> Also after reading patches for a few early steps, I do not quite see
>> "batch"-ness in this protocol; it is strictly "a single request is
>> met with a single response".
>
> The batch-ness is that multiple requests can eventually go to the same
> process. The client could collect multiple commands in a batch and send
> them all without processing the responses one-by-one. This is how it works
> in the tests: a single input file is prepared and all responses are
> scanned after-the-fact.

As a user that makes sense given the existing `--batch` and
`--stdin` options.

> The back-and-forth mechanism is how the git-credential-manager tool would
> use it, because it dynamically explores certain config keys. For example:
> it checks the deepest possible URL for a specific key then peels away the
> last segment of the URL to see if there is a directory-prefix match in a
> key. (This is the main reason that there are so many requests in this
> application.)
>
> I believe this is similar to how 'git cat-file --batch' or 'git cat-file
> --batch-check' work, which was my inspiration for this word. If we regret
> those names, then I'm happy to move towards a better name.
>
> Thanks,
> -Stolee
