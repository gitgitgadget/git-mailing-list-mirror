Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FC1A9FBA
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308374; cv=none; b=UEkWSWyCP18wwkSxX5vCxZ5DSaA8hnFpnaT/C8PGfbNRVjUwNc8t42ahy5ILkHDLNesW7sxTOeQLjJ5UGBTyMYJnrMb7Id89ERNfNIf8U/AcO2ybLPd2S3nvCbAhHJcdmCtvnOHWAfXdb3ZpmegE86cntHxev7O/xnXudLJSWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308374; c=relaxed/simple;
	bh=RKOrVNLKS2uQ2uU5/6e74QQvLDLbIs8H9Y61OE2cEuE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PmN3FaRdjrG2xgk976ejQ8t/MrkR+peyToEVm1SuxyQQ+mlufNly7sd6ix9oclD4HTy8OcjRQ7IeSaO+5oWqvUydXoPjKdzBeTzjmkGWXcdAhZJcnO/LFlQEEViVZF5DmTPID8kmCOc7l+aShLfTDCSb/nb7cZAv9kb/Jt/y57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oGCN7o2g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q61tDe+y; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oGCN7o2g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q61tDe+y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 389991400179;
	Thu,  5 Feb 2026 11:19:33 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 11:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770308373;
	 x=1770394773; bh=RKOrVNLKS2uQ2uU5/6e74QQvLDLbIs8H9Y61OE2cEuE=; b=
	oGCN7o2g6I5ZjWYGQMjZh29PgUP+l/pIl8aQgjUxuZHqo+xTRKNLdo25dOqGom8+
	z72XByAgIjZKsCImkTRufvcKFEdgeoblRNcIITQjsPIwy7xNKLwRdVGg/gj+oGF4
	HfPR74CSUy94g3Iz041eTbTVyN3yJivhOuvIzvD6sZQM0ztuXroqpw2gOcJ+UqCF
	vaYMK3jYFLpM0S1315RqFi0Yt9wPBbduShY2/Rz5RHGI7KOgtza3+0Jq1n6N6XHx
	BofJsOv1962nu3bvsLpP3Juc+kysCYFJ8yrc7b6NS6DorNcSjrPSK4xvKfRv3MLb
	8l4uCLdymM+F1xQNVYez2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770308373; x=
	1770394773; bh=RKOrVNLKS2uQ2uU5/6e74QQvLDLbIs8H9Y61OE2cEuE=; b=q
	61tDe+yqpANxhL0HTkJtSwiNm24pl3PVDUIytJl7kjQAyfJclMNkMJwnKEzt6Y4r
	Zq1ao9DKenk1eyiJrbvpnGJBX2qG4xPDZFK9dReMcC0UrmL5/rhRH3IHe533fRyP
	o6S7/hyb/eHXP+uKyg3xtxJKM7CL1fSo2sxEXC26+BfYHAdccc3ZOW4hTWN5QULL
	pO/c5Wlmyasx469Jrc0RwdSQQ8ryYFKYkiaS0jpaAYRe6vDyMrdttVzsdwbntJBw
	Yii8knt7YczWcDNyal4ov9m/8Dmio3tK8gHxLpTKubsvZiBgXA+op0h7B3+tR3SE
	Nfcdszmv7NWwTEcaxfosA==
X-ME-Sender: <xms:FcOEaaSQ-WwMXrsoXaKgQgjigDkWV2NF45z6vAb9NsL1DXBHP3SEvTo>
    <xme:FcOEaanB9Ah_XpE6ICyFGPNpqKYQKprMHCjRK0f9RrcY8Bz2mfktFAFXZtAe4QvEh
    Wt0jdMSb09aqlBANOIqT8R031xvvrEubBmabl-0fyRxKpxIKdyerIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pehmjhgthhgvvghthhgrmhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:FcOEad-H_H9fys3bq2S9Huot64b5-J1UvN0l6aAl5rohbWNV1nw5wA>
    <xmx:FcOEabCjGegJ1mEbq8CWkLihTOLAPQePl4RuM0wCfMmlWWum1TKwog>
    <xmx:FcOEaSShsMiQR3Zjm725vte9JDSaIwDbIJyCYzTKy4uHXTZ-WujRHg>
    <xmx:FcOEaSsTW3jJKGkxVA2ueS258f-3XaPOt-JxAxqho36EobefoJh4qQ>
    <xmx:FcOEabjjz5x_4QGtV508L4D4v6uFK9evotV_bbBr1MiwsL5bUt09gIwu>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0ADE91EA006B; Thu,  5 Feb 2026 11:19:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdGsxB5Ml5Nw
Date: Thu, 05 Feb 2026 17:19:12 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Matthew John Cheetham" <mjcheetham@outlook.com>
Message-Id: <8775e4d7-4793-413d-a0ff-c1d325ed04e5@app.fastmail.com>
In-Reply-To: 
 <a06344dc753698ece37f8d066b0a51931b7fa16f.1770307510.git.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <a06344dc753698ece37f8d066b0a51931b7fa16f.1770307510.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 4/4] trace2: emit cmd_ancestry data for Windows
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 5, 2026, at 17:05, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Since 2f732bf1 (tr2: log parent process name) it is now possible to emit

The usual way to refer to commits is to use `git show -s
--pretty=reference`. (Or maybe with `--abbrev=8` as well
which seems to be the case here.) That also adds the date.
See `SubmittingPatches`.

> a specific process ancestry event in TRACE2. We should emit the Windows
> process ancestry data with the correct event type.
>
> To not break existing consumers of the data_json "windows/ancestry"
> event, we continue to emit the ancestry data as a JSON event.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>[snip]
