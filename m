Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D04A06
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427237; cv=none; b=rqa8vkB9r2+OvZvWtXBIa2mT1XjY7DE+LbGEcX/h/3x2Qz+pn9DnU3xgHKZPZpmlFSGjS+uwhvGCCG0/EGr/r/HKDBRF0Bp1LQSl8pxOyg5CMHvRy79N5pvSIGWUmk0JY8cLOAjSP+s/MeZf09Ethy6yFZ3ZUuvq9YavnFVcPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427237; c=relaxed/simple;
	bh=RmG6mvQwdWmROauTKi0XyTCwdJ5ZCkLXKnjTEt8Q8zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lmI2U2kpa0dRD2AnGWSxP8Mh/tyumYiv+R07h2ZT+mrz4O0f1r8A7FXBdVjM7aLsolLFhjykEimPOac40rpkOOOrgLZmppLnoJy8gNgKpapIDZm7+k7nM6Gnsx+yKT0Bt9zAzPbtuHDLC231uGujPLm0PCZ6HXK+cDk4Q5NbpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M9ChS6rR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPQpFUql; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M9ChS6rR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPQpFUql"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 55A1A1D000EA;
	Thu, 28 Aug 2025 20:27:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 28 Aug 2025 20:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756427232;
	 x=1756513632; bh=kqN7Y/Z72FGFrF1Soz3/bMoqcIurPczhV5ITotE9Ko0=; b=
	M9ChS6rRW0YObz5KEzC+LIIZpLdL/suJJ6+vzmlmPEqwDPEPXo4XDmmJ2lchclnN
	rnxeX79TLz+E2QglSCi4yLTaBSK5MR8KZaot8riihlF1b3lrzbgKeQk1hQAyrMKk
	3Pcd1zUslEdLLqPiAXO+9CcZtJlxCjSa/Uz/Oo7aRZM1doRz06PPcJ5IE+E/RfuC
	U46by7QKoaMTec8nk3VjpfVEW+2RWpM9ibxegqGv6igCer7C0GLAZfWEJI7bISTZ
	vV+RQCHMrY0XUxkwbHrv02ac7fE1xteE3Q/JNxPghUzxdxidJ/v/xU7U44E6QP7a
	+zTcfv47IhCCtfOcQTntmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756427232; x=
	1756513632; bh=kqN7Y/Z72FGFrF1Soz3/bMoqcIurPczhV5ITotE9Ko0=; b=V
	PQpFUqlDXx9+HArGZ4IDkwHH5Xy3aJHvNVxrB/XqES6cBc6tYaYrPyn2CYWkC9cM
	lDyv7VqlT5N84Dy9FdfJtNgk4SG5TrL4Iafq/8DY6OyaIlRt6dHocBJyyQo7nJxe
	qBdRC7JANGQsqZAhpNCTECu5Vab8zJzowsTua2DBw1/xix86gTeKkPGvvRBatdCR
	yXBJQK4dEjrs9PsIqwC1C/415jeym/mDKfSSSOpIFlFvz6xsFGhnsS6DlXc1nWFr
	wh7YGD2KwXF+jDksXMRosG76ef8HVbQOhtfERPcskOAb/ziaiuEu67He8dWzvXzE
	4RcN+Bi0NgKFQqu1Xf9Dw==
X-ME-Sender: <xms:3_OwaE_S4g9NvUwtc9BDADdk35BBNYj9mWPu5TV1XlDbUHqIa6uFEQ>
    <xme:3_OwaFLgHTgNRbKSrYzFcNjrEHXIflMEa9tiUxLlblbASNjqzeyqH82WoxXdSkmRx
    2u8f4CdNP5kOGM24A>
X-ME-Received: <xmr:3_OwaKeex4dP8gZZoOuwf4Uga4mTbwUSr4asZD1GR2L25WPiD86NE_idQ_bbE6scB5Qk6JqZngnQY1wGbdVPTTjGAkIMPURKyy0tZS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvgeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3_OwaE9m8qJRUvnpbwYDFJBQALLwXtvVcNf5ke3iBACE5hLNhPoVxg>
    <xmx:4POwaHqoJIvwJ9ubKL1wxSXif-iXCuwXZDA95s4XNSL_m2NgOcOweA>
    <xmx:4POwaJDOeVhRpni1T2NZ9-aFsttHXJ_mC3hvXfM-Aqr10zcZVipwGg>
    <xmx:4POwaJxXAGd58OGoPL_iE1K8SpU1grDxNosZenGLpfdi3qM7YBQ67Q>
    <xmx:4POwaCg5IVGS7jz7LqGPaRdp7aMFMZjGY9MjTWDBkaseh7fFh0V7G-AX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 20:27:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 0/8] sparse-checkout: add 'clean' command
In-Reply-To: <CABPp-BH=tk3eenHJkbRcD8uLGuakNMT5GkjVt6WfmOO8P+xq7A@mail.gmail.com>
	(Elijah Newren's message of "Thu, 28 Aug 2025 17:15:14 -0700")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<xmqqzfbjqbfo.fsf@gitster.g>
	<CABPp-BH=tk3eenHJkbRcD8uLGuakNMT5GkjVt6WfmOO8P+xq7A@mail.gmail.com>
Date: Thu, 28 Aug 2025 17:27:10 -0700
Message-ID: <xmqq5xe7q8f5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Thu, Aug 28, 2025 at 4:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> This seems to have a few comments that haven't been responded to
>> (plus a "This step looks good to me" or two).  Can we get it unstuck
>> soonish?  The topic is from mid July and I do not like to hold topics
>> in 'seen' for longer than a month without any activity.
>
> Stolee built this series on top of Ayush's topic to avoid conflicts
> for you, and he said
> (https://lore.kernel.org/git/c3c0fbef-f395-4972-8352-dd89af6799d5@gmail.com/)
> that since you marked this as blocking on Ayush's topic, he didn't
> want to update until that topic moved.
>
> Do you want to instead kick Ayush's topic out and have Stolee rebase
> to no longer be on top of Ayush's, and have Ayush rebase anything he
> might do on top of Stolee's work?  (See also Ayush's recent update at
> https://lore.kernel.org/git/CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=mzZqEvTPovQN9uw@mail.gmail.com/)

It really depends on how unstable the base topic would be, but I
know Stolee is better than building his stuff on unusably unstable
crap, and that was the reason why I thought that updating this topic
on top of the same base would allow us to move forward faster, as it
would mean that everything would hopefully be ready _UNLESS_ the
change that needs to be made to the base topic is so extensive that
the topic on top would also need heavy updates _again_ once an
update to the base topic comes.

