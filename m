Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47938526AB8
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876879; cv=none; b=D72TUdbV6tvODRE0RyHVugNd+BKp9MIlJbYLjx1FeuWlx+6XFps5L0uKIbGaDNLePUTEvZPW/XiXAMKz+kU8mNSAIJqI8koL9bxVTKKQhBryv3ZeyztkTcC4ZBqxKdeNVrCrrFa3Z5IPoRB5g2UoOef1klPIorpTXe70L28eLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876879; c=relaxed/simple;
	bh=EBHgVo5boBkmbzMEkt8lBn051BYi+Ff1ZmvZ2Pls+PY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Axa/LOuMc/JTkcZrFEwhVZGCu22EUdn5oapgWC+JyC/EzPlSELDx4csLupPiOrR7QlAT2IjmQj1Gh/HFftpQ7hgxVpnUMRwa7uKSv8pGrQ1OyWHJBrQKi+gcuDYBn6aw5t7kFQ2j6IWWnHxkIOgxZix/4SRb7GDeZuPjb1q6ETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UeK0/hol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mncaTCPO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UeK0/hol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mncaTCPO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 557731400147
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:47:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 13:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790876871;
	 x=1790963271; bh=Nqv1wsaLV5Ii4K8UFI+xXGB/FLgfSlxYvhe5Rz+Yxok=; b=
	UeK0/holUun0c+lpdHftYYsI4KI52gbGzxn34yiZ24jzhGZowKJJ1+ySKctBqtAa
	Y2wpDe1gTA/uSMJQcbF+iD2t7H02Pw7uDyVAKyJkw/0Ume5/QfzYvGWdtdzXzCgu
	qbftZV7YXSSSBjQUzE3ZTKXWgF/AWXMn8uITBKoUoxB2kFtzl33NCiPB5kiqTbhq
	+ruG/qcxggxw4CKYFDf+sxuEgqERzZWJ2YQCh4fcmSZ+1IMTSgzdFIvG8kRWZLIa
	GJPdPL6Q8Fnd8jlmq+ba6yi9wagfgJGrT5hE+ncrmh/sgEomFWDaLy++yXxpNVh7
	Wb9ZIAvSpaNNscmnKTtxNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790876871; x=
	1790963271; bh=Nqv1wsaLV5Ii4K8UFI+xXGB/FLgfSlxYvhe5Rz+Yxok=; b=m
	ncaTCPO8oq5jd/SJ3dTHepa5Te+0knddQl03Z1pNN4HRXIa9AraKqA9xg8YOFoDm
	mn0Vjw3CHNwUWq46qiQn3QU7XljRxyvPNj1S3EPTjfpeNtjaWz0YEKpMqRgsHUmX
	1KnTXCw8V2mjuUJhDyL8UlYsCj+EKq2BBD1KfGZC4nO6NVbuCsSM8KE2IhLdNEk6
	d6DpJncRWfeYakcvD4QeoQrBlOgzN+X9KykEnfnlc2kchwOA6DK6EQzwFTtmIvnZ
	H4IbTrEsFscQWbmjCHNA58Py4V/A8HLX7M6gMMqEUzUTtjxBHxqh7vjmm7ZT9Q1b
	FBhkN1yS+k8XocHGAGsow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790876871; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UFdVlH1ReHMnKUvEnoKhcV5GTOPQb07TFMucPKfp4cY0277
	xp0pLcj1Ncp0QujuLLrmzRGZjazfmbsj8Jmtz2exxldXXe+DKYRKFrBdHAsmGwuB
	q53JTA0prkYXsV2+lbD7bAgTbiH35760iusrbOSo+wZqAQdUlq5TuTNfdU3pGpcZ
	W0/dEafHHxWuPVRe4TVG2Z1GfijxKNuDqxFBoj3sZzsa42knh4WNwXUb437lHMtv
	fquUQNK4EZ7p8L2SHpnhBTRR7iiywox9ghal5VVCdC4uzb6I8TOoYKGZCaDr91Pp
	ctsWKstv/hZMlSNXSV80+OhD1yLa90yIEQquINA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:8b2gVSIohMfBmtNS3ttVaNjvvBaB6sQom2XNLt07OOg=:EBHgVo5boBkmbzMEkt8lBn051BYi+Ff1ZmvZ2Pls+PY=;
