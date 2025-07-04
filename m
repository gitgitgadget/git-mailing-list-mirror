Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857B241676
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665195; cv=none; b=CN+rDP1rVB/veQdXNupWoBjBwHpFtkbpkfEE/YbAfvg0tiff9nTVUtMcHwQDY4rS6oecAREEEgix8+GAJUsNfWkwahLrCYtVGvUriN05N0UDo1fi0HbkVkz8mKsM3/MlGAE1Iep8OxYc7X0ABhs/pmAdxKXSklDeRijFOn/f9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665195; c=relaxed/simple;
	bh=uy016a6qbe1WGyMYWsz83sUUIFKerin1PX5bHq97FB8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H5RQH7JKasCrTebE4AoCl4w4byxKyZXjjg760KLdi+jB9o/56ZgCK2QTgGAXPrJeS5+4+AJtOOuGt3xZcJRJo8Dd0fpLblGAy/F/Bn179DrFuNuW8eYiuJ8dHsQbRRc3NiMNywI5eKyABH0Fkhde+5kkXGAbol8X552U89g6cRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=J2/nYmK+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/phGH84; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="J2/nYmK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/phGH84"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4686EEC0BAA;
	Fri,  4 Jul 2025 17:39:52 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 04 Jul 2025 17:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751665192;
	 x=1751751592; bh=uy016a6qbe1WGyMYWsz83sUUIFKerin1PX5bHq97FB8=; b=
	J2/nYmK+Uev4kG2WgPXShGy09gJkzZ0UBJF53rBrYkmYTC0bhy5AtpnD/vk5xW0k
	QE6E7SzYsPRz59ODdXxs7NIwcsYQByDFPNVcMtXk6pHuMHEPXdOmo3NSOA29Bxye
	Ysx8MXRcH2khsoIPOGQvMcX3NRnDlIPm28DOvuUSzZbJjg9S8vKYTidK4KM89H+f
	jICO3hBRSt4Zkaffecaj/hAo7c50++EXN73Ry4jpWRrYHDqKf+GE5HPSPz/56AFD
	qFzKHdJXfmqKeySvhe83Qfqr+K3yomh0UtCKLvSqUj8TxAu+2Su97shF+6uSEhPk
	hXHBDKPUFy54mwXK2mNaGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751665192; x=
	1751751592; bh=uy016a6qbe1WGyMYWsz83sUUIFKerin1PX5bHq97FB8=; b=h
	/phGH84ymnnEPbjvVvZ5QaPTq4C8xYfjNjyZt5i0hpu2/nmp7A64vEYztG5RUn2X
	S6DL2k4MqFcbYzEGT+4Rn5C2CLPgl8AFyw850zd3XPQIuXhRwRyV8W94NvuvNVR1
	ldqdMcS7Nwl4pvmnQkm8/PeL8484VZ/+9xnwH9YAEUe5j6cX62GyCbA0GJ3HHf1D
	uQKaVNTfbpO12quWsiXvfggBnbLzf88dNGfTj99irUqiOEvibeBgyHL/9GDH9ueY
	dPkmrVPHALi35IOofpX3cizUKxccv+R5NuiGpIaUSr+O3uMgpnfJrs1C5F2Tx7CB
	+hLtfq4+N+z25JmtY2Gug==
X-ME-Sender: <xms:KEpoaNYi_nJc2Pgz1HnVgYy3DxAgeL5JydV51Ya-nniui4FnPKu_j6I>
    <xme:KEpoaEY1v0Lbw4y5_XAFhaTfpWj4Ar5Dh8dhhWR1Tbk60PQ_bJNhv7aMyWYk5-kBO
    C8XQUwuXDjNU2nUhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KEpoaP_qLv0sEpQAjSEeUSlmkcrLbf5-hMdbRybd-WTn5cILVh-dmg>
    <xmx:KEpoaLqUEv4KXND3JzdxWkWVP24BKbup-ODf3wWUmMq5MUZIFiE_aw>
    <xmx:KEpoaIozRIOQMMMe35IBY_W29_3o-Z0kwriveQl1zD9V1FUPew-zQA>
    <xmx:KEpoaBSKdtpZa6cqu1wHffDQA8ybl-nNGqaphVI-fpkdutDy91ofWQ>
    <xmx:KEpoaKKKNQuyk9qFmXkuLpCpy1OQHEVAXHLLTbFfOzzH_PPjcteMzBQn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 08A9C1EA0066; Fri,  4 Jul 2025 17:39:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6a27cb3eb86664ec
Date: Fri, 04 Jul 2025 23:39:31 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <bbaabac0-7832-40f3-b661-e9681cfdfa82@app.fastmail.com>
In-Reply-To: <bc18712a-8f72-4827-b47f-afac69ea6fa0@app.fastmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 <d54e297567ac8f3009daa8fdf3de158338b2b700.1749373787.git.gitgitgadget@gmail.com>
 <bc18712a-8f72-4827-b47f-afac69ea6fa0@app.fastmail.com>
Subject: Re: [PATCH 7/9] doc: git-log: convert pretty formats to new doc format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025, at 22:43, Kristoffer Haugsbakk wrote:
> Has using `=E2=90=A3` to denote SP in verbatim code blocks been consid=
ered
> by anyone?

Bad example to associate with ` -> ` (=E2=90=A3->=E2=90=A3). But it coul=
d work for some
things like `:=E2=90=A3` in git-interpret-trailers(1).
