Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E51277026
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044156; cv=none; b=mWc73Uo6ebo83xY/AGd81uS7T2BoR6aehF540KvKb54v19kemYFCI9I2YjfjZkhd0FfS2mODmYMbqbstvdZrSpYeUOQHSWwuqf+lKHgGqgV9uKvAgvwzuZ3PfUy+bH05r9Mz/twvyYG4NJ+Lg4ByUm+X2hO/04Zo8XFYAlsxg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044156; c=relaxed/simple;
	bh=YRFMx/SCVUUAG0T234XFm8TrMT2Zy6xwlMKNUXJuNGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U02ou2JZNaZQYl7uuvnQTiYM8pAMa/VLz9Zs/aUFrP/7l6uHjAaWGiRVE5XAyW9my/vXM7aFI/0Lg59VPWqmMP0VjhAnarnjQeXY+Oy1S7iQC5HM33gf3k36Ed9O7j7VSzV1icStr7CiXwQrOAyajVPmbFwxbI2k5UprM3ryTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S1KW93o8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhGQC+Pd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S1KW93o8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhGQC+Pd"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6ADDEEC060C;
	Wed, 25 Feb 2026 13:29:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 25 Feb 2026 13:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772044154; x=1772130554; bh=qnoA05OAy7
	w87KRIbk2y+pX46IqfjRhmvVgKxhtUx1I=; b=S1KW93o8/YCB8p6bo+J3W0kpG1
	lx3VM/bW7sKf9x3tUQPUZw3IbpbDlneAlbe4X1i4AvknM/iLbVqJq3dy6zHA6ewv
	JfU7+6LkwLvXw/4+qOtk9UBy/3BpkUqvpibwUvJF70zbkRj5V3kaQwY7dJiQDClY
	lYNpO71m0ZDyDgmHnpoUSi/xgSo/lWksoOMxQyxx028amlN8V/1mBrl2YSzBxMsO
	2SmKQ8o9vMIJx0M9jB3NW/u0A6MbHDsfrUvcGWiGvmcNj9IiGfnnlVOuOS2/qACD
	LCXKlt1iJB4RQ4a4W1KCtyARcoooQ9m0KwpFTR16BENm2skrnZ6ZhZp0VD1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772044154; x=1772130554; bh=qnoA05OAy7w87KRIbk2y+pX46IqfjRhmvVg
	KxhtUx1I=; b=IhGQC+Pdo7jRBLqHqiOLnWa+S4c+9EmRrsaKPd1s77eDc39+bB1
	7k5RL+zBVlyLLZtNZ+AEf/6EPIZVRo3l0gsLKQnszA1WXoLQ+d4ykd1pw1zRZXgi
	WXfMYynaVJbpi3k8EDqb/2N2rlI3pZusSMH2xbm/YUNMXxtqQosAm151kW+KYaLf
	XdoduHoafIssFVNWg9w0KbaF8Ke474sWnY6keDj9gS+S8ZqcLwYW7ZGUTQToQTIW
	OsgA4S1tPSeOO33tJJFM00mkgFguYCyDKh8kGeobEv25rVP9L35anJ9tIWolPzzK
	0NzAXMloM9GmtUmu6Ndu+4F42MtuFIl3EHw==
X-ME-Sender: <xms:ej-faVtaKoPNVwd1CjLhUBpE4jbY7JEfLbYc29pI0au0l2ih_SbdRw>
    <xme:ej-faV4y7M3WK-zDqdLFZmvwh99UmoAWTD_n8niGxdG9tbrKe4shgHLW5Shrw9mrs
    KyCmDHxrHJT91ahesrLps7fIvrjzX53Bu0j_qG0H3d0aHqP-_xGmA>
X-ME-Received: <xmr:ej-faWLu9wn8kgEFMJPd5y20TMIwPf9xbFd-dKf6-H3LuGbOqqE7-WOoiIkqQuZ17dyhB4uqPg6-FcAlo-1RiQWBZ6AwHiIdVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhigsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ej-faV4P36XkLQwvVMbv79aBy2GBQaRKwc-WcU3i0q1kCi4QlATRbQ>
    <xmx:ej-faZx60SBUur1lZj0ByreQe73bVxm5VcBTUMayPe72BzbisCA7VA>
    <xmx:ej-faZbduoc3ABhDIJv5tuUY_XnXDw0NYAE1fWFmeM1VuBw2AW61jg>
    <xmx:ej-fabQmwHVuYlnXP0N4cQmDW5KxLgtQHZWzVvepfbwy8bM9fj-foQ>
    <xmx:ej-faZxcvyidbiRj4_LGkJbzdiK3EPAcrdZVaixfningCNC_9K3TYrid>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 13:29:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
In-Reply-To: <aZ81X6ERyx5fcm6L@devuan> (Alejandro Colomar's message of "Wed,
	25 Feb 2026 18:55:26 +0100")
References: <aZ81X6ERyx5fcm6L@devuan>
Date: Wed, 25 Feb 2026 10:29:12 -0800
Message-ID: <xmqq4in4brt3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alejandro Colomar <alx@kernel.org> writes:

> Would you mind changing %d to be affected by --decorate=?

I would imagine everybody would strongly mind as the scripts they
have already written and have been using for years will be broken by
such a change.  So changing how %d works is a non-starter.

But that does not mean we cannot add a different placeholder that
behaves that way.  I wonder if it is the cleanest to extend the
%(decoreate:<option>,...) notation, perhaps like

    $ git log --format="%(decorate:optional=yes)"

with and without --decorate/--no-decorate may be a way forward?