X-ME-Sender: <xms:xpy-ai1V29i7s59A6Z6i4rs3rrwmmBMsFK-uvt_b_eO4tmuwgLUy-w>
    <xme:xpy-auYhU9PVW3NhbTvO7bo5vuLB7m9MOAa_QrD1S3SpS7G8-F5zALQaRbsdUq_PU
    ftJVZbnej2f21AQoFgY0MAF0nFWsQJ-1R6EH7dh3bVW-AImwKe_cQ>
X-ME-Received: <xmr:xpy-aiLiV8UHUL3Ax2X2DhljvzzmYd5HG1ZKzVaPbeMybzZhRRx9EGKPhfXmqZjdJN9p3ekReQcnFOfDzNODqV6BdJkTkP26Npsj>
X-ME-Proxy-Cause: dmFkZTE/MbTbQpZRNqhRbMqplilbsRH2yC7pnDmM3nMvZ4Gf5ZZnCdfB+HS22owyeFiw6y
    jzKHxs6QIHg2DB4VJ56VOyhAl9u1kCP77dGM4KVMK9Mjw64/GQf6j3JDMs4+EeE6OT/OZk
    5EJbnYIFrxZsT6rxhKCvYtxp5x66/HDAr/ukR1hBEPnCwgxY+ArX3+6EdLS2Ri4FcilmyD
    y5MjGY2WYMJ1OShgz5LDa64/uMRWbACAtRw84fPlt8KPygJ5vppoqTIuD5xd8iAdduQbFW
    zrD21w1MLL64S0EoaNH0bOqAa4u8hAQg5+x5la4YXgi7bAaFmfoNi2wXbug6jnx0aFDDLw
    pUAh1tAsYnsrY9xcUBiNPIUl/g+A2xwO7H/d9CaXZ93G3Gu4GXZt0tKWOG26gHtj0hCF/p
    J7PoCJKGRq3lFJxXm4DvxVhPhaSWM+Ptd7E0e/R8xk98Fjz2TelEdoMP4H+tT4PE9eZXH2
    9oSt2KrcT0mlO0qG5an4bEoJynjoOVdpKhSc4KVgVuvq6EubhJ5z9YcpjjH5f5NeNjQx/R
    SWtfSJSPgUuX1Ec245XTXmQvb/HycF8iD4zym+2jwhdQIcE/p8hWLCMOU7j/pNd8dvyxWB
    mJW63fwbz0WF2kJmF3WKrIDVmofhR26FBxpHCOtQ0aD6G3oB+D9B9wOEtUww
X-ME-Proxy: <xmx:xpy-alHzHX7l_lx79RjlPuXrZUTlJiYjEjcGh0WQa70u5YGoDvHYTQ>
    <xmx:xpy-ahvWDzYiyU86D7e-Au4KfM5jU6DVX2Z74L6lWL8ERErwKlusPg>
    <xmx:xpy-astvzAioaTtPNNk6U8MgllDLAMBBNnsR9Rv47gtJsLtnXFk1qA>
    <xmx:xpy-anDX42_oOcs-oHvv_SozkTse5hQcZ8sGkVzPe0np3IjfZZTVZg>
    <xmx:x5y-atwF2Dp7_V_h7e-oWlAnCn_tnGrrfAJHdBCHd045ltlBNlLcvvji>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:47:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,  Eli
 Barzilay <eli@barzilay.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 0/4] stash: clean up index-mode test merge
In-Reply-To: <d3adb734-2b84-4d7b-b245-5407ee410eb4@gmail.com> (Phillip Wood's
	message of "Thu, 1 Oct 2026 16:52:19 +0100")
References: <cover.1789853192.git.ben.knoble@gmail.com>
	<cover.1790803471.git.ben.knoble@gmail.com>
	<d3adb734-2b84-4d7b-b245-5407ee410eb4@gmail.com>
Date: Thu, 01 Oct 2026 10:47:49 -0700
Message-ID: <xmqq4if55n3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Ben
>
> On 30/09/2026 22:24, D. Ben Knoble wrote:
>> 
>> Changes in v5:
>> • Rebase on synthetic merge for the test interaction with t5520
>>    (dropping old 4/5) [59d1ce1b6e (Merge branch 'tb/t5520-reflog-expire'
>>    into dk/stash-apply-index-incore, 2026-09-29)]
>> • Fix handling of tri-state merge_result.clean
>
> The range-diff below looks as expected, thanks for working on this, I'm 
> really pleased to see us removing some subprocesses from "git stash".

Thanks for writing and reviewing.  These now look very good to me
too.

Let me mark them for 'next'.
