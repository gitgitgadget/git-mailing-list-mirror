Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6C244687
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450028; cv=none; b=sGj7ut3MWGIdF7Jb0JW/7zPf8+4kFPCs/fHlXAw1ZkETLEibCuZwTMwAk7CzUMTRTjyT4SSwtZMYVguoeUu6nzWWqq95r55xGp+WId6DMM1HV8yBFf0CJry0V/PaZXqjZ4rEhHfEXrHSiZB+TYvCSi3L7u2wyYQezH137tS9wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450028; c=relaxed/simple;
	bh=HfpdOy69Lgzw68O6n0H53KGvUD7j6X17U75KH5Yp/a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OG/HpjWTu3XgDjt9XWzKPFw30WjQj1bcKYOJrrWzYOsTcKWa4FEOTzwn/8bCa6uNu5S8BNjw+MxmnTSqLASER8SJVW5/dLLtZgDJQisKR8Uwcp72M19V1Ta5ecC4GKBzatqPIlV1CpR828wTBeymM8xUMBrhryfvJuC8Rg6UU0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gNbEtgk5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5ZtVOIq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNbEtgk5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5ZtVOIq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAE627A00A5;
	Tue,  9 Sep 2025 16:33:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 09 Sep 2025 16:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757450024;
	 x=1757536424; bh=AV866sXVqkKLKBTYQotYd9CAkOgRIKxrBM9FE1GhxSk=; b=
	gNbEtgk5MK6FgeAOWkioywtENtRW/ryzLxywkxfMtp0Xz/jnPD4BmUtc3zRxKFum
	Lu4gui6fG4UgU1y8lAjhg4LQdl2TB8iNb18wLEko1xJbU4yjvq9/vEmTC/0DPH0+
	2aaJi7T84ylPVoaC6rQeWTkTVa6zm8r0yVOVWqSsa07d+e7Y9ejAp+xNVixXbdhP
	TT4wYtEIXNki1+Tto3gwA1WQV87EIEJERIKsxHX3kGZadani5W0dmd6LY3tlUOZA
	L8SLB0QmLX2gzFCuh37Ad+M+VmEF2IUjJHo/ji6NUNlBcmY1smccsZWTZHojvbVn
	9ee1RCMggvZt8ZKIKnvH3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757450024; x=
	1757536424; bh=AV866sXVqkKLKBTYQotYd9CAkOgRIKxrBM9FE1GhxSk=; b=E
	5ZtVOIqd+CNiYsejbjP7oBxdlJF39TfpJtRcBAce7x3mE3bgFwWlkS5Mc0ZMdgzb
	DHjpMHIeAq/qnA9gNbkObo0+R+LZLHYeu45TOvLjmC5TzockbaHgUTkVPFFVZC68
	AQrGK2PivVnkAWKmwBSpYK5w8Dbq3TpH+ETXLi/JvVqMsVj+clcZwm+ITv1s3kcE
	pcFm4JfKSrVv+Ih4Nv9yFIL5620v3wLKqpPy47OXS3b0U0OxbtTtXTwVh5Qg99Dx
	es+gA7+IXWYH4gGxRlqZjm0wDxGbIiHmQG2PwSSThgm6ruPD9M1XIMHMnKfQK/Np
	hE3yFj7oN+UC9BQZjMhSg==
X-ME-Sender: <xms:KI_AaBfzublNACr2_WrVhPhFXOJV9QHICGBoFtzi7MJmnhj-xaHX4Q>
    <xme:KI_AaKu92dKMZtnEGIk5okOLqVvP08lXT1yGIUpQyw1VAzGniDGKqA3l_OaKWfZNE
    nOf8n9AuEFKQAhKSg>
X-ME-Received: <xmr:KI_AaA-OYhAGel4nhLv3oLK9k55dwJ8gUTey-DjvKfTR5g-BCiw3GxSmiVbcq-jUCgdw81-PrxlDnd06xXPAOqSBs3NiKLYeFYwwCns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:KI_AaF2zgbJjbcqpdtgDXiZXwar3zFxB0DO-aPplK7HXCCJHgR1eEw>
    <xmx:KI_AaFBGF4yBpR4-PRgBuBIJMX1tudUvER2YzGCEtlIjec-GS9nV7Q>
    <xmx:KI_AaBcYDhdYIWzk916eyiV8AK5G1Pezb7iRDZ-zho5Cygbwmw-l4Q>
    <xmx:KI_AaC4tSpkX_4yfU_eKxpsVQBPWmiAOePEGTEYwgO94BQ8KoiPeBQ>
    <xmx:KI_AaMvEIL2T9hb9khedP3US0pgJnekJftjUksvTqM6gFoqH3r-Q1kZ7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 16:33:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 08/17] xdiff: delete chastore from xdfile_t, view with
 --color-words
In-Reply-To: <CABPp-BHdKu2nsWhpfGY4MexfChxfwv_0mqvpgrV3kbYgdCYKEg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 9 Sep 2025 01:58:11 -0700")
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<e7d1933d1c470528de94118fe9c58b47bcc67aca.1757274320.git.gitgitgadget@gmail.com>
	<CABPp-BHdKu2nsWhpfGY4MexfChxfwv_0mqvpgrV3kbYgdCYKEg@mail.gmail.com>
Date: Tue, 09 Sep 2025 13:33:42 -0700
Message-ID: <xmqqwm67tlg9.fsf@gitster.g>
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

> On Sun, Sep 7, 2025 at 12:46 PM Ezekiel Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> My personal bias is that things like "view with --color-words" makes
> more sense to include near the end of the commit message, just before
> the sign-offs.  Not sure if others agree on that.

FWIW, I am with you.  Certainly not on the title.  It is even fine
immediately below the three-dash line before the diffstat.

Thanks.  I am enjoying to follow along the series by reading your
reviews.
