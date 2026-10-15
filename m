Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856B3DC4AB
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084221; cv=none; b=os9u5HWFfuK+Yt9vvX1UpOiYX2TUX4B14/QZKF8KpYY7E1bAaaN7rnk0rrGUEVPmr1R8aWEL/H8HeZTClizPFccVcRo8biF1BBBq36ovn6j3O+YINgRn6x8KYKKUhdILuTEgs3yldsctmh6qDd6sSvg552vpdwckvmRIwZeFDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084221; c=relaxed/simple;
	bh=cYT23HENbIF6M9VslzrxRgCX2QR3DV6ChVK7qBAeabo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFoEOwOLQp7co5rRnnqrPo4plbfOhV7ULicd9fosq0wDgjZoVDaaSbY9rRZmy6UeyJf5k/XOjBkof8hhTE8sXuaVg+p8ZLkRcGWrL12+jiAVgejddevQbinM8Li007glshVYpG+YJEsH5O0Ccm1kleQoRaHXkHw2tzBd001UGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iEArs82A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yQBsBHu+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iEArs82A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQBsBHu+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 473311D00147
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:10:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 13:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792084209;
	 x=1792170609; bh=b/tZsUdQWmLhz+HWo8R+jKnBgSpjLV9A5BJQ19aXwbc=; b=
	iEArs82AleG9VB44FIVjV5bNz6nCmIKHnwMk+ox18rGzAbxupEVdQbkvC9ps1y0U
	Szn+KKXZPhAQGynxM2mU7GKhq90Sp7ACjxtKpf1Z5haeWZUeHk5EgYCsPDAq6NsW
	29u72ieU/g7buIuEnh0EB56i4QF+QQV6Yu6uK49JzTf5UHq/eLUUpiK5LnPRP3EO
	LtYi4gXJ+V00hbms2HTr8RfS29IL33pXCSwaeXtb0L8jSPozb8Ql+OsKyl6KwLR8
	cHNinx+GC8NRjKhda68ib49hJF4jNjvm0PfDpq8K6SVhuCSPQqEmcef69SGjH05W
	45MlpncY0VhvgWxqPuCx/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792084209; x=
	1792170609; bh=b/tZsUdQWmLhz+HWo8R+jKnBgSpjLV9A5BJQ19aXwbc=; b=y
	QBsBHu+BC/78wuzoaxy+Bsg1eEZo1Lw/2kyAfc5wyJUmVbknVdIeLvA4gQ5dJsJa
	tgqC9UkyzIFUr0XPm1wadXLj+AlcNFL9eRs+vyJB/NtzAmFZG8+qA4QxgIgY5R4y
	1A2Rf8OUpm7oqA6Bl3Raa3BA1J0pW6IEldpwTBHRT9f1ms6d9dPr7x9BWVds0sZ/
	7mAGYTjOd+5cvc0aZ32jG1fGAG/R368WviKO9qN5WWNHkpCtW0LXFzpScWgqXm0b
	26AtqvMBBPOC/NcHDtTr8LsuwkNISPQa5gb09HUHOr9r1jftl6pPE6qSVKfMD1I5
	bnGfa5PYG7iZIIDmDaoXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792084209; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:pKQKoflBaDES4Ww02tuD6vtEptk8oxuYbB1w4j/FLfh/08E
	la+pAeUSKN5qqJu3HBAX77P/89vka7k9+//1ZoPQqjsce0GpMGyy794dpC9p2PIB
	G+Bs9lZ9lOVANIo1fKYCzkpvFgUz2PmXdZ+H9MIxnScmvskw07meOsIeQtjI5GrK
	gRrM9WL+Vvi4psHmXphdlrzo+M8cBviCg3uLvXv5hT6K9At5GgQutsKpTbTIsVfE
	KQyeWH3IDfnEIp/YwrohaT9KeV9VvlK3/Yl6qDlknqdUroRdAfuXykJUNt5tIM5Z
	mn8vOHbVS0TsY5iE2zcD6Yyxc1fJ4QeUKS0LBvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:8g5kfYC1IhRIOy3kHWHdxp5hVqA5WN5wNW82rC8Oz0o=:cYT23HENbIF6M9VslzrxRgCX2QR3DV6ChVK7qBAeabo=;
