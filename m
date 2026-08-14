Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7C4611C2
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704883; cv=none; b=kXZi6XO94rDR0rBUEd92aQSXcOw84WV7jGT/3vczyCtMlCk8DlOidREREMBkkFr69FjNx0rUSSuT6t6nMkpazCtyHRGNC7gKMg4dx8PmQ9hDGLBSuU4tRgFgolvOcd5SoEVtgY0saJtDSTcDMnw13Ec3catO1i7ECtplz5Px2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704883; c=relaxed/simple;
	bh=MWJiN+GcDksB8JSfShhUhqsl2WvIgaZYpW/UT4HhcuA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LQZvDu45LxSe8opeQtnlwBKwsztxv+W6W3RVn1GH7wF94OGR0zVYgFT8LzeDMcopFnoODTksOfxbS9Kk4tRWlMHLkcVGf9S435LDACxFE6SJ2iww0BFopz5FAFOxqKpWq1b4ZSmyz6tFO/MfpXHdyqBUdbfF0PkQmWTC8j8bbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KB65YdmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDpEVf4Y; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KB65YdmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDpEVf4Y"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 967481D000E4;
	Fri, 14 Aug 2026 06:54:31 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 14 Aug 2026 06:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786704871;
	 x=1786791271; bh=MWJiN+GcDksB8JSfShhUhqsl2WvIgaZYpW/UT4HhcuA=; b=
	KB65YdmV98YefZFTGSAIoGAs7DQufxl//CnKsCAdV0wsri/qINk4EA1rJeXLEcDz
	ZVgYoy18w695uir9lkfN9aFywUitikUDlT/hf+f0ehL+Hd097HpAXLZtZANfmNst
	kZKCJIGhHrdUy4B7Uj2vjfwyKYnSbWrk2VJthJWANDMygQnU9cukyK8/IoZ6IJvZ
	3PKwGpJnvF40kNd2wigDK4NDV/IVUlD9nbho5c0lg0lIR0wiM6M5SPK9u/fxgTc9
	Q4E3jdIcPTFJQUiHLdjJEl15uy5YJPKBVBErGDH9Cy1xhMtlF4VXchrLUqZz2Psm
	U5uFH25jhtu8XRX4EJF4bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786704871; x=1786791271; bh=M
	WJiN+GcDksB8JSfShhUhqsl2WvIgaZYpW/UT4HhcuA=; b=CDpEVf4YTvBfJrIVh
	RtYpDzoywNw3mqwYXc259f5mowfGX2/8R3/D+Uc07ilqw8UKmRAlS39fiOGTbLY1
	RFVeqL+g5w0ZHItzj/+V/3gdRwYeqLeNbbrnYlOGbJelz0Jo1ig1f3BwBfWsl3fS
	HOGvDE9p2Vee52TeRpWwyzT90wo/lV14/twEqImrl/PDlxMUicDyAibtcpqw+r/a
	cL8m+7rZ6s/ihbiAnhIosX5v0bZv3RcLhAaP0MXssO/fW5kyx4y09IW13nmVO0qz
	KumHDiFtLEZ7Hh+gqKMCUEYFxotPgf2nzXinJVomRafyzYI9rMs3lxrvaKLQi+f8
	taUnA==
X-ME-Sender: <xms:5PN-an43i_MI1EzFp7Ny2BUELHy0X-TjUGgZxkH3ediQz6prondAc1s>
    <xme:5PN-anuo2A1dXar53flTn2yqheTDIWt14ac_FB7-2FtfFK3CtOX1qEm1cupu7Uyzu
    CFpNqx2rZJBOcwv9D97vvNnEv_-bDiGj1zahpbpSYTbTG2XcI0>
X-ME-Proxy-Cause: dmFkZTFsuUdVHDG/Lgengkn+smQj4Nq8SreKVHI/EXSDWJuwuAjpFOL1mn441kk9F8jEsb
    4g/zaHYc4s26UCHnSz33El8JHs+fPFczmCFza3tETAHjafQ5VXzCvffTosuZbBbi/DI6M4
    uVeN0sOX3b1zqlexBxToY8gihpZSGtHXDDmJTlfTM8t7BHsjg1Ot4PdylzSB25v5gB875c
    4YUCbuwuGP8us6972O8l+8XxhQe2t9R1NEbAtAb9c3uihH5pMbf8Ii+2foIu31TR/LbPKf
    S7O41nralLOFiSseLqG+H6o5GycR90JmPtWoTxjHO7DdPoQae4J2hKn1GEz45Dp1QBujev
    0tTEXS1La0bSyA6djaIgXs+Ez/UM6C7q/bvREla/mSs9fcXORWU8LkloJWouvPEaO5YX8q
    wXwv6JtNlTJaZ9Ht4tg3gTg0Gp3ZTZwzZbdc0e4iBPohQ/PX6yUcj5gbGbTT6XoWRL2nNQ
    OYnS4JD+JgmdYOVtGBwDV/Ty1rtFcnzmq9PLoBbcMn8r2OJeyr8jHpv/6/V8kvrIaNfR5O
    GY09H3MQDMkMLzqBkwPvlA7Op03a+PsXFJ6E5TJoneZh32lnp9e9KxdSIik5XnmQ5p3YkY
    m0i9DoeiAKigP42/hZDYcuKic/PKjuGrKfcW7sZVkc5pHWTgp5hor2B6Aumg
X-ME-Proxy: <xmx:5fN-ail6Kk2c_ZQYMVzQDqlMPnwR0QHfz0taMIRScCWoHMSlt1TZoQ>
    <xmx:5fN-anwifVhWDnoCAwe-WaQEq7SJDjMvQX4BfbXR2Axn4VazeN5jFg>
    <xmx:5fN-aoOUWVYnYi9KnR70xeEw165GSN4IN6JSCLyuCQYwLF25PaSGsQ>
    <xmx:5fN-ajTZ7V_FYJr1EXwCR27Rbx6CYYaSsNgzyxr9yOvLTV8RjAIIzg>
    <xmx:5_N-aoewjJci4seY8bmLGFNTnd8RX1lgXPZSwIcURDhaoWV9hQxgQ_bn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5EB1022C0077; Fri, 14 Aug 2026 06:54:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4FwHZfX4lP-
Date: Fri, 14 Aug 2026 12:54:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Peter Morris" <mrpmorris@gmail.com>, git@vger.kernel.org
Message-Id: <7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com>
In-Reply-To: 
 <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
References: 
 <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
Subject: Re: [RFC] git worktree: use filesystem cloning where supported
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 14, 2026, at 12:40, Peter Morris wrote:
> I'd like to suggest a change to how git worktree creates files.
>
> # Problem
>[snip]

https://lore.kernel.org/git/pull.2317.git.git.1780685368.gitgitgadget@gmail.com/
