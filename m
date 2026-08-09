Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAC3016E0
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299558; cv=none; b=GuBpr5eceJ5mKHYQv3Dd55cqoH5VED9Zdg7p66a//BTNL9M4S1DIgdCioBKsWfMEPir6gtG1axkeTKKlEBoL6PGSNWriDtjJpvvZEKvIHVItNXDDtYaRhzqREvuqEXLeAlcQ6LgcZDUi4qRNBg+2nHavs4xKkyeKC2iEISDkP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299558; c=relaxed/simple;
	bh=0UlMVd9+p2LOWaCObcFaUpAG+TH25DXE9yPJ5NQb08Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pX7FmHACPGhL0nBM3pPf0R+fpepu4YWR/02boKVRXCqVCu2NTXJV9bW6ZrydEedE1C0vm4O5WGxA9j4GP9YmlLjAIKk7jQmSybtqaDWu9EpOD9qvqP9mrjNPZ+jdfZoP5i1Hz+mc3vGBJ1eSaHNE4B/ISpOb+S+R3EQG5CE3nMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lk5JKwxV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UD3dMUqk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lk5JKwxV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UD3dMUqk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C5C5CEC00B4;
	Sun,  9 Aug 2026 14:19:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 09 Aug 2026 14:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786299555; x=1786385955; bh=qBWQ5MYGke
	n+87A5ezCV9MWlibm2vkD1vYygpNXEj+w=; b=lk5JKwxVlFJhq+/9m1LfngEhyT
	/z9iYEtJMpjoLqhKuwjDw6cTnCwWa/Jj0YGpWkER7ykZLu7ZXN4eLJtsEd4jdD+j
	b7j/Z//TXBPXsQiYPr+5BxdNvcqFRbLmmAWRtFBdJa7ccXxCO7QzVo6r4sr4tSSG
	nyDEPbZN7ZWiN6HnwPlY3qFBZtxqOgqcUdqvxr1NT3JjlF64hsh9WrGXu7ml0Kfn
	Xe/Gs3OdL+2CtYn+vJZF/LnFTlRdIsVDFDCPNPAcpOnpizIY9C4889EoF5p2sn5O
	By9RacWFvMwlDWC7WqupS3fvu8UK4x7tFyqDT2SzF/F5ThPy5GNHn0zt5xcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786299555; x=1786385955; bh=qBWQ5MYGken+87A5ezCV9MWlibm2vkD1vYy
	gpNXEj+w=; b=UD3dMUqkgCK6AnZV7P8zRO9g27s0+U7ASwPSZtOjWB3MsXrGkaM
	4TmfFpuU2wqY9ulZHFIa+5+XlO0vt5oxzj8j18QzDnEyxv5LshCa7/pwMHJddZBz
	1gppauXqes3vec6WVxI7COwGRzN0FLxL2FN8fqWBqSlcKX/AUFlbPkMopbKC2G69
	xaONwwWFzU4Y2qWVK19HdT8IE2yLiQZ3P79LpTlvl9HC2tKtw71g8hAnSeVyUmDd
	hPBV+sE1nOnQHU7NPnQxeE7YsLcpx3D3wNvvwxd+SRFx7xlFJ2i+de971mrAVH1X
	gw3u0H3Tzl/LKFwM2gnnPV8KcdspOJJsVTQ==
X-ME-Sender: <xms:o8R4alRugJgc1VGXmyKNARD1vm7waWtpYMOELmhXM2SNm6dB9L5vvg>
    <xme:o8R4alpYa_pksBb5ZNs9MCxhXjzkH_8MUew2ES_mgoLU_cllmNLZdHjfp0Zz3Ihh1
    40MNGPlJr9s64HeUYZEHSxjIm8FfJMLoAWmm_nuiWdPWnkekK_UATo>
X-ME-Received: <xmr:o8R4ajINIDMgeMgO6XBcpwtNll-NaNVEBtFyKGvXcuAJ-pTwEgKYWyvhT7nY3-gQupcQjmfsZQohgVIEeA78OjMpHjcWyWJvxg>
X-ME-Proxy-Cause: dmFkZTGs9e5LmlEJIHb3ML/UN5VqG55C5oCgT1Da6Jp8eRSYLkV46bgDwqCwLkhsn6gnMV
    SMFBDppUy33aOGwM1NAkk0eLe2dikQ8L13AIk9STqhV3hvHvXeV45AjdV1qM8ZcOVCisSj
    8syd2FyEKfwnx1MoHD0mk8wQmcZCbLJGE0ME0aBg8BZmO54Mkb0TxXLdudG3aGoX3dKD8W
    Ul/zVHRw6CCyf7B+3b07tHqdH73xdW3Jc4KzjHVxnaRG4e3ItikzLnXas6zlauJtaTX+Qd
    Rov8cV9ZGPZFeCX6+RoQgEQK/70pEI0xIve8O0LJud0LFIBrusRnjLyr6+UPw7UlmRznqC
    QNVmq4ipEXJ3o2IlDaYxe4sCdH7kGrneWaxWxiZiU2H9KiFXrcncZeyvANwUmkX9Zg+8bQ
    NGkeDRX9cHcS+OdD3P0elQtY+AB96/0SAS+ERZq+2Hg8xHNsoae+p7CLQ69cIfCnpiW+SI
    L3ic74ohNIP7t7KexdG/MAFj/iPN6z9RUFpDr3DCFpOCRLegrUw4eFyAMNxwvAo8+hv0Uv
    +0AOtJeTMZWpiF4WkznHRUhRc8p8F05Z6q21sdzZxikAmhU28xmiAZaESi4+ESatSfYBWI
    xGFIPRTbeWwP7ZQ/VS0AaTo7MXklIqYBQGbvcyIw9ZE4gvEi7WI/M3jBmBdA
X-ME-Proxy: <xmx:o8R4aoq0OZwpC3ekDI69VVGZ4B7PWLz0x1RV7be5RANXFctXQaBHxg>
    <xmx:o8R4aryXE616_lQltYTos6duHmK2oRobAK5_vdh8n-4j43CVg8xUlg>
    <xmx:o8R4asPc9jgSOeIWBGwJs8Ft6VHw9KbhYayUAEImx3E16h4Q2P_fog>
    <xmx:o8R4ag55cP8EqFLyH7_NvN3pF1pWA7mgPRrSWhg670XjowcUwqz4uQ>
    <xmx:o8R4aj5nCd565RBtbrWKxMwlVdG7Zzc5rQ3AgiysscU_pAqGN5hqIGlu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 14:19:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  yoichi.nakayama@gmail.com
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote
 branch name
In-Reply-To: <20260809074528.5189-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sun, 9 Aug 2026 09:45:28 +0200")
References: <xmqqo6fc9swz.fsf@gitster.g>
	<20260809074528.5189-1-haraldnordgren@gmail.com>
Date: Sun, 09 Aug 2026 11:19:14 -0700
Message-ID: <xmqqfr0n9mxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> This is an interesting idea!
>
>
> Harald

When expressing your opinion on what another said, quote a bit from
the message you are responding to so that people know what you are
referring to.  I cannot easily tell which part of what I said you
found interesting.

Thanks.
