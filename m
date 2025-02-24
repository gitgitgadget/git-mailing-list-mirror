Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BBF254856
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415409; cv=none; b=c22dJQ4wQiTjqcSeTKkE3cHxh4BUm4JDMoqgEnbtJgBo4leZ8b3pNrcDjmTzMoZLn7XRPKndkSf/SuBlON7lwxYNfC7oOkxmQLgF0Vky7Dkpy445tfhTzTeduLih9QubOZd0Go4URIPOLZFyTUQC3zninxg8D0SkG5j+HY+pfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415409; c=relaxed/simple;
	bh=OTWwIwSk54VM/BvvjxfWn5e/mTeHf3Y6SUFesuLDXVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exOg1MgrMlB8O6hvOrlSBT01IxRggmYP+V98wQrpHmx4MC/XynK8/r1IcLca0oDDmn3ukynTnkDnuRz+fXsM+uq/aAm/DAsKEDg5wL8v+OsstFLcZsMhIN1Ab9MPLVpU9Jw1tDWm/OLMPYCD/e0Oy9uLiDDYMIbeLbriEqt/Deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gHxrDwYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHEATpnW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHxrDwYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHEATpnW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 24AB51380A2F;
	Mon, 24 Feb 2025 11:43:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 24 Feb 2025 11:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740415406; x=1740501806; bh=bVNcQsGNLb
	7nQ0Ez9dnuAzPLdGzIsXhqEW0xFO/7YiY=; b=gHxrDwYYa+0N9jnEYY8A2Br0CL
	P5VX/OJ/5RP4UyiA6sJiqBERQ/bsQBFBCCIPMVvHo6wICCT219PLKBkvqA+pET15
	EgicDXWIkEVdAaYc2hvtS1RkAdMMyTNjMjEuSTWhyj+bO9hi8r4SqLDLKaDaxP1C
	UtD57BQC66pMiu1oKj+D8d7/btHPdNmzcQGsFIl+m6lJLn+6841pKtESWM1KY4wb
	SF4MA7xmUftkY+B/CMj30wJGpvUCrmHDYwp7U+VkEcFL2PCOeCHUL9dXsE0cpLMG
	FWLMXZOfQkp8wY13COrbZ6xDSFbkii6d+dpCT6mUbuvzTmQKP5y8HIZZlwZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740415406; x=1740501806; bh=bVNcQsGNLb7nQ0Ez9dnuAzPLdGzIsXhqEW0
	xFO/7YiY=; b=EHEATpnWCbVbLocig8G3s+yVeSb6/iHCAxhbSZeLZqK1M7IMaws
	PEjOK+94js4kk3Dbe158feMfkVALmuZA7xMw6JESx6Bqw2uFbp0OV8sggC5ZVgJS
	buaxjzKOep2mPsZ5bVB83MSPK8A5yNXLuxyGxqtSn18uNjS9CwWLK5SAs1vNAmz1
	NvJ5em5RihFhqaYoC+WvaLCucYbniUBzkpZ7pueg0lm1eSR+XBrRMxJbBe6T2soj
	4vbmWKpKUoCsNIll6iBxVLsrggJHR/oZPNGtheYFLd9Mn6b7K+6C+NJ0+7/WgamC
	RiAfBrvn4V8kWAvKXV79/TBWLWh9cy6Bt6Q==
X-ME-Sender: <xms:raG8Z-YBNR4Vdmd_CVUu-Wng1mi-jgxMrrKrY4sYVjvVps9LQe0s9w>
    <xme:raG8ZxaPRPiwe4QiNLwbfTOFdyBVP6LNRMuK91Ty3oaw0GSZyNCCgMukC9tu8K9LZ
    wL36RfI2SX27W3djQ>
X-ME-Received: <xmr:raG8Z48IZ0HRCY-ILPCC2LnXzeYhC8LGGz-h59m0RcG_hVnEtFjIkLfkshaEKUVdXYyVglTQeAOjWDM3cFL0wFAleqVZTV1VddotGww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepvddtvdehsehugihprdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:raG8ZwqLRpUSAessS9H6UuP8R2k22tCLxTRWpy0Tfn4mt3vA44X1yA>
    <xmx:raG8Z5rzbwUKn1Xw4p_soj7s3SlOZh3rB3xu3I8HS5lH4HQCBWZL-w>
    <xmx:raG8Z-SwZYQ70E4TdGJkxVN5j1EzKfYyFIBDnKJg0lQyN1ODTcS9Rg>
    <xmx:raG8Z5q6BvkBVBal8CJXR0triMEkq9MDY-_O-Uh0sJNkIPyS3tLTbA>
    <xmx:rqG8Z6lC9zpnLHfdg5JTRPmMBqiHVlPydCQUerk3QaFup5IwtgJ84IQc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 11:43:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Markus Gerstel <2025@uxp.de>,  git@vger.kernel.org
Subject: Re: 'git gc auto' didn't trigger on large reflog
In-Reply-To: <Z7xQey4S0ewT5rs7@pks.im> (Patrick Steinhardt's message of "Mon,
	24 Feb 2025 11:56:59 +0100")
References: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>
	<Z7xQey4S0ewT5rs7@pks.im>
Date: Mon, 24 Feb 2025 08:43:23 -0800
Message-ID: <xmqqeczn70pg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> It's a bit funny, but whether or not `git gc --auto` does anything
> solely depends on the state of the object database.

I guess after adding "auto", we haven't been careful enough to
update the triggering condition as we added new kinds of "garbage"
to collect?  Should we make an exhausitive and authoritative list of
gc tasks, document them, and make sure "--auto" pays attention?

Other than objects (packing loose ones, pruning unreferenced loose
ones or packing them into cruft packs), we seem to check reflog,
worktree, and rerere database.

I do not think there is a readily usable API to query how much stale
data is in reflogs that are more than N seconds old, without which
"gc --auto" cannot make decisions.  I am reasonably sure rerere API
does not give you such data, either.  I have no idea about the
triggering condition of "worktree prune".


