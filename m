Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC81DC198
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642298; cv=none; b=Pc/XUq0v+OtcIuehCjo1M+cavCfw70BnjcCNS1C8jiKyY8IvleYRhwn2FTANGsMc1AYGixz8UxKdczwyAFIbbNqMVkgT18FzqxQE9GTWnZhINd0rHOH65o8Lg6LSDTSwSLfQ3Ak/qTHMsWqEqWB5IX/o6cthmtq75X4Twn0mdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642298; c=relaxed/simple;
	bh=BW04M+aS5WxF2DiEMudmoGEoYxhxKqsVMsk6QgNGllU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HL5Mlx7B26A26sneoVdpOd1jKUhhXKs91mvPMwQg2ECyuLMePBJXu0pdAeIc285LOw0d27eKUFGfFO6oC/251Niy/YMj2YKfKrDnP6HVhIhXbt93CYy1t/e+a60LdkjUSv80fu821v59q1yKLGCWFW9xHo72tRKEV6Zo9u2stAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cuyifslh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDu4nPYr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cuyifslh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDu4nPYr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61DC71400220;
	Fri,  4 Jul 2025 11:18:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 04 Jul 2025 11:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751642294;
	 x=1751728694; bh=BW04M+aS5WxF2DiEMudmoGEoYxhxKqsVMsk6QgNGllU=; b=
	cuyifslh2QxlXKcq1ISWp5nSgGwKUeoCgazQA5iTYrgHSsBFR9hX7jsOZ2YH698J
	4ZZ1QXJhH1MH+zGNtiqvDz2McqVFCh42HpbDjciQlKVhoSK5LLyhp23j8EEHhqsJ
	8J5HyRNOyk0OczRSFONZudTNVeGKHr2OvBPNLctuW5zagQC28qm/aETr01p/vcsw
	bm9RQqNC0cIbHjqfe89k5p40MDPeTGL7SPz6r0yJl1P1TuL6CVGWGMq2Stm9lq+E
	Uz3sev9jJOKNDWHd6cWQTKuTo14bmxq2yvo5B/cc3mwW55/64YHwzJ9jvpVO+ux5
	PeqZXbXp7lhU/IUM06P3PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751642294; x=
	1751728694; bh=BW04M+aS5WxF2DiEMudmoGEoYxhxKqsVMsk6QgNGllU=; b=g
	Du4nPYrRr2oa+ps26b3MohXnPsHaT4oaxlwgjr/M8kbgxA0vybI2UST4V0baMDvf
	AfnNyf/E0kYRkK4xo2pTw/yJSqftNIGpBmfhuDM2tUpk61bdULlIUI5KT/VPD/bi
	NrOTOIJrcbCJOzw5NM4cjZWIKyoDn+QPC4Hep14IQr8Wn3e2pBlY3Kj/O0E3/Wey
	yR81Z0R+yjN5Llv+pNqDULe5RERhT3sDW2DOV1gLdnEmQPo977QjF62Ip6Zo1XTK
	BNg1P0bPiY8Iwfj9D9EEicU+3PJW+5YZFGDnhovMyNMTYzG3W7P80mD0DgqCvcXf
	uUDUcfZGg6A3cnSaoGP4g==
X-ME-Sender: <xms:tvBnaBLhtOvZmwsEG-tXGuemgwevLGQbFI6n-pA_lcRhqlvM6Ri692Q>
    <xme:tvBnaNIcyD4p4dHb9OZ6CMw6ironK_iJa8OZvrGC_LHMMrCYfGWCEOFBXSejRQVFq
    tc8_3hN55RBkqJcSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsghorhhishestghouggvshihnhhthhgvshhi
    shdrtghomhdprhgtphhtthhopehkrghrvghnsegtohguvghshihnthhhvghsihhsrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tvBnaJtJESpIvPg4yeq1uC3uPa2iDTlFvXVnmkRwwVggqTVBVeR7Hw>
    <xmx:tvBnaCYFRfsLM_nDU1n61Y6Ck1YMsJmwacKEwCUG9J7WxJB3-Cn_Qg>
    <xmx:tvBnaIYZT-4oDTnXvsBIU3E9tz5M9jXDXcy8CmzcaROFUnl9Jw8DUQ>
    <xmx:tvBnaGDeCsVzDKrCO2GaxXG2d6nCSKR87p82na6Z4fOl8I7p1ZbEhQ>
    <xmx:tvBnaOx94Rq-dcb65zsZj4GR-q5jrmN61eahP2BLG4ha4NmmXYCCNgS9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1DC171EA0065; Fri,  4 Jul 2025 11:18:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Td4c5bef4314aafce
Date: Fri, 04 Jul 2025 17:17:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Boris Kolpackov" <boris@codesynthesis.com>, git@vger.kernel.org
Cc: karen@codesynthesis.com
Message-Id: <ecb6df31-1f3a-4373-91ed-ae5231af7f7e@app.fastmail.com>
In-Reply-To: <c20e2e7b-8471-4398-9bfb-6534f8ad2b39@app.fastmail.com>
References: <boris.20250703161436@codesynthesis.com>
 <c20e2e7b-8471-4398-9bfb-6534f8ad2b39@app.fastmail.com>
Subject: Re: Document ability to disable template directory in git-init
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 4, 2025, at 16:57, Kristoffer Haugsbakk wrote:
> You can apparently pass `--no-templates`
>
> ```
> git init --template=$HOME/git-template --no-templates
> ```

Typo:

```
git init --template=$HOME/git-template --no-template
````
