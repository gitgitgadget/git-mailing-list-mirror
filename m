Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAF3890E8
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038390; cv=none; b=K8GUdniY0WC2GfBYU0GF2UNNR/zBWaEyedbg3dne5JSNo+TQvRGvyb6IlKwvhOKCYZgbg5GNlg/MJPW+5AIlVLoMz38L6/J0nNfB0+RDdOg3g2aMM1XPHYPT6BvgUdTrBUvnJqIksy+/0WVGuEPZxT5JZDD5nsJuMdXsj9BBh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038390; c=relaxed/simple;
	bh=FSmYtiprjRwOVi+oR2JniodckqvqMIXN5OEs87oFHAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T7/WSFht9tzaeZXYEueyDZfF2Cg1KwBrJQaYO/nbMdkltzucRxPcLpFDjWejNqFfDmdIVbPdzC8Qtlr3XT/D7lfEfU+Aq26RLCGGl6DCXhdtHBJkQoQGG+BzNvk6DpmYcJCyoplhwr7lyA1md5CxN3aWtW3LaeahSF8CZQ37UcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OJl6Sh5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LRIkhppI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OJl6Sh5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRIkhppI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 84B061D000CF;
	Thu,  6 Aug 2026 13:46:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 06 Aug 2026 13:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786038388; x=1786124788; bh=dxnt5z6E1I
	uqZzDmUS8DA2mGW54+xvXWcJhLhT1bwRo=; b=OJl6Sh5bTrn3/KeKAVUPKr0Jcu
	+CUKZYBD7eJVjJ8MFFcCd+9DBW2weYTXHR1NbRFGykRwrPmbLXtROQp1I18CdsCK
	oc5J5uMRwfEhFeq3v55NW2vMAq7d0EnFwYbk6N854rK8JAFPU3ZD/jXTjBVzI5kz
	0uAKxx3FZA5q1vJQk/mY8qy49M8X2P6uipCTXdzCa61aaELrgw9Rfc5T3LlqtPx7
	3BGRdvuxP6jLTPC2HNxV1nZsgZGjOSfr4sRrxhnRQpSxK5kdKXOZhS6hCIOu9uHm
	YH4+qPJf4CH7Ebps6qzdVgV6UDAgXXPjG2cRROYrKSJhfDq+8hAH88ei4p+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786038388; x=1786124788; bh=dxnt5z6E1IuqZzDmUS8DA2mGW54+xvXWcJh
	LhT1bwRo=; b=LRIkhppIYo9MvIxuNcqgC8rIY6AxNpKaJh4z29YartIvHoOBJrB
	tzX6PWOGumBmi1LSmKDkuivYMOry1V9j4cPn8fkFqArsyYOVFoByW7FQ+2I51yLR
	CnGDxEnH4WKD6BNImPcyPCMtnB/VepH2ccbu5P9lj3RfSe4k1k1rgH7vbhQx6jEt
	vg776nyhDx8ZqI/CMgrDAdLRt+24nchlacPKSfZ5jRX8EIl/3pgu0m+15kbaHYl9
	DJBR2UT/WU8S3KPlR7qQZr9xCWxXE7RDUcwrIYE0m34Y3NhNTHne6xnZUhze5hZz
	3VwONPlmNqFbMXmd1s9bR/346cb2KYUikOg==
X-ME-Sender: <xms:c8h0amc_mz13crSZ3TbIxXuyPlNMAZyVHa_Kiscc6a7hPn6VT2EIDw>
    <xme:c8h0aieN0nm7UmLQi2mSnVNoHWa4Kn77tr8YFX0AQNYvxBK2Lox1wFkhdiT1jJO4s
    l0zBjdrJwx8atLHWFcTV04ARDcv-O72xAS4-iMc3sMXFRs9kNxdiPQ>
X-ME-Received: <xmr:c8h0apz_ruYwCmQpqxvuiNFoErFXFKiKv07LBUWkhSkHbfm0I4SK2cj5MXY2t9YkjAVTkiyVdinCbeVfgmcK81qPpkIrVB8KIA>
X-ME-Proxy-Cause: dmFkZTF1smQbdqdpPpbSXb4U2Q4N50of/EWn5+FuM+QZC9claVvinQR6dgzjC01loZm8Ut
    ZIt+rMdPPSMcZLNfo3a87vBx6Mdqt/DPdQTmSrLVJSdcHvGzPYLWf/v2/Ak54yihjxoImn
    wi4aEVzz165wzpzBKOdW/Op7a488Y2EjbgD2H12DtLOvnkQs5PYdqaHJWzVHLzqcVP5kZG
    vk4hAgHx+rG0lWZZCl8oQdO6fWMqKRXFl7/k1qBd5gDO6tFvhE/+n/IjgIVCh/d/KrASTy
    QKi75b144Qr1F5DPVZpJ7T7NeEQmMxs/7f7Oy6JlhinSfWsy68cxTPHG9Qf4srtXeJAZRG
    yq/8P2XxBxkHy+4wp//qRZVl0xw4uubHT8X3dZ2+gXKMxa7ngdWHrOTqgu8HC7gAN0/jcF
    at7mAascv2PEfFslG9dyPxXd3kdwKQf0YiKDA15FgHsvgdAge0MqcACFIOvKTspjr1fBo1
    lhaVK6/lykpKqjGbWK5u+v04IJ8esXYwEc38G48cufnJpcsXVUwywx1eAh8Q99hyadh0Kt
    +GUpEIyeZzvoLS1mE898HqF801MysmdACLLmxtG1zZKhMHQYINfrMXOaQ33XngpD8xhKD+
    pApe26xZ9bB0q3SbpssiiRL8EqKIWrnx8i1rMZYV65skQxPOlF5oBVBg9epA
X-ME-Proxy: <xmx:c8h0ap9rqOzdBfiHebJks8_E_xnzPXFIcofOA9c3DgPQVL9Owuyh0w>
    <xmx:c8h0ahiBr3TbJyvlqemLwteo2zpSNnnzE8lHHtNQwkAFg_w5YeE5xg>
    <xmx:c8h0agHnIoF5RqHXETRBdrJ8WWHKUxSFphO1ENNltvoWyyA4BeDbqQ>
    <xmx:c8h0ag-dLZ6Z6Tb5PPZTmKP5GUEulNEfoW6DnPmjbTDHsUk8xHoI4w>
    <xmx:dMh0avrMzwnooVoc7GDwkuvn_0SSYJEqYO2TbhFnkrrOLPPc4SHekbWT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:46:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v25 0/7] branch: delete-merged
In-Reply-To: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 05 Aug 2026 14:24:30
	+0000")
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:46:26 -0700
Message-ID: <xmqqcxvvjg5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Delete branches that have already been merged on upstream.
>
> Changes in v25:
>
>  * Wrap long lines in tests.

The interdiff looks just as expected.

Shall we mark the topic for 'next' now?

Thanks.
