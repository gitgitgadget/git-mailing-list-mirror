Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720826CE11
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837311; cv=none; b=uEi5dNEyGiILD89Eep7kC8f96SS0fwFWTldU16cLnIKry/PfMlmYS8zbRoIU5JPxcfCuqCzOydJ8tzdIesSHXTctMf82Cc168eRFuyVc1V2LxVlCgVDKQ9TUU2cBZC6Fn1v00jJmjL1jvUBMi3rII31NaHNdNA/9VvzDpmV+Hm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837311; c=relaxed/simple;
	bh=ppweYZ2lBldUrKHKyg0apiCSz7J6CvUzrBDxC8KM/+A=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qTosEvtDOw22zKNO0v0lZpJJf5UfXjQaoRBRodMsAhBvpq3LFl4DsY+W9LwtCdSUuj65qSQ4S7JVvaxtPGsGiT0txPbR4B2keZbTlK/WfqCYXyUmabdHV18tUpdqsZGTUvEXfvWaA4KisZ7XzifIsB18R1oqcTOhMIdm439HQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=D6a+XNm+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLbAqTCY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="D6a+XNm+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLbAqTCY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A268140008D;
	Thu, 25 Sep 2025 17:55:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 17:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758837309;
	 x=1758923709; bh=qDP2xMmlV44eyrXxyTsrsb9kVo27h2WLbjK+GXUXATE=; b=
	D6a+XNm+fuqnJnN3JWr4+S/nRH++FLJGZwN2Cpwhe6ddyFB2STg39Pb9W0bbkK0L
	bkTvoo+UM29FxLv57TQCFV7f+jN4BqEcgRiltV03E7vUjdXF+hvLjmqA5MV/5Lyt
	PWjoweT7uZAQEAmPKwxkC4QUx6gis3suCQluuiSIuwMWsgsqfrGKNRR+hoAWzfaP
	k85XJsG3d3HZSEbIpO/M+0MVcI2+OjC4UVOUlP7oDkWfeE6/myUR4SCDdebTKlJD
	Di3ELSNTkJruW7OGkRYQucgwSLwpUFmIoI+qfqmYuMVS/68QT5zUn9Sm3apQ/niF
	GPQiNezDi0djrMFLcA7fbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758837309; x=1758923709; bh=q
	DP2xMmlV44eyrXxyTsrsb9kVo27h2WLbjK+GXUXATE=; b=MLbAqTCYVEUhK3dLQ
	7b31YYqWBcIRVNttFmb9gdXQF7YYt10lFnUsqn4o7ZG4cTYoOAsOD3+CkIDHgpNE
	esWvAlNSBLASyhdxt0UX8AUCrWZKs7/FfC/ueqv26qNq5svyPxUd9t36Imr8ome5
	ol1WRA55HwfeKiIGERwqXU47cYQdjT/r41JOmMhsE0n6bB4j78z1KvAfrAEOMpL9
	1Jmgyu6+cAAMlILMALIXT5ZVR7iCywxtZikzVwqfLdp07DE+igYkTzGxa3g3wnb/
	WBKFJMJ+LnKu692YzFUsenXTCf+GKG7A3bYNqoQRPZ2jzBdjANEtJdXkmXRawXqY
	f500w==
X-ME-Sender: <xms:PLrVaKVB7H5ChDuaIRnYIzeZj2AqVLwKBDf_V6C3JUZ3zog8XctueQU>
    <xme:PLrVaBYFPcMHFLVDxfkVs-MYMGsE4K7B_wQQZzEhIzlR8whwVsCKvXrC9LxrsnVpy
    cpoTT6eNf0zpf8Lm6tKDWcPzYSJsv-88CQX9Asg5esE416yMikG4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehptgguhhhosggsshesvghlvggtthhrohhophht
    ihgtrghlrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PLrVaBBcjqyRB-9Kk86-ZQxL2nB772D_fSMD7ubRZ8_ibk2VQhSpqA>
    <xmx:PLrVaNfb7UUNXP4vj1eMZ-ZooNOawSmCy7xLwdBiV4tXEt9Yoo6tEQ>
    <xmx:PLrVaEJCxH9dLe_RLjzReBlyFWpeR4hc6bPyslvEgzkqgPl7QN-UGg>
    <xmx:PLrVaIdth6h9BX9HVFoEAe75G81sPrM4NTA2QBIJk-Kljr6Wu0OVew>
    <xmx:PbrVaJKuBAHtGStgviFacVyuClajM2Cj_xU9zWXnQVQGEYbhNxkzy0ym>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE2E41EA006B; Thu, 25 Sep 2025 17:55:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqZGWnjFrCK-
Date: Thu, 25 Sep 2025 23:54:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phil Hobbs" <pcdhobbs@electrooptical.net>, git@vger.kernel.org
Message-Id: <1c5581eb-ad69-4a18-b798-c54344a4208a@app.fastmail.com>
In-Reply-To: <67a6ec3a-a718-438f-ac4c-ff989f316a9b@electrooptical.net>
References: <67a6ec3a-a718-438f-ac4c-ff989f316a9b@electrooptical.net>
Subject: Re: whatchanged is super useful!
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025, at 23:44, Phil Hobbs wrote:
> I use git whatchanged all the time.  Please don't remove it!

It might be useful but everything it can do, git-log(1) can also do.

You can replace it with `git log` like so:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Or you can replace `--raw` with more modern alternatives like
`--name-only` or `--stat`.
