Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2134B1A9FB7
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913626; cv=none; b=P3fxXpjVi3XzCDyF90Wg1qnCXfWXq7Y8fdfiem2eU0B8XMfBs/MSRMO6htuK+zRu2b/Qxf5f1iyHLuKcEmkihbkd0Wxxc6xY6+nhzt1+eFd+JTSW7qMuUzsY3n/klBSENYEwvi3aBo51Qt5vZ374g/TX+gn6cx492WGMBx91yP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913626; c=relaxed/simple;
	bh=oOo12DAtS1b9uy6nZIOSDCq46c1cWrFVkFEGw+ti7+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A25jGBQnk0myYrNDe9C5hQ1KymrN6xAMXOsJjCIer2tHRBbTgmfvPj9wKA/1m1xhrYUtI3efw0q8z15oiAGw6Qtc3gEJ7OCurHkCuRMpYSNyVDVLa/Q5Ji428W1WMEEUDDd7evCFx9Q1vGJgFtRXscWKu39uagNrcXt5G2QT1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GUPUrpAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZGyuIP2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GUPUrpAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZGyuIP2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 66065EC0101;
	Wed,  1 Jul 2026 09:47:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 09:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782913624; x=1783000024; bh=nqISCGj4SX
	jmdXBHWDVGFuU/jMwbI50XVVErV0Hgm68=; b=GUPUrpANisnNVsDvn01ahS1ELr
	RBzHT3D1lT12JxgT69Df7HDT3StIf+tnaNgTi1XU5TlyGDjsX9u/Qrnm6sjHPO7P
	jdLqzHjIRAiIffJ9H4dOxIe5ZJn3N4U8/tfekaV5dPwkM2kcgB8VtHx235gmTr3y
	FKIBKv5OtyvKZ6ajWbga6TiyKEMGqnL+3zxvmALS4AO2rDTMZ5bqyb33+sdrGKMK
	FkQNdhOTP7+ySFnNI3xarKG0MZBhvYl6gSdlVQiXNsf57ixwADplTSRHcPDaSj/H
	mDoBtx8V+iuR5vlfcOvRor89xzXhw7G//tG5YrtKSMSPMOs2XEKNUdEpONzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782913624; x=1783000024; bh=nqISCGj4SXjmdXBHWDVGFuU/jMwbI50XVVE
	rV0Hgm68=; b=EZGyuIP2/RQ9wVdsa6ch5jqOtT7AdGLz4Z47G+VWqBb7FWidJ5R
	9w681m4aT5a7JYW2opKXJKH2vICk+XpxDBUym6cVW1QKDOh3uIGBrBO5Fm+CjyM6
	HOtOsHuDK+Vi083jbKvRyu/cnPDV75DAOke58xLys9VdRLQZoPDIYCN94CGaZsGQ
	EurEDmdrA1V/RtssiDwNBYlOOshPLkLAqXQLDylpJApd8+dtIXP32rhUZr+l4h4z
	So/TKQwxXK/toD5fhIKmb3Qx9QP+iCO0KcW8dBeTz8WAHs2UOFVdYJYmIzWFB9fN
	p0xaYjsXkPgdJHuvZmtwMqHuYiYipIzth9g==
X-ME-Sender: <xms:VxpFatJsyObf_9115NrQp4sS6sOAEN6SBGM5pFCaqoEt2vRnUUt93A>
    <xme:VxpFap1vYlEYlFRVtIDhGtjopeXKDOyicQwP5IthFQVoJxK5MgzlmHDPlR8aMelQl
    8vcuEkEIouh-336oT94IEg8LFXSJwDj4vvIRi61cAv78Lh7LWGwSw>
X-ME-Received: <xmr:VxpFaj5ooWlz3HB0LN33Kh_XdydMnIq2_XlH1ANCgZzXuNX6KYSKXeTM7QsiUFzAlFtiR3tPVyWP2ZDcajpeYdqiLEau6W3ETt9ciMw>
X-ME-Proxy-Cause: dmFkZTE+/65C9kathvCKHrb8ssdxZ44vQ9Wnme7S8CPn/kn4pr/S/jSxLM6EH6l8zwuBcf
    q83S7lpsSt7w09k341+exVGNDRM6vhXNpESnRdxFh0EMAbLNhxJo9n2bVo7kYkZkcm3X7X
    PQG7saE3OEjyQOhbu6iWC/n7V8kLi0/K2xCOWzy2v8e10bzlZUcx5D4XPaIqhKJxvPs3d6
    FyPFIOqiNHuiYENEPr+H+qBM+Apm2qFu6HKOW2LOGhCwsUFegpqm5JS7QUusT/VYGg7oUN
    JKF1kuOyrehEpntNT1QHBPeVgiax6Ct0eE/6fNVmTux35KMH7pyx6t9bJieKOjFjh1dUZp
    qxm/AwbByYhhT0RbJGMrlzqhmOUQuKGtjSHIwb1ChOmN2EwUqupxusKOeT55+F8wCXrhk7
    irewWT+T0hDIyliHh3m8C+x9IJl5eumQu36pEWiTyjOTzIzwysJI1IygaiaOviPFPiHchs
    J5EBJ3yTKOnZ6nXNbawFN5JT1LZTDXN8DFkucTVYLqqZJusW2ke4RizNwdpekxhF01zrzA
    g56Oj/Bag8oGWI0W5xNXp0IoOJo2BIWW32BRe60E81o0fPS3qthgUdQjKsb0vXrBXtypPc
    jFRTdJtui0H7rt21lzCl/W7KyMMmIR1K5NDGU+CCpSzn4cLwa2iltQ84rhGA
X-ME-Proxy: <xmx:VxpFai921iyUG_sAK0s_8QqCahnA0K9I_6JIL9qcpjd7iIqwL9rp-A>
    <xmx:VxpFaqXnrO61HngzBzdubCTdbRMbj9shHWyDti7X8FIcLwXJk5Verg>
    <xmx:VxpFalraQSgU4dtZ7oo9CF8LOAQOS1VewWGoghgo-aQRnpvHq3zjig>
    <xmx:VxpFakmSuziQtrTm4aGXZq3V_xgn8yO62XUHNWUdAcanFpt3r7woyQ>
    <xmx:WBpFamFEyya792wAWJ-XnIivPiQC5bvMCHUpnPWjpbiq5lJzSmNyKZPg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 09:47:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  phillip.wood@dunelm.org.uk,
  Patrick Steinhardt <ps@pks.im>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
In-Reply-To: <f15456d2-d8b2-4edc-80b4-3a9d8fc77da9@gmail.com> (Phillip Wood's
	message of "Wed, 1 Jul 2026 11:31:23 +0100")
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
	<akIQLM6xZTHBudWT@pks.im>
	<3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
	<CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
	<dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
	<CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
	<4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
	<CAHwyqnXoqZYHodWXHtwnk0_PiZcCYSVL+WgL3h5nWiYx_cSZLw@mail.gmail.com>
	<f15456d2-d8b2-4edc-80b4-3a9d8fc77da9@gmail.com>
Date: Wed, 01 Jul 2026 06:47:02 -0700
Message-ID: <xmqq8q7urfe1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> The reason we're introducing the history command is to experiment with 
> providing a better user interface for rewriting history without being 
> bound by the limitations of "git rebase". So I think it would entirely 
> appropriate to try a different format for the squash message here. If it 
> turns out to be a success then we can see if we want to use it in "git 
> rebase" as well.

Do we know concretely things that are bad in the current way "rebase
-i" works, so that we can experiment deviation from?  If not, the
above is going backwards, I'm afraind.

Thanks
