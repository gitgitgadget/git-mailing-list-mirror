Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA35661
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897349; cv=none; b=YTj/pDnT/PHCt+vNzI+hRpc5O2EZ7l3CPXhBXhwqoYHrHeN3tuLpia2h3BGNbalRAUIYIgXQTCuH0Iz0DhvwJHC6dvBAGu4iNLfhAICBEPuvLXDp99WpMREwrz16IuPJEqO1bgotdHOQ62OxLbkru7vJ026nLPrvuMFCsQsKtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897349; c=relaxed/simple;
	bh=f315iA0wQqaaE4yywcJjpMS74SwJ9zMBFvjynmrkBBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bej+tievd6d82mbVq5W1qL8tdPKLwf20ggzDh1xl3HNPp1mfuZ07AHeD27pbdYTnSqIksw6HtpJbo0PAWG4Jgv+9vGc36/kRElpX3FnUbLGzx8w3IMwBrEaquYPHazRGpMKFzu39etnto6QqhRztaxq9kZDgV9/RVb/8fcm2eBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oWw7A0SN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=txycwPtn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oWw7A0SN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="txycwPtn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D38C25401C1;
	Wed, 11 Dec 2024 01:09:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 11 Dec 2024 01:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733897345;
	 x=1733983745; bh=B2rcBsIGAJAggvW7MSkISM041k+mymTev0cB7YS07uI=; b=
	oWw7A0SNXaZ3A6KN2/ez57znF38+rita0CzccT+c844r2HniQbfJj/aA5YnR54jG
	TlrL5GPLerA1uM14VJ4TMqquvW6Z7D6RNo6YCUZa9Hv21HgIDiYZzyvOdk6EjzXr
	CEzyg664A2NFQYM6HLUODzFuA7bWg9WpStyIxQ/awv1ADIc5libcIg/0kfRSbiPe
	ReJPfjnv67K4d8oGCW0xZn2fGtoh1iYkSj4BjhSRVUuhKpNIse25jplSjtvn0Gmq
	pp7yw/LCjZwE4nlQnpMTo1m3G27BTeBp63lcwByapWkOEbec5uC6ExHRy54WhC45
	gJZmeaNZP4qEj4zEApFLaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733897345; x=
	1733983745; bh=B2rcBsIGAJAggvW7MSkISM041k+mymTev0cB7YS07uI=; b=t
	xycwPtnC1mu8+uDQ2qqOZUm8m1XJglYLP6Sjnw2qlb6V8xm/THrNBemirkG+JQWX
	gl2J0Mnwuqga+7QnPYkRdekAeiRzQ/wp6rd7/1JHpMA0BzIFDvM/Vkk/4n48e5nc
	WflpJKM7K5mtQTiRtZEeB+64rZn5MPWlfDDGLGlh3p98x7PHu3eh323si/2Oed8s
	7Pwk1m8X9xZVw9YPaEpe644sUlMLOgYfcnwB23ROhhh09rzNqwUskLjlZb1a6jOe
	JWAZyadsFDvEe0WJrjyyvafTsKxHkrW1Vp7mUGcfK8Q3N6tS1lLUMDSaz6znDJYM
	6DGlBMcq9//3K7APEglmw==
X-ME-Sender: <xms:gCxZZ9tjjuLI0G3SCEWBO2YPq--7VXDNFAKZKJVIMBlGhj12WZnqAA>
    <xme:gCxZZ2diMaTJrKnwnxEBH03DJAZOtryv4UJ2YtIoy7ECy1EhOB7_w2LWtLOyUa30u
    bVsxSEuc-GI3FTVmg>
X-ME-Received: <xmr:gCxZZwzIw0dAFHRLO-Wnp5aBXuoHttlAQtNwjgzy-XOzfPYzd-f2TuDk41fRivxUpd6XMYpWikc3wl-Cc_FeGPeITq7jJrbkREJypwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeelgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhhguggrnhhhqh
    igsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhohigvlhgurghrtdesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:gCxZZ0NhCoxoTmUaReWr9cJFZdrnuHGQX5xb6JcRpD1WYLom5Qu_PQ>
    <xmx:gCxZZ99f1fP_M43cUDbeCyiuN1BWnMqKfRcIaORXcFRr0aGSfY7hUw>
    <xmx:gCxZZ0XIdsoIpPWUCceBjTpq5sPpnudFludBYwgsmCFsZRDwr3BqKg>
    <xmx:gCxZZ-fUutQ0tKciKWUgs1cKetG0Qa7zKv9KTq5X_W82aG13U_PyXg>
    <xmx:gSxZZ2NUZDwKbX3fdeCmnLh59tE4lMjBaLoCmKQsPQ7bj2pTbBgnFhvZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 01:09:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: Roy Eldar <royeldar0@gmail.com>,  git@vger.kernel.org,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/7] git-submodule.sh: improve variables readability
In-Reply-To: <Z1jxSJKl8nwGbYa5@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
	"Wed, 11 Dec 2024 08:56:24 +0700")
References: <20241209165009.40653-1-royeldar0@gmail.com>
	<20241210184442.10723-1-royeldar0@gmail.com>
	<20241210184442.10723-7-royeldar0@gmail.com>
	<Z1jxSJKl8nwGbYa5@danh.dev>
Date: Wed, 11 Dec 2024 15:09:02 +0900
Message-ID: <xmqq4j3akayp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:

>>  		--reference=*)
>> -			reference_path="${1#--reference=}"
>> +			reference="$1"
>
> --reference takes a path to some repository,
> (see also git-clone --reference),
> thus it can have any characters, including but not limit to whitespace.
> I think we need to discard this hunk!

I didn't double check the code that uses the variable, but as long
as the code that uses $reference writs it correctly, e.g.

    git subcmd ${reference:+"$reference"} ...

it should correctly pass what it received in the above assignment
from the user in $1 just fine, even if its value can contain any
arbitrary byte, I would think.


