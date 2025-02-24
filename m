Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1525B68E
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413689; cv=none; b=Bm0DsTpYqtFIZSGcMh9CIXaClENRnv7n+Ah01SK+zOAyQh3kYGyNco5BMC3breqrOe6Gjl1yejm2WhKmc0b9pgxmNWCZ2XbKWekGP4ugK8EsS304atQwZOnhpnpxaSEfgIScBqxPud5wfJcmkhelLx7UoRLqpFaAAoyzNAkBeks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413689; c=relaxed/simple;
	bh=4+kTcYo95WZcgo3PiFXD5qIOoVgznnjQVHWxi2VOdms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KhceOCAtOfYvFxKW4Hc0XvxlCAT6+vKxEP5ePw53/scxgc0etK282E879c1yhaqPIu1nrzJRErvf4ea3hBMc6TowOO/wQf8CQnG//DnY1mL5Rj51SdU356R1S5QZBTPk1LF37F7S53Svjgu3Ex8yAcH/oW+5+DWtAvTKdHDaois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tO1PLFJ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2p2zouwB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tO1PLFJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2p2zouwB"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id ADB8A1380A17;
	Mon, 24 Feb 2025 11:14:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 24 Feb 2025 11:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740413685; x=1740500085; bh=FKJjzmZBlA
	uG+n/toTloy2UgQeV8cy/JQiKZv1x6jKU=; b=tO1PLFJ39Zubg9F/b5euPWyuVt
	sOaXF+J4x13UGMBs76Ij/Pat6crhKls+Q+O7V1NLSAQYsQ9g8/ewBH/kEyHr8l7d
	Fwmi7/rKz+AbcE6OGOReWundDUdVqEn2TcWy2MzPJe919eylwUe0BV3+HpNXxaOH
	fwqRj3dLaX4c80z9OHK7YZTF9Gp+Th6N0iP6mcOc43dgT8sI0i4BPx2mL3BxE5HZ
	l+UhvBsxfSwIL2B7i+OtnFIH2ZZ7FEqeDX3dKWvdyu2+SlraN5NNtD3Jo0h6WsAj
	vgsac5sosQsvG5gcS2rjzbdxzgtDnzJbxEyoUEj/6VWmFRh3UjxEmC3xJFhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740413685; x=1740500085; bh=FKJjzmZBlAuG+n/toTloy2UgQeV8cy/JQiK
	Zv1x6jKU=; b=2p2zouwBU4fJ/o5EqvxRKGP7iKkG/oSfyq3eRO5c2WHEB9bu8bl
	8eYY8mx3vlcB8dXb3gxwNyzfrbqYqj0y+Jy2tDm7T/9DO7iPaz1e40FlFgTH7aa6
	tPmY7wzJp/fzPmWDcGN4tlTTd5Y3B1D0FsR39eq/bMw59ZXdwAdF5w9wwClvAf9T
	qzSPuwgL6LE4nixbBDQ5ppiCMCkpLTMEJtrxFxcT1YkioC7Y8Uht91bUa73qsodI
	6dgjc7HI3X/muQ9XyDzJs7hPIu9Xpcltt7TLfak7/7BpXzLIDe7ywNsrWuD/sFox
	vzriDntpW9t/YMz2+V+GQwajO5VqpHblWdw==
X-ME-Sender: <xms:9Zq8Z0rWVksOBivkuptXILm7HxCZjjzxA2Y6Fx51zuQA0us-lePwaQ>
    <xme:9Zq8Z6rVrRhDPkqbLFBie9GZDv7AsO2PMCUTkCAlT0U6LuCJ35KZ-Pps2wOwQtyuf
    RRhitDq8ZMGL6yapQ>
X-ME-Received: <xmr:9Zq8Z5MNEwzwnjYefyA0TOfEK19iP9CS3DAtj_oZt-LE-CtcQE6Ga_hRsQo6jkKjmqcuykzuuNn7UnBUsRBI0pcz-31vvNzWvfOs2fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9Zq8Z75FtoTFbroJwPgRwlbGffzVylLrEhYB_RA4OtHkEIInpKGwmQ>
    <xmx:9Zq8Zz4qsI_wacW9Q7kP3ZAeKi5xTb9LJ2Ep_Njiw4lIDdoC0GqzHQ>
    <xmx:9Zq8Z7hMBKq1sS7TgB-KPQbjfcPpuCltQOSdEhSQ-adJ8OBp4TFTBQ>
    <xmx:9Zq8Z96L__xYZgM-XXqp4xC0jKwQUrL9yus_f3VC2gKOdTrR4kNyEQ>
    <xmx:9Zq8ZwtirlOANNXvzhZLDWkivM7UicGmAkNM-bZWC5SqtyWRKDC7wcoZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 11:14:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
In-Reply-To: <20250222072048.GA3096947@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 22 Feb 2025 02:20:48 -0500")
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
	<20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>
	<20250222072048.GA3096947@coredump.intra.peff.net>
Date: Mon, 24 Feb 2025 08:14:43 -0800
Message-ID: <xmqqr03n7218.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Feb 07, 2025 at 12:03:36PM +0100, Patrick Steinhardt wrote:
>
>>  static timestamp_t rerere_last_used_at(struct rerere_id *id)
>>  {
>> +	struct strbuf buf = STRBUF_INIT;
>>  	struct stat st;
>> +	int ret;
>> +
>> +	ret = stat(rerere_path(&buf, id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
>>  
>> -	return stat(rerere_path(id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
>> +	strbuf_release(&buf);
>> +	return ret;
>>  }
>
> This "int ret" should surely be a timestamp_t, no?
>
> -Peff

Indeeeeeed.  Thanks for a careful reading.
