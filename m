Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0135DA78
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352061; cv=none; b=gGrCye46eLQy4OhFsStQKW2gxDfcZ72idT95gGHjkATFkPwI/s9yI/93XvXAGVcTMTNSoNrSCng2IurQBzSqKwj3FrkEboGOC0V3T8hUT1WoaTltrbHrcLOGin+PZcvEdqu6caweRMLro95IBVDGl7m3HE7u8sBkBFnIinhWPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352061; c=relaxed/simple;
	bh=nuDMMZKIyuKmgFHg+2onOZqkStHkXpG1upuJS+zYCdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QT+lx4Yyp7lrEdXRt2+KZS4cjxd2I1GA/cVlcKcP6ACl574oT2yWD3jHR+G4zv9gPDVI9ijWSupDrELWBC4XJgkYAH3QXe0NxkBeVQGSzCa/K6md9xF7YAx0r6XS9wrITkeVq6g6OEGohTwjcyEdGSlaVimCvUAX6p7HPeTvvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d7JJFM7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BY38iPSs; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d7JJFM7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BY38iPSs"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86E5A7A00CF;
	Mon,  1 Jun 2026 18:14:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 18:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780352059; x=1780438459; bh=jQ2/Cdwjl+
	TtVMKKiBcoPHW8NqD/jdTtv96Vn6OPfvk=; b=d7JJFM7TBMUozBy+U7MLIHowWs
	0vnZBl5RqSa6ErFyr6V+nkL3PhXllrPSd4RysZNa+qbYUQ4f8egu4zvw9SZoGSQC
	mm/q+/yAoW+jrQP9u53E30WWOlytWmkHb0MQOXc7z2Cb6M2MUm1R0ZNStO7jt0zx
	iDxjkgJ/4LX0kSZFp64CzoQE8I7t18L2eeO8/pRxk3dsH8N6FbSpFMjMyLWRpf1F
	omrqdqrFhyRYwrydnbPXb+1KWA68b+CBybSiz2OYW6UiwrZ4adlHtKIlg7nVhEks
	o2Q8lKUmyhviNexzfUzr2LpR0NwlVeNjrz5TBlLOERRPeuNrQDYFGx2Fcd3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780352059; x=1780438459; bh=jQ2/Cdwjl+TtVMKKiBcoPHW8NqD/jdTtv96
	Vn6OPfvk=; b=BY38iPSspPx1VtEGYfjazFJ+xhTiULlZPFLgv+0x0eonjy72qVI
	0KGdfTJgjbyxbWrRyOarTpC4BRGSc8k6nLDNAtQZRG1dw8VIW1NT1bN8xFK/e9Kn
	ZF7drdioSo3y+OdvehUnRKNnCObb0jTqMbkKS7A0OBabHM2XKL6CJ2+rZ/r/8NvS
	D7Uo1hSSs1+wR2/SK64Xlq8bi4YGmflKVrfytWlUizcvOFb0hYwk0NkssEA1lV8r
	uPYF5hoQ80O1B6CFZxDTrzozKkm/jt8ItC0XWC8J7F8M7JW0aoSG8MbfvFyg4IfM
	5s0Vvs/dr3hcK+BWhsOwOxkcxdHs056Ce7g==
X-ME-Sender: <xms:OwQeakvazLX-qwWOQlNdNcw546PwRTrTed0vA7afvHs8TQym-ctnng>
    <xme:OwQeao5LTm1ojMBdf6LEixdcKNRyixbf3sUK6tDG-t6ljPodo-uwuFWEALKWZxl2M
    ehXrMK2mDWMhNa-60t9Rwn-_aDhcT7ABlStzSDZOgO1iC65fyc>
X-ME-Received: <xmr:OwQeatLHneHIkLNbPo3M80wBc4e2VIKoc-5H_PMNDEvvGZ6ewEHvogNb61vCBJPWDcg1ee3Ce_s-_zr0O9Wjd5D8TNXcUb8RtAs2>
X-ME-Proxy-Cause: dmFkZTF9+9qsieQrSH9C+x1jM+OPgjeu/xVLctTxl1SaMFtF1C5yO/VjKau9BCq4UAEaTk
    jg+kRDreB7U6Tbocyk7FBeWAqBZWp5SU5wsGka/EORpW9kuIJgpYxCFJ0SLGvllGl9IndA
    n/C2m1IBr2Hmm8pHUlp+iNosKyY4N0eIgPM/KR018CMT/i4osCbANea0kKZ7Y4LWyegp9r
    fDe9olVFlwoycZ29Qy31rcuOcIHoO64VGv7H2oAS/ZeUdM1wmIDVb7LXRW997QiV1TZcih
    px1vcRkiRPcfoZ0nuA8HxekIWptXfNLVwArygxP/E7TLBY/L+w8tkqnL590oL2hSpSszAn
    lR0KJHmMMLaWkXUxiIEqC6ssz8g65ER5XLEFWVqDZVXhYocNbZYe6C6Yom9hmslidWU1jd
    yENjS8lli3TIZWY2i9kpwP+ozA/6x1zljlwSQcBmT+fjRLUAZVM2JUrzStOBtQhWSeGPHQ
    Nhp9+0CpR22CSB9P7tG+5RFHY6DaJAYkP3yWk63zQqL0dlgiWvYfRfslVMSt1VJ92b6+KW
    gsKzBOo8aSZYNdM8DocI+nX196nPR41pv74hYqHw+pYl+cptYOOoyABBc+jhR+LpUBe8Bu
    fG+xOk2kh5fJHyOcLH56doK4/FZKoB8ii74e2wsXCtLsl12A9MvQ4/CqgPzg
X-ME-Proxy: <xmx:OwQeag5EFwxhyV6IhzHSN0kjhwRfWnzdzR1BVwctNvlaIfbgRIOHkQ>
    <xmx:OwQeaowJVlhWjoGd6Oq0_8UEzZX2tcLPy9ZUzaLQA8Y-yxBB_hg9tA>
    <xmx:OwQeasZZ1yi_QSQQnB4ozBVmVqJq1B_Ptqdh7bhnVrJjHfeqJXkndg>
    <xmx:OwQeaiQntMK_doS7-PdUlgfveqYzHJB1lKgW_9KguRmqPqB-R3x0Eg>
    <xmx:OwQeapCYDNWkWZ5eL4WOLEHHxCoFiNUlxZzQIVBq56hynFzqLa_8C3_A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:14:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/18] odb: make loose object source a proper `struct
 odb_source`
In-Reply-To: <xmqqh5nm3q09.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	02 Jun 2026 06:33:10 +0900")
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
	<xmqqh5nm3q09.fsf@gitster.g>
Date: Tue, 02 Jun 2026 07:14:17 +0900
Message-ID: <xmqqqzmp3o3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> this patch series converts the loose object source into a proper `struct
>> odb_source` so that it can be used via our generic interfaces.
>>
>> The patch series is relatively straight-forward, as the source basically
>> already exists as such and the interfaces already match. So for most of
>> the part we are just moving around some code and converting functions
>> that were previously called directly into callbacks.
>>
>> I guess the only part that needs some attention is that there is some
>> confusion at first with the `struct odb_source_loose::source` parent
>> pointer that initially points at the owning `struct odb_source_files`.
>> This relationship doesn't make much sense, as a loose source can totally
>> exist standalone without the files source.
>
> No significant comments came in the past week or so on these
> patches.  Should we declare victory, and mark it for 'next'?  I can
> locally amend a typo in [3/18] (<xmqqh5o0zrsr.fsf@gitster.g>).

Ah, I see your reroll.  Perfect.  Let me mark the topic for 'next'
then.
