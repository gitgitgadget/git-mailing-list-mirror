Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1F1DF730
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054723; cv=none; b=ov99SyQ7s3zTZ9N1kSy6ofRqwEHVk3g0GwSrncNuS2UphQ7k/mgdycyDT4oWvjk0LS2RRwGlqpa+V16ECHMszd5703SJn0x9YCv1V/ZA0VnrFaHy9yOivWHrZVcwrud3AlukuOm83xqcObTSBdTHzX/eaSt2Ucyj/GfBHqV+suo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054723; c=relaxed/simple;
	bh=ONCQxK4NXzX8KSs9h03y8nK3bAW807vHXY/B1Fvyyz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td9nbsKSmKndVTW28F58LYfPWHpyWFRyTmVohWIa5VOes9vqbp33ygjADKkY8zsjQaI7Q31kGP243Y04PF6JKhYZkJu2VbFMu8+0YjsTeUOvvWY9gdbp4Te0M1/HgxzY4q2/DHWsHcUGc+TpPNmF3kImmPjQYe0ywRCQkBzKVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=moIn6v6O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rz05AtG4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="moIn6v6O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rz05AtG4"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B21E114013D;
	Fri,  8 Nov 2024 03:32:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 08 Nov 2024 03:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731054720; x=1731141120; bh=2pd8qhu2Og
	VldnRfVKbTSY+PKI0JAapJh3n2xdy4C/E=; b=moIn6v6OGfm4B6+FPwI8F5rL5U
	c/iNZ75DLKByS6KcjjzscfAhm5iRLxmG+d0N+Av24KLQpofXc35MRvwx/+UCGFjF
	x+sAO/GI6MPQLUBuDJRm4qxRwwDq5lA1N1CDX0ua11/lb3ooHTy6j2z3vcTCQehS
	4cQtDIx49qaHcqH5vi3w1/D/TAw6oO6BcBQQMhJJC/+ZWg+ulqZAoHo/CHiD6Vxk
	pOIF1f7VZJGZ2REzzpJboeQLgAJxIJlPIMkgAbE3svbIj+LQTWEJnYPPUN0C066S
	KJGecCTqOCHbJ2ZZjAMwjqNNLBuiw8fhrs+3wVfjCzJJnACuM8yJ/sxbRHvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731054720; x=1731141120; bh=2pd8qhu2OgVldnRfVKbTSY+PKI0JAapJh3n
	2xdy4C/E=; b=Rz05AtG4AalgIKnMSjiIF0ep5G7M9R4YpsfnwsnfQWP0/3ll6q/
	4IR58U6LzbN1BkgG3hnGaZxY1QZtA5/0zQumhHhRS4HjB3LadbvIjQQdiTmpztAm
	4j5A75HZc1pbD6pMN/bGeigv8OD5SC+33NmCgwQ4p4zj4+X/RLA+ihClQbl/hKEM
	eAfGCL5c9Yg+1KgSD44BjVc/0rUO9NmRkIvF2GMMV/H59e6JEE29+C7ysnFGrOji
	mvHY01k5pCrmqu2QprOU5C6BAw2Z55J155k7/h6YITrqiRsHIDyav7januHhjACO
	YoTl6kFiDIA0pwQaCX6BPnQNzX2CnWIyfZQ==
X-ME-Sender: <xms:gMwtZ-51tLZEirSnQYSBDUKuLbu244lX3zb8BjZPQHrRE_5hTJzfcg>
    <xme:gMwtZ34mKFDvbREi1s-TQKTgEfhjbxvDKlHcdAOIJs4-TzVMbcVNIIk-yEj9mbxVh
    65Evm4NnO0zOj-Slw>
X-ME-Received: <xmr:gMwtZ9fvNetQI6131JjLWXBNqv9H0du1vyXm3baYJuY_hEI0VANLnjuJNlXHV_1-iMt6QthBlkXLaT2O3B4FLODiN2RPm-DpM8qwPyUDXEQvcuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejvedugefgff
    ffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhholhihrgdttdejrdhklhgrshhssehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gMwtZ7K0iWy9wljKFj77lHLadNTtUrXhV-uETdGLHYz5wnHVpF8XJQ>
    <xmx:gMwtZyKgVRugZpvSAWekB-rH8epKb8upNJst0ogkzUpS_MmLIobmJQ>
    <xmx:gMwtZ8xWki2fyeUdexSz2zPNCQUd7bqYIDkjTHKWWWO5QpYH9AzQbg>
    <xmx:gMwtZ2LO9z_VJ9L_WZ5XCr99DIDFW1EhVhkrA4Id5QOm1nlD6zMgcg>
    <xmx:gMwtZ5XPM7SBG_P9cWfgdg6trL1rxwf-dEkygfzchdutjJYO19lYL5qg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:31:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe6b47e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 08:31:29 +0000 (UTC)
Date: Fri, 8 Nov 2024 09:31:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Evangeline Rome <kolya007.klass@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Crash report: git maintenance start/stop
Message-ID: <Zy3MdudlGBoFxDan@pks.im>
References: <CAFBPeVD7pSOZkaCs_sWfhz6A7EWrV1SmLcCxVErK6GEs7KeYbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBPeVD7pSOZkaCs_sWfhz6A7EWrV1SmLcCxVErK6GEs7KeYbQ@mail.gmail.com>

On Fri, Nov 08, 2024 at 01:24:29AM +0300, Evangeline Rome wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> I'm sorry but i can't remember exactly. I learned about cool new feature called
> maintenance and tried to apply it for every cloned local repo I have
> using shell scripts. something went wrong. I'm not sure if its my fault
> or not. I tried to reproduce it:

This very much reads like the report at [1]. If so, the bug has been
fixed via c1662a00b6 (Merge branch 'ps/maintenance-start-crash-fix',
2024-10-18).

Patrick

[1]: https://lore.kernel.org/git/CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com/
