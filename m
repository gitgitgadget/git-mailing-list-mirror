Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634151EEA49
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501401; cv=none; b=PbJQnTLC3tsEFtSuS1gUXwY+OwxUf2znJwFqIkKmNfL2Yw84+7m+W5aFHQpcNQhvZt0yMhihHGuoyDafB12gMp8DKOpKn0h0elhzYBkh4hI0cZRnUI4m6YT5aNoeaRugFsGQYV8X43XIF3COY8HxmQv89sinwEPPXaonImUX9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501401; c=relaxed/simple;
	bh=j5pTifEJyG63J66Ma7ujDd9A6mqggYsLieBh9gvmQIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPuFFfOT35/zxbGUdqBXL7TddVGwynCNgADvLn7cvUH8/uBwDTjCa0q4n/BsACFgOiGkAz9k+mY+GTYnHAbC0cmmr0vK8fMmSkfgz+0KG8PJUaLB8duMvL3KakychWBFCkFHJ5bC4kNNry8lBFEKmvlkZupT9aoBaKjPM7Xh/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NcnIeyiG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oToe772J; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcnIeyiG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oToe772J"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 278037A01E1;
	Fri, 29 Aug 2025 17:03:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 29 Aug 2025 17:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756501398;
	 x=1756587798; bh=o/rY2kjSKe521qausEoY+Y92ZY5B3Opv3D3se5FI4Q0=; b=
	NcnIeyiGcmJOJuOYc9pAsvTQ8LriBPzIXEXE4Bxgyhfdf7UfWTyZQ9jkgyt/8TEt
	zLUxcNVtOWc+Qa2izGqWp52GlcAbjWCbPhE/JtVhgXtAWI8qsbhpPiM2/EL5+9Cx
	XFH82E4gjka+lJ7en/oQHeD0tEQA1xn/gG2JT1hk9trkApCSf5nOzba3Ngfeb9fB
	+rIO4NSsOf09CpmaUWuSdgsxu1FKkOY/ix8ZP1Fv7fnr2F8nEgVaDNhkRv6zAa5C
	RT3ocynlnPf9bKo/DdVLTS1fpHymKXNeM7uCJUPtTtguMWC33c5UzmEfqGOTDUsh
	mdVsx8h/LDZYuq9K3Z5aJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756501398; x=
	1756587798; bh=o/rY2kjSKe521qausEoY+Y92ZY5B3Opv3D3se5FI4Q0=; b=o
	Toe772Jzmvk+wtiLUsXyKObp/FlalUcBhmU909mCWvjtjJRpqkvbbbU1oMQk5U+p
	wLEh/4qCt4tmbfo1s0n+ppgz5fk1I3Nd732oOJrgMm7gvAFxFaDvhMg9qCOKzUaq
	DfF87hPcu81fU1s26CsyvENNzk22k+LmOcs921+J4GxdBWYWcwsalLWsjM1j90FI
	nxqQptzdlfoUeRrrJpJH7iJdHNMcfBUBJmEBGlnrkS4r7nmS37GVKRQB51Eo/DlW
	GxyChVh3lZiT8zq0Rt3iYYkCXFJVspXi5NOCcudJjt4WmHUt4LOQqLJSPU8Yl1zq
	9cO3b+R2+7DiVuu5l9eZg==
X-ME-Sender: <xms:lRWyaB19fln_9x9-y4AuNM7fBnbxRK2TUxDeihvCyhfVAvFykt_ZBQ>
    <xme:lRWyaAiuwoRJ_JbqLZ0nYWkirpArEr6v1aSFuM3t9mwcBK_CAp_pPBWRxnSlCBt4m
    K5MHqT-RUMyoJlTQQ>
X-ME-Received: <xmr:lRWyaCW5jLKKfwbL5XrAFJoWhVC1sJcBa2sxU_wF6C6H6IiyBQ4aL51Z0fgFbGVYc7JjyVZxBJ7wyzkLNE7oNnkALKfzrUwNiQk6Lvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lRWyaPXh054_wyoFBQd5lITIz-jSZhuAWIKIU7vD7Xlsxz-16847sg>
    <xmx:lRWyaChyRVCZiIvJQwexqw7u8JzJ2PHcAXwLKK0x0JxkJKQ67wVBkQ>
    <xmx:lRWyaKYBCo376AVmOWNj9PyW7Fv4H0yEW0wJkTeq8RPjqa9lfPAqFg>
    <xmx:lRWyaPrbk4KaWd26Cqh_Oai-390UDm5kWvT5oFrWFKo840XKhXCRBQ>
    <xmx:lRWyaFaoDwnQ9W3vd8S4CHwUzyLdUHtYn4ebPFoMNhZYJ0PxfFDOQUBB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 17:03:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 0/8] sparse-checkout: add 'clean' command
In-Reply-To: <xmqq5xe7q8f5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	28 Aug 2025 17:27:10 -0700")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<xmqqzfbjqbfo.fsf@gitster.g>
	<CABPp-BH=tk3eenHJkbRcD8uLGuakNMT5GkjVt6WfmOO8P+xq7A@mail.gmail.com>
	<xmqq5xe7q8f5.fsf@gitster.g>
Date: Fri, 29 Aug 2025 14:03:15 -0700
Message-ID: <xmqqcy8dn8mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> On Thu, Aug 28, 2025 at 4:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> This seems to have a few comments that haven't been responded to
>>> (plus a "This step looks good to me" or two).  Can we get it unstuck
>>> soonish?  The topic is from mid July and I do not like to hold topics
>>> in 'seen' for longer than a month without any activity.
>>
>> Stolee built this series on top of Ayush's topic to avoid conflicts
>> for you, and he said
>> (https://lore.kernel.org/git/c3c0fbef-f395-4972-8352-dd89af6799d5@gmail.com/)
>> that since you marked this as blocking on Ayush's topic, he didn't
>> want to update until that topic moved.
>>
>> Do you want to instead kick Ayush's topic out and have Stolee rebase
>> to no longer be on top of Ayush's, and have Ayush rebase anything he
>> might do on top of Stolee's work?  (See also Ayush's recent update at
>> https://lore.kernel.org/git/CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=mzZqEvTPovQN9uw@mail.gmail.com/)
>
> It really depends on how unstable the base topic would be, but I
> know Stolee is better than building his stuff on unusably unstable
> crap, and that was the reason why I thought that updating this topic
> on top of the same base would allow us to move forward faster, as it
> would mean that everything would hopefully be ready _UNLESS_ the
> change that needs to be made to the base topic is so extensive that
> the topic on top would also need heavy updates _again_ once an
> update to the base topic comes.

(Sorry, but sent before finishing).

Yes, it may be simpler to kick out a stalled topic and give it a
fresh restart when it becomes ready.  If Derrick wants to go that
route, I am totally fine with that.

Thanks.