X-ME-Sender: <xms:8QjRar9TJg9Vglj7RlQIj6UOsBPmX4m7GhzGnkSaKtLGCTj4_qSXZQ>
    <xme:8QjRamw9DEcdS6bSp8ILcRSpeoOzFYkHOrywSIUldxIRmcP__0_EKFQdl7tWXbB7n
    AGRo0QGG61wpwIbEoOUnQCI-nMUPmLJQpdGOcHildQT8u2MNySfbvE>
X-ME-Received: <xmr:8QjRavPsgRrO0iz2hgFJJ-KZ0NU3lAJrK50bB-d0w6Q0WRXFt9sZqeV6PC4OGgRc4ONkehC8PES5nEFt72eLVQt0T1s91ZSeOrzN>
X-ME-Proxy-Cause: dmFkZTFEQCS2BPKmYJlDcN9VixqAzYuNEfinAMFaqWAlp5sJy2YFe7NjVlciqXamHZQa1X
    LShRZfeFE196oUw5emyEPhPgvEVkrtMfMimGk/bc/Is9Cxn4c3GlxagiJdFyq0Wee5upyK
    rxgWz3Nk0XiwTqK1Nardn3ORfVxyH6JmDvg39r4UUtLxFMR73deVpYCtBLj/uAXeBejQK9
    54yM5XiupkouLGH4sNQugVkgtx6qFCbz8UywIpzYCUY435xOlI+zCXYPsBPAW+R44gRStJ
    LYbSF4n6ExbV831bKXFiZn3MbisS21GxhTXPuyrQYWDbVdSaEDIWth8ReV0kXadEHKtYMO
    sFUqZkDT/Eo/4RM+EbEZA0zc8FUElsiQ/Nv3XZUG/Pmu8uOj7A0iwKhZS7BpJ62Gdpddgn
    u5HK+alFFGeIp+skLzoYj3DKW1ME4+gqN32jT3mX9jlPYiYnphI4/lEd54UDT7czL8dFI6
    KfwtI/DMRuiYIxQviJec3VLeqmHpGwypJXXY6OOvHFRf5ER/TP8AjMRDwNq5HxLGmw46SX
    2DUgp1Kz5QrrbR/AXTe17WBBnUreMf4Kzl83s8o9gDOdz3LsVmqpVl0mpCWUcOZGI5S+4u
    Y1t2m0TsA3DZ20Twl9d1LHP+93fqgo3ZBEKnSc6tsZM6mdRSPPhPxNXlEzug
X-ME-Proxy: <xmx:8QjRaj9TIaMLO2hOMmvSUN6wsWCOs5oqWlZfPjcvPpD2Ua1DMC992w>
    <xmx:8QjRak6aTe5ztm5pyBEgVBvS-qFhM6-wDpLoZIix0LHFD4mRJkNBZw>
    <xmx:8QjRah7FTPQge_lTYK82Vftu9Dmquz16uqF5cBgeNUQf-tXnzeXGZg>
    <xmx:8QjRaloyNDy3zHk4bDCPCCeS4lJ3qiXs8SryEj3cXfwh7ue3CFcnwQ>
    <xmx:8QjRalfNpnNeYM4szeTi0GBaV_ZVDph3q0sUWhFEqh5uXg5fR4VvmhPO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:10:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  Shashank S via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
In-Reply-To: <9c905a79-22a2-4db2-b434-00ad8a287300@gmail.com> (Kaartic
	Sivaraam's message of "Thu, 15 Oct 2026 17:13:33 +0530")
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
	<CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
	<xmqqzewgosyw.fsf@gitster.g>
	<9c905a79-22a2-4db2-b434-00ad8a287300@gmail.com>
Date: Thu, 15 Oct 2026 10:10:08 -0700
Message-ID: <xmqqzeweopov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> That said, I just wanted to highlight one thing. In the Microproject 
> ideas page[1], we have the following for this specific idea:
>
>    Notes
>
>    - Start small: Pick a test file with just a few instances to convert
>    - Run the test suite after your changes to ensure nothing breaks
>    - Follow Git’s commit message style
>    - Include which command you used to find the instances in your commit
>      message
>
> So, we can't really blame the candidates for including the command in 
> the commit message. It is our mistake asking them to include it in the 
> first place when we don't prefer it to be present there.
>
> I raised a PR to fix that:
>
>    https://github.com/git/git.github.io/pull/875

I do not think your update is taking us in the right direction,
though.  Recommend to have it under three-dash lines instead,
perhaps?
