Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342102D2483
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754689; cv=none; b=OdmDvqvuruMdeiwrcr+MXC0JJMmemptaoXPUUbNSkWCe0l6BUTbTq6gZdEZpJDsrsBJikWZresQLt1ow/M07fxW4teHEXNEOmPMlG1LCh4Zoe25bg5yTNQlaYRDq61q1y3yQ8WHE79oQF4f7V3j7R4SWxA86vqORDzwrrb8n0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754689; c=relaxed/simple;
	bh=VNVR7Gf33XfW/6CQc/jqLS6J2WdasPwXx+fXQsW+ovY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jc4JRRKdJLLKUSSBhlCOIxHrY/0Jg+lNjqkRDnfFz3nQ+J19oZvPZkV1cIT78Q3HoU07J/Ln+M3tdlzdXix1/iT3VOpiXMkDwz0MyYdT4uj0/2WN0JkCMqlKsNdioNwme/KxjVXXJjyttzO4xqrKAIH4ABjR3Ehf9PhyEcfIlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KPsi403/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeta9wFT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KPsi403/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeta9wFT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72E687A00DE;
	Mon, 29 Jun 2026 13:38:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 13:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782754687; x=1782841087; bh=ROZaSrj4eS
	zi1r6/2jcyF2YD18xYJqble6bw6KOWfo4=; b=KPsi403/OZndKiHUBhKfFQswlB
	o6w8wQFTcCeJT78xw5wTz890lXV4HnP7mfi8K0ksMMedEX1L0XOvXqnB2Y5yNgKE
	lwY0b0SyaHn/7NREx3aFvEEOdGqZk2XDt6gG2aBpID9CeZ92txDkLPcN385487XT
	7AilBclt0jUgMhi15T9nCiG3maEbUSDzKzD16z+xoLKzxEfvcFceTy9yQW6Tw/7I
	HMGSk6RJqmx/qUvvI1xhu2DRw0BXeP3eiDVqlxlSdwPAcNi6Ns2DlArpTS7CJd8J
	YC3n6KEduH8h9tg0ax+nT6qp7mKdPzdVZwSFS6hyrR5oj7tH34dVC8TL3efA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782754687; x=1782841087; bh=ROZaSrj4eSzi1r6/2jcyF2YD18xYJqble6b
	w6KOWfo4=; b=jeta9wFTj8zA3CWgcqUHvtTPlIQQ5wq1flhhyc4Ch3p7wOxtyzJ
	VfU2szyo/sHPPrbOYorrtH1Q56umDyfUBJZ6XKzL1UBfAx5SZf+lLXu22FJBQ+9p
	BXqKMP6bNr9R15TmNJCXszFBvtoocLNKYXIsT3tSFTuBQEps4dZFLd6CuQ3OtlNx
	49dmOeoBYIdXfYON9N27ROS00ddd7UmNCkJ4OLYD4n0Lrmq4x4b+pp/4gRbNS5m+
	V66DDHUnNUQKN4u0S5RDUSdzz3fRuYenVmittzT52eNqAHgwJJ6OKDTd78DL5IHe
	XX9Xuv9IXtCe3Vd1l5XkOWIA+CaI9Be6gYw==
X-ME-Sender: <xms:f61CaiK0mcqdI2T1_EVdtcC9TtJ8EOCNH_bgjnz5dZuRO17ZthDu-w>
    <xme:f61CahL_zkmRs7gq4Le069n9cdrD73BNQYkOta4mOZ0ICOx9Ibz-Q8Cwk4E5Ve6Rq
    -k0nXlHd4Dbb_Rng9hQEJ4fzNn5WCjyCctAcih61CzvVGi8Lj_2SQ>
