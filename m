Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C043B6C4
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278661; cv=none; b=AcpXhUJAazHNU+XO5vIdy5BvxvkGpFELFFxg6KRVTBARx7QDbvlLOwKpb/3Hg0d+Jer/ur9KU5TwW9T1miVBQc6sI12saPHILYwW147flgYuWktrdyjdA1cN5iZqGqWNKU1l6BD/pIuyVs4mIogBcbnHyBpz1AKo0TbTD+qmCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278661; c=relaxed/simple;
	bh=eQ0ciUrciC3AMPO3LWfzNXHdny6LIdp2xjtTlwISlNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QnVIgXfme0lBY6LevzQyjhvY+HFx33Jah56G+Eq41ePkMxV85CkIh0iHwcc5DnbeoE0Qhue1FcAxmlky///TZvgqYe77MZhLusUigB/05YThaUpyZArcVS1JcXgn2w5M6C2rr7P+v+bLZXJ5XrfawSfmm0ERahROOonMmS8i+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CtR/kUuI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLoNBp8t; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CtR/kUuI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLoNBp8t"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EAAE81D00078;
	Tue,  1 Sep 2026 12:04:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 12:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788278657; x=1788365057; bh=xL0HR2kkhV
	fZu3qEG3VndU3Lv0dXiyVMaIA/Pp//EH4=; b=CtR/kUuIpscpEBzjHjG+I0zi9A
	NxRsZAtw0132JG64dr8pab0qTJeXWCL5mKUhMuIRX5/cyLJiNVYEBspJf0UJX+BJ
	FjlT0d0EQMb6hYDW5BedSmqSnsKjdnWMM2RFF2leuZpx2RAPkKBVqP4kYVraAwd9
	s70fjEEyaOGbkunbwH/1+x97KGO15+Xl/+F9jZ2gz2+xPaCxNubIksGNqV3MfppV
	NmqZLsyoZmAFLIaSa2C7BBRD9icmq8ObomipvXtku4sQLv46xjnawKsuWVr+u1ZV
	ISc5uNSDIbLYd1tOPBY+bXX4I75ZBUxqLW8yLtJV5WCB4jAkp/ZUh0V3A4qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788278657; x=1788365057; bh=xL0HR2kkhVfZu3qEG3VndU3Lv0dXiyVMaIA
	/Pp//EH4=; b=fLoNBp8tEHOGEiv8t4DX3UbxoeLkOC9rwVbupyzfDGQ20PGjkEx
	M/+5LElkmT9yvi1WNj/ncT+RuPbEa2UW5li9T0hNTlvmAohHQCDpiEyVIsx5V8V0
	D9GIDb+giJXujEBrnz6oJ+PPtE2ONG11/P4IdtwbOyJRiYG4XqegrL7BaO/t1v/H
	ocQtYRhLfP45+3t3KNhh0aXSSjvXaL1Vgy6wgdQXSFDry/fdk28Bvd1W5WaNzN4u
	mZVF/qPruo4Dw6Uk5FnFck5zXnB1LXHvUSyjsedLB0C2Od+Utu1o3wCdQ/kpGqKD
	lkrf7MI5G9XSPoRG4RLtPZlgkcD+Tt2EnzA==
X-ME-Sender: <xms:gfeWaqq5brr5kxYb4yKl7zDnlo3yYsQq9L32rtO_RzRe5Fhoxpn_rw>
    <xme:gfeWaq7NeW_MzZdq5rqXTLj--SdHbSsutVdcB-vwWaV3BJhnu1e_ZZ-rKW7jUdHPY
    1hu4Xr77tsYgOK4uUL3iyzdXYeNr9Mbm20fd_W2dZAedLNemYixcw>
X-ME-Received: <xmr:gfeWahfDUlFA8g6lHJ0L6Sh3GY89wWXP0guN-UDKAgt8c_UeHp2dIIdg6UCzzivcbYH7qJj3rYCtMIgh2ebCdIxWoZWwp7RJTA>
X-ME-Proxy-Cause: dmFkZTGr5Nzw9bqPB+HC4bjc5Ddt8V6214efkd71b0G9EKu7ZwWIOH2qabSN60JksRefPn
    LSRt+k4LO+gxGUQdIxEjSCOrNYmSBzY8p8Lln4ohkefg69i+joTM3AktvfnwGe18UeqLLG
    vk++04KoBhwE9hmw2P55CvyIQDnXRSVUvU/0JUu/qroUAzZuoBGmkaU8jW3DpkwZcF5uDJ
    vQUn6CgxNBv3gmVCKP2b9mgrO25wZIYZFKsmIAfofUfZBfRuG4a1sVM/2bsy8KdrWdZvUo
    LKQBI9GvF0xophAcM+hS/liPxdVF5qAPz2m9RgrDUEoONFCZdfhpemnrOFsphNKN1LgZDE
    TGoEvIHR9XcWVgoxXjUXnRQYK3Q9iIbSKeGUURGdRtuddfrhzaY8oGMkle7TfhqR6ned90
    WjMu13VNPNahWYGfBvkN67Y6No3JEU3UEgMdeWEjqTbefAngXLqqH/aeeTZBstedHsercC
    iBcYnOOOS3GlBQAiN1tcUs+zWO1qac3TZ5vOdjr43UoYUMFR+hqaa5Ftk6p68xaMkAjlUz
    c9Ebn0svC2O47Mk0o/OI68Wo5txFffbEaI2EhAhh1DHmptwt6pJ+jqoWJYmGj9UFyLjR4G
    rJRW/HvQQFlVYQB1sgfvnp8orwycmcKlsHFrG0AmcfVkdAdasNgkHTP0KJbA
X-ME-Proxy: <xmx:gfeWav4oZ1XiWeSR6lsHKxLYExM-Wocg2fcghxUuhwn_MjcLqkiZ1w>
    <xmx:gfeWaot8nWE5MW7NXBKYKXWyONB6Xkxge0BfyQOWymHvxalUV05iWQ>
    <xmx:gfeWavhIZLqYAFATkQGRCBcukdutw7eCGaLdsYUnaMSE6H_R-9jiCw>
    <xmx:gfeWajo9vD4UBLZfSHPaH3UQw0KY1y4ibBXElUPaA6os1m8QKF73bg>
    <xmx:gfeWam8Y8zxnuG9L1H81F8BycKRzFe81NsJzpyqtux4rgmzvpp3KiKyc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 12:04:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names
 a removed pack
In-Reply-To: <374bffe1-47ff-4cb6-9d69-f4b7da7292da@gmail.com> (Derrick
	Stolee's message of "Tue, 1 Sep 2026 11:27:08 -0400")
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
	<9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
	<20260829120721.GF40814@coredump.intra.peff.net>
	<xmqqjyp71g9s.fsf@gitster.g>
	<374bffe1-47ff-4cb6-9d69-f4b7da7292da@gmail.com>
Date: Tue, 01 Sep 2026 09:04:15 -0700
Message-ID: <xmqqmru1t0u8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 8/30/2026 4:53 PM, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>>> ...
>>> Sorry, I know that was a lot of text to end up at "you have already
>>> written it the best way", but it took me a while to reason through it.
>>>
>>> The patch looks good to me. ;)
>> 
>> Thanks for a very informative and well reasoned write-up in support
>> of the series.
>> 
>> Shall we mark it for 'next' then?
>
> I'm late in responding, but I support the series, too!
>
> thanks,
> -Stolee

Thanks, all.
