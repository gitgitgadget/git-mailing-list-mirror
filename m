Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80133C01
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047389; cv=none; b=eqHkgg4w+yDUxTFF3pL91olv1ZlQdM+Mf1gdS6LAdtIvpRsPxzSE0DInLQD6k48vhp9omtaJalT27+R1WsjdQnEYdDKEwhbLb82qg5TNwJgNLIn0URoxG8cJa+9hWLQo7T4dY1xRYQ2ryOo/5Z/p88D2Gls+VMDF7IC3U0bD2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047389; c=relaxed/simple;
	bh=otdYETHe5KtDq2LYT+YEKuwb+hLdQQ35QA6xBChXA8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gs6XEQakyicL/BU+EPOsMOZ4CXvK/2H6sPCmo7s0+qidoFymM1TPtSfSoE3rMAXGr3FyJy3UjVJ6GXNE3R5SUT9mxy4AJAULwvxUaO4rzFj2FuEZXj2RsWL3/6RbN3lxXgMfM45q9Uy/7rGWpl1DaFNc9Kb+Jjnx/n7GzG+ESh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YXXMpp8y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQB6On/h; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YXXMpp8y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQB6On/h"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B92991140206;
	Mon, 16 Jun 2025 00:16:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Jun 2025 00:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750047386;
	 x=1750133786; bh=XLkqgCBxuUD/6MUv1+7EAECLDX5x4XkNJSyuRSadkKI=; b=
	YXXMpp8yl8FXjFsiqWgR1ZNhZRzShx3FwC0InSkuPi/NgvPVin6CnzyQ8+jsYRhc
	UVrHaIJ1DANtHxGjSZ/EAvyi4uNrgPrkLQggL42ZXmE53lzZOIrZvDtl2CVvbevW
	Jh3WZAdIUhghP2/l4vW7dHX0RuKlFYJm5QNUQeV1ZHFqAu6l3xZpFdVkwsHIVcHB
	Z5jX+u2CjHT0a59GP323tPxQt4lrf/ZbLe8o55TGk/E8SZN8zvWsjoZjP8Ku4mVR
	cb75M0BbabO1PVsNjohEtmQbHrJ8RbQXV8qGnElwOljB5LeDcI6GB1NTFKIEg2hi
	4L/84f8iOOlBvu3xj/41Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750047386; x=
	1750133786; bh=XLkqgCBxuUD/6MUv1+7EAECLDX5x4XkNJSyuRSadkKI=; b=a
	QB6On/hic71p1FQuCr8I1gW+EHhVi/RzLV/5vTjx8aKa5IvsM6v3ihznDsbOS7z9
	Qrj2WApzx1AieWijuKrGfpIupdeC17gb2m8c3nJ+BRQOnkKFFSqKnG9YX8QfUQ9n
	XhaGzKstISVddJ7mT4uro5VTVJ1WUMjX/TgAaUo19qTknyp/i0MGV0252pLtZWFE
	0GFcCLqdMsLviT7cCgkrVQXbRIMVi1Lm6ItrmEmUhg95IB0d3FtpwpA5sNIvE8x9
	mSLOb+Us6TwooCYsuALTV7KAdUglJMZlt9nxUvyyaM4tcoarcvohznC5nZ9zs0Ft
	Zi8c5zpI9kf/YIUda3LdA==
X-ME-Sender: <xms:mppPaJk5xEIsQAVmxcWDXZ2pQ7Ft-LkAjYnUZ8YnbVgThxCTTXCjFw>
    <xme:mppPaE0YTsgrRa8z5VQIRlRl7zIGpqOG7s7-95juG8Nq1wY28VjlDGTciWFCC3npa
    gfqOhT7zAvoFr12Qw>
X-ME-Received: <xmr:mppPaPrecZeMRjsQkx_y5pYPH7fQr4mHAxVbeYoT0LnGW8_ef8tPo4Am4s6_CGE_R117Pqn6UykgFGbSsNGQl_z8T_j9_Xumcdve>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrsh
    esghhmrghilhdrtghomhdprhgtphhtthhopehrohgumhhitghhvghlrghsshhisehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehitggrshgvlhhlihesuhhsphdrsghrpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mppPaJn4K2nOlWj23x1MrNj1eA2y8VeRTOPnby2kS5WlKnOBpkprGQ>
    <xmx:mppPaH0TYmD-r1ArAh4g7nG6oe4lynOpZwD1DIgmfLkbipDphhVGYw>
    <xmx:mppPaIs2ZwV3xGUjVyIZk4_sP5gkaUiCc6Fu_xlKRv9r1BD_GVTmpA>
    <xmx:mppPaLWstEwNxngTA-Ht_ZGQwls7ByAUjeuOcxyqUj3r3sKCYAVUIg>
    <xmx:mppPaP4LxGflSg6QmMqOWKfsk-riEuqHSl-goOMjsEzuin5SZYF7WF9S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 00:16:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: Rodrigo Michelassi <rodmichelassi@gmail.com>,  git@vger.kernel.org,
  icaselli@usp.br
Subject: Re: [PATCH] replace 'test -[efd]' with
 'test_path_is_[file,dir,executable]'
In-Reply-To: <cioavyfxwgdhfzuodb7dnwzmvsui4xcxi6mljnlszjwebogajg@taejma43hgtx>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 15 Jun
 2025 20:53:42
	-0700")
References: <20250616020827.10820-1-rodmichelassi@gmail.com>
	<cioavyfxwgdhfzuodb7dnwzmvsui4xcxi6mljnlszjwebogajg@taejma43hgtx>
Date: Sun, 15 Jun 2025 21:16:24 -0700
Message-ID: <xmqqwm9c2uef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> On Sun, Jun 15, 2025 at 11:08:27PM -0800, Rodrigo Michelassi wrote:
>> From: rodrigocmichelassi <rodmichelassi@gmail.com>
>> 
>> 'test_path_is_file', 'test_path_is_dir' and 'test_file_is_executable' are modern path checking methods in Git's development. Replace the basic shell commands 'test -f', 'test -d' and 'test -e', respectively, with this approach
>
> Splitting this long line, into multiple lines of about 70ish columns is
> better, see the relevant documents in Documentation/ for useful suggestions.
>
>> Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>
>
> This certifies that you are the author of the code, an therefore should go
> after Isabella's, who might be the original author which you improved upon.
>
>> @@ -474,7 +474,7 @@ test_expect_success 'local clone --shared from linked checkout' '
>>  
>>  test_expect_success '"add" worktree with --no-checkout' '
>>  	git worktree add --no-checkout -b swamp swamp &&
>> -	! test -e swamp/init.t &&
>> +	! test_path_is_executable swamp/init.t &&
>
> this is not acurate translation, `test -e` is true if there is any "file"
> with that name, the equivalent for that helper function would be `test -x`

Yes, "test_path_is_missing" is what you want here, without any "!",
to make sure that the path does not exist.