X-ME-Received: <xmr:f61CanvUzpTfZFA36soiWPDAyT8AgafsNykW5JXC7cpkSpHjmERQuXp4sOdhX8LQydImfgF9ZERYWSMJw6YWvum5sosCWNmZkUwd3K8>
X-ME-Proxy-Cause: dmFkZTFAEMmduZw5EqcCHFnFjRL+Bw2JHFyQyEQbmc9usmO2yGQvbKfacssaPXZ8sWU4vz
    FSCxPqzu9Z/DuctWW06ZZH8y4CcebhliqCzV+Sf/ZCFAf8jg7uXLW6xo0YI4sDvPT8XAT4
    I05ydSNV7MTFh4gk0mnf95018L+Kslqxcf+eE4sN+0mgkSrv3dv6aAfeSfGW3oo4uQfGqh
    Uw5KPqpHi2YxDoKN/s0Kg9p+GotVu28qSOqEclG+nSAEYeFREDGZZ0SfpmdBBGsXTulSQU
    Kc5q/mNEvBGFzRfbwOjXkL6HPfDSFD2R+qIFSeIie4TqlVTU48jNMTh34EwVo/DH/WyrE2
    4TXRuFPRjhUEFA7jnD9JOsgYg+NHLuAy0riZndUUgwHB1Bt2ArWVGHKD5QD8NpymathHAZ
    AsE/icHOBQGSYXFXWMAcuv7DgS/2ok9SE2jsiGgYcIhFH2FZI00l6G/avGEIGXfguoEovo
    KrbBBcwHQKKqsKks6/OzEzvEueQXXP1YAzkqHWyM9pVOKL5hcYt6JoP++kd8MBDRuCvAqN
    6LWuF2kWlR7TCbsZGEeKxUUMnjow1s37qtSHBfpmVukV907PYZ0Xzbv9I7DOOeTHBDgc2V
    //sHzlLT8dGdAN2AYHVKiElD226+YWKYWsHyqR+D76lkLESz1nEr1nG8Jhcw
X-ME-Proxy: <xmx:f61CamQIe5MubHW1FPb1TkPF9J9yyoBSplOGmRA2P_4F11Efbj4ADA>
    <xmx:f61CalOgXXZ9sAoTj0D7u_cgsYzeF8DW30A3vZuEq5bt3VKfn9q-YA>
    <xmx:f61CajYjApkN2Hl5NFFFvVsFP6uXPf1mbobrRL7hPO__C7a879mTxw>
    <xmx:f61CanyVPuMdGb6pHs1wRK25a45emKVRiEYRdDnkSmehmscwbclx5g>
    <xmx:f61CanNCP78ZKNzVzZXVr5hWaE8kM8VLO6ypwjg1Ez5R5nsQT3Yj40qw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 13:38:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v6 4/4] history: re-edit a squash with every message
In-Reply-To: <xmqq7bnhz9jr.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	29 Jun 2026 07:49:12 -0700")
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<4edf012b77fd2f2fb2a51eb10863bbf852fffa40.1782635349.git.gitgitgadget@gmail.com>
	<xmqqwlvhzyhz.fsf@gitster.g>
	<CAHwyqnXXFz4z_ULUq7Oqu0ykwpLJyEyW-uoF2bKfoYZQAjrNdQ@mail.gmail.com>
	<xmqq7bnhz9jr.fsf@gitster.g>
Date: Mon, 29 Jun 2026 10:38:05 -0700
Message-ID: <xmqqpl19w8le.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
>>> I doubt it would make practical difference, but one thing I notice
>>> is that unlike "git rebase -i", this one does not intersperse
>>> markers like "# This is the 1st commit message" in between the
>>> messages taken from the squashed commits, so it is not exactly
>>> "mirroring".
>>
>> I wouldn't mind extracting that logic from 'rebase -i' to show it
>> here. It would be nice to have.
>
> If we can share more code (not necessarily the exact existing
> code---after cleaning it up if needed is perfectly fine and may even
> be better) across codebaes that would be excellent.  Thanks.

After looking at what Phillip said in a side thread (look for "So
instead of ... We'd have") [*], I retract my "I doubt it would make
practical difference".  Without boundary that shows where each
message begins, the result is much harder to look at.


[Reference]

 * https://lore.kernel.org/git/3b3af3ef-a043-4af9-964e-429237789c97@gmail.com/

