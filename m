Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDD8F40
	for <git@vger.kernel.org>; Fri, 30 May 2025 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748642124; cv=none; b=rB9g6HB8l3aY++hOXVV7V/b7oPqo+6RWDiYyu4bH3V0diDpWDKqbI791Cg7Wj6LurK1vjvxL7RXltpGAVcpET2vj9FSTLTUvX5rSc4iEPW68Oa7jFHa0ECxaVsqnElYO5/eZD9hW6eRAMpowyUxHjGdeM8kh4z32zBebWn+U8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748642124; c=relaxed/simple;
	bh=Us4Y2RIpOELuH5U+SdRTB4li2KK/UoaOKq/uH6xVqEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SirmfS7qW5aIeCIkEAnm6PrTlAdHE+HXBor4zDR+qiD5kv4pdC1hlF7GjWGdbujyxzfJPKZ+rW+Zxhso7yXSOhoRAwJ7LmpqAFUE+fugp2InOZ/Sa//sdbvDvR+hC6YXT4qMGz58SNW2SPKFU6/CiO4I6RikX9kKDHABESVpRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b4uYHv4q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P3ll9MRx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b4uYHv4q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P3ll9MRx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B1DDF13802B4;
	Fri, 30 May 2025 17:55:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 30 May 2025 17:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748642121; x=1748728521; bh=Q/hqYz6G4g
	ixy4oB35hhF6xFBEU+eXddaHgwMzaYz3g=; b=b4uYHv4qCUDdR5da9lfTtGGzNm
	hXBkZVE2kDTDVYjfAsdn5tT+gBxkwQw+ztPydqq2SSE9mWSNWzEf7+n4/E00p/50
	YPQ/MMpr8691X+9SK2HHX5rxoBkgPxi09JtENWcs9hRJeKQMJJUTPkh7Qs6QIv4U
	gOiyPO70rbpO00tiwNePq64gClocQITdG473M4j22VFQYcieJbyM+NGm5uvbHldy
	jg99x7+Clr2kgvJiatorVz0eDFqvvoOFDhnj5n5aB6zPM0BzfMiMAiSjhlzL6YJE
	VbxvDuiR73UXGCiFEnt8g6GkTwtOCZRzJVHUpjitUU3SEF1D2/z6wj4OyXhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748642121; x=1748728521; bh=Q/hqYz6G4gixy4oB35hhF6xFBEU+eXddaHg
	wMzaYz3g=; b=P3ll9MRxGQHfK7ms9NyQLoPnGBA0EpE1LBwD3kbJjeUydV60c41
	Eeyw6S56t9LACxIB7xD4nsM6aNnHQBQgRs9jvddRlWDq9sTEMxVJq7Q1DMY576XX
	Af1sEbsW2Gt7+KFLk0uiDvfZDpAiskacKADyacqq3xQiYj4R18b1ADUziIGBJC+Z
	tI40/GkLyWzNp+9zVLtNB9kC0p0JJT3fDzehZKGR29bMLVMN/YYDk3lBVF9bNiGc
	UAQSQtJTS2NH2GjmL6mYogKuhWmZBXlz3u8ZzvvjxVhgWUpgONku1M7GvZvXGizH
	RszxorgexSNZ4YeBqZZHKMUEc14YHPrHqNQ==
X-ME-Sender: <xms:SSk6aIBqsuFPIOF2-cp6veGrxrjvP_-O7w1b22PW66Ry1uZyYeH_bA>
    <xme:SSk6aKh0nNqQj8FzNjzcELNmBzkEgQDEbUrFOTBYRasC17Mq9LQj1atTbmoRyROQ1
    0prrdKos3e1S9gppQ>
X-ME-Received: <xmr:SSk6aLnzrNedKRjpobF9Ab-XMfGcCpivwJdSBhA0OiZJmYIEK43zXUmnuecPAT_5q65CoefSrzWuwx7HaKlylQMFjwiJj2T6thsV0es>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeftddugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlihgrnhesshifrg
    hgvghmrghkvghrshdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepiihihigrohesughishhrohhothdrohhrghdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SSk6aOxnC5lDepjgLweU-R8sic8RO79L8WaBnUSVK_KUUiauDYSM0w>
    <xmx:SSk6aNQLDRtcESaCYa_RzTvbN0QTjprBPXpF_2xKDNW9azWmK_p0Lg>
    <xmx:SSk6aJYdhX1ycHgyv2nlKy8ZCptElAUjNU8zZCJWsQjz5kB-5xlESw>
    <xmx:SSk6aGTuJ9cffCh0nky08Zp1ZhibDISVD99EU62w7UJ-UqGrFFMNsA>
    <xmx:SSk6aKVQWkUS_K4wakjF5rJycJExG4Ss5msdo-q2kSfw_rOpWi19xknZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 17:55:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
In-Reply-To: <PN3PR01MB95974BABA153882DE494D06EB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 30 May 2025 22:49:21 +0530")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250528070521.17379-1-gargaditya08@live.com>
	<20250528070521.17379-3-gargaditya08@live.com>
	<xmqqa56vl1uq.fsf@gitster.g>
	<PN3PR01MB9597008B30AB91C9539E7C8CB866A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<877c1yb53w.fsf@gitster.g>
	<PN3PR01MB9597DEE8C41CB1599B9A97CEB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqbjraf29c.fsf@gitster.g>
	<PN3PR01MB95974BABA153882DE494D06EB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 30 May 2025 14:55:19 -0700
Message-ID: <xmqq5xhhepbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Thats definitely much better. Although, not really in the scope
> of this patch series ;)

I agree.  As you decided not to touch this part with your series, it
is perfectly fine to leave it as-is.  Your series is not making this
part any worse that way.
